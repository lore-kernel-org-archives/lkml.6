Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-3283753-1524781022-2-10136845529282868105
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_MED -2.3, SPF_PASS -0.001, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.133', Host='smtp2.osuosl.org', Country='US',
  FromHeader='de', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524781021; b=KfKdo4YkEhPLs0IlijK9nAwMVz4/LDYdRx+vnGNB3uc8aRvvyM
    Eq9i8O4l6Cm7hnaEr3qROhksJwmeqMfGuC6jjRcgZ877ZO9rOrBgqE92AK3hx+tf
    tmB5+AbzqwfpYS16mDMrMbuHkMlQEhsXkfi7pR0Us+rbBDd0zY+txD+IrhzwcQ8K
    xg4QX2eArcUH/PdtxCPA2Pmfwv7UBf8n51Tgo/lySUG8fFgcsVz/IimQB3rW35yc
    csANR8VFzDe4pN6P29lio/fQWK0LUKHqNGdIp1XN2CHuDHYXc3T6ZFn7TJPjUgox
    CBp/tREHHKbmzB4+bstfXHV30gbotbOTnvbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:subject:in-reply-to
    :message-id:references:mime-version:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=fm2; t=1524781021; bh=ZBVP3
    xtMFEnEo9YHuWWAyxPn+r435XSY4x/Rv32qw1o=; b=mWIaj1MwDRwp2bfCD5r8b
    OMdBlO/m/GDosNGfgZGSaUDdGK08cChgFJeYJFiMzN9j5bvyyXIApDIa+uxsVC0z
    MVMmp9X1sO8O88r45tZ6K6ubq1e3SkWXPw85VgvuXBgdXqSoNa6Q0yRQRy07ZUS5
    liJNbuEgyyyHntq1sPvjF0PUEPy1Dh3MAJhKameNzxxncXoInWWYBLLYpfzK0PdH
    F5gmIKKD6ZYgDzSJ8RZ00hQxTYRY5CApB+xgIu9qtXqhjaYn2l3O8YUS3JXcHm1D
    YiuqEPYX0wGSfz4mA+CDpCiUIqE80YMmcJPmKoZmhuF4HSDNgYWNnPOjdEsQ7jzn
    g==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linutronix.de;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=fail x-ptr-helo=hemlock.osuosl.org x-ptr-lookup=smtp2.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=linutronix.de header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=0 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linutronix.de;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=fail x-ptr-helo=hemlock.osuosl.org x-ptr-lookup=smtp2.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=linutronix.de header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfD2/I6VpXMx1y8zgUzJLww5OSNfNFD8CsUosaTsyNcLoIj9gDHvVqLX+6HhyZvoT1C91uDXjR68CDSwzNu7qEWKg/W3dl45hRk5rBgDtfSzGbiCdBp/G
    sz7QeG/sHM3WjeadkCm8BJkUI3wG5a1ceXwg7tq9ahX5LGM7bz9+EMEQRQbrwJ3bP7/hWZEu7CHRFtUIfD7fvr32eVz6pX+sqYyljMt3k2ycCMgLusHHA8aR
    AvsJG90YIf4MnJC6PNQBvg==
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=kIo7DnY5WRu98hpln7do/g==:117
    a=kIo7DnY5WRu98hpln7do/g==:17 a=kj9zAlcOel0A:10 a=Kd1tUaAdevIA:10
    a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10 a=Odnh0R2cAAAA:8 a=DDOyTI_5AAAA:8
    a=YXTaVE1a38RxohtJrlAA:9 a=POzrWeHEtARKiLvT:21 a=yg7GzjVmVag1mBcZ:21
    a=CjuIK1q_8ugA:10 a=lNAA6UHySJB7qmBR1x20:22 a=_BcfOz0m4U4ohdxiHPKc:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: discussion
X-Remote-Delivered-To: driverdev-devel@osuosl.org
Date: Fri, 27 Apr 2018 00:16:51 +0200 (CEST)
From: Thomas Gleixner <tglx@linutronix.de>
To: "K. Y. Srinivasan" <kys@microsoft.com>
Subject: Re: [PATCH 3/5] X86: Hyper-V: Enhanced IPI enlightenment
In-Reply-To: <20180425181250.8740-3-kys@linuxonhyperv.com>
Message-ID: <alpine.DEB.2.21.1804270009080.1596@nanos.tec.linutronix.de>
References: <20180425181110.8683-1-kys@linuxonhyperv.com>
 <20180425181250.8740-1-kys@linuxonhyperv.com>
 <20180425181250.8740-3-kys@linuxonhyperv.com>
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
>  
> +struct ipi_arg_ex {
> +	u32 vector;
> +	u32  reserved;
> +	struct hv_vpset vp_set;

Please align that in tabular fashion for easy of reading

	u32		vector;
	u32  		reserved;
	struct hv_vpset	vp_set;

> +};
> +
>  static struct apic orig_apic;
>  
>  static u64 hv_apic_icr_read(void)
> @@ -97,6 +103,40 @@ static void hv_apic_eoi_write(u32 reg, u32 val)
>   * IPI implementation on Hyper-V.
>   */
>  
> +static int __send_ipi_mask_ex(const struct cpumask *mask, int vector)
> +{
> +	int nr_bank = 0;
> +	struct ipi_arg_ex **arg;
> +	struct ipi_arg_ex *ipi_arg;
> +	int ret = 1;
> +	unsigned long flags;

This is really horrible to read.

	struct ipi_arg_ex *ipi_arg;
	struct ipi_arg_ex **arg;
	unsigned long flags;
	bool ret = false;
	int nr_bank = 0;

is really more conveniant for quick reading.

So the other more limited function has a lot more sanity checks vs. vector
number and other things. Why are they not required here? Comment please.

> +	local_irq_save(flags);
> +	arg = (struct ipi_arg_ex **)this_cpu_ptr(hyperv_pcpu_input_arg);
> +
> +	ipi_arg = *arg;
> +	if (unlikely(!ipi_arg))
> +		goto ipi_mask_ex_done;
> +
> +	ipi_arg->vector = vector;
> +	ipi_arg->reserved = 0;
> +	ipi_arg->vp_set.valid_bank_mask = 0;
> +
> +	if (!cpumask_equal(mask, cpu_present_mask)) {
> +		ipi_arg->vp_set.format = HV_GENERIC_SET_SPARCE_4K;
> +		nr_bank = cpumask_to_vpset(&(ipi_arg->vp_set), mask);

nr_bank really confused me. bank_nr is what you mean, not number of banks,
right?

> +	}
> +	if (!nr_bank)
> +		ipi_arg->vp_set.format = HV_GENERIC_SET_ALL;
> +
> +	ret = hv_do_rep_hypercall(HVCALL_SEND_IPI_EX, 0, nr_bank,
> +			      ipi_arg, NULL);
> +
> +ipi_mask_ex_done:
> +	local_irq_restore(flags);
> +	return ret;
> +}

Thanks,

	tglx
_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
