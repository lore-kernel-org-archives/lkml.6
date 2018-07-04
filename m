Return-Path: <SRS0=cgxA=JU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA2F0C3279B
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 10:07:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8756D2150E
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 10:07:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZP6e2GLz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8756D2150E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933056AbeGDKHf (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Jul 2018 06:07:35 -0400
Received: from mail-it0-f68.google.com ([209.85.214.68]:40361 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932493AbeGDKHd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jul 2018 06:07:33 -0400
Received: by mail-it0-f68.google.com with SMTP id 188-v6so7262166ita.5
        for <linux-kernel@vger.kernel.org>; Wed, 04 Jul 2018 03:07:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=GCav0y8enWnmMZ7LcLRU9XEWnMzjZNv/CIubdKodAFU=;
        b=ZP6e2GLzdctoG0ruzPkUwFFn2CLHhSDnyQZ2Dbn8HMpT54cQsJGyjs9UzeM2soiYKq
         v6fdgRL2097i5ts5TwhoKuBpfd/Q2gd5FsSZR6nA9GLd726FAK54AakPPXkuZfLz5IVt
         WIuCSfOYpuAsJj9BgDjobFbhT7ILR3mAU1Nfs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=GCav0y8enWnmMZ7LcLRU9XEWnMzjZNv/CIubdKodAFU=;
        b=gFqIRsHxV3xQpIR0o4gpkay4ubLWP8KQfh7y6ysUzw7/jtSQZPp6KfyEUgSrNIkgKx
         nshIh63hM64DCOmWy+Rrd3dcG9dhY4pnCMA/aarK1XydMZhRpHAAi6xJSYE948mrArBm
         eazVX5cfluc+bfSyoZvnltnqe4h0ESAupn47MYkvNvm84wM1nJj4Jc1Mz5lwPoBW9YYI
         jGwNlAWw7n3KBhWNGLW0oBHDBrcnDRygNeetJOUVW9KdZfVnztXUv/fmQZJ+3WxOvw7S
         OZ2pkNhlxtLHHyf2jXFMnZ7VnDcHTKsvDYnggmu4Ser+Htiauvt2swPiGPdrAoyBNQ75
         OkDA==
X-Gm-Message-State: APt69E3IuH6IyiRmwRzGSDMwbZkJDp/rmch0L0rr6Pw01txhOq+lBxYj
        85a/PRSjfQY4gg1HO5fT2JealYCVJHLNYrNUIaH10Q==
X-Google-Smtp-Source: AAOMgperrlyqXCvwigEyGCMLjf5AtM8UZyjw4XK1Th89e9poHBs38WCaD1FrLDpUO1KzHo7bWMTNN3mdwsvoi17T228=
X-Received: by 2002:a02:94af:: with SMTP id x44-v6mr1041091jah.121.1530698852972;
 Wed, 04 Jul 2018 03:07:32 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a02:818f:0:0:0:0:0 with HTTP; Wed, 4 Jul 2018 03:07:32 -0700 (PDT)
In-Reply-To: <76c619e6267c5f0adfda80d0fdba3c6b@agner.ch>
References: <20180628081331.13051-1-stefan@agner.ch> <20180628081331.13051-3-stefan@agner.ch>
 <CAPDyKFqPaRRuXdSD50q=et-OvJ=emdbq-XWyeddkiuC5SjuLig@mail.gmail.com> <76c619e6267c5f0adfda80d0fdba3c6b@agner.ch>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 4 Jul 2018 12:07:32 +0200
Message-ID: <CAPDyKFrjSadT0T2+zWhpq-E5kS1bm01y4R+LfyHyhjFBuK_hLQ@mail.gmail.com>
Subject: Re: [PATCH 2/3] mmc: sdhci: add quirk to prevent higher speed modes
To:     Stefan Agner <stefan@agner.ch>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Haibo Chen <haibo.chen@nxp.com>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        Michael Trimarchi <michael@amarulasolutions.com>,
        Russell King <rmk+kernel@armlinux.org.uk>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3 July 2018 at 10:48, Stefan Agner <stefan@agner.ch> wrote:
> On 02.07.2018 16:36, Ulf Hansson wrote:
>> On 28 June 2018 at 10:13, Stefan Agner <stefan@agner.ch> wrote:
>>> Some hosts are capable of running higher speed modes but do not
>>> have the board support for it. Introduce a quirk which prevents
>>> the stack from using modes running at 100MHz or faster.
>>
>> To cap the freq, use the DT property "max-frequency". To enable
>> certain speed modes, use the corresponding speed mode binding. For
>> example "sd-uhs-sdr*" and "mmc-hs200*".
>> Documented in Documentation/devicetree/bindings/mmc/mmc.txt
>
> I had bad experience with max-frequency: Some higher speed modes seem
> not to work reliably if constraint to low frequencies. E.g. we had lots
> of devices fail in practise with HS400@100MHz... So it is doing what it
> should, but it just seems that higher speed modes do not necessarily run
> well with lower frequencies...
>
> So I'd rather prefer to limit speed modes as it is done right now.
>
>>
>> In case the sdhci cap register, doesn't reflect the board support
>> properly, such that you may want to disable some speed modes, then you
>> may benefit from using the DT properties "sdhci-caps*.
>> Documented in Documentation/devicetree/bindings/mmc/sdhci.txt
>
> Hm, yeah I guess something like
>
> sdhci-caps-mask =  /bits/ 64 <((SDHCI_SUPPORT_SDR104 |
> SDHCI_SUPPORT_SDR50 | SDHCI_SUPPORT_DDR50) << 32)>
>
> would come close.
>
> But it does not restrict MMC modes such as HS200/HS400. There seem to be
> no mmc-caps...

Right.

The solution to fix this, should be to *not* set those DT properties,
like "mmc-hs*" for example. That should work, no?

>
>
> My aim is to replace the SDHCI_QUIRK2_NO_1_8_V fix, which does not
> restrict modes correctly. Currently the driver checks whether >=100MHz
> pinctrl settings are available, and if not uses the quirk to restrict
> higher speed modes. Removing that would break device tree backward
> compatibility...

Looks like the problem is not really SDHCI_QUIRK2_NO_1_8_V, but rather
how the pinctrl setting becomes interpreted when setting the quirk.

>
> We probably could do something like this:
> if (!100mhzpinctrl) {
>      if (!sdhci-caps) {
>           /*
>            * If no 100MHz/200MHz pinctrl are available, SDHC caps should
> be used to restrict
>            * modes. Falling back to old behavior...
>            */
>          pr_warn(...)
>          host->quirks2 |= SDHCI_QUIRK2_NO_1_8_V;
>      }
> }
>

I am not sure what makes best sense here. Let me have a look at patch 3 as well.

[...]

Kind regards
Uffe
