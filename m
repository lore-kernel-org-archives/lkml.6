Return-Path: <SRS0=SFDS=MQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD9E9C64EBC
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 18:37:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9AAF82083F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 18:37:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="GkNBteae"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9AAF82083F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728177AbeJEBbg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Oct 2018 21:31:36 -0400
Received: from mail-it1-f195.google.com ([209.85.166.195]:38866 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728003AbeJEBbg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Oct 2018 21:31:36 -0400
Received: by mail-it1-f195.google.com with SMTP id i76-v6so15480206ita.3
        for <linux-kernel@vger.kernel.org>; Thu, 04 Oct 2018 11:37:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=Qripqr2lFTOyL4eG2+rH2ogPhSlNydPej+tyL4yiDas=;
        b=GkNBteaeVZdPC4KyPiGu/XKewT0XWSjcqaJ6eeetb9169p16ZEbl+uMEmkQHw+YXkd
         slLztKWLQHqvxPjqtHPJ+GKpURFQRkAjiBE+z0CSIOO90DH/lV1ullMH/j3jKw+deTgl
         5gN3hTSNCrNCWLjQq6wFm1/LQmFMO+lQIdfgk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=Qripqr2lFTOyL4eG2+rH2ogPhSlNydPej+tyL4yiDas=;
        b=NeA/1OhbX+NM6f8IYXXU5XAmuic9QtmxZlXYsAk59YpbRnwtR32lN4pGA41BAPn5xV
         DXmAyj+jmc70YtV6ogM4oxUFg8t5plzYdS8HiQCYwXjxRcgNuSq4tX9a80nQHMKKSiFk
         mmagjo2zhyNR7hEpXKIAQp2NJdvxc2tRK2X+pmN3HlnPMnmesIKge/6myNT9vBR2JgK9
         Xrrfq+FXwTt4iBbGb1nxj4H/HWKRCblfbvap4WCBMzoOiFjKUCcisFpaY3nV8sKB/HiS
         uiX/gyGSV+nx6mA24S6oKRMZZuhAPVm8q3+CvGcoMiluC31qTnMllO5QI8qbQ6HJ5dgE
         h9HQ==
X-Gm-Message-State: ABuFfohur6rK2w34j5oVOuOEZIP5tXS8krkGq8ycP0faL/kl9Syx5Ue9
        H07LMLdm/r4MJv4dtAvF/l/Ny0IgKx7YvJWDUk3jcw==
X-Google-Smtp-Source: ACcGV60YnHWOyTVtQhJGXHp+a5mHhaHtTNDMCZ7CYM3z163QmMp+zCHpV1zI1Qw+LGbDHg1CpIHD5G9y8qPP4ZVIsY4=
X-Received: by 2002:a05:660c:243:: with SMTP id t3mr5721582itk.146.1538678225481;
 Thu, 04 Oct 2018 11:37:05 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a02:3941:0:0:0:0:0 with HTTP; Thu, 4 Oct 2018 11:36:24 -0700 (PDT)
In-Reply-To: <20181004172109.GA16878@red-moon>
References: <20181003143824.13059-1-ulf.hansson@linaro.org>
 <CAJZ5v0h7jvoa4oUeM4FgFizF_jbAonoAgP3m417n_TGqfqNsqg@mail.gmail.com>
 <CAPDyKFq0GLs2AMA+6b-Khf+4kGxzVCTvtehp-YmwV2h=_SP4=g@mail.gmail.com>
 <10136406.EY9A7BdqYq@aspire.rjw.lan> <CAJZ5v0iv9OYoaLYHsmdp2xbDuENPgue_mBgFujdmesnBOegRKQ@mail.gmail.com>
 <20181004155755.GD5233@e107981-ln.cambridge.arm.com> <CAJZ5v0j+W2CHiqkniXNJgZ3DU9pOpd_83Wj9Egwf+pVkRCjZLg@mail.gmail.com>
 <20181004172109.GA16878@red-moon>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 4 Oct 2018 20:36:24 +0200
Message-ID: <CAPDyKFrWzDU9BsfAnx7uoaXq=gmGg2r46Mn-cJHSWUk-TmyomA@mail.gmail.com>
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

On 4 October 2018 at 19:21, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com> wrote:
> On Thu, Oct 04, 2018 at 07:07:27PM +0200, Rafael J. Wysocki wrote:
>
> [...]
>
>> > > I don't see any dependency there, so I'll queue up the 1-3 in
>> > > pm-domains and the 4-6 in pm-cpuidle.
>> >
>> > I do not see why we should merge patches 4-6 for v4.20; they add legacy
>> > (DT bindings and related parsing code) with no user in the kernel; we
>> > may still want to tweak them, in particular PSCI DT bindings.
>>
>> My impression was that 4-6 have been agreed on due to the ACKs they
>> carry.  I'll drop them if that's not the case.
>
> I have not expressed myself correctly: they have been agreed (even
> though as I said they may require some tweaking) but I see no urgency
> of merging them in v4.20 since they have no user. They contain DT
> bindings, that create ABI/legacy, I think it is better to have code
> that uses them in the kernel before merging them and creating a
> dependency that is not needed.

There is already code using the new bindings, for the idle states.
Please have look at patch 5, 6 and 11.

Moreover, you have had plenty on time to look at the series, as those
patches haven't changed since a very long time.

May I suggest you do the review instead, so we can move things
forward, please. The changes in the v9 series should be trivial to
review.

>
>> > Likewise, it makes no sense to merge patches 7-8 without the rest of
>> > the PSCI patches.

Well, those patches are part of this series, because Mark wanted me to
move the files. Is really such a big deal? I think it makes sense, no
matter what happens afterwards.

[...]

Kind regards
Uffe
