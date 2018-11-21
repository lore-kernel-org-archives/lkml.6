Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3312C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 06:51:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A90321104
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 06:51:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="ZugJB7K8";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="SReTCA0i"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7A90321104
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727787AbeKURYk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Nov 2018 12:24:40 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:43300 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726773AbeKURYj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Nov 2018 12:24:39 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 9FAFC60B0D; Wed, 21 Nov 2018 06:51:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1542783084;
        bh=zTwqJGp2VMfcTdsau9v3/UuTejjkYII1F00I5Uz2JQg=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=ZugJB7K8tvyqCTFiqVi1VUJpYUrWA7w473HZZ+TeJ7V8RxzeDF/5zU54hVlWYGZg0
         idAjQDl1nSXbOv7YifZH7YKjI8vWZ/MIDweueyW8IXuyC4HcAoLLaW5HJ6SXJFsVjl
         2NwPQ5D7bd8axdBey3BfShCSh1IfMffjLjYwhMTo=
Received: from [10.79.128.198] (blr-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.18.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: rnayak@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 82DE860227;
        Wed, 21 Nov 2018 06:51:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1542783083;
        bh=zTwqJGp2VMfcTdsau9v3/UuTejjkYII1F00I5Uz2JQg=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=SReTCA0item2JQ2KorUhi97gyVgEYG0rzgxGgC1BcgI5ightkpgvoQvCcymWi1SF5
         +fBqN4Aw3H+Iphg4kdpbKTyn0D2MipXr9BfChdCqUVvg/6CM7cho0d0SPrYMh3cGL1
         PY9rBpFqjtOnZKVlf1BAkp0TByxlp4S09YEZh7t4=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 82DE860227
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=rnayak@codeaurora.org
Subject: Re: [PATCH 4/4] PM / Domains: Propagate performance state updates
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     ulf.hansson@linaro.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Kevin Hilman <khilman@kernel.org>,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
        linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>, Nishanth Menon <nm@ti.com>,
        niklas.cassel@linaro.org, linux-kernel@vger.kernel.org
References: <cover.1541399301.git.viresh.kumar@linaro.org>
 <7e1ea283f9eebce081af80ddb8d3ca5c9c76cd3b.1541399301.git.viresh.kumar@linaro.org>
 <71530b01-eefa-4778-0b17-d7774eb48356@codeaurora.org>
 <20181121051626.izb6dem62zoaf2c4@vireshk-i7>
 <68a3294f-5556-4b5f-f8c7-79c20b5c70fb@codeaurora.org>
 <5efc76bb-7732-52b6-4684-82b35ad52343@codeaurora.org>
 <20181121063646.37bha3vomxvzazzn@vireshk-i7>
From:   Rajendra Nayak <rnayak@codeaurora.org>
Message-ID: <bd5b94fb-ed9a-7745-a0cd-cfc3b81d676f@codeaurora.org>
Date:   Wed, 21 Nov 2018 12:21:18 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <20181121063646.37bha3vomxvzazzn@vireshk-i7>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/21/2018 12:06 PM, Viresh Kumar wrote:
> On 21-11-18, 11:12, Rajendra Nayak wrote:
>> And the reason for that seems to be that we update the genpd status to GPD_STATE_ACTIVE
>> *after* we try to set the performance state, so we always hit this check which bails out
>> thinking the genpd is not ON.
> 
> Thanks for looking at it. Here is the (untested) fix, please try it
> out.

Thanks, yes, this does seem to work.

> 
> diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
> index 84c13695af65..92be4a224b45 100644
> --- a/drivers/base/power/domain.c
> +++ b/drivers/base/power/domain.c
> @@ -250,9 +250,6 @@ static int _genpd_set_performance_state(struct generic_pm_domain *genpd,
>          unsigned int mstate;
>          int ret;
>   
> -       if (!genpd_status_on(genpd))
> -               goto out;
> -
>          /* Propagate to masters of genpd */
>          list_for_each_entry(link, &genpd->slave_links, slave_node) {
>                  master = link->master;
> @@ -286,7 +283,6 @@ static int _genpd_set_performance_state(struct generic_pm_domain *genpd,
>          if (ret)
>                  goto err;
>   
> -out:
>          genpd->performance_state = state;
>          return 0;
>   
> @@ -361,6 +357,11 @@ static int _genpd_reeval_performance_state(struct generic_pm_domain *genpd,
>                  return 0;
>   
>   update_state:
> +       if (!genpd_status_on(genpd)) {
> +               genpd->performance_state = state;
> +               return 0;
> +       }
> +
>          return _genpd_set_performance_state(genpd, state, depth);
>   }
> 
