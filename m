Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45180C5CFFE
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 15:47:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0BC0F2145D
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 15:47:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544543258;
	bh=Djsbtzi/TR7ayQrSSJNUUB3plK6MMkxiSrp48iLLgfI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Uoe6zRj4OgT63NV2mqCDgHCoTFgI+FTFnNaLdAUO9DiPwwCI74xJyaxkuXFx8KmnM
	 pDQNqWXg59AHkkOYf0Fj4lXpxY8nv+n/pOUyiRxKU1a6pyDUzgHjNc+pLGW9HH91DT
	 reEh1VfOUAhfjyZT4UKeiA3t5OjpmXTb3EXHDvnI=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0BC0F2145D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728598AbeLKPrg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 10:47:36 -0500
Received: from mail.kernel.org ([198.145.29.99]:36062 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728576AbeLKPre (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 10:47:34 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4906B20989;
        Tue, 11 Dec 2018 15:47:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544543253;
        bh=Djsbtzi/TR7ayQrSSJNUUB3plK6MMkxiSrp48iLLgfI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=reY3p0f6zcqKHQK78QHxPYJVs5VRENBDUt3IXkrUYPW0DwJ2STXyPRQa2iyfU5R2/
         C2BlndZOh3qsMoZAOEWjP+ZpSWFlakCzwSHUv14R5d/uqx7kMIstQa38xpynleDjoU
         0bJMjNRFAfhdl49/xTAR4YT9GkOEEFQD9qk/hV8k=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Alexander Theissen <alex.theissen@me.com>
Subject: [PATCH 4.4 71/91] usb: appledisplay: Add 27" Apple Cinema Display
Date:   Tue, 11 Dec 2018 16:41:30 +0100
Message-Id: <20181211151612.142117633@linuxfoundation.org>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20181211151606.026852373@linuxfoundation.org>
References: <20181211151606.026852373@linuxfoundation.org>
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

4.4-stable review patch.  If anyone has any objections, please let me know.

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


