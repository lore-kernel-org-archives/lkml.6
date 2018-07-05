Return-Path: <SRS0=71UW=JV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A35C4C6778C
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 10:14:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D0D4240CD
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 10:14:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="IiZZVEs6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5D0D4240CD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753602AbeGEKN7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Jul 2018 06:13:59 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:50291 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753366AbeGEKN5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jul 2018 06:13:57 -0400
Received: by mail-wm0-f66.google.com with SMTP id v25-v6so10200067wmc.0
        for <linux-kernel@vger.kernel.org>; Thu, 05 Jul 2018 03:13:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=yaGZbzzXDLOA55yPS4uVEnVJP/wHdFMm3agtu0H/j84=;
        b=IiZZVEs6E+YCBYxpxKEmlkxhSCbFXH3Uut2s9P2rZd9M8U5PFVNUo65y2lQ26vjT3l
         S4lRLpAibT2XXjQKVuQ/tl97sVzINV8tkdMFmW7lnywLYPb2BEb/HbLd4XlfNTkAXZKo
         v61VES3s0saNR4nxzAnXyTaasIWOsiKQkUYEpOxnrw7WnXOFhYz5BXGXRrd7HhFQ8+7z
         KCIxsDrNjkUQBKfTl2LOcssMzK3VZxFyMlkOntMy2CkooYt3MBdidrHsTVgnf61I2mSN
         9SYb0dJHQrP8ZOKHHufxhchqh69p2JOzXxDQnu1kkAxXMfjFYbe/B5mzZka9Wqm/X727
         iA8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=yaGZbzzXDLOA55yPS4uVEnVJP/wHdFMm3agtu0H/j84=;
        b=WHLI19gaRIcggYA7IQ7DREfa4APJDK6sJc5PCt3C/SqmSMBpWGYqCyxRBmIZfse5Ja
         LDU+Y0eTmR/AF+1n+FSanVKrcoNx3srL/Iv2sLm+kIYe6qlmYBGZXLnlGNnSomVDB0U1
         KuINUgCV+ifWpjwMeuQk0baf2jprL6EdSpwE+EyTJBLrp1FVjD3X3FqpAG0DJfwTe9XO
         VMf+kNKcwp4pox7JF2W0mZSyw91Y2LqLzN7ddRj7eHadwPqM5Pg7FJqPEpDxiuGV/VP+
         mzDMVrqPHeaZMhZJ9QiHflgBDBj6wVgf2/M9xgYlnfzkIIEaGaLMrz03Hm3u+Pd+XnuQ
         5keg==
X-Gm-Message-State: APt69E0dXxnFeOgW7dYh0c13Q96WOvTkGWZsX7D27F+mI6JbEI9qqsvU
        PeqpgujAL4I+Pu0Dp6oiAXl1CS65
X-Google-Smtp-Source: AAOMgpfppwxIHMsCiia/SnIIr4uQTOipFs89sfPVImqaDL7rwGOR+eBugLZTJ+eqOpViSu63NVAT9Q==
X-Received: by 2002:adf:8806:: with SMTP id d6-v6mr3833651wrd.41.1530785636759;
        Thu, 05 Jul 2018 03:13:56 -0700 (PDT)
Received: from boomer.baylibre.local ([90.63.244.31])
        by smtp.googlemail.com with ESMTPSA id z18-v6sm5175510wrr.76.2018.07.05.03.13.55
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 05 Jul 2018 03:13:56 -0700 (PDT)
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
Cc:     Jerome Brunet <jbrunet@baylibre.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] ASoC: dpcm: add runtime rate merge of BE.
Date:   Thu,  5 Jul 2018 12:13:47 +0200
Message-Id: <20180705101349.7520-1-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.14.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset adds the possibility to merge BE rates in the dpcm runtime
hw, like it is done for formats and channels.

This first patch is a simple rework of format and channel merge to ease
the addition of rate merge.

Jerome Brunet (2):
  ASoC: dpcm: rework runtime stream merge
  ASoC: dpcm: add rate merge to the BE stream merge

 include/sound/soc.h |  2 ++
 sound/soc/soc-pcm.c | 99 ++++++++++++++++++++++++++++++++++++++++-------------
 2 files changed, 77 insertions(+), 24 deletions(-)

-- 
2.14.4

