Return-Path: <konrad.wilk@oracle.com>
X-Google-Smtp-Source: AH8x227Rm5cppe5wYZAA3lz6LHnwAF8XBMte5XN6Iuu32rFmQvn3eRcy4U+IcgVeIhoWVjoN5MRp
ARC-Seal: i=1; a=rsa-sha256; t=1517594325; cv=none;
        d=google.com; s=arc-20160816;
        b=WKIJ1Fzle66iFhwwJ2nWpxOi8zeQp97dodXcJwEcc7jkLOvBOhw7Xs5rYCVtRLL43Y
         Gjxs+At0GAZkDqesaY125dyMGvhzYpog8qenPCGHCkIIZ2STtlDz8e1p8r6M1P6saNil
         HerzoikN74EHJSSoMYf2QkNpQ7yhmBlj2IMQPrbj/DVYaC059B6SRZZdS3HldfMoFCPX
         X7JfLo1Bf1+y9RPtvhU/uB3NzBwUa1sZ1svEL7iNbjATvYTHCpTzX9xBsqRRctD/EqyD
         bKRIwK4mzuUDAnkt3PHsCpCcPcJ/SIVKvZH8wNLSxkDj9d621Pz524ObnCRFGEEIxMfm
         iSBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:dkim-signature
         :arc-authentication-results;
        bh=7bBjPXaJ98x437gPIEZuMAvUvqqMm0taaVF7XxevA1Y=;
        b=Oz46vw6GHaqm7ZPRpOkQ8Glj98/1NnhlKOaHxsHVXkB1xevBs8t+/TxhUdDpiHQKys
         NXUznhDYOvz/md5tZW9FI7jaxe5PK+pgZ914tNAy9W1xk5blRXfVC5+kNDQ7M5m4IZRf
         Wi/FDW9Fpp1Bg96FlBVoW/oGHS0Y3oNSlT1qHj2zbeYqbfF9L6bqU/Vubl5D0po1CoG6
         2KDQ3aS8MrGxZWRfYrIu41tPNCNFiNPvjEpuyGatGwZHnsl9oSbjeGEriI2UogKKs/NS
         eX5YXvHLe4dJCggUIuZwjO3XWdHkXGnX+nPZEMOHNerHkMFm+/0fcEEbL0B7DX2UOckd
         8sSg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@oracle.com header.s=corp-2017-10-26 header.b=J7atDId9;
       spf=pass (google.com: domain of konrad.wilk@oracle.com designates 141.146.126.79 as permitted sender) smtp.mailfrom=konrad.wilk@oracle.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=oracle.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@oracle.com header.s=corp-2017-10-26 header.b=J7atDId9;
       spf=pass (google.com: domain of konrad.wilk@oracle.com designates 141.146.126.79 as permitted sender) smtp.mailfrom=konrad.wilk@oracle.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=oracle.com
Date: Fri, 2 Feb 2018 12:53:52 -0500
From: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
To: KarimAllah Ahmed <karahmed@amazon.de>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, x86@kernel.org,
        Asit Mallick <asit.k.mallick@intel.com>,
        Arjan Van De Ven <arjan.van.de.ven@intel.com>,
        Dave Hansen <dave.hansen@intel.com>, Andi Kleen <ak@linux.intel.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Dan Williams <dan.j.williams@intel.com>,
        Jun Nakajima <jun.nakajima@intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        David Woodhouse <dwmw@amazon.co.uk>,
        Greg KH <gregkh@linuxfoundation.org>,
        Andy Lutomirski <luto@kernel.org>, Ashok Raj <ashok.raj@intel.com>
Subject: Re: [PATCH v6 4/5] KVM: VMX: Allow direct access to
 MSR_IA32_SPEC_CTRL
Message-ID: <20180202175352.GT28192@char.us.oracle.com>
References: <1517522386-18410-1-git-send-email-karahmed@amazon.de>
 <1517522386-18410-5-git-send-email-karahmed@amazon.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1517522386-18410-5-git-send-email-karahmed@amazon.de>
User-Agent: Mutt/1.8.3 (2017-05-23)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8793 signatures=668661
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=768
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1802020218
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1591237580461918240?=
X-GMAIL-MSGID: =?utf-8?q?1591312987688676701?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

.snip..
> @@ -1913,6 +1914,29 @@ static void update_exception_bitmap(struct kvm_vcpu *vcpu)
>  }
>  
>  /*
> + * Check if MSR is intercepted for currently loaded MSR bitmap.
> + */
> +static bool msr_write_intercepted(struct kvm_vcpu *vcpu, u32 msr)
> +{
> +	unsigned long *msr_bitmap;
> +	int f = sizeof(unsigned long);

unsigned int
> +
> +	if (!cpu_has_vmx_msr_bitmap())
> +		return true;
> +
> +	msr_bitmap = to_vmx(vcpu)->loaded_vmcs->msr_bitmap;
> +
> +	if (msr <= 0x1fff) {
> +		return !!test_bit(msr, msr_bitmap + 0x800 / f);
> +	} else if ((msr >= 0xc0000000) && (msr <= 0xc0001fff)) {
> +		msr &= 0x1fff;
> +		return !!test_bit(msr, msr_bitmap + 0xc00 / f);
> +	}
> +
> +	return true;
> +}

with that:

Reviewed-by: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
