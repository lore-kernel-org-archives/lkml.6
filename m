Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 946F1C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 04:32:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 639952148D
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 04:32:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zbDPxaw/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726819AbfBUEcO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 23:32:14 -0500
Received: from mail-qk1-f195.google.com ([209.85.222.195]:45530 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725880AbfBUEcO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 23:32:14 -0500
Received: by mail-qk1-f195.google.com with SMTP id v139so3505264qkb.12
        for <linux-kernel@vger.kernel.org>; Wed, 20 Feb 2019 20:32:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JnOpA5YgJAM+RQbCa94IzmSzldvRrqsBHqA1DiKhDo4=;
        b=zbDPxaw/6xRSR/mKxdeBVQJslUIkzr1B1rg6GyA43G/OBwj/eXmygGwZVb0k2xpN72
         Mn23mgIFssHMIRHpPHLsbe1DaQV26xO0745pY0xFHZvHHRYSMl/ybyglac6pYQf/44ku
         epWQFdhDc9D9VUhtZ4RVC9lfo4yp8XLiHIOX1l3CmaIHsgcXEJcrm8mQBjuFOsSs8pTQ
         NG1ebEks7QsDOzq/tkq/dwrGhUJVE2ln6DhD75H9JSaTF3XNX3qAyunWnLF8oo8lMqKy
         +dcGo/F4+OYNW9ZXejVTGk/vJZqVammLBg5aZn9rDtKZXPYZjnl39ejCXvjecgefBymk
         3GZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JnOpA5YgJAM+RQbCa94IzmSzldvRrqsBHqA1DiKhDo4=;
        b=abnkXVFmBGZ3eUZSuZSO6Fc9PCslmyg1rTa+PlfKQgsr0NOGPv3qF0lWK08jZdEZRi
         XTjoMHrgl6JDAmN9AFjUhndoyXUWFqi/uujQCQ3zWjj9OcmxhMgLxgbc/zf7oRqSgzWa
         1hUvR9esorcO+rsyt2MVCAte+F3f5OEcsbCTmwxfOLLI2PYQ6fG+a2QbMlsr7aDhYMjY
         ycJTbIvrcYb/vOOlZeXvvsqJtupm7l2y5jrYItKAcRe+bJiLQq7xK9kVQYMpnSMHTP8v
         wPmAwdYQugYndNPg7HFq6n0yuV9a09ZpfegMozgf1nsJbzcLtdxUAKghEEw5+/IF7Ymu
         wung==
X-Gm-Message-State: AHQUAuZNh+UMxeIu3bYhwMQo//LGMEbi3JsK6XGauF4WVPUfEtna82mR
        HUe3suqcy1va0ck1qlj87kFSrEeYiA17B59zL7whQA==
X-Google-Smtp-Source: AHgI3IYMTne5NECf2/VnuCl1H1a+StnMzmKZ3BfsAp9ESC1yUX0Eoj7L0bowMfDvFJ090TSt/6zVewP9rryilnl//C4=
X-Received: by 2002:a37:9442:: with SMTP id w63mr26409826qkd.109.1550723533175;
 Wed, 20 Feb 2019 20:32:13 -0800 (PST)
MIME-Version: 1.0
References: <5919a74b74f466e803e07f70136517119dcd4560.1550661235.git.viresh.kumar@linaro.org>
 <CAP245DWuJTXfAc3QyqXjePqy32GHQsEqHbuSvjiS4EE3-TV1PA@mail.gmail.com> <20190221034534.n5jli3bj4mwtoudd@vireshk-i7>
In-Reply-To: <20190221034534.n5jli3bj4mwtoudd@vireshk-i7>
From:   Amit Kucheria <amit.kucheria@linaro.org>
Date:   Thu, 21 Feb 2019 10:02:00 +0530
Message-ID: <CAP245DV9m-foV8vAWSq5ZpvPHa_dLJyBQzRkta5B_yO2+bwL2A@mail.gmail.com>
Subject: Re: [PATCH] cpufreq: kyro: Reduce frame-size of qcom_cpufreq_kryo_probe()
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Rafael Wysocki <rjw@rjwysocki.net>, Ilia Lin <ilia.lin@kernel.org>,
        Linux PM list <linux-pm@vger.kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 21, 2019 at 9:15 AM Viresh Kumar <viresh.kumar@linaro.org> wrote:
>
> On 20-02-19, 21:56, Amit Kucheria wrote:
> > On Wed, Feb 20, 2019 at 4:44 PM Viresh Kumar <viresh.kumar@linaro.org> wrote:
> > >
> > > With the introduction of commit 846a415bf440 ("arm64: default NR_CPUS to
> > > 256"), we have started getting following compilation warning:
> > >
> > > qcom-cpufreq-kryo.c:168:1: warning: the frame size of 2160 bytes is larger than 2048 bytes [-Wframe-larger-than=]
> > >
> > > Fix that by dynamically allocating opp_tables and freeing it later.
> > >
> > > Compile tested only.
> > >
> > > Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> > > ---
> > >  drivers/cpufreq/qcom-cpufreq-kryo.c | 9 ++++++++-
> > >  1 file changed, 8 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/drivers/cpufreq/qcom-cpufreq-kryo.c b/drivers/cpufreq/qcom-cpufreq-kryo.c
> > > index 1c8583cc06a2..6888cb6db2ef 100644
> > > --- a/drivers/cpufreq/qcom-cpufreq-kryo.c
> > > +++ b/drivers/cpufreq/qcom-cpufreq-kryo.c
> > > @@ -75,7 +75,7 @@ static enum _msm8996_version qcom_cpufreq_kryo_get_msm_id(void)
> > >
> > >  static int qcom_cpufreq_kryo_probe(struct platform_device *pdev)
> > >  {
> > > -       struct opp_table *opp_tables[NR_CPUS] = {0};
> > > +       struct opp_table **opp_tables;
> > >         enum _msm8996_version msm8996_version;
> > >         struct nvmem_cell *speedbin_nvmem;
> > >         struct device_node *np;
> > > @@ -133,6 +133,10 @@ static int qcom_cpufreq_kryo_probe(struct platform_device *pdev)
> > >         }
> > >         kfree(speedbin);
> > >
> > > +       opp_tables = kcalloc(num_possible_cpus(), sizeof(*opp_tables), GFP_KERNEL);
> > > +       if (!opp_tables)
> > > +               return -ENOMEM;
> > > +
> >
> > Perhaps add a comment above that that actual opp_table is allocated in
> > the loop below because of dev_pm_opp_set_supported_hw?
> >
> > I was staring at this for a few minutes wondering why you needed this
> > kcalloc before I realised that opp_tables (missed the 's') is a
> > temporary array of pointers. :-)
>
> I feel that you got confused because this patch didn't had the diff
> where the opp_tables thing is getting used. When we see the .c file
> itself, it is pretty much clear on what is going on and I believe the
> comment would be totally unnecessary and redundant.
>
> This is how it looks now, please lemme know if you still prefer the
> comment :)

Perhaps I was just unfamiliar with the dev_pm_opp_set_supported_hw()
API where the actual allocation happens 3 levels deep. Maybe the
comment should apply to dev_pm_opp_set_supported_hw(). I leave it to
you to decide.

>         opp_tables = kcalloc(num_possible_cpus(), sizeof(*opp_tables), GFP_KERNEL);
>         if (!opp_tables)
>                 return -ENOMEM;
>
>         for_each_possible_cpu(cpu) {
>                 cpu_dev = get_cpu_device(cpu);
>                 if (NULL == cpu_dev) {
>                         ret = -ENODEV;
>                         goto free_opp;
>                 }
>
>                 opp_tables[cpu] = dev_pm_opp_set_supported_hw(cpu_dev,
>                                                               &versions, 1);
>                 if (IS_ERR(opp_tables[cpu])) {
>                         ret = PTR_ERR(opp_tables[cpu]);
>                         dev_err(cpu_dev, "Failed to set supported hardware\n");
>                         goto free_opp;
>                 }
>         }
>
>         kfree(opp_tables);
>
>
> --
> viresh
