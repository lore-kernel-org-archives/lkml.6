Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-3659933-1518385158-2-4489188572458206327
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
    t=1518385158; b=oZcS5/vpGG3ZC4HE3i9LGeoKf0N2f/QFVNq64JTIiTUbkvW
    Nysktu4AJbd4Z/aJ0cdRdH3Pu1B12qDR6SMD2sGrQIqQP8QwOFIBTzzJr5gUtXBa
    6j2S6iMiPt+FYnQx6mWzkd4J0es1SgspcmkA7e9dlAYEgxltJsz7t6BkqT3mBhfC
    Saa1x+UooIn0zcSPtOJ1lzMDTcsI5IKK5IKPrKExitTKVA2bA1oeAF01MWngb3tT
    vqFh9FYPQIInROK6I67fYX/Z7OwBVO1I/XeTgTVbBPN7pg+ueALg7sJfQBKJM/F2
    2dikR9x5Y7k8lERgdYgMMeaLu2EVVkpd8n+7GMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:subject:in-reply-to
    :message-id:references:mime-version:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=arctest; t=1518385158; bh=6
    dOt9mKxJ7dXVoxQaGcLJ9mWXc1cwJo04515f3px+IM=; b=nVrRCTRnyKKmx7Zgg
    QfPdM9tN/AmLJCQgHZouZnpGtI5kKplZfTxrQ9BOeULFpiuadFpqmIv8d0iyHbkK
    2DGAio3IFwXd/l+qP3p83ogkm7C9QsYl83+X5pypTgfHinzcFvAMETPtZvK1HtSX
    qbbR0Ue9GXHgL8EnGM37eujp2Uj1nKjGmW/bnBSwNq3vO+x3kOqE/+FJX59aq+hL
    TUHxvMgEfpgxRS3EhT+Uk6oBXY1a8x5/ssxBNPLK+7adM8BsOCZD4FrokyqKYCJQ
    T2xFBA0SqOZ39JcQn/vCWyMJCUsRhq5s9KdI1tiF+m2j79yBncT4Ipdtqyv+M+0P
    BxbTw==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=infradead.org header.i=@infradead.org header.b=pfdNT72k x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=casper.20170209;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=infradead.org;
    iprev=pass policy.iprev=140.211.166.137 (smtp4.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=fraxinus.osuosl.org;
    x-aligned-from=fail;
    x-ptr=fail x-ptr-helo=fraxinus.osuosl.org x-ptr-lookup=smtp4.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=infradead.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=infradead.org header.i=@infradead.org header.b=pfdNT72k x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=casper.20170209;
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
Date: Sun, 11 Feb 2018 21:39:05 +0000 (GMT)
From: James Simmons <jsimmons@infradead.org>
To: Sumit Pundir <pundirsumit11@gmail.com>
Subject: Re: [PATCH] staging: lustre: lnet: return of an error code should
 be negative
In-Reply-To: <1517117095-12643-1-git-send-email-pundirsumit11@gmail.com>
Message-ID: <alpine.LFD.2.21.1802112138340.21780@casper.infradead.org>
References: <1517117095-12643-1-git-send-email-pundirsumit11@gmail.com>
User-Agent: Alpine 2.21 (LFD 202 2017-01-01)
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20180211_213905_893701_42D44E87 
X-CRM114-Status: UNSURE (   9.19  )
X-CRM114-Notice: Please train this message.
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
Cc: devel@driverdev.osuosl.org, andreas.dilger@intel.com,
 gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
 oleg.drokin@intel.com, lustre-devel@lists.lustre.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>


> Return value of error codes should typically be negative.
> Issue reported by checkpatch.pl
>

Reviewed-by: James Simmons <jsimmons@infradead.org>
 
> Signed-off-by: Sumit Pundir <pundirsumit11@gmail.com>
> ---
>  drivers/staging/lustre/lnet/selftest/framework.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/lustre/lnet/selftest/framework.c b/drivers/staging/lustre/lnet/selftest/framework.c
> index c7697f6..0ca1e3a 100644
> --- a/drivers/staging/lustre/lnet/selftest/framework.c
> +++ b/drivers/staging/lustre/lnet/selftest/framework.c
> @@ -187,7 +187,7 @@ sfw_del_session_timer(void)
>  		return 0;
>  	}
>  
> -	return EBUSY; /* racing with sfw_session_expired() */
> +	return -EBUSY; /* racing with sfw_session_expired() */
>  }
>  
>  static void
> -- 
> 2.7.4
> 
> 
_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
