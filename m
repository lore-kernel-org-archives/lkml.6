Return-Path: <SRS0=lBHl=PS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B5ECC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 18:21:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB01C208E3
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 18:21:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="PfE6IS0X"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731038AbfAJSVL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Jan 2019 13:21:11 -0500
Received: from smtprelay.synopsys.com ([198.182.60.111]:34508 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729760AbfAJSVK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jan 2019 13:21:10 -0500
Received: from mailhost.synopsys.com (mailhost2.synopsys.com [10.13.184.66])
        by smtprelay.synopsys.com (Postfix) with ESMTP id 9527110C0A42;
        Thu, 10 Jan 2019 10:21:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1547144469; bh=3DhO0nsT73OngEt7lN4Jc9aqYbxhGBAiGX/ukl5lFgo=;
        h=Subject:To:CC:References:From:Date:In-Reply-To:From;
        b=PfE6IS0X6M6u7cxJbyJ0mtFPlqv4se/YZZw3BEeRVRBZIT5F96OlRqEVKv0vH/Abo
         KP6T/5u7ntlujWdbFky3vIvii8hbGoPpvGzOimxGc1mAEhMt/GfgTXVcWKZYCL5Dw8
         0B00vCe45i1L/FYNBAud9dlb0v5WwZtRpkWXYJPt/kx67PAPdHegFOusEIbWLNOt9y
         SQorROxfeUufBQVg055vKaHWVXntEKx6L2kChUs1bpFpQjmvhMt3H8dRujp0H0neog
         AP5GPigVhLDRfPDUkpeuGpX2qjLmGd4gv22DO+8Uuo10b/npkXTKHweiBU9GNqFTmZ
         7bEzMuRlACLaw==
Received: from US01WEHTC3.internal.synopsys.com (us01wehtc3.internal.synopsys.com [10.15.84.232])
        by mailhost.synopsys.com (Postfix) with ESMTP id 396AB395D;
        Thu, 10 Jan 2019 10:21:09 -0800 (PST)
Received: from IN01WEHTCA.internal.synopsys.com (10.144.199.104) by
 US01WEHTC3.internal.synopsys.com (10.15.84.232) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Thu, 10 Jan 2019 10:21:08 -0800
Received: from IN01WEHTCB.internal.synopsys.com (10.144.199.105) by
 IN01WEHTCA.internal.synopsys.com (10.144.199.103) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Thu, 10 Jan 2019 23:51:08 +0530
Received: from [10.10.161.70] (10.10.161.70) by
 IN01WEHTCB.internal.synopsys.com (10.144.199.243) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Thu, 10 Jan 2019 23:51:08 +0530
Subject: Re: [PATCH v2 2/4] ARC: perf: introduce Kernel PMU events support
To:     Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
        <linux-snps-arc@lists.infradead.org>
CC:     <linux-kernel@vger.kernel.org>,
        Alexey Brodkin <alexey.brodkin@synopsys.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Ingo Molnar" <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>
Newsgroups: gmane.linux.kernel,gmane.linux.kernel.arc
References: <20181213165621.20817-1-Eugeniy.Paltsev@synopsys.com>
 <20181213165621.20817-3-Eugeniy.Paltsev@synopsys.com>
From:   Vineet Gupta <vineet.gupta1@synopsys.com>
Openpgp: preference=signencrypt
Autocrypt: addr=vgupta@synopsys.com; keydata=
 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
 hhqBJlyU6MVUa6vZNv8E
Message-ID: <2ff36f1a-d243-750a-053f-a7eca5b888e0@synopsys.com>
Date:   Thu, 10 Jan 2019 10:20:58 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181213165621.20817-3-Eugeniy.Paltsev@synopsys.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.10.161.70]
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ping ! Peter, does this look ok to you ?


