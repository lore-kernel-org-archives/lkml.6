Return-Path: <SRS0=+sa6=KY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40FFFC46460
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 08:16:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DBFC321B32
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 08:16:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Di/xFYmu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DBFC321B32
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729080AbeHIKkR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Aug 2018 06:40:17 -0400
Received: from mail-oi0-f68.google.com ([209.85.218.68]:34153 "EHLO
        mail-oi0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727237AbeHIKkQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Aug 2018 06:40:16 -0400
Received: by mail-oi0-f68.google.com with SMTP id 13-v6so8454702ois.1;
        Thu, 09 Aug 2018 01:16:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=vhfxA2TCPA+Sx00Yae+Z7Y0iYXgYwlNNNr+5aGetYmk=;
        b=Di/xFYmuGwXeHrxIgCZUPhonspIotZMkvlkB64S+HvCKmv/laZTmwi1latjToREinf
         WjzClsHtutNbV4URe02kXrfX4HHRwq+sjAka4+fLxG9MI03WJ2BZZ+kvyJ0d9gixe9ED
         Niao5yMvnJUpa0n0fL6tvOnZJHsz+USrqVMI2PSbgMoFWkZl4n3c3hYnqfYOlThJMeJc
         b/nDfNsg+a+yXezT7fwpQnw3404UEzGNkp7Gtprbh88tS1S4vAfspYML6Ca/+YnGqSD5
         JL9UQ7wv0e+86I3+edB+iFxmJrY4DG1ageV9QdGEGVM8qXUE4xDyRKlryk7oE4XOOAu3
         zfBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=vhfxA2TCPA+Sx00Yae+Z7Y0iYXgYwlNNNr+5aGetYmk=;
        b=VScgY5SW9RrXADvNhhRPyXMRbyIad6G4KDGf++xIA65VKQCusQuMs5ATdyHQ4Sre7D
         HPO+qiBoZ9YyC3qUBLCrywFgC32Y4wELAkWQLybWaaFMnGmK0YLFJ3669RP4ikdw88bG
         iZkyffTJnj1svuv+tsrlQa2G1rib5veVLpNj5cZxPL9N++y2CQskjwnzXoxrI2jEPyPt
         4TEgyOpVMzsC8+ptG7IgWnVx7ZVgxUTTGUi/wybZUwo0ukS8xTGSNLepKdYV/FxI/tfx
         53TV2WNlhRXOVv2iB1SNBrZJWISTUhKq1S9z+HbALnIuJbRcrb5HLVJ0NRGc+iK4SZ6k
         9dLQ==
X-Gm-Message-State: AOUpUlGVghfkSv0g0T8ir1lCZuHTo3b1xNp85Cbv0UhTKQUaEIBstclB
        iNiTYRysmVNMElV2uTV93zsa1u7l5EzDDLaT4P0=
X-Google-Smtp-Source: AA+uWPzKx89YUtWXyw/Eevy49KIHn37rSsMaW38IBDlyB4GQmno2nSLYSuj4voFsQ3VuNvhyKExtNUnd0RI+ZHqQlmA=
X-Received: by 2002:aca:ccc4:: with SMTP id c187-v6mr1068101oig.282.1533802593716;
 Thu, 09 Aug 2018 01:16:33 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:63d2:0:0:0:0:0 with HTTP; Thu, 9 Aug 2018 01:16:33 -0700 (PDT)
In-Reply-To: <20180808180248.GC27850@codeaurora.org>
References: <20180620172226.15012-1-ulf.hansson@linaro.org>
 <2056372.NMt4aPaF4h@aspire.rjw.lan> <2205807.cU2puvubpP@aspire.rjw.lan>
 <1726374.375PCQfjLZ@aspire.rjw.lan> <CAPDyKFrmP15+_hyRp44Jw-wsTmsNFKORdCeGJEgW8o0OoKiHhA@mail.gmail.com>
 <CAJZ5v0hk1wfm10fyycmddKF6wR4D51r30fD_-J5UDMbtB3+V-Q@mail.gmail.com>
 <20180808105619.GB25150@e107981-ln.cambridge.arm.com> <20180808180248.GC27850@codeaurora.org>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 9 Aug 2018 10:16:33 +0200
X-Google-Sender-Auth: MoRXvnvxUQnFLGdJ9oSkJdEO43c
Message-ID: <CAJZ5v0gnZCmfgERSJfAFM6Y+jLX4V3Rsr4D5gBACWRNbGcEN-A@mail.gmail.com>
Subject: Re: [PATCH v8 09/26] kernel/cpu_pm: Manage runtime PM in the idle
 path for CPUs
To:     Lina Iyer <ilina@codeaurora.org>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        Kevin Hilman <khilman@kernel.org>,
        Lina Iyer <lina.iyer@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Juri Lelli <juri.lelli@arm.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 8, 2018 at 8:02 PM, Lina Iyer <ilina@codeaurora.org> wrote:
> On Wed, Aug 08 2018 at 04:56 -0600, Lorenzo Pieralisi wrote:
>>
>> On Mon, Aug 06, 2018 at 11:37:55AM +0200, Rafael J. Wysocki wrote:
>>>
>>> On Fri, Aug 3, 2018 at 1:42 PM, Ulf Hansson <ulf.hansson@linaro.org>
>>> wrote:
>>> > [...]
>>> >
>>> >>>
>>> >>> Assuming that I have got that right, there are concerns, mostly
>>> >>> regarding
>>> >>> patch [07/26], but I will reply to that directly.
>>> >>
>>> >> Well, I haven't got that right, so never mind.
>>> >>
>>> >> There are a few minor things to address, but apart from that the
>>> >> general
>>> >> genpd patches look ready.
>>> >
>>> > Alright, thanks!
>>> >
>>> > I will re-spin the series and post a new version once 4.19 rc1 is out.
>>> > Hopefully we can queue it up early in next cycle to get it tested in
>>> > next for a while.
>>> >
>>> >>
>>> >>> The $subject patch is fine by me by itself, but it obviously depends
>>> >>> on the
>>> >>> previous ones.  Patches [01-02/26] are fine too, but they don't seem
>>> >>> to be
>>> >>> particularly useful without the rest of the series.
>>> >>>
>>> >>> As far as patches [10-26/26] go, I'd like to see some review comments
>>> >>> and/or
>>> >>> tags from the people with vested interest in there, in particular
>>> >>> from Daniel
>>> >>> on patch [12/26] and from Sudeep on the PSCI ones.
>>> >>
>>> >> But this still holds.
>>> >
>>> > Actually, patch 10 and patch11 is ready to go as well. I ping Daniel
>>> > on patch 12.
>>> >
>>> > In regards to the rest of the series, some of the PSCI/ARM changes
>>> > have been reviewed by Mark Rutland, however several changes have not
>>> > been acked.
>>> >
>>> > On the other hand, one can also interpret the long silence in regards
>>> > to PSCI/ARM changes as they are good to go. :-)
>>>
>>> Well, in that case giving an ACK to them should not be an issue for
>>> the people with a vested interest I suppose.
>>
>>
>> Apologies to everyone for the delay in replying.
>>
>> Side note: cpu_pm_enter()/exit() are also called through syscore ops in
>> s2RAM/IDLE, you know that but I just wanted to mention it to compound
>> the discussion.
>>
>> As for PSCI patches I do not personally think PSCI OSI enablement is
>> beneficial (and my position has always been the same since PSCI OSI was
>> added to the specification, I am not even talking about this patchset)
>> and Arm Trusted Firmware does not currently support it for the same
>> reason.
>>
>> We (if Mark and Sudeep agree) will enable PSCI OSI if and when we have a
>> definitive and constructive answer to *why* we have to do that that is
>> not a dogmatic "the kernel knows better" but rather a comprehensive
>> power benchmark evaluation - I thought that was the agreement reached
>> at OSPM but apparently I was mistaken.
>>
> I will not speak to any comparison of benchmarks between OSI and PC.
> AFAIK, there are no platforms supporting both.
>
> But, the OSI feature is critical for QCOM mobile platforms. The
> last man activities during cpuidle save quite a lot of power. Powering
> off the clocks, busses, regulators and even the oscillator is very
> important to have a reasonable battery life when using the phone.
> Platform coordinated approach falls quite short of the needs of a
> powerful processor with a desired battery efficiency.

Even so, you still need firmware (or hardware) to do the right thing
in the concurrent wakeup via an edge-triggered interrupt case AFAICS.
That is, you need the domain to be prevented from being turned off if
one of the CPUs in it has just been woken up and the interrupt is
still pending.
