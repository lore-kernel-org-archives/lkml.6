Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79D7FC5CFFE
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 16:22:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4004C2084E
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 16:22:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544545362;
	bh=icF6CUCOske7KoZoPP82syN8nQDdd1YQk0qOcIu2r5U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=emEgOKDcziR2XQBYMZRTHwuNGY1cZzQmbg26CnMHY82KRpeX9uCX99/aDpcqQlI0c
	 zs88c1qz5G7U3na+FYXMfx6Yp3t2Y350DK6ZobgGipZCiYo1u02mRkbBsrELn1AeZ6
	 J1G7y1zwa0+zwZf9QR8VFRZNHm8qwWXxXa3599y0=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4004C2084E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728007AbeLKQWl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 11:22:41 -0500
Received: from mail.kernel.org ([198.145.29.99]:60530 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727686AbeLKPn6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 10:43:58 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DEACC20870;
        Tue, 11 Dec 2018 15:43:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544543038;
        bh=icF6CUCOske7KoZoPP82syN8nQDdd1YQk0qOcIu2r5U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kgt/J2C07EJ/Raqwwrgmjt3VBjzZ4Wkcqgi5FEK7vqCdHf7Fx4IseaVJZW76o4kSg
         i9Lgztnlw1ajhqTmB05Nx/1MrddBsowb8cbLEeu6va2oSc7YzVD2m0MFWO1NKCrpz4
         MUwzujF3mblVgyt51Y5xzEk2cerOyDUIvtLdqOqA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Alexander Theissen <alex.theissen@me.com>
Subject: [PATCH 3.18 42/54] usb: appledisplay: Add 27" Apple Cinema Display
Date:   Tue, 11 Dec 2018 16:41:30 +0100
Message-Id: <20181211151548.433595469@linuxfoundation.org>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20181211151546.010073210@linuxfoundation.org>
References: <20181211151546.010073210@linuxfoundation.org>
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

3.18-stable review patch.  If anyone has any objections, please let me know.

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


