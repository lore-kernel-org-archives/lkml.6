Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EB42ECDFB3
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 15:38:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 071F420779
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 15:38:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="bhUB/+C0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 071F420779
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731649AbeGQQMD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 12:12:03 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:35362 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730267AbeGQQMD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 12:12:03 -0400
Received: by mail-wm0-f67.google.com with SMTP id y22-v6so2016149wma.0
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jul 2018 08:38:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9sAH2Ef99/2bhlR0MoQCg+FVxNbBkGW0ITAgVPFte8U=;
        b=bhUB/+C0clfnybspZTs75RRQuB4IZJ/rE/6puw6Gq5SqL55W/jtZ+S/nv5FfFdcyfs
         AtykdHfn4gDW2fygyHxYhxwoN0B05MoC6cNw/IXmX8t8nCVn4PhhYapuss71RESlKpCk
         EvoH8vL7H+u/+1YeleismMTA8F46bkofOm/4+yrFFRb1nXq2rKdbcsIBjY4hLEBkypoP
         3feBkS7+FPXf2TaCtSQuSSxoHCfNbFIFtHzL6aK64p8Z/cjU/0pw5MStCXHVkfsy4788
         kIgt3iH8cA4nEdT80Nl+XjoIVWHccCgv5Hz4GNoDBN7hBjhXbIB9AOq3bIkHGM/Sa7Zg
         jjew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9sAH2Ef99/2bhlR0MoQCg+FVxNbBkGW0ITAgVPFte8U=;
        b=h0ehpnFUUv1LergoLUu+xCacqL+xLT5+E/g3D9mqqIx7dypw/jHjiEASPyiQUvgTes
         V9ZkE6G6wE5sPDRgl7TruhF33YTHgmMuWmlG3s2GLbLk+Yup4dEoGYF7Gdjhal3oJpe+
         SIz+fxGsW81952xpkkbAFI/UH0ACryt0gU8YkJB/gN+GZqRk/ywdKett7hL0vyjG7OsL
         kuPkJ6ThGBB+Qep7ixa87rH45yGgS5CWXV6YiNp9qL0dJrNG1o5yqyse6vWnXu47N4du
         A0F2CLuSoPkL67Jc48f3y1lZwdODk35tIkTMbeesc1l9i7PYEFA2sav1SfJC9T7WKNTL
         yXcA==
X-Gm-Message-State: AOUpUlHfpUicqMkhvRxePSNyIceGRK9pkQxN9zKtE0iEoMjKsBnOOdtE
        gC0sOJGAW5CEyrCAkkBuzwCe27LIjG8=
X-Google-Smtp-Source: AAOMgpcVdJr7I7+WQBoR0e9KZSgkVk9iTtfJJvovOckPPw15oEynb4qmZN164I3vpj3xQ+UB/0+Obg==
X-Received: by 2002:a1c:cc08:: with SMTP id h8-v6mr1621638wmb.82.1531841928862;
        Tue, 17 Jul 2018 08:38:48 -0700 (PDT)
Received: from boomer ([90.63.244.31])
        by smtp.gmail.com with ESMTPSA id a13-v6sm2131769wrf.93.2018.07.17.08.38.47
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 17 Jul 2018 08:38:48 -0700 (PDT)
Message-ID: <1531841927.26720.18.camel@baylibre.com>
Subject: Re: [PATCH 00/15] ASoC: meson: add axg audio subsystem support
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Carlo Caione <carlo@caione.org>
Cc:     alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-amlogic@lists.infradead.org
Date:   Tue, 17 Jul 2018 17:38:47 +0200
In-Reply-To: <20180717153643.8806-1-jbrunet@baylibre.com>
References: <20180717153643.8806-1-jbrunet@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 (3.26.6-1.fc27) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2018-07-17 at 17:36 +0200, Jerome Brunet wrote:
> This patchset adds support for the audio subsystem found on Amlogic's
> axg SoC family. The first SoC of this family is the A113D/X targeted
> at smart speaker application. The G12a SoC family, Amlogic next-gen
> STB chipset, will reuse this audio subsystem with a few changes.
> 
> This patchset implements the DPCM machine driver and the different
> components it made of. Several components are still missing, such
> spdif input and pdm, and will submitted later on.
> 
> The fancier part of this patchset is probably around the TDM. Properly
> modeling the SoC architecture and its capatilities made things a little
> more complex than usual (details in the related commit descriptions)
> 
> If necessary, this patchset could broken into smaller series. For the
> intial submission, I wanted to give a global view of the subsystem.
> Hopefully, it will make it a bit easier to understand.
> 
> Jerome Brunet (15):
>   ASoC: meson: add axg fifos DT binding documentation
>   ASoC: meson: add axg fifo base driver
>   ASoC: meson: add axg frddr driver
>   ASoC: meson: add axg toddr driver
>   ASoC: meson: add axg spdif output DT bindings documentation
>   ASoC: meson: add axg spdif output
>   ASoC: meson: add axg tdm formatters DT bindings documentation
>   ASoC: meson: add axg tdm interface DT bindings documentation
>   ASoC: meson: add tdm formatter base driver
>   ASoC: meson: add tdm interface driver
>   ASoC: meson: add tdm output driver
>   ASoC: meson: add tdm input driver
>   ASoC: export snd_soc_of_get_slot_mask
>   ASoC: meson: add axg sound card DT bindings documentation
>   ASoC: meson: add axg sound card support
> 

Really sorry for the noise, messed up with format-patch.
Please ignore this series. I will resend it
