Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EE82C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 03:45:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB2DB2086A
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 03:45:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zW1/ppks"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727032AbfBUDpm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 22:45:42 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:35453 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726016AbfBUDpm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 22:45:42 -0500
Received: by mail-pl1-f194.google.com with SMTP id p19so2200024plo.2
        for <linux-kernel@vger.kernel.org>; Wed, 20 Feb 2019 19:45:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=QR9p8rA4rhCD98l9OZ/jpYvZPBH6YgsVN3A8lJve7Kg=;
        b=zW1/ppksQ3WQkcz6hwzXRX8NK/l+y3T9YGpe/vIZLJsd4hHltiRE1NTT1HrCPWhwVm
         C+PnPTglx7YX1D4f6TW2yCGoMoE5obgu/e6AD0p7P9e17UUDgBHRq0EJ9wy5FRS6+R6U
         yJuEuOT0x1sif7MF8mYpzHmYvAyDejJMxjxN5QG4CxocFZPeJLi468zd368S3hYgcoDl
         ySFLJZe+ot1yb7rfUKmuE+SHbSOKjc2FMp38rtNOechzdWQi68HzYgZmzl72c1csb8tt
         5uFQFCreZzX7U6QVJVoyI80dulezEufZTau1JxoPhSX8/eo//kKPQcCnSmF1NZSys0K7
         qftw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=QR9p8rA4rhCD98l9OZ/jpYvZPBH6YgsVN3A8lJve7Kg=;
        b=YpP6Nw5PRhfYOuG8s3ZvCc4bQ3yKj+9OabYFyY1/fcxUij9o2as7Oe6g6Cf8WT5o0o
         IJUYxeIh5+zEEyN43jYWWm6c3n0Vkendqc7ArOXiQppBhr97DBaEBCVPYDNNr46i8soO
         sg+bHGk39PpIzqyvMYwt2i+hj1KQFenBSrIb/PephCokIEcw6dVgLmp6/Jp3VWH3uljX
         ACq1F3DZsmrJdu2Lj+g5Eou7/w2dOWLo8D0qGo4RdoOTfPL76dvK5zRyJ+h68eTqaC7Z
         OnYMLYRnX75yEeznt2wZFggve0bbVIlHMnQMT9rduXEhHGDc6gQRpZJZI0nbqAMDEgi7
         iwwQ==
X-Gm-Message-State: AHQUAuagwI3IeeE0HmakAdb4d9WErQPKR1c87A10QcfJyjtrbiyRJ8jj
        84Ec1drQiBxVw34WHBzrisPHLA==
X-Google-Smtp-Source: AHgI3IaiwsBFS1Qmv3mvCA8Y015/mh51dKlq8y7xexufN6ZzeIS02jKILjyW98UUfokghs8gJMVZtg==
X-Received: by 2002:a17:902:6686:: with SMTP id e6mr40109014plk.208.1550720740766;
        Wed, 20 Feb 2019 19:45:40 -0800 (PST)
Received: from localhost ([122.172.102.63])
        by smtp.gmail.com with ESMTPSA id o2sm27712261pgq.29.2019.02.20.19.45.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 20 Feb 2019 19:45:38 -0800 (PST)
Date:   Thu, 21 Feb 2019 09:15:34 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Amit Kucheria <amit.kucheria@linaro.org>
Cc:     Rafael Wysocki <rjw@rjwysocki.net>, Ilia Lin <ilia.lin@kernel.org>,
        Linux PM list <linux-pm@vger.kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] cpufreq: kyro: Reduce frame-size of
 qcom_cpufreq_kryo_probe()
Message-ID: <20190221034534.n5jli3bj4mwtoudd@vireshk-i7>
References: <5919a74b74f466e803e07f70136517119dcd4560.1550661235.git.viresh.kumar@linaro.org>
 <CAP245DWuJTXfAc3QyqXjePqy32GHQsEqHbuSvjiS4EE3-TV1PA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAP245DWuJTXfAc3QyqXjePqy32GHQsEqHbuSvjiS4EE3-TV1PA@mail.gmail.com>
User-Agent: NeoMutt/20180323-120-3dd1ac
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20-02-19, 21:56, Amit Kucheria wrote:
> On Wed, Feb 20, 2019 at 4:44 PM Viresh Kumar <viresh.kumar@linaro.org> wrote:
> >
> > With the introduction of commit 846a415bf440 ("arm64: default NR_CPUS to
> > 256"), we have started getting following compilation warning:
> >
> > qcom-cpufreq-kryo.c:168:1: warning: the frame size of 2160 bytes is larger than 2048 bytes [-Wframe-larger-than=]
> >
> > Fix that by dynamically allocating opp_tables and freeing it later.
> >
> > Compile tested only.
> >
> > Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> > ---
> >  drivers/cpufreq/qcom-cpufreq-kryo.c | 9 ++++++++-
> >  1 file changed, 8 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/cpufreq/qcom-cpufreq-kryo.c b/drivers/cpufreq/qcom-cpufreq-kryo.c
> > index 1c8583cc06a2..6888cb6db2ef 100644
> > --- a/drivers/cpufreq/qcom-cpufreq-kryo.c
> > +++ b/drivers/cpufreq/qcom-cpufreq-kryo.c
> > @@ -75,7 +75,7 @@ static enum _msm8996_version qcom_cpufreq_kryo_get_msm_id(void)
> >
> >  static int qcom_cpufreq_kryo_probe(struct platform_device *pdev)
> >  {
> > -       struct opp_table *opp_tables[NR_CPUS] = {0};
> > +       struct opp_table **opp_tables;
> >         enum _msm8996_version msm8996_version;
> >         struct nvmem_cell *speedbin_nvmem;
> >         struct device_node *np;
> > @@ -133,6 +133,10 @@ static int qcom_cpufreq_kryo_probe(struct platform_device *pdev)
> >         }
> >         kfree(speedbin);
> >
> > +       opp_tables = kcalloc(num_possible_cpus(), sizeof(*opp_tables), GFP_KERNEL);
> > +       if (!opp_tables)
> > +               return -ENOMEM;
> > +
> 
> Perhaps add a comment above that that actual opp_table is allocated in
> the loop below because of dev_pm_opp_set_supported_hw?
> 
> I was staring at this for a few minutes wondering why you needed this
> kcalloc before I realised that opp_tables (missed the 's') is a
> temporary array of pointers. :-)

I feel that you got confused because this patch didn't had the diff
where the opp_tables thing is getting used. When we see the .c file
itself, it is pretty much clear on what is going on and I believe the
comment would be totally unnecessary and redundant.

This is how it looks now, please lemme know if you still prefer the
comment :)

        opp_tables = kcalloc(num_possible_cpus(), sizeof(*opp_tables), GFP_KERNEL);
        if (!opp_tables)
                return -ENOMEM;

        for_each_possible_cpu(cpu) {
                cpu_dev = get_cpu_device(cpu);
                if (NULL == cpu_dev) {
                        ret = -ENODEV;
                        goto free_opp;
                }

                opp_tables[cpu] = dev_pm_opp_set_supported_hw(cpu_dev,
                                                              &versions, 1);
                if (IS_ERR(opp_tables[cpu])) {
                        ret = PTR_ERR(opp_tables[cpu]);
                        dev_err(cpu_dev, "Failed to set supported hardware\n");
                        goto free_opp;
                }
        }

        kfree(opp_tables);


-- 
viresh
