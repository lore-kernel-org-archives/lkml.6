Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62718C07E85
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 16:09:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 22A8820879
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 16:09:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544544582;
	bh=rmtCfWbcMjxtcFsrEGXJbYOwz0NWiR7ikuk9wXu5XYQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=gciRAIaf414jaGUVZbMLidyvHbmfffW0tKGoVIebEj8XVu6SJmboEN2mDCWm1L5ZQ
	 CKxk4DcxBromMEkT2x+oEmFFM/PqAvLl3wufu5WOdUq/3INmCeDYDkxpp2ulhp6R3o
	 FaFmQ8xyW0K/5nJyMF2iol/yuz39QutGc62klfpA=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 22A8820879
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730057AbeLKQJk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 11:09:40 -0500
Received: from mail.kernel.org ([198.145.29.99]:40902 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729661AbeLKPwL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 10:52:11 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 55E382145D;
        Tue, 11 Dec 2018 15:52:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544543530;
        bh=rmtCfWbcMjxtcFsrEGXJbYOwz0NWiR7ikuk9wXu5XYQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=zctPXseb3snOcQ3h6uo2NfvR0nLtDVzpLNJ52APv15RFxa4FX14aWv+EQT+5UvJG0
         Q9cNAvxrROQ6bmCGlHI9MDcPB3epnL2917jYSEi7/FL+PQMonYSOoVzGsu1mWefxGN
         nD8XojuxQBCS+BsL4HnOFjyVi4NUIe0EQ1sGTuhk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Alexander Theissen <alex.theissen@me.com>
Subject: [PATCH 4.14 32/67] usb: appledisplay: Add 27" Apple Cinema Display
Date:   Tue, 11 Dec 2018 16:41:32 +0100
Message-Id: <20181211151632.019215399@linuxfoundation.org>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20181211151630.378216233@linuxfoundation.org>
References: <20181211151630.378216233@linuxfoundation.org>
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

From: Alexander Theissen <alex.theissen@me.com>

commit d7859905301880ad3e16272399d26900af3ac496 upstream.

Add another Apple Cinema Display to the list of supported displays.

Signed-off-by: Alexander Theissen <alex.theissen@me.com>
Cc: stable <stable@vger.kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/usb/misc/appledisplay.c |    1 +
 1 file changed, 1 insertion(+)

--- a/drivers/usb/misc/appledisplay.c
+++ b/drivers/usb/misc/appledisplay.c
@@ -64,6 +64,7 @@ static const struct usb_device_id appled
 	{ APPLEDISPLAY_DEVICE(0x921c) },
 	{ APPLEDISPLAY_DEVICE(0x921d) },
 	{ APPLEDISPLAY_DEVICE(0x9222) },
+	{ APPLEDISPLAY_DEVICE(0x9226) },
 	{ APPLEDISPLAY_DEVICE(0x9236) },
 
 	/* Terminating entry */


