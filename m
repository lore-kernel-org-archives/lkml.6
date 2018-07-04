Return-Path: <SRS0=cgxA=JU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9677FC3279B
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 20:17:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 48F7A241F0
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 20:17:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hj26vIXq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 48F7A241F0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753068AbeGDURi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Jul 2018 16:17:38 -0400
Received: from mail-vk0-f66.google.com ([209.85.213.66]:46369 "EHLO
        mail-vk0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752874AbeGDURg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jul 2018 16:17:36 -0400
Received: by mail-vk0-f66.google.com with SMTP id b14-v6so3658429vke.13;
        Wed, 04 Jul 2018 13:17:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=qybflPsN6kGJ+bgC3aHCtFi0PS0cNdNZq5H1lpqwMK4=;
        b=hj26vIXqzSRSi+L5IFA3JW2xhDt7au8ZbGSNV3bqkpw0pQ8E05rhOvs16lnXvecT7J
         1leXzEYDo630OeQBWW9w6pLXPn8GJTBoJKB+er7PW8PYXkuxKmzLNjpOnq2LvCNfjtCU
         gcKhoQfiARbIuC7+EsqvQU44Pv3em/hKzl8xS7SEXgjJm5GiaTVqOUU7Q6soAIZZ3IKB
         YfLbQQtIBGGFRGBciOWdCBsyxdNP+qXUK+ignI1XL4W0o9/VwwQJm35Fk4/FkQWCPwr0
         R2iDFlFL7wN4UYso/lbaPDMsPjjVtK79qry0ohPCzgdxB8JHF07aSZ8V1lkQzf3HY/IC
         Uevg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=qybflPsN6kGJ+bgC3aHCtFi0PS0cNdNZq5H1lpqwMK4=;
        b=gCiJSY+PdT2HNrJEWmJ6R1KV8uWMjlTnA8JusUWwfyYp1d7h06+hyIUxyIFISfx7FJ
         R9hnhj4riYhehETDV2TQpRUSaHWj204F/tXlRBaOkP201QpxAHxLGUcj5dlRJMGcKB9x
         /JzS3Is3KMsw23oRPi+NO9btE5gtBGAdVdxyCJ++ANxAs2W0pGJljsaf1aHgszfSkgZ/
         cqIhPbGPxfbJK0Za6y9aQe98xw9gkDf1G38II2ulkQUL8TOoMI52W9NaFkoMrOaT+c0l
         KlUT8h55BcOnpg77orBrM+6wmHIDtXBq4akLfqo4ES26b3u9Z7WrHxhPlD9yjKBJj2fC
         zuVA==
X-Gm-Message-State: APt69E2copSiFtT4eTxpreEFMP5hxFBNQR5LJAzHlrj0x2SBmQxSKG/+
        +rgoLYmC5GViam/6R0e1tOrsk0uAJcmRqvG6CTs=
X-Google-Smtp-Source: AAOMgpevwyiBB3gdW+aKP8MvYI9yG+wcUUcXTSci8mXdWWWs59mKXM8WJE/Q4HK0soLQzQTvMc8+svbCjxvJACgfa3k=
X-Received: by 2002:a1f:7d09:: with SMTP id y9-v6mr1846448vkc.15.1530735456059;
 Wed, 04 Jul 2018 13:17:36 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a67:2149:0:0:0:0:0 with HTTP; Wed, 4 Jul 2018 13:17:35 -0700 (PDT)
In-Reply-To: <fda04867-b470-5266-65db-edb90023f8dc@landley.net>
References: <62fb47ea-9296-139b-1eeb-28ddc5826091@landley.net>
 <CAHp75Vc+2rjFcLfuV5ao0eGmz2aF4jRS_YTZQTaRx=45sOSFOw@mail.gmail.com>
 <CAHp75VdEUquwcd3_OxbHAK+gOCnpff_Fd91jkHx87XKkD2xwKQ@mail.gmail.com> <fda04867-b470-5266-65db-edb90023f8dc@landley.net>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 4 Jul 2018 23:17:35 +0300
Message-ID: <CAHp75VdLpDSS9M_y=DhcCCJW1bZA7TXpSVaairbGCPxtiyiwMA@mail.gmail.com>
Subject: Re: [PATCH] Fix platform data in leds-pca955x.c
To:     Rob Landley <rob@landley.net>
Cc:     clg@kaod.org, Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Pavel Machek <pavel@ucw.cz>, Andrew Jeffery <andrew@aj.id.au>,
        Linux LED Subsystem <linux-leds@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 4, 2018 at 9:09 PM, Rob Landley <rob@landley.net> wrote:
> On 07/04/2018 12:04 PM, Andy Shevchenko wrote:
>> On Wed, Jul 4, 2018 at 8:00 PM, Andy Shevchenko
>> <andy.shevchenko@gmail.com> wrote:
>>> On Wed, Jul 4, 2018 at 3:46 AM, Rob Landley <rob@landley.net> wrote:
>>
>>> For now, you can switch to unified device properties API (basically
>>> un-ifdef pca955x_pdata_of_init() and replacing of_* by device_* or
>>> fwnode_* compatible calls) and providing a static table of built-in
>>> device properties in the platform code in question.
>>> (see include/linux/property.h, for example users of
>>> PROPERTY_ENTRY_U*() macros, like arch/arm/mach-pxa/raumfeld.c)
>>
>> Taking into consideration that device is enumerated by i2c core, which
>> is being aware of device properties (1), better example might be
>> drivers/platform/x86/intel_cht_int33fe.c
>
> This file doesn't include the word "LED".

Should it?
You seems missed a point completely.

>
>   $ grep -i led drivers/platform/x86/intel_cht_int33fe.c
>   $
>
> Examining it... this is an ACPI driver, Intel's Not-Invented-Here proprietary
> device tree.

Huh?!

> So I should convert an sh7760 board to ACPI?

NO! (Of cource if you have ACPI ID and meaning of that device on ACPI
enabled platform, then it's your choice)

>  How would this fix the problem
> where the driver's probe function expects a structure as input that is locally
> defined, instead of the generic structure from linux/leds.h it used to accept?

You missed a point.

> If we feed the probe function NULL platform data _and_ don't have device tree
> enabled, doesn't it error out?

No.

-- 
With Best Regards,
Andy Shevchenko
