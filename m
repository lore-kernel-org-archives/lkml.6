Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-3069381-1519656515-5-2773769235816564420
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.137', Host='smtp4.osuosl.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519656514; b=S4ZENEA+BqHQNS/oDLDprJOh0qmBvwty/GgZr389/pRT2DK
    5fFhGQpH/PocH+2ZN651F+UpP5sQvKghpUeRsg6Nn5o7hzHkax88wjSFxKT7l5i8
    k965GBfghcgV6YcP9+SIgCepxZvKqZ0LbPkikysAFpjdeH/9bhsWRXXaaTqWani7
    GGqjMIFkQXuGbFIh1s0hPDmX4DrUB0tN1yNWVbiWOPVHWiQvQSvyN5VpELwn3OmJ
    /cdMiR4KzO6RL668Rno+bndj9drI8aKjCQ/d5mRiCA44yXubE8P//7qX39Se6lVg
    /5g9JZl9toP4rmPOTPbB5O9/IuMVESyMGXNLZcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:subject:in-reply-to
    :message-id:references:mime-version:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=arctest; t=1519656514; bh=Z
    Knm5XxtTbQ4FfHPhlNptJjNgeQ+Jgh3TyeQ3X+UpYY=; b=qy1AzrLykxdXRMQLa
    Twn70o65rXOO7M5XMdGfvgkf+oYfDCt8NG19jrJNESH3DoESXyOx5O9qp3c2QlIN
    dnXjr/ILdXzehB66ucCkIo12vPkF9a87+RH4zVfr8KDPLrJjAK1YetSDj5fzcP1j
    OIKiuATzFXKeLL476ibI8OLcMUoQWpKFyaVyaR1YCGky3eFOzUxu4kJEKcByK6iY
    C8LTGCxTGtsjhnE1ea7xc9INux5oGLRRLn90KbqHukfppNzLVa3pjy02UAETfnIh
    3uaBW51NqcT3qNZZtkh9EhoiuBL8M47Bh3h0jrXQoZLKwYq8ks8rMLPVgctek7NR
    vFwWw==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=infradead.org header.i=@infradead.org header.b=iFM5coBh x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=casper.20170209;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=infradead.org;
    iprev=pass policy.iprev=140.211.166.137 (smtp4.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=fraxinus.osuosl.org;
    x-aligned-from=fail;
    x-ptr=fail x-ptr-helo=fraxinus.osuosl.org x-ptr-lookup=smtp4.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=infradead.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=infradead.org header.i=@infradead.org header.b=iFM5coBh x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=casper.20170209;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=infradead.org;
    iprev=pass policy.iprev=140.211.166.137 (smtp4.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=fraxinus.osuosl.org;
    x-aligned-from=fail;
    x-ptr=fail x-ptr-helo=fraxinus.osuosl.org x-ptr-lookup=smtp4.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=infradead.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
X-Remote-Delivered-To: driverdev-devel@osuosl.org
X-Amavis-Alert: BAD HEADER SECTION, Improper folded header field made up
 entirely of whitespace (char 20 hex): X-Spam-Report: ....9 points, 5.0
 required)\n \n  pts rule nam[...]
Date: Mon, 26 Feb 2018 14:48:25 +0000 (GMT)
From: James Simmons <jsimmons@infradead.org>
To: NeilBrown <neilb@suse.com>
Subject: Re: [PATCH 2/3] staging: lustre: lmv: correctly iput lmo_root
In-Reply-To: <151933737384.16436.1999360148075400466.stgit@noble>
Message-ID: <alpine.LFD.2.21.1802261448120.13228@casper.infradead.org>
References: <151933726925.16436.9827896439357574011.stgit@noble>
 <151933737384.16436.1999360148075400466.stgit@noble>
User-Agent: Alpine 2.21 (LFD 202 2017-01-01)
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20180226_144825_487261_7FC05C34 
X-CRM114-Status: GOOD (  20.99  )
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


> Commit 8f18c8a48b73 ("staging: lustre: lmv: separate master object
> with master stripe") changed how lmo_root inodes were managed,
> particularly when LMV_HASH_FLAG_MIGRATION is not set.
> Previously lsm_md_oinfo[0].lmo_root was always a borrowed
> inode reference and didn't need to by iput().
> Since the change, that special case only applies when
> LMV_HASH_FLAG_MIGRATION is set
> 
> In the upstream (lustre-release) version of this patch [Commit
> 60e07b972114 ("LU-4690 lod: separate master object with master
> stripe")] the for loop in the lmv_unpack_md() was changed to count
> from 0 and to ignore entry 0 if LMV_HASH_FLAG_MIGRATION is set.
> In the patch that got applied to Linux, that change was missing,
> so lsm_md_oinfo[0].lmo_root is never iput().
> This results in a "VFS: Busy inodes" warning at unmount.
> 
> Fixes: 8f18c8a48b73 ("staging: lustre: lmv: separate master object with master stripe")
> Signed-off-by: NeilBrown <neilb@suse.com>

Reviewed-by: James Simmons <jsimmons@infradead.org>


> ---
>  drivers/staging/lustre/lustre/lmv/lmv_obd.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/lustre/lustre/lmv/lmv_obd.c b/drivers/staging/lustre/lustre/lmv/lmv_obd.c
> index 179651531862..e8a9b9902c37 100644
> --- a/drivers/staging/lustre/lustre/lmv/lmv_obd.c
> +++ b/drivers/staging/lustre/lustre/lmv/lmv_obd.c
> @@ -2695,7 +2695,7 @@ static int lmv_unpackmd(struct obd_export *exp, struct lmv_stripe_md **lsmp,
>  	if (lsm && !lmm) {
>  		int i;
>  
> -		for (i = 1; i < lsm->lsm_md_stripe_count; i++) {
> +		for (i = 0; i < lsm->lsm_md_stripe_count; i++) {
>  			/*
>  			 * For migrating inode, the master stripe and master
>  			 * object will be the same, so do not need iput, see
> 
> 
> 
_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
