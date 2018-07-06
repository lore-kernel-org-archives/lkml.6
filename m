Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C716C6778A
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 02:09:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D6432240BC
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 02:09:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vVlwDL9c"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D6432240BC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=speakeasy.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932170AbeGFCJI (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Jul 2018 22:09:08 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:35020 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753770AbeGFCJG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jul 2018 22:09:06 -0400
Received: by mail-pf0-f193.google.com with SMTP id q7-v6so5901283pff.2
        for <linux-kernel@vger.kernel.org>; Thu, 05 Jul 2018 19:09:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=erlKwbafGZKSPPny8WxrZGDZiTQxlT/5WxSIsA/t6cg=;
        b=vVlwDL9c1ze2edfN62Dr0JoU3tDcITX8zO09gtptxsUvc+6WSvSPg/c71mTurvlDBt
         CBCfmHhSWBKyRM4iCyrW86fifEnwzZQhRQkXt45QGmj7GXwosTymOxmI0oKytGxAoSZD
         FyLus/z8dmkmPaDKudnCw15GAKwXsHTPWOUXXvwwme594JPcpqXKdbRi+2z2WN6B8eny
         xLpl+m8XxnTB6dm20UU0xRbMtNoZQBCHw3Zi97IAb+e7Fmm19wMoN2SxsaBeY9uFiM5J
         RTVkj1mQEoTuI/j+ZyodnsoV1idNV5AUU9bfhKGc2+bFdgTjoeCkTCOdBFuJ9Tu9d2/J
         xMAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=erlKwbafGZKSPPny8WxrZGDZiTQxlT/5WxSIsA/t6cg=;
        b=QIoPzFwmaWzrm7gzGdhpkn5nsA8ngLEKU2rXcciofJFx6Wov2tPFJu09Yy+4NBoBLG
         qzx7oHAypGBzQ7E2Fm8XkVgl6AqSix3VrQXdGMQrwsWA/pnRyx6bm+J/7iEuFN8Zx4Xe
         /IsNTfqNMIp4iNhLfIZQGCqREoj0GNjDVCHQeyWzy65IyFL4MmxGxtw4fnpvIYMG7cqF
         ja2Li90qoB5R65dFL9R8yRnG5zeAu8LLcw5oHm4CngKq+yR+AyFKR1Um8g1vBFnpHPo+
         HLSNNhToSrb7p2or4WmYmmUn3EDiVclQuurh1vbDt8GGty2TBjeNqn9PDr8rKhggmL+r
         +sIg==
X-Gm-Message-State: APt69E03lNc9kulyKaYd4rXLEmZhLcrraqqSXp0Z4XQtXanbq7SHpypY
        5i7GsqyXGP2CTFkL2p6gwOmvFubtN0EhJjN/s0Y=
X-Google-Smtp-Source: AAOMgpeajaRi+ivomSm6Xlcum9A7jffrUToFf1J687uPL6MHwjz48Z4UETc58x5KdiOxj5KzVejl9X/1GutAmUOx72Q=
X-Received: by 2002:a63:8749:: with SMTP id i70-v6mr7839220pge.325.1530842946139;
 Thu, 05 Jul 2018 19:09:06 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a17:90a:cc7:0:0:0:0 with HTTP; Thu, 5 Jul 2018 19:09:05
 -0700 (PDT)
In-Reply-To: <20180705130617.GA31233@embeddedor.com>
References: <20180705130617.GA31233@embeddedor.com>
From:   Trent Piepho <xyzzy@speakeasy.org>
Date:   Thu, 5 Jul 2018 19:09:05 -0700
X-Google-Sender-Auth: KETvqU6Ya0RzOlBgrXl-ow4JGEA
Message-ID: <CA+7tXiiPTSiJ==Q72Ynit-_fTLdVoy1v9PyJTchid5TjdYpkLQ@mail.gmail.com>
Subject: Re: [alsa-devel] [PATCH] ASoC: nau8824: use 64-bit arithmetic instead
 of 32-bit
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 5, 2018 at 6:06 AM, Gustavo A. R. Silva
<gustavo@embeddedor.com> wrote:
> Add suffix ULL to constant 256 in order to give the compiler complete
> information about the proper arithmetic to use.
>
> Notice that such constant is used in a context that expects an
> expression of type u64 (64 bits, unsigned) and the following
> expression is currently being evaluated using 32-bit arithmetic:
>
> 256 * fs * 2 * mclk_src_scaling[i].param
>
> Addresses-Coverity-ID: 1432039 ("Unintentional integer overflow")
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
> ---
>  sound/soc/codecs/nau8824.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/sound/soc/codecs/nau8824.c b/sound/soc/codecs/nau8824.c
> index 6bd1445..468d514 100644
> --- a/sound/soc/codecs/nau8824.c
> +++ b/sound/soc/codecs/nau8824.c
> @@ -1274,7 +1274,7 @@ static int nau8824_calc_fll_param(unsigned int fll_in,
>         fvco_max = 0;
>         fvco_sel = ARRAY_SIZE(mclk_src_scaling);
>         for (i = 0; i < ARRAY_SIZE(mclk_src_scaling); i++) {
> -               fvco = 256 * fs * 2 * mclk_src_scaling[i].param;
> +               fvco = 256ULL * fs * 2 * mclk_src_scaling[i].param;

This would be better written as fvco = (256 * 2 *
mclk_src_scaling[i].param) * (u64)fs;

There no reason the entire expression must use 64 bit multiplies,
since the left side
above is know to fit in 32-bits.

The code could be more efficient if mclk_src_scaling had been sorted
by scaling ratio
instead of register value.  In fact, most of the math in this loop
could be precomputed by the
compiler if one instead though of min and max fs range for a given scaler.
