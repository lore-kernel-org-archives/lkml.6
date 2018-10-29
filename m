Return-Path: <SRS0=Xm/m=NJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64AFCC2BC61
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 17:28:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E93020657
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 17:28:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="D0542zzh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2E93020657
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727762AbeJ3CSO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Oct 2018 22:18:14 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:35217 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726330AbeJ3CSO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Oct 2018 22:18:14 -0400
Received: by mail-pg1-f196.google.com with SMTP id 32-v6so4247652pgu.2
        for <linux-kernel@vger.kernel.org>; Mon, 29 Oct 2018 10:28:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9Nv2xOlbXaWyJXbR+LgN8wx+L6gFwy3aaGFZH/g8OlQ=;
        b=D0542zzhcH9Nh0K1keLRaJQS+/B7WEMMDw5Q30c2LNcKEAn4YgNBgnI3W+XLj8HXio
         GzkbUlpAqy6k047ePP8yn9ESouPYKSPc8svLRxlRLkvSO1Hhc0ZuPQrjnjRUkNWvEI+v
         OfI0djCFyIcN10sz2/5RvPu6IicMHVNfhBWMOcWW1K2TGvrys0lsN7U0QzQEo6IPHMcB
         fFMBSfpaPUMX1GnHK2MP2+DxzxPPmy4si0TeZ1okpHB0V/FPSzRlqXqhM3f4SxbGF3gh
         zCBZP1aXPR6oju6Fh+TT5f+eOvDZoHO5Qwrp9L03AlOFGmnKJc6sGOGauZ1KIRYHUBRu
         gv8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9Nv2xOlbXaWyJXbR+LgN8wx+L6gFwy3aaGFZH/g8OlQ=;
        b=fOZ8aRcdDdsbFdXWPw2noVoujHHrhnu5cpZp3bLaWvUGZbSBk/lk++bpf5hVPTKl+I
         aB0K/Va5tD37FSJwnvFiOheEbY8zZo20/ZZDcexQmV2Mj8ZLlh6Qa2PFIQ96OY3XMf3m
         W4X+CL8lGchXHUOrCPGXvllij2a3+bbtgQbnGyILmpon8OMs8S3zXGBKDZ3LfnI/oaED
         B03iib+vnSYexK3im64NmJjvCJQluk2yNtXtgMYIVX6oUL8LlWw+3t4apwdoYr4yzniY
         YYgNbEAJjBeeWhkfEfgANzYOUiRatDZrNd6fIiteHxEJ8qvNGJLL+vbiYSP4yClyqCTh
         /CjA==
X-Gm-Message-State: AGRZ1gLT4xTR2G/dXzu70ZRTSKNGfqR/oyvjaJr9sn+BsN66ZxfbqgPB
        EEHZ3Y4JJxejpIhWKLQQf0WSE30kaa+jOS0M+yU9+Q==
X-Google-Smtp-Source: AJdET5f6NlO5/EQlLVMGHjy1DiTGwHLyQnp7TgL+be2WEdxCV+u+MvE0IGov+UL5BKAj7XjlSuoh/hNUPzWfo/8PrcQ=
X-Received: by 2002:aa7:88c2:: with SMTP id p2-v6mr16167065pfo.32.1540834119850;
 Mon, 29 Oct 2018 10:28:39 -0700 (PDT)
MIME-Version: 1.0
References: <20181029105158.6340-1-natechancellor@gmail.com>
In-Reply-To: <20181029105158.6340-1-natechancellor@gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Mon, 29 Oct 2018 10:28:28 -0700
Message-ID: <CAKwvOdmkPFC5SPNVTXeRdrE-vnbjYiDdXr_ZCArmvYYVtsYKVQ@mail.gmail.com>
Subject: Re: [PATCH] hinic: Fix l4_type parameter in hinic_task_set_tunnel_l4
To:     Nathan Chancellor <natechancellor@gmail.com>
Cc:     aviad.krawczyk@huawei.com, "David S. Miller" <davem@davemloft.net>,
        netdev@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 29, 2018 at 3:54 AM Nathan Chancellor
<natechancellor@gmail.com> wrote:
>
> Clang warns:
>
> drivers/net/ethernet/huawei/hinic/hinic_tx.c:392:34: error: implicit
> conversion from enumeration type 'enum hinic_l4_tunnel_type' to
> different enumeration type 'enum hinic_l4_offload_type'
> [-Werror,-Wenum-conversion]
>                 hinic_task_set_tunnel_l4(task, TUNNEL_UDP_NO_CSUM,
>                 ~~~~~~~~~~~~~~~~~~~~~~~~       ^~~~~~~~~~~~~~~~~~
> 1 error generated.
>
> It seems that hinic_task_set_tunnel_l4 was meant to take an enum of type
> hinic_l4_tunnel_type, not hinic_l4_offload_type, given both the name of
> the functions and the values used.

I agree. Thanks for fixing this up, Nathan!
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>

>
> Fixes: cc18a7543d2f ("net-next/hinic: add checksum offload and TSO support")
> Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
> ---
>  drivers/net/ethernet/huawei/hinic/hinic_hw_qp.c | 2 +-
>  drivers/net/ethernet/huawei/hinic/hinic_hw_qp.h | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/net/ethernet/huawei/hinic/hinic_hw_qp.c b/drivers/net/ethernet/huawei/hinic/hinic_hw_qp.c
> index 967c993d5303..bbf9bdd0ee3e 100644
> --- a/drivers/net/ethernet/huawei/hinic/hinic_hw_qp.c
> +++ b/drivers/net/ethernet/huawei/hinic/hinic_hw_qp.c
> @@ -532,7 +532,7 @@ void hinic_task_set_inner_l3(struct hinic_sq_task *task,
>  }
>
>  void hinic_task_set_tunnel_l4(struct hinic_sq_task *task,
> -                             enum hinic_l4_offload_type l4_type,
> +                             enum hinic_l4_tunnel_type l4_type,
>                               u32 tunnel_len)
>  {
>         task->pkt_info2 |= HINIC_SQ_TASK_INFO2_SET(l4_type, TUNNEL_L4TYPE) |
> diff --git a/drivers/net/ethernet/huawei/hinic/hinic_hw_qp.h b/drivers/net/ethernet/huawei/hinic/hinic_hw_qp.h
> index a0dc63a4bfc7..038522e202b6 100644
> --- a/drivers/net/ethernet/huawei/hinic/hinic_hw_qp.h
> +++ b/drivers/net/ethernet/huawei/hinic/hinic_hw_qp.h
> @@ -160,7 +160,7 @@ void hinic_task_set_inner_l3(struct hinic_sq_task *task,
>                              u32 network_len);
>
>  void hinic_task_set_tunnel_l4(struct hinic_sq_task *task,
> -                             enum hinic_l4_offload_type l4_type,
> +                             enum hinic_l4_tunnel_type l4_type,
>                               u32 tunnel_len);
>
>  void hinic_set_cs_inner_l4(struct hinic_sq_task *task,
> --
> 2.19.1
>


-- 
Thanks,
~Nick Desaulniers
