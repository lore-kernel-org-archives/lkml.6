Return-Path: <SRS0=71UW=JV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E533C6778A
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 09:48:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C663E2405C
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 09:48:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="E9IDIzlP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C663E2405C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753421AbeGEJsX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Jul 2018 05:48:23 -0400
Received: from mail-it0-f66.google.com ([209.85.214.66]:36655 "EHLO
        mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753271AbeGEJsW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jul 2018 05:48:22 -0400
Received: by mail-it0-f66.google.com with SMTP id j185-v6so11193815ite.1
        for <linux-kernel@vger.kernel.org>; Thu, 05 Jul 2018 02:48:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=fqOfzO88RVB/rA/5UTuVM+UXL319/o9khOYwN3rgz5E=;
        b=E9IDIzlPrzTt8V3aP0lpNrcJAHoCehmtNho2UsKSGsERWWyLPEIPcauQSXuHnG9XZU
         ep0HIu1kWjp27KquAu9zblymNn6evdEHt2mI1iFafXfxJUvl3v3V92q4HmDC05vRy9C3
         Kw8Tslk/ia3wxTZnsjkIoTsr0hpNGwaPdQdvw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=fqOfzO88RVB/rA/5UTuVM+UXL319/o9khOYwN3rgz5E=;
        b=Fx1Hesx59SyxrEKImOZvhZGo0jkGkVhSgQ6JCXgXuno5wRKZIlMMdSrb9TVd3MfAKS
         C9Qdf1LQvNWxtKluRQrTWvEFzL8OYJGvnb5knGiNkTImgK28aIta1K7eSwSz04CEZzrc
         /4XS6vgwR3HHzZapLnQotd+NkeF0Kyk67KVjcsqextg9Yz1mqLvsdYEXceozbl7zlERX
         30W3/j7pDw04USxisNq0xBCElflG5aWXYfu0AP4bf3gl+rWSfDpN4LaUp/FvXigUbYsP
         tL6uKYP4/YHcnzaUwi4/9076H5EUGFkNqb4gYjaYEhZviI0Mbv1VU+vhK6RZL/1MUVkp
         +GWg==
X-Gm-Message-State: APt69E2pWBRjh7OnIxWuGbN34cOYivq6+bjp4ljnXQ6q3PMDuKZlTF7p
        qaCgr5He97F6hr63fhuXm+RyaCfdLaq+UI3bbxo1tQ==
X-Google-Smtp-Source: AAOMgpd5zc0a/f9/4E2a/XBziFzwiFq7vyA6kfst8bJG1Wb2S48GY8SYvpccfyoyS6b6WPqrlHiBs0wQfIOJDLY+x9w=
X-Received: by 2002:a24:d00b:: with SMTP id m11-v6mr4344818itg.97.1530784101498;
 Thu, 05 Jul 2018 02:48:21 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a02:818f:0:0:0:0:0 with HTTP; Thu, 5 Jul 2018 02:48:20 -0700 (PDT)
In-Reply-To: <b2cc30701b1c38cd0c40736d04407424@agner.ch>
References: <20180704150745.21003-1-stefan@agner.ch> <b2cc30701b1c38cd0c40736d04407424@agner.ch>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 5 Jul 2018 11:48:20 +0200
Message-ID: <CAPDyKFqhUBteUNwE4aice5kxNkTX-0mHiJELhA57hwEmPH6v6A@mail.gmail.com>
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

On 4 July 2018 at 17:18, Stefan Agner <stefan@agner.ch> wrote:
> On 04.07.2018 17:07, Stefan Agner wrote:
>> If pinctrl nodes for 100/200MHz are missing, the controller should
>> not select any mode which need signal frequencies 100MHz or higher.
>> To prevent such speed modes the driver currently uses the quirk flag
>> SDHCI_QUIRK2_NO_1_8_V. This works nicely for SD cards since 1.8V
>> signaling is required for all faster modes and slower modes use 3.3V
>> signaling only.
>>
>> However, there are eMMC modes which use 1.8V signaling and run below
>> 100MHz, e.g. DDR52 at 1.8V. With using SDHCI_QUIRK2_NO_1_8_V this
>> mode is prevented. When using a fixed 1.8V regulator as vqmmc-supply
>> the stack has no valid mode to use. In this tenuous situation the
>> kernel continuously prints voltage switching errors:
>>   mmc1: Switching to 3.3V signalling voltage failed
>>
>> Avoid using SDHCI_QUIRK2_NO_1_8_V and prevent faster modes by
>> altering the SDHCI capability register. With that the stack is able
>> to select 1.8V modes even if no faster pinctrl states are available:
>>   # cat /sys/kernel/debug/mmc1/ios
>>   ...
>>   timing spec:    8 (mmc DDR52)
>>   signal voltage: 1 (1.80 V)
>>   ...
>>
>> Link: http://lkml.kernel.org/r/20180628081331.13051-1-stefan@agner.ch
>> Signed-off-by: Stefan Agner <stefan@agner.ch>
>> ---
>
> Btw, I still get the switching error once during boot-up:
>   mmc1: Switching to 3.3V signalling voltage failed

I guess the this happens then also at system resume?

The core tries first with 3.3 then if it fails, it continues with 1.8V, etc.

>
> This is due to the call from mmc_set_initial_signal_voltage. It is a bit
> unfortunate since this is printed as a warning. Not sure if that could
> be prevented somehow?

Seems like SDHCI_SIGNALING_330 should not be set, unless 3.3V I/O is
supported. That should avoid SDHCI from trying and instead just
returning an error code immediately.

This seems like a generic issues for all SDHCI variant drivers.

[...]

Kind regards
Uffe
