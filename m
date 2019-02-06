Return-Path: <SRS0=01Bl=QN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0920C169C4
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 18:17:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B062120823
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 18:17:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="JWLwripM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729201AbfBFSRL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Feb 2019 13:17:11 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:39465 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728484AbfBFSRB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Feb 2019 13:17:01 -0500
Received: by mail-pg1-f195.google.com with SMTP id r11so3247410pgp.6
        for <linux-kernel@vger.kernel.org>; Wed, 06 Feb 2019 10:17:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=MhIG2ByH0nfB88vhi3Ju2g4JuRs3GssxeE0tYPDVI3g=;
        b=JWLwripM7cig2N6/Lra2zSRJZA3puuvePaI0FeoUozufAmBTtsF2ulgF8eJJnMBlwx
         Ijo7GUr+Z1HnpbOGUMkPMO16fPpmq/XbGnzJMkw5YyVFm09so+/MLeShpFfC/d68Kc2s
         6PC7OWBH1QdTX3Os9LaA0Sd+PucwM6oEU1SaA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=MhIG2ByH0nfB88vhi3Ju2g4JuRs3GssxeE0tYPDVI3g=;
        b=mpnzJXxnMb3plSXbKRomWb4+ahc8ah75N7f2yQk0dcYA4I+ohsVdN97s1km8Ek0uWP
         BNrhiywm+j3mVzHmxdvJkRAVtQooCdm5Y5S9NY5d5JEf9dUPrmcrOYkwUTLRlkdiQLqV
         ihMaIqXH5vnV8oqnPfF9Uw1ILAHdQAE5+0i1U9d3oJga1XLqnUykPwk1+1mfI3FPgtSh
         lCeTnL8/GEb294TVoYADoVQVE6Eba0GSOXh69UW9zWs80fZ8Aed+JVMU/2Jf1oCm1oRB
         cn8/Dx6cdiCOl5sTsBMrhR7Kqs1wF9J760lzpgrwIwtILiBb/uwyxdPO9ccTZuDJYohF
         CLXQ==
X-Gm-Message-State: AHQUAub/DZ5jtwnxfwghpRfNoNzWaWZWUfEsivTKQaaiGNcVPDKBZGf8
        mr7wPcdHiG7j/2c2PVqTfzRE0A==
X-Google-Smtp-Source: AHgI3IY+Qn+GaBsUDviGTrhL0JwUFojmyAInDmLBAgvqUwEOEvNJ8pySZM6KiT5YYwTQ9N2x7AHnRQ==
X-Received: by 2002:a63:ec13:: with SMTP id j19mr10701296pgh.6.1549477020321;
        Wed, 06 Feb 2019 10:17:00 -0800 (PST)
Received: from localhost ([2620:15c:202:1:75a:3f6e:21d:9374])
        by smtp.gmail.com with ESMTPSA id i12sm7669354pgs.28.2019.02.06.10.16.59
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 06 Feb 2019 10:16:59 -0800 (PST)
Date:   Wed, 6 Feb 2019 10:16:59 -0800
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Quentin Perret <quentin.perret@arm.com>
Cc:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Taniya Das <tdas@codeaurora.org>, CK Hu <ck.hu@mediatek.com>,
        Eddie Huang <eddie.huang@mediatek.com>,
        Nicolas Boichat <drinkcat@chromium.org>,
        Douglas Anderson <dianders@chromium.org>
Subject: Re: [PATCH 2/2] cpufreq: mediatek: Register an Energy Model
Message-ID: <20190206181659.GI117604@google.com>
References: <20190205175225.25923-1-mka@chromium.org>
 <20190205175225.25923-2-mka@chromium.org>
 <20190206101316.fr7z4ffr4ck4l4aj@queper01-lin>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190206101316.fr7z4ffr4ck4l4aj@queper01-lin>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Quentin,

On Wed, Feb 06, 2019 at 10:13:18AM +0000, Quentin Perret wrote:
> Hi Matthias,
> 
> On Tuesday 05 Feb 2019 at 09:52:25 (-0800), Matthias Kaehlcke wrote:
> > Try and register an Energy Model from mediatek-cpufreq to allow
> > interested subsystems like the task scheduler to use the provided
> > information.
> > 
> > Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
> > ---
> >  drivers/cpufreq/mediatek-cpufreq.c | 2 ++
> >  1 file changed, 2 insertions(+)
> > 
> > diff --git a/drivers/cpufreq/mediatek-cpufreq.c b/drivers/cpufreq/mediatek-cpufreq.c
> > index eb8920d398181..e6168ee582783 100644
> > --- a/drivers/cpufreq/mediatek-cpufreq.c
> > +++ b/drivers/cpufreq/mediatek-cpufreq.c
> > @@ -460,6 +460,8 @@ static int mtk_cpufreq_init(struct cpufreq_policy *policy)
> >  		return ret;
> >  	}
> >  
> > +	dev_pm_opp_of_register_em(policy->cpus);
> 
> I'm not familiar with the mediatek-cpufreq driver so bear with me, but
> the code sets policy->cpus just below here. Is there any particular
> reason for not using that in PM_EM ?

You are prefectly right, I missed the obvious and didn't get my hands
on hardware yet for testing.

So much for screwing up a one-liner ... I'll send a fix.

I thought Viresh already applied the patch, however in opp/linux-next
I currently only see the other one of this series for qcom-hw, so it
seems sending a new version rather than a fix-up patch is the way to
go.

Thanks for the review!

> >  	cpumask_copy(policy->cpus, &info->cpus);
> >  	policy->freq_table = freq_table;
> >  	policy->driver_data = info;
> 
> Thanks,
> Quentin
