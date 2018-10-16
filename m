Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A10EFC04EBD
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 12:51:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F76D2089E
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 12:51:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5F76D2089E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727111AbeJPUlY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 16:41:24 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:38349 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726986AbeJPUlY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 16:41:24 -0400
Received: by mail-wr1-f65.google.com with SMTP id a13-v6so25384692wrt.5
        for <linux-kernel@vger.kernel.org>; Tue, 16 Oct 2018 05:51:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=5p7cviuQBK0R+K3mE0Ykz7J45zD9UyW6xF0PfbGvwNQ=;
        b=cQpdRgoLOubRxaRQGK+46U2old2QZq+FLcCWHE0TR4RLnlojg+9HswdcWtrr16Bpak
         28uD0Dz54rzbSFmcM9owcWkRoZY7ai8rmWwQZZcSQg2VXOvmMXmw0kRecyguS7PBywC+
         fM3PCKQVqzupJRUa/inPibquJ+cFz1G2wOD/stTs7FkKMsU2/wOrF81JHhpXd2GUeuGj
         C521TXTyiXmYF5undMUrhguof9q0+b5HhO0oz3mSgt71blx+Yeaj7Gf+WIfjUVkJTxz9
         ARixYuuunFsgJLymNRdlyUD2zj4pGSbqSBFsQ/Q/aJWEOmWN7/kv2xx+AOxmL1oWROZ+
         ahVg==
X-Gm-Message-State: ABuFfoiIcu5G3lXx5xkuc8fD21ay7otg5hIGNXKf+v/e+tbMn8oI9/wf
        kX/qNO8WBWBxrE1d3m9NKDMDOA==
X-Google-Smtp-Source: ACcGV62pPSyaMh7srn9zH7kQ3KpAdHoS5ydd2yM4xGhnU0+iVqwI71zxq0QxfuHRirN4uZ1gJc4/8Q==
X-Received: by 2002:a5d:484e:: with SMTP id n14-v6mr18069513wrs.234.1539694262307;
        Tue, 16 Oct 2018 05:51:02 -0700 (PDT)
Received: from localhost.localdomain (p200300EF2BD31613C1F2E846AEDA540D.dip0.t-ipconnect.de. [2003:ef:2bd3:1613:c1f2:e846:aeda:540d])
        by smtp.gmail.com with ESMTPSA id w4-v6sm10768765wra.83.2018.10.16.05.51.00
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 16 Oct 2018 05:51:01 -0700 (PDT)
Date:   Tue, 16 Oct 2018 14:50:58 +0200
From:   Juri Lelli <juri.lelli@redhat.com>
To:     Quentin Perret <quentin.perret@arm.com>
Cc:     peterz@infradead.org, rjw@rjwysocki.net,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        gregkh@linuxfoundation.org, mingo@redhat.com,
        dietmar.eggemann@arm.com, morten.rasmussen@arm.com,
        chris.redpath@arm.com, patrick.bellasi@arm.com,
        valentin.schneider@arm.com, vincent.guittot@linaro.org,
        thara.gopinath@linaro.org, viresh.kumar@linaro.org,
        tkjos@google.com, joel@joelfernandes.org, smuckle@google.com,
        adharmap@codeaurora.org, skannan@codeaurora.org,
        pkondeti@codeaurora.org, edubezval@gmail.com,
        srinivas.pandruvada@linux.intel.com, currojerez@riseup.net,
        javi.merino@kernel.org
Subject: Re: [PATCH v8 10/15] sched: Introduce a sysctl for Energy Aware
 Scheduling
Message-ID: <20181016125058.GD9130@localhost.localdomain>
References: <20181016101513.26919-1-quentin.perret@arm.com>
 <20181016101513.26919-11-quentin.perret@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181016101513.26919-11-quentin.perret@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 16/10/18 11:15, Quentin Perret wrote:

[...]

> diff --git a/kernel/sysctl.c b/kernel/sysctl.c
> index cc02050fd0c4..481309a11174 100644
> --- a/kernel/sysctl.c
> +++ b/kernel/sysctl.c
> @@ -466,6 +466,17 @@ static struct ctl_table kern_table[] = {
>  		.extra1		= &one,
>  	},
>  #endif
> +#if defined(CONFIG_ENERGY_MODEL) && defined(CONFIG_CPU_FREQ_GOV_SCHEDUTIL)
> +	{
> +		.procname	= "sched_energy_aware",
> +		.data		= &sysctl_sched_energy_aware,
> +		.maxlen		= sizeof(unsigned int),
> +		.mode		= 0644,
> +		.proc_handler	= sched_energy_aware_handler,
> +		.extra1		= &zero,
> +		.extra2		= &one,
> +	},
> +#endif

Doesn't this need to be documented in Documentation/sysctl/kernel.txt?

Also, do we want a kernel parameter as well to be able to disable this
at boot?

Best,

- Juri
