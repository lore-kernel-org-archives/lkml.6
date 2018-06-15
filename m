Return-Path: <SRS0=sQLo=JB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2156FC5CFC1
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 23:33:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D59C2208D7
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 23:33:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g6AcwdWC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D59C2208D7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756838AbeFOXdK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Jun 2018 19:33:10 -0400
Received: from mail-pg0-f65.google.com ([74.125.83.65]:45672 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756807AbeFOXdE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jun 2018 19:33:04 -0400
Received: by mail-pg0-f65.google.com with SMTP id z1-v6so5037784pgv.12;
        Fri, 15 Jun 2018 16:33:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ITUVC9LBnWi7fLZ0EdR/Tdci0pgIb7X7cLDoaAkbyXs=;
        b=g6AcwdWCukQhclS0CGJrRkmzdB+Mk0a4Z5cUVmkrFdhBaafXPvymREfZbcGinhz7+f
         snoJ37e1UFEO7WaKCiW7KgF4OpnJzrFkV2ZwPHUGnIBpmXxpD3ff7zXt5R2GWtOuvpF+
         8Se0bkOO8sENhOxi3ztVWdGRjDXHXWIskWrdFFqOD8MPi3kJ9RbSdrAr2oKxcziEi/sf
         co7xT/RSmvAistwOMn8nzQYF1Q0q8b3h+Bya1vOaB7EBNF6pfauTANgjnJPmhMDKBWtx
         0yE+RgB0Zjp//049cY2J2rzO9/wzpQz31u3m00xl42Bsw+O5xjJeZUJn98G42VmKlzKW
         14gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ITUVC9LBnWi7fLZ0EdR/Tdci0pgIb7X7cLDoaAkbyXs=;
        b=efD9fsAz5CqBIXCqEmvlfUSDaeqB8v89HkmlnyqIO8nLmjHjenLVIl1SXkC/r1KNGJ
         PXiBO/6CxSwfNGxnU31CQh+9JRrbz6WVz4iJqHdsrnqmAD9+HPqJEBCwdFyt+0d56dax
         hzIHo+pTXvPK49C/yrgz7VpwCOjwQyhMX8t3c8FANWOLtl9QBxS2GyWY4ACy/vxN79g4
         MOit9E1fftAcoQmVV8VIRhym6hjklU1WdX2M+vlvJ6zmYkt5A1buZjwE0f1Jtd6QGDNQ
         yUA/PKVxlxxP0XNOFfICzFITwkgOmTxqtV28UETx54f6tAPVT9MgrjII9J2BBQ5uHR0I
         VR1Q==
X-Gm-Message-State: APt69E2fvY0X/iIt0OuiORradVkUaRzgMS17Cb8VEYTWqpQM6cpvxRR4
        pzqQTMVZYexd1FYj1dsXZUk=
X-Google-Smtp-Source: ADUXVKKxT51fvDMpvmvOAL8Zhd5Im0oY6aWpDAr1bqZhnra5uclwci07F48gbA03z+QppPxSzvjncQ==
X-Received: by 2002:a62:a60e:: with SMTP id t14-v6mr4017450pfe.241.1529105584147;
        Fri, 15 Jun 2018 16:33:04 -0700 (PDT)
Received: from [192.168.43.97] ([1.1.125.127])
        by smtp.gmail.com with ESMTPSA id r11-v6sm15701762pfb.139.2018.06.15.16.32.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 15 Jun 2018 16:33:03 -0700 (PDT)
Subject: Re: [PATCH 1/3] drm: mxsfb: Change driver.name to mxsfb-drm
To:     Leonard Crestez <leonard.crestez@nxp.com>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "stefan@agner.ch" <stefan@agner.ch>,
        "marex@denx.de" <marex@denx.de>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>
Cc:     "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>,
        "marcofrk@gmail.com" <marcofrk@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "l.stach@pengutronix.de" <l.stach@pengutronix.de>
References: <cover.1529091248.git.leonard.crestez@nxp.com>
 <47ea7572011735b68a8a70f0e11bdf00cb2fd86a.1529091248.git.leonard.crestez@nxp.com>
 <CAOMZO5B8i0gN+rCq-yPrd112NkwJWTxYCtsLVeLhD1JLRuX6EQ@mail.gmail.com>
 <07be6d9a85b6be655fc2b084be81d8bf9715b57a.camel@nxp.com>
 <638457fd-85da-8fec-d146-517c43f71813@denx.de>
 <b3fa74c5110b45e5992920485749869ab1f7ebce.camel@nxp.com>
From:   Marek Vasut <marek.vasut@gmail.com>
Message-ID: <6995fa4b-47a9-887b-5e4f-4284ca6a2c79@gmail.com>
Date:   Sat, 16 Jun 2018 01:32:44 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <b3fa74c5110b45e5992920485749869ab1f7ebce.camel@nxp.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/16/2018 12:42 AM, Leonard Crestez wrote:
> On Fri, 2018-06-15 at 23:36 +0200, Marek Vasut wrote:
>> On 06/15/2018 10:58 PM, Leonard Crestez wrote:
>>> On Fri, 2018-06-15 at 16:47 -0300, Fabio Estevam wrote:
>>>> On Fri, Jun 15, 2018 at 4:43 PM, Leonard Crestez
>>>> <leonard.crestez@nxp.com> wrote:
> 
>>>>> The FBDEV driver uses the same name and both can't be registered at the
>>>>> same time. Fix this by renaming the drm driver to mxsfb-drm
>>>>
>>>> Stefan sent the same patch a few days ago:
>>>
>>> In that thread there is a proposal for removing the old fbdev/mxsfb
>>> driver entirely.
>>>
>>> That would break old DTBs, isn't this generally considered bad? Also,
>>> are we sure the removal of fbdev/mxsfb wouldn't lose any features?
>>>
>>> What my series does is make both drivers work with the same kernel
>>> image and turns the choice into a board-level dtb decision. Supporting
>>> everything at once seems desirable to me and it allows for a very
>>> smooth upgrade path.
>>
>> Having two drivers in the kernel with different set of bugs is always bad.
>>
>>> The old driver could be removed later, after all users are converted.
>>
>> Both drivers were in for long enough already. And let's be realistic,
>> how many MX23/MX28 users of old DTs with new kernels are there who
>> cannot update the DT as well ?
> 
> Grepping for "display =" in arch/arm/boot/dts/imx* I see that old
> bindings are also used by 3rd-party boards for imx6/7:
>  * imx6sx-nitrogen6sx
>  * imx6ul-geam
>  * imx6ul-isiot
>  * imx6ul-opos6uldev
>  * imx6ul-pico-hobbit
>  * imx6ul-tx6ul
>  * imx7d-nitrogen7

Er, yes, a handful of boards which could be updated :)

> Converting everything might be quite a bit of work, and explicitly
> supporting old bindings is also work.

Does adding support for old bindings justify the effort invested ? I
doubt so, it only adds more code to maintain.

> It is very confusing that there is a whole set of displays for imx6/7
> which are supported by upstream but only with a non-default config.
> While it is extremely common in the embedded field to have custom
> configs the default one in the kernel should try to "just work".
> 
> Couldn't this patch series be considered a bugfix? It was also
> surprisingly small.

I think it's just a workaround which allows you to postpone the real
fix, and I don't like that.

-- 
Best regards,
Marek Vasut
