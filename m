Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6290ECE560
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 17:45:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 68FE1214DA
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 17:45:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZmeyISyw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 68FE1214DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728131AbeIQXNs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 19:13:48 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:33591 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726865AbeIQXNs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 19:13:48 -0400
Received: by mail-pl1-f195.google.com with SMTP id b97-v6so2559708plb.0
        for <linux-kernel@vger.kernel.org>; Mon, 17 Sep 2018 10:45:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=goskRjiAX0H39Z3gxiBu0gUPukO/qoqjPSnSRZysEJo=;
        b=ZmeyISywnYVvWlyZ8UCqueKMee/cW1TXms6YCnLiSisrqwOAKSAZi7LTg2LSNTxpce
         hXSOzxWNOz8yv3ct5kSuQDMKQy7wSUxVOCh0UVFBiGC10+wO0qBbbqdVuJJ8ckmKKmzP
         qFkOLI7vgIn6VyLjl6srtJGSh1Q38rtCso+21Zaka1WcqLmd462afkaWy5w64bCSnkrr
         vSCzZenwpENaE/I+e4cieTt8oN9azhToVtKFZI9czkX0yNhTzJ9i2FbVdDy8j9qmhPLR
         a3Jiis6a8KIJ4CU2d2iX8VKSD/4N359/T8zM/JnF/UMP/QvfPJ0uwfhQ8Cp4B+uFAt2T
         Od6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=goskRjiAX0H39Z3gxiBu0gUPukO/qoqjPSnSRZysEJo=;
        b=aIptQcQovKPNq3rvW3+bHaws5uocK9R01asQOG7RHlEmCkgQ2h5mWEhQKBdDCwyjwR
         J/zH44FI7A5Q2kbWlUtx22+6HgmSUM5TIcu5yF6NlzTZ3up3RlAF8Su58BsseD3DDoJf
         KR/Wnx8NdLX+wqos7ucDF3N3AuEiUAkWR8Seh/1fymW3va2yOm4iCH979c5NQZHnkVYv
         Ib9R7wjH4cWzobQL/qcbmQ+nmI5MHpD5Ughp/n5V07/nRcAb1MtruKW1Y1eemj8vTFZ2
         TagI87VDI2aSIUBBncCPyS9IQKhwOnUOkpcKYTBFsRxHOusiHxNLyxdKZZQ42RO0Ubmy
         dokQ==
X-Gm-Message-State: APzg51Be792+1jxdONWMijms/705mRr5inXVRNOAkqYZz/H3LTbiGrL0
        CsLA+6OKhHuTnJmRsg94HFoLvL+VjTCQwXoRDybjJg==
X-Google-Smtp-Source: ANB0VdatOHFeG/ix1XbQc5yGtyKm5AZYVdF28CeztKBeOOm8hCEVizKuRCCLIk/W2iXiXCsf8ZfuOOisJNKfNhqmH7A=
X-Received: by 2002:a17:902:708a:: with SMTP id z10-v6mr26196935plk.229.1537206324561;
 Mon, 17 Sep 2018 10:45:24 -0700 (PDT)
MIME-Version: 1.0
References: <20180915060612.21812-1-natechancellor@gmail.com>
In-Reply-To: <20180915060612.21812-1-natechancellor@gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Mon, 17 Sep 2018 10:45:13 -0700
Message-ID: <CAKwvOd=Mx7T4tMAC0v46b=9BrkOS8MNxprkFWEQP5Bz6rZvvxg@mail.gmail.com>
Subject: Re: [PATCH] [media] bt8xx: Remove unnecessary self-assignment
To:     Nathan Chancellor <natechancellor@gmail.com>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 14, 2018 at 11:06 PM Nathan Chancellor
<natechancellor@gmail.com> wrote:
>
> Clang warns when a variable is assigned to itself.
>
> drivers/media/pci/bt8xx/bttv-driver.c:2043:13: warning: explicitly
> assigning value of variable of type '__s32' (aka 'int') to itself
> [-Wself-assign]
>         min_height = min_height;
>         ~~~~~~~~~~ ^ ~~~~~~~~~~
> 1 warning generated.
>
> There doesn't appear to be any good reason for this and this statement
> was added in commit e5bd0260e7d3 ("V4L/DVB (5077): Bttv cropping
> support") back in 2007. Just remove it.
>
> Reported-by: Nick Desaulniers <ndesaulniers@google.com>
> Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
> ---
>
> I'm not sure if the comment should have been removed as well. If it
> does, I can easily send a v2.

I think the comments are actually reversed; the comment about max
scale should be for max_height and min scale should be for min_height.

Self assignment usually is used to silence unused variable warnings,
which doesn't look to be the case here.

Not sure about the comment; I think it's good to keep it, just unsure
of the exact statement it applies to.  Maybe Mauro has thoughts on
that?

Either way, you can add my reviewed by tag to this or a v2 that
moves/removes the comment, though I think this patch may just be fine.
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>

Thanks for the patch.

>
> Thanks!
>
>  drivers/media/pci/bt8xx/bttv-driver.c | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/drivers/media/pci/bt8xx/bttv-driver.c b/drivers/media/pci/bt8xx/bttv-driver.c
> index 413bf287547c..b2cfcbb0008e 100644
> --- a/drivers/media/pci/bt8xx/bttv-driver.c
> +++ b/drivers/media/pci/bt8xx/bttv-driver.c
> @@ -2040,7 +2040,6 @@ limit_scaled_size_lock       (struct bttv_fh *               fh,
>         max_width = max_width & width_mask;
>
>         /* Max. scale factor is 16:1 for frames, 8:1 for fields. */
> -       min_height = min_height;
>         /* Min. scale factor is 1:1. */
>         max_height >>= !V4L2_FIELD_HAS_BOTH(field);
>
> --
> 2.18.0
>


-- 
Thanks,
~Nick Desaulniers
