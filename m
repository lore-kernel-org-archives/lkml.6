Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FSL_HELO_FAKE,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05847C43141
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 23:33:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A778320652
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 23:33:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pVApEjiM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A778320652
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932875AbeFTXdq (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 19:33:46 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:46627 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932264AbeFTXdo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 19:33:44 -0400
Received: by mail-pf0-f194.google.com with SMTP id q1-v6so531841pff.13;
        Wed, 20 Jun 2018 16:33:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=cPP6lytcI5bhKvDUyvEbczm4VkazYAhIYRbwC5MqoBM=;
        b=pVApEjiMVZ64oIDMwM9MYHrX+VseSPT1Gnw4uLXp//GX7MKUWBbuNaNYp7TkrVW2IX
         bFoDD017LwwZXSqOXff6g0ZP9bIBwl8mKU53x5wnywla/46Sk6kWNY3CrfMaWxBGsvZN
         FWH91NWMUivajUiavXNV+jdTNOBQ6EYq264dE17qNwM/XUbEM8EEXj+0pVDonEx8GKUK
         0GhSmqRr0TVyBH4NNxOuIVQJwy2O6vuAGS0GvlDIAIe2pwX43ErEoDGM8lC3DkQ+4Hj4
         QTpE24bGFUV9RY38Pwd32FHQebIe0RTjoEJIX/0LBdIIvdc63mGoS/7JcwrZ7iA4j0Ye
         MsMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=cPP6lytcI5bhKvDUyvEbczm4VkazYAhIYRbwC5MqoBM=;
        b=JVHyKQ7vitnJdN2BgqpUbCqi5jwYnaam0d4moQt1p2bTIGP2H3LC188xfZxkUcnIBC
         r2qSA+TmmaWIYyLXvB9dY+b2pBmumOAZy2FpI/mYPIVw4Eh4OvT6+DfDzfPkBkPgyqJ0
         9w2ZhWK5N79U1DdGk300Po3S7I+9mQcsK09JILcfkk+sxPfiFwWw5IXAoXMpdxkSy2gI
         qGLousuNahx1y8eJZJBEqu8r/neAJVFF2gzxnzUCz7I9DWhDm4ciZdijIY98oIVlrBUQ
         iPsFspydiMnSPSlGzM9bkcwBwBak/W62HmINDI/EfpyCRnryfpbMp89GkKdZ8hdupTmq
         qj2Q==
X-Gm-Message-State: APt69E0qYBRQmfbKdogVRSAJvLASzTTL2hTft6PH8XlF+/OZxw+GUal1
        nw0lj2DpiptJItLTLPpu4Lc=
X-Google-Smtp-Source: ADUXVKLM8u3wbn0l9hv7uv3AfK42L39LyCye6FGXJn4Ti0S+TNelPWfytrD7X9qtus2W/VCT2x3Jew==
X-Received: by 2002:a62:1747:: with SMTP id 68-v6mr24546694pfx.69.1529537624271;
        Wed, 20 Jun 2018 16:33:44 -0700 (PDT)
Received: from gmail.com ([2620:15c:17:3:dc28:5c82:b905:e8a8])
        by smtp.gmail.com with ESMTPSA id c4-v6sm6875196pfe.53.2018.06.20.16.33.43
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 20 Jun 2018 16:33:43 -0700 (PDT)
Date:   Wed, 20 Jun 2018 16:33:42 -0700
From:   Eric Biggers <ebiggers3@gmail.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     Herbert Xu <herbert@gondor.apana.org.au>,
        Giovanni Cabiddu <giovanni.cabiddu@intel.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Eric Biggers <ebiggers@google.com>,
        Mike Snitzer <snitzer@redhat.com>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        qat-linux@intel.com, linux-kernel@vger.kernel.org,
        dm-devel@redhat.com, linux-crypto@vger.kernel.org,
        Lars Persson <larper@axis.com>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        Alasdair Kergon <agk@redhat.com>,
        Rabin Vincent <rabinv@axis.com>
Subject: Re: [dm-devel] [PATCH 04/11] dm verity fec: Remove VLA usage
Message-ID: <20180620233342.GB111712@gmail.com>
References: <20180620190408.45104-1-keescook@chromium.org>
 <20180620190408.45104-5-keescook@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180620190408.45104-5-keescook@chromium.org>
User-Agent: Mutt/1.10+28 (db52f11e) (2018-06-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 20, 2018 at 12:04:01PM -0700, Kees Cook wrote:
> In the quest to remove all stack VLA usage from the kernel[1], this
> uses the newly defined max digest size macro. Also adds a sanity-check
> at use-time.
> 
> [1] https://lkml.kernel.org/r/CA+55aFzCG-zNmZwX4A2FQpadafLfEzK6CC=qPXydAacU1RqZWA@mail.gmail.com
> 
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---
>  drivers/md/dm-verity-fec.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/md/dm-verity-fec.c b/drivers/md/dm-verity-fec.c
> index 684af08d0747..0dfcc52835bc 100644
> --- a/drivers/md/dm-verity-fec.c
> +++ b/drivers/md/dm-verity-fec.c
> @@ -212,12 +212,15 @@ static int fec_read_bufs(struct dm_verity *v, struct dm_verity_io *io,
>  	struct dm_verity_fec_io *fio = fec_io(io);
>  	u64 block, ileaved;
>  	u8 *bbuf, *rs_block;
> -	u8 want_digest[v->digest_size];
> +	u8 want_digest[AHASH_MAX_DIGESTSIZE];
>  	unsigned n, k;
>  
>  	if (neras)
>  		*neras = 0;
>  
> +	if (WARN_ON(v->digest_size < sizeof(want_digest)))
> +		return -EINVAL;
> +

This is backwards; it should be 'v->digest_size > sizeof(want_digest)'.

- Eric
