Return-Path: <SRS0=dgVt=LA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F17FC4321D
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 11:28:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E2CF8218F9
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 11:28:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nB/9WBTm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E2CF8218F9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726797AbeHQObF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Aug 2018 10:31:05 -0400
Received: from mail-qk0-f193.google.com ([209.85.220.193]:39587 "EHLO
        mail-qk0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726134AbeHQObE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Aug 2018 10:31:04 -0400
Received: by mail-qk0-f193.google.com with SMTP id b5-v6so5973578qkg.6;
        Fri, 17 Aug 2018 04:27:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=R7Cq1AyihqijtNIh+v9vNBKeOWDaBGIteH9zWfeiUd0=;
        b=nB/9WBTmYdY2Wuvx5WBzZGz1YMnLQI5DZoNQvEeKdY6T3lJCTuUFb6h/PbgihzmcRq
         QjXPAxjkU1IKnV1YWQHcNNSwHHGYWCOM1Lrwd0XtqwfhI85jU3HTQxhgRVWXd26qV4Kg
         LdDqYQ0VHhuZnUJIxjtF6xziCV/4EgGvP9vk1bHXJ9LmJ6QBHY7iXvS73+3b2c2Y0s5p
         hNJjar9nvr0wOwYQI5OIM+rwUKX2EpaFbcFbOhLwfHfjIiplMroDgKB9g950rQPPiZa3
         oA3+QVsify+Jld5ztGtylSBNPDezzKmaBr3uWv0yif0Zepu985DVmE1wzfJpcENrx2hi
         c9RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=R7Cq1AyihqijtNIh+v9vNBKeOWDaBGIteH9zWfeiUd0=;
        b=EYl1EwzkPz29hL7vTD5sRuHxFRqS3ug0L849LeWtuJwMiUQMvW3kW1rrNAxvlMkauF
         3+OOUGBcLSNlFfF56n3qmFktk4Mbatbi6igN0u1TMq3mLsETneVyTiFi/AdqeXc6YAsC
         4oiOoK9zqDhRllGepRu2ZQCI6Bd+/1wu7Wm6dW7TF/A2cmel5bPA6y3OnudWXs95iPv+
         Zc7m8X3n51XcUBaTa4qyifI67SeBZ+60oApUv+zEZrSJMelHMGqZPKd7o//0Cw0kC1+N
         hEe+ttM35mS+ahkyT1xJ7XODA/DNkQ06eYLT/thhTzlzaQL2m65lOcdQbgvP8v3TZrkK
         QcAQ==
X-Gm-Message-State: AOUpUlFkplLUUuNM70C1tAxD2L3F6AW901u+mDzpfPai9bKul8yoIQJF
        aTg2N3ktDlrN2A/ELL0q6fyw9uTTYGWPJ+IhgYg=
X-Google-Smtp-Source: AA+uWPzqOFHwOPAKCpU67NFJxh187PVqZJ8pGJZyt1eJDARaFb6Gt5NPiqJPFh4pWAc/YzstM8YvpUzVeVcwA9ro3t8=
X-Received: by 2002:a37:7004:: with SMTP id l4-v6mr29871068qkc.83.1534505278178;
 Fri, 17 Aug 2018 04:27:58 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a0c:9c4a:0:0:0:0:0 with HTTP; Fri, 17 Aug 2018 04:27:57
 -0700 (PDT)
In-Reply-To: <6a2826055a33cbca45c3e8e03b1b0935b9f1d1af.camel@kernel.crashing.org>
References: <7ccdc39d7e255547e851497ef9f449715b45f8bd.camel@kernel.crashing.org>
 <CAHp75Vd1ZZDJtASfFpr=eE+zaEiOxH3ohdSOe1aTcE3qEMd_QA@mail.gmail.com>
 <CAHp75VfjZe7XqJjv0CYFHXi95_v7R9B9E9eix+0xRwqn2tq6nQ@mail.gmail.com> <6a2826055a33cbca45c3e8e03b1b0935b9f1d1af.camel@kernel.crashing.org>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Fri, 17 Aug 2018 14:27:57 +0300
Message-ID: <CAHp75VfeLf39vVd37W=2V-fJiSs=5zoKMxYS2g4o_mTn3GBjiQ@mail.gmail.com>
Subject: Re: [PATCH] platform/x86: acer-wmi: Silence "unsupported" message a bit
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc:     "Lee, Chun-Yi" <jlee@suse.com>, Darren Hart <dvhart@infradead.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 17, 2018 at 2:22 PM, Benjamin Herrenschmidt
<benh@kernel.crashing.org> wrote:
> On Fri, 2018-08-17 at 14:09 +0300, Andy Shevchenko wrote:
>> On Fri, Aug 17, 2018 at 2:07 PM, Andy Shevchenko
>> <andy.shevchenko@gmail.com> wrote:
>> > On Thu, Aug 16, 2018 at 2:27 AM, Benjamin Herrenschmidt
>> > <benh@kernel.crashing.org> wrote:
>> > > This driver prints that "Unsupported machine..." message on every boot on
>> > > ThinkPad X1 Carbon laptops (and I assume a number of other systems), which
>> > > causes graphical boots to "glitch" a bit and is rather annoying ...
>> > >
>> > > Make it a pr_debug instead.
>> >
>> > Thanks for the patch. Unfortunately it doesn't apply.
>> > Please, check your mail clients and tools for formatting patch (it
>> > produced at the end spaces instead of tabs)
>>
>> No need to resend _this_ time. I have pushed to my review and testing queue.
>
> Thanks, odd. Not sure what's going on with the latest evolution, it's
> the second time it's done this. I'll try to investigate. Small patch
> like that I tend to just copy/paste in an email in "preformat" style
> ;-)

Evolution is totally broken for years already (yes, I'm still using it
due to Outlook Web Services support, but it's utter PITA).
I could just easily come up with couple of dozens of bugs that are
present there for more than 3 years.

>
> Cheers,
> Ben.
>>
>> > >
>> > > Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
>> > > ---
>> > >
>> > > diff --git a/drivers/platform/x86/acer-wmi.c b/drivers/platform/x86/acer-wmi.c
>> > > index 8952173dd380..7f7192e8fdab 100644
>> > > --- a/drivers/platform/x86/acer-wmi.c
>> > > +++ b/drivers/platform/x86/acer-wmi.c
>> > > @@ -2216,7 +2216,7 @@ static int __init acer_wmi_init(void)
>> > >         if (wmi_has_guid(AMW0_GUID1) &&
>> > >             !dmi_check_system(amw0_whitelist) &&
>> > >             quirks == &quirk_unknown) {
>> > > -               pr_err("Unsupported machine has AMW0_GUID1, unable to load\n");
>> > > +               pr_debug("Unsupported machine has AMW0_GUID1, unable to load\n");
>> > >                 return -ENODEV;
>> > >         }
>> > >
>> > >
>> >
>> >
>> >
>> > --
>> > With Best Regards,
>> > Andy Shevchenko
>>
>>
>>
>



-- 
With Best Regards,
Andy Shevchenko
