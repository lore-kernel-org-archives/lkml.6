Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3527955-1520957973-2-10555630828070413239
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520957972; b=hHfIfjh7veeeeZXjrNOl4gXhY3pD6yFqgobKHTn169K2CQY
    LfZc9dak5i6HnJlEyoshw6DiKF4vDPnPfrVXkTHz6zGWyyeOzYmYxH9ZIsyCkBSZ
    mhPWjnjY44iB05yX52Jp1mcDdZZwLW4oNOfn7hfeFe+qMBl4KurtJlA0kozCuDTH
    2ruzRY0InHA2F3sRvymCTRbgRStPnxqi1q0+MuGDNyHTD3YLW/D1w9eYhltma097
    lGfEPESC24tExw3o+Uod5hQQR7i/1KOXsxMptmKluVVvxYL7KMSS82opJzZppiql
    h8jxyNbOS24Os3KsWGR7THJgo4cq5lZ2oWqPzSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:message-id:references
    :mime-version:content-type:in-reply-to:subject:sender:list-id;
    s=arctest; t=1520957972; bh=tq0gIFAmxzvUC6TsiMycRLT+7F+ylKfggb6
    4Nkvy6Mk=; b=qATS4jfoEuo2/p6I45V6mMiUic90Ty0hpFN3JvcTvNH4axLjmH2
    /JUfOZzzUxM/r+ZzXdhVUgHfKvCow4mRG6t/MN7/pHrJPhK96ozgDd5NvVBupEvz
    chsfyasYlj7LGs0S5aUclXTjliwu0JC6Yr8UIywdj4br3JFzZnKZfQzOTz6mHIVv
    acBym7h7/54XIfNhLiAX+eGO9jHU/+mx/u+rdXkRUW0BH9xXGWofD2IBPwIXF+Mu
    cNUVfpEsuwSI7qcAyPLPIrNui7a/B/RMUJsg2KOUXKcx3l08UKRXlDoyZHfX8w3G
    vLuOKgQ4OsdsZDgkBclKEEcNAViFEe9gJjg==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=merlins.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=merlins.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=merlins.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=merlins.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933348AbeCMQTQ (ORCPT <rfc822;greg@kroah.com>);
        Tue, 13 Mar 2018 12:19:16 -0400
