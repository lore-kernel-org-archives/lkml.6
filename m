Return-Path: <SRS0=cgxA=JU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06007C3279B
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 11:16:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE1AC22CA1
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 11:16:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="UXqFsLAX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AE1AC22CA1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753767AbeGDLQY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Jul 2018 07:16:24 -0400
Received: from mail-io0-f193.google.com ([209.85.223.193]:36441 "EHLO
        mail-io0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753561AbeGDLQX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jul 2018 07:16:23 -0400
Received: by mail-io0-f193.google.com with SMTP id k3-v6so4553823iog.3
        for <linux-kernel@vger.kernel.org>; Wed, 04 Jul 2018 04:16:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=r8106mhANmHuo4lkuuk5nnnmPIWB1B41XsI4QTZ/364=;
        b=UXqFsLAXefWWnDEov1nhkd5Uy2WOWnSnzbmQoZ+m+mCw9AsVWTnjEu2Qp2eV/IKl7f
         yBIrwyXdbhJP8WRBxtnlLq/gQQdcpMc10Q9xuVTHXZNUpa0nhp54LQDlElVscijnlDtL
         Xc5lLtmzpbkA0oB5x1Vmt1pfCgWkbhs2nSXFM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=r8106mhANmHuo4lkuuk5nnnmPIWB1B41XsI4QTZ/364=;
        b=RWB6GsO8sUnNDKSytfO+LlSlcRPPyYAiBMEB2n87XCfGY0iUzEMVlUREzD0xq1Eipz
         aWFA1rkLfi25W8F5g/4TsXp//2+S4UzWRXvjY2AhOXn9z/PrFWmBt5LXQnauHyHAH1xW
         fD8Oe7hmBvrmEq3gc3TyIpf5WEi3/J4bflsJvHUMjm4aCFcvNmKmL37CQlIQX+G8YUs6
         /LR28gcokCUaADRNSTRjVkpbXiDZVXGIvqXtzJ0qfVhNdZ4N2As7fIV+Ni39pgwNniCA
         IMxUhRARwmA/gIYLdAGhyqEHQUPNAYrjWD9h3MUpcNyCAIzNDmpeG5GERYp/7lZcN26C
         UKdQ==
X-Gm-Message-State: AOUpUlF1PK4OvShyLbPILqKNTuaxbUNJXsmpP97k1sd5NSjO2q68Mmzd
        x2oeHp3gUbE6pAvGm3A3zaRvz1eDMT0miVH/AZgjwQ==
X-Google-Smtp-Source: AAOMgpeQMgXS704NHuebusZUmUQcYW5kl5ivhW5teD7JSGKxlbIGImYqmJptN6G2HRTsAeCG2FnidrKjArWgE7mivoM=
X-Received: by 2002:a6b:c997:: with SMTP id z145-v6mr1233670iof.266.1530702982739;
 Wed, 04 Jul 2018 04:16:22 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a02:818f:0:0:0:0:0 with HTTP; Wed, 4 Jul 2018 04:16:22 -0700 (PDT)
In-Reply-To: <ffea342896629cf57b78661b04f60eda@agner.ch>
References: <20180628081331.13051-1-stefan@agner.ch> <20180628081331.13051-3-stefan@agner.ch>
 <CAPDyKFqPaRRuXdSD50q=et-OvJ=emdbq-XWyeddkiuC5SjuLig@mail.gmail.com>
 <76c619e6267c5f0adfda80d0fdba3c6b@agner.ch> <CAPDyKFrjSadT0T2+zWhpq-E5kS1bm01y4R+LfyHyhjFBuK_hLQ@mail.gmail.com>
 <ffea342896629cf57b78661b04f60eda@agner.ch>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 4 Jul 2018 13:16:22 +0200
Message-ID: <CAPDyKFrDMmMu1kuJdPDyyGKu6b0dR2MF2U4Rnb4hoHAcwNYtuw@mail.gmail.com>
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

On 4 July 2018 at 12:55, Stefan Agner <stefan@agner.ch> wrote:
> On 04.07.2018 12:07, Ulf Hansson wrote:
>> On 3 July 2018 at 10:48, Stefan Agner <stefan@agner.ch> wrote:
>>> On 02.07.2018 16:36, Ulf Hansson wrote:
>>>> On 28 June 2018 at 10:13, Stefan Agner <stefan@agner.ch> wrote:
>>>>> Some hosts are capable of running higher speed modes but do not
>>>>> have the board support for it. Introduce a quirk which prevents
>>>>> the stack from using modes running at 100MHz or faster.
>>>>
>>>> To cap the freq, use the DT property "max-frequency". To enable
>>>> certain speed modes, use the corresponding speed mode binding. For
>>>> example "sd-uhs-sdr*" and "mmc-hs200*".
>>>> Documented in Documentation/devicetree/bindings/mmc/mmc.txt
>>>
>>> I had bad experience with max-frequency: Some higher speed modes seem
>>> not to work reliably if constraint to low frequencies. E.g. we had lots
>>> of devices fail in practise with HS400@100MHz... So it is doing what it
>>> should, but it just seems that higher speed modes do not necessarily run
>>> well with lower frequencies...
>>>
>>> So I'd rather prefer to limit speed modes as it is done right now.
>>>
>>>>
>>>> In case the sdhci cap register, doesn't reflect the board support
>>>> properly, such that you may want to disable some speed modes, then you
>>>> may benefit from using the DT properties "sdhci-caps*.
>>>> Documented in Documentation/devicetree/bindings/mmc/sdhci.txt
>>>
>>> Hm, yeah I guess something like
>>>
>>> sdhci-caps-mask =  /bits/ 64 <((SDHCI_SUPPORT_SDR104 |
>>> SDHCI_SUPPORT_SDR50 | SDHCI_SUPPORT_DDR50) << 32)>
>>>
>>> would come close.
>>>
>>> But it does not restrict MMC modes such as HS200/HS400. There seem to be
>>> no mmc-caps...
>>
>> Right.
>>
>> The solution to fix this, should be to *not* set those DT properties,
>> like "mmc-hs*" for example. That should work, no?
>>
>
> The controller does not make use of the dt modes so far, so I can't not
> set those properties...

Then where are the corresponding caps for the eMMC speed modes being set?

Can't you just avoid setting them?

>
>>>
>>>
>>> My aim is to replace the SDHCI_QUIRK2_NO_1_8_V fix, which does not
>>> restrict modes correctly. Currently the driver checks whether >=100MHz
>>> pinctrl settings are available, and if not uses the quirk to restrict
>>> higher speed modes. Removing that would break device tree backward
>>> compatibility...
>>
>> Looks like the problem is not really SDHCI_QUIRK2_NO_1_8_V, but rather
>> how the pinctrl setting becomes interpreted when setting the quirk.
>>
>
> Yes, sorry for the confusion. SDHCI_QUIRK2_NO_1_8_V is fine, it is just
> not the quirk this driver needs.
>
> I argue that commit ad93220de7da ("mmc: sdhci-esdhc-imx: change pinctrl
> state according to uhs mode") chose the wrong quirk from the
> beginning...

That's seems reasonable! But it's been there since 3.13, so I guess we
have to think about backwards compatibility issues, as you stated.

>
> Afaict, the quirk needed here does not exist.

[...]

Kind regards
Uffe
