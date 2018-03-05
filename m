Return-Path: <julia.lawall@lip6.fr>
X-Google-Smtp-Source: AG47ELuf1NPfoTHI6uOpx5RQr2JEejfd8bhfeVKr5egIFErgcDWWHEllw3mKqOaqd0yrBL2gQGqz
ARC-Seal: i=1; a=rsa-sha256; t=1520235475; cv=none;
        d=google.com; s=arc-20160816;
        b=b0w7wdevRkAobI2si/SW10ahSVowCaAT3O72FMaf03+xWj8GjJGI3a3v2KDCmIGe1D
         ufd9SZppiRRBfVqb9551pzdL5+xRh3920ci35zox28qI1NTuhPc89/BvsO2yGlR3TVP9
         CyeG3kH2KYn0RPAA4SJECBegVH9Vg83TYtrWpvDKlB/mz39bMlo3kV4YU0FnM2MSgsMG
         sYY8OS6YCt6xTWOu60OXRmBpFSnDUMN5j8c2RQUGAh5lHtHan6WPjou9nRunwLkv8l9P
         mVqHQUbi9lPO2K4wpzIOFFan3kTRbixn/n2nlsahKuhla25y2iqkUVaHZaKq+o8FO6aH
         1JxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:message-id:in-reply-to:subject
         :cc:to:from:date:arc-authentication-results;
        bh=1u7duWMyJKA21pTv1UpfGwAEq+w8RKwlJD2mOnl6NZs=;
        b=YESu4go+xUxkjegeLvrku5m2VHVNB9szjVfO0ACOB61R8+Z+vXg9aynB+jPirJU2mO
         KPOOvAqbsECL7vw4hhR7T+f3k1OjuarcBWx0WkitO0QjAc+ub5XuAYu3W7tPmqLxZAwj
         DBBzuIIZi3tHPyp4cm9rDFP5R2t27hs+euHC5755nae0IYtKOI8KToVxUI9BRWc4bJcH
         KPrXGSupbiMV8LApyvYcpXKTbqbsy4RoalHACk/DIBxCDfD3Kelt5gCdkoU4SYHsqyKB
         /v8j3CZuVjkUKStPcrUXXaLn/J0saAF/Lbg4PFYV3VeQxoZ6pgAh7oNyhQaPTL6KuMyz
         8E9A==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=neutral (google.com: 192.134.164.104 is neither permitted nor denied by domain of julia.lawall@lip6.fr) smtp.mailfrom=julia.lawall@lip6.fr
Authentication-Results: mx.google.com;
       spf=neutral (google.com: 192.134.164.104 is neither permitted nor denied by domain of julia.lawall@lip6.fr) smtp.mailfrom=julia.lawall@lip6.fr
X-IronPort-AV: E=Sophos;i="5.47,426,1515452400";
   d="scan'208";a="256960044"
Date: Mon, 5 Mar 2018 08:37:54 +0100 (CET)
From: Julia Lawall <julia.lawall@lip6.fr>
X-X-Sender: jll@hadrien
To: Arushi Singhal <arushisinghal19971997@gmail.com>
cc: gregkh@linuxfoundation.org, devel@driverdev.osuosl.org,
    linux-kernel@vger.kernel.org, Larry.Finger@lwfinger.net,
    outreachy-kernel@googlegroups.com
Subject: Re: [Outreachy kernel] [PATCH v2] staging: rtl8192u: Replace printk()
 with appropriate net_*macro_ratelimited()
In-Reply-To: <20180305073256.GA4347@seema-Inspiron-15-3567>
Message-ID: <alpine.DEB.2.20.1803050835230.2306@hadrien>
References: <20180305073256.GA4347@seema-Inspiron-15-3567>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594082150118827439?=
X-GMAIL-MSGID: =?utf-8?q?1594082433972436919?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>



On Mon, 5 Mar 2018, Arushi Singhal wrote:

> Replace printk having a log level with the appropriate
> net_*macro_ratelimited.
> It's better to use actual device name as a prefix in error messages.

I asked several questions about the above two lines, which as far as I can
see haven't been answered. Please excuse me if I missed the answers, but I
would still like to know what they are.

Namely, why did you choose to change to rate limited output, and what does
the "device name as a prefix" comment mean?

julia

