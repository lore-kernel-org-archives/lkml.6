Return-Path: <SRS0=bZNE=OE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E55DEC43441
	for <linux-kernel@archiver.kernel.org>; Sun, 25 Nov 2018 09:43:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F3B620855
	for <linux-kernel@archiver.kernel.org>; Sun, 25 Nov 2018 09:43:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="CV7GtshK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9F3B620855
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727348AbeKYUeZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 25 Nov 2018 15:34:25 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:46139 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726526AbeKYUeY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Nov 2018 15:34:24 -0500
Received: by mail-wr1-f66.google.com with SMTP id l9so15894825wrt.13
        for <linux-kernel@vger.kernel.org>; Sun, 25 Nov 2018 01:43:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=px6NC8KdvxGNBQSBF1q3oBpxk80QLEMbTgJ4mhve4Sk=;
        b=CV7GtshKHnSKhf62NQD6COid+4ccPkJWLg6wtq8b86hEvsxyEqisfoBmyz8+LGH33M
         tLBIyH11eXWIIV6Tac+0pLETX8yjnOuGvo7C/+IZ8G6QQxBMTAgCF2B+pfe/3P1JSCHu
         e5RGHo4dAnkBjk46O1hz9NFWzSy2UpszHSDPk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=px6NC8KdvxGNBQSBF1q3oBpxk80QLEMbTgJ4mhve4Sk=;
        b=sq3lvJWFCGB050u7mh3MIu1L5tfdmiNmWqSOTRFxFoG0nAh6+b2fjJx/YXsyPKN4HP
         gjO4kJ/OnaKk9+XpNuk+LjRDPGYAx1ZQsgAXpM+XUvfidio+9HYnlXI9IItpXOcS3z4H
         HrYNk0qJZkJKnVfwxSckvV/a99vCdR0i/0xWIjca90vP7VGgskQoz3fWZDnYAlCLjQ90
         ucOtcR5orPkHSE9ERCXFmRRs+0D4v9Qq7uGOol/sbjkM17Yrh1hiHDmkNTAqvkpAFfN0
         LWOXROOJO3DXH77n7bl8/XDfqYzngUIKTk93tlghy+DZCRnpEYxCafSPjQBEYfH++b02
         +7EA==
X-Gm-Message-State: AA+aEWafx4Pyq4e4lyYZyAGY3ZgT1ncXV7rtjj/rF7xeznaJyGZhcFSx
        2ZGgpPm281dDE12rhkq2Tf9oSvtihEY=
X-Google-Smtp-Source: AFSGD/WsCpvC1RfMAkD8K+v25dffZA4jgDt/3LJwEF00kAVVt7liaDYDvPNYWV/gcd+WQv1N82c3Zg==
X-Received: by 2002:a5d:44d1:: with SMTP id z17mr19389608wrr.271.1543139021494;
        Sun, 25 Nov 2018 01:43:41 -0800 (PST)
Received: from [192.168.0.40] (85.64.136.77.rev.sfr.net. [77.136.64.85])
        by smtp.googlemail.com with ESMTPSA id o81sm15474160wmd.10.2018.11.25.01.43.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 25 Nov 2018 01:43:40 -0800 (PST)
Subject: Re: [PATCH v2] clocksource/drivers/integrator-ap: add missing
 of_node_put()
To:     Yangtao Li <tiny.windzz@gmail.com>, tglx@linutronix.de
Cc:     linux-kernel@vger.kernel.org
References: <20181125050049.29685-1-tiny.windzz@gmail.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <f4772a69-12c4-f79e-4ac2-4fe3add96f91@linaro.org>
Date:   Sun, 25 Nov 2018 10:43:39 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181125050049.29685-1-tiny.windzz@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25/11/2018 06:00, Yangtao Li wrote:
> of_find_node_by_path() acquires a reference to the node
> returned by it and that reference needs to be dropped by its caller.
> integrator_ap_timer_init_of() doesn't do that.The pri_node and the
> sec_node are used as an identifier to compare against the current node,
> we can directly drop the refcount after getting the node from path as
> it is not used aspointer. In addition, a single variable is needed,
> so fix it.

I can apply the patch after adding a comment in the code below or
alternatively you can resend a V3 after adding a comment yourself.

What is your preference?

> Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
> ---
> Changes in v2:
> -update changeelog
> -simplify fix
> -change two variable to one
> ---
>  drivers/clocksource/timer-integrator-ap.c | 22 +++++++++++++---------
>  1 file changed, 13 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/clocksource/timer-integrator-ap.c b/drivers/clocksource/timer-integrator-ap.c
> index 76e526f58620..bbd0977d579a 100644
> --- a/drivers/clocksource/timer-integrator-ap.c
> +++ b/drivers/clocksource/timer-integrator-ap.c
> @@ -181,8 +181,7 @@ static int __init integrator_ap_timer_init_of(struct device_node *node)
>  	int irq;
>  	struct clk *clk;
>  	unsigned long rate;
> -	struct device_node *pri_node;
> -	struct device_node *sec_node;
> +	struct device_node *alias_node;
>  
>  	base = of_io_request_and_map(node, 0, "integrator-timer");
>  	if (IS_ERR(base))
> @@ -204,7 +203,14 @@ static int __init integrator_ap_timer_init_of(struct device_node *node)
>  		return err;
>  	}
>  
> -	pri_node = of_find_node_by_path(path);
> +	alias_node = of_find_node_by_path(path);
> +
> +	/* Drop the refcount of node */
> +	of_node_put(alias_node);
> +
> +	if (node == alias_node)
> +		/* The primary timer lacks IRQ, use as clocksource */
> +		return integrator_clocksource_init(rate, base);
>  
>  	err = of_property_read_string(of_aliases,
>  				"arm,timer-secondary", &path);
> @@ -213,14 +219,12 @@ static int __init integrator_ap_timer_init_of(struct device_node *node)
>  		return err;
>  	}
>  
> +	alias_node = of_find_node_by_path(path);
>  
> -	sec_node = of_find_node_by_path(path);
> -
> -	if (node == pri_node)
> -		/* The primary timer lacks IRQ, use as clocksource */
> -		return integrator_clocksource_init(rate, base);
> +	/* Drop the refcount of node */
> +	of_node_put(alias_node);
>  
> -	if (node == sec_node) {
> +	if (node == alias_node) {
>  		/* The secondary timer will drive the clock event */
>  		irq = irq_of_parse_and_map(node, 0);
>  		return integrator_clockevent_init(rate, base, irq);
> 


-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

