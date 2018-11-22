Return-Path: <SRS0=Yw3T=OB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E62FC43441
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 18:46:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E822820824
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 18:46:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="LKR+57LM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E822820824
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=alien8.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388304AbeKWF13 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Nov 2018 00:27:29 -0500
Received: from mail.skyhub.de ([5.9.137.197]:59684 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729748AbeKWF13 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Nov 2018 00:27:29 -0500
Received: from zn.tnic (p200300EC2BDC9100898E5A1DF8FAB135.dip0.t-ipconnect.de [IPv6:2003:ec:2bdc:9100:898e:5a1d:f8fa:b135])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id BF6A91EC06CA;
        Thu, 22 Nov 2018 19:46:50 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1542912410;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=mAkOzn0kYsUOQ71qgrcvEiL38sVGUGg/ymftslkkTQY=;
        b=LKR+57LMDux2pFVP5r21RKgfXnVIqeb7lSXz3TTkklUS4Sc7Xm+uQF5s0+C0/+i1/PTZ8S
        Bu+6RRaJHYKMPyOtz6ffhyje0/NqG8DuyiPRtKeTyrupktKi4a11A40MOfks0q3LotjrW+
        yVZGm7TXaYsKlPbnhrLrzsuOOdeSql8=
Date:   Thu, 22 Nov 2018 19:46:44 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     "Moger, Babu" <Babu.Moger@amd.com>
Cc:     "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "fenghua.yu@intel.com" <fenghua.yu@intel.com>,
        "reinette.chatre@intel.com" <reinette.chatre@intel.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "hpa@zytor.com" <hpa@zytor.com>, "x86@kernel.org" <x86@kernel.org>,
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
Subject: Re: [PATCH v9 08/13] x86/resctrl: Rename config parameter INTEL_RDT
 to RESCTRL
Message-ID: <20181122184644.GF10365@zn.tnic>
References: <20181121202811.4492-1-babu.moger@amd.com>
 <20181121202811.4492-9-babu.moger@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20181121202811.4492-9-babu.moger@amd.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 21, 2018 at 08:28:39PM +0000, Moger, Babu wrote:
> Resource control feature is supported by both Intel and AMD.
> So, rename the INTEL_RDT to vendor neutral RESCTRL.
> 
> Now CONFIG_RESCTRL will be used for both Intel and AMD to enable
> Resource Control support. Update the texts in config and condition
> accordingly.
> 
> Signed-off-by: Babu Moger <babu.moger@amd.com>
> ---
>  arch/x86/Kconfig                     | 23 ++++++++++++++++-------
>  arch/x86/include/asm/resctrl_sched.h |  4 ++--
>  arch/x86/kernel/cpu/Makefile         |  2 +-
>  arch/x86/kernel/cpu/resctrl/Makefile |  4 ++--
>  include/linux/sched.h                |  2 +-
>  5 files changed, 22 insertions(+), 13 deletions(-)
> 
> diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
> index 1a0be022f91d..36aad997caf8 100644
> --- a/arch/x86/Kconfig
> +++ b/arch/x86/Kconfig
> @@ -445,16 +445,25 @@ config RETPOLINE
>  	  code are eliminated. Since this includes the syscall entry path,
>  	  it is not entirely pointless.
>  
> -config INTEL_RDT
> -	bool "Intel Resource Director Technology support"
> +config RESCTRL
> +	bool "Resource Control support"
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
> +	  and monitoring of the usage of certain system resources by one or more
> +	  processors.
> +
> +	  Intel refers to this feature as Intel Resource Director Technology
> +	  (Intel(R) RDT). More information about RDT can be found in the
> +	  Intel x86 Architecture Software Developer Manual.
> +
> +	  AMD refers to this feature as AMD Platform Quality of Service(AMD QoS).
> +	  More information about AMD QoS can be found in AMD64 Technology
> +	  Platform Quality of Service Extensions manual.

I've simplified this to:

          Enable Resource Control support.

          Provide support for the allocation and monitoring of system resources 
          usage by the CPU.

          Intel calls this Intel Resource Director Technology
          (Intel(R) RDT). More information about RDT can be found in the
          Intel x86 Architecture Software Developer Manual.

          AMD calls this AMD Platform Quality of Service (AMD QoS).
          More information about AMD QoS can be found in the AMD64 Technology
          Platform Quality of Service Extensions manual.

          Say N if unsure.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
