Return-Path: <SRS0=3gpS=RA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00FF2C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 22:01:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B641B2146F
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 22:01:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551132087;
	bh=yq9ZKnTL8huK2F8NsUXQJdDCIZvShsdSHHAawX7y9fo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=TT1PZxRGeglSuAAfvBgd0e+8LAZYFV7pfBpBtI46kiv0T4Gikp+EUoNgstOy64VXT
	 AlXtLHvvgVmlrYMtR8qM69wsvjrJ3xsPJCWoG0Mc34gon6TrroM4h/UHyg2Ia/1OdP
	 a5zxzxG8iD2zNXdGayQUsu0rwIfc3aNibngmPSEA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729845AbfBYWB0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Feb 2019 17:01:26 -0500
Received: from mail.kernel.org ([198.145.29.99]:48730 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729360AbfBYVQw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Feb 2019 16:16:52 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B98D12147C;
        Mon, 25 Feb 2019 21:16:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551129411;
        bh=yq9ZKnTL8huK2F8NsUXQJdDCIZvShsdSHHAawX7y9fo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MWsjxAxCM4bGlmCGjYOogol+3lZNW0mARIvjCUPA2FnJWmLuJ9u5Le5WH2rvzhsjX
         BmH9aow6JU7KgCrO6/gwVA+xcXr3rQ+RvvUyCTLj5k9ruADSI6ITqJ5qXNUbU12jr5
         PfvF61ycEGQMtyifXffBNXFW/U9mdG7c2mzFg26g=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, YueHaibing <yuehaibing@huawei.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 22/71] xen/pvcalls: remove set but not used variable intf
Date:   Mon, 25 Feb 2019 22:11:24 +0100
Message-Id: <20190225195036.176852642@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190225195034.555044862@linuxfoundation.org>
References: <20190225195034.555044862@linuxfoundation.org>
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

[ Upstream commit 1f8ce09b36c41a026a37a24b20efa32000892a64 ]

Fixes gcc '-Wunused-but-set-variable' warning:

drivers/xen/pvcalls-back.c: In function 'pvcalls_sk_state_change':
drivers/xen/pvcalls-back.c:286:28: warning:
 variable 'intf' set but not used [-Wunused-but-set-variable]

It not used since e6587cdbd732 ("pvcalls-back: set -ENOTCONN in
pvcalls_conn_back_read")

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
Reviewed-by: Boris Ostrovsky <boris.ostrovsky@oracle.com>
Signed-off-by: Boris Ostrovsky <boris.ostrovsky@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/xen/pvcalls-back.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/xen/pvcalls-back.c b/drivers/xen/pvcalls-back.c
index 7185ebb63bd53..abd6dbc29ac28 100644
--- a/drivers/xen/pvcalls-back.c
+++ b/drivers/xen/pvcalls-back.c
@@ -291,12 +291,10 @@ static int pvcalls_back_socket(struct xenbus_device *dev,
 static void pvcalls_sk_state_change(struct sock *sock)
 {
 	struct sock_mapping *map = sock->sk_user_data;
-	struct pvcalls_data_intf *intf;
 
 	if (map == NULL)
 		return;
 
-	intf = map->ring;
 	atomic_inc(&map->read);
 	notify_remote_via_irq(map->irq);
 }
-- 
2.19.1



