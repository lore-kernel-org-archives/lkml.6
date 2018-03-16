Return-Path: <jarkko.sakkinen@linux.intel.com>
X-Google-Smtp-Source: AG47ELvWTU2gDA79UwMf699Dm+VLL52v0UI2lLo82ekWqkpObDFEiJHFthpeLToczfZAK4T0Kljf
ARC-Seal: i=1; a=rsa-sha256; t=1521202895; cv=none;
        d=google.com; s=arc-20160816;
        b=fiu/JQr+ZH/BvrFtr5/fiE12hdRHOcoQtJ/DnD1Qle4xOXYkPEs6wGhLXOmERZM5AQ
         iMrRXZVbF11KUSptSVQr7xo1BBEnkMkia2gBE49h5r3egSHb2eY8uDdLbqLj1DtKciFx
         Dlpqi5OZgCFSV38v2XOQJSo4128trK+3r30PkuQ6xXHGaeQPtOQtRjLe3jbAuJ+xABHZ
         uHwlgqYKV8XlR5QOKVovlSxuAKLFA58UrmRatPWsALTTGAfJ7p3+5AlyaFQFrtYUZPLk
         zpfJdDYPzVmYbwrsmDcdNmNkFv5dT/LEfuHfrC767x9EbLMcbEf11LfC1D/w2dENmeM9
         CeNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:organization:in-reply-to:content-transfer-encoding
         :content-disposition:mime-version:references:message-id:subject:cc
         :to:from:date:arc-authentication-results;
        bh=J10fSG1A4pvK61JrfS5L99109uP8R6HcRim05uJtsbE=;
        b=ttmiNDUphYRo5DJfRopXoZ9zG6z59ELLul0C534C8dVNOV900DGe9lBp5qHpd2iNdK
         fxdAMFf0A01xcfPFRsns1OOmp0KSHeACaZWG4HlD0itBGHMf01eqrplU8mjJ+ZjFUF+T
         4g4PmGS4oglfiDTlGMfgFsDDMIfwj1onDYqQZ3id/laE/8KkGy6Za/g+TUYTEJOfj9bf
         Jl3thZ+hN0fOZPodOqNLV1nAvlFcm7Nyfv6U0MF28ygCnEuIWipysiUkTXoy7E/hB3X6
         6eYVi3mGzd40RbWm/KEeeNFrcWQoDSWy2lPe1zaAxEj/d0UH05Q9ttR4jP2H27eMh6kQ
         ZJXg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of jarkko.sakkinen@linux.intel.com designates 134.134.136.65 as permitted sender) smtp.mailfrom=jarkko.sakkinen@linux.intel.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of jarkko.sakkinen@linux.intel.com designates 134.134.136.65 as permitted sender) smtp.mailfrom=jarkko.sakkinen@linux.intel.com
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,315,1517904000";
   d="scan'208";a="39491207"
Date: Fri, 16 Mar 2018 14:21:29 +0200
From: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To: Mimi Zohar <zohar@linux.vnet.ibm.com>
Cc: linux-integrity@vger.kernel.org, linux-security-module@vger.kernel.org,
	keyrings@vger.kernel.org, Peter Huewe <peterhuewe@gmx.de>,
	Jason Gunthorpe <jgg@ziepe.ca>, Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 3/5] tpm: migrate tpm2_probe() to use struct tpm_buf
Message-ID: <20180316122129.GA2458@linux.intel.com>
References: <20180305165614.5469-1-jarkko.sakkinen@linux.intel.com>
 <20180305165614.5469-4-jarkko.sakkinen@linux.intel.com>
 <1520290344.10396.357.camel@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1520290344.10396.357.camel@linux.vnet.ibm.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.9.4 (2018-02-28)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593676067717266056?=
X-GMAIL-MSGID: =?utf-8?q?1595096847398989755?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, Mar 05, 2018 at 05:52:24PM -0500, Mimi Zohar wrote:
> Hi Jarrko,
> 
> On Mon, 2018-03-05 at 18:56 +0200, Jarkko Sakkinen wrote:
> > In order to make struct tpm_buf the first class object for constructing TPM
> > commands, migrate tpm2_probe() to use it.
> > 
> > Signed-off-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
> 
> With this patch, the Pi doesn't find the TPM.  I'm seeing the
> following line in dmesg.
> 
> [    1.087414] tpm_tis_spi: probe of spi0.0 failed with error 256

Thank you for reporting this Mimi. Does it have TPM1/TPM2?

/Jarkko
