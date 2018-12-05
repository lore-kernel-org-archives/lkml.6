Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 123B9C04EB9
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 18:10:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE9EA20892
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 18:10:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="TGqISBZp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BE9EA20892
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=synopsys.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728237AbeLESJ7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 13:09:59 -0500
Received: from smtprelay2.synopsys.com ([198.182.60.111]:54354 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727388AbeLESJ7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 13:09:59 -0500
Received: from mailhost.synopsys.com (mailhost2.synopsys.com [10.13.184.66])
        by smtprelay.synopsys.com (Postfix) with ESMTP id 944FB10C08D9;
        Wed,  5 Dec 2018 10:09:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1544033398; bh=yLiTtfrRuj9OMIPmAKFnmP1FqzQEqUSzemrdeoxnEH0=;
        h=From:To:CC:Subject:Date:References:From;
        b=TGqISBZpZGtrjXWFSRaqq2THa+iDEEmdk3A/7QXe4pa941PPP5lU4FlLYbZCWKO/J
         Z2W9AvfC0ORr5r4YmPZFADYCb9uDxOcS9PIC5g4FSK9JnVq1AwRtkpllOFZM96i19h
         wOOWa6MYXQn79FPqvPDMOZp163hdChm10pS4WxftU2Gh/7ROaLkxz4dw1hBroHZuef
         7d2IDRKa914243+hc5an3OroZVK66J48Z3FegEkM8VpVJj+ls50xX46M7wnrzeStKJ
         BEdAPAUWKlRmmZ4agN2wthHP9SNDokftBydG6LuhTSrXtkqpzx0nHOfNXZbtTC2wB3
         1KcCn0HRN6TTw==
Received: from US01WXQAHTC1.internal.synopsys.com (us01wxqahtc1.internal.synopsys.com [10.12.238.230])
        by mailhost.synopsys.com (Postfix) with ESMTP id 6FDED3E7A;
        Wed,  5 Dec 2018 10:09:58 -0800 (PST)
Received: from US01WEMBX2.internal.synopsys.com ([fe80::e4b6:5520:9c0d:250b])
 by US01WXQAHTC1.internal.synopsys.com ([::1]) with mapi id 14.03.0415.000;
 Wed, 5 Dec 2018 10:09:58 -0800
From:   Vineet Gupta <vineet.gupta1@synopsys.com>
To:     Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
        "linux-snps-arc@lists.infradead.org" 
        <linux-snps-arc@lists.infradead.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Alexey Brodkin" <alexey.brodkin@synopsys.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Ingo Molnar" <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>
Subject: Re: [PATCH 2/5] ARC: perf: introduce Kernel PMU events support
Thread-Topic: [PATCH 2/5] ARC: perf: introduce Kernel PMU events support
Thread-Index: AQHUjLzgBlrsNj2oEEKybwd/bQNQoQ==
Date:   Wed, 5 Dec 2018 18:09:57 +0000
Message-ID: <C2D7FE5348E1B147BCA15975FBA23075014641B980@US01WEMBX2.internal.synopsys.com>
References: <20181205170609.18690-1-Eugeniy.Paltsev@synopsys.com>
 <20181205170609.18690-3-Eugeniy.Paltsev@synopsys.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.144.199.106]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/5/18 9:06 AM, Eugeniy Paltsev wrote:=0A=
