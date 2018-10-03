Return-Path: <SRS0=e9m6=MP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D831CC00449
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 05:23:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 97FDE20878
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 05:23:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i1lHqaRY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 97FDE20878
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726757AbeJCMJ4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Oct 2018 08:09:56 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:39671 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726405AbeJCMJz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Oct 2018 08:09:55 -0400
Received: by mail-lf1-f68.google.com with SMTP id w21-v6so3157288lff.6;
        Tue, 02 Oct 2018 22:23:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rsBDQSbj4zao1eWyJkrt9hNhiIKtQun5JshHjLgdAGc=;
        b=i1lHqaRYblC05e0IBPfYNcODknCUHxxN8INFHZunRN4Dbkky1zKQfbmNxCYvwiXQyN
         Yvi6ixqsSJ9hapUXh6Y6jTr2BZ9VarsjwMm065nkYENErld9G9vbj/o/9mMKe9k/oqO4
         PSfGj2qM9SnH3qHQkWVFPXXmX/abXybvb5bYziNZSdXJld3/j1eGW39tFHu5jqZ8fIJk
         4nW9WUQbYAVjyEDRaGjYTPgparTlCQq3nJgFQc2KBA9fp2nHUAtFTuBajfIiU+QC0Mjz
         /XwR0nOgnth8u7/87o+rSUghQCm1C3oWJPOK4q6YogJzX5waq3RwHKYVkBUTcJlGYHVE
         QzOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rsBDQSbj4zao1eWyJkrt9hNhiIKtQun5JshHjLgdAGc=;
        b=PmmzyAE2gR+mAUYqLIZ+lDVubGm+m+FrkpmGm88Bc6X/8fcOzoKwbBSb1sTOiPK8bL
         ajcC0HvDRh06Zse60aG+BfkzzEiDj7od6kfgW0m9ucrwWyxdJkzWBT3EJ94/1Mh/6qjV
         1URvENii95nC2Sd8l3aP8QaKDE2+DIB6pk1tlqMJETeoowP0AR0DePfo2bGSoMj4CVhy
         WorVimIk1gc2ryOIQimuda06uyS2pk95lQvKO6sM9XCCGGkAZsYTd3Y0hI9k+6ojHveN
         OHxuVd1B9W2o8LZ5uaUMeXQv78R6WXG1AA2pTb4a2YT2lDZgmiXLfX0/W3+UqK+Hrjg3
         7BMA==
X-Gm-Message-State: ABuFfojQzx8s5tjCZqk8z7OcfSHdNIyozMfcbz3etB4ebK/WQD3eW09l
        Tqb9fBVxfTyE5pLjw7WgbICe7FLJ03H/miFXPhc=
X-Google-Smtp-Source: ACcGV60DcnktpvTmPxf8PJxMe2UGJqIFPa2bpvr72Ef4xbqkOtJzVnDfYmgmkAvwL/WH4cA/Jy8/wU9AbWQP3W+ZAuU=
X-Received: by 2002:a19:f817:: with SMTP id a23-v6mr9613063lff.67.1538544186292;
 Tue, 02 Oct 2018 22:23:06 -0700 (PDT)
MIME-Version: 1.0
References: <20181001202153.GA240123@dtor-ws> <20181003044150.i46eaoyco3w47nid@vireshk-i7>
In-Reply-To: <20181003044150.i46eaoyco3w47nid@vireshk-i7>
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
Date:   Tue, 2 Oct 2018 22:22:54 -0700
Message-ID: <CAKdAkRR1UprR6d4ObZagpHEtPXi8eotG+qd=2NM1kOvFKzOxXg@mail.gmail.com>
Subject: Re: [PATCH] cpufreq: dt-platdev: mark RK3399 as having separate
 policies per cluster
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>,
        Derek Basehore <dbasehore@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 2, 2018 at 9:41 PM Viresh Kumar <viresh.kumar@linaro.org> wrote:
>
> On 01-10-18, 13:21, Dmitry Torokhov wrote:
> > RK3399 has one cluster with 4 small cores, and another one with 2 big
> > cores, with cores in different clusters having different OPPs and thus
> > different policies. Let's enable this via "have_governor_per_policy"
> > platform data.
>
> The policies are always different in such cases, with or without this flag. What
> this flag rather enables is for us to have separate set of tunables for the
> governor for individual policies.
>
> For example, without this flag there will be a single governor directory:
>
> /sys/devices/system/cpu/cpufreq/schedutil/
>
> and the value of tunables in that directory will be used for all cpufreq
> policies.
>
> With this flag you wouldn't have the governor directory there, but rather in:
>
> /sys/devices/system/cpu/cpufreq/policy*/schedutil/
>
> i.e. tunables per policy and that's why the name of the flag is:
> have_governor_per_policy.
>
> > Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> > ---
> >
> > Not tested, but we had a patch unconditionally enabling
> > CPUFREQ_HAVE_GOVERNOR_PER_POLICY flag in tree we used to ship devices
> > based on RK3399 platform.
>
> Sure, that sounds good. Just that you need to update the commit log a bit.

OK, I'll do that.

>
> >  drivers/cpufreq/cpufreq-dt-platdev.c | 5 ++++-
> >  1 file changed, 4 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/cpufreq/cpufreq-dt-platdev.c b/drivers/cpufreq/cpufreq-dt-platdev.c
> > index fe14c57de6ca..040ec0f711f9 100644
> > --- a/drivers/cpufreq/cpufreq-dt-platdev.c
> > +++ b/drivers/cpufreq/cpufreq-dt-platdev.c
> > @@ -78,7 +78,10 @@ static const struct of_device_id whitelist[] __initconst = {
> >       { .compatible = "rockchip,rk3328", },
> >       { .compatible = "rockchip,rk3366", },
> >       { .compatible = "rockchip,rk3368", },
> > -     { .compatible = "rockchip,rk3399", },
> > +     { .compatible = "rockchip,rk3399",
> > +       .data = &(struct cpufreq_dt_platform_data)
>
> data is void *. No need to provide typecast information. This shouldn't throw
> any build warnings I believe.

We however need to tell the compiler the type of structure we are
creating. The following won't compile:

        .data = &{ .have_governor_per_policy = true, }

Thanks.

-- 
Dmitry
