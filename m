Return-Path: <SRS0=SIc1=KP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3074AC43142
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 15:10:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B47D2208A4
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 15:10:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T7MSL/Zb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B47D2208A4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732472AbeGaQv3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Jul 2018 12:51:29 -0400
Received: from mail-vk0-f68.google.com ([209.85.213.68]:45443 "EHLO
        mail-vk0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731516AbeGaQv3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jul 2018 12:51:29 -0400
Received: by mail-vk0-f68.google.com with SMTP id b78-v6so7678579vka.12;
        Tue, 31 Jul 2018 08:10:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=aD2l1IBkZk50SG8tXQPKO6xM9pTI9kVsAgBH2u29HCM=;
        b=T7MSL/ZbSgVsuR0YQzLqLlWt9YQGkBY58Zn1YkjaEDWVi3wzPBWg3u0+xHbwhjkIRX
         uBKfJNB97ua4/fQVqjMym0WDE6tPJ9UWMh0NfxIQaeiUA6C78KJYfKu4aPkJKqRIrYDk
         HzZYJI10TyQkT3F739hdsEE5+rTBXmz45Cp6iFedk23bmNSv6n8ayRH6Z32mOaj267rX
         NQlYY5lc6P75TXLQpqLMN9ZAlu/mZMSbqpirizJpUyHtDj4MWO1iaonnTM0noO6vzR6J
         NiJLhfvFUVxD4eAHpVcN6swL7imSbGK2SL5cM8gew8QSVjlpQY0cCt+lbdlaXT4W+oUK
         7m+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=aD2l1IBkZk50SG8tXQPKO6xM9pTI9kVsAgBH2u29HCM=;
        b=mFz8pQoL7qxU94X/siZs+GM85Jd+mR2GzusNxqwvqdacqJS7PgYvrT8hwGsMZrQBba
         ePdWxSE+9WKtanCnydBMqICLCKze9W/Qgu/cyt+BNTVKLFRnYZ5FPhT0yfu86dXyzr8s
         oRZu+erClvVE54OMCCAft67TQi1bZS73MNis49CdJO2noZMvhfN8whPvpkhcEyehQmV4
         CF1wTEPjZn0ani5F2kwHzfdAXwip/zdoWmxjQUrIpaCIAS9DJZgBGvhxLcwY2+5DYDPK
         db+dedEeVl6IMOuf2O/aaYNiSSDo8bspgVSAUlRJZYExRCzBJCr8X2A+A2ccuTrDXyeq
         zIuA==
X-Gm-Message-State: AOUpUlFQWCtvQSTZGgNsRbfCpeKQWcJsOQR7rRBU5doxbcphLJ54uakF
        V7eMORru88f7jc+xR/p72cNBtTx5PdvOySpA6UY=
X-Google-Smtp-Source: AAOMgpccE0AcQX6E9E+oV4Y03/EySWaorwJNgMgO23FG2Wgrt1qntF9j081580PxCtztcn0J/wmR26EPYlVRnSW/of0=
X-Received: by 2002:a1f:c884:: with SMTP id y126-v6mr13246624vkf.76.1533049843129;
 Tue, 31 Jul 2018 08:10:43 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a67:2149:0:0:0:0:0 with HTTP; Tue, 31 Jul 2018 08:10:42
 -0700 (PDT)
In-Reply-To: <0cc13519-2a5d-e6a9-9fd0-17fd6bb119b0@redhat.com>
References: <20180731093256.30533-1-youling257@gmail.com> <CAHp75Vfp+EZjt_bg3iieKG0NPBvqzURXKh97D4=ULrKnbE4mvQ@mail.gmail.com>
 <0cc13519-2a5d-e6a9-9fd0-17fd6bb119b0@redhat.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 31 Jul 2018 18:10:42 +0300
Message-ID: <CAHp75VfU_720wPNuh8=9DKYGGdWhu6hMxBxD50p2UGbiNp6P_Q@mail.gmail.com>
Subject: Re: [PATCH] platform/x86: touchscreen_dmi: Add info for the Cube
 KNote i1101 tablet
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     youling257 <youling257@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        linux-input <linux-input@vger.kernel.org>,
        Andy Shevchenko <andy@infradead.org>,
        Darren Hart <dvhart@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 31, 2018 at 2:53 PM, Hans de Goede <hdegoede@redhat.com> wrote:
> Hi,
>
> On 31-07-18 13:32, Andy Shevchenko wrote:
>>
>> On Tue, Jul 31, 2018 at 12:32 PM, youling257 <youling257@gmail.com> wrote:
>>>
>>> Add touchscreen info for the Cube KNote i1101 tablet.
>>>
>>
>> Thanks for the patch.
>> Unfortunately I can't take it w/o SoB line. If Hans volunteering to
>> give a such again, I guess we're fine.
>
>
> Yes you can add my:
>
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
>
> Like last time, or do you want me to resend this with it added?

I'll use it as Author, no need to resubmit, thanks!

>
> Regards,
>
> Hans
>
>
>
>>
>>> Reported-and-tested-by: lkongl <lkongl@163.com>
>>> ---
>>>   drivers/platform/x86/touchscreen_dmi.c | 26 ++++++++++++++++++++++++++
>>>   1 file changed, 26 insertions(+)
>>>
>>> diff --git a/drivers/platform/x86/touchscreen_dmi.c
>>> b/drivers/platform/x86/touchscreen_dmi.c
>>> index 85e425420da2..cb204f973491 100644
>>> --- a/drivers/platform/x86/touchscreen_dmi.c
>>> +++ b/drivers/platform/x86/touchscreen_dmi.c
>>> @@ -117,6 +117,22 @@ static const struct ts_dmi_data cube_iwork8_air_data
>>> = {
>>>          .properties     = cube_iwork8_air_props,
>>>   };
>>>
>>> +static const struct property_entry cube_knote_i1101_props[] = {
>>> +       PROPERTY_ENTRY_U32("touchscreen-min-x", 20),
>>> +       PROPERTY_ENTRY_U32("touchscreen-min-y",  22),
>>> +       PROPERTY_ENTRY_U32("touchscreen-size-x", 1961),
>>> +       PROPERTY_ENTRY_U32("touchscreen-size-y", 1513),
>>> +       PROPERTY_ENTRY_STRING("firmware-name",
>>> "gsl3692-cube-knote-i1101.fw"),
>>> +       PROPERTY_ENTRY_U32("silead,max-fingers", 10),
>>> +       PROPERTY_ENTRY_BOOL("silead,home-button"),
>>> +       { }
>>> +};
>>> +
>>> +static const struct ts_dmi_data cube_knote_i1101_data = {
>>> +       .acpi_name      = "MSSL1680:00",
>>> +       .properties     = cube_knote_i1101_props,
>>> +};
>>> +
>>>   static const struct property_entry dexp_ursus_7w_props[] = {
>>>          PROPERTY_ENTRY_U32("touchscreen-size-x", 890),
>>>          PROPERTY_ENTRY_U32("touchscreen-size-y", 630),
>>> @@ -458,6 +474,16 @@ static const struct dmi_system_id
>>> touchscreen_dmi_table[] = {
>>>                          DMI_MATCH(DMI_BOARD_NAME, "Cherry Trail CR"),
>>>                  },
>>>          },
>>> +       {
>>> +               /* Cube KNote i1101 */
>>> +               .driver_data = (void *)&cube_knote_i1101_data,
>>> +               .matches = {
>>> +                       DMI_MATCH(DMI_BOARD_VENDOR, "Hampoo"),
>>> +                       DMI_MATCH(DMI_BOARD_NAME, "L1W6_I1101"),
>>> +                       DMI_MATCH(DMI_SYS_VENDOR, "ALLDOCUBE"),
>>> +                       DMI_MATCH(DMI_PRODUCT_NAME, "i1101"),
>>> +               },
>>> +       },
>>>          {
>>>                  /* DEXP Ursus 7W */
>>>                  .driver_data = (void *)&dexp_ursus_7w_data,
>>> --
>>> 2.18.0
>>>
>>
>>
>>
>



-- 
With Best Regards,
Andy Shevchenko