> Indentation is also changed, to fix the  checkpatch issue if line is not
> exceding 80 characters.
>
> Signed-off-by: Arushi Singhal <arushisinghal19971997@gmail.com>
> ---
> changes in v2
> *change the subject line, in v1 driver name was wrong.
>
>  .../rtl8192u/ieee80211/ieee80211_crypt_ccmp.c      | 22 +++++++++++-----------
>  1 file changed, 11 insertions(+), 11 deletions(-)
>
> diff --git a/drivers/staging/rtl8192u/ieee80211/ieee80211_crypt_ccmp.c b/drivers/staging/rtl8192u/ieee80211/ieee80211_crypt_ccmp.c
> index e6648f7..200fe5f 100644
> --- a/drivers/staging/rtl8192u/ieee80211/ieee80211_crypt_ccmp.c
> +++ b/drivers/staging/rtl8192u/ieee80211/ieee80211_crypt_ccmp.c
> @@ -73,7 +73,7 @@ static void *ieee80211_ccmp_init(int key_idx)
>
>  	priv->tfm = (void *)crypto_alloc_cipher("aes", 0, CRYPTO_ALG_ASYNC);
>  	if (IS_ERR(priv->tfm)) {
> -		printk(KERN_DEBUG "ieee80211_crypt_ccmp: could not allocate crypto API aes\n");
> +		net_dbg_ratelimited("ieee80211_crypt_ccmp: could not allocate crypto API aes\n");
>  		priv->tfm = NULL;
>  		goto fail;
>  	}
> @@ -276,22 +276,22 @@ static int ieee80211_ccmp_decrypt(struct sk_buff *skb, int hdr_len, void *priv)
>  	keyidx = pos[3];
>  	if (!(keyidx & (1 << 5))) {
>  		if (net_ratelimit()) {
> -			printk(KERN_DEBUG "CCMP: received packet without ExtIV flag from %pM\n",
> -				hdr->addr2);
> +			net_dbg_ratelimited("CCMP: received packet without ExtIV flag from %pM\n",
> +					    hdr->addr2);
>  		}
>  		key->dot11RSNAStatsCCMPFormatErrors++;
>  		return -2;
>  	}
>  	keyidx >>= 6;
>  	if (key->key_idx != keyidx) {
> -		printk(KERN_DEBUG "CCMP: RX tkey->key_idx=%d frame keyidx=%d priv=%p\n",
> -			key->key_idx, keyidx, priv);
> +		net_dbg_ratelimited("CCMP: RX tkey->key_idx=%d frame keyidx=%d priv=%p\n",
> +				    key->key_idx, keyidx, priv);
>  		return -6;
>  	}
>  	if (!key->key_set) {
>  		if (net_ratelimit()) {
> -			printk(KERN_DEBUG "CCMP: received packet from %pM with keyid=%d that does not have a configured key\n",
> -				hdr->addr2, keyidx);
> +			net_dbg_ratelimited("CCMP: received packet from %pM with keyid=%d that does not have a configured key\n",
> +					    hdr->addr2, keyidx);
>  		}
>  		return -3;
>  	}
> @@ -306,8 +306,8 @@ static int ieee80211_ccmp_decrypt(struct sk_buff *skb, int hdr_len, void *priv)
>
>  	if (memcmp(pn, key->rx_pn, CCMP_PN_LEN) <= 0) {
>  		if (net_ratelimit()) {
> -			printk(KERN_DEBUG "CCMP: replay detected: STA=%pM previous PN %pm received PN %pm\n",
> -			       hdr->addr2, key->rx_pn, pn);
> +			net_dbg_ratelimited("CCMP: replay detected: STA=%pM previous PN %pm received PN %pm\n",
> +					    hdr->addr2, key->rx_pn, pn);
>  		}
>  		key->dot11RSNAStatsCCMPReplays++;
>  		return -4;
> @@ -341,8 +341,8 @@ static int ieee80211_ccmp_decrypt(struct sk_buff *skb, int hdr_len, void *priv)
>
>  		if (memcmp(mic, a, CCMP_MIC_LEN) != 0) {
>  			if (net_ratelimit()) {
> -				printk(KERN_DEBUG "CCMP: decrypt failed: STA=%pM\n",
> -					hdr->addr2);
> +				net_dbg_ratelimited("CCMP: decrypt failed: STA=%pM\n",
> +						    hdr->addr2);
>  			}
>  			key->dot11RSNAStatsCCMPDecryptErrors++;
>  			return -5;
> --
> 2.7.4
>
> --
> You received this message because you are subscribed to the Google Groups "outreachy-kernel" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to outreachy-kernel+unsubscribe@googlegroups.com.
> To post to this group, send email to outreachy-kernel@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/outreachy-kernel/20180305073256.GA4347%40seema-Inspiron-15-3567.
> For more options, visit https://groups.google.com/d/optout.
>
