Return-Path: <jgg@ziepe.ca>
ARC-Seal: i=1; a=rsa-sha256; t=1520351044; cv=none;
        d=google.com; s=arc-20160816;
        b=ixjIOO8uB3lnutoj3DINoobM97uZLCqQisJIgB070sC4NaGZhFT2OwtY6W0iRsAUsg
         IeZ4KkBhLKX5HUoCvFGsWPOHCMIh7xVHIZa2e8CZNJkJa7tKhKUQjHf7M3LRR4gboix7
         rCIMdSrE8cSQLJSNGU0t4LRb3sb/pNWggT3a2E+xWALzOCulfPa8Ffe+QwELwTSspr8L
         AtOjfcujew/NlkIrsYKMs8Zq7LcgRSqQH8jMD1WL3G7C/11uh280AQbC1+lRUjQi8eIs
         MK4CGnaRGlB+WkFGC0W0DH0mcAVa1u1hvdEHoikx86znma/RktmSJEvxmLsibbnBLWtN
         GhTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:dkim-signature
         :arc-authentication-results;
        bh=aQMyCAuyb554soyjNEkA6Ww77Q36cSkLF7maOBgNKfE=;
        b=CVyDRNnJXXiXwH1UTsC20gpgoTPG1pDyo2D5EfdYsVtHhJQeYxWfDZBYsuJII0pQqd
         2JNxWy5CxmEcpO1GtiVLTvwzyj1Ws3HdJxit0g1ITFYhOaa42r0vKrEtXsc6ATxeWcmZ
         H5UPPv1s2QfBcjtgYlDb3lmr233uIfUQ56jCgKT+87kKA1z1h36lat1C5i7wrI2sXJPy
         8N5pD0QTLSSwCMtJFMSWnSoUC0PT5jr5aOWRJKRuhYgrP9OUz5bBkkLT/aU98p7sn0xv
         Dw/5BdvDBDYvXfuCjeqW6Rig7AIu2zSCvz5WzHxrRnJfX6FvwT3iS1XG61CVo0KxGY9p
         qPVw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@ziepe.ca header.s=google header.b=o/8Y47QY;
       spf=pass (google.com: domain of jgg@ziepe.ca designates 209.85.220.65 as permitted sender) smtp.mailfrom=jgg@ziepe.ca
Authentication-Results: mx.google.com;
       dkim=pass header.i=@ziepe.ca header.s=google header.b=o/8Y47QY;
       spf=pass (google.com: domain of jgg@ziepe.ca designates 209.85.220.65 as permitted sender) smtp.mailfrom=jgg@ziepe.ca
X-Google-Smtp-Source: AG47ELsEe3ms++w2zzvVQGfo64F76YwxF+klYo68KcehDQQz5dlZGX8qd4DXw1e2B8ZmiY2Kb1vjCw==
Date: Tue, 6 Mar 2018 08:44:01 -0700
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc: linux-integrity@vger.kernel.org, linux-security-module@vger.kernel.org,
	keyrings@vger.kernel.org, Peter Huewe <peterhuewe@gmx.de>,
	Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 3/5] tpm: migrate tpm2_probe() to use struct tpm_buf
Message-ID: <20180306154401.GB13395@ziepe.ca>
References: <20180305165614.5469-1-jarkko.sakkinen@linux.intel.com>
 <20180305165614.5469-4-jarkko.sakkinen@linux.intel.com>
 <1520336251.7549.13.camel@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1520336251.7549.13.camel@linux.intel.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593676067717266056?=
X-GMAIL-MSGID: =?utf-8?q?1594203616616079667?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, Mar 06, 2018 at 01:37:31PM +0200, Jarkko Sakkinen wrote:
> On Mon, 2018-03-05 at 18:56 +0200, Jarkko Sakkinen wrote:
> > In order to make struct tpm_buf the first class object for constructing TPM
> > commands, migrate tpm2_probe() to use it.
> > 
> > Signed-off-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
> 
> Jason, is this now OK? I removed the error klog.

Sure the log message is gone - but I haven't been auditing your tpm_buf
work..

Jason
