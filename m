Return-Path: <sudeep.holla@arm.com>
X-Google-Smtp-Source: AH8x226UqIaIg1yM8JiNPr8K0QSfG6F0kiSDdSq/fhk3R0MHenFMrz2bkzrrwkrqTybvImBYhqgR
ARC-Seal: i=1; a=rsa-sha256; t=1519292892; cv=none;
        d=google.com; s=arc-20160816;
        b=o8Nu6SbsgjIRvsTuG8WnOO6Agir6AdhNVxT+E7ChRGRSlYA+8H9/kFh92fYpgC+h9B
         +wMPwB8g3wJ2SgWyaJsqbN+1DYRgmPdaXOtB4t5wgr+iE9cPAC9YJ6paIuRxmB/Wrz+M
         w9coLvSUBL3YcyRilCQTDeTaxJ3sdxigz7KVJ+37SWf6nXxjaXeUq0JPSvykT92H3eoA
         mzDui7GdDYIZmevJY7sokkYAF//NHNR8QUDp0XSSqFMg1ZU4rLWDnMpQreRbqZDC3WoS
         zWoelsg6R2FFMwY1uM41J9drc8oacM7RABf8FtoVKnEyPTnQYer7TWv0fIUBpleDX1/n
         89ng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:organization:from:references:to:subject
         :cc:arc-authentication-results;
        bh=nyJJqqoFrcIqKFY11s5GjOqn7XIxNL8kEX5fpaOVEHA=;
        b=zzHQoKZfg277Cdoznqx3oBjsBgsLiss35Jf1g6Xr18s/4xstp4FXFe8Ge9k2cd+sAv
         GDLRZAATBgahimzZdJEgJ5cyCBYVeSnHt7x/ZftFaNclhP705jZp8JJOppP/Hg7KXoA9
         FGiabqtXZyrzSvkqyIDCbkudP0mOboVfELb+f3xZv7FmHR19ydE/fqNA8nam3QHzGYb7
         q3nBIB+02H5IEwjCBFdwAVX2xe1yYfUKmeDjS+H0CblI8/jqfHgtIbUCSObkp/QuU1+f
         x3giL4EuIWRUYscCMrpa0XmaVV0hdJmpEzwAkOahfvfU9WYunVl/09GLyDGO8HEs/Ha+
         c4vg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of sudeep.holla@arm.com designates 217.140.101.70 as permitted sender) smtp.mailfrom=sudeep.holla@arm.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of sudeep.holla@arm.com designates 217.140.101.70 as permitted sender) smtp.mailfrom=sudeep.holla@arm.com
Cc: Sudeep Holla <sudeep.holla@arm.com>,
 ALKML <linux-arm-kernel@lists.infradead.org>,
 LKML <linux-kernel@vger.kernel.org>, DTML <devicetree@vger.kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Arnd Bergmann <arnd@arndb.de>, Alexey Klimov <klimov.linux@gmail.com>,
 linux-pm@vger.kernel.org
Subject: Re: [PATCH v5 19/20] cpufreq: add support for CPU DVFS based on SCMI
 message protocol
To: Quentin Perret <quentin.perret@arm.com>
References: <1518461124-17371-1-git-send-email-sudeep.holla@arm.com>
 <1518461124-17371-20-git-send-email-sudeep.holla@arm.com>
 <20180222085936.GA2290@e108498-lin.cambridge.arm.com>
From: Sudeep Holla <sudeep.holla@arm.com>
Organization: ARM
Message-ID: <1f04bbaf-83ae-6351-dbc9-82d27af030e1@arm.com>
Date: Thu, 22 Feb 2018 09:48:06 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180222085936.GA2290@e108498-lin.cambridge.arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592221944110003396?=
X-GMAIL-MSGID: =?utf-8?q?1593094064697602611?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>



On 22/02/18 09:04, Quentin Perret wrote:
> Hi Sudeep,
> 
> On Monday 12 Feb 2018 at 18:45:23 (+0000), Sudeep Holla wrote:
> [...]
>> +/*
>> + * perf_ops->freq_set is not a synchronous, the actual OPP change will
>> + * happen asynchronously and can get notified if the events are
>> + * subscribed for by the SCMI firmware
>> + */
>> +static int
>> +scmi_cpufreq_set_target(struct cpufreq_policy *policy, unsigned int index)
>> +{
>> +	struct scmi_data *priv = policy->driver_data;
>> +	struct scmi_perf_ops *perf_ops = handle->perf_ops;
>> +	u64 freq = policy->freq_table[index].frequency * 1000;
>> +
>> +	return perf_ops->freq_set(handle, priv->domain_id, freq, false);
>> +}
> 
> Is arch_set_freq_scale() needed in this function ?
> 

Yes indeed, already added locally[1] after Dietmar started the discussion.

-- 
Regards,
Sudeep

[1] https://git.kernel.org/sudeep.holla/linux/h/for-list/new_arm_scmi
