Return-Path: <SRS0=Q/hc=JL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0B6BC43144
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 08:57:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9FE9E2563E
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 08:57:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="aLv7St2s"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9FE9E2563E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754743AbeFYI5J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 04:57:09 -0400
Received: from mail-io0-f193.google.com ([209.85.223.193]:38707 "EHLO
        mail-io0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754575AbeFYI5G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 04:57:06 -0400
Received: by mail-io0-f193.google.com with SMTP id l19-v6so11794116ioj.5
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jun 2018 01:57:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=U4TOzcExpBCnbQAxnm11Tll/dIgwn4FZ1AlrfkmPmOw=;
        b=aLv7St2sAEDBDswfVlamV5Oox10YEPNE6XA6wkO+xKIEdp+QJ2WYDHU0HJR19i5NRm
         rVD0b3Hk1Rajl9wZQgAOfZhLtJd1gA5a3ZwhAepDC+HVPSmeUSVd6YWFBb8mHTFpb1/0
         YdaeWBvkBBlBW9liLogcPPHd4y/VXffmnKibQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=U4TOzcExpBCnbQAxnm11Tll/dIgwn4FZ1AlrfkmPmOw=;
        b=DT74qGA9PFw144kczpRqnuOLi4BCS2yWN7pbcrvW/vPXHKIIB3o9UvjoNdMQqPn/K6
         Tk8U9Ie2ZpgwGmpAcmvo+404TlyBToPLBJvWvuk9d6G08+8Bwz6HHeKr0QK8iukV53QM
         NmdXNoIO7wQG/6uyn2aLd69cF5BSsrqLsfpe6z/iN7Qrd4RkUhDgDlzhtq/XJWwLCNSA
         et3lAsw8JkvlSyk9RgGYjAtOj17jzk7HkhLVdbwy7eh9RsAEPVbjUwK+eeTDZ8IEfBCO
         RR3fMpeZL6mBh8bH9fg7L3qtqYJwddM68VxKWztE3bUx1Vkp8GFWAitRSpxBizadItyJ
         wEdA==
X-Gm-Message-State: APt69E0vJMoX0ZAoPtYLBUpcSpbZEG8uNcVK778GL/VS7bT659LSraPc
        /CDSt897INy4/pGfP/XJ9MVMSx4oL0GyzY8vbMB6FA==
X-Google-Smtp-Source: AAOMgpe0WKayHOmfviwPIvCDev0VVkf/2ov3qKracwE3XDvvgiTGlbjW2F9yNmAL62I8Vk/lnqxFOtJ3ihLjGg+gFiM=
X-Received: by 2002:a6b:c992:: with SMTP id z140-v6mr9756687iof.266.1529917026005;
 Mon, 25 Jun 2018 01:57:06 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a02:818f:0:0:0:0:0 with HTTP; Mon, 25 Jun 2018 01:57:05
 -0700 (PDT)
In-Reply-To: <20180619101016.hbgjvev7d3h4yg7x@vireshk-i7>
References: <20180612044052.4402-1-rnayak@codeaurora.org> <20180612044052.4402-8-rnayak@codeaurora.org>
 <414598de-00a1-9ce7-3a7e-4a95fd1bd35d@codeaurora.org> <f5014664-1639-c610-a50a-db66484428dc@codeaurora.org>
 <20180619101016.hbgjvev7d3h4yg7x@vireshk-i7>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 25 Jun 2018 10:57:05 +0200
Message-ID: <CAPDyKFpvBXbppamoDDUKcMTnD8S3U7ZTKutLgSsLYQkAU0JXZg@mail.gmail.com>
Subject: Re: [PATCH v3 7/7] soc: qcom: rpmpd/rpmhpd: Add a max vote on all
 corners at init
To:     Viresh Kumar <viresh.kumar@linaro.org>,
        Rajendra Nayak <rnayak@codeaurora.org>
Cc:     David Collins <collinsd@codeaurora.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Andy Gross <andy.gross@linaro.org>, devicetree@vger.kernel.org,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19 June 2018 at 12:10, Viresh Kumar <viresh.kumar@linaro.org> wrote:
> On 14-06-18, 12:05, Rajendra Nayak wrote:
>> On 06/14/2018 03:58 AM, David Collins wrote:
>> > Hello Rajendra,
>> >
>> > On 06/11/2018 09:40 PM, Rajendra Nayak wrote:
>> >> As we move from no clients/consumers in kernel voting on corners,
>> >> to *some* voting and some not voting, we might end up in a situation
>> >> where the clients which remove votes can adversly impact others
>> >
>> > s/adversly/adversely/
>> >
>> >> who still don't have a way to vote.
>> >>
>> >> To avoid this situation, have a max vote on all corners at init.
>> >> This should/can be removed once we have all clients moved to
>> >> be able to vote/unvote for themselves.
>> >
>> > This change seems like a hack.  Do you intend for it to be merged and then
>> > later reverted in Linus's tree?  Could it instead be implemented in a way
>> > that does not require reverting and instead is enabled by some DT
>> > property?  Alternatively, could this feature be added to the power domain
>> > core since it is relatively generic?
>> >
>> >
>> >> Signed-off-by: Rajendra Nayak <rnayak@codeaurora.org>
>> >> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
>> >> ---
>> >>  drivers/soc/qcom/rpmhpd.c | 12 +++++++++++-
>> >>  drivers/soc/qcom/rpmpd.c  |  9 +++++++++
>> >>  2 files changed, 20 insertions(+), 1 deletion(-)
>> >>
>> >> diff --git a/drivers/soc/qcom/rpmhpd.c b/drivers/soc/qcom/rpmhpd.c
>> >> index 7083ec1590ff..3c753d33aeee 100644
>> >> --- a/drivers/soc/qcom/rpmhpd.c
>> >> +++ b/drivers/soc/qcom/rpmhpd.c
>> >> @@ -329,7 +329,7 @@ static int rpmhpd_update_level_mapping(struct rpmhpd *rpmhpd)
>> >>
>> >>  static int rpmhpd_probe(struct platform_device *pdev)
>> >>  {
>> >> -  int i, ret;
>> >> +  int i, ret, max_level;
>> >>    size_t num;
>> >>    struct genpd_onecell_data *data;
>> >>    struct rpmhpd **rpmhpds;
>> >> @@ -390,6 +390,16 @@ static int rpmhpd_probe(struct platform_device *pdev)
>> >>            pm_genpd_init(&rpmhpds[i]->pd, NULL, true);
>> >>
>> >>            data->domains[i] = &rpmhpds[i]->pd;
>> >> +
>> >> +          /*
>> >> +           * Until we have all consumers voting on corners
>> >> +           * just vote the max corner on all PDs
>> >> +           * This should ideally be *removed* once we have
>> >> +           * all (most) consumers being able to vote
>> >> +           */
>> >> +          max_level = rpmhpds[i]->level_count - 1;
>> >> +          rpmhpd_set_performance(&rpmhpds[i]->pd, rpmhpds[i]->level[max_level]);
>> >> +          rpmhpd_power_on(&rpmhpds[i]->pd);
>> >
>> > Clearly these calls will result in max level requests being sent for all
>> > power domains at probe time.  However, it isn't clear that this will
>> > actually help at runtime in these two cases:
>> >
>> > 1. A consumer enables and then disables a power domain.
>> >     - It seems like the PD would just be disabled in this case.
>
> So instead of rpmhpd_power_on() we should be doing gepnd_power_on() or whatever
> the API is, so the user count stays at 1.

There is no such API.

Instead a device needs to be attached to genpd and that's it. As long
as the device don't enables runtime PM and that the device gets
runtime suspended, genpd will remain powered on.

>
>> > 2. A consumer sets a non-max performance state of a power domain.
>> >     - It seems like the PD would just be set to the new lower
>> >       performance state since the max vote isn't known to the
>> >       PD core for aggregation purposes.
>
> Right, and that's because the patch isn't implemented properly yet. I asked to
> do a fake vote from some user with their dev structure, so the vote always
> stays.
>
>> Yes, you are right. I certainly did not seem to have thought through this enough.
>>
>> A need for something like this came up at a point where genpd could not deal with
>> devices with multiple power domains. So the concern at that point was that if some
>> consumers (which only need to vote on one corner) move to using this driver, while
>> some others (which need to vote on multiple corners) cannot, we would end up breaking
>> them.
>>
>> That does not seem to be true anymore since we do have patches from Ulf which support
>> having devices with multiple power domains attached which can be controlled individually.
>> So if some consumer voting makes some others break, they should just be fixed and patched
>> to vote as well. If all this gets handled centrally from within the clock drivers then we
>> most likely won't even end up with a situation like this.
>>
>> I think I will just drop this one unless Stephen/Viresh still see an issue with some early
>> voters breaking others.
>
> So what if the LCD/DDR/etc are getting used at boot and someone requests a lower
> vote?  Wouldn't we just break ?

Sounds like we need a way to manage votes for "boot constraints
performance levels". :-)

Anyway, to deal with this via the existing genpd APIs, we need to
attach a device to a genpd and then call
dev_pm_genpd_set_performance_state() on it. I guess at a late
initcall, the votes can be dropped and the device can be detached. Or
something along these lines.

Kind regards
Uffe
