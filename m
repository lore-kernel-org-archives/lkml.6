Return-Path: <luc.vanoostenryck@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1521739670; cv=none;
        d=google.com; s=arc-20160816;
        b=Qw3rzpEkiyUVOFg97sN2hgcBRgOCpBa+Tz+GMgaixqwbNBlwzfrghu+f7VEKHrzVQq
         OK/F03F1hdKl2o95nmBtM5krWc7IRAEss1x1MwCWL2gdjDPgFnCyI8Dw2uckAIH007aA
         J+V/rLoF0iDjAeSD7ESuILW/HFf7Lu9tH78Jq4JN55G0ICgE/DaH4uGwnlLFareghpAc
         KCf4ypHwDO0vBiyNBFxxZHH4bZTSj1SQJR+di9i4scsvsku7d5fw5E8j81nJAzCX+M6L
         gFout4bbSBtZlm1XgEnB9uowr04knPssHw4tTllx53nI+/Mn1Omxwa79EuBmtibOCwWc
         eW1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:dkim-signature
         :arc-authentication-results;
        bh=7zdN9H+UzjxORJlvIUJ7s04/mpWt8wVB1RxPZ2xJx/Y=;
        b=QpXTS+zU4c5tsNYkwIjHfIej8pVCeoISi/B8OD3+/OqVei+KgvzpTwIc/JoeVQ02BJ
         /vCBnfinc4h4CI/2l+tx+nrnIbuuNMdmDFacayLMBfeEUz+zY/0i8uFINN7dLYcZ1ARN
         2r+2CP3xiNEW6wzl2hnrOfoGHd9/tnIUvZtyCAEXVEr1s0oSrDgILo4K9AkKXU7n63ze
         CPzU2s4yI9/62/iZ7QMbcoo4kCm2ex4z3/fykFix3H113xi8dS7Hlu8kRggrKtOTInUL
         5iQv6NcRvGMYb5oL8P7g6bbiif3sCH8KMnNlspFKSLvNS7XKknLdt5rofgLLfjYbwf7t
         vKhw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=PpaxXgEp;
       spf=pass (google.com: domain of luc.vanoostenryck@gmail.com designates 209.85.220.41 as permitted sender) smtp.mailfrom=luc.vanoostenryck@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=PpaxXgEp;
       spf=pass (google.com: domain of luc.vanoostenryck@gmail.com designates 209.85.220.41 as permitted sender) smtp.mailfrom=luc.vanoostenryck@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
X-Google-Smtp-Source: AG47ELvsj5KVaY5P43cD0rDzNOdPFTJskXd4/8FELaLAvEoY3mCk6oYYeNnjIXctyE9lN0GAcmcSdw==
Date: Thu, 22 Mar 2018 18:27:48 +0100
From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To: Logan Gunthorpe <logang@deltatee.com>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
	linux-ntb@googlegroups.com, linux-crypto@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Andy Shevchenko <andy.shevchenko@gmail.com>,
	Horia =?utf-8?Q?Geant=C4=83?= <horia.geanta@nxp.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Philippe Ombredanne <pombredanne@nexb.com>,
	Kate Stewart <kstewart@linuxfoundation.org>
Subject: Re: [PATCH v14 02/10] iomap: Add big endian sparse annotations to
 mmio_{read|write}XXbe()
Message-ID: <20180322172747.4rjped3gojfuhuh2@ltop.local>
References: <20180322171703.4300-1-logang@deltatee.com>
 <20180322171703.4300-3-logang@deltatee.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180322171703.4300-3-logang@deltatee.com>
User-Agent: NeoMutt/20171215
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595659036992994205?=
X-GMAIL-MSGID: =?utf-8?q?1595659696535549520?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, Mar 22, 2018 at 11:16:55AM -0600, Logan Gunthorpe wrote:
> Sparse produces a few warnings of the form:
> 
> lib/iomap.c:84:9: warning: cast to restricted __be16
> 
> (The kbuild robot has recently started running such checks)

Reviewed-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com> 
