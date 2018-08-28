Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE3D0C433F4
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 21:13:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A0502087B
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 21:13:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="K+y/pi44"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5A0502087B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727470AbeH2BG6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 21:06:58 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:46631 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727098AbeH2BG6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 21:06:58 -0400
Received: by mail-pl1-f193.google.com with SMTP id a4-v6so1255755plm.13
        for <linux-kernel@vger.kernel.org>; Tue, 28 Aug 2018 14:13:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=e7VINsH8koltelR+yCyoQDvGAQJrwWmKRgn67eGDey0=;
        b=K+y/pi447OAs4226ChuwMwGW1btAegKpfr8l8CD/yzbDe+3fgOZZnBW2bKxeTCPp3h
         cZiBoD3CZ4HeNhoMjsqoEdwvc9lURf8Mb/K9VhoSTCyNEADjJieSQ5UkCBlr+gp83Irt
         yv1Xu9wUwgA01mP5ce7eStpm+XaPys3xx9q0c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=e7VINsH8koltelR+yCyoQDvGAQJrwWmKRgn67eGDey0=;
        b=pTjXlMVwxFa20BwosYPQaj3C3kckklLEdsJOgem1Qd85mYranfL3THREezLxDfef9z
         gMNqpV3uvaGW9f2lIiGmhuFox8Rp97KUHUL5WcG85fZ5cRIG8DTiYaI9iQBUaBjGdkRq
         BUTdvBHzi96mw+JbA2rbBVsCnjc/MO4zwppH1W2o8CN3NGR4xF70dcVGNyjnXLEmeDNc
         GrSyO0qzzauFMiUHcFBLHw+NqnVKxEf7hbBBsQRmdzqgxD2nvCtwoPvSwExdUWT3SU/n
         TMiRr+DMGMHRWLmYgHNPtFMLLUOycSpZeae2f7M1/ILmqhiib5hyxz9kPZaRjcOqxRgf
         hApg==
X-Gm-Message-State: APzg51ANSOD46uzx7cflmkKrbexmUa+Ej0MsON/2mM87/vhMoZ8UGL6w
        cay95BJHUSJIqlSSxTrXTEbTOg==
X-Google-Smtp-Source: ANB0VdZjXGcsb7o0Qlmw4ue3RUgvSN0m/uohXauWX8D7mc3q3Us6Rx5F4avu2EFJIOy+H2qg58Wf2Q==
X-Received: by 2002:a17:902:934c:: with SMTP id g12-v6mr3102508plp.67.1535490809579;
        Tue, 28 Aug 2018 14:13:29 -0700 (PDT)
Received: from minitux (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id i1-v6sm5979332pgj.38.2018.08.28.14.13.28
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 28 Aug 2018 14:13:28 -0700 (PDT)
Date:   Tue, 28 Aug 2018 14:13:26 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Jacek Anaszewski <jacek.anaszewski@gmail.com>
Cc:     Baolin Wang <baolin.wang@linaro.org>, Pavel Machek <pavel@ucw.cz>,
        rteysseyre@gmail.com, Mark Brown <broonie@kernel.org>,
        Linux LED Subsystem <linux-leds@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v5 1/2] leds: core: Introduce LED pattern trigger
Message-ID: <20180828211326.GI2523@minitux>
References: <1dc5d394324b2bf1ffe229b8e42691fab6d749e0.1533556992.git.baolin.wang@linaro.org>
 <c18fd41f-831c-ab74-57e5-d4151f4b47cc@gmail.com>
 <20180824101145.GA1510@amd>
 <9bb7ac19-36a6-d11a-6d46-fc65c2026201@gmail.com>
 <20180824201227.GB17146@amd>
 <f5046e2d-9f15-4b7e-083e-e97f7ca0693c@gmail.com>
 <CAMz4kuLubD6v1+zmjuKtBL4geBk4ofBdkMy+v8x0K5g_L0otqQ@mail.gmail.com>
 <52eb7b5f-a405-06d1-2758-f27401a3ce3b@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <52eb7b5f-a405-06d1-2758-f27401a3ce3b@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 28 Aug 13:25 PDT 2018, Jacek Anaszewski wrote:

