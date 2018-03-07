Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-2879378-1520417302-2-18401781964419937701
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES roensv, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.137', Host='smtp4.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520417301; b=wz/pAaks+c4QdvI6b/espNylPtWnB0oDJB6lI+nw2s+qwyj
    KGOmFp6bPvtzQP+4H0ucvcBFK6LCwxH8rEn1sLc3/Adu2DzsNmjXc3nu34aMGELO
    008rdFtSftDGaTW9lg20DJl9dnsoGtnA1rAE1+Pj143KNOcYFGKWQtcwAd6Zpwld
    E5gprAhvJQf7yzkb8CPdPdYTBIaNbtpOlJSKIsPnlvs0VmKd3sfF8vaL0gTUJtUc
    Verh226fg9Ssq7fAsn9PJQqaM5OO3WndvKeAhe7CzAiI9QPge3hxobzzQjjW1o6Q
    IikS3qBGEvci/Hen0GMOsUV2sv4VErVc4grY60Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:subject:message-id
    :references:mime-version:in-reply-to:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=arctest; t=1520417301; bh=O
    G+ZKeC3OMqyoMbCh90XT9UtMS6gVKFy9EBePi9xhUY=; b=TnYGX8UCiQkRpwD2J
    OGp9JF2rm+96k32Cx0q0zj+UJUTrCBmd5to3AyY9vGWjrK2VgrpLwzITRXbAr4pk
    5vYGflpJJsA+smW7za0hb+8wD4pQPXlCxZ6j5ai3nRxKh2yUxZ0ImwNos9JfPEZz
    6D1bqkhnC97FE/fCRa6dIDjgnV57fcVZwIFh8tu5LFsW1/xDMplCc8hnqY9gfrtg
    ZYLXCsKayUQZ6PCvezF8GxmaOPTtJxC3GjkS4NjFmCHJsEuv7d5/MWNHHDvsmHjh
    b0yJPDMqqHdD/t/FuYC3NczImBEycg8qcOVtdCgd8Q7cG0Tp4Af7gcIAKrQHxRpt
    zJY1A==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=messagingengine.com header.i=@messagingengine.com header.b=MDuZDOZI x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=fm2;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=apporbit.com;
    iprev=pass policy.iprev=140.211.166.137 (smtp4.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=fraxinus.osuosl.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=fail x-ptr-helo=fraxinus.osuosl.org x-ptr-lookup=smtp4.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=apporbit.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=messagingengine.com header.i=@messagingengine.com header.b=MDuZDOZI x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=fm2;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=apporbit.com;
    iprev=pass policy.iprev=140.211.166.137 (smtp4.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=fraxinus.osuosl.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=fail x-ptr-helo=fraxinus.osuosl.org x-ptr-lookup=smtp4.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=apporbit.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
X-Remote-Delivered-To: driverdev-devel@osuosl.org
X-ME-Sender: <xms:oLifWkbR3WBhS7v8l83FjEJkMbf93yr3IlBRToDHo0wKXENmncF7fA>
Date: Wed, 7 Mar 2018 21:02:05 +1100
From: "Tobin C. Harding" <tobin@apporbit.com>
To: Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH] staging: lustre: Remove VLA usage
Message-ID: <20180307100205.GF11750@eros>
References: <20180307054608.GA9300@beast>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20180307054608.GA9300@beast>
X-Mailer: Mutt 1.5.24 (2015-08-30)
User-Agent: Mutt/1.5.24 (2015-08-30)
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
Cc: devel@driverdev.osuosl.org, Dmitry Eremin <dmitry.eremin@intel.com>,
 Tycho Andersen <tycho@tycho.ws>, Andreas Dilger <andreas.dilger@intel.com>,
 Kernel Hardening <kernel-hardening@lists.openwall.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org,
 Gargi Sharma <gs051095@gmail.com>, Oleg Drokin <oleg.drokin@intel.com>,
 lustre-devel@lists.lustre.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, Mar 06, 2018 at 09:46:08PM -0800, Kees Cook wrote:
> The kernel would like to remove all VLA usage. This switches to a
> simple kasprintf() instead.
> 
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---
>  drivers/staging/lustre/lustre/llite/xattr.c | 19 +++++++++++++------
>  1 file changed, 13 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/staging/lustre/lustre/llite/xattr.c b/drivers/staging/lustre/lustre/llite/xattr.c
> index 532384c91447..aab4eab64289 100644
> --- a/drivers/staging/lustre/lustre/llite/xattr.c
> +++ b/drivers/staging/lustre/lustre/llite/xattr.c
> @@ -87,7 +87,7 @@ ll_xattr_set_common(const struct xattr_handler *handler,
>  		    const char *name, const void *value, size_t size,
>  		    int flags)
>  {
> -	char fullname[strlen(handler->prefix) + strlen(name) + 1];
> +	char *fullname;
>  	struct ll_sb_info *sbi = ll_i2sbi(inode);
>  	struct ptlrpc_request *req = NULL;
>  	const char *pv = value;
> @@ -141,10 +141,13 @@ ll_xattr_set_common(const struct xattr_handler *handler,
>  			return -EPERM;
>  	}
>  
> -	sprintf(fullname, "%s%s\n", handler->prefix, name);
> +	fullname = kasprintf(GFP_KERNEL, "%s%s\n", handler->prefix, name);
> +	if (!fullname)
> +		return -ENOMEM;
>  	rc = md_setxattr(sbi->ll_md_exp, ll_inode2fid(inode),
>  			 valid, fullname, pv, size, 0, flags,
>  			 ll_i2suppgid(inode), &req);
> +	kfree(fullname);

This is cool.  We've had kasprintf() since 2007, who knew?!

thanks,
Tobin.
_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
