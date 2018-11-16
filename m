Return-Path: <SRS0=A7nN=N3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7356C43441
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 21:18:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B03E2086A
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 21:18:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="bs9I1aA5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6B03E2086A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727484AbeKQHcH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 17 Nov 2018 02:32:07 -0500
Received: from merlin.infradead.org ([205.233.59.134]:53304 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725885AbeKQHcG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Nov 2018 02:32:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=WvaXTMSGcnBhxv1J6jg5JMvzH/IHu/QWkK1xYdFeJb0=; b=bs9I1aA5u8KJkgPxMFQ10BmLiC
        FUQq8KNnwVxRpyuNJaTsHieFwDevq0yPLtevpgT1Od6sugGzt9ZTsINT5f7abpmRQqJRXQB1QRpy7
        CzVGGMBBh3kxrADMy0sMFsL6q2BnZoME/rkXFa2O2+3UXVApWmnaGMFDHkjhftBrCHmeERRE3L0YA
        SM50/+e9KK8ccUpmqvh+A9Ko2Iah4csB/eELVIomtfbmQA6jVxE82cvoygDvolQJ071DLq+BMSOmr
        827p577TUPUlUiHdFzkz0sPpRNvzkSlZdmsKaP9lmrekhU3860FILDIWg2WjcGEsyRnsftN3LRMfE
        Fw51H3QA==;
Received: from static-50-53-52-16.bvtn.or.frontiernet.net ([50.53.52.16] helo=midway.dunlab)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gNlUq-0004LI-E5; Fri, 16 Nov 2018 21:17:48 +0000
Subject: Re: [PATCH v8 09/13] arch/resctrl: Update the RESCTRL config
 parameter
To:     "Moger, Babu" <Babu.Moger@amd.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>, "corbet@lwn.net" <corbet@lwn.net>,
        "fenghua.yu@intel.com" <fenghua.yu@intel.com>,
        "reinette.chatre@intel.com" <reinette.chatre@intel.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>
Cc:     "hpa@zytor.com" <hpa@zytor.com>, "x86@kernel.org" <x86@kernel.org>,
        "mchehab+samsung@kernel.org" <mchehab+samsung@kernel.org>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "kstewart@linuxfoundation.org" <kstewart@linuxfoundation.org>,
        "pombredanne@nexb.com" <pombredanne@nexb.com>,
        "rafael@kernel.org" <rafael@kernel.org>,
        "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
        "tony.luck@intel.com" <tony.luck@intel.com>,
        "qianyue.zj@alibaba-inc.com" <qianyue.zj@alibaba-inc.com>,
        "xiaochen.shen@intel.com" <xiaochen.shen@intel.com>,
        "pbonzini@redhat.com" <pbonzini@redhat.com>,
        "Singh, Brijesh" <brijesh.singh@amd.com>,
        "Hurwitz, Sherry" <sherry.hurwitz@amd.com>,
        "dwmw2@infradead.org" <dwmw2@infradead.org>,
        "Lendacky, Thomas" <Thomas.Lendacky@amd.com>,
        "luto@kernel.org" <luto@kernel.org>,
        "joro@8bytes.org" <joro@8bytes.org>,
        "jannh@google.com" <jannh@google.com>,
        "vkuznets@redhat.com" <vkuznets@redhat.com>,
        "rian@alum.mit.edu" <rian@alum.mit.edu>,
        "jpoimboe@redhat.com" <jpoimboe@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>
References: <20181116205407.10457-1-babu.moger@amd.com>
 <20181116205407.10457-10-babu.moger@amd.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <99946ea2-dceb-b274-2434-2e9e1c211582@infradead.org>
Date:   Fri, 16 Nov 2018 13:17:44 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <20181116205407.10457-10-babu.moger@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/16/18 12:54 PM, Moger, Babu wrote:
> CONFIG_RESCTRL will be used for both Intel and AMD to enable
> Resource Control feature. Update the details and condition accordingly.
> 
> Signed-off-by: Babu Moger <babu.moger@amd.com>
> ---
>  arch/x86/Kconfig | 19 ++++++++++++++-----
>  1 file changed, 14 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
> index 4aae7aba4d61..c5ef3afa89a6 100644
> --- a/arch/x86/Kconfig
> +++ b/arch/x86/Kconfig
> @@ -448,13 +448,22 @@ config RETPOLINE
>  config RESCTRL
>  	bool "Resource Control feature support"
>  	default n
> -	depends on X86 && CPU_SUP_INTEL
> +	depends on X86 && (CPU_SUP_INTEL || CPU_SUP_AMD)
>  	select KERNFS
>  	help
> -	  Select to enable resource allocation and monitoring which are
> -	  sub-features of Intel Resource Director Technology(RDT). More
> -	  information about RDT can be found in the Intel x86
> -	  Architecture Software Developer Manual.
> +	  Select to enable Resource Control feature support.
> +
> +	  These features are intended to provide the support for the allocation
> +	  and monitoring the usage of certain system resources by one or more

	  and monitoring of the usage

> +	  processors.
> +
> +	  Intel refers this feature as Intel Resource Director Technology

	        refers to this feature

> +	  (Intel(R) RDT). More information about RDT can be found in the
> +	  Intel x86 Architecture Software Developer Manual.
> +
> +	  AMD refers this feature as AMD Platform Quality of Service(AMD QoS).

	      refers to this feature

> +	  More information about AMD QoS can be found in AMD64 Technology
> +	  Platform Quality of Service Extensions manual.
>  
>  	  Say N if unsure.
>  
> 


-- 
~Randy
