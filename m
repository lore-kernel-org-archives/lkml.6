Return-Path: <jarkko.sakkinen@linux.intel.com>
X-Google-Smtp-Source: AIpwx4+OntGiW/8Zc3kJvRsK6DXOeseTk7YY5IWAyBToglhcA3/4iHW8ASdquCuveHx2tFbnHtQP
ARC-Seal: i=1; a=rsa-sha256; t=1523272275; cv=none;
        d=google.com; s=arc-20160816;
        b=pdvUbwfHwrLi8eMyKkoZguGXnGBzgLLENiVjzdMvDZfVacsKlPD0vKKgC0c6/8yJj6
         6GKazCHS9AbVaznefsoQ5NEm/utOoWCCOo3QRdKrLRN84e9gUz1a6Oqt3x5WQBJoY6yI
         ief2t51LuVPo131MiX/U82Daze+bSsRnp07O7YnnavdETRcI6dh9XkwNAUUI5r0lYZH9
         UJLMhqE4zp6vXdgOTn7uqks6j/m15L8QoQWoJAdZFKGKDmL4YM+jwUA4n0/yVHznWuFK
         MVdkQGXnmAicT5iGljzB08lAao7nDtvHmgScf74etOy9t3tUB4jT7OW/huWXUC/v9HlB
         3Cxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:mime-version:organization:references
         :in-reply-to:date:cc:to:from:subject:message-id
         :arc-authentication-results;
        bh=REKAe9hCbMVSDM832URGN18TZOx/31kOCjfu/3eWxMg=;
        b=p7s4A3rxbwWaAGDEbRM9hSVVzl0Cv3/cFGH4sDGy/5hR/rifMmgUZXQNl52lxSLgf3
         eUTRCMLMq4tlp2R7pYYG5YUURuonWDLouX4t/tlHGjyuHbFEyTGdtemctFDBGXveRbtD
         jiMYFLYQ0bLVN7QJmxWlKA0maYJP617ebnc/lkYZj1mn1QYhbeU/DxpiD9T4Hjp2cf+l
         bcvOxLwSxYknMHvf8tv9ruvn0Fmb0fxZXfirnth52SvHzZdiWXYX7mHSOdeADzaD/f21
         EsVsGheilUVmXe9FNSRhkQ0uyv7o1NLdOkPUM+xzyJD3zn5IjGcWD0rQ82cvNfrh0UJ0
         AZBg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of jarkko.sakkinen@linux.intel.com designates 192.55.52.43 as permitted sender) smtp.mailfrom=jarkko.sakkinen@linux.intel.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of jarkko.sakkinen@linux.intel.com designates 192.55.52.43 as permitted sender) smtp.mailfrom=jarkko.sakkinen@linux.intel.com
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,427,1517904000";
   d="scan'208";a="35647115"
Message-ID: <4ea103c15998af56813fb870ac9a27a34a694f49.camel@linux.intel.com>
Subject: Re: [PATCH] tpm: st33zp24: remove redundant null check on chip
From: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To: Colin King <colin.king@canonical.com>, Peter Huewe <peterhuewe@gmx.de>,
	Jason Gunthorpe
	 <jgg@ziepe.ca>, Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman
	 <gregkh@linuxfoundation.org>, linux-integrity@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Mon, 09 Apr 2018 14:11:08 +0300
In-Reply-To: <20180406162144.14717-1-colin.king@canonical.com>
References: <20180406162144.14717-1-colin.king@canonical.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.0-4 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597014495178816118?=
X-GMAIL-MSGID: =?utf-8?q?1597266749496419239?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, 2018-04-06 at 17:21 +0100, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> Currently chip is being dereferenced by the call to dev_get_drvdata
> before it is being null checked, however, chip can never be null, so
> this check is misleading and redundant. Remove it.
> 
> Detected by CoverityScan, CID#1357806 ("Dereference before null check")
> 
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> 
> ---
> 
> V2: don't check for null, just remove redundant null check,
>     thanks to Jason Gunthorpe for spotting that.
> 
> ---
>  drivers/char/tpm/st33zp24/st33zp24.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/drivers/char/tpm/st33zp24/st33zp24.c
> b/drivers/char/tpm/st33zp24/st33zp24.c
> index f95b9c75175b..abd675bec88c 100644
> --- a/drivers/char/tpm/st33zp24/st33zp24.c
> +++ b/drivers/char/tpm/st33zp24/st33zp24.c
> @@ -373,8 +373,6 @@ static int st33zp24_send(struct tpm_chip *chip, unsigned
> char *buf,
>  	int ret;
>  	u8 data;
>  
> -	if (!chip)
> -		return -EBUSY;
>  	if (len < TPM_HEADER_SIZE)
>  		return -EBUSY;
>  

Reviewed-by: Jarkko Sakkinen <jarkkko.sakkinen@linux.intel.com>

/Jarkko
