Return-Path: <SRS0=n7Wc=J2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C346C3279B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 09:06:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3DC712089B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 09:06:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=agner.ch header.i=@agner.ch header.b="KkeQzKnR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3DC712089B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=agner.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751297AbeGJJGn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Jul 2018 05:06:43 -0400
Received: from mail.kmu-office.ch ([178.209.48.109]:58140 "EHLO
        mail.kmu-office.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751182AbeGJJGk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jul 2018 05:06:40 -0400
Received: from webmail.kmu-office.ch (unknown [IPv6:2a02:418:6a02::a3])
        by mail.kmu-office.ch (Postfix) with ESMTPSA id EC7425C0634;
        Tue, 10 Jul 2018 11:06:37 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agner.ch; s=dkim;
        t=1531213597;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/Ppx9e/3iESTYls19aT3EcPKSQ5uAmlll3vSYRTOmpg=;
        b=KkeQzKnRNIfEng83gJ5/TsCf1Ejagkfer7w7q04svTjz1TYaadTc81cm5Xqgfym0XA3zHz
        0YXIpmYRYkHztJ9HHz7szTjKEuo8JB69AJ9eH8iEuIkKgqJjZK0Yd7KcFBXoNwMJy73Kqp
        Y2623IF+pGCjiD8rYwEuPSn4d1txv/E=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Date:   Tue, 10 Jul 2018 11:06:36 +0200
From:   Stefan Agner <stefan@agner.ch>
To:     Marek Vasut <marek.vasut@gmail.com>
Cc:     Leonard Crestez <leonard.crestez@nxp.com>, festevam@gmail.com,
        marex@denx.de, shawnguo@kernel.org, devicetree@vger.kernel.org,
        linux-fbdev@vger.kernel.org, marcofrk@gmail.com,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        dl-linux-imx <linux-imx@nxp.com>, kernel@pengutronix.de,
        Fabio Estevam <fabio.estevam@nxp.com>,
        linux-arm-kernel@lists.infradead.org, l.stach@pengutronix.de
Subject: Re: [PATCH 1/3] drm: mxsfb: Change driver.name to mxsfb-drm
In-Reply-To: <6995fa4b-47a9-887b-5e4f-4284ca6a2c79@gmail.com>
References: <cover.1529091248.git.leonard.crestez@nxp.com>
 <47ea7572011735b68a8a70f0e11bdf00cb2fd86a.1529091248.git.leonard.crestez@nxp.com>
 <CAOMZO5B8i0gN+rCq-yPrd112NkwJWTxYCtsLVeLhD1JLRuX6EQ@mail.gmail.com>
 <07be6d9a85b6be655fc2b084be81d8bf9715b57a.camel@nxp.com>
 <638457fd-85da-8fec-d146-517c43f71813@denx.de>
 <b3fa74c5110b45e5992920485749869ab1f7ebce.camel@nxp.com>
 <6995fa4b-47a9-887b-5e4f-4284ca6a2c79@gmail.com>
Message-ID: <fd22085f646d97f66cff5b7f22785500@agner.ch>
X-Sender: stefan@agner.ch
User-Agent: Roundcube Webmail/1.3.4
X-Spamd-Result: default: False [-0.36 / 15.00];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         MID_RHS_MATCH_FROM(0.00)[];
         RCPT_COUNT_TWELVE(0.00)[15];
         TAGGED_RCPT(0.00)[];
         MIME_GOOD(-0.10)[text/plain];
         FROM_HAS_DN(0.00)[];
         FROM_EQ_ENVFROM(0.00)[];
         DKIM_SIGNED(0.00)[];
         TO_DN_SOME(0.00)[];
         RCVD_COUNT_ZERO(0.00)[0];
         ASN(0.00)[asn:29691, ipnet:2a02:418::/29, country:CH];
         RCVD_TLS_ALL(0.00)[];
         BAYES_HAM(-0.26)[73.58%];
         ARC_NA(0.00)[]
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16.06.2018 01:32, Marek Vasut wrote:
> On 06/16/2018 12:42 AM, Leonard Crestez wrote:
>> On Fri, 2018-06-15 at 23:36 +0200, Marek Vasut wrote:
>>> On 06/15/2018 10:58 PM, Leonard Crestez wrote:
>>>> On Fri, 2018-06-15 at 16:47 -0300, Fabio Estevam wrote:
>>>>> On Fri, Jun 15, 2018 at 4:43 PM, Leonard Crestez
>>>>> <leonard.crestez@nxp.com> wrote:
>>
>>>>>> The FBDEV driver uses the same name and both can't be registered at the
>>>>>> same time. Fix this by renaming the drm driver to mxsfb-drm
>>>>>
>>>>> Stefan sent the same patch a few days ago:
>>>>
>>>> In that thread there is a proposal for removing the old fbdev/mxsfb
>>>> driver entirely.
>>>>
>>>> That would break old DTBs, isn't this generally considered bad? Also,
>>>> are we sure the removal of fbdev/mxsfb wouldn't lose any features?
>>>>
>>>> What my series does is make both drivers work with the same kernel
>>>> image and turns the choice into a board-level dtb decision. Supporting
>>>> everything at once seems desirable to me and it allows for a very
>>>> smooth upgrade path.
>>>
>>> Having two drivers in the kernel with different set of bugs is always bad.
>>>
>>>> The old driver could be removed later, after all users are converted.
>>>
>>> Both drivers were in for long enough already. And let's be realistic,
>>> how many MX23/MX28 users of old DTs with new kernels are there who
>>> cannot update the DT as well ?
>>
>> Grepping for "display =" in arch/arm/boot/dts/imx* I see that old
>> bindings are also used by 3rd-party boards for imx6/7:
>>  * imx6sx-nitrogen6sx
>>  * imx6ul-geam
>>  * imx6ul-isiot
>>  * imx6ul-opos6uldev
>>  * imx6ul-pico-hobbit
>>  * imx6ul-tx6ul
>>  * imx7d-nitrogen7
> 
> Er, yes, a handful of boards which could be updated :)
> 
>> Converting everything might be quite a bit of work, and explicitly
>> supporting old bindings is also work.
> 
> Does adding support for old bindings justify the effort invested ? I
> doubt so, it only adds more code to maintain.
> 
>> It is very confusing that there is a whole set of displays for imx6/7
>> which are supported by upstream but only with a non-default config.
>> While it is extremely common in the embedded field to have custom
>> configs the default one in the kernel should try to "just work".
>>
>> Couldn't this patch series be considered a bugfix? It was also
>> surprisingly small.
> 
> I think it's just a workaround which allows you to postpone the real
> fix, and I don't like that.

This is one of the situation where states quo is kinda the worst
situation.

Currently imx_v6_v7_defconfig and mxs_defconfig actually still uses
CONFIG_FB_MXS.

I understand that you'd rather prefer to move forward. I suggest we do
it in steps.

In 4.19:

- Change DRM driver.name to mxsfb-drm so we avoid conflicts for now
- Remove CONFIG_FB_MXS from imx_v6_v7_defconfig/mxs_defconfig now, and
only enable CONFIG_DRM_MXSFB=y
- Add (deprecated) to CONFIG_FB_MXS

In 4.19/4.20:
- Fix the above device trees

In 4.20/4.21:
- Remove FB_MXS

Does that sound reasonable? If yes, I can send the patch set to do step
1.

--
Stefan
