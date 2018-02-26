Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-3102847-1519656539-3-14878062296327885913
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES endaro, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.133', Host='smtp2.osuosl.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519656538; b=WiGuLMgCcA9MiyWomsK7qSgQIXbEgpWWD+dZFdId65rMZy6
    zYY8uQ5oOXFS02/j/UyT4WZtTNBkubKOMFMnruGbCcsiyY4rhDuZor5DnZK4o3gC
    qiM2wgiYMtRljQyZ2dWWZ2je3B9fzY3LI3IdDSxnUAMP188PuDs3FEBRpGFMu07K
    8Hpm5uTsPWz2eBBk7lP1VbgsJEvuNo/PZ6NCPpkF0ChBRbvpo2YdBoWhZcpOAz9W
    RkzjqP0g6pwvOh3dpmHChN98vby1UnvBR5FyDtzfEjDz6D2kg5Xkozqs7ITcy5Kc
    3IyowQeHgYsEy7aXhnFgYLC1geDmV8cKJLh93hg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:subject:in-reply-to
    :message-id:references:mime-version:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=arctest; t=1519656538; bh=N
    dituZL8jsleYm6mh50Rq6qi++1YuyLGmLPL90kVmAs=; b=f7lOpF/Dj+2/GwZH4
    MhHYx1VYNvXzMSdpLmnNe0TuYK6PimjW1DisQObHe2Tx0Br8CpU8UeS3upKioSVb
    nu9ZddQln5d0SZVGKQPeXSgLkouZ+NLHSoVNMGwxjKUpjFW5HIko/UIwRYk3bMi+
    P0RpJDVa7b68FB/cmIkcJlz0iJbuy5lT1khYsjmlwJ8rVfc0rtuPOabgVlb3L3J8
    ANsAI3k7oYyTIlm9nYZo+VYvHAwZS3dHkNv1JeQLmt9Z4gtKaOkzRW4c+ZGZy5cj
    SjFQXy1Vxn0mjUc9l8nZiBjchAkg7draVj4kYV1hFPb/ARSw2qrEVoCCsmwsBKyR
    MrCqg==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=infradead.org header.i=@infradead.org header.b=E/C5Dryv x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=casper.20170209;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=infradead.org;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-ptr=fail x-ptr-helo=hemlock.osuosl.org x-ptr-lookup=smtp2.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=infradead.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=infradead.org header.i=@infradead.org header.b=E/C5Dryv x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=casper.20170209;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=infradead.org;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-ptr=fail x-ptr-helo=hemlock.osuosl.org x-ptr-lookup=smtp2.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=infradead.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
X-Remote-Delivered-To: driverdev-devel@osuosl.org
X-Amavis-Alert: BAD HEADER SECTION, Improper folded header field made up
 entirely of whitespace (char 20 hex): X-Spam-Report: ....9 points, 5.0
 required)\n \n  pts rule nam[...]
Date: Mon, 26 Feb 2018 14:48:48 +0000 (GMT)
From: James Simmons <jsimmons@infradead.org>
To: NeilBrown <neilb@suse.com>
Subject: Re: [PATCH 3/3] staging: lustre: lnet/selftest: don't ignore status
 from lstcon_test_add
In-Reply-To: <151933737388.16436.11922095105762928334.stgit@noble>
Message-ID: <alpine.LFD.2.21.1802261448360.13228@casper.infradead.org>
References: <151933726925.16436.9827896439357574011.stgit@noble>
 <151933737388.16436.11922095105762928334.stgit@noble>
User-Agent: Alpine 2.21 (LFD 202 2017-01-01)
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20180226_144848_699938_1BF74746 
X-CRM114-Status: GOOD (  14.03  )
X-BeenThere: driverdev-devel@linuxdriverproject.org
X-Mailman-Version: 2.1.24
 <driverdev-devel.linuxdriverproject.org>
List-Unsubscribe: <http://driverdev.linuxdriverproject.org/mailman/options/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=unsubscribe>
List-Archive: <http://driverdev.linuxdriverproject.org/pipermail/driverdev-devel/>
List-Post: <mailto:driverdev-devel@linuxdriverproject.org>
List-Help: <mailto:driverdev-devel-request@linuxdriverproject.org?subject=help>
List-Subscribe: <http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=subscribe>
Cc: devel@driverdev.osuosl.org, Andreas Dilger <andreas.dilger@intel.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Oleg Drokin <oleg.drokin@intel.com>,
 Lustre Development List <lustre-devel@lists.lustre.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>


> If lstcon_test_add sets 'ret' (passed by reference) to 1,
> then lst_test_add_ioctl() ignores the return value.
> This isn't justified - the return value must be zero for 'ret'
> to be meaningful.
> 
> Signed-off-by: NeilBrown <neilb@suse.com>

Reviewed-by: James Simmons <jsimmons@infradead.org>

> ---
>  drivers/staging/lustre/lnet/selftest/conctl.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/lustre/lnet/selftest/conctl.c b/drivers/staging/lustre/lnet/selftest/conctl.c
> index 51497cf9a832..a2d8092bdeb7 100644
> --- a/drivers/staging/lustre/lnet/selftest/conctl.c
> +++ b/drivers/staging/lustre/lnet/selftest/conctl.c
> @@ -670,7 +670,7 @@ static int lst_test_add_ioctl(struct lstio_test_args *args)
>  			     args->lstio_tes_param_len,
>  			     &ret, args->lstio_tes_resultp);
>  
> -	if (ret)
> +	if (!rc && ret)
>  		rc = (copy_to_user(args->lstio_tes_retp, &ret,
>  				   sizeof(ret))) ? -EFAULT : 0;
>  out:
> 
> 
> 
_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