> On 08/25/2018 09:51 AM, Baolin Wang wrote:
> > On 25 August 2018 at 04:44, Jacek Anaszewski <jacek.anaszewski@gmail.com> wrote:
> >> On 08/24/2018 10:12 PM, Pavel Machek wrote:
> >>> On Fri 2018-08-24 21:49:50, Jacek Anaszewski wrote:
> >>>> Hi Pavel,
> >>>>
> >>>> On 08/24/2018 12:11 PM, Pavel Machek wrote:
> >>>>> Hi!
> >>>>>
> >>>>>> I think that it would be more flexible if software pattern fallback
> >>>>>> was applied in case of pattern_set failure. Otherwise, it would
> >>>>>> lead to the situation where LED class devices that support hardware
> >>>>>> blinking couldn't be applied the same set of patterns as LED class
> >>>>>> devices that don't implement pattern_set. The latter will always have to
> >>>>>> resort to using software pattern engine which will accept far greater
> >>>>>> amount of pattern combinations.
> >>>>>>
> >>>>>> In this case we need to discuss on what basis the decision will be
> >>>>>> made on whether hardware or software engine will be used.
> >>>>>>
> >>>>>> Possible options coming to mind:
> >>>>>> - an interface will be provided to determine max difference between
> >>>>>>   the settings supported by the hardware and the settings requested by
> >>>>>>   the user, that will result in aligning user's setting to the hardware
> >>>>>>   capabilities
> >>>>>> - the above alignment rate will be predefined instead
> >>>>>> - hardware engine will be used only if user requests supported settings
> >>>>>>   on the whole span of the requested pattern
> >>>>>> - in each of the above cases it would be worth to think of the
> >>>>>>   interface to show the scope of the settings supported by hardware
> >>>>>
> >>>>> I'd recommend keeping it simple. We use hardware engine if driver
> >>>>> author thinks pattern is "close enough".
> >>>>
> >>>> The thing is that in the ledtrig-pattern v5 implementation there
> >>>> is no option of using software fallback if pattern_set op
> >>>> is initialized:
> >>>>
> >>>> +    if (led_cdev->pattern_set) {
> >>>> +            return led_cdev->pattern_set(led_cdev, data->patterns,
> >>>> +                                         data->npatterns, data->repeat);
> >>>> +    }
> >>>
> >>> Yeah, that sounds wrong. (Sorry I did not pay enough attention).
> >>>
> >>> It pattern_set() returns special error code, it should just continue
> >>> and use software pattern fallback.
> >>
> >> And now we can get back to the issue I was concerned about in the
> >> email you replied to, i.e. what series of [brightness delta_t] tuples
> >> should be written to the pattern file to enable hardware breathing
> >> engine.
> > 
> > OK. So now we've made a consensus to use the software pattern fallback
> > if failed to set hardware pattern. How about introduce one interface
> > to convert hardware patterns to software patterns if necessary?
> > 
> > diff --git a/drivers/leds/trigger/ledtrig-pattern.c
> > b/drivers/leds/trigger/ledtrig-pattern.c
> > index 63b94a2..d46a641 100644
> > --- a/drivers/leds/trigger/ledtrig-pattern.c
> > +++ b/drivers/leds/trigger/ledtrig-pattern.c
> > @@ -66,8 +66,15 @@ static int pattern_trig_start_pattern(struct
> > pattern_trig_data *data,
> >                 return 0;
> > 
> >         if (led_cdev->pattern_set) {
> > -               return led_cdev->pattern_set(led_cdev, data->patterns,
> > -                                            data->npatterns, data->repeat);
> > +               ret = led_cdev->pattern_set(led_cdev, data->patterns,
> > +                                           data->npatterns, data->repeat);
> > +               if (!ret)
> > +                       return 0;
> > +
> > +               dev_warn(led_cdev->dev, "Failed to set hardware pattern\n");
> > +
> > +               if (led_cdev->pattern_convert)
> > +                       led_cdev->pattern_convert(led_cdev,
> 
> I can't see how it could help to assess if hw pattern
> engine can launch given pattern, and with what accuracy.
> 
> Instead, I propose to add a means for defining whether the pattern
> to be set is intended for hardware pattern engine or for software
> fallback. It could be either separate sysfs file e.g. hw_pattern,
> or a modifier to the pattern written to the pattern file, e,g,
> 
> echo "hw 100 2 200 3 100 2" > pattern
> 
> hw format expected by given driver would have to be described
> in the per-driver ABI documentation. All patterns without
> "hw" prefix would enable software pattern engine.
> 

We started this discussion with the suggestion that rather than
introducing a new Qualcomm specific sysfs interface for controlling the
pattern engine we should have a common one, but if I understand your
suggestion we should not have a common interface, just a common sysfs
file name?

Regards,
Bjorn
