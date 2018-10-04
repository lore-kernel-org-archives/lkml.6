Return-Path: <SRS0=SFDS=MQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE5C1C64EBC
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 09:32:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B1F0A213A2
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 09:32:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B1F0A213A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727655AbeJDQZR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Oct 2018 12:25:17 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:38259 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727150AbeJDQZR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Oct 2018 12:25:17 -0400
Received: by mail-ot1-f68.google.com with SMTP id h15-v6so8493007otj.5;
        Thu, 04 Oct 2018 02:32:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vttIPmW6bRPFnjF4MnucHltErxDXz5XftYR6jv18fpg=;
        b=pwkrDwQ7YXVuETR68f1ElCRn3qqkTF6Ry1n7EJNCb0uEQjEPj+u/PcNgfRIQ8v3/bS
         0GKnmWbkoTUFeKHZJvqJacqyT085QJgu/b8EJbyiF1IUSHdZq7A0dkojC/Z/Y36nGT12
         MnXcBpiLnsLuJ8vbn4LMCsqX1vszRmBkoIrUj29BBU13rT63Xnk4qbFr/NewW/yX/A8T
         qvTaTVcfPH4B7J7cEsLx2v30IYTKrXf9tNmT86FI0psmVH+hsxS9vGB9mtYeI5MDu+7v
         fLK69+QsCf2yVzBO5J5/R2Ev7ZN8WczIAi1b71/1BzVPjzX1dyQ9zRX4FO9W2J8D32O1
         9Sqw==
X-Gm-Message-State: ABuFfog9GyYG0aN4xPWgfaGwE37Gm0fGSIJnEUlLTrzOXFmbsYAQx803
        klF7KQ9kpig9BoG+mcYjmawiXlDVUkFfe7HHpVc=
X-Google-Smtp-Source: ACcGV61HvPLPCRxXN2OTA4toFy1xmgIC+vRm5yDXpz5nKAdubGHi4mU2aIUtnD0fay/i3eWx67l7Ir5SPS3FURER5JU=
X-Received: by 2002:a9d:34f:: with SMTP id 73mr3353641otv.343.1538645572909;
 Thu, 04 Oct 2018 02:32:52 -0700 (PDT)
MIME-Version: 1.0
References: <20181003143824.13059-1-ulf.hansson@linaro.org>
 <CAJZ5v0h7jvoa4oUeM4FgFizF_jbAonoAgP3m417n_TGqfqNsqg@mail.gmail.com>
 <CAPDyKFq0GLs2AMA+6b-Khf+4kGxzVCTvtehp-YmwV2h=_SP4=g@mail.gmail.com> <10136406.EY9A7BdqYq@aspire.rjw.lan>
In-Reply-To: <10136406.EY9A7BdqYq@aspire.rjw.lan>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 4 Oct 2018 11:32:41 +0200
Message-ID: <CAJZ5v0iv9OYoaLYHsmdp2xbDuENPgue_mBgFujdmesnBOegRKQ@mail.gmail.com>
Subject: Re: [PATCH v9 00/11] PM / Domains: Support hierarchical CPU
 arrangement (PSCI/ARM) (a subset)
To:     Ulf Hansson <ulf.hansson@linaro.org>
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

On Thu, Oct 4, 2018 at 11:04 AM Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
>
> On Thursday, October 4, 2018 10:58:53 AM CEST Ulf Hansson wrote:
> > On 4 October 2018 at 10:39, Rafael J. Wysocki <rafael@kernel.org> wrote:
> > > On Wed, Oct 3, 2018 at 4:39 PM Ulf Hansson <ulf.hansson@linaro.org> wrote:
> > >>
> > >> I have digested the review comments so far, including a recent offlist chat
> > >> with with Lorenzo Pieralisi around the debatable PSCI changes. More or less I
> > >> have a plan for how to move forward.
> > >>
> > >> However, to avoid re-posting non-changed patches over and over again, I decided
> > >> to withhold the more debatable part from this v9, hence this is not the complete
> > >> series to make things play. In v9, I have just included the trivial changes,
> > >> which are either already acked/reviewed or hopefully can be rather soon/easily.
> > >>
> > >> My hope is to get this queued for v4.20, to move things forward. I know it's
> > >> late, but there are more or less nothing new here since v8.
> > >
> > > I have no problems with the first three patches in this series, so I
> > > can apply them right away.  Do you want me to do that?
> >
> > Yes, please.
> >
> > >
> > > As for the rest, the cpuidle driver patch looks OK to me, but the
> > > PSCI-related ones need ACKs.
> >
> > For some yes, but I think you can go ahead with a few more.
> >
> > Patch 4, 5 is already acked/reviewed.
> >
> > Patch 6 should be fine (if you are okay with it else wait for an ack
> > from Daniel)
>
> OK, thanks.
>
> Do the 4-6 depend on the 1-3?

I don't see any dependency there, so I'll queue up the 1-3 in
pm-domains and the 4-6 in pm-cpuidle.

Thanks,
Rafael
