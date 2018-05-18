Return-Path: <jarkko.sakkinen@linux.intel.com>
X-Google-Smtp-Source: AB8JxZrZprOx51FJdCVexozA86UZMKt8LGspaiBUK46YHsq+JAut0P7WtGTtPhZ7ut1P/wwz8JHx
ARC-Seal: i=1; a=rsa-sha256; t=1526630722; cv=none;
        d=google.com; s=arc-20160816;
        b=wfV4CtX1tJTuXZMyKWnQxT3LOaMXcyjVIRDRLk9zLxQHR8EgGUh5/wa1AlIc7VY8uz
         F2Gr6Ra+KDNRmjpW/rU/JtNkRKmGUDApp06LO5pXjZoIJB5oaqhJlYKwVhEKqCBz0JvQ
         uwX4LdFNky503nqQq3oJMCbv1vhcFu9pgJCFCBsdkx5zSwc7UXjzdcNACI0NOX+bbV5A
         Kb84Xaig0Yfr5ea78KJ0PWTy7cEBwyc4/GBpWVcDsFAL9Wm7GJ8EiSq9LvuERL3s/KW/
         gsdu53PRu6o1GCWGthqIANVB9maOofhw2EVIO/feQARqA3wfdxGP9big3m5wJAlSQaTt
         k2dA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:organization:in-reply-to:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :arc-authentication-results;
        bh=ycrRJOE2DMjha4gu0q+myZg2J5j5eOq1lmv7IGGXiDQ=;
        b=N+QDW3zj9eJpYyQHvsIc55cS5bkMnBDc+0Gv9WyJ8qsHaZp2gSOn3945jb4FqhIAoV
         tBxeB4bF58hpWQnNmuSngiVaN/zbuO3GX3FU3XxKn98TXyi6bFJ4lVzO/+3zuUK3bjsR
         4ga/bjmHoggdCMqXwfMUaeJa86WnCVkktmkXLgF4DIHXGsDqQVQYNdFQCxls/AqheAZJ
         +n9wRcTx0YNqF4rnWNJmu7L9iu6RBQ0fNpKeZRbBXcILb4H1lVJoaGQXz8QKtG3bHn2z
         5amyQb1EC90CcW9nrfyVY51H3n45JsqsE+/BnxofylBpsduYqsvUz55amjOtf3u8b/c7
         Fd5w==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of jarkko.sakkinen@linux.intel.com designates 192.55.52.151 as permitted sender) smtp.mailfrom=jarkko.sakkinen@linux.intel.com;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=intel.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of jarkko.sakkinen@linux.intel.com designates 192.55.52.151 as permitted sender) smtp.mailfrom=jarkko.sakkinen@linux.intel.com;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=intel.com
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,413,1520924400";
   d="scan'208";a="51898061"
Date: Fri, 18 May 2018 11:05:16 +0300
From: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To: Nayna Jain <nayna@linux.vnet.ibm.com>
Cc: linux-integrity@vger.kernel.org, linux-security-module@vger.kernel.org,
	Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>,
	Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 3/4] tpm: migrate tpm2_get_tpm_pt() to use struct
 tpm_buf
Message-ID: <20180518080516.GB14777@linux.intel.com>
References: <20180326121406.14548-1-jarkko.sakkinen@linux.intel.com>
 <20180326121406.14548-4-jarkko.sakkinen@linux.intel.com>
 <95828353-43e1-0a02-ea54-544b709584b9@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <95828353-43e1-0a02-ea54-544b709584b9@linux.vnet.ibm.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.9.4 (2018-02-28)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596002384835671162?=
X-GMAIL-MSGID: =?utf-8?q?1600788336098716139?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, May 18, 2018 at 12:01:46PM +0530, Nayna Jain wrote:
> 
> 
> On 03/26/2018 05:44 PM, Jarkko Sakkinen wrote:
> > In order to make struct tpm_buf the first class object for constructing TPM
> > commands, migrate tpm2_get_tpm_pt() to use it.
> > 
> > Signed-off-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
> Reviewed-by: Nayna Jain<nayna@linux.vnet.ibm.com>
> Tested-by: Nayna Jain<nayna@linux.vnet.ibm.com>

For all the rest, thanks. I'll still do one more revision of these
patches to update the kdoc comments (but they do not involve any
code changes).

/Jarkko
