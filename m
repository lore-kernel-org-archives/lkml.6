Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-3283754-1524781314-2-8584494917749556543
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_MED -2.3, SPF_PASS -0.001, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.138', Host='smtp1.osuosl.org', Country='US',
  FromHeader='de', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524781314; b=hbY6TTiAArR42VAVwK+HLcBCKltTUF+tmuzMeYGVF85g7hVj4y
    ipGYM5BEI4Az49VN998kK5/MEUR4duUuIh2qHo1lEwpmZwasQflxzZX+pKM9Pw/i
    TbtZPcfucrqfTrEVnuT/DAgYOt/HFHD/OwP2XOnED9LlNHZQUpSpdE8RDUA60DxO
    SsvfHqaUoBT1mXRQnpMk+DhOvQxj6TKOAiFBF+Ba9ncVNH6buKvbZyLn6a7zQyyu
    xjaPPbl8iqF9BpKxmnnNfvDSkNeffWKc54kH/B855kdTqUyHVl0NfwHWFJmwsF60
    kk3zaYrAauyEfrpHzKpmfWvNkGRvSPo4v7jg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:subject:in-reply-to
    :message-id:references:mime-version:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=fm2; t=1524781314; bh=WtZko
    EkOau6BkpTU/9ZzxHjjcLETn8SG1KtJtT+4998=; b=cpMycrdJ8b8tUHZ/CDMsX
    w25Wb4fdn2FTCjxeeHJWSlS5LJr7yc6GjiQxpgHymwAkdBi3HZiQMJWhkjGCb+DI
    BXe7V6o7dBtBmaEWB5M0k4n8LwKOXDBzIXBPCM9UzJrbZHCYdL5TCYSJKQUERRMX
    fwB2D2DI/dwJmI6aUm4mmZPP2ai9c5KOZMmxfwg0WWZma/7hOhfKWib1IHHzwV9E
    ev3Ykixu8vBVLcCuVg1haE13ENMMv6Zhj/9/C4dB5GdaRwsFWeY1mTJCS3PsIkZp
    pnzbbmJkH8eyoxre19Mj0QsIEPK2ziInEZxVYMxkPEKLt75tCkiUUlwAT0qxCtMt
    g==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linutronix.de;
    iprev=pass policy.iprev=140.211.166.138 (smtp1.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=whitealder.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=fail x-ptr-helo=whitealder.osuosl.org x-ptr-lookup=smtp1.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=linutronix.de header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=0 state=0
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linutronix.de;
    iprev=pass policy.iprev=140.211.166.138 (smtp1.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=whitealder.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=fail x-ptr-helo=whitealder.osuosl.org x-ptr-lookup=smtp1.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=linutronix.de header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfA6waFhEMheVegoSSlj2NBPIvnvtbyTnFpAHlG/wqwOxdr3wJ83qVYF23lTAKxDDlBz5n1fivH6xGwJ6B6NeBtBvI5JZr/BoO2yXOFJXfryHH/OF8daJ
    D8c/66EhkKE8kDpl3qlU1/NXx/qcq2osPZHYckP4xmwcKOqHn7VoA+qD67H9OJEuOJxXKpGaw95iuunMM5dY7s22oTgWURSwcec4NN95ao16Fahv24sQJZg/
    yjILiLRQ5/yFGecewrSOOQ==
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=28bQ1EhdAjTzU1YDPmtEKw==:117
    a=28bQ1EhdAjTzU1YDPmtEKw==:17 a=kj9zAlcOel0A:10 a=Kd1tUaAdevIA:10
    a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10 a=Odnh0R2cAAAA:8 a=DDOyTI_5AAAA:8
    a=KMVaEzmyRfOQVK2Ks80A:9 a=CjuIK1q_8ugA:10 a=lNAA6UHySJB7qmBR1x20:22
    a=_BcfOz0m4U4ohdxiHPKc:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: discussion
X-Remote-Delivered-To: driverdev-devel@osuosl.org
Date: Fri, 27 Apr 2018 00:21:41 +0200 (CEST)
From: Thomas Gleixner <tglx@linutronix.de>
To: "K. Y. Srinivasan" <kys@microsoft.com>
Subject: Re: [PATCH 4/5] X86: Hyper-V: Consolidate code for converting cpumask
 to vpset
In-Reply-To: <20180425181250.8740-4-kys@linuxonhyperv.com>
Message-ID: <alpine.DEB.2.21.1804270017300.1596@nanos.tec.linutronix.de>
References: <20180425181110.8683-1-kys@linuxonhyperv.com>
 <20180425181250.8740-1-kys@linuxonhyperv.com>
 <20180425181250.8740-4-kys@linuxonhyperv.com>
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
>  	if (!cpumask_equal(mask, cpu_present_mask)) {
> -		ipi_arg->vp_set.format = HV_GENERIC_SET_SPARCE_4K;
> +		ipi_arg->vp_set.format = HV_GENERIC_SET_SPARSE_4K;

Please move this patch before the others, so you can use SPARSE in the new
code right away.

Thanks,

	tglx
_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
