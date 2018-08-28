Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2BCEC433F4
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 22:03:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 650932087E
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 22:03:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="REiKhoDB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 650932087E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727298AbeH2B5L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 21:57:11 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:33552 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727117AbeH2B5K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 21:57:10 -0400
Received: by mail-wm0-f68.google.com with SMTP id i134-v6so2934847wmf.0
        for <linux-kernel@vger.kernel.org>; Tue, 28 Aug 2018 15:03:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=hJUC4mMiu2eCKoInWozFRORjuY9pN0SwQ4JmN7lgORM=;
        b=REiKhoDB47AiU1gvPy6en5uvMlPeWBb1gTclTAOVRWZFScr1f/N9mj+T+b9Kc/bD99
         vC/3gb1VkWBPY2IdcqGHIYv4mZbVOAb68NYwbuNwoN2QJBd/Ej1kXK7zn9redC3yupuv
         i9D7fuwyRAgV7Qytyq5zQQIP6EjX72TYo1x2bu8jxuFDdCm8zHZBm6WrsdXmgjbiV/XG
         jCWuiCyLryxP0af58Y96lvJnvlDrPMxMJB5JNFTB4VNbE0tkfzmuPwJnKrj+KdO8aYxr
         DNqQvghMzH8xrg1oyu1RGmqnUi8LoFH3qKewqkZoTCUJPPELXyrW2Yo17DX8xTqEGAon
         rNlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=hJUC4mMiu2eCKoInWozFRORjuY9pN0SwQ4JmN7lgORM=;
        b=Zh/6LZuSSTNcxQm8XRAdIkmg0FFnrvfGgRgfC2FgQEBlOswS8sRoSUlzgqRD/KrW+A
         M3JQu17UxzSk5iJgrkgt/HOOdwW1bnPet9RQxQSgmoC/Ztz+P3HbUXnXzTGsrQ1LzIae
         DPlIi0HCP7moRevpcB34MbRlt85WCvIHTn1ExWwABx8/czjWrcdfWaCcqR8HvlKD2Rln
         n06SAMesJz6tzN1fIccPqpOELMzb1LNN0WozMoBklevPgPDm0ciKQM93gNzzsbtG4f4G
         44x2S3rF/xopZZ1fuai7mycpHPiWhwdjzSzpyn3PfTx2kALnCIe+YbF1pt/uA5iXBmwW
         CAOw==
X-Gm-Message-State: APzg51DGkf5B1N3TKOTL4ia4AlT/LnGGpGbBfj0GGRgUEF9LTGa0qxtM
        XBTqK49Bm6hWHj++OV1H3TU=
X-Google-Smtp-Source: ANB0VdZZDbvzGDrKuKAfh1gpkPvi5dpYmSVTCfM93PFKE15HM35XYpfFPL4PxctQ/7taDUNWdWN7hg==
X-Received: by 2002:a1c:1252:: with SMTP id 79-v6mr2436355wms.70.1535493809836;
        Tue, 28 Aug 2018 15:03:29 -0700 (PDT)
Received: from flashbox ([2a01:4f8:10b:24a5::2])
        by smtp.gmail.com with ESMTPSA id 184-v6sm4399262wmv.6.2018.08.28.15.03.28
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 28 Aug 2018 15:03:29 -0700 (PDT)
Date:   Tue, 28 Aug 2018 15:03:27 -0700
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Ray Clinton <mr.ray.clinton@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arve =?iso-8859-1?B?SGr4bm5lduVn?= <arve@android.com>,
        Todd Kjos <tkjos@android.com>,
        Martijn Coenen <maco@android.com>,
        Alistair Strachan <astrachan@google.com>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        trivial@kernel.org
Subject: Re: [PATCH] Trivial numbering change in comments.
Message-ID: <20180828220327.GA22320@flashbox>
References: <CAPMnawu33A5L5a6a00tZ+_9cQxyN97OwXK0sO9Q60+YvR=Yg_A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPMnawu33A5L5a6a00tZ+_9cQxyN97OwXK0sO9Q60+YvR=Yg_A@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 28, 2018 at 04:08:18PM -0400, Ray Clinton wrote:
> I'm trying to get my feet wet in kernel dev and while working on a patch
> I noticed in a lengthy comment block that the number "2" was skipped
> in a description of the steps of a protocol. This patch is simply correcting
> this. This is for 4.18.0.
> 
> It is a very trivial patch, but this is my first actual try at one and
> thought I
> might start out small (and I don't think you can get smaller than a single
>  character change). Any and all advice (about this patch, email, or
> anything else) is very welcome.
> 
> Thanks so much!
> Ray
> 
> Signed-off-by: Ray Clinton <mr.ray.clinton@gmail.com>
> ---
>  drivers/staging/android/uapi/vsoc_shm.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/android/uapi/vsoc_shm.h
> b/drivers/staging/android/uapi/vsoc_shm.h
> index 6291fb2..0301172 100644
> --- a/drivers/staging/android/uapi/vsoc_shm.h
> +++ b/drivers/staging/android/uapi/vsoc_shm.h
> @@ -92,7 +92,7 @@ struct fd_scoped_permission_arg {
>   *    The transmitter can choose any appropriate hashing algorithm, including
>   *    hash = futex_offset & ((1 << num_nodes_lg2) - 1)
>   *
> - * 3. The transmitter should atomically compare and swap futex_offset with 0
> + * 2. The transmitter should atomically compare and swap futex_offset with 0
>   *    at hash. There are 3 possible outcomes
>   *      a. The swap fails because the futex_offset is already in the table.
>   *         The transmitter should stop.
> -- 
> 2.7.4

Hi Ray,

Welcome to Linux kernel development and good first patch. Just a few
words of advice for any future patches that you submit!

Make sure to include what subsystem you are modifying in the commit
title. You can see examples by using 'git log --online <path>'; for
this subsystem, it's usually "staging: android: vsoc:", making this
patch's title "staging: android: vsoc: Trivial numbering change in comments".

I'd recommend keeping author details (such as your experience and other
info) in-between the '---' and the file names modified in the patch so
that they can be read by the maintainers/reviewers but not added to the
commit message by 'git am'. This is also helpful for adding comments
like what changed between versions of the patch or maybe something like
"I'm not sure this change is correct, it could also be done via <method>,
I'd like some review".

Small nits in the grand scheme of things but they'll come in handy as
you develop more and more complex patches and series.

Reviewed-by: Nathan Chancellor <natechancellor@gmail.com>

Cheers!
Nathan
