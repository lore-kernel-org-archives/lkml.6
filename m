Return-Path: <SRS0=Jh2l=L4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8073BFC6182
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 08:29:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1EFF520882
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 08:29:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1EFF520882
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728180AbeINNnJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Sep 2018 09:43:09 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:41112 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727649AbeINNnJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Sep 2018 09:43:09 -0400
Received: from 79.184.255.178.ipv4.supernova.orange.pl (79.184.255.178) (HELO aspire.rjw.lan)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.148)
 id 445fb4ad9bb43d48; Fri, 14 Sep 2018 10:29:43 +0200
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Rob Herring <robh@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Viresh Kumar <viresh.kumar@linaro.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH] cpufreq: Convert to using %pOFn instead of device_node.name
Date:   Fri, 14 Sep 2018 10:27:03 +0200
Message-ID: <2755190.UQhmFvc9f1@aspire.rjw.lan>
In-Reply-To: <20180828015252.28511-14-robh@kernel.org>
References: <20180828015252.28511-1-robh@kernel.org> <20180828015252.28511-14-robh@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday, August 28, 2018 3:52:15 AM CEST Rob Herring wrote:
> In preparation to remove the node name pointer from struct device_node,
> convert printf users to use the %pOFn format specifier.
> 
> Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
> Cc: Viresh Kumar <viresh.kumar@linaro.org>
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-samsung-soc@vger.kernel.org
> Cc: linux-pm@vger.kernel.org
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
>  drivers/cpufreq/s5pv210-cpufreq.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/cpufreq/s5pv210-cpufreq.c b/drivers/cpufreq/s5pv210-cpufreq.c
> index 5d31c2db12a3..dbecd7667db2 100644
> --- a/drivers/cpufreq/s5pv210-cpufreq.c
> +++ b/drivers/cpufreq/s5pv210-cpufreq.c
> @@ -611,8 +611,8 @@ static int s5pv210_cpufreq_probe(struct platform_device *pdev)
>  	for_each_compatible_node(np, NULL, "samsung,s5pv210-dmc") {
>  		id = of_alias_get_id(np, "dmc");
>  		if (id < 0 || id >= ARRAY_SIZE(dmc_base)) {
> -			pr_err("%s: failed to get alias of dmc node '%s'\n",
> -				__func__, np->name);
> +			pr_err("%s: failed to get alias of dmc node '%pOFn'\n",
> +				__func__, np);
>  			of_node_put(np);
>  			return id;
>  		}
> 

Applied, thanks!


