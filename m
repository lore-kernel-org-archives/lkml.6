Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A272DC282C2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 18:53:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 767CA20835
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 18:53:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550084039;
	bh=crtgnfRpBFbiAipflRkUYqs+gdBZ5TSGEOV22qXXIpQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=RKCSHk/woy2HMl33IR3c/wl5eANR4As75+LXBCO0fv/7fVIxg6SPJhNqr5ZwaTdhu
	 GthGP+2+CVIPG17rfgRgdn9RJuNwxQdpyCNMS6sNCQfI2PlC0P+S7R5x2lExmHckFY
	 PKj/8ZqSgbm3vPJ+Q7GP3da8ku1EsBrZMCPFJh4Y=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405608AbfBMSmP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 13:42:15 -0500
Received: from mail.kernel.org ([198.145.29.99]:40670 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2405585AbfBMSmJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 13:42:09 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D9F4820811;
        Wed, 13 Feb 2019 18:42:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550083328;
        bh=crtgnfRpBFbiAipflRkUYqs+gdBZ5TSGEOV22qXXIpQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nPaLhBl82HI3sgLzDtrNNDdNdhJxyKsWEhTyOPxetUxsFhKh47Ys+ebXYM+qVKJlQ
         /KZfVTUURLdAWsbLiHQrJ9oPEMvyBJeb+73NfSKqxSW5cLA0d882N/2+reSATEZA6P
         ueaJxh9OqTY4bT7VyOeTUPn8HRqBhn5ObTir2jp8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        james.r.harris@intel.com, Ahsan Atta <ahsan.atta@intel.com>,
        Xiubo Li <xiubli@redhat.com>,
        Tommi Rantala <tommi.t.rantala@nokia.com>
Subject: [PATCH 4.14 35/35] Revert "uio: use request_threaded_irq instead"
Date:   Wed, 13 Feb 2019 19:38:30 +0100
Message-Id: <20190213183707.599505725@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190213183706.176685027@linuxfoundation.org>
References: <20190213183706.176685027@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Xiubo Li <xiubli@redhat.com>

commit 3d27c4de8d4fb2d4099ff324671792aa2578c6f9 upstream.

Since mutex lock in irq hanler is useless currently, here will
remove it together with it.

This reverts commit 9421e45f5ff3d558cf8b75a8cc0824530caf3453.

Reported-by: james.r.harris@intel.com
CC: Ahsan Atta <ahsan.atta@intel.com>
Signed-off-by: Xiubo Li <xiubli@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Tommi Rantala <tommi.t.rantala@nokia.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/uio/uio.c |    8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

--- a/drivers/uio/uio.c
+++ b/drivers/uio/uio.c
@@ -445,13 +445,10 @@ static irqreturn_t uio_interrupt(int irq
 	struct uio_device *idev = (struct uio_device *)dev_id;
 	irqreturn_t ret;
 
-	mutex_lock(&idev->info_lock);
-
 	ret = idev->info->handler(irq, idev->info);
 	if (ret == IRQ_HANDLED)
 		uio_event_notify(idev->info);
 
-	mutex_unlock(&idev->info_lock);
 	return ret;
 }
 
@@ -974,9 +971,8 @@ int __uio_register_device(struct module
 		 * FDs at the time of unregister and therefore may not be
 		 * freed until they are released.
 		 */
-		ret = request_threaded_irq(info->irq, NULL, uio_interrupt,
-					   info->irq_flags, info->name, idev);
-
+		ret = request_irq(info->irq, uio_interrupt,
+				  info->irq_flags, info->name, idev);
 		if (ret) {
 			info->uio_dev = NULL;
 			goto err_request_irq;


