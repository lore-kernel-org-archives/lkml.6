Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90463C6778A
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 10:03:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2BBC320852
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 10:03:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="2NRgKubw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2BBC320852
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388349AbeGXLIz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 07:08:55 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:37197 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726367AbeGXLIz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 07:08:55 -0400
Received: by mail-wm0-f65.google.com with SMTP id n11-v6so1914102wmc.2
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jul 2018 03:03:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=BxwVO/EcXpPeF3isg3l9x8hE+UN+sMl/J3Mw5faKj2k=;
        b=2NRgKubwlUVqKvX+euKA3+Xc0LDCAdk5V/ecwQhMlbS9a2eq4UqGYJuXbVovnrDJHi
         UcFp3TCqyz5jhvkXdigGMeXk+4eoSGPwD/0bZ3/Cxd2RITrEbKI4aoO6bXe2lPJM1eTp
         hd7Et7E2Zrjmx/e/BK3fZFoQeFFpNx21RL+q4sEsogFqfD+WLjks7e4Sxb2B7IbW05f6
         ndJdBMgZ33IsYeTKqTbN350HGk+3WbDs22LsgAm0K0IEAvjI7ZG1B8P44TFcZ7/jweto
         dPPlEJ851Fd6J+D829WJZCXnLVzHHvQLPNMxrAqdyvy3yqmnNzg/aFPHopsB8TIJoiIi
         m6xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BxwVO/EcXpPeF3isg3l9x8hE+UN+sMl/J3Mw5faKj2k=;
        b=rNTdSvzzF4sXGp6Bb0QnfKb6HVCtAdwWuxitoO9vR4Und+PjoRMFJndBiEJNNWneen
         JE+bSDGLkrBtyq26irfYzud7nsm7HCPXWAafx44A/xw4GdIlAJqJxCvBf/XdQK+aqFSn
         n9VRf9ZwT9it7ZJ2RvbbJvDgoEpkp1WpLj3SwGprNZegVgae0Lvx5cane7QBc0sRCUSA
         LsyDTjLUmeVLNW7dp+T+mBgipEUNVoRsA9Ml9yNPwmUP4N+hZwAz5piWB82NiYV49rEe
         8uX0HwAxUZ0E1zSALA0TAITRvMzWzew9Z7JN82wuhB2C40l0L7cnbSyhOVLbUO5GCmhp
         6IZg==
X-Gm-Message-State: AOUpUlFTUbxl+V+iFagGfMhCewSsdQhe897tBcnYTZ/S1mU/JrzvfYMB
        OsxJPED/mW2FPFZQ2OupKmXang==
X-Google-Smtp-Source: AAOMgpdVb/9QHQKnWvEH2knfx2hg8n+wZL11jhOl9afSLJ4y9f9fN2PGVh6DlReTgNo02QbagkOrIQ==
X-Received: by 2002:a1c:b584:: with SMTP id e126-v6mr1711118wmf.136.1532426592417;
        Tue, 24 Jul 2018 03:03:12 -0700 (PDT)
Received: from boomer.lan (cag06-3-82-243-161-21.fbx.proxad.net. [82.243.161.21])
        by smtp.gmail.com with ESMTPSA id w8-v6sm8985208wrp.72.2018.07.24.03.03.11
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 24 Jul 2018 03:03:11 -0700 (PDT)
Message-ID: <59fdcf671ffd0ef60e4d982ba269f853089ee7da.camel@baylibre.com>
Subject: Re: [PATCH] ASoC: meson: axg-spdifout: select SND_PCM_IEC958
From:   jbrunet@baylibre.com
To:     Arnd Bergmann <arnd@arndb.de>, Mark Brown <broonie@kernel.org>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Carlo Caione <carlo@caione.org>,
        Kevin Hilman <khilman@baylibre.com>,
        alsa-devel@alsa-project.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Date:   Tue, 24 Jul 2018 12:03:10 +0200
In-Reply-To: <20180724093705.1691747-1-arnd@arndb.de>
References: <20180724093705.1691747-1-arnd@arndb.de>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.4 (3.28.4-1.fc28) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2018-07-24 at 11:36 +0200, Arnd Bergmann wrote:
> When CONFIG_SND_PCM_IEC958 is disabled, we get a link error for the
> new driver:
> 
> sound/soc/meson/axg-spdifout.o: In function `axg_spdifout_hw_params':
> axg-spdifout.c:(.text+0x650): undefined reference to
> `snd_pcm_create_iec958_consumer_hw_params'

I used arm64 defconfig to do all my test and this symbol was selected
by the HDMI codec driver, which is probably why missed it. 

Thanks a lot for fixing the problem Arnd.

> 
> The other users use 'select', so we should do the same here.
> 
> Fixes: 53eb4b7aaa04 ("ASoC: meson: add axg spdif output")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Acked-by: Jerome Brunet <jbrunet@baylibre.com>

