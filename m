Return-Path: <SRS0=7Z+k=KK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FC91C28CF6
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 15:42:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3FEF920857
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 15:42:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iYPrFW5a"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3FEF920857
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731909AbeGZQ75 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Jul 2018 12:59:57 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:55760 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731721AbeGZQ74 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jul 2018 12:59:56 -0400
Received: by mail-wm0-f66.google.com with SMTP id f21-v6so2428401wmc.5
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jul 2018 08:42:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=bQ//A8LCHYgPMsCe3Nc+SoU4xMXW5wpSE4Hm7jv17fs=;
        b=iYPrFW5am3Xrt0ya7ygTO/kd0LiU5O4plUcnr1IdC7xItHZ1RTosRXLkUbMOtAyhWZ
         PsKYYjFkbSRMUaUWd56nAx0MwbYjq1YyJH1IJBl+wcZf1jBGBDa+zuKRRdKBiGGIJnLq
         ftr+Vb046zjq0ppVMatB4DF+nNtTczkfQotnJ2U9LEY5tW/XYHeG52jGYI1eh8Qy8kl4
         56gigI4EhfdbBhfP2msCbhAlo2mIpts3OW1oGKoAcZxrRZsRwIH4OB8FFWShritiXaJC
         ZynvfB0/5WKRNSg0+MqbQz0OxuuV0wTK+WK4CPu1lSexZHij7bgVZjo3o5uHSS0WtiU9
         XZ1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=bQ//A8LCHYgPMsCe3Nc+SoU4xMXW5wpSE4Hm7jv17fs=;
        b=OMk+mj8zqO8GcykPOLgcfuP3udmUKWmoGg0YDgPE/L3gJfkJh024pHPT+fweEsuGjl
         Z7b/4pmtOHcq5QbxHxPT+IT5pePH+JpJcBeCDCHOLsMK6kZKQhUtij24JemFJ0yAffIz
         oe9DGVcPZRW6J2rH9FFWr7KrvA4FG/++i5pwYKVrD9+oaIaMJMcrTtXFdSNR8W5fR5Ny
         /mN8HnbMbAIQCIChoiO/etbU/ZFj5hZx9DBLSwML5Ppv3G9eDQ75ZXA4cyzGyDMDEYq+
         HDwYET3VES3XvXhEoTPwOL4hPrJ57AhLlHIywdR8ccMXUEfBZHCPmQbIgEDsmUtdcTqa
         yj5A==
X-Gm-Message-State: AOUpUlECWd+ThAmsfGZSdGWoT2SWd1qmaQH4F6js3BbsA7EsmrLJRVQG
        4EQS3zRE7U3xqhyWl7fKW3xiWYJS911DKw==
X-Google-Smtp-Source: AAOMgpdUcWu5qDOicrVRGyL7HjpU4r9FNkosuSY/XeJob95iOQXNLVZXWrRpz7bvYFlRtzZPMspnUA==
X-Received: by 2002:a1c:8f50:: with SMTP id r77-v6mr2025632wmd.44.1532619750982;
        Thu, 26 Jul 2018 08:42:30 -0700 (PDT)
Received: from we.local (ppp-2-87-92-87.home.otenet.gr. [2.87.92.87])
        by smtp.gmail.com with ESMTPSA id r5-v6sm1294667wmc.39.2018.07.26.08.42.30
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 26 Jul 2018 08:42:30 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by we.local (Postfix) with ESMTP id 3F4EB6407E7;
        Thu, 26 Jul 2018 18:42:29 +0300 (EEST)
X-Virus-Scanned: amavisd-new at local
Received: from we.local ([127.0.0.1])
        by localhost (we.local [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id EEPDjM_a66TM; Thu, 26 Jul 2018 18:42:28 +0300 (EEST)
Received: by we.local (Postfix, from userid 1000)
        id 4F9B36408C4; Thu, 26 Jul 2018 18:42:28 +0300 (EEST)
From:   Georgios Tsotsos <tsotsos@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Georgios Tsotsos <tsotsos@gmail.com>,
        James Hogan <jhogan@kernel.org>,
        Aaro Koskinen <aaro.koskinen@iki.fi>,
        Joe Perches <joe@perches.com>, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/3] Staging: octeon-usb fixes for coding style, SPDX and readability.
Date:   Thu, 26 Jul 2018 18:41:50 +0300
Message-Id: <cover.1532610629.git.tsotsos@gmail.com>
X-Mailer: git-send-email 2.16.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, 
Ok, this have gone too far, i sent these series so many times wrong...
I am sorry its my first patch (and series) and i keep mix-up patch generation
an sending to my self. Last time not everybody was cc.

Here are three patches which trying to resolve TODO's list requirements 
number 45 about octeon-usb. 
There are SPDX licence additions on code, makefile and header files.
Checkpatch warnings are resolved,also a notice about CVMX_WAIT_FOR_FIELD32 macro.
After Joe Perches's (joe@perches.com) suggestion i broke down the 
cvmx_usb_poll_channel function in order to improve readability and keeping it
under 80 columns.

Georgios Tsotsos (3):
  Staging: octeon-usb: Adding SPDX license identifier
  Staging: octeon-usb: Change coding style of CVMX_WAIT_FOR_FIELD32 marco.
  Staging: octeon-usb: Breaks down cvmx_usb_poll_channel().

 drivers/staging/octeon-usb/Makefile     |   1 +
 drivers/staging/octeon-usb/octeon-hcd.c | 128 +++++++++++++++++++-------------
 drivers/staging/octeon-usb/octeon-hcd.h |   1 +
 3 files changed, 80 insertions(+), 50 deletions(-)

-- 
2.16.4
