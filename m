Return-Path: <SRS0=9Qwj=MR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC87CC00449
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 11:49:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C2082064E
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 11:49:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="XQ7rHUVX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9C2082064E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728410AbeJESsG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Oct 2018 14:48:06 -0400
Received: from mail-it1-f196.google.com ([209.85.166.196]:33584 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727798AbeJESsF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Oct 2018 14:48:05 -0400
Received: by mail-it1-f196.google.com with SMTP id h6-v6so4319339ith.0
        for <linux-kernel@vger.kernel.org>; Fri, 05 Oct 2018 04:49:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=RZq83Ola6viygQynR/kntx1CZ7JatAC9FSSODGc94QY=;
        b=XQ7rHUVX1jaOlD1/4nc7VGwubxRH7iHFTQtfssslp/pqHY9Z0wQyIt4Q+91fpEdC+r
         rpdGVw1bNDshv/UcgsO3YinTFHciGjEWqpsZJRtHccafT9KRUkXNPAX80tzh0rUxxEOm
         ChlQcdLyA+U8Da+Tj/GcrlMhQA80pnQ7BhEGA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=RZq83Ola6viygQynR/kntx1CZ7JatAC9FSSODGc94QY=;
        b=KB8oX73vwFJP8wYPpKUIwlowGSTiLvVp3tpMDZGt5DUPDgKOBgpri1puPT+CRa4byL
         mg74TTYj7Uf+PIVNpOUW8Yngcd0IfA0Tc2uO4qcdri38qkEHzvxVbFUFZ/4ttOw+6pWp
         h9T1oW0e/HTmgP7CpBekZqcUEwK2KF6ha3zbN6tEj6dSZ8F3JMkODkEAPFwgQFPwSmeg
         cZRXzVX1sSXClb/UmI2DqI0jRp8I7BXTC6Xivdgh4HHRtbKbQjm9LM0d6GdevhkkvFrS
         eLYdofDPy68xQuJYqvt+P0pTngsIXN50n0T2sTGKh/jPzxBBUI4RRAz8vN34HB2L4L4p
         O0ZA==
X-Gm-Message-State: ABuFfojt/Tma1RY8v3dsz7kBdwAHfPEH6edcsHLcoHyRm3B+O6nHIsNz
        j1xAFkZXpcTyaJ5siia9ukzyi1dyImpvrQfupA8Ixw==
X-Google-Smtp-Source: ACcGV61FnT8NHAAATM6XuF6sYYW8tv+dKQPt36IzyN74DRkVkf9Gz/1mVVvbUhZ44CZ0usqDpaQn8rMDd0iuE6f+1dA=
X-Received: by 2002:a05:660c:243:: with SMTP id t3mr7835431itk.146.1538740180968;
 Fri, 05 Oct 2018 04:49:40 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a02:3941:0:0:0:0:0 with HTTP; Fri, 5 Oct 2018 04:49:00 -0700 (PDT)
In-Reply-To: <20181005104729.GB25651@red-moon>
References: <20181003143824.13059-1-ulf.hansson@linaro.org>
 <CAJZ5v0h7jvoa4oUeM4FgFizF_jbAonoAgP3m417n_TGqfqNsqg@mail.gmail.com>
 <CAPDyKFq0GLs2AMA+6b-Khf+4kGxzVCTvtehp-YmwV2h=_SP4=g@mail.gmail.com>
 <10136406.EY9A7BdqYq@aspire.rjw.lan> <CAJZ5v0iv9OYoaLYHsmdp2xbDuENPgue_mBgFujdmesnBOegRKQ@mail.gmail.com>
 <20181004155755.GD5233@e107981-ln.cambridge.arm.com> <CAJZ5v0j+W2CHiqkniXNJgZ3DU9pOpd_83Wj9Egwf+pVkRCjZLg@mail.gmail.com>
 <20181004172109.GA16878@red-moon> <CAPDyKFrWzDU9BsfAnx7uoaXq=gmGg2r46Mn-cJHSWUk-TmyomA@mail.gmail.com>
 <20181005104729.GB25651@red-moon>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Fri, 5 Oct 2018 13:49:00 +0200
Message-ID: <CAPDyKFquOR91qnTcXU63MBSY6m=uhOw+HpGvy_jiRy6_MO3Lbg@mail.gmail.com>
Subject: Re: [PATCH v9 00/11] PM / Domains: Support hierarchical CPU
 arrangement (PSCI/ARM) (a subset)
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Tony Lindgren <tony@atomide.com>,
        Kevin Hilman <khilman@kernel.org>,
        Lina Iyer <ilina@codeaurora.org>,
        Rob Herring <robh+dt@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5 October 2018 at 12:47, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com> wrote:
> On Thu, Oct 04, 2018 at 08:36:24PM +0200, Ulf Hansson wrote:
>> On 4 October 2018 at 19:21, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com> wrote:
>> > On Thu, Oct 04, 2018 at 07:07:27PM +0200, Rafael J. Wysocki wrote:
>> >
>> > [...]
>> >
>> >> > > I don't see any dependency there, so I'll queue up the 1-3 in
>> >> > > pm-domains and the 4-6 in pm-cpuidle.
>> >> >
>> >> > I do not see why we should merge patches 4-6 for v4.20; they add legacy
>> >> > (DT bindings and related parsing code) with no user in the kernel; we
>> >> > may still want to tweak them, in particular PSCI DT bindings.
>> >>
>> >> My impression was that 4-6 have been agreed on due to the ACKs they
>> >> carry.  I'll drop them if that's not the case.
>> >
>> > I have not expressed myself correctly: they have been agreed (even
>> > though as I said they may require some tweaking) but I see no urgency
>> > of merging them in v4.20 since they have no user. They contain DT
>> > bindings, that create ABI/legacy, I think it is better to have code
>> > that uses them in the kernel before merging them and creating a
>> > dependency that is not needed.
>>
>> There is already code using the new bindings, for the idle states.
>> Please have look at patch 5, 6 and 11.
>
> I had a look before replying and I reiterate the point, there is
> no reason to merge those patches without the rest of the series,
> none. There is already a way to describe idle states in the kernel
> and it works very well, we will add one when we need it not before.

Okay, let's defer them.

>
>> Moreover, you have had plenty on time to look at the series, as those
>> patches haven't changed since a very long time.
>
> So ?
>
>> May I suggest you do the review instead, so we can move things
>> forward, please. The changes in the v9 series should be trivial to
>> review.
>
> There is no reason to merge patches [4, 5, 6, 10] stand-alone, they
> are not solving any problem and they do not provide any benefit
> other than adding useless ABI/legacy, they make sense when we look
> at the whole series.

Okay, let's defer them.

>
>> >> > Likewise, it makes no sense to merge patches 7-8 without the rest of
>> >> > the PSCI patches.
>>
>> Well, those patches are part of this series, because Mark wanted me to
>> move the files. Is really such a big deal? I think it makes sense, no
>> matter what happens afterwards.
>
> We can merge patches [7-8] even if there is no urgency at all to do so,
> usually PSCI patches go via arm-soc whose patches queue is now closed
> and I do not think that's a problem at all.

Okay, let's defer them.

That said, can please review the patches?

Kind regards
Uffe
