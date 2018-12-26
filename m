Return-Path: <SRS0=2CM+=PD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53D64C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 02:30:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 203C321720
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 02:30:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=umn.edu header.i=@umn.edu header.b="YQVtKCOZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726902AbeLZCaT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Dec 2018 21:30:19 -0500
Received: from mta-p7.oit.umn.edu ([134.84.196.207]:35782 "EHLO
        mta-p7.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725876AbeLZCaS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Dec 2018 21:30:18 -0500
Received: from localhost (unknown [127.0.0.1])
        by mta-p7.oit.umn.edu (Postfix) with ESMTP id 72BB3B45
        for <linux-kernel@vger.kernel.org>; Wed, 26 Dec 2018 02:30:17 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p7.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p7.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id aQsXblDbNyvL for <linux-kernel@vger.kernel.org>;
        Tue, 25 Dec 2018 20:30:17 -0600 (CST)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
        (using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mta-p7.oit.umn.edu (Postfix) with ESMTPS id 429CCB16
        for <linux-kernel@vger.kernel.org>; Tue, 25 Dec 2018 20:30:17 -0600 (CST)
Received: by mail-io1-f70.google.com with SMTP id x2so17774263ioa.23
        for <linux-kernel@vger.kernel.org>; Tue, 25 Dec 2018 18:30:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umn.edu; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=8hEGMvffrUiw9dEYsU/Nc1z3C+p7rVZkDACQdzzdsms=;
        b=YQVtKCOZsYdKFZP4Y4jlRrV4DMLaiOQBuZqJxoK8ftXxNuFv7dOT2AJXy0iXfOSskz
         AiwyBhGTBjY2i/kMKAU8Dcp+aKSdojoNm2gk/2NfmGiBM4mcEncUiS7Dq8GLXp4wGtk1
         Lac1USEL+wKgdxL497a82tYQJTYO0dOZZplrdfWB+FCGBgQ0blf3wwpKRqa8xh8BaAEA
         +w+OQaKDxUmjv1RJAtMhRF3np5rVUmZp202rH1ZkbLFkzT5G+L5aJN89bVZkWBpbUlRe
         ck24qPA/KRsSYsQg3zjQj72O1VzkN3mXF4tbNTLPFmRdP1RI7QK/zAy2lrz1SivDknMf
         Y0CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=8hEGMvffrUiw9dEYsU/Nc1z3C+p7rVZkDACQdzzdsms=;
        b=kBQxwk9hVscUswel1MuL/yqpNB5r7qqw7OwBINCCYcXeIo66YXeoaBCnBrlREiEgNC
         JH8hgnAFnZ6OASRa47pLImwKLaCv1VsbZxYz/Or7FEvjnv172Ceos25I0u0fJ086lkUV
         ATXkX7I6OoNR8BCHJtzv4RM1PpDcg2/lRXaX2k+/SOBRpQSRiCjhRoaSrNnegYm9kgxY
         Nas3s61t2I0bnzfeX7VVvU6yZvJmDh/OQre47baDfFLicRcy5QsazdOWTC6DgFws4oLw
         mnxcgJtxgthohDXeNF3G+T/AGWynH5r9+zJn+eVmTGZzhswcaPChgwrSofgihrmP4CLH
         NCaQ==
X-Gm-Message-State: AA+aEWZNnunRgWzCAOVk0yct0+h9CzhS5FelQosfOYItSOlPuL2JCvtM
        mtI8eO93Si9e+B1zkHcKfBpTHsom5AEHr/S4Yf/OKPuo+Du5W/UaQlRngpVNLYr17OhFFdmwYz7
        /iKHojkLaIxjzEua4DTPYiCALfJxG
X-Received: by 2002:a02:908d:: with SMTP id x13mr11999488jaf.65.1545791416876;
        Tue, 25 Dec 2018 18:30:16 -0800 (PST)
X-Google-Smtp-Source: AFSGD/VqrACC0N+s3xHX7HJiBf/6uDy2UpvBJN8PsbIM3j8jLEjPhzBSVkY/9JbXQdm1KBLA795GYQ==
X-Received: by 2002:a02:908d:: with SMTP id x13mr11999477jaf.65.1545791416645;
        Tue, 25 Dec 2018 18:30:16 -0800 (PST)
Received: from localhost.localdomain (host-173-230-104-22.mnmigsc.mn.minneapolis.us.clients.pavlovmedia.net. [173.230.104.22])
        by smtp.gmail.com with ESMTPSA id l3sm13329866itb.43.2018.12.25.18.30.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 25 Dec 2018 18:30:15 -0800 (PST)
From:   Kangjie Lu <kjlu@umn.edu>
To:     kjlu@umn.edu
Cc:     pakki001@umn.edu,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        Jie Yang <yang.jie@linux.intel.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: [PATCH] sound: atom: fix a missing check  of snd_pcm_lib_malloc_pages
Date:   Tue, 25 Dec 2018 20:29:48 -0600
Message-Id: <20181226022950.71824-1-kjlu@umn.edu>
X-Mailer: git-send-email 2.17.2 (Apple Git-113)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

snd_pcm_lib_malloc_pages() may fail, so let's check its status and
return its error code upstream.

Signed-off-by: Kangjie Lu <kjlu@umn.edu>
---
 sound/soc/intel/atom/sst-mfld-platform-pcm.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/sound/soc/intel/atom/sst-mfld-platform-pcm.c b/sound/soc/intel/atom/sst-mfld-platform-pcm.c
index afc559866095..91a2436ce952 100644
--- a/sound/soc/intel/atom/sst-mfld-platform-pcm.c
+++ b/sound/soc/intel/atom/sst-mfld-platform-pcm.c
@@ -399,7 +399,13 @@ static int sst_media_hw_params(struct snd_pcm_substream *substream,
 				struct snd_pcm_hw_params *params,
 				struct snd_soc_dai *dai)
 {
-	snd_pcm_lib_malloc_pages(substream, params_buffer_bytes(params));
+	int ret;
+
+	ret =
+		snd_pcm_lib_malloc_pages(substream,
+				params_buffer_bytes(params));
+	if (ret)
+		return ret;
 	memset(substream->runtime->dma_area, 0, params_buffer_bytes(params));
 	return 0;
 }
-- 
2.17.2 (Apple Git-113)