Received: from magic.merlins.org ([209.81.13.136]:51251 "EHLO
        mail1.merlins.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933432AbeCMQTO (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 13 Mar 2018 12:19:14 -0400
Date: Tue, 13 Mar 2018 09:19:07 -0700
From: Marc MERLIN <marc@merlins.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Tang Junhui <tang.junhui@zte.com.cn>,
        Michael Lyle <mlyle@lyle.org>, Jens Axboe <axboe@kernel.dk>
Message-ID: <20180313161907.tu4afzqrgmkvzzxv@merlins.org>
References: <20180313152458.201155692@linuxfoundation.org>
 <20180313152504.537862990@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180313152504.537862990@linuxfoundation.org>
X-Sysadmin: BOFH
X-URL: http://marc.merlins.org/
User-Agent: NeoMutt/20160916 (1.7.0)
X-SA-Exim-Connect-IP: 173.11.111.145
X-SA-Exim-Mail-From: marc@merlins.org
X-Remote-Spam-Checker-Version: SpamAssassin 3.4.1-mmrules_20121111 (2015-04-28) on
        magic.merlins.org
X-Remote-Spam-Level: 
X-Remote-Spam-Status: No, score=-2.7 required=7.0 tests=BAYES_00,GREYLIST_ISWHITE,
        SPF_SOFTFAIL,T_RP_MATCHES_RCVD autolearn=ham autolearn_force=no
        version=3.4.1-mmrules_20121111
X-Remote-Spam-Report: *  0.7 SPF_SOFTFAIL SPF: sender does not match SPF record (softfail)
        * -0.0 T_RP_MATCHES_RCVD Envelope sender domain matches handover relay
        *      domain
        * -1.9 BAYES_00 BODY: Bayes spam probability is 0 to 1%
        *      [score: 0.0000]
        * -1.5 GREYLIST_ISWHITE The incoming server has been whitelisted for this
        *      receipient and sender
Subject: Re: [PATCH 4.14 095/140] bcache: fix crashes in duplicate cache
 device register
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, Mar 13, 2018 at 04:24:58PM +0100, Greg Kroah-Hartman wrote:
> 4.14-stable review patch.  If anyone has any objections, please let me know.
 
Just in case someone is considering whether it's important to merge, the
bug did crash my kernel of course, but I'm virtually certain it was also
responsible for corrupting my existing bcache device enough that I had
to restore it from backup.

Thanks again to Tang for fixing it.


> ------------------
> 
> From: Tang Junhui <tang.junhui@zte.com.cn>
> 
> commit cc40daf91bdddbba72a4a8cd0860640e06668309 upstream.
> 
> Kernel crashed when register a duplicate cache device, the call trace is
> bellow:
> [  417.643790] CPU: 1 PID: 16886 Comm: bcache-register Tainted: G
>    W  OE    4.15.5-amd64-preempt-sysrq-20171018 #2
> [  417.643861] Hardware name: LENOVO 20ERCTO1WW/20ERCTO1WW, BIOS
> N1DET41W (1.15 ) 12/31/2015
> [  417.643870] RIP: 0010:bdevname+0x13/0x1e
> [  417.643876] RSP: 0018:ffffa3aa9138fd38 EFLAGS: 00010282
> [  417.643884] RAX: 0000000000000000 RBX: ffff8c8f2f2f8000 RCX: ffffd6701f8
> c7edf
> [  417.643890] RDX: ffffa3aa9138fd88 RSI: ffffa3aa9138fd88 RDI: 00000000000
> 00000
> [  417.643895] RBP: ffffa3aa9138fde0 R08: ffffa3aa9138fae8 R09: 00000000000
> 1850e
> [  417.643901] R10: ffff8c8eed34b271 R11: ffff8c8eed34b250 R12: 00000000000
> 00000
> [  417.643906] R13: ffffd6701f78f940 R14: ffff8c8f38f80000 R15: ffff8c8ea7d
> 90000
> [  417.643913] FS:  00007fde7e66f500(0000) GS:ffff8c8f61440000(0000) knlGS:
> 0000000000000000
> [  417.643919] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [  417.643925] CR2: 0000000000000314 CR3: 00000007e6fa0001 CR4: 00000000003
> 606e0
> [  417.643931] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 00000000000
> 00000
> [  417.643938] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 00000000000
> 00400
> [  417.643946] Call Trace:
> [  417.643978]  register_bcache+0x1117/0x1270 [bcache]
> [  417.643994]  ? slab_pre_alloc_hook+0x15/0x3c
> [  417.644001]  ? slab_post_alloc_hook.isra.44+0xa/0x1a
> [  417.644013]  ? kernfs_fop_write+0xf6/0x138
> [  417.644020]  kernfs_fop_write+0xf6/0x138
> [  417.644031]  __vfs_write+0x31/0xcc
> [  417.644043]  ? current_kernel_time64+0x10/0x36
> [  417.644115]  ? __audit_syscall_entry+0xbf/0xe3
> [  417.644124]  vfs_write+0xa5/0xe2
> [  417.644133]  SyS_write+0x5c/0x9f
> [  417.644144]  do_syscall_64+0x72/0x81
> [  417.644161]  entry_SYSCALL_64_after_hwframe+0x3d/0xa2
> [  417.644169] RIP: 0033:0x7fde7e1c1974
> [  417.644175] RSP: 002b:00007fff13009a38 EFLAGS: 00000246 ORIG_RAX: 0000000
> 000000001
> [  417.644183] RAX: ffffffffffffffda RBX: 0000000001658280 RCX: 00007fde7e1c
> 1974
> [  417.644188] RDX: 000000000000000a RSI: 0000000001658280 RDI: 000000000000
> 0001
> [  417.644193] RBP: 000000000000000a R08: 0000000000000003 R09: 000000000000
> 0077
> [  417.644198] R10: 000000000000089e R11: 0000000000000246 R12: 000000000000
> 0001
> [  417.644203] R13: 000000000000000a R14: 7fffffffffffffff R15: 000000000000
> 0000
> [  417.644213] Code: c7 c2 83 6f ee 98 be 20 00 00 00 48 89 df e8 6c 27 3b 0
> 0 48 89 d8 5b c3 0f 1f 44 00 00 48 8b 47 70 48 89 f2 48 8b bf 80 00 00 00 <8
> b> b0 14 03 00 00 e9 73 ff ff ff 0f 1f 44 00 00 48 8b 47 40 39
> [  417.644302] RIP: bdevname+0x13/0x1e RSP: ffffa3aa9138fd38
> [  417.644306] CR2: 0000000000000314
> 
> When registering duplicate cache device in register_cache(), after failure
> on calling register_cache_set(), bch_cache_release() will be called, then
> bdev will be freed, so bdevname(bdev, name) caused kernel crash.
> 
> Since bch_cache_release() will free bdev, so in this patch we make sure
> bdev being freed if register_cache() fail, and do not free bdev again in
> register_bcache() when register_cache() fail.
> 
> Signed-off-by: Tang Junhui <tang.junhui@zte.com.cn>
> Reported-by: Marc MERLIN <marc@merlins.org>
> Tested-by: Michael Lyle <mlyle@lyle.org>
> Reviewed-by: Michael Lyle <mlyle@lyle.org>
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Jens Axboe <axboe@kernel.dk>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> 
> ---
>  drivers/md/bcache/super.c |   16 ++++++++++------
>  1 file changed, 10 insertions(+), 6 deletions(-)
> 
> --- a/drivers/md/bcache/super.c
> +++ b/drivers/md/bcache/super.c
> @@ -1181,7 +1181,7 @@ static void register_bdev(struct cache_s
>  
>  	return;
>  err:
> -	pr_notice("error opening %s: %s", bdevname(bdev, name), err);
> +	pr_notice("error %s: %s", bdevname(bdev, name), err);
>  	bcache_device_stop(&dc->disk);
>  }
>  
> @@ -1849,6 +1849,8 @@ static int register_cache(struct cache_s
>  	const char *err = NULL; /* must be set for any error case */
>  	int ret = 0;
>  
> +	bdevname(bdev, name);
> +
>  	memcpy(&ca->sb, sb, sizeof(struct cache_sb));
>  	ca->bdev = bdev;
>  	ca->bdev->bd_holder = ca;
> @@ -1857,11 +1859,12 @@ static int register_cache(struct cache_s
>  	ca->sb_bio.bi_io_vec[0].bv_page = sb_page;
>  	get_page(sb_page);
>  
> -	if (blk_queue_discard(bdev_get_queue(ca->bdev)))
> +	if (blk_queue_discard(bdev_get_queue(bdev)))
>  		ca->discard = CACHE_DISCARD(&ca->sb);
>  
>  	ret = cache_alloc(ca);
>  	if (ret != 0) {
> +		blkdev_put(bdev, FMODE_READ|FMODE_WRITE|FMODE_EXCL);
>  		if (ret == -ENOMEM)
>  			err = "cache_alloc(): -ENOMEM";
>  		else
> @@ -1884,14 +1887,14 @@ static int register_cache(struct cache_s
>  		goto out;
>  	}
>  
> -	pr_info("registered cache device %s", bdevname(bdev, name));
> +	pr_info("registered cache device %s", name);
>  
>  out:
>  	kobject_put(&ca->kobj);
>  
>  err:
>  	if (err)
> -		pr_notice("error opening %s: %s", bdevname(bdev, name), err);
> +		pr_notice("error %s: %s", name, err);
>  
>  	return ret;
>  }
> @@ -1980,6 +1983,7 @@ static ssize_t register_bcache(struct ko
>  	if (err)
>  		goto err_close;
>  
> +	err = "failed to register device";
>  	if (SB_IS_BDEV(sb)) {
>  		struct cached_dev *dc = kzalloc(sizeof(*dc), GFP_KERNEL);
>  		if (!dc)
> @@ -1994,7 +1998,7 @@ static ssize_t register_bcache(struct ko
>  			goto err_close;
>  
>  		if (register_cache(sb, sb_page, bdev, ca) != 0)
> -			goto err_close;
> +			goto err;
>  	}
>  out:
>  	if (sb_page)
> @@ -2007,7 +2011,7 @@ out:
>  err_close:
>  	blkdev_put(bdev, FMODE_READ|FMODE_WRITE|FMODE_EXCL);
>  err:
> -	pr_info("error opening %s: %s", path, err);
> +	pr_info("error %s: %s", path, err);
>  	ret = -EINVAL;
>  	goto out;
>  }
> 
> 
> 

-- 
"A mouse is a device used to point at the xterm you want to type in" - A.S.R.
Microsoft is to operating systems ....
                                      .... what McDonalds is to gourmet cooking
Home page: http://marc.merlins.org/                       | PGP 7F55D5F27AAF9D08
