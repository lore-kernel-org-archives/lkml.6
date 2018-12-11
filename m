Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B46DBC5CFFE
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 05:02:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 77B672054F
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 05:02:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="BztX15TN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 77B672054F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728659AbeLKFCU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 00:02:20 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:35525 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728017AbeLKFCT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 00:02:19 -0500
Received: by mail-lj1-f193.google.com with SMTP id x85-v6so11785162ljb.2
        for <linux-kernel@vger.kernel.org>; Mon, 10 Dec 2018 21:02:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wVQRKeA3LrWUFCWj38YW7UNSSMR/1M/U3bbK4X1HaM4=;
        b=BztX15TNf7C7JxFUBcuRZ/qB3t398Eo2pCh/aQzySjA0fVL2z47AuIWjYtd9qAIZVP
         JQ8BkW9bc7OgFORj8f0r38W6zQOGCULUcuHq4fVi+m5vMZ/kar0V9KWUTk8pE85WICXA
         8ZXYldkg03UzrpCEzpUYfhDg7oYWNX36Eu6Zk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wVQRKeA3LrWUFCWj38YW7UNSSMR/1M/U3bbK4X1HaM4=;
        b=DoxWta5Q2w4y635hIsD7ZVLrFYQ8xZmnT1OstL0sgxlh8IGENRWVjf/wUDSv45xXkm
         L5/QPB1YROFVDkh5VfyoG8ru2f2u6L3NgXbB/J6XAMJCnJNxedbv9iYDmyPDpNPbPyxR
         833+jJHS9Qw6ggvPN5PwzEaU/hWNfL+sQiy5F0LPNfPqIbLJ4AXuJkcxaV7UGjWJ7tpY
         mpTXS60umeiKJ7CjrKm54tLX2CW+apDnLb83X2KWOdKwnBCZWM7tgIcSd7JI6IiTEM+V
         hLBudc2F/8OBcjfBtSqt8lBSWvnd7NWzhSHgBFnYs5WA2hT62AtwsZaLPlMtMD7YjoMB
         GiOg==
X-Gm-Message-State: AA+aEWYGFecGgPAHJPqv2PF7mCsZavQiRW80YdcFdUhzHX+1nrcYCPf7
        9Qk44raDuX6g1va2Bk19MORxyoDoBVZ+pSS6P2dbTA==
X-Google-Smtp-Source: AFSGD/VuMe2A4VysUGd7mBU+4U74dImBJpPyuFVbtqtcDzpRkOGYUHnvT5qGhhYPmns7cS0suGaB68PC4l+fdz8wiqc=
X-Received: by 2002:a2e:b1ca:: with SMTP id e10-v6mr9693666lja.16.1544504536565;
 Mon, 10 Dec 2018 21:02:16 -0800 (PST)
MIME-Version: 1.0
References: <20181211035725.5084-1-manivannan.sadhasivam@linaro.org>
In-Reply-To: <20181211035725.5084-1-manivannan.sadhasivam@linaro.org>
From:   Baolin Wang <baolin.wang@linaro.org>
Date:   Tue, 11 Dec 2018 13:02:04 +0800
Message-ID: <CAMz4kuKtJSmUheV3F0P6RP_prCaS94NC2uBh05g5DNp3pJ=9XQ@mail.gmail.com>
Subject: Re: [PATCH] Add linux-unisoc mailing list to Spreadtrum SoC support
To:     manivannan.sadhasivam@linaro.org
Cc:     Orson Zhai <orsonzhai@gmail.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        linux-unisoc@lists.infradead.org,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>, afaerber@suse.de,
        orson.zhai@unisoc.com,
        =?UTF-8?B?R2VuZyBSZW4gKOS7u+i1kyk=?= <geng.ren@unisoc.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 11 Dec 2018 at 11:57, Manivannan Sadhasivam
<manivannan.sadhasivam@linaro.org> wrote:
>
> Since Spreadtrum is now merged into Unisoc Communications, let's use the
> newly created linux-unisoc mailing list for all discussions around the
> Spreadtrum SoCs.
>
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

Thanks.
Acked-by: Baolin Wang <baolin.wang@linaro.org>

> ---
>  MAINTAINERS | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 6682420421c1..d1f768fd4f49 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -2108,6 +2108,7 @@ ARM/SPREADTRUM SoC SUPPORT
>  M:     Orson Zhai <orsonzhai@gmail.com>
>  M:     Baolin Wang <baolin.wang@linaro.org>
>  M:     Chunyan Zhang <zhang.lyra@gmail.com>
> +L:     linux-unisoc@lists.infradead.org (moderated for non-subscribers)
>  S:     Maintained
>  F:     arch/arm64/boot/dts/sprd
>  N:     sprd
> --
> 2.17.1
>


-- 
Baolin Wang
Best Regards
