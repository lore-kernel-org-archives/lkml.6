Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-560798-1519060330-2-8666924239906701395
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES unknown, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.133', Host='smtp2.osuosl.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519060329; b=ClCMHqGrfjRdJ9Xzg6R6No5v8QtuaUR264gXMH33SeopVN6
    5flzenil5GBu/6n45pGThSjxaiD1z2GK4lFB2kMBWa10zNHrLEoyJMb5LZh7tsiJ
    ZRrwtKmQnKW09ijYSgfYjS7HFCMPr/yJFcBDq9/DCJptfJEb1JTeN1D/oAMNBfC+
    pKxGxam3xpQWJw5QDsBVfn+2+ia4CBlZQdoCKKYMSTV2ODLjKQMaofoVlwUWCxjo
    q69H1vBv3iRxULP6SY1abdsJ+2Ni3D7BHFgXC1z40MMO77rHD5IhDUX7zkVua9CU
    QYiIaOiB45OiQj8NOLAAMXjNf0f1utp5Sk9NdNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:subject:message-id
    :references:mime-version:in-reply-to:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=arctest; t=1519060329; bh=C
    ByDgpLzF6VdVVoqfSx6B8LA9TPPHyV2MGCzj9ic/v8=; b=beMriMuBw+fmqa7Ow
    Q7r9kmaXvvB2BMXDMJ/Y57Zq2RNV2BHU4GJJw2iC2LmexxQobdyzraKznCKfhQt1
    4PP9UKIt78Qg8pjZZsDdMKC0pNjYKBzJmHPpRNEIsjB8kpLWB0atyBtoSpFuXpBD
    /kqfnXf82ryTPSMCRsT0bbJkVqdfiGSHivFKq9ti3PhA8nNJ1XLuq3jlrStEQ6du
    2cHklGRs97HIhsdfV9Hls+n4YWKwC4gOZ1ZP98SRMbKfyfCCgj4Cw97WY5CcgEiH
    jQZuzTAn4w9sIV5wE0tpSepaxDe3HyqOU06vdnaSSkdtMXOeuOi1Newq0F4AcZrs
    E6gww==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-ptr=fail x-ptr-helo=hemlock.osuosl.org x-ptr-lookup=smtp2.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-ptr=fail x-ptr-helo=hemlock.osuosl.org x-ptr-lookup=smtp2.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
X-Remote-Delivered-To: driverdev-devel@osuosl.org
Date: Mon, 19 Feb 2018 18:12:05 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Quytelda Kahja <quytelda@tamalin.org>
Subject: Re: [PATCH 3/4] Staging: ks7010: hostif: Fix multiple use of
 arguments in rate and event masking macros.
Message-ID: <20180219171205.GB3632@kroah.com>
References: <20180217022503.24982-1-quytelda@tamalin.org>
 <20180217022503.24982-2-quytelda@tamalin.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20180217022503.24982-2-quytelda@tamalin.org>
User-Agent: Mutt/1.9.3 (2018-01-21)
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
Cc: devel@driverdev.osuosl.org, driverdev-devel@linuxdriverproject.org,
 linux-kernel@vger.kernel.org, wsa@the-dreams.de
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, Feb 16, 2018 at 06:25:02PM -0800, Quytelda Kahja wrote:
> Use GCC extensions to prevent macro arguments from accidentally being evaluated
> multiple times when the macro is called.
> 
> Signed-off-by: Quytelda Kahja <quytelda@tamalin.org>
> ---
>  drivers/staging/ks7010/ks_hostif.h | 74 +++++++++++++++++++++++++-------------
>  1 file changed, 50 insertions(+), 24 deletions(-)
> 
> diff --git a/drivers/staging/ks7010/ks_hostif.h b/drivers/staging/ks7010/ks_hostif.h
> index 5bae8d468e23..750ac86cee77 100644
> --- a/drivers/staging/ks7010/ks_hostif.h
> +++ b/drivers/staging/ks7010/ks_hostif.h
> @@ -599,19 +599,39 @@ struct hostif_mic_failure_confirm_t {
>  #define TX_RATE_48M	(uint8_t)(480 / 5)
>  #define TX_RATE_54M	(uint8_t)(540 / 5)
>  
> -#define IS_11B_RATE(A) (((A & RATE_MASK) == TX_RATE_1M) || ((A & RATE_MASK) == TX_RATE_2M) || \
> -			((A & RATE_MASK) == TX_RATE_5M) || ((A & RATE_MASK) == TX_RATE_11M))
> -
> -#define IS_OFDM_RATE(A) (((A & RATE_MASK) == TX_RATE_6M) || ((A & RATE_MASK) == TX_RATE_12M) || \
> -			 ((A & RATE_MASK) == TX_RATE_24M) || ((A & RATE_MASK) == TX_RATE_9M) || \
> -			 ((A & RATE_MASK) == TX_RATE_18M) || ((A & RATE_MASK) == TX_RATE_36M) || \
> -			 ((A & RATE_MASK) == TX_RATE_48M) || ((A & RATE_MASK) == TX_RATE_54M))
> -
> -#define IS_11BG_RATE(A) (IS_11B_RATE(A) || IS_OFDM_RATE(A))
> -
> -#define IS_OFDM_EXT_RATE(A) (((A & RATE_MASK) == TX_RATE_9M) || ((A & RATE_MASK) == TX_RATE_18M) || \
> -			     ((A & RATE_MASK) == TX_RATE_36M) || ((A & RATE_MASK) == TX_RATE_48M) || \
> -			     ((A & RATE_MASK) == TX_RATE_54M))
> +#define IS_11B_RATE(A)							\
> +	({								\
> +		typeof(A) A_ = (A);					\
> +		((A_ & RATE_MASK) == TX_RATE_1M) ||			\
> +			((A_ & RATE_MASK) == TX_RATE_2M) ||		\
> +			((A_ & RATE_MASK) == TX_RATE_5M) ||		\
> +			((A_ & RATE_MASK) == TX_RATE_11M); })
> +

Again, please just make these real functions, if they are actually used.

thanks,

greg k-h
_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
