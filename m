Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25E9FC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 22:24:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC25521934
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 22:24:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=mathembedded-com.20150623.gappssmtp.com header.i=@mathembedded-com.20150623.gappssmtp.com header.b="lfw58aOC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392489AbfBMWYj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 17:24:39 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:54325 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388723AbfBMWYi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 17:24:38 -0500
Received: by mail-wm1-f66.google.com with SMTP id a62so4295733wmh.4
        for <linux-kernel@vger.kernel.org>; Wed, 13 Feb 2019 14:24:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mathembedded-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=m+vCklTWoSobytp7Gc3dHDsQcFaMYAikQDXSI8DPoMk=;
        b=lfw58aOCKT6bJXatKmsWUo/L6nFMoh4ku0BsWsvhKY0Lz4tRqw1BOk7y8/bT8ejH4j
         u/+vXeR3EbiPnZi2x3s31TVrY5wymOYvl2qGFQDUpBoigrduNcFuvyJ7rPNBy5dQLhya
         /2KH2Xq+RS/14gTeQGNoLRE2CYMGXI3LYzl2fr1BhfRsjjwI2r7Co2mmsW8MvNErAIxq
         m8pK+979sbGolm0M4fHyikK2T89bWXsqsAfqL2P5h+2ck/9iwh1CJ82nHWGEJ3aHMFoa
         sE/Y2ImCBHutOJYSyGO4NZSXEFhSKl7PtOqiA24v3ETwzc3Urqq6RdVvhHpUn1lehj3p
         Ng6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=m+vCklTWoSobytp7Gc3dHDsQcFaMYAikQDXSI8DPoMk=;
        b=KXvo/zZ22TNSEtaKGxGxVrpwjG42qTeTtOhBvY7W2RzWmk7D8Fqo2R/uRSY4ZEkiAC
         pQpKAD9gY1CIpsjDuymf034mXDX17scJC18OxslblATAJuurc/zErYTZGQDgyhTVIQNU
         uhUh7jhXvEo/ShrL2kHLTlqMH6dcr/KDeQLBg2f1ALgKqlM4le/bwhrV2azFlgJuzHgB
         UXr721qmEWVpXgf0qwbikvaMeauljpsfvY7NdeTtgjg5lJhQCFEsMf748eszg8dexj8v
         YL6hcbvoCKBmyRah7nN4jRnylZbEyXwDW+AIzDq3EsIkjNXqXYDwZjsdavUx2H/hxFoo
         S+fw==
X-Gm-Message-State: AHQUAubY5//lVWcEUCW5i+Dzs+EJS5VjfUXpq4XacmB89WSgx3FljK66
        rAaWmA/95Iu86OUSlY6vacfbxQ==
X-Google-Smtp-Source: AHgI3IaOpfGHUjxvmhDCxkXzLXzIfQ1TB3hqopYyP8jKoRacfL0nP3yvHKl20OaO0HeNLB0nVWDVYQ==
X-Received: by 2002:a7b:c8d0:: with SMTP id f16mr265981wml.134.1550096676753;
        Wed, 13 Feb 2019 14:24:36 -0800 (PST)
Received: from diamond.mathembedded.com (host86-176-243-198.range86-176.btcentralplus.com. [86.176.243.198])
        by smtp.gmail.com with ESMTPSA id h71sm788330wme.20.2019.02.13.14.24.35
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 13 Feb 2019 14:24:35 -0800 (PST)
From:   Stuart Menefy <stuart.menefy@mathembedded.com>
To:     Sangbeom Kim <sbkim73@samsung.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Lee Jones <lee.jones@linaro.org>, linux-kernel@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org
Cc:     Stuart Menefy <stuart.menefy@mathembedded.com>
Subject: [PATCH v3 0/2] mfd: sec: Add support for the RTC on S2MPA01
Date:   Wed, 13 Feb 2019 22:24:00 +0000
Message-Id: <20190213222402.20541-1-stuart.menefy@mathembedded.com>
X-Mailer: git-send-email 2.13.6
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the RTC on the S2MPA01. As this is appears to be identical to the
RTC on the S2MPS14 we can use the existing code.

Before we can do that however tidy up the existing code as requested by
Lee:
https://lore.kernel.org/lkml/20190213072458.GB1863@dell/

Changes since v2:
 - Add patch tidying up existing one element structure initialisation
 - Rebase patch 2/2

Changes since v1:
 - Remove the duplicated code and simply declare the RTC to be the same
   as that on the S2MPS14.

Stuart Menefy (2):
  mfd: sec: Put one element structure initialisation on one line
  mfd: sec: Add support for the RTC on S2MPA01

 drivers/mfd/sec-core.c | 59 +++++++++++++++++---------------------------------
 drivers/mfd/sec-irq.c  |  3 +++
 2 files changed, 23 insertions(+), 39 deletions(-)

-- 
2.13.6

