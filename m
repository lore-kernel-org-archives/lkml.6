Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 472C4C43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 19:15:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 13089206B7
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 19:15:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="NFoS0jYL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727467AbfAGTPN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 14:15:13 -0500
Received: from mail-qk1-f195.google.com ([209.85.222.195]:42430 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726602AbfAGTPN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 14:15:13 -0500
Received: by mail-qk1-f195.google.com with SMTP id 68so912913qke.9
        for <linux-kernel@vger.kernel.org>; Mon, 07 Jan 2019 11:15:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=OQPhpem738Y/XDyv02lLu7Lu2ECfK24W+en8ROxQEUM=;
        b=NFoS0jYLmF/KOz0rLc1K/9JS3q+2dZ55KEV3mLWvS41oQDU+VhexAg04O7PcU+gVY7
         LlrzFKRyG76hnY9YFYcfGDb+yUg4p6oczzcvtKbIBiWJIyGaVjEYmwrJGBG+2Z3zp4Et
         jR2byQeR/dkzdx5Z1IL2foyoJM5oRb/BiNrYI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=OQPhpem738Y/XDyv02lLu7Lu2ECfK24W+en8ROxQEUM=;
        b=pFORPv6VshC//VCKzgYSiSgeRxM+Swuv8HrBsdpFCgXGd8GOD51Wk+5oGqhq7uOVIS
         d4/RKGsEOkoWHi63VumKKX/N+gDfWfMHhZBvOgX7SehWC/mbUrjPNAvV3WjmAYNb049I
         +jYiulsb55ZBOq4kFhtMTpCp5BS2qrtPz0tw9sHhSkegxyEuYLNM1NdWFwaf7BLtzpgK
         BCFAkZwZDV00ajArv/F36oe/94vQmcImzBk3ehpye1Z34yuxj6F4I+4f7096nTMcOljU
         IwBTBYY2pAjYdqYV5QtJtD4B5P/TmUFzyYo5EIKcm+TE36dvmgNCWp+VpLjoZPtToav7
         IQNQ==
X-Gm-Message-State: AJcUukeH2WGIzmgyEG/4g4U3LSs/7MFVG8LPPzKOJmm1QA664HeHeZ5z
        utK/WUkFcVAxExbVAbreoydDQg==
X-Google-Smtp-Source: ALg8bN5OGYKUNvT2y3kHTpzICPCQuFc7j3O/a3+UeAHiKpDg3c4kzXfEy1t+nz5EiU6qGas/7bI+9A==
X-Received: by 2002:ae9:e102:: with SMTP id g2mr55029827qkm.343.1546888512143;
        Mon, 07 Jan 2019 11:15:12 -0800 (PST)
Received: from davidb.org (cn-co-b07400e8c3-142422-1.tingfiber.com. [64.98.48.55])
        by smtp.gmail.com with ESMTPSA id d193sm38782876qka.91.2019.01.07.11.15.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 07 Jan 2019 11:15:11 -0800 (PST)
Date:   Mon, 7 Jan 2019 12:15:03 -0700
From:   David Brown <david.brown@linaro.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Alan Stern <stern@rowland.harvard.edu>,
        Matt Dharm <mdharm-usb@one-eyed-alien.net>,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        usb-storage@lists.one-eyed-alien.net
Subject: [PATCH] usb: storage: Remove outdated URL from MAINTAINERS
Message-ID: <20190107191502.GA31394@davidb.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This website hasn't worked for quite some time.

Signed-off-by: David Brown <david.brown@linaro.org>
Cc: Matt Dharm <mdharm-usb@one-eyed-alien.net>
---
 MAINTAINERS | 1 -
 1 file changed, 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 82ad0eabce4f..0dbba14128e4 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -14142,7 +14142,6 @@ M:	Alan Stern <stern@rowland.harvard.edu>
 L:	linux-usb@vger.kernel.org
 L:	usb-storage@lists.one-eyed-alien.net
 S:	Maintained
-W:	http://www.one-eyed-alien.net/~mdharm/linux-usb/
 F:	drivers/usb/storage/
 
 USB MIDI DRIVER
-- 
2.19.2
