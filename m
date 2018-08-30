Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C77BC433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 19:18:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB8D72082A
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 19:18:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iiz/Lc00"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BB8D72082A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727294AbeH3XVq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 19:21:46 -0400
Received: from mail-ua1-f65.google.com ([209.85.222.65]:37380 "EHLO
        mail-ua1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725836AbeH3XVp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 19:21:45 -0400
Received: by mail-ua1-f65.google.com with SMTP id y10-v6so6415024uao.4;
        Thu, 30 Aug 2018 12:18:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=nYMkvpZ/TKeSz+jXkocwzlgUfMyAdPRnPsI2NHfra5c=;
        b=iiz/Lc00yMUK/S1+3pxt50IH2DPTnR//CUdkGs0ZE016i+ZcRcJ7UySJMboOy6AqCk
         Rlb6SVhyhkqpJoDQkO2QMdfugk+uxYeA4qvClkU6mD2wQVQHCvpNAztKbSfZe6kxlz+r
         K1Ut+fLDwESesQgAsPql35bE+jCjuO72dQ0rmkYhq07Rc2ZlKoclDnPc2VXS48yN+Bl7
         njIM4lE1ErHUmzQ31AsR16peXUMDSd0fzlQ5+wWvRmER1EmY8MLAdiPxvHQAugkcvDy3
         AF2jV6bLng6ckjgUdsJhJDgqTBBtmCQL2xoa8m26Dz//9Q20HJ6/y7dsS0n9V2XJi0/M
         mSaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=nYMkvpZ/TKeSz+jXkocwzlgUfMyAdPRnPsI2NHfra5c=;
        b=B7APTqQeYeZ4cUKnUONBiqxKx4i+CkpOVOjMVlj7Mb5HwJPb5ZGmQikf3dKfbERYrX
         EIMJWb5xRsSEPGNiU/ntVEebcjpOREb8Qz35xT/ywNJ9lItHnt6VU6N3yTrg9NLnR8S8
         k+bYtrvZXatGDDXANwgn8VjbE3dK1SMXvL3XsNcruX4DOxwwuP3QwVz8BRVXmLMnpAHd
         23Wysc3cHod5hV55awVLEGvvC2L0EkIzQsxZDERA6ZKGhbk3YV45ci2F+s5OL+G+u7zv
         Mg2VaeAVQqwHHsgp1BH/x2yfv6UAFMfTSrPCiEdosUDMUNG5hciNH2T7LUZZ4s3RCJrF
         pjdA==
X-Gm-Message-State: APzg51D+1B4cR4v5eEZNpLaRlIBkOIiDC2u2/jJvCucU9Ci8iRgxsFJT
        St1CFjjT5BU55N8qOgai8COgBH6egoF7K/C7EEs=
X-Google-Smtp-Source: ANB0VdafOd1MPCAZUknFM560s50gwfnXisk+e/HPvGtPdDHpTwnmOJP9HCq96yEy1Qn6C6/vi8u0e0q5vshDnjW5zYE=
X-Received: by 2002:a67:3b0c:: with SMTP id i12-v6mr1020539vsa.14.1535656685382;
 Thu, 30 Aug 2018 12:18:05 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ab0:5e5c:0:0:0:0:0 with HTTP; Thu, 30 Aug 2018 12:18:04
 -0700 (PDT)
In-Reply-To: <1535654266-40053-1-git-send-email-wufan@codeaurora.org>
References: <1535654266-40053-1-git-send-email-wufan@codeaurora.org>
From:   Tyler Baicar <baicar.tyler@gmail.com>
Date:   Thu, 30 Aug 2018 15:18:04 -0400
Message-ID: <CABo9ajCui0y9HMBzgKWeNtrbu4de+mLh=d9Qdkyo4zhU9az6hw@mail.gmail.com>
Subject: Re: [PATCH v2] EDAC, ghes: use CPER module handles to locate DIMMs
To:     Fan Wu <wufan@codeaurora.org>
Cc:     mchehab@kernel.org, Borislav Petkov <bp@alien8.de>,
        James Morse <james.morse@arm.com>, linux-edac@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        arm-mail-list <linux-arm-kernel@lists.infradead.org>,
        john.garry@huawei.com, toshi.kani@hpe.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Fan,

On Thu, Aug 30, 2018 at 2:37 PM, Fan Wu <wufan@codeaurora.org> wrote:
> For platforms whose firmwares provide valid module handles
> (SMBIOS type 17) in error records, this patch uses the module
> handles to locate corresponding DIMMs and enables per-DIMM
> error counter update.
>
> Signed-off-by: Fan Wu <wufan@codeaurora.org>

> diff --git a/drivers/edac/ghes_edac.c b/drivers/edac/ghes_edac.c
> index 473aeec..949f603 100644
> --- a/drivers/edac/ghes_edac.c
> +++ b/drivers/edac/ghes_edac.c
> @@ -81,6 +81,20 @@ static void ghes_edac_count_dimms(const struct dmi_header *dh, void *arg)
>                 (*num_dimm)++;
>  }
>
> +static int get_dimm_smbios_index(u16 handle)
> +{
> +       struct mem_ctl_info *mci;
> +       int i;
> +
> +       mci = ghes_pvt->mci;
> +

Minor nit: you could define and set mci in the same line to save some
space here.

Otherwise this patch looks good to me.

Reviewed-by: Tyler Baicar <baicar.tyler@gmail.com>
