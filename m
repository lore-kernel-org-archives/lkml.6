Return-Path: <lorenzo.pieralisi@arm.com>
X-Google-Smtp-Source: AG47ELuxIsk+JnGU7ushzcWFRGEdLMzu6h12FARKypc+6Pwwwb38AaidJhm+HcDPLjbzYdVEuVhX
ARC-Seal: i=1; a=rsa-sha256; t=1520529623; cv=none;
        d=google.com; s=arc-20160816;
        b=wSlsr/jWCzctQWmWFFwmuvTRQmfuL5PLHJ4D97hxGUkKhFmqC/A8iqDedpfVfnRkcU
         cu8hBg7a8/V8LVQ0gYO9iCEywmO+isaRBq/JpbNZl5HPZv0aGSFLWEEtgwFHdgn2sQS3
         V8YWNJLU1OeVrzn2Rx08/zDTdhSUowhDWIaUkQWJDu/qg6Uncofmgrk4HKuLM7tvY4/6
         jdBGUV84RxgW8Beat8yNQcClJ5eZucDZLOIElo7wTInV7ceAgiXrB7KX8WDXg3P46C17
         Dsv68m9O/8DqM2UQFUMxsSyekvLnNX5nKZ1ec1yx3te5RJGiizC86sKW5rQzwzfb6xB+
         Dw1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:arc-authentication-results;
        bh=2QnePwCrxgaDPxVDYeAUu3PE7p9tjeIH9HrCXdLcY7M=;
        b=aXMuHeD9SAatQMtxy6DAyIsFOoww2m8rqSUCeT0MbJ8wIaKIEAM+kKjqB+jE3U8L6u
         xQYBTMcP68WachvRPvu5Xum+vryC+gJWum5KKc+LIruJBLQUhM9CfxbE4biM385lI1nC
         eLXaYwyrHyGdQqNJ2imY2nQMzvmJ8P2mlb81fAvjVxBMX0zPw3Qea9I+G2n9HIfx2mkw
         0/UUGaYtyDR127VCUgQk25J8EDrVWAR7SqlW1VapQkNCyUmoRpe5ghWBGQSCA98rggq7
         IW0HvjvYzfJJVYuQpn8LwvxvcmtomvD+bnURtbZOTvi2JMDPKDveeu0QhprwsP9vS3Gx
         veDg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of lorenzo.pieralisi@arm.com designates 217.140.101.70 as permitted sender) smtp.mailfrom=lorenzo.pieralisi@arm.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of lorenzo.pieralisi@arm.com designates 217.140.101.70 as permitted sender) smtp.mailfrom=lorenzo.pieralisi@arm.com
Date: Thu, 8 Mar 2018 17:20:14 +0000
From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To: Jeremy Linton <jeremy.linton@arm.com>
Cc: linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	sudeep.holla@arm.com, hanjun.guo@linaro.org, rjw@rjwysocki.net,
	will.deacon@arm.com, catalin.marinas@arm.com,
	gregkh@linuxfoundation.org, mark.rutland@arm.com,
	linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
	wangxiongfeng2@huawei.com, vkilari@codeaurora.org, ahs3@redhat.com,
	dietmar.eggemann@arm.com, morten.rasmussen@arm.com,
	palmer@sifive.com, lenb@kernel.org, john.garry@huawei.com,
	austinwc@codeaurora.org, tnowicki@caviumnetworks.com
Subject: Re: [PATCH v7 07/13] drivers: base cacheinfo: Add support for ACPI
 based firmware tables
Message-ID: <20180308172014.GB2780@e107981-ln.cambridge.arm.com>
References: <20180228220619.6992-1-jeremy.linton@arm.com>
 <20180228220619.6992-8-jeremy.linton@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180228220619.6992-8-jeremy.linton@arm.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593684152561134116?=
X-GMAIL-MSGID: =?utf-8?q?1594390870242726684?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, Feb 28, 2018 at 04:06:13PM -0600, Jeremy Linton wrote:

[...]

> diff --git a/include/linux/cacheinfo.h b/include/linux/cacheinfo.h
> index 0c6f658054d2..1446d3f053a2 100644
> --- a/include/linux/cacheinfo.h
> +++ b/include/linux/cacheinfo.h
> @@ -97,6 +97,15 @@ int func(unsigned int cpu)					\
>  struct cpu_cacheinfo *get_cpu_cacheinfo(unsigned int cpu);
>  int init_cache_level(unsigned int cpu);
>  int populate_cache_leaves(unsigned int cpu);
> +int cache_setup_acpi(unsigned int cpu);
> +int acpi_find_last_cache_level(unsigned int cpu);
> +#ifndef CONFIG_ACPI
> +int acpi_find_last_cache_level(unsigned int cpu)

This has got to be a static inline function declaration (see kbot report).

Lorenzo

> +{
> +	/* ACPI kernels should be built with PPTT support */
> +	return 0;
> +}
> +#endif
>  
>  const struct attribute_group *cache_get_priv_group(struct cacheinfo *this_leaf);
>  
> -- 
> 2.13.6
> 
