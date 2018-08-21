Return-Path: <SRS0=PzCS=LE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE75EC4321D
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 08:11:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 826A620C01
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 08:11:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 826A620C01
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726842AbeHULbB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Aug 2018 07:31:01 -0400
Received: from mail-ua1-f50.google.com ([209.85.222.50]:43938 "EHLO
        mail-ua1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726346AbeHULbB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Aug 2018 07:31:01 -0400
Received: by mail-ua1-f50.google.com with SMTP id f4-v6so11320703uao.10;
        Tue, 21 Aug 2018 01:11:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=c5KYaLQ+yVYey17feGzjTGSPSb2K5Cc6S2noaTb1Ijg=;
        b=QQdexwkUoagKVijYFKqBjfCTmDrzCwWNsAJcfAwmgIpjqEyyXYE/Co+9HXnAG8sOUd
         e5ZYMPVzZFzzkNyUpwqqLsdhRB79wrjCldwqB5q9+AUHUr1IWiOjCHqsY8fKVtEWsGdh
         CZdLqM/845gbLg4wgEquXKn+3f93Slsx5lCYdVU/fTfkk2jB1bqu9mdWTgIVo/8HY+gX
         HNryLalt17fqHzv5nac1exfavx8m+Xq9nu2YLjF4Y+IB+QbCzISuLU3RiTWsUuVRSsMB
         4LNOD0mLqlBw8uuqsWvkc9CTpYh2kGMgKkEV7yITobUOqlKR79ZdK0F7IGX5qc+wLH3j
         QK4w==
X-Gm-Message-State: AOUpUlHD8btnCIdzG32N/CbH4b5JZzcOUkrHtqJ1wWvvBwYSukP3h9IZ
        GggdIFjDHtMH1JiZJgZOtLexTxAOMB009tlSMYE=
X-Google-Smtp-Source: AA+uWPySvzo2wz/3vDTkjwPbG+3PcD4WK+4M/jiHaU8S2K/Byz380Te7ThVNFRNcxzXZQs/1EUytEwTOAeB+G7Nui9k=
X-Received: by 2002:ab0:48a4:: with SMTP id x33-v6mr32580485uac.138.1534839112638;
 Tue, 21 Aug 2018 01:11:52 -0700 (PDT)
MIME-Version: 1.0
References: <20180720134219.680ae314@canb.auug.org.au>
In-Reply-To: <20180720134219.680ae314@canb.auug.org.au>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 21 Aug 2018 10:11:41 +0200
Message-ID: <CAMuHMdVs-3CWF23_qik6euae6tQasp-zM4tSgx-pp02xPnyEeA@mail.gmail.com>
Subject: Re: linux-next: manual merge of the mfd tree with the sound tree
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Lee Jones <lee.jones@linaro.org>, Takashi Iwai <tiwai@suse.de>,
        Linux-Next <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Neil Armstrong <narmstrong@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 20, 2018 at 5:42 AM Stephen Rothwell <sfr@canb.auug.org.au> wrote:
> Today's linux-next merge of the mfd tree got a conflict in:
>
>   drivers/gpu/drm/i915/Kconfig
>
> between commit:
>
>   a57942bfdd61 ("ALSA: hda: Make audio component support more generic")
>
> from the sound tree and commit:
>
>   9c229127aee2 ("drm/i915: hdmi: add CEC notifier to intel_hdmi")
>
> from the mfd tree.
>
> I fixed it up (see below) and can carry the fix as necessary. This
> is now fixed as far as linux-next is concerned, but any non trivial
> conflicts should be mentioned to your upstream maintainer when your tree
> is submitted for merging.  You may also want to consider cooperating
> with the maintainer of the conflicting tree to minimise any particularly
> complex conflicts.
>
> --
> Cheers,
> Stephen Rothwell
>
> diff --cc drivers/gpu/drm/i915/Kconfig
> index 5c607f2c707b,2d65d567d5d1..000000000000
> --- a/drivers/gpu/drm/i915/Kconfig
> +++ b/drivers/gpu/drm/i915/Kconfig
> @@@ -23,7 -23,7 +23,8 @@@ config DRM_I91
>         select SYNC_FILE
>         select IOSF_MBI
>         select CRC32
>  +      select SND_HDA_I915 if SND_HDA_CORE
> +       select CEC_CORE if CEC_NOTIFIER
>         help
>           Choose this option if you have a system that has "Intel Graphics
>           Media Accelerator" or "HD Graphics" integrated graphics,

Anyone who cares about alphabetically sorting the (long) list of selects,
reducing the potential for conflicts?

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
