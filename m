Return-Path: <quentin.perret@arm.com>
X-Google-Smtp-Source: AH8x227/afzoi34y9n0itlxnqU4i1c5bCDaidrrLNSLYGIg67QvzpCTnoeGNB84uGgv6zGRpouaO
ARC-Seal: i=1; a=rsa-sha256; t=1519290251; cv=none;
        d=google.com; s=arc-20160816;
        b=d7RTDBIG1MOHP6/Kz5D9E+wykqJRn6jOtG2Mhp5WWIlpk6vOmYZGZkepo3qQs5HRJ6
         tcpRp41FNqI3KhIPzuWAC+9hFXPVOTxlq2ytrjCbao2wHEFPpp7UBsSk9DFUBEAiv8vs
         80dKdXiCTy1PNKSw/+rpZdkI1YemDAbd6gQ8iLjHeOrU6kPZeiROLcjKuy/kLV6CguI4
         83D7htR5ujbBrKS48tU6T461ey3nH3Wug1pofZe5bgehf7lDYiU3vHSZujRSlTs3KqGv
         RExUthOyCeLzL8kIwLC6d0GRapRMIQtCU3/fYbeRs8pFuL7xPvFnPPMQkYCTaV2D4EqB
         fgxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:arc-authentication-results;
        bh=59ZxhAW+gfgWytezH7a/dqk8aqFPFEMj6ncoE5drVX8=;
        b=KRfi2R6bcy2kKOI3Bb2yin0tYN8J+qmpgDYSuYJMsOwhEuUVVGc5/8DpsnIeDNhsB+
         PfdnR7sNSrCpcVD1XyWkWaR2rgFWajKICo2NtZ4tCkRQ5LkGFKbqJxAhm3GV7bAPWMIG
         UDrRtGQuafVcZ0fkaI3+gDYHP1inEr3VH7UzckUN3vzMN4mX/RVOmVGA9BYR/ezILTi4
         cxv3LUtnbV/nsTLMODhnHBFRyrjuyeFY+36A6OjDlmTBqJi2vCjjyzmzie7jEwrjU32D
         oRczE3AvibUw+vASoLm6YPyjNBoOKpvvHvBDrJwdIj7HGFeKQfpik/z6u/gssd9y6cWW
         /Gng==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of quentin.perret@arm.com designates 217.140.101.70 as permitted sender) smtp.mailfrom=quentin.perret@arm.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of quentin.perret@arm.com designates 217.140.101.70 as permitted sender) smtp.mailfrom=quentin.perret@arm.com
Date: Thu, 22 Feb 2018 09:04:04 +0000
From: Quentin Perret <quentin.perret@arm.com>
To: Sudeep Holla <sudeep.holla@arm.com>
Cc: ALKML <linux-arm-kernel@lists.infradead.org>,
	LKML <linux-kernel@vger.kernel.org>,
	DTML <devicetree@vger.kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Alexey Klimov <klimov.linux@gmail.com>, linux-pm@vger.kernel.org
Subject: Re: [PATCH v5 19/20] cpufreq: add support for CPU DVFS based on SCMI
 message protocol
Message-ID: <20180222085936.GA2290@e108498-lin.cambridge.arm.com>
References: <1518461124-17371-1-git-send-email-sudeep.holla@arm.com>
 <1518461124-17371-20-git-send-email-sudeep.holla@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1518461124-17371-20-git-send-email-sudeep.holla@arm.com>
User-Agent: Mutt/1.8.3 (2017-05-23)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592221944110003396?=
X-GMAIL-MSGID: =?utf-8?q?1593091294181775268?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi Sudeep,

On Monday 12 Feb 2018 at 18:45:23 (+0000), Sudeep Holla wrote:
[...]
> +/*
> + * perf_ops->freq_set is not a synchronous, the actual OPP change will
> + * happen asynchronously and can get notified if the events are
> + * subscribed for by the SCMI firmware
> + */
> +static int
> +scmi_cpufreq_set_target(struct cpufreq_policy *policy, unsigned int index)
> +{
> +	struct scmi_data *priv = policy->driver_data;
> +	struct scmi_perf_ops *perf_ops = handle->perf_ops;
> +	u64 freq = policy->freq_table[index].frequency * 1000;
> +
> +	return perf_ops->freq_set(handle, priv->domain_id, freq, false);
> +}

Is arch_set_freq_scale() needed in this function ?

Thanks,
Quentin
