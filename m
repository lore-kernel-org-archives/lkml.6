Return-Path: <SRS0=UfG/=NY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88768C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 17:59:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E3BC208A3
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 17:59:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gfHfdwnN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4E3BC208A3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732177AbeKND6J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Nov 2018 22:58:09 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:38661 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731625AbeKND6J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Nov 2018 22:58:09 -0500
Received: by mail-lf1-f67.google.com with SMTP id p86so9515748lfg.5;
        Tue, 13 Nov 2018 09:58:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=3KuNfLo201mbVqRVMv5T3hy2BLkbeIaUI/sYn1L1224=;
        b=gfHfdwnNVfckrjjq2hOu++5y+0VFPMpGeZn1RR9DjizqoTzwbYzj5rJ3vI5QtNOgjD
         IbjWgLoylhNo2vPxeaWA40qyzymd1QDnld6sTYN//995M1uLGq0fwxGO331atWg8GxxE
         WTcPG3Ic5C30Cv9/8KaNUIEvgWInne7j8xIMXokFM8GjtGbrQlmSWR6t19fhHizj5AJM
         +jkdxWyVIZaI3O7r7RNcpqKDXSFswi0CBaiMFFEayiXlRjOwf1+6DzxpJ/0psQLGDnDJ
         NghoilxRIuqCxwVKAFxNOjkkDBP1ZbOSq/2/3wyErVXaJ4wC6XfPfK0wHmM0dmbpiz0C
         P4LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=3KuNfLo201mbVqRVMv5T3hy2BLkbeIaUI/sYn1L1224=;
        b=PF7Chxt1FlDd9dpz1S9kq8uKSAsX0Phdl7afJR+LF8uVG1SS+6jzTZx0NsATbLG9na
         2KVJels2snoBOJ/ssEX4YdVgrK5gbcX9FA6+B0jSmhd6Ezp0f/0ke1zMLBcUritw6xo9
         QXudHjo5fyBHucZbiyCOa6JL6FfxqwYnMS1IPHWKhZ1Qa3CGqAe6KdPJteqHtpdD3ltq
         zMvvZBDOTg+6oLuwQ2Cfdhjx4hPayS1loLIuo6ta15bPqKtRsP3vuPaCSz8U2BbvzEAw
         iMsoZWv8FJKZCxD3UtaYVg24uPU58nVytpf+ai1Tku5TrWNauWM/wVzA6ZvjIsfrUeX6
         DK7A==
X-Gm-Message-State: AGRZ1gI9cCAdxMUabQ/o2XlHErSMYdZXRAxKjEm/U208mQSYxNGOCvZr
        xebWTxJHsZr/3BI1DmzkfT8=
X-Google-Smtp-Source: AJdET5eJ/rpw+esrbaxWg++/tx3nFW5RVz5BnK9tSVZnDxOKV5ty0Y75fJO4+kxolX4FYDUzniUREA==
X-Received: by 2002:a19:e30f:: with SMTP id a15mr3441288lfh.66.1542131937121;
        Tue, 13 Nov 2018 09:58:57 -0800 (PST)
Received: from xi.terra (c-74bee655.07-184-6d6c6d4.bbcust.telenor.se. [85.230.190.116])
        by smtp.gmail.com with ESMTPSA id i78sm3521405lfa.9.2018.11.13.09.58.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 13 Nov 2018 09:58:56 -0800 (PST)
Received: from johan by xi.terra with local (Exim 4.91)
        (envelope-from <johan@kernel.org>)
        id 1gMcxh-00042s-Oj; Tue, 13 Nov 2018 18:58:53 +0100
Date:   Tue, 13 Nov 2018 18:58:53 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Dave Gerlach <d-gerlach@ti.com>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Keerthy J <j-keerthy@ti.com>, Tero Kristo <t-kristo@ti.com>,
        Tony Lindgren <tony@atomide.com>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Johan Hovold <johan@kernel.org>
Subject: Re: [PATCH v3] cpufreq: ti-cpufreq: Only register platform_device
 when supported
Message-ID: <20181113175853.GN13311@localhost>
References: <20181113173912.27643-1-d-gerlach@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181113173912.27643-1-d-gerlach@ti.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 13, 2018 at 11:39:12AM -0600, Dave Gerlach wrote:
> Currently the ti-cpufreq driver blindly registers a 'ti-cpufreq' to force
> the driver to probe on any platforms where the driver is built in.
> However, this should only happen on platforms that actually can make use
> of the driver. There is already functionality in place to match the
> SoC compatible so let's factor this out into a separate call and
> make sure we find a match before creating the ti-cpufreq platform device.
> 
> Reviewed-by: Johan Hovold <johan@kernel.org>
> Signed-off-by: Dave Gerlach <d-gerlach@ti.com>
> ---
> v2->v3: Use platform_device_register_resndata to pass match data to probe to
> 	to avoid matching again in probe.
> 
> 	v2: https://patchwork.kernel.org/patch/10574535/
> 

>  static int ti_cpufreq_init(void)
>  {
> -	platform_device_register_simple("ti-cpufreq", -1, NULL, 0);
> +	const struct of_device_id *match;
> +
> +	/* Check to ensure we are on a compatible platform */
> +	match = ti_cpufreq_match_node();
> +	if (match)
> +		platform_device_register_resndata(NULL, "ti-cpufreq", -1, NULL,
> +						  0, match,
> +						  sizeof(*match));

platform_device_register_data()?

>  	return 0;
>  }
>  module_init(ti_cpufreq_init);

Johan
