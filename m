Return-Path: <jarkko.sakkinen@linux.intel.com>
X-Google-Smtp-Source: AG47ELt+MpK+mIMeohlUkkxnh2BAAJ6nMOjZKliqTrca2B78KSP7FiRGVqC4ht7MRrlQViIQ8mFb
ARC-Seal: i=1; a=rsa-sha256; t=1520336256; cv=none;
        d=google.com; s=arc-20160816;
        b=k3nR/Y9tVDuWRxXGYoWzBAp4YJ8IoZwum9IwRfJh++x8fFQBI6ttPtoOyz3A24AOR7
         mbd5nIVuv91BVDn6VzbnmMaYswvwqIIbUaQ1g6reJlqKD0DLYxdY9qjO7EXvw751qKig
         gsZOws6hGXoxXnp2uvL1qZa3iTM56UgiaBRykU5/IG+8kIJAGP8K9rM5jbrLAawfXnzR
         tEsS31gRs4wlZxtHU1DUTD2uU+ct31lsqjNr2sOUdGNit3vH24UCvZlfrgJ5+z2yD5AD
         /WDFsIiD/gN86ig0Vteiy76RwwjcUIV/nYrX7A4jYUhtH2KWMdT+hL4omD1Lvbl6GWVk
         /6ow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:mime-version:organization:references
         :in-reply-to:date:cc:to:from:subject:message-id
         :arc-authentication-results;
        bh=c/GYObSle1/1cJCKtFDgbAhvWU0Ku7cqGP4VVZzml8s=;
        b=MGVf1mXNij3voPNVIeVpMQQ6gIsVQ3/D+2up6DaMVSXbyFg+79DHuhECv5a1ri3qOw
         L27v1+uBd/HffAlVDtudUeUrne/iHwuUZdIVhxOSnEjA6Kkmm4YIHNEb/1v1CfVbRfxD
         hSNpUWmvUZYnAWvbUMWcNDYa2Vt9mqZiM+SUxEu+zyQBoAu8vRZ8pJaZkLTTuhVof3bn
         rsxNKZLKMAQ7z/NYeF4LukgCYRNC2mq2ZztUY59oQBnMhkjbtPzgCr5TW/DEv0PrnAH2
         ariJXVJ7ZtX0lE3UejNhTDm8nR5J4zpNzoRzy3FLhIX8y9jpIZqt397eRhda+5U5UkMg
         0PNQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of jarkko.sakkinen@linux.intel.com designates 134.134.136.100 as permitted sender) smtp.mailfrom=jarkko.sakkinen@linux.intel.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of jarkko.sakkinen@linux.intel.com designates 134.134.136.100 as permitted sender) smtp.mailfrom=jarkko.sakkinen@linux.intel.com
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.47,431,1515484800";
   d="scan'208";a="22922278"
Message-ID: <1520336251.7549.13.camel@linux.intel.com>
Subject: Re: [PATCH v3 3/5] tpm: migrate tpm2_probe() to use struct tpm_buf
From: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To: linux-integrity@vger.kernel.org
Cc: linux-security-module@vger.kernel.org, keyrings@vger.kernel.org, Peter
 Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>, Arnd Bergmann
 <arnd@arndb.de>,  Greg Kroah-Hartman <gregkh@linuxfoundation.org>, open
 list <linux-kernel@vger.kernel.org>
Date: Tue, 06 Mar 2018 13:37:31 +0200
In-Reply-To: <20180305165614.5469-4-jarkko.sakkinen@linux.intel.com>
References: <20180305165614.5469-1-jarkko.sakkinen@linux.intel.com>
	 <20180305165614.5469-4-jarkko.sakkinen@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.5-1build1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593676067717266056?=
X-GMAIL-MSGID: =?utf-8?q?1594188110567158291?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, 2018-03-05 at 18:56 +0200, Jarkko Sakkinen wrote:
> In order to make struct tpm_buf the first class object for constructing TPM
> commands, migrate tpm2_probe() to use it.
> 
> Signed-off-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>

Jason, is this now OK? I removed the error klog.

/Jarkko
