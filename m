Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32C71C004D2
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 02:23:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D2C6A2083C
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 02:23:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D2C6A2083C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sakamocchi.jp
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728099AbeJAI63 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Oct 2018 04:58:29 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:34179 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727277AbeJAI63 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Oct 2018 04:58:29 -0400
Received: by mail-pf1-f194.google.com with SMTP id k19-v6so8065267pfi.1
        for <linux-kernel@vger.kernel.org>; Sun, 30 Sep 2018 19:23:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=DQ9Cpd8D+2FKhAnL508GVFP60TvHvJ0B01q7d8g9lH0=;
        b=Rc/WXtRmbSBBQ67hAR4FSj20kjZ81SCJ2VzpxenRI13KT16Cx3zE3Y5bH6tBRm9aHx
         nhsGxRte07HcowfH5rJOea9K6qCw2AhP5EJ4Xtj1iiKzpSyGgCTxwyj0z579KIdv2JAD
         NfkfN4840W1L7Y5D8KNcVyWG9jlvbtSv/PWyTHBQJFrhtnPtQ72hINrDPYH3V5s4x3A0
         i9J/UQWuz2TU9K+zMJWA8Xb2L0nTcZ5vGnBA619f+jElB37tBe8eZ2M626arv0t+Mdt6
         9xRgMrsBKQP/DwAzyfAhPXctzBn6HFUqng8sGrVHDgtQtGoPx2Md4iWNRreBVEpN7nNL
         iizQ==
X-Gm-Message-State: ABuFfojAq64cPArETfDkxAtg66XaYIhW0x+YcCy7CiAmyOBCy7RcQwpY
        t2aPeb0ErSgKi7O02ijEi/gFkSqj
X-Google-Smtp-Source: ACcGV63hc53Rn7pTE+q4pAs130imErgMWSGyHs0e/tMZ3bEWuLQ8QqJebFel/d+LoevDiJYHMCUKHQ==
X-Received: by 2002:a62:d582:: with SMTP id d124-v6mr7243995pfg.31.1538360581121;
        Sun, 30 Sep 2018 19:23:01 -0700 (PDT)
Received: from ?IPv6:2405:6580:9660:3200:6caf:e2c:fa0a:6628? ([2405:6580:9660:3200:6caf:e2c:fa0a:6628])
        by smtp.gmail.com with ESMTPSA id g17-v6sm4220299pfe.37.2018.09.30.19.22.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 30 Sep 2018 19:23:00 -0700 (PDT)
Subject: Re: [PATCH 10/11] ALSA: hda/ca0132 - Add ZxR 600 ohm gain control
To:     Connor McAdams <conmanx360@gmail.com>
Cc:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        Alastair Bridgewater <alastair.bridgewater@gmail.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
References: <1538276607-30234-1-git-send-email-conmanx360@gmail.com>
 <1538276607-30234-11-git-send-email-conmanx360@gmail.com>
From:   Takashi Sakamoto <o-takashi@sakamocchi.jp>
Message-ID: <e313237f-1f99-bf87-ebb9-8dffb7a96e46@sakamocchi.jp>
Date:   Mon, 1 Oct 2018 11:22:57 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <1538276607-30234-11-git-send-email-conmanx360@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sep 30 2018 12:03, Connor McAdams wrote:
> This patch adds a control for 600 ohm gain on the Sound Blaster ZxR.
> 
> Signed-off-by: Connor McAdams <conmanx360@gmail.com>
> ---
>   sound/pci/hda/patch_ca0132.c | 44 ++++++++++++++++++++++++++++++++++++++++++--
>   1 file changed, 42 insertions(+), 2 deletions(-)
> 
> diff --git a/sound/pci/hda/patch_ca0132.c b/sound/pci/hda/patch_ca0132.c
> index f0781e4..90e6a96 100644
> --- a/sound/pci/hda/patch_ca0132.c
> +++ b/sound/pci/hda/patch_ca0132.c
> ..
> @@ -6415,6 +6452,9 @@ static int ca0132_build_controls(struct hda_codec *codec)
>   		ae5_add_headphone_gain_enum(codec);
>   		ae5_add_sound_filter_enum(codec);
>   	}
> +
> +	if (spec->quirk == QUIRK_ZXR)
> +		zxr_add_headphone_gain_switch(codec);
>   #ifdef ENABLE_TUNING_CONTROLS
>   	add_tuning_ctls(codec);
>   #endif

Though error code can be returned in a call of snd_hda_ctl_add(), it's 
not handled correctly in 'ca0132_build_controls()'. At least, return
code in calls of below functions is better to be checked.

  - add_voicefx()
  - add_ca0132_alt_eq_presets()
  - ca0132_alt_add_svm_enum()
  - ca0132_alt_add_output_enum
  - ca0132_alt_add_input_enum
  - ca0132_alt_add_mic_boost_enum
  - ae5_add_headphone_gain_enum
  - ae5_add_sound_filter_enum
  - zxr_add_headphone_gain_switch

This is not a strong request and you can work for it after merging this
patchset. We have two weeks more till next merge window.


Regards

Takashi Sakamoto
