Return-Path: <kernel-hardening-return-13061-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AIpwx48rU31dB81gDdh+F8ZyLx00jt7biX/OzvWAKCjWwISYl8IqLkWoclQgXTS4rF0khUgF4y+s
ARC-Seal: i=1; a=rsa-sha256; t=1524145680; cv=none;
        d=google.com; s=arc-20160816;
        b=saNfr3JmaEi/OGZWWEUEtivgSnBGXQ29ueiqc3JgmvBlFB7a9n2HZyrVIgj6YbUX7C
         9Dld+6CrNfPOIEmBtt5AMQ5R2MPNQsIMwJPmMlhhlihm89l5G+89Mh652tBzFOixx8US
         m7OLYWbdrYE8VQUHW3yMIvZ5IxAPYGzBHot+agZC9HiywdV183YAgiU+e60HP8qESCma
         uzRheYfcNAknWtxmOmJBgypaydQd/F9XzNDew6Izyie2rpr9a3cCvR2566DIoP7PUnln
         7tCDCMr6wvSsTjkYKA9xuaEEGW5VOpezqjyHza/CFkSiU4FLBaELqpqgFVdtbtRucwUU
         yRcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:delivered-to:delivered-to
         :list-id:list-subscribe:list-unsubscribe:list-help:list-post
         :precedence:mailing-list:arc-authentication-results;
        bh=vNf9gFQStpRpAy1uZh6TIl/XluHs8K/mQtZlagBsyHE=;
        b=iKweYq+H+uZP/7OE3lXERdoYcEjk7tqo3oekte14xsqcJlCO0cG7xR04nSimiJ8MqY
         Cc0feGEBrreo10WfIqY4dPhtyppSmkI1cpuNP6ZOYZL0XS+SvB+0CYpG1JaavHnYRceU
         CfOCl85OifjG+jgdgmhv8s267Vq5UGH8NFzCgSif1A+xMx+uyX3q0zlgpZKszoUphNXc
         OthfRHYYAb2AdA5pBoej4d0eu/WcqwbMYb0VnncwDW8UM7zw8ujyS4cvu+/Vl/Kh9mpF
         7b1vVqUvYlJ9ZRQzcgyWjUQ1o27YB86mZd1w9rVP459uLktuxr9ckRlm0OGxpe1nnn+a
         4dtg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-13061-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-13061-gregkh=linuxfoundation.org@lists.openwall.com;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=redhat.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-13061-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-13061-gregkh=linuxfoundation.org@lists.openwall.com;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=redhat.com
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
Date: Thu, 19 Apr 2018 09:46:47 -0400
From: Mike Snitzer <snitzer@redhat.com>
To: Thomas Gleixner <tglx@linutronix.de>, NeilBrown <neilb@suse.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Kees Cook <keescook@chromium.org>,
	Segher Boessenkool <segher@kernel.crashing.org>,
	Kernel Hardening <kernel-hardening@lists.openwall.com>,
	Andrew Morton <akpm@linuxfoundation.org>,
	Boris Brezillon <boris.brezillon@free-electrons.com>,
	Richard Weinberger <richard@nod.at>,
	David Woodhouse <dwmw2@infradead.org>,
	Alasdair Kergon <agk@redhat.com>,
	Anton Vorontsov <anton@enomsg.org>,
	Colin Cross <ccross@android.com>, Tony Luck <tony.luck@intel.com>
Subject: Re: [patch V2 7/8] dm verity fec: Check result of init_rs()
Message-ID: <20180419134647.GA9817@redhat.com>
References: <20180419100441.548834519@linutronix.de>
 <20180419100935.340306831@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180419100935.340306831@linutronix.de>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598168985985100525?=
X-GMAIL-MSGID: =?utf-8?q?1598182581392967251?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, Apr 19 2018 at  6:04am -0400,
Thomas Gleixner <tglx@linutronix.de> wrote:

> From: Thomas Gleixner <tglx@linutronix.de>
> 
> The allocation of the reed solomon control structure can fail, but
> fec_alloc_bufs() ignores that and subsequent operations in dm verity use
> the potential NULL pointer unconditionally.
> 
> Add a proper check and abort if init_rs() fails.

This changelog makes little sense: init_rs() isn't in play relative to
this patch.

And it runs counter to this commit's changelog:

commit 34c96507e8f6be497c15497be05f489fb34c5880
Author: NeilBrown <neilb@suse.com>
Date:   Mon Apr 10 12:13:00 2017 +1000

    dm verity fec: fix GFP flags used with mempool_alloc()

    mempool_alloc() cannot fail for GFP_NOIO allocation, so there is no
    point testing for failure.

    One place the code tested for failure was passing "0" as the GFP
    flags.  This is most unusual and is probably meant to be GFP_NOIO,
    so that is changed.

    Also, allocation from ->extra_pool and ->prealloc_pool are repeated
    before releasing the previous allocation.  This can deadlock if the code
    is servicing a write under high memory pressure.  To avoid deadlocks,
    change these to use GFP_NOWAIT and leave the error handling in place.

    Signed-off-by: NeilBrown <neilb@suse.com>
    Signed-off-by: Mike Snitzer <snitzer@redhat.com>

Seems there is no real need for this patch.  Neil, what do you think?

Thanks,
Mike


> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> Cc: Boris Brezillon <boris.brezillon@free-electrons.com>
> Cc: Tony Luck <tony.luck@intel.com>
> Cc: Kees Cook <keescook@chromium.org>
> Cc: Segher Boessenkool <segher@kernel.crashing.org>
> Cc: Kernel Hardening <kernel-hardening@lists.openwall.com>
> Cc: Richard Weinberger <richard@nod.at>
> Cc: Mike Snitzer <snitzer@redhat.com>
> Cc: Anton Vorontsov <anton@enomsg.org>
> Cc: Colin Cross <ccross@android.com>
> Cc: Andrew Morton <akpm@linuxfoundation.org>
> Cc: David Woodhouse <dwmw2@infradead.org>
> Cc: Alasdair Kergon <agk@redhat.com>
> 
> ---
>  drivers/md/dm-verity-fec.c |    7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> --- a/drivers/md/dm-verity-fec.c
> +++ b/drivers/md/dm-verity-fec.c
> @@ -308,8 +308,13 @@ static int fec_alloc_bufs(struct dm_veri
>  {
>  	unsigned n;
>  
> -	if (!fio->rs)
> +	if (!fio->rs) {
>  		fio->rs = mempool_alloc(v->fec->rs_pool, GFP_NOIO);
> +		if (!fio->rs) {
> +			DMERR("failed to allocate RS control structure");
> +			return -ENOMEM;
> +		}
> +	}
>  
>  	fec_for_each_prealloc_buffer(n) {
>  		if (fio->bufs[n])
> 
> 
> 
> 
> 