On 12/13/18 8:56 AM, Eugeniy Paltsev wrote:
> Export all available ARC architected hardware events as
> kernel PMU events to make non-generic events accessible.
> 
> ARC PMU HW allow us to read the list of all available
> events names. So we generate kernel PMU event list
> dynamically in arc_pmu_device_probe() using
> human-readable events names we got from HW instead of
> using pre-defined events list.
> 
> -------------------------->8--------------------------
> $ perf list
>   [snip]
>   arc_pmu/bdata64/                  [Kernel PMU event]
>   arc_pmu/bdcstall/                 [Kernel PMU event]
>   arc_pmu/bdslot/                   [Kernel PMU event]
>   arc_pmu/bfbmp/                    [Kernel PMU event]
>   arc_pmu/bfirqex/                  [Kernel PMU event]
>   arc_pmu/bflgstal/                 [Kernel PMU event]
>   arc_pmu/bflush/                   [Kernel PMU event]
> -------------------------->8--------------------------
> 
> Signed-off-by: Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
> ---
> Changes v1->v2:
>  * Rename "arc_pmu" to "arc_pct"
>  * Trivial changes
> 
>  arch/arc/kernel/perf_event.c | 106 ++++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 105 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arc/kernel/perf_event.c b/arch/arc/kernel/perf_event.c
> index 693f32d60c35..d60aaaead421 100644
> --- a/arch/arc/kernel/perf_event.c
> +++ b/arch/arc/kernel/perf_event.c
> @@ -17,12 +17,28 @@
>  /* HW holds 8 symbols + one for null terminator */
>  #define ARCPMU_EVENT_NAME_LEN	9
>  
> +enum arc_pmu_attr_groups {
> +	ARCPMU_ATTR_GR_EVENTS,
> +	ARCPMU_ATTR_GR_FORMATS,
> +	ARCPMU_NR_ATTR_GR
> +};
> +
> +struct arc_pmu_raw_event_entry {
> +	char name[ARCPMU_EVENT_NAME_LEN];
> +};
> +
>  struct arc_pmu {
>  	struct pmu	pmu;
>  	unsigned int	irq;
>  	int		n_counters;
> +	int		n_events;
>  	u64		max_period;
>  	int		ev_hw_idx[PERF_COUNT_ARC_HW_MAX];
> +
> +	struct arc_pmu_raw_event_entry	*raw_entry;
> +	struct attribute		**attrs;
> +	struct perf_pmu_events_attr	*attr;
> +	const struct attribute_group	*attr_groups[ARCPMU_NR_ATTR_GR + 1];
>  };
>  
>  struct arc_pmu_cpu {
> @@ -192,6 +208,17 @@ static int arc_pmu_event_init(struct perf_event *event)
>  			 (int)hwc->config, arc_pmu_ev_hw_map[ret]);
>  		return 0;
>  
> +	case PERF_TYPE_RAW:
> +		if (event->attr.config >= arc_pmu->n_events)
> +			return -ENOENT;
> +
> +		hwc->config |= event->attr.config;
> +		pr_debug("init raw event with idx %lld \'%s\'\n",
> +			 event->attr.config,
> +			 arc_pmu->raw_entry[event->attr.config].name);
> +
> +		return 0;
> +
>  	default:
>  		return -ENOENT;
>  	}
> @@ -442,6 +469,67 @@ static void arc_cpu_pmu_irq_init(void *data)
>  	write_aux_reg(ARC_REG_PCT_INT_ACT, 0xffffffff);
>  }
>  
> +/* Event field occupies the bottom 15 bits of our config field */
> +PMU_FORMAT_ATTR(event, "config:0-14");
> +static struct attribute *arc_pmu_format_attrs[] = {
> +	&format_attr_event.attr,
> +	NULL,
> +};
> +
> +static struct attribute_group arc_pmu_format_attr_gr = {
> +	.name = "format",
> +	.attrs = arc_pmu_format_attrs,
> +};
> +
> +static ssize_t arc_pmu_events_sysfs_show(struct device *dev,
> +					 struct device_attribute *attr,
> +					 char *page)
> +{
> +	struct perf_pmu_events_attr *pmu_attr;
> +
> +	pmu_attr = container_of(attr, struct perf_pmu_events_attr, attr);
> +	return sprintf(page, "event=0x%04llx\n", pmu_attr->id);
> +}
> +
> +/*
> + * We don't add attrs here as we don't have pre-defined list of perf events.
> + * We will generate and add attrs dynamically in probe() after we read HW
> + * configuration.
> + */
> +static struct attribute_group arc_pmu_events_attr_gr = {
> +	.name = "events",
> +};
> +
> +static void arc_pmu_add_raw_event_attr(int j, char *str)
> +{
> +	memmove(arc_pmu->raw_entry[j].name, str, ARCPMU_EVENT_NAME_LEN - 1);
> +	arc_pmu->attr[j].attr.attr.name = arc_pmu->raw_entry[j].name;
> +	arc_pmu->attr[j].attr.attr.mode = VERIFY_OCTAL_PERMISSIONS(0444);
> +	arc_pmu->attr[j].attr.show = arc_pmu_events_sysfs_show;
> +	arc_pmu->attr[j].id = j;
> +	arc_pmu->attrs[j] = &(arc_pmu->attr[j].attr.attr);
> +}
> +
> +static int arc_pmu_raw_alloc(struct device *dev)
> +{
> +	arc_pmu->attr = devm_kmalloc_array(dev, arc_pmu->n_events + 1,
> +		sizeof(*arc_pmu->attr), GFP_KERNEL | __GFP_ZERO);
> +	if (!arc_pmu->attr)
> +		return -ENOMEM;
> +
> +	arc_pmu->attrs = devm_kmalloc_array(dev, arc_pmu->n_events + 1,
> +		sizeof(*arc_pmu->attrs), GFP_KERNEL | __GFP_ZERO);
> +	if (!arc_pmu->attrs)
> +		return -ENOMEM;
> +
> +	arc_pmu->raw_entry = devm_kmalloc_array(dev, arc_pmu->n_events,
> +		sizeof(*arc_pmu->raw_entry), GFP_KERNEL | __GFP_ZERO);
> +	if (!arc_pmu->raw_entry)
> +		return -ENOMEM;
> +
> +	return 0;
> +}
> +
>  static int arc_pmu_device_probe(struct platform_device *pdev)
>  {
>  	struct arc_reg_pct_build pct_bcr;
> @@ -473,6 +561,11 @@ static int arc_pmu_device_probe(struct platform_device *pdev)
>  	if (!arc_pmu)
>  		return -ENOMEM;
>  
> +	arc_pmu->n_events = cc_bcr.c;
> +
> +	if (arc_pmu_raw_alloc(&pdev->dev))
> +		return -ENOMEM;
> +
>  	has_interrupts = is_isa_arcv2() ? pct_bcr.i : 0;
>  
>  	arc_pmu->n_counters = pct_bcr.c;
> @@ -504,8 +597,14 @@ static int arc_pmu_device_probe(struct platform_device *pdev)
>  				arc_pmu->ev_hw_idx[i] = j;
>  			}
>  		}
> +
> +		arc_pmu_add_raw_event_attr(j, cc_name.str);
>  	}
>  
> +	arc_pmu_events_attr_gr.attrs = arc_pmu->attrs;
> +	arc_pmu->attr_groups[ARCPMU_ATTR_GR_EVENTS] = &arc_pmu_events_attr_gr;
> +	arc_pmu->attr_groups[ARCPMU_ATTR_GR_FORMATS] = &arc_pmu_format_attr_gr;
> +
>  	arc_pmu->pmu = (struct pmu) {
>  		.pmu_enable	= arc_pmu_enable,
>  		.pmu_disable	= arc_pmu_disable,
> @@ -515,6 +614,7 @@ static int arc_pmu_device_probe(struct platform_device *pdev)
>  		.start		= arc_pmu_start,
>  		.stop		= arc_pmu_stop,
>  		.read		= arc_pmu_read,
> +		.attr_groups	= arc_pmu->attr_groups,
>  	};
>  
>  	if (has_interrupts) {
> @@ -536,7 +636,11 @@ static int arc_pmu_device_probe(struct platform_device *pdev)
>  	} else
>  		arc_pmu->pmu.capabilities |= PERF_PMU_CAP_NO_INTERRUPT;
>  
> -	return perf_pmu_register(&arc_pmu->pmu, pdev->name, PERF_TYPE_RAW);
> +	/*
> +	 * perf parser doesn't really like '-' symbol in events name, so let's
> +	 * use '_' in arc pct name as it goes to kernel PMU event prefix.
> +	 */
> +	return perf_pmu_register(&arc_pmu->pmu, "arc_pct", PERF_TYPE_RAW);
>  }
>  
>  static const struct of_device_id arc_pmu_match[] = {
> 

