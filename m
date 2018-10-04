Return-Path: <SRS0=SFDS=MQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B87B8C64EBC
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 10:11:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 77B172082A
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 10:11:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="hxiZg5BJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 77B172082A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727648AbeJDRDz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Oct 2018 13:03:55 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:43252 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727432AbeJDRDz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Oct 2018 13:03:55 -0400
Received: by mail-io1-f68.google.com with SMTP id y10-v6so7411623ioa.10
        for <linux-kernel@vger.kernel.org>; Thu, 04 Oct 2018 03:11:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=r9U8GJ7bA7IWXUwn75k/SS4CGv0zhs8KIl4o221x0VE=;
        b=hxiZg5BJBQ/WKCb3p6SW7PxJyMUkExHmIS8632CuwhFl1wZUoW9eqkZi0wURjzYznD
         5Cq2BX8acGeVIeCIZ7pPI0X2fKmFML8SH4BDlZVcCtC2qZ4soI9mi2flYejNdGIMChA2
         YAoPupxMlbNGa/YTzXv54W3KTognAfWOgN1RE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=r9U8GJ7bA7IWXUwn75k/SS4CGv0zhs8KIl4o221x0VE=;
        b=IA1w584NVTH9uH6cDPGI5/0PFPFfxA1534oWs9I0gTR6GTMNgv7O+1cU3LWiC+wiML
         9F+QQRAqREIqD+BjJLZssZRqMo/oNLbWxnrU2wa6GC6syvIIeeqtBxGB+y7KYM/SuB0m
         HLVvQf6vBDX32+lEfnhaapv5VgMJx8e6DN8rRXzcc1cXLkggyv34qFKJ0tLgwVG/j5PU
         BOPwR187HZZYuFtkibbbiuDHCl2h5/o922jwqqfBcS2i2gIqWOH25nkuCmkNnaFSi5C8
         Fgo7E0hnzg3PKxM+Eb49asb1+8Vaqv3QGXUWBTr3E8OKGDVMZhpDGjTZnlGaaTweebBa
         4F1w==
X-Gm-Message-State: ABuFfoiM/MXoJUrLF50tq29T2WMapDf49aq4QeyBRIBHYjwYZvyk+aAZ
        H3wLFLWP1IjlmTP3OXE8brNkVAyKpvDAWsp3999kJg==
X-Google-Smtp-Source: ACcGV628cOhvEh+S2U9KBeD6/H5L8UM/V0Vh6FpK2s/xb4BYgrTFjHrTcV+QRv1o7hL107ZVhl3vq37FvpXxtMqeit4=
X-Received: by 2002:a6b:203:: with SMTP id 3-v6mr3787776ioc.131.1538647881014;
 Thu, 04 Oct 2018 03:11:21 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a02:3941:0:0:0:0:0 with HTTP; Thu, 4 Oct 2018 03:10:40 -0700 (PDT)
In-Reply-To: <CAJZ5v0iv9OYoaLYHsmdp2xbDuENPgue_mBgFujdmesnBOegRKQ@mail.gmail.com>
References: <20181003143824.13059-1-ulf.hansson@linaro.org>
 <CAJZ5v0h7jvoa4oUeM4FgFizF_jbAonoAgP3m417n_TGqfqNsqg@mail.gmail.com>
 <CAPDyKFq0GLs2AMA+6b-Khf+4kGxzVCTvtehp-YmwV2h=_SP4=g@mail.gmail.com>
 <10136406.EY9A7BdqYq@aspire.rjw.lan> <CAJZ5v0iv9OYoaLYHsmdp2xbDuENPgue_mBgFujdmesnBOegRKQ@mail.gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 4 Oct 2018 12:10:40 +0200
Message-ID: <CAPDyKFqgXy9Yf9j_zf5n7QcrCg8V20qqprVdZK-KYKhWJEkuoQ@mail.gmail.com>
Subject: Re: [PATCH v9 00/11] PM / Domains: Support hierarchical CPU
 arrangement (PSCI/ARM) (a subset)
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Sudeep Holla <sudeep.holla@arm.com>,
        Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>,
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

On 4 October 2018 at 11:32, Rafael J. Wysocki <rafael@kernel.org> wrote:
> On Thu, Oct 4, 2018 at 11:04 AM Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
>>
>> On Thursday, October 4, 2018 10:58:53 AM CEST Ulf Hansson wrote:
>> > On 4 October 2018 at 10:39, Rafael J. Wysocki <rafael@kernel.org> wrote:
>> > > On Wed, Oct 3, 2018 at 4:39 PM Ulf Hansson <ulf.hansson@linaro.org> wrote:
>> > >>
>> > >> I have digested the review comments so far, including a recent offlist chat
>> > >> with with Lorenzo Pieralisi around the debatable PSCI changes. More or less I
>> > >> have a plan for how to move forward.
>> > >>
>> > >> However, to avoid re-posting non-changed patches over and over again, I decided
>> > >> to withhold the more debatable part from this v9, hence this is not the complete
>> > >> series to make things play. In v9, I have just included the trivial changes,
>> > >> which are either already acked/reviewed or hopefully can be rather soon/easily.
>> > >>
>> > >> My hope is to get this queued for v4.20, to move things forward. I know it's
>> > >> late, but there are more or less nothing new here since v8.
>> > >
>> > > I have no problems with the first three patches in this series, so I
>> > > can apply them right away.  Do you want me to do that?
>> >
>> > Yes, please.
>> >
>> > >
>> > > As for the rest, the cpuidle driver patch looks OK to me, but the
>> > > PSCI-related ones need ACKs.
>> >
>> > For some yes, but I think you can go ahead with a few more.
>> >
>> > Patch 4, 5 is already acked/reviewed.
>> >
>> > Patch 6 should be fine (if you are okay with it else wait for an ack
>> > from Daniel)
>>
>> OK, thanks.
>>
>> Do the 4-6 depend on the 1-3?
>
> I don't see any dependency there, so I'll queue up the 1-3 in
> pm-domains and the 4-6 in pm-cpuidle.

Great, thanks!

Make sure you put the remaining of the PSCI changes on pm-cpuidle
(once acked), as there are dependency.

Kind regards
Uffe
