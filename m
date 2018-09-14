Return-Path: <SRS0=Jh2l=L4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C551FC6182
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 17:35:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D007520882
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 17:35:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vhAiJ1Uh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D007520882
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728460AbeINWuh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Sep 2018 18:50:37 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:37094 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727118AbeINWuh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Sep 2018 18:50:37 -0400
Received: by mail-pl1-f194.google.com with SMTP id f1-v6so4514635plt.4
        for <linux-kernel@vger.kernel.org>; Fri, 14 Sep 2018 10:35:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2lekJxPl5gyuXRyVnA66Vi63buFs4rj3yjnplqztKwg=;
        b=vhAiJ1UhfFOUsyZY3vGkMqsbMG1SZJKW93TymLoP4wA2Nst52qJlqWlG1ZNc1ZCx5n
         znvt1LZz86fJgfNhEMViALmDSEjYV26RXCO72CF9LYhaEgQcO1mQnq2hGVTKyef7/vTd
         cJOz+zMGPBwtH1Yq5VUOOZefZ00FwDwNBofxDaC+jFmLHRrKqYuErHXCko5h37Dk5mbN
         q+oSlcK8m0wgGSC3pmg7DYgjnI+yrfUaJNWt6aMS3TP1CBq/IYHxC6Ria3+B+9PVMvu2
         QiPGDcsIhLU8bxO1pctoXF81523jqRomGLr1gUY1J27+8KoBuAvVlGyNkAJlnNJyPVXe
         U6Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2lekJxPl5gyuXRyVnA66Vi63buFs4rj3yjnplqztKwg=;
        b=HfyzrpHsZ2rLNxmnCDYixClj/B5JxwkYBRSd3cec1zPuuVKnmsuR6nV91xlWKR2OFa
         C0YU88UsyrnseQ4UvSg/nBNOjJEip/54Lxf1R0xSGEgLz/LPF2LUXxqSkDwyQpox/sTH
         cpQaZW17byXdUKonAfDJNKSX0oFexvTgjOLewAq82fczFvVqLU6NpLt0d5sywyntOaPJ
         Sj2u7oEajDu6lGUwkx6vzsYBpoQUSGYhxMqlijsiGAKGTqvnGZT8hxY2Hrb+x4zb8aga
         m3XkKB3iDhKhXIJ+y8Xg49h7SdXK/Jei9GFylRNMm3D85KAqLIO+x6RvWmGnUay3QGQR
         v9+w==
X-Gm-Message-State: APzg51BId1ElMsjhyUkoAUP6L/rXZ4HWQ2hsZ4mD07mjg48W7SJWH0Lp
        t1u7EMdK3BtqG+LN5/5OCDpFk+v3TMx6jUkeso2Tpw==
X-Google-Smtp-Source: ANB0VdavPHongYfq4usbQsOuemlfti2+PMVDNlaq4Ht0sqrt0231JEREOEvbyxzQFLdG3wl67VzPqprzx1pXZ04dQQ0=
X-Received: by 2002:a17:902:7102:: with SMTP id a2-v6mr13238028pll.217.1536946507607;
 Fri, 14 Sep 2018 10:35:07 -0700 (PDT)
MIME-Version: 1.0
References: <20180914050047.7079-1-natechancellor@gmail.com>
In-Reply-To: <20180914050047.7079-1-natechancellor@gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Fri, 14 Sep 2018 10:34:56 -0700
Message-ID: <CAKwvOdn_nNzStndVu3efLrv6x1wQTC4+A2bW5fEn37NGrWtqLg@mail.gmail.com>
Subject: Re: [PATCH] drbd: Change drbd_request_detach_interruptible's return
 type to int
To:     Nathan Chancellor <natechancellor@gmail.com>
Cc:     philipp.reisner@linbit.com, lars.ellenberg@linbit.com,
        axboe@kernel.dk, drbd-dev@lists.linbit.com,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 13, 2018 at 10:01 PM Nathan Chancellor
<natechancellor@gmail.com> wrote:
>
> Clang warns when an implicit conversion is done between enumerated
> types:
>
> drivers/block/drbd/drbd_state.c:708:8: warning: implicit conversion from
> enumeration type 'enum drbd_ret_code' to different enumeration type
> 'enum drbd_state_rv' [-Wenum-conversion]
>                 rv = ERR_INTR;
>                    ~ ^~~~~~~~
>
> drbd_request_detach_interruptible's only call site is in the return
> statement of adm_detach, which returns an int. Change the return type of
> drbd_request_detach_interruptible to match, silencing Clang's warning.

Yeah with one call site that passes along the return value, that's the
right fix to IMO.
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>

>
> Reported-by: Nick Desaulniers <ndesaulniers@google.com>
> Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
> ---
>  drivers/block/drbd/drbd_state.c | 6 ++----
>  drivers/block/drbd/drbd_state.h | 3 +--
>  2 files changed, 3 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/block/drbd/drbd_state.c b/drivers/block/drbd/drbd_state.c
> index 0813c654c893..b452359b6aae 100644
> --- a/drivers/block/drbd/drbd_state.c
> +++ b/drivers/block/drbd/drbd_state.c
> @@ -688,11 +688,9 @@ request_detach(struct drbd_device *device)
>                         CS_VERBOSE | CS_ORDERED | CS_INHIBIT_MD_IO);
>  }
>
> -enum drbd_state_rv
> -drbd_request_detach_interruptible(struct drbd_device *device)
> +int drbd_request_detach_interruptible(struct drbd_device *device)
>  {
> -       enum drbd_state_rv rv;
> -       int ret;
> +       int ret, rv;
>
>         drbd_suspend_io(device); /* so no-one is stuck in drbd_al_begin_io */
>         wait_event_interruptible(device->state_wait,
> diff --git a/drivers/block/drbd/drbd_state.h b/drivers/block/drbd/drbd_state.h
> index ea58301d0895..cff0a34c150b 100644
> --- a/drivers/block/drbd/drbd_state.h
> +++ b/drivers/block/drbd/drbd_state.h
> @@ -162,8 +162,7 @@ static inline int drbd_request_state(struct drbd_device *device,
>  }
>
>  /* for use in adm_detach() (drbd_adm_detach(), drbd_adm_down()) */
> -enum drbd_state_rv
> -drbd_request_detach_interruptible(struct drbd_device *device);
> +int drbd_request_detach_interruptible(struct drbd_device *device);
>
>  enum drbd_role conn_highest_role(struct drbd_connection *connection);
>  enum drbd_role conn_highest_peer(struct drbd_connection *connection);
> --
> 2.18.0
>


-- 
Thanks,
~Nick Desaulniers
