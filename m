Return-Path: <SRS0=01Bl=QN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20C4DC169C4
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 10:13:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DDD96218A3
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 10:13:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728859AbfBFKNY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Feb 2019 05:13:24 -0500
Received: from foss.arm.com ([217.140.101.70]:50672 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726598AbfBFKNX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Feb 2019 05:13:23 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0590680D;
        Wed,  6 Feb 2019 02:13:23 -0800 (PST)
Received: from queper01-lin (queper01-lin.cambridge.arm.com [10.1.195.48])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 965863F719;
        Wed,  6 Feb 2019 02:13:20 -0800 (PST)
Date:   Wed, 6 Feb 2019 10:13:18 +0000
From:   Quentin Perret <quentin.perret@arm.com>
To:     Matthias Kaehlcke <mka@chromium.org>
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
Message-ID: <20190206101316.fr7z4ffr4ck4l4aj@queper01-lin>
References: <20190205175225.25923-1-mka@chromium.org>
 <20190205175225.25923-2-mka@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190205175225.25923-2-mka@chromium.org>
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Matthias,

On Tuesday 05 Feb 2019 at 09:52:25 (-0800), Matthias Kaehlcke wrote:
> Try and register an Energy Model from mediatek-cpufreq to allow
> interested subsystems like the task scheduler to use the provided
> information.
> 
> Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
> ---
>  drivers/cpufreq/mediatek-cpufreq.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/cpufreq/mediatek-cpufreq.c b/drivers/cpufreq/mediatek-cpufreq.c
> index eb8920d398181..e6168ee582783 100644
> --- a/drivers/cpufreq/mediatek-cpufreq.c
> +++ b/drivers/cpufreq/mediatek-cpufreq.c
> @@ -460,6 +460,8 @@ static int mtk_cpufreq_init(struct cpufreq_policy *policy)
>  		return ret;
>  	}
>  
> +	dev_pm_opp_of_register_em(policy->cpus);

I'm not familiar with the mediatek-cpufreq driver so bear with me, but
the code sets policy->cpus just below here. Is there any particular
reason for not using that in PM_EM ?

>  	cpumask_copy(policy->cpus, &info->cpus);
>  	policy->freq_table = freq_table;
>  	policy->driver_data = info;
> -- 
> 2.20.1.611.gfbb209baf1-goog
> 

Thanks,
Quentin
