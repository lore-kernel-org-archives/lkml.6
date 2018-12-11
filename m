Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C33E4C5CFFE
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 16:13:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 84D802084E
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 16:13:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544544833;
	bh=vfqo1mjiDcFmsOktgxpOcIX42ItJEtVoty1a3dFFIJw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=1KVcFYNM0ma4KQQqwJkzxlqGBkUK35Z7hSzUqp+fS5s27b98823AnpxWlq47KuVSQ
	 KsxjSXxLIU/gSAbZ8FKub6P9nfL+4CwI7ETGPBKWf/HImaJkdBaM+AizpvjDjO4+Dt
	 xlfyhWlyajUOjGFMZ74VaduTs5kyZBClgtAxw33g=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 84D802084E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729063AbeLKPta (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 10:49:30 -0500
Received: from mail.kernel.org ([198.145.29.99]:37814 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729010AbeLKPtZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 10:49:25 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 76F12208E7;
        Tue, 11 Dec 2018 15:49:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544543364;
        bh=vfqo1mjiDcFmsOktgxpOcIX42ItJEtVoty1a3dFFIJw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fdhXpvJMgK7V4DcYupqGoFhq6xsPfh+CgNCKivOVFBLgFmbJsTg1uJK7GToTSiCD3
         xcTc9FdddYVU14X8f8UWb9nZJ3GV5t9jKpmASCNXxwMItLY8luswIH11RssF9v/n+e
         s+auOvVFjGwaIK5q5O1smbmzyIjEFhGo1yFv/3yQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Alexander Theissen <alex.theissen@me.com>
Subject: [PATCH 4.9 22/51] usb: appledisplay: Add 27" Apple Cinema Display
Date:   Tue, 11 Dec 2018 16:41:30 +0100
Message-Id: <20181211151615.053117632@linuxfoundation.org>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20181211151612.328911565@linuxfoundation.org>
References: <20181211151612.328911565@linuxfoundation.org>
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

4.9-stable review patch.  If anyone has any objections, please let me know.

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


