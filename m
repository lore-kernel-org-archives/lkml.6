Return-Path: <alexander.shishkin@linux.intel.com>
X-Google-Smtp-Source: AB8JxZrpB9C4wH/MmXVw8mTB3EUWrYcuOxwnoQ/avsnue1tcW6WiaJ40l6QBzcM61LJmLEsSprNR
ARC-Seal: i=1; a=rsa-sha256; t=1526293346; cv=none;
        d=google.com; s=arc-20160816;
        b=LJ5jk9Q7MS+vvaGpgIRmE3XHjmtipPC1pqwIiwqhQQM5sbS3Ik1Ec68wdp59g6r5P1
         MnDxALByS6xg3Ct9VSFO2WUE1q68qVwcCa85JsGbBcjH3lVnpM+8waHJKr/yR+COOow4
         kxa4/2z6OJMav3vgTu52+EOO047vyFGFmNsOWbFPaAjCsh5PovDnQ8V3ragsFUudIFUq
         oxLpzVLaA+ypvoI0pTEAnpB1bsF7h0aZjlErfRAwaUHdNn6z9ZOja80EVbXFdX2RPxjT
         d7mtiz/Bq75Ho1CBet9FAmG66I9jqM19Y6H3GAOMjxcEHFkOuXRKCzpikzqqsRz3RLci
         BReg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:arc-authentication-results;
        bh=vEnVAstjTMmhtiIxURXO+xEtUvtjgojuU/NS+UCe6pM=;
        b=L5ZDwyviJd7zC3KhHt24joekTSaDZ2ZybNdvp0UQLEW+Lnkl6ZUXbEiO5x5mZD/9+J
         GoDMtCoZAqJ50hEQ0HPIm97KDraongU2z2okQIBrQso5XJ9PHl30ZnJRWB6Hv4X6sVR/
         AYWGoVPrwbIaNcEgw2zWBuXXVNXY02kCAykl9TPXYSClK8hXtcfywXAt8Wjo3BFgg+I1
         Sen9/7ivBTUl1ojIX4odbDtVse2phzPeuLna0NarVMnrPcO6IclaYkZdnYooOdqBUcEh
         dFnokWOJZEtVBH0W6uqXIzxCgtwVCGrjOWtYlPfXEWfVkE70nPaLySopuJdwQX3bYUIM
         l2+g==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of alexander.shishkin@linux.intel.com designates 192.55.52.151 as permitted sender) smtp.mailfrom=alexander.shishkin@linux.intel.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of alexander.shishkin@linux.intel.com designates 192.55.52.151 as permitted sender) smtp.mailfrom=alexander.shishkin@linux.intel.com
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,399,1520924400";
   d="scan'208";a="54117925"
Date: Mon, 14 May 2018 13:22:17 +0300
From: Alexander Shishkin <alexander.shishkin@linux.intel.com>
To: Luwei Kang <luwei.kang@intel.com>
Cc: kvm@vger.kernel.org, tglx@linutronix.de, mingo@redhat.com,
	hpa@zytor.com, x86@kernel.org, chao.p.peng@linux.intel.com,
	thomas.lendacky@amd.com, bp@suse.de, Kan.liang@intel.com,
	Janakarajan.Natarajan@amd.com, dwmw@amazon.co.uk,
	linux-kernel@vger.kernel.org, alexander.shishkin@linux.intel.com,
	peterz@infradead.org, mathieu.poirier@linaro.org,
	kstewart@linuxfoundation.org, gregkh@linuxfoundation.org,
	pbonzini@redhat.com, rkrcmar@redhat.com, david@redhat.com,
	bsd@redhat.com, yu.c.zhang@linux.intel.com, joro@8bytes.org
Subject: Re: [PATCH v8 01/12] perf/x86/intel/pt: Move Intel-PT MSRs bit
 definitions to a public header
Message-ID: <20180514102217.uc3kzhu6gs4wapuo@um.fi.intel.com>
References: <1526295432-20640-1-git-send-email-luwei.kang@intel.com>
 <1526295432-20640-2-git-send-email-luwei.kang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1526295432-20640-2-git-send-email-luwei.kang@intel.com>
User-Agent: NeoMutt/20180323
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1600429565340015294?=
X-GMAIL-MSGID: =?utf-8?q?1600434571618850671?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, May 14, 2018 at 06:57:01PM +0800, Luwei Kang wrote:
> From: Chao Peng <chao.p.peng@linux.intel.com>
> 
> Intel Processor Trace virtualization enabling in KVM guest
> need to access these MSRs bit definitions, so move them to
> public header file msr-index.h.
> @@ -115,6 +148,7 @@
>  #define MSR_IA32_RTIT_ADDR2_B		0x00000585
>  #define MSR_IA32_RTIT_ADDR3_A		0x00000586
>  #define MSR_IA32_RTIT_ADDR3_B		0x00000587
> +#define MSR_IA32_RTIT_ADDR_RANGE	4

This one wasn't there before, so belongs in a different patch.

Regards,
--
Alex
