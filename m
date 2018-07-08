Return-Path: <SRS0=ZPnh=JY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99021C3279B
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Jul 2018 17:54:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 45793208CA
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Jul 2018 17:54:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DBZWmPmO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 45793208CA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932681AbeGHRxk (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 8 Jul 2018 13:53:40 -0400
Received: from mail-ua0-f194.google.com ([209.85.217.194]:40688 "EHLO
        mail-ua0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932121AbeGHRxi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Jul 2018 13:53:38 -0400
Received: by mail-ua0-f194.google.com with SMTP id j17-v6so10399303uap.7;
        Sun, 08 Jul 2018 10:53:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=l3Tta6ZdBdKzqyIgVj2RKArlm1QzNFuhdTV5fG8hnzs=;
        b=DBZWmPmOY8eEYSoTAbzOCBKd+vHPWokHlCT2szMmqQ22eJ6DPpLJ8qT67UzWRJCRvR
         1RTBqOLPtJtwRGme7VRiX92Da/KHSoAlUsGhArALCbQuUFQH6KXWcDVgNPMmirjU84x5
         V00gPW5gN21i7wPV6AUPhA8LBLNlpCuwYo5ydXL9/pHBsDqghWn/wcu02RRXxA1vlMD4
         Dfl5M1Ehh4qb7CxoWHSHvp9hdL6Y+gqSGU4WgyiGApnbO6cKaD6yZ9diKh4pCB3ae9qo
         DhH/3biCQIKBctcLDlaouzABZmtzSuD1KA3fdoNw96an6AddN6XimPOl4xYEOadlHanI
         IIyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=l3Tta6ZdBdKzqyIgVj2RKArlm1QzNFuhdTV5fG8hnzs=;
        b=Dt9hnANObmxSXTFHeQyG1eKRBDmcetPgWYKw3ht5ddiyxDsEQCpdfKZ3/dC265m+7y
         ghdMrPYdoYEuWx8+BEc4AAiQooxd2hwtA9OnibQ24b9TwJ95uNtOfIkANihOdKLyr6a0
         oTcCPJtzGVoEaygaaX/G2OYxoGw5x3OkMar+XycHovcJrGuRR7BQizGAV5ePxa9rGVrq
         P2kzA8w/lxjvaQkvlzU7TC9jGd6AgnP/2qftDBoO495Y22wb/0D2+HbFmm5tr1B3Gn49
         GNebtb6lf50Jw8Nsq/jh4eEaQgGBUlD+sUKU8v7ht/R5/GXF6gWrllQ0EQUGbBKagw3s
         ffcg==
X-Gm-Message-State: APt69E1LKudR5aRcxp93WBZqcF0y/s/uregdnRrAAyx6xl2KDqtTj+AD
        LFVohdyA++PsjSg5t0Ev00HZR8+h0h0lIxnKyto=
X-Google-Smtp-Source: AAOMgpeAbnhoZWPnjbnToBL6ZzLJOBquJfM81g17lgOtQB8u7CIASf5lrVbLwvGbCK9oW/JppSi04P3M3j1YLgLIS0E=
X-Received: by 2002:ab0:6037:: with SMTP id n23-v6mr10880631ual.28.1531072417006;
 Sun, 08 Jul 2018 10:53:37 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a67:2149:0:0:0:0:0 with HTTP; Sun, 8 Jul 2018 10:53:36 -0700 (PDT)
In-Reply-To: <82968804b607bf33550ba6fbaebc658db3953804.camel@linux.intel.com>
References: <20180628181906.54910-1-srinivas.pandruvada@linux.intel.com>
 <74ac9bf130074e0a8f86a7904783d091@ausx13mpc120.AMER.DELL.COM>
 <95b3748fcb911c7305bd2bbcfd4e368f044f8b14.camel@linux.intel.com>
 <CAHp75VdX+i_N_GttiL3QZrpivpUeJa0ofGfeJR1FkfuiBWocqA@mail.gmail.com>
 <cc4bc804434a40d9bdd2fa03bbb875aa@ausx13mpc120.AMER.DELL.COM>
 <CAHp75VerxQrPwHTU9PF_q_8xkRm7=cBTPf2tb_5xPEoBQKcL8A@mail.gmail.com>
 <20180706235907.GE3041@fury> <1530935335264.5774@Dell.com>
 <CAHp75VeW9y2z2N7bzwY-kztLvgJYmHECHRF1q5Mr8ude8LOMUQ@mail.gmail.com> <82968804b607bf33550ba6fbaebc658db3953804.camel@linux.intel.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Sun, 8 Jul 2018 20:53:36 +0300
Message-ID: <CAHp75VeUf2m+eRDYzTWL6a8O3+AQV7rs_RzbtmTD5yh+TEQ0cA@mail.gmail.com>
Subject: Re: [PATCH v2] platform/x86: intel-hid: Add support for Device
 Specific Methods
To:     Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc:     Mario Limonciello <Mario.Limonciello@dell.com>,
        Darren Hart <dvhart@infradead.org>,
        Alex Hung <alex.hung@canonical.com>,
        Andy Shevchenko <andy@infradead.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 8, 2018 at 2:37 AM, Srinivas Pandruvada
<srinivas.pandruvada@linux.intel.com> wrote:
> On Sat, 2018-07-07 at 19:24 +0300, Andy Shevchenko wrote:
>> On Sat, Jul 7, 2018 at 6:48 AM,  <Mario.Limonciello@dell.com> wrote:
>> > > I strongly advocate for vendors to have more control over their
>> > > drivers,
>> > > but this scenario really frustrates me. I don't think I can
>> > > justify this
>> > > to Linus as a fix. But before we just say "no" (because hey, I
>> > > want
>> > > these fixes available as early as possible too), let's ask Rafael
>> > > if he
>> > > has an opinion or if there is precedent for this in his
>> > > experience with
>> > > ACPI drivers in general:
>> >
>> > Full disclosure - an updated FW has since been rolled out that
>> > reverted this
>> > behavior back to previous FW behavior due to lack of Linux support
>> > for the
>> > new _DSM.  There is desire to use the new interface (as it did fix
>> > actual
>> > problems with the old one) so at some point it may return.  When
>> > that happens
>> > it would be ideal that people who are (for example) running an LTS
>> > kernel
>> > or distro kernel that tracks stable can pick it up too.
>>
>> I am all for the better user experience and bugs especially in FW
>> should be fixed, but I think to support all kind of behaviour the new
>> FW release should always provide a knob by which we can check if some
>> feature is supported or not.
>>
>> Above sounds to me as mistake in design of the fix.
> The fix here takes care of all the combination. If the new _DSM is
> available, it checks what functionality the _DSM interface can provide
> (Fn 0). For those functionality it gets using _DSM matching new FW
> interface. If there is no _DSM or _DSM doesn't provide the
> functionality or _DSM provided method fails, it still revert to old FW
> interface style using standalone method. Eventually because of
> configurable 5-button array, all platforms will be using new FW
> interface with consideration of backward compatibility.

Srinivas, thanks for elaboration.

-- 
With Best Regards,
Andy Shevchenko
