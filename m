Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FSL_HELO_FAKE,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C26F8C43140
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 17:56:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7FEE820874
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 17:56:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LqwE6lMo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7FEE820874
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932622AbeFTR4m (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 13:56:42 -0400
Received: from mail-pg0-f67.google.com ([74.125.83.67]:33338 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932431AbeFTR4l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 13:56:41 -0400
Received: by mail-pg0-f67.google.com with SMTP id e11-v6so168949pgq.0;
        Wed, 20 Jun 2018 10:56:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ETn1trucF49/ZWABJbN9nGWr6H1YS6qIkfB37SfKh88=;
        b=LqwE6lMo3w6dn0sqWu102khq5hSWx+W6abe5GaLMFUSrRRuWB0CLFOzJwj9wvO9AhC
         C/BiObYFmMAu4TpVyCib9DRZmT+w9MI3g3QcRTRBGNxwN4h2gsCX2FGabdL2nkRrCKOK
         VBP3LmxjMg15C96/yLECOqMtTbfsQzyLgBPbv+acgXwghzGIdFArjcvNuRMaAupL2pE3
         y6A3iILGSqqeyAg1VwKKEId5opLBLqrOahZ/z6qca9tYoFcXxTn14DGlPr0oyxtyGlqS
         zPOJbc5w2Q7sw25rZR9OY79exO5eee5d/lKNbrPlz4MYxF1p6hXTiP+FWBTU3p/JGbm8
         nQXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ETn1trucF49/ZWABJbN9nGWr6H1YS6qIkfB37SfKh88=;
        b=VziRwKOOQI8be8yR1glQhD14agYGESC7e6RrSwMQDnK1R7TY3jUgkht1wQkmX+LMeh
         Vkn5+I69tQHZrnkJ3AcZB/BzhNR953No8Opn6TUpprN/FyJ8Zmsn1tHlFga8aiso0g5i
         KVYRYCPDlaYxIVu9cvuD/B7bTYJq/83mepr1RUzT3D9pO0Ema5OstwhR+gwaa07st8IS
         vOGAQ7/Dd/lU5WEY9EOvAaccwithl6sjaLM2unJ1npe/1guH3tobIi8ErI1XsmGQNtWZ
         +C/tOmKYlBASoxcqjnPqXTn/7l8wm936PcynJI+DW6zg2t9vK3Axqzqxv1vAouE0/bXF
         fhNA==
X-Gm-Message-State: APt69E1LYA8m/+iXSs6wKwhGwcFtvsX5mpW7QvIiYaqYCwmqM1KFdjjU
        u1pgEoykMActuKQof1Xe7U8=
X-Google-Smtp-Source: ADUXVKIET/AfLfsAA2p95ZTGN+g5TPJ1QIDixnv6P1sPxkhijKuARA9J1BXTVR08H2g0KD7i4rjp2w==
X-Received: by 2002:a62:e208:: with SMTP id a8-v6mr23746769pfi.6.1529517400930;
        Wed, 20 Jun 2018 10:56:40 -0700 (PDT)
Received: from gmail.com ([2620:15c:17:3:dc28:5c82:b905:e8a8])
        by smtp.gmail.com with ESMTPSA id j15-v6sm6458462pfk.40.2018.06.20.10.56.40
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 20 Jun 2018 10:56:40 -0700 (PDT)
Date:   Wed, 20 Jun 2018 10:56:38 -0700
From:   Eric Biggers <ebiggers3@gmail.com>
To:     Juan Manuel Torres Palma <j.m.torrespalma@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org,
        davem@davemloft.net, herbert@gondor.apana.org.au
Subject: Re: [PATCH] crypto: testmgr: add test vectors for skein
Message-ID: <20180620175638.GB76265@gmail.com>
References: <20180620105714.18359-1-j.m.torrespalma@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180620105714.18359-1-j.m.torrespalma@gmail.com>
User-Agent: Mutt/1.10+28 (db52f11e) (2018-06-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Juan,

On Wed, Jun 20, 2018 at 07:57:14PM +0900, Juan Manuel Torres Palma wrote:
> Adds test vectors specified in skein v1.3
> specification. The main code is still in staging
> directory, but this is required to eventually be
> moved to the crypto directory.
> 
> Signed-off-by: Juan Manuel Torres Palma <j.m.torrespalma@gmail.com>
> ---
>  crypto/testmgr.c |  21 ++++++
>  crypto/testmgr.h | 203 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 224 insertions(+)
> 
> diff --git a/crypto/testmgr.c b/crypto/testmgr.c
> index 11e45352fd0b..9fa08cbc8852 100644
> --- a/crypto/testmgr.c
> +++ b/crypto/testmgr.c
> @@ -3453,6 +3453,27 @@ static const struct alg_test_desc alg_test_descs[] = {
>  		.suite = {
>  			.hash = __VECS(sha512_tv_template)
>  		}
> +	}, {
> +		.alg = "skein1024",
> +		.test = alg_test_hash,
> +		.fips_allowed = 1,

Are you sure Skein should be on the "FIPS allowed" list?  I'm not particularly
familiar with FIPS, but my understanding is that the fips_allowed flag is only
supposed to be set on specific "approved" algorithms.  So if you're unsure, it
shouldn't be set.

Eric
