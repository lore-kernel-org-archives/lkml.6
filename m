Return-Path: <SRS0=KKla=QI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 334D3C282D8
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 08:05:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0217820863
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 08:05:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fMsSd933"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727791AbfBAIFI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Feb 2019 03:05:08 -0500
Received: from mail-it1-f182.google.com ([209.85.166.182]:36694 "EHLO
        mail-it1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725786AbfBAIFH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Feb 2019 03:05:07 -0500
Received: by mail-it1-f182.google.com with SMTP id c9so8568753itj.1;
        Fri, 01 Feb 2019 00:05:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=LrXMuVInfBoFgqkBXH7g5f70XnsHBP+Fp7D6fTS+JB8=;
        b=fMsSd933zKq24rpGB37+jfQ2tKSmOGfBEBtC5yCS699vX6jKEuYO8sMwhEVyQ8UBxG
         HpdKRafCNKuwPlyJKJAixuCfCrKizJhdxBUfr0Krki8OG5dn+C4aiYF6Wadv3GtUwOpU
         OLKb8wB/88pZpcPrkoV7/3eLTbsOHdwPC1XpzipLCZ+d3HlC5wkSgbHJwKP1SnOHIIog
         AzmdVWWkXo3K5Fp7FFbtYiskx+1YYFGskAmGKA47g/dYSLqPVj5PJh4vPeXmj408877n
         nnvro1a8BRiQHy+MSzmJkNt/tw9hog7n7zx72GbCzXznVyNtRJQbLgF995i47PjIs3ZZ
         2J+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=LrXMuVInfBoFgqkBXH7g5f70XnsHBP+Fp7D6fTS+JB8=;
        b=jdQ0xFIWXwxMkrPYy3P5FtDSRCUFQ94knwEApKEnz/XE+qf3LoasHAhh23dL1SyLUT
         ZfQl/dvbIwyM/ViGOdFqO1oG4DnVHb4aKjAJdzMHwB04wN8payWFQo1JPhByjW1PuRW0
         wLYOjNj/iOy/ObZI3uF63K3Q2O6AmbNA7f4ewbj87ruxdts6IHZQNAX2wPKmzAAifflA
         8cBdACj5BD2/FMEUZwQQdwG1L9LGsRTc03MuXHKyTsaP6/Xc66AIsSmbfS+/LKvvu/lT
         EmhXbvUztfnZXiYTScAzAGaSTyic43qg7g5YH287p8DOIG9zlWo2axQbYD4YciFVOaC5
         Pa7Q==
X-Gm-Message-State: AHQUAuY2OMVr7j4z3k+xumUDeRA7rHgVwTYgrVmBgZnFsgai6f0S0Y4C
        haV7CNItC9ak4YlwBFKe2DCG83JEzZzWD/PUm/q8jOlh
X-Google-Smtp-Source: AHgI3IZLl7hL5UedoEjpVagL0FjBfnOcnMnrED6LpY4A78yUVMmavMcJkUkOZWEMRLUpmEDoKzSqtEcIX4gBxK84fdc=
X-Received: by 2002:a24:b044:: with SMTP id b4mr775356itj.164.1549008306771;
 Fri, 01 Feb 2019 00:05:06 -0800 (PST)
MIME-Version: 1.0
From:   Michael Umansky <mishka99@gmail.com>
Date:   Fri, 1 Feb 2019 00:04:40 -0800
Message-ID: <CAOPCCyKnS6Eab6QD8Qd6-pyYTXP4VDMsjTfzzv8R+ijTDCVf4w@mail.gmail.com>
Subject: latest RT patches for the latest 4.20.6 release
To:     stable@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I found linux-stable-rt-4.20.2.tar.gz but the latest official patches
are for 4.19.15 (in the rt directory).

While I can run the diffs against the regular 4.20.2 tree I'm curious
if there will be official patches released against that version, or
better yet, against current 4.20.6 stable version?

thanks
Michael Umansky
