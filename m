Return-Path: <SRS0=LZPJ=LZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A65D0C04ABB
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 23:44:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A38020866
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 23:44:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="f2MsUqry"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A38020866
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726861AbeILEp4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Sep 2018 00:45:56 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:45245 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725737AbeILEp4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Sep 2018 00:45:56 -0400
Received: by mail-pf1-f196.google.com with SMTP id i26-v6so23431pfo.12
        for <linux-kernel@vger.kernel.org>; Tue, 11 Sep 2018 16:44:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0trje/sBhpGsnVwEh/JhXr1BBRQf4qPt8GXVxSz39nY=;
        b=f2MsUqry8PJBPD7k0C1bY8oKUswg3XYNL0Tub4MmEnCR3Qmvlh/q9dy91o5HKiJynE
         ya8uQ2WNKkrYLnkaXwA5dvZHj3//FmqHeksCFHPk2j+T/AicGlal3rWXtKo0NqdnP1of
         B5xH9pU1wn4pihDzx5mg4sKP4KPwKE2H2Oi/w8gpCJGm1r+APDLKQ9ahTrWYeSk0cqtW
         vxk1d6hW8PUDtDjNjn1PWIFnibuZXOg+AD30RhOzBSrD8lgtgn7nYcpbaJ3Ntr78S311
         P38Ed1ZZAvegnmVZfYljEtzH7+yeHxvc+4mN9cJxMkwjxk8UKtaQ8RdKAV1T2RHGES9R
         ruYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0trje/sBhpGsnVwEh/JhXr1BBRQf4qPt8GXVxSz39nY=;
        b=YtyS5whTwYu4qfr7UuKLETpE0lCK0eRnrtlv64EjSeJxwpPUbgGaA0XTu1Tb4h1CaH
         +uEy7178qZvnmLNprHjynPshazjVhuCaR1QKBUpVWiSnTJnm52bzv7fAoNhVis9RnJs9
         MciuqzxHV0Oe2qkbhurIhpvZRPQ0af+gbSDZG7O/9BTMyXM1vzHRJvrapiwcucYAh037
         uAwmJ94kAuSA3Y27cHLrOASotAw7CIy/pJ+nulYdQn6u73zjlMVgN0UgCQOAWGz4KW4O
         otmTzxp/BcCCfcKVO3oD7EVosAckzsbC41kuvNwmVobXrC2q1QjdA44VdLKCK8qV4U21
         lZsQ==
X-Gm-Message-State: APzg51AB3wqOprKUHrdD9QqtaUOKUOEd8DsnSaOO1FaNR++Bxuus9CqM
        FVlcyYtNkSPad05q0t5m+x2x3iPpTIW/Bvsm4SjuhQ==
X-Google-Smtp-Source: ANB0Vda7Eu7hsKItVUwhwgk4V67aF6HKIN4FWt81LN4fEJbkIqx7gPmV4WGTuSo/IlvtxXphL5MKIaTswBJ3heVWuUw=
X-Received: by 2002:a63:1921:: with SMTP id z33-v6mr31402434pgl.302.1536709459180;
 Tue, 11 Sep 2018 16:44:19 -0700 (PDT)
MIME-Version: 1.0
References: <20180911232025.4909-1-natechancellor@gmail.com>
In-Reply-To: <20180911232025.4909-1-natechancellor@gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Tue, 11 Sep 2018 16:44:08 -0700
Message-ID: <CAKwvOdmxg_hRVN=W4VQpxUrApH5-cci8DX=OCWztUWhDXxYUSg@mail.gmail.com>
Subject: Re: [PATCH] dmaengine: timb_dma: Use proper enum in td_prep_slave_sg
To:     Nathan Chancellor <natechancellor@gmail.com>
Cc:     dan.j.williams@intel.com, vkoul@kernel.org,
        dmaengine@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 11, 2018 at 4:20 PM Nathan Chancellor
<natechancellor@gmail.com> wrote:
>
> Clang warns when implicitly converting from one enumerated type to
> another. Avoid this by using the equivalent value from the expected
> type.
>
> drivers/dma/timb_dma.c:548:27: warning: implicit conversion from
> enumeration type 'enum dma_transfer_direction' to different enumeration
> type 'enum dma_data_direction' [-Wenum-conversion]
>                 td_desc->desc_list_len, DMA_MEM_TO_DEV);
>                                         ^~~~~~~~~~~~~~
> 1 warning generated.
>
> Reported-by: Nick Desaulniers <ndesaulniers@google.com>
> Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
> ---
>  drivers/dma/timb_dma.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/dma/timb_dma.c b/drivers/dma/timb_dma.c
> index 395c698edb4d..fc0f9c8766a8 100644
> --- a/drivers/dma/timb_dma.c
> +++ b/drivers/dma/timb_dma.c
> @@ -545,7 +545,7 @@ static struct dma_async_tx_descriptor *td_prep_slave_sg(struct dma_chan *chan,
>         }
>
>         dma_sync_single_for_device(chan2dmadev(chan), td_desc->txd.phys,
> -               td_desc->desc_list_len, DMA_MEM_TO_DEV);
> +               td_desc->desc_list_len, DMA_TO_DEVICE);

Looks like DMA_MEM_TO_DEV and DMA_TO_DEVICE happen to have the same
value (today) so no functional change.
And dma_sync_single_for_device is defined to take the `enum
dma_data_direction` which `DMA_TO_DEVICE` is an enumeration of.

Thanks for the patch Nathan.
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>

>
>         return &td_desc->txd;
>  }
> --
> 2.18.0
>


-- 
Thanks,
~Nick Desaulniers
