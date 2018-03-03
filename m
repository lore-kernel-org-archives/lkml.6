Return-Path: <sergeev917@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1520110682; cv=none;
        d=google.com; s=arc-20160816;
        b=dTvMoEFV/SnKvQ/A5jLxpOOwGrAEV9Ab59mNiQTVONdVuKJIbWtoCi9Q3RYJb/sf2K
         Jb+GNVneXeqThVLC1Qw71OUNGcWU8nl+zeGKXSxLKxJE6+klCm3P7QoFLz3BkG8TCzgf
         UeToYzF+bXVXUsQkF2SWxkPGTQtINEVpoOYgqrFl+zz5Pe40fzU2mZM74fLWlDR+2Gtr
         g90thToWF+sWTL9mb9hsPVXRsr5roeSHgy53rFxZX+dEX0O8okqqJaOGXALgQ7JMXDWP
         80a0BshmgsnVqor3zbm1XR6uR7NjZLX+FRGOMLYBYd3846VI+IUJuIh8lssRN3vbuazd
         5Mog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:dkim-signature:arc-authentication-results;
        bh=eLKJY1GokhqqGxqKnv4aFKxrJqKLzW90ug6SOv4ngb0=;
        b=oVDSRwd1ae3IOmln0IcHBRd/v9q7lI/Pv2uiHxinBrPCp82RZwJGEMgN2JdwQFzTmS
         I7mbn/roCHtVDBdt4fzU1TdToTh7XvCz940uIBYnzuUhzcXCr3gxGExntINZ/BhNYF6U
         rl1dFM+RYyvvn/AohnVppdTe9FhOakTFgL88hQV0egQZZoUX2j36UUELexBaKsmyi0Rw
         b0RO1uwb9NLYe1RIrWQH8urHqJHyTEddGaI2o95TZqljrDofhO7Pf+NFYS1E3Ylh7119
         mWxWygnbgr0iVpPZsbxQYpuwyPcwt+WxNmFmXl83tQl0zFwhpDl7KKFhJltc2xst8U3g
         nzVw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=mFC0NeO8;
       spf=pass (google.com: domain of sergeev917@gmail.com designates 209.85.220.41 as permitted sender) smtp.mailfrom=sergeev917@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=mFC0NeO8;
       spf=pass (google.com: domain of sergeev917@gmail.com designates 209.85.220.41 as permitted sender) smtp.mailfrom=sergeev917@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
X-Google-Smtp-Source: AG47ELu+7cfuDXrp3d6ZCYXqCbP2Gaf8inO5kvA4yZHDAsGubRINessNwoVm4Qk/tks5XsTtWf85ow==
Date: Sun, 4 Mar 2018 00:02:04 +0300
From: Alexander Sergeyev <sergeev917@gmail.com>
To: David Woodhouse <dwmw@amazon.co.uk>
Cc: Ingo Molnar <mingo@redhat.com>, Thomas Gleixner <tglx@linutronix.de>,
	"H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
	Kyle Huey <me@kylehuey.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Peter Zijlstra <peterz@infradead.org>, linux-kernel@vger.kernel.org
Subject: spectre v2 microcodes blacklist (march update)
Message-ID: <20180303210204.GA6148@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
User-Agent: mtt
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593951579457590092?=
X-GMAIL-MSGID: =?utf-8?q?1593951579457590092?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi,

the microcode revision guidance from Intel is revised once again [1] (1 Mar).

It looks like the following:

>Intel document only clears the 0xc2 microcode on *some* parts with CPUID 506E3 
>(INTEL_FAM6_SKYLAKE_DESKTOP stepping 3). For the Skylake H/S platform it's OK 
>but for Skylake E3 which has the same CPUID it isn't (yet) cleared.

is no longer a problem. CPUID 506E3 with both Skylake H/S and Skylake Xeon E3 
is labelled as "production" now.

Could we drop { INTEL_FAM6_SKYLAKE_DESKTOP, 0x03, 0xc2 } from 
spectre_bad_microcodes?

[1] 
https://newsroom.intel.com/wp-content/uploads/sites/11/2018/03/microcode-update-guidance.pdf
