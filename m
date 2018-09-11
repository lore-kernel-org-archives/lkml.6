Return-Path: <SRS0=LZPJ=LZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 478BFC43143
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 01:22:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B44E42086E
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 01:22:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Mh58OZoD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B44E42086E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726517AbeIKGTM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Sep 2018 02:19:12 -0400
Received: from mail-oi0-f68.google.com ([209.85.218.68]:35252 "EHLO
        mail-oi0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726338AbeIKGTM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Sep 2018 02:19:12 -0400
Received: by mail-oi0-f68.google.com with SMTP id m11-v6so44113807oic.2
        for <linux-kernel@vger.kernel.org>; Mon, 10 Sep 2018 18:22:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=bdW+dR3T2tZkUKwqsZtNOS31TIkjDdiGlI9dqF8giL8=;
        b=Mh58OZoDMtHl5elm6/SAWHXWbZTh/UpDUrkw2mfFlylT1NsJX//bE7w8/Srbc8MaLA
         40jj6rA50Pwr9S49+hVc9xkztRVFFZS+C9e/UYtyZR3TVLWa8q5cmp/KdOwIaHS/M3mh
         bfrPBdSMsenwaxyDEiLs6/DQanq4t90YFpq6U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=bdW+dR3T2tZkUKwqsZtNOS31TIkjDdiGlI9dqF8giL8=;
        b=ideMLtrrtdQnRFC2cLATupyxV0IybRPGVXnibuIXYZ+f3P6aly2UTv7WcSZVWPLYl1
         mnOJqrmBujRM4v9uIKPAPZ55DKuBMbuxjWmfb/igyjkAWnyvtBsvHhBtyBAjgbRN49/1
         /n7c0jxx5+SbG+0hEIkfchq+sNEAQdV2EshkWIcCr5lqF5aTOwzWad87WyrIRaua0uUM
         tASbwrJsyrgnPrUBoLsP6xK1e+hN+UgZ2P8/OzoeIxjH0tIkJ5ExzWfKH/Ywvv0QY0L0
         UwDd+toQPRM00dD5WpsTcK3+P2iV2EVz4/ltEHVRux648dRoZd5dCy459+ITST9zy3Kw
         +c8g==
X-Gm-Message-State: APzg51DayXxvjcwITH7SfJSu9GFriBxIKEaK5gG4Ud+NdqXlNELFYsZ/
        WWYXzGjQfMIPhEPYQ7PNqk/ktaD8KjM7FgrkJ8eKGA==
X-Google-Smtp-Source: ANB0VdYoPVvVWd64riN/cUshLaM46OrBCzu4PG2UkNPSt5AjFqy1iPBKOble6KcaAyhOzAdJXoMj63pDdeynObke26w=
X-Received: by 2002:aca:e005:: with SMTP id x5-v6mr24241619oig.328.1536628946816;
 Mon, 10 Sep 2018 18:22:26 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:3ec8:0:0:0:0:0 with HTTP; Mon, 10 Sep 2018 18:22:25
 -0700 (PDT)
In-Reply-To: <20180910212051.GB4697@amd>
References: <5a502ec29251c019ddad8f3314ab45fc0f6feaf7.1536027873.git.baolin.wang@linaro.org>
 <20180908050208.GY2523@minitux> <0190dc10-99a3-abb7-b196-a537c49a2b6e@gmail.com>
 <CAMz4kuK=t9t0nZaVHguv_BVH5WKTDvxPrxCjPrpws9=VV_57ag@mail.gmail.com> <20180910212051.GB4697@amd>
From:   Baolin Wang <baolin.wang@linaro.org>
Date:   Tue, 11 Sep 2018 09:22:25 +0800
Message-ID: <CAMz4ku+Q+hLOOPJ_GFb81gFwAE1=dG=4kVAqZineEA-EETbZXA@mail.gmail.com>
Subject: Re: [PATCH v8 1/2] leds: core: Introduce LED pattern trigger
To:     Pavel Machek <pavel@ucw.cz>
Cc:     Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        rteysseyre@gmail.com, Mark Brown <broonie@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Linux LED Subsystem <linux-leds@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11 September 2018 at 05:20, Pavel Machek <pavel@ucw.cz> wrote:
> Hi!
>
>> >> I'm still convinced that this will confuse our users and to me it would
>> >> be more logical if this denotes the number of times the pattern should
>> >> be repeated, with e.g. negative numbers denoting infinite.
>> >
>> > Sounds reasonable. Let's change this semantics as you propose.
>> >
>> >> In particular I expect to have to explain why my driver expects that you
>> >> write 0 in the file named "repeat" to make it repeat and 1 to make it
>> >> not repeat.
>>
>> Hm, so there are some cases we need to make clear.
>> 1) If negative numbers present infinite, so what's the meaning of number 0?
>> 2) What we should show for users if repeat number is negative, just
>> show negative numbers or one string "infinite"?
>
> I'd say just -1 is infinite, anything else is error.
>
> And yes, reading it should just display -1.

OK. Thanks.

-- 
Baolin Wang
Best Regards
