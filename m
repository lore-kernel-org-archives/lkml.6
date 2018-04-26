Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-3258746-1524780542-2-6293001668198345152
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_MED -2.3, SPF_PASS -0.001, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.137', Host='smtp4.osuosl.org', Country='US',
  FromHeader='de', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524780541; b=s/RPhjp6FQLl+Z9X8onEWeMyRzEXr0SJqf5dKadUs2eOJsDsqU
    PctyZBox16uUlv+zyQUW7vGnjCfsKqqTatR0EtE9MyEpqmogGyGvtUmGmDjaRp3N
    Je3DKt9dZRH01K+ILz+0nNynBcefp+gfPGd7IGFlC0yVCyLuqYdGipdfodOcSQNQ
    4EUEa+pqJwJXRjKrAt379Zqm/ZxYcqY2IOwgbHHD6PDpPDgiTcEn7eitSPm9ltyB
    DaifIJmqs7KKRsydcSiIxwpLQwT4Na72RGlgypo7JPYVnA+hQKEQS/Pu1Us7m/bR
    zHJAF6wsO6XGdlXm/s6igpnT5R3Tn5l7ANGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:subject:in-reply-to
    :message-id:references:mime-version:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=fm2; t=1524780541; bh=fWBVu
    BxLNwigX9ODNf4uzj1QPlyQRZcZchAeblIqP6Q=; b=v4tH+NBuijfW361s7OUis
    MDrvWsPP7GfXLgLoCZXOvlQuY87CVNw5rCzQxpq2PZsEGuR8a8b4yK43fvIuDRW9
    7uZnaZJ7xN9NOi/2hdDd+udTYxKelIgI9+SdpKKx4+E6jdDAB7oiGXuBtjaS4AE4
    k0Eoe+ITaSpeDW6jhsDKmtfjFebtWWAkDWJOqAu0nzooIKKtvNpYLP7FaFcKmqOb
    0v1GRuPlMhkriDwDIgKQcJiaaPlVkbR8SkK5pXWIZW86ivpLLGdT8kyhpOocBimT
    8ZuPd1SjcpCfFxVomDsOPryHEJsuydnlCitylGcJBul7KQKaRL5xstkp1en/pKRt
    g==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linutronix.de;
    iprev=pass policy.iprev=140.211.166.137 (smtp4.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=fraxinus.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=fail x-ptr-helo=fraxinus.osuosl.org x-ptr-lookup=smtp4.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=linutronix.de header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=0 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linutronix.de;
    iprev=pass policy.iprev=140.211.166.137 (smtp4.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=fraxinus.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=fail x-ptr-helo=fraxinus.osuosl.org x-ptr-lookup=smtp4.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=linutronix.de header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfCFglEkHcPWvbRPb0FwfhnkJYX7tr0EsuGT1x9VROKIhoxDAGW8d9uzLAQGSEQ9M7+drhZ8rY285kwt3iq4b3e/yVq8vAgHcpfr0b0BJCAAaDVjALX5E
    YJk1Vpaehczw8wzxDMHduOA74Lm4B8EKlvbHN0mddxE2kMC7GMiJWoMeTd9LY32Mnv+wEsS9cwgdivvY5JxB8UrhOpwKTS7NMDQcFE+K9N9+0pdbuyQQ9tdA
    QTspb3mX8TVpy5xe85Ln0g==
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=584k1XxxM9pnnVd4MmWcNA==:117
    a=584k1XxxM9pnnVd4MmWcNA==:17 a=kj9zAlcOel0A:10 a=Kd1tUaAdevIA:10
    a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10 a=Odnh0R2cAAAA:8 a=DDOyTI_5AAAA:8
    a=_fb9viBMHngkQaVTh_4A:9 a=qomS8sWnohVKU5OJ:21 a=zRduJ-uG0ucdbZ08:21
    a=CjuIK1q_8ugA:10 a=lNAA6UHySJB7qmBR1x20:22 a=_BcfOz0m4U4ohdxiHPKc:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: discussion
X-Remote-Delivered-To: driverdev-devel@osuosl.org
Date: Fri, 27 Apr 2018 00:08:44 +0200 (CEST)
From: Thomas Gleixner <tglx@linutronix.de>
To: "K. Y. Srinivasan" <kys@microsoft.com>
Subject: Re: [PATCH 2/5] X86: Hyper-V: Enable IPI enlightenments
In-Reply-To: <20180425181250.8740-2-kys@linuxonhyperv.com>
Message-ID: <alpine.DEB.2.21.1804262350040.1596@nanos.tec.linutronix.de>
References: <20180425181110.8683-1-kys@linuxonhyperv.com>
 <20180425181250.8740-1-kys@linuxonhyperv.com>
 <20180425181250.8740-2-kys@linuxonhyperv.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required, ALL_TRUSTED=-1,
 SHORTCIRCUIT=-0.0001
X-BeenThere: driverdev-devel@linuxdriverproject.org
X-Mailman-Version: 2.1.24
 <driverdev-devel.linuxdriverproject.org>
List-Unsubscribe: <http://driverdev.linuxdriverproject.org/mailman/options/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=unsubscribe>
List-Archive: <http://driverdev.linuxdriverproject.org/pipermail/driverdev-devel/>
List-Post: <mailto:driverdev-devel@linuxdriverproject.org>
List-Help: <mailto:driverdev-devel-request@linuxdriverproject.org?subject=help>
List-Subscribe: <http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=subscribe>
Cc: olaf@aepfle.de, sthemmin@microsoft.com, gregkh@linuxfoundation.org,
 jasowang@redhat.com, x86@kernel.org, linux-kernel@vger.kernel.org,
 Michael.H.Kelley@microsoft.com, hpa@zytor.com, apw@canonical.com,
 devel@linuxdriverproject.org, vkuznets@redhat.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, 25 Apr 2018, kys@linuxonhyperv.com wrote:
> +static int __send_ipi_mask(const struct cpumask *mask, int vector)
> +{
> +	int cur_cpu, vcpu;
> +	struct ipi_arg_non_ex **arg;
> +	struct ipi_arg_non_ex *ipi_arg;
> +	int ret = 1;

So this indicates whether __send_ipi_mask() can send to @mask or not. So
please make it a bool and let it return false when it does not work, true
otherwise. If you had used -Exxxx then it would have been more obvious, but
this is really a boolean decision.

> +	unsigned long flags;
> +
> +	if (cpumask_empty(mask))
> +		return 0;
> +
> +	if (!hv_hypercall_pg)
> +		return ret;
> +
> +	if ((vector < HV_IPI_LOW_VECTOR) || (vector > HV_IPI_HIGH_VECTOR))
> +		return ret;
> +
> +	local_irq_save(flags);
> +	arg = (struct ipi_arg_non_ex **)this_cpu_ptr(hyperv_pcpu_input_arg);
> +
> +	ipi_arg = *arg;
> +	if (unlikely(!ipi_arg))
> +		goto ipi_mask_done;
> +
> +

Stray newline

> +	ipi_arg->vector = vector;
> +	ipi_arg->reserved = 0;
> +	ipi_arg->cpu_mask = 0;
> +
> +	for_each_cpu(cur_cpu, mask) {
> +		vcpu = hv_cpu_number_to_vp_number(cur_cpu);
> +		if (vcpu >= 64)
> +			goto ipi_mask_done;

This is completely magic and deserves a comment.

> +
> +		__set_bit(vcpu, (unsigned long *)&ipi_arg->cpu_mask);
> +	}
> +
> +	ret = hv_do_hypercall(HVCALL_SEND_IPI, ipi_arg, NULL);
> +
> +ipi_mask_done:
> +	local_irq_restore(flags);
> +	return ret;
> +}

....

>  static int hv_cpu_init(unsigned int cpu)
>  {
>  	u64 msr_vp_index;
>  	struct hv_vp_assist_page **hvp = &hv_vp_assist_page[smp_processor_id()];
> +	void **input_arg;
> +
> +	input_arg = (void **)this_cpu_ptr(hyperv_pcpu_input_arg);
> +	*input_arg = page_address(alloc_page(GFP_ATOMIC));

This is called from the cpu hotplug thread and there is no need for an
atomic allocation. Please use GFP_KERNEL.

>  	hv_get_vp_index(msr_vp_index);
>  
> @@ -217,6 +224,10 @@ static int hv_cpu_die(unsigned int cpu)
>  {
>  	struct hv_reenlightenment_control re_ctrl;
>  	unsigned int new_cpu;
> +	void **input_arg;
> +
> +	input_arg = (void **)this_cpu_ptr(hyperv_pcpu_input_arg);
> +	free_page((unsigned long)*input_arg);

Hrm. Again this is called from the CPU hotplug thread when the cou is about
to go down. But you can be scheduled out after free() and before disabling
the assist thing below and the pointer persist. There is no guarantee that
nothing sends an IPI anymore after this point.

So you have two options here:

  1) Disable interrupts, get the pointer, set the per cpu pointer to NULL,
     reenable interruots and free the page

  2) Keep the page around and check for it in the CPU UP path and avoid the
     allocation when the CPU comes online again.

>  	if (hv_vp_assist_page && hv_vp_assist_page[cpu])
>  		wrmsrl(HV_X64_MSR_VP_ASSIST_PAGE, 0);
> @@ -260,6 +271,12 @@ void __init hyperv_init(void)
>  	if ((ms_hyperv.features & required_msrs) != required_msrs)
>  		return;
>  
> +	/* Allocate the per-CPU state for the hypercall input arg */
> +	hyperv_pcpu_input_arg = alloc_percpu(void  *);
> +
> +	if (hyperv_pcpu_input_arg == NULL)
> +		return;

Huch. When that allocation fails, you return and ignore the rest of the
function which has been there before. Weird decision.

Thanks,

	tglx
_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
