Return-Path: <SRS0=3gpS=RA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC8A8C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 13:39:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9799F2087C
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 13:39:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727330AbfBYNjJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Feb 2019 08:39:09 -0500
Received: from mail-qt1-f193.google.com ([209.85.160.193]:36961 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725857AbfBYNjI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Feb 2019 08:39:08 -0500
Received: by mail-qt1-f193.google.com with SMTP id a48so10444929qtb.4;
        Mon, 25 Feb 2019 05:39:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qQa+wgPMesiTlKTvsul58fMBX/JX9ZGKjrHuNhwWwaE=;
        b=lNXtjk4swRPraYzy5kMl4Ow/5aSxcVdyAS2aTKwq2Jle81xfRh2Me9KVYNKHXxuWdT
         RCvBdXUbxdiq0NROahYAJp8u2+V1zbp/0ut+jpqu0BfELqL/qAU6MOVYCSqk9HkuSi15
         qBmV6YYWLol2VQnMXEkq8Ilc9RM5JyFaHUZRPNwCT8AIkO3T/4T/dEBfg+kGRgwrcDDC
         92oWPE3NmEKEN7shghJ4H1zRe8mA9LinaAwYSkbzEstEyopGVQ/eKPMvNcyfTR50pbZ2
         V4RlzQCt5JqePpRWlUmqBr0Xl996qQtQguHNVaqowP7fjUM9X3HwXi0SJ0vCDGe3EoIn
         lWQA==
X-Gm-Message-State: AHQUAuavgX25FJKEaoO/aG3e3OHaLaUbXKX6Hy7sx1ClMIyC0UPNEtuJ
        Zn908wSdK4v7N+jxbpLfTx5pFobDRNHZWx52LgI=
X-Google-Smtp-Source: AHgI3Ia0H18NOVTeeQv3O4dtvQH0bnDl573OwqEPOJrarR2yrs4QFNav2eGJajGvCjfkGip/4HEkbKLCBWB4/EEEHDM=
X-Received: by 2002:ac8:445a:: with SMTP id m26mr13488848qtn.212.1551101947115;
 Mon, 25 Feb 2019 05:39:07 -0800 (PST)
MIME-Version: 1.0
References: <20190225123615.49bce7cd@canb.auug.org.au> <CAK8P3a3moJ12SDM3Ow-Hw3qBeTv9siswK+9pPiEA4JJ+7k4xvg@mail.gmail.com>
 <s5hr2bw2k7m.wl-tiwai@suse.de> <e2aaed45-0fb1-c9c8-76d4-3b97b36cada6@nvidia.com>
In-Reply-To: <e2aaed45-0fb1-c9c8-76d4-3b97b36cada6@nvidia.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Mon, 25 Feb 2019 14:38:50 +0100
Message-ID: <CAK8P3a2Q7OAAYCU01TNpHR2SM7N=YunyqZEihSESnQwxzL5=Vg@mail.gmail.com>
Subject: Re: linux-next: manual merge of the sound tree with the arm-soc tree
To:     Sameer Pujar <spujar@nvidia.com>
Cc:     Takashi Iwai <tiwai@suse.de>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Olof Johansson <olof@lixom.net>,
        ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Thierry Reding <treding@nvidia.com>,
        Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        DTML <devicetree@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 25, 2019 at 12:24 PM Sameer Pujar <spujar@nvidia.com> wrote:
> On 2/25/2019 4:44 PM, Takashi Iwai wrote:
> > On Mon, 25 Feb 2019 10:19:15 +0100, Arnd Bergmann wrote:
> >> On Mon, Feb 25, 2019 at 2:36 AM Stephen Rothwell <sfr@canb.auug.org.au> wrote:
> >> I see this property being used in commit c0bde003a013 ("ALSA:
> >> hda/tegra: sound card name from device tree"), which removes
> >> a questionable use of the root compatible property, replacing
> >> it with the new 'nvidia,model' property. We don't do this for any
> >> other subsystem, so why does the sound subsystem export
> >> information about the board as a string here?
> > The sound subsystem exports merely some understandable name string
> > for the given sound card object, and that was composed from the
> > compatible string in the past, which turned out to be useless on some
> > configs.
> >
> > But this kind of addition is an extremely bad manner, I'm fine to
> > revert these (at best with a better alternative).  This isn't about
> > any functionality but rather some readable information that isn't a
> > part of API.

It is not extremely bad, but it is at the minimum surprising.

> The motivation for adding custom sound card name is following,
> 1. When for boards, multiple HDMI/DP ports are exposed, it is sometimes
>     necessary to know the default port or any customization for that matter.
>     Audio userspace can distinguish based on the sound card names.
> 2. Multiple sound cards can coexist for a platform, the indication of
> particular
>     audio path is useful.
> 3. It can help to customize audio paths.
>     Generally people use "*,model" property in DT to name the sound complex.
>     Ex: "samsung,model" [sound/soc/samsung/snow.c]
>         "rockchip,model" [sound/soc/rockchip/rockchip_rt5645.c]

I see, I had not noticed those before. They do seem a little unusual,
and inconsistent, as the samsung sames are always names the board
there, but rockchip doesn't: one board names it just "I2C", the other
one uses "VEYRON-I2S", and the example in the documentation lists
"ROCKCHIP-I2S" and "Analog audio output", each of them following
different naming systems.

In Documentation/devicetree/bindings/sound/qcom,apq8096.txt, a
"qcom,model" property is listeds as "Obsolete", and replaced by
a "model" property. This is in turn also used on amlogic, freescale,
and some samsung platforms.

My impression here is that the idea of passing a model name
through DT is well established, but for new stuff, we probably
want to standardize on plain "model" rather than "$vendor,model".

       Arnd
