Return-Path: <SRS0=X6pY=KX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6B53C46470
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 00:29:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 705CC214ED
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 00:29:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b87nqmxo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 705CC214ED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727351AbeHHCp6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Aug 2018 22:45:58 -0400
Received: from mail-qk0-f195.google.com ([209.85.220.195]:46156 "EHLO
        mail-qk0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726968AbeHHCp6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Aug 2018 22:45:58 -0400
Received: by mail-qk0-f195.google.com with SMTP id 191-v6so321254qki.13
        for <linux-kernel@vger.kernel.org>; Tue, 07 Aug 2018 17:29:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=ZJfDNLxKw5v8l4nbHTe52XzcLh0p6Efyu3ZfsNcp++c=;
        b=b87nqmxoEImQP+L9iZuAwSD0zdco/Jtlr3/RxUYPOnkerj+6IL7w3yYyfGk5MAbbpQ
         aZ2Ylm57VYA3oqlARqhPzoGIwOgY61kj7g5dUGEGQw3ZzD/TvWLMH0Io/6gV75TLbebd
         iOjBY7BMDV+qdDMOAwDXXHpTUUb451/da6MfSNfBL4Mz/FY/QhceQP/pVXqt13qFHAUg
         cRK/HDwEUdbMWsWzMhrJhb/pyoHEPplnSdHbF3W7iBs2hLa4iLLJEnHHRHKgHhb50igZ
         x9wOlbDr7vOySBSjHwY3x+XzrqXwVMvJAtJsF6/C4YQ5Qd1P1DyfntbjFs0nPoVDxI5l
         7p5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=ZJfDNLxKw5v8l4nbHTe52XzcLh0p6Efyu3ZfsNcp++c=;
        b=o7MnnEJRh6oiBjdfTXadSGIt0MuKLHwF2Hd+Bu41UHTvX0IcmIT+cMVx+6p0aTZNa9
         6Hj9uRIX1ycN2DTpFOCRl+DYUp+05uBcUR1Wue3dSWD6ekvBgm3emhHZ92atMCxmMeEV
         IDfEd2BJBmmJaPqt6AY6x57CdG+BWVtlOq4Vs0p2LpL3sXFLHyfAUfpFo8OndOIRw91G
         8qZGCLyvybDvu0LFOsVAI/+T/Obt1qNagL5Ey6LFH98hpYcMXz7jT+FPj37QYSRjuvts
         7biURzyow+IEZWsO+tYo5Nz4QIPBHioiE/M9aEBRSbCzsPJtle9wv/rk+i2jW3oo1dF4
         OY4Q==
X-Gm-Message-State: AOUpUlGpK/F+Kd9xX6s5GGI4Yox8BBhYWELW2q/8CXzqHTBpyKU6JbYu
        oOK0TZs5R3CAZDeZLAoEyWQ=
X-Google-Smtp-Source: AA+uWPyoop68zujuy3zM29pdDvTuFTYb4vKm0Gv9VQr980xUbR8rBJfST7LzIK+IIkuZs4WplbQrkA==
X-Received: by 2002:a37:a417:: with SMTP id n23-v6mr589084qke.42.1533688141031;
        Tue, 07 Aug 2018 17:29:01 -0700 (PDT)
Received: from WindFlash ([201.82.148.26])
        by smtp.gmail.com with ESMTPSA id v41-v6sm1726576qtk.70.2018.08.07.17.28.59
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 07 Aug 2018 17:29:00 -0700 (PDT)
Date:   Tue, 7 Aug 2018 21:28:57 -0300
From:   Leonardo =?utf-8?B?QnLDoXM=?= <leobras.c@gmail.com>
To:     Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 06/15] staging: fbtft: Changes gamma table to define.
Message-ID: <b7913aafa00d62b455ecef87f248049e81752d50.1533686201.git.leobras.c@gmail.com>
References: <cover.1533686201.git.leobras.c@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1533686201.git.leobras.c@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Most of other "Gamma Tables" were already boxed on a define, just did the same to PIOLED.

Signed-off-by: Leonardo Brás <leobras.c@gmail.com>
---
 drivers/staging/fbtft/fbtft_device.c | 13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)

diff --git a/drivers/staging/fbtft/fbtft_device.c b/drivers/staging/fbtft/fbtft_device.c
index 85018e4a4284..4110bba52e64 100644
--- a/drivers/staging/fbtft/fbtft_device.c
+++ b/drivers/staging/fbtft/fbtft_device.c
@@ -262,6 +262,10 @@ static const s16 waveshare32b_init_sequence[] = {
 	-3
 };
 
+#define PIOLED_GAMMA	"0 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 " \
+			"2 2 2 2 2 2 2 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 " \
+			"3 3 3 4 4 4 4 4 4 4 4 4 4 4 4"
+
 /* Supported displays in alphabetical order */
 static struct fbtft_device_display displays[] = {
 	{
@@ -890,14 +894,7 @@ static struct fbtft_device_display displays[] = {
 					{ "dc", 25 },
 					{},
 				},
-				.gamma =	"0 2 2 2 2 2 2 2 "
-						"2 2 2 2 2 2 2 2 "
-						"2 2 2 2 2 2 2 2 "
-						"2 2 2 2 2 2 2 3 "
-						"3 3 3 3 3 3 3 3 "
-						"3 3 3 3 3 3 3 3 "
-						"3 3 3 4 4 4 4 4 "
-						"4 4 4 4 4 4 4"
+				.gamma = PIOLED_GAMMA
 			}
 		}
 	}, {
-- 
2.18.0