> Export all available ARC architected hardware events as=0A=
> kernel PMU events to make non-generic events accessible.=0A=
>=0A=
> ARC PMU HW allow us to read the list of all available=0A=
> events names. So we generate kernel PMU event list=0A=
> dynamically in arc_pmu_device_probe() using=0A=
> human-readable events names we got from HW instead of=0A=
> using pre-defined events list.=0A=
>=0A=
> -------------------------->8--------------------------=0A=
> $ perf list=0A=
>   [snip]=0A=
>   arc_pmu/bdata64/                  [Kernel PMU event]=0A=
>   arc_pmu/bdcstall/                 [Kernel PMU event]=0A=
>   arc_pmu/bdslot/                   [Kernel PMU event]=0A=
>   arc_pmu/bfbmp/                    [Kernel PMU event]=0A=
>   arc_pmu/bfirqex/                  [Kernel PMU event]=0A=
>   arc_pmu/bflgstal/                 [Kernel PMU event]=0A=
>   arc_pmu/bflush/                   [Kernel PMU event]=0A=
=0A=
Lets call this pct iso pmu since pmu has more of power mgmt connotation. I =
know=0A=
the code has pmu littered all over but atleast the user interface could be =
more=0A=
intuitive.=0A=
=0A=
BTW this approach seems more user friendly and is different from Alexey's e=
arlier=0A=
stab at implementing raw events [1]. He didn't keep around any list (and re=
lied on=0A=
use rlooking in the PRM to find his interesting event of the day) and pass =
as=0A=
*r*foobar.  PeterZ at the time had some reservations with that which I neve=
r fully=0A=
understood.=0A=
=0A=
[1] https://lore.kernel.org/patchwork/patch/568769/=0A=
=0A=
> -------------------------->8--------------------------=0A=
>=0A=
> Signed-off-by: Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>=0A=
> ---=0A=
>  arch/arc/kernel/perf_event.c | 107 +++++++++++++++++++++++++++++++++++++=
+++++-=0A=
>  1 file changed, 106 insertions(+), 1 deletion(-)=0A=
>=0A=
> diff --git a/arch/arc/kernel/perf_event.c b/arch/arc/kernel/perf_event.c=
=0A=
> index 811a07a2ca21..97b88b00c418 100644=0A=
> --- a/arch/arc/kernel/perf_event.c=0A=
> +++ b/arch/arc/kernel/perf_event.c=0A=
> @@ -22,12 +22,28 @@=0A=
>  /* HW holds 8 symbols + one for null terminator */=0A=
>  #define ARCPMU_EVENT_NAME_LEN	9=0A=
>  =0A=
> +enum arc_pmu_attr_groups {=0A=
> +	ARCPMU_ATTR_GR_EVENTS,=0A=
> +	ARCPMU_ATTR_GR_FORMATS,=0A=
> +	ARCPMU_NR_ATTR_GR=0A=
> +};=0A=
> +=0A=
> +struct arc_pmu_raw_event_entry {=0A=
> +	char name[ARCPMU_EVENT_NAME_LEN];=0A=
> +};=0A=
> +=0A=
>  struct arc_pmu {=0A=
>  	struct pmu	pmu;=0A=
>  	unsigned int	irq;=0A=
>  	int		n_counters;=0A=
> +	int		n_events;=0A=
>  	u64		max_period;=0A=
>  	int		ev_hw_idx[PERF_COUNT_ARC_HW_MAX];=0A=
> +=0A=
> +	struct arc_pmu_raw_event_entry	*raw_entry;=0A=
> +	struct attribute		**attrs;=0A=
> +	struct perf_pmu_events_attr	*attr;=0A=
> +	const struct attribute_group	*attr_groups[ARCPMU_NR_ATTR_GR + 1];=0A=
>  };=0A=
>  =0A=
>  struct arc_pmu_cpu {=0A=
> @@ -196,6 +212,17 @@ static int arc_pmu_event_init(struct perf_event *eve=
nt)=0A=
>  			 (int)hwc->config, arc_pmu_ev_hw_map[ret]);=0A=
>  		return 0;=0A=
>  =0A=
> +	case PERF_TYPE_RAW:=0A=
> +		if (event->attr.config >=3D arc_pmu->n_events)=0A=
> +			return -ENOENT;=0A=
> +=0A=
> +		hwc->config |=3D event->attr.config;=0A=
> +		pr_debug("init raw event with idx %lld \'%s\'\n",=0A=
> +			 event->attr.config,=0A=
> +			 arc_pmu->raw_entry[event->attr.config].name);=0A=
> +=0A=
> +		return 0;=0A=
> +=0A=
>  	default:=0A=
>  		return -ENOENT;=0A=
>  	}=0A=
> @@ -446,6 +473,68 @@ static void arc_cpu_pmu_irq_init(void *data)=0A=
>  	write_aux_reg(ARC_REG_PCT_INT_ACT, 0xffffffff);=0A=
>  }=0A=
>  =0A=
> +/* Event field occupies the bottom 15 bits of our config field */=0A=
> +PMU_FORMAT_ATTR(event, "config:0-14");=0A=
> +static struct attribute *arc_pmu_format_attrs[] =3D {=0A=
> +	&format_attr_event.attr,=0A=
> +	NULL,=0A=
> +};=0A=
> +=0A=
> +static struct attribute_group arc_pmu_format_attr_gr =3D {=0A=
> +	.name =3D "format",=0A=
> +	.attrs =3D arc_pmu_format_attrs,=0A=
> +};=0A=
> +=0A=
> +static ssize_t=0A=
> +arc_pmu_events_sysfs_show(struct device *dev,=0A=
> +			  struct device_attribute *attr, char *page)=0A=
> +{=0A=
> +	struct perf_pmu_events_attr *pmu_attr;=0A=
> +=0A=
> +	pmu_attr =3D container_of(attr, struct perf_pmu_events_attr, attr);=0A=
> +	return sprintf(page, "event=3D0x%04llx\n", pmu_attr->id);=0A=
> +}=0A=
> +=0A=
> +/*=0A=
> + * We don't add attrs here as we don't have pre-defined list of perf eve=
nts.=0A=
> + * We will generate and add attrs dynamically in probe() after we read H=
W=0A=
> + * configuration.=0A=
> + */=0A=
> +static struct attribute_group arc_pmu_events_attr_gr =3D {=0A=
> +	.name =3D "events",=0A=
> +};=0A=
> +=0A=
> +static void arc_pmu_add_raw_event_attr(int j, char *str)=0A=
> +{=0A=
> +	memmove(arc_pmu->raw_entry[j].name, str, ARCPMU_EVENT_NAME_LEN - 1);=0A=
> +	arc_pmu->attr[j].attr.attr.name =3D arc_pmu->raw_entry[j].name;=0A=
> +	arc_pmu->attr[j].attr.attr.mode =3D VERIFY_OCTAL_PERMISSIONS(0444);=0A=
> +	arc_pmu->attr[j].attr.show =3D arc_pmu_events_sysfs_show;=0A=
> +	arc_pmu->attr[j].id =3D j;=0A=
> +	arc_pmu->attrs[j] =3D &(arc_pmu->attr[j].attr.attr);=0A=
> +}=0A=
> +=0A=
> +static int arc_pmu_raw_alloc(struct device *dev)=0A=
> +{=0A=
> +	arc_pmu->attr =3D devm_kmalloc_array(dev, arc_pmu->n_events + 1,=0A=
> +		sizeof(struct perf_pmu_events_attr), GFP_KERNEL | __GFP_ZERO);=0A=
> +	if (!arc_pmu->attr)=0A=
> +		return -ENOMEM;=0A=
> +=0A=
> +	arc_pmu->attrs =3D devm_kmalloc_array(dev, arc_pmu->n_events + 1,=0A=
> +		sizeof(*arc_pmu->attrs), GFP_KERNEL | __GFP_ZERO);=0A=
> +	if (!arc_pmu->attrs)=0A=
> +		return -ENOMEM;=0A=
> +=0A=
> +	arc_pmu->raw_entry =3D devm_kmalloc_array(dev, arc_pmu->n_events,=0A=
> +		sizeof(struct arc_pmu_raw_event_entry),=0A=
> +		GFP_KERNEL | __GFP_ZERO);=0A=
> +	if (!arc_pmu->raw_entry)=0A=
> +		return -ENOMEM;=0A=
> +=0A=
> +	return 0;=0A=
> +}=0A=
> +=0A=
>  static int arc_pmu_device_probe(struct platform_device *pdev)=0A=
>  {=0A=
>  	struct arc_reg_pct_build pct_bcr;=0A=
> @@ -477,6 +566,11 @@ static int arc_pmu_device_probe(struct platform_devi=
ce *pdev)=0A=
>  	if (!arc_pmu)=0A=
>  		return -ENOMEM;=0A=
>  =0A=
> +	arc_pmu->n_events =3D cc_bcr.c;=0A=
> +=0A=
> +	if (arc_pmu_raw_alloc(&pdev->dev))=0A=
> +		return -ENOMEM;=0A=
> +=0A=
>  	has_interrupts =3D is_isa_arcv2() ? pct_bcr.i : 0;=0A=
>  =0A=
>  	arc_pmu->n_counters =3D pct_bcr.c;=0A=
> @@ -508,8 +602,14 @@ static int arc_pmu_device_probe(struct platform_devi=
ce *pdev)=0A=
>  				arc_pmu->ev_hw_idx[i] =3D j;=0A=
>  			}=0A=
>  		}=0A=
> +=0A=
> +		arc_pmu_add_raw_event_attr(j, cc_name.str);=0A=
>  	}=0A=
>  =0A=
> +	arc_pmu_events_attr_gr.attrs =3D arc_pmu->attrs;=0A=
> +	arc_pmu->attr_groups[ARCPMU_ATTR_GR_EVENTS] =3D &arc_pmu_events_attr_gr=
;=0A=
> +	arc_pmu->attr_groups[ARCPMU_ATTR_GR_FORMATS] =3D &arc_pmu_format_attr_g=
r;=0A=
> +=0A=
>  	arc_pmu->pmu =3D (struct pmu) {=0A=
>  		.pmu_enable	=3D arc_pmu_enable,=0A=
>  		.pmu_disable	=3D arc_pmu_disable,=0A=
> @@ -519,6 +619,7 @@ static int arc_pmu_device_probe(struct platform_devic=
e *pdev)=0A=
>  		.start		=3D arc_pmu_start,=0A=
>  		.stop		=3D arc_pmu_stop,=0A=
>  		.read		=3D arc_pmu_read,=0A=
> +		.attr_groups	=3D arc_pmu->attr_groups,=0A=
>  	};=0A=
>  =0A=
>  	if (has_interrupts) {=0A=
> @@ -540,7 +641,11 @@ static int arc_pmu_device_probe(struct platform_devi=
ce *pdev)=0A=
>  	} else=0A=
>  		arc_pmu->pmu.capabilities |=3D PERF_PMU_CAP_NO_INTERRUPT;=0A=
>  =0A=
> -	return perf_pmu_register(&arc_pmu->pmu, pdev->name, PERF_TYPE_RAW);=0A=
> +	/*=0A=
> +	 * perf parser doesn't really like '-' symbol in events name, so let's=
=0A=
> +	 * use '_' in arc pmu name as it goes to kernel PMU event prefix.=0A=
> +	 */=0A=
> +	return perf_pmu_register(&arc_pmu->pmu, "arc_pmu", PERF_TYPE_RAW);=0A=
>  }=0A=
>  =0A=
>  #ifdef CONFIG_OF=0A=
=0A=
