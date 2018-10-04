Return-Path: <SRS0=SFDS=MQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D762C64EBC
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 18:38:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DAF6D2087D
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 18:38:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="TMQG0w6O"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DAF6D2087D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727781AbeJEBd0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Oct 2018 21:33:26 -0400
Received: from mail-it1-f194.google.com ([209.85.166.194]:36085 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727614AbeJEBdZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Oct 2018 21:33:25 -0400
Received: by mail-it1-f194.google.com with SMTP id c85-v6so15508157itd.1
        for <linux-kernel@vger.kernel.org>; Thu, 04 Oct 2018 11:38:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=7+8qAGgQi+nleYbZrya2R+TQjgWZ5ahtt7oX49bsjqY=;
        b=TMQG0w6OT2QnPaN6lgUDuj/+6AWYtXSGwkXcuXBs0vWtC9saTNA739Boq2fVVUIP8L
         H1bLIFWnNSOir7fRCYCxqtWqd3PMkATj6IlVY+zegwD754hZ/wuuKGPh0HlbdDTVsbbT
         XAHvq7mTzeBtiXF03n9zpdQKQtgPTCEuvpO/g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=7+8qAGgQi+nleYbZrya2R+TQjgWZ5ahtt7oX49bsjqY=;
        b=rECZS0jLJghDJirqBRwoO2hUeVpRoaO9eyxCEr+Ukae8oO9/lpPTSxeFR84RjWoreA
         ZWanJdvRdS4bTHu8A4LTMfQfErnXTSNkYdQVN9PZiorHs2xJeJq+wDw4QsaNNbM3SrnR
         xsYqoD+wJKH8I4EzRpCaazUPyPz5Jz8CFEbI5Y8iDS7f92HQsX37KQNwCJfT7z8Swmtr
         wx2BY3V80dCdfnmMa4ob8+wuNDbLPAwv0hIzYDWwjoQHJOGVrjEO4mq0flgCuadSl5RJ
         /SRNso0DhcnsyoeRCCh0Q5cvWILOMKkI6nn8Z1a2Knp7N6HCsqJVv+elYseouYgKe5Il
         yXAQ==
X-Gm-Message-State: ABuFfohWyYk7KRwIk3CkKlP0JQlKFH/UzfBonAkEvbLIH6nl87Hz/XLH
        m9SFhjmD7hI+S96ohOq59BeUm7aYgPPNAE39hzD4GA==
X-Google-Smtp-Source: ACcGV60C/qOceDekwsGswAI6pcW6uyc+iqdq5GpBH9mnDMH9EVdePBIo7Qzf/rRGO6Svj+sNpnct45Kks2hD8o7cvs0=
X-Received: by 2002:a24:8045:: with SMTP id g66-v6mr6237592itd.45.1538678334496;
 Thu, 04 Oct 2018 11:38:54 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a02:3941:0:0:0:0:0 with HTTP; Thu, 4 Oct 2018 11:38:14 -0700 (PDT)
In-Reply-To: <CAPDyKFrWzDU9BsfAnx7uoaXq=gmGg2r46Mn-cJHSWUk-TmyomA@mail.gmail.com>
References: <20181003143824.13059-1-ulf.hansson@linaro.org>
 <CAJZ5v0h7jvoa4oUeM4FgFizF_jbAonoAgP3m417n_TGqfqNsqg@mail.gmail.com>
 <CAPDyKFq0GLs2AMA+6b-Khf+4kGxzVCTvtehp-YmwV2h=_SP4=g@mail.gmail.com>
 <10136406.EY9A7BdqYq@aspire.rjw.lan> <CAJZ5v0iv9OYoaLYHsmdp2xbDuENPgue_mBgFujdmesnBOegRKQ@mail.gmail.com>
 <20181004155755.GD5233@e107981-ln.cambridge.arm.com> <CAJZ5v0j+W2CHiqkniXNJgZ3DU9pOpd_83Wj9Egwf+pVkRCjZLg@mail.gmail.com>
 <20181004172109.GA16878@red-moon> <CAPDyKFrWzDU9BsfAnx7uoaXq=gmGg2r46Mn-cJHSWUk-TmyomA@mail.gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 4 Oct 2018 20:38:14 +0200
Message-ID: <CAPDyKFoOkC7Tr0Hkx2OHhCA4Tk9j5Y3HBB4bG6ORaiHp-KcJ9w@mail.gmail.com>
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

On 4 October 2018 at 20:36, Ulf Hansson <ulf.hansson@linaro.org> wrote:
> On 4 October 2018 at 19:21, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com> wrote:
>> On Thu, Oct 04, 2018 at 07:07:27PM +0200, Rafael J. Wysocki wrote:
>>
>> [...]
>>
>>> > > I don't see any dependency there, so I'll queue up the 1-3 in
>>> > > pm-domains and the 4-6 in pm-cpuidle.
>>> >
>>> > I do not see why we should merge patches 4-6 for v4.20; they add legacy
>>> > (DT bindings and related parsing code) with no user in the kernel; we
>>> > may still want to tweak them, in particular PSCI DT bindings.
>>>
>>> My impression was that 4-6 have been agreed on due to the ACKs they
>>> carry.  I'll drop them if that's not the case.
>>
>> I have not expressed myself correctly: they have been agreed (even
>> though as I said they may require some tweaking) but I see no urgency
>> of merging them in v4.20 since they have no user. They contain DT
>> bindings, that create ABI/legacy, I think it is better to have code
>> that uses them in the kernel before merging them and creating a
>> dependency that is not needed.
>
> There is already code using the new bindings, for the idle states.
> Please have look at patch 5, 6 and 11.

Should be 5, 6 and 10, sorry.

>
> Moreover, you have had plenty on time to look at the series, as those
> patches haven't changed since a very long time.
>
> May I suggest you do the review instead, so we can move things
> forward, please. The changes in the v9 series should be trivial to
> review.
>
>>
>>> > Likewise, it makes no sense to merge patches 7-8 without the rest of
>>> > the PSCI patches.
>
> Well, those patches are part of this series, because Mark wanted me to
> move the files. Is really such a big deal? I think it makes sense, no
> matter what happens afterwards.
>
> [...]
>
> Kind regards
> Uffe
