Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA24CC6778A
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 11:32:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 81F612086B
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 11:32:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="eodbefVf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 81F612086B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932795AbeGILb7 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 07:31:59 -0400
Received: from mail-it0-f67.google.com ([209.85.214.67]:36498 "EHLO
        mail-it0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932482AbeGILb4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 07:31:56 -0400
Received: by mail-it0-f67.google.com with SMTP id j185-v6so25611704ite.1
        for <linux-kernel@vger.kernel.org>; Mon, 09 Jul 2018 04:31:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=G6c9a47YExbDBhVY3P4bZgpa8L9U1okymtiLcOu2tV0=;
        b=eodbefVfnBWoLEQVQmHVpWCo2TWNvawrWQA8s2l5F3b6TukJ/B/96mdeDHRc0a7mLK
         R+UgGlw9hLbPbYhHrLpzstwD4Soqb0LS8IBQ1vK8FnrRrkisX+Jx80G5bWthgfIz6PST
         a1rEc9MPmYGYhOHj+3ND4hjUaQlRgoLC1b6/Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=G6c9a47YExbDBhVY3P4bZgpa8L9U1okymtiLcOu2tV0=;
        b=TtcDid437Mu9F4c2J2GkhanhE+WUr0EQ2qu5f0LgxZGhFPXMpRyTDELM//T1d6WPOq
         Xg3CKGRI5xspH/YFeW7EnlQyuBErMP0jnNuwq+AQ9i6cGoqJjc/rba+rxTEa6OQJE+j+
         NxOSS8jb6AXk21Kmgk5e+7XGtQEUutY+AbwfPCq+PDMq1OsrTvVde5aSYBR4nSpuW5Bj
         WrTwlZPwcUJ8MZCgsiYFyrBJk7AIbi7LhCU3J+ur1CiDHG8B5y26dq7/zTq/bXavckvY
         km80ZcfV9YCDJPEBTdRV3y9Q/rR0blwSLRqq7v4Iw392J26IZhffQC8Hw8KSQ+AlG0SQ
         Vulw==
X-Gm-Message-State: APt69E33IeCakf/+WwcOIEDQCok7duMy8pavxlWw5N+goFpH2cefNN84
        mSbw2QGWoBp454om2tShwEN2kQCWCJ3WeEEX9Mc6cw==
X-Google-Smtp-Source: AAOMgpfW9Tz0DtHyMIj4SQhl6BAHE1PM/3Cx1vfm0ascU69suwVyIpW0DV98DSUHzXgDYWq0GGsX5FqFoR31cN4oYDI=
X-Received: by 2002:a24:d00b:: with SMTP id m11-v6mr16051257itg.97.1531135916322;
 Mon, 09 Jul 2018 04:31:56 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a02:818f:0:0:0:0:0 with HTTP; Mon, 9 Jul 2018 04:31:55 -0700 (PDT)
In-Reply-To: <3d4064a559e741e05105b11c9e7a831d@agner.ch>
References: <20180704150745.21003-1-stefan@agner.ch> <CAPDyKFou773HgPzE29Ynr2MVFcaOhb=+uXBrjL+1H8iWx4jdQw@mail.gmail.com>
 <3d4064a559e741e05105b11c9e7a831d@agner.ch>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 9 Jul 2018 13:31:55 +0200
Message-ID: <CAPDyKFqoZ=od-sJVO9Aj9Ha6QjGqjvrNuyWE2HS_Rtkap_bbKw@mail.gmail.com>
Subject: Re: [PATCH v2] mmc: sdhci-esdhc-imx: allow 1.8V modes without
 100/200MHz pinctrl states
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

On 5 July 2018 at 16:22, Stefan Agner <stefan@agner.ch> wrote:
> On 05.07.2018 15:10, Ulf Hansson wrote:
>> On 4 July 2018 at 17:07, Stefan Agner <stefan@agner.ch> wrote:
>>> If pinctrl nodes for 100/200MHz are missing, the controller should
>>> not select any mode which need signal frequencies 100MHz or higher.
>>> To prevent such speed modes the driver currently uses the quirk flag
>>> SDHCI_QUIRK2_NO_1_8_V. This works nicely for SD cards since 1.8V
>>> signaling is required for all faster modes and slower modes use 3.3V
>>> signaling only.
>>>
>>> However, there are eMMC modes which use 1.8V signaling and run below
>>> 100MHz, e.g. DDR52 at 1.8V. With using SDHCI_QUIRK2_NO_1_8_V this
>>> mode is prevented. When using a fixed 1.8V regulator as vqmmc-supply
>>> the stack has no valid mode to use. In this tenuous situation the
>>> kernel continuously prints voltage switching errors:
>>>   mmc1: Switching to 3.3V signalling voltage failed
>>>
>>> Avoid using SDHCI_QUIRK2_NO_1_8_V and prevent faster modes by
>>> altering the SDHCI capability register. With that the stack is able
>>> to select 1.8V modes even if no faster pinctrl states are available:
>>>   # cat /sys/kernel/debug/mmc1/ios
>>>   ...
>>>   timing spec:    8 (mmc DDR52)
>>>   signal voltage: 1 (1.80 V)
>>>   ...
>>>
>>> Link: http://lkml.kernel.org/r/20180628081331.13051-1-stefan@agner.ch
>>> Signed-off-by: Stefan Agner <stefan@agner.ch>
>>
>> Thanks, applied for next! Let's see if this turns out okay, then let's
>> make it a fix and add a stable tag.
>>
>> BTW, would you mind looking up the commit it fixes? Or if there is a
>> certain stable release we should target.
>>
>
> The quirk SDHCI_QUIRK2_NO_1_8_V has been used if pinctrl were missing
> since support has been added for additional pinctrl states (back around
> 3.13).
>
> Fixes: ad93220de7da ("mmc: sdhci-esdhc-imx: change pinctrl state
> according to uhs mode")
>
> I guess it won't apply on older kernels since the code which applies the
> quirk has been moved around.

Thanks!

I have moved the patch to fixes and added a stable tag, # v4.13+. It
applied cleanly on top of that kernel version, if you or anyone else
needs it for an older kernel, please post a backported patch.

[...]

Kind regards
Uffe
