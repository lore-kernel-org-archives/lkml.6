Return-Path: <SRS0=/3Wd=NV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18956C43441
	for <linux-kernel@archiver.kernel.org>; Sat, 10 Nov 2018 06:27:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE6DC206BA
	for <linux-kernel@archiver.kernel.org>; Sat, 10 Nov 2018 06:27:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ti5iMnGI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CE6DC206BA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728906AbeKJQL3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 10 Nov 2018 11:11:29 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:46629 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728567AbeKJQL3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Nov 2018 11:11:29 -0500
Received: by mail-lf1-f66.google.com with SMTP id f23so2841191lfc.13;
        Fri, 09 Nov 2018 22:27:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gs8rrWrRhmS4JXF+Yr3LoefbFSeNTTkISbJ/N4ZSiPM=;
        b=ti5iMnGIaFz/MlBZ6SMcaV8WsvLdDtliFwSMnpFoQpZ2CYhSli/weE/QnDSiV4YLVc
         w5kCMh08DUha9M3Kij1hb17pBet8VoypptyCv79WbM/FjufM5tt68Huj05WpL6gASUrl
         FmZtl9chZzMUY2p98lXRCAdKIvqWuzIQtYvEMDopjmBNNdfv3ydaxEdo0u3+4RM3Yc+E
         3d+7aPLKJEQSlAVgM27fPfNPkfznslu/zqJPoVWSM8ZBZ6NunG3GLGBMH7F8ncah0b7a
         bH7LUg8tYE06TzrvviziR6vKDasuX6Z/MP27nQBDlXKgFHlpu8NOPYc72Fpze8vhOjnW
         a9hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gs8rrWrRhmS4JXF+Yr3LoefbFSeNTTkISbJ/N4ZSiPM=;
        b=X9jdgNUK4poz7Fvo/p/iTCAfUur2r3/hrLbim3IRuYt5/B8IHE9qhT+iNBOb3hdSke
         vC3st6Vb3vWISaHxPnSswBLocVAa6/xezcKBZUlFdy5CdHEh5lxhvSN9ObFUSAU4aD+k
         GiftLf7h0hL1RtzgrdDgvQ5/KM81cESmGjrPV8ittn9hmqGs08zHt8Hxl3D0yUsflIwz
         Z1V1Kyt2gOi9vNjMQ6kFjLCQacvlhkd0lGFBmzVEBMqw6ChM04Ua3I1OdI+cxLmRPPW5
         Ow4PAjIfRucP8Y/ba3AO+cyIWtbPQ6DaJDqirZ8P0LFKHkhI5lIhmqDa55mUhmpOnSmM
         87Hw==
X-Gm-Message-State: AGRZ1gJjWj8snZ3vqLQGm+utsIiHc/omHnEt2m8IQNRzb+k7BFA/jOk2
        F7vKSaoUyjxyuCsaSb8clftB/L0v5ZMpzt9ZEHU=
X-Google-Smtp-Source: AJdET5fcBprGjnrxj7GWEiFxMB6PG1ijkYzUVzrPTGYtnybY9P7Uhnc6GL0MvMxiupT6bMhFg2YtCUb0BoL6mYWmiFQ=
X-Received: by 2002:a19:5349:: with SMTP id h70mr6713377lfb.24.1541831256992;
 Fri, 09 Nov 2018 22:27:36 -0800 (PST)
MIME-Version: 1.0
References: <5be59bf8.1c69fb81.a231.dcd6@mx.google.com>
In-Reply-To: <5be59bf8.1c69fb81.a231.dcd6@mx.google.com>
From:   Souptick Joarder <jrdr.linux@gmail.com>
Date:   Sat, 10 Nov 2018 11:57:24 +0530
Message-ID: <CAFqt6zY5PUB-=1PeNKHiWmgbrR=3EfqcYsWOVH5TLeJnQf0JBg@mail.gmail.com>
Subject: Re: [PATCH] infiniband/hw/hns/hns_roce_hw_v2.c: Use dma_zalloc_coherent
To:     Sabyasachi Gupta <sabyasachi.linux@gmail.com>
Cc:     oulijun@huawei.com, xavier.huwei@huawei.com,
        Doug Ledford <dledford@redhat.com>, jgg@ziepe.ca,
        linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
        Brajeswar Ghosh <brajeswar.linux@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 9, 2018 at 8:08 PM Sabyasachi Gupta
<sabyasachi.linux@gmail.com> wrote:
>
> Replaced dma_alloc_coherent + memset with dma_zalloc_coherent

There are few other places in this file where same is applicable.
Can we get those changes in same patch ?
>
> Signed-off-by: Sabyasachi Gupta <sabyasachi.linux@gmail.com>
> ---
>  drivers/infiniband/hw/hns/hns_roce_hw_v2.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
> index a4c62ae..c9966ec 100644
> --- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
> +++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
> @@ -4972,13 +4972,12 @@ static int hns_roce_mhop_alloc_eq(struct hns_roce_dev *hr_dev,
>                                 eqe_alloc = i * (buf_chk_sz / eq->eqe_size);
>                                 size = (eq->entries - eqe_alloc) * eq->eqe_size;
>                         }
> -                       eq->buf[i] = dma_alloc_coherent(dev, size,
> +                       eq->buf[i] = dma_zalloc_coherent(dev, size,
>                                                         &(eq->buf_dma[i]),
>                                                         GFP_KERNEL);
>                         if (!eq->buf[i])
>                                 goto err_dma_alloc_buf;
>
> -                       memset(eq->buf[i], 0, size);
>                         *(eq->bt_l0 + i) = eq->buf_dma[i];
>
>                         eq_buf_cnt++;
> --
> 2.7.4
>
