Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C74FECE560
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 17:30:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CAC1E214DC
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 17:30:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mx3kAHG5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CAC1E214DC
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728261AbeIQW6W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 18:58:22 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:37847 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726865AbeIQW6V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 18:58:21 -0400
Received: by mail-pf1-f194.google.com with SMTP id h69-v6so7885780pfd.4
        for <linux-kernel@vger.kernel.org>; Mon, 17 Sep 2018 10:30:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DvnclQHc/h09H2TJyTKF0PFoOdtSmCi7Spg7y7giy/w=;
        b=mx3kAHG5wBmDo1IjrgH9uwNM6/kX9kfMrIfz5fwKbuNKEW7M2ctiwXp65X+KIGYesC
         Ms+g5rlW4uthMD3d3qWlTo51qATCIovKtrwy+Q2VWbOBiHTHqvsZCOByTj+YE6Qd/rhd
         oLEyCQ6KeTdtyGEG79eEdZMxag2PYMCm5/CFa7pHogSTRU2hqDRDMxzQV9NF6EVrb60z
         J2LMmVoE4o38ZW5606wKEgjDuzyQLDgXjYvwzvHeNRJa7Hr1qoiW0u8tWlBDNxGapgAP
         0+DwtLdgQZdtBbiFoy1m4Q93ilxWVniePK+gCtpCfQDICjEdDcksqnesfhiLd+mZ6rYK
         A6IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DvnclQHc/h09H2TJyTKF0PFoOdtSmCi7Spg7y7giy/w=;
        b=JtTehvjeyx1dEiGIjNjfQkNjhNhg2XEvnlgRDIYMN7IRUVRhdY4AofpRTgWaNIc5t4
         J5gmTFY8+0bp+Lqv9j0NFwxBJdGAmHbHxBJ/lJK3LIOPuXXeXX7LI8MNIayXvnwz+vEH
         Z5CTrjmDuJQJwWCBlqwUGBpLb5h8OnKW+sUhYAw1qsuISjvUfErzfBNqezdaY8HMdVXr
         KsEyxonHFeek6/NtpoPEl/qbGhCoTvWmn6qF0AXjEuBWljT15Tjj8dOGK+Dn7OYpqqX8
         YkCPkoHQfPlGJA/32NuWYWLyCfCDwJAcQXd5k4L24RltiVFPerShl7U+9GBLZWDCR/XK
         NusQ==
X-Gm-Message-State: APzg51B1cwRX3vL0FmRM5mH4wNf61kWTe1O38/fE6YbJHmWhy4sDFwcV
        Jz3JonV3wmcHRdhv9KeGRuU2a6wqJu8qc/EBwCZsZw==
X-Google-Smtp-Source: ANB0Vdbeg8IayW0erQnKS7z0PbvTcOcLvvgQKtaLUvHbYo/I0eNbFs8d5GUKK6kSgyCde3DmQDZRYCvPii2uxmnHvnk=
X-Received: by 2002:a63:1921:: with SMTP id z33-v6mr24847433pgl.302.1537205401763;
 Mon, 17 Sep 2018 10:30:01 -0700 (PDT)
MIME-Version: 1.0
References: <20180915063645.31295-1-natechancellor@gmail.com>
In-Reply-To: <20180915063645.31295-1-natechancellor@gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Mon, 17 Sep 2018 10:29:50 -0700
Message-ID: <CAKwvOdmi3CxLNRGH7bWgNR5eK3p5eB_U4OsDwLPkuaDgA74JtA@mail.gmail.com>
Subject: Re: [PATCH] scsi: mptfusion: Remove unnecessary parentheses and
 simplify null checks
To:     Nathan Chancellor <natechancellor@gmail.com>
Cc:     sathya.prakash@broadcom.com, chaitra.basappa@broadcom.com,
        suganath-prabu.subramani@broadcom.com,
        MPT-FusionLinux.pdl@broadcom.com, linux-scsi@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 14, 2018 at 11:36 PM Nathan Chancellor
<natechancellor@gmail.com> wrote:
>
> Clang warns when multiple pairs of parentheses are used for a single
> conditional statement.
>
> drivers/message/fusion/mptbase.c:338:11: warning: equality comparison
> with extraneous parentheses [-Wparentheses-equality]
>         if ((ioc == NULL))
>              ~~~~^~~~~~~
> drivers/message/fusion/mptbase.c:338:11: note: remove extraneous
> parentheses around the comparison to silence this warning
>         if ((ioc == NULL))
>             ~    ^      ~
> drivers/message/fusion/mptbase.c:338:11: note: use '=' to turn this
> equality comparison into an assignment
>         if ((ioc == NULL))
>                  ^~
>                  =
> drivers/message/fusion/mptbase.c:342:12: warning: equality comparison
> with extraneous parentheses [-Wparentheses-equality]
>         if ((pdev == NULL))
>              ~~~~~^~~~~~~
> drivers/message/fusion/mptbase.c:342:12: note: remove extraneous
> parentheses around the comparison to silence this warning
>         if ((pdev == NULL))
>             ~     ^      ~
> drivers/message/fusion/mptbase.c:342:12: note: use '=' to turn this
> equality comparison into an assignment
>         if ((pdev == NULL))
>                   ^~
>                   =
> 2 warnings generated.
>
> Remove them and while we're at it, simplify the NULL checks as '!var' is
> used more than 'var == NULL'.
>
> Reported-by: Nick Desaulniers <ndesaulniers@google.com>
> Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>

Nathan,
Thanks for this patch.
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>

> ---
>  drivers/message/fusion/mptbase.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/message/fusion/mptbase.c b/drivers/message/fusion/mptbase.c
> index dc1e43a02599..ba551d8dfba4 100644
> --- a/drivers/message/fusion/mptbase.c
> +++ b/drivers/message/fusion/mptbase.c
> @@ -335,11 +335,11 @@ static int mpt_remove_dead_ioc_func(void *arg)
>         MPT_ADAPTER *ioc = (MPT_ADAPTER *)arg;
>         struct pci_dev *pdev;
>
> -       if ((ioc == NULL))
> +       if (!ioc)
>                 return -1;
>
>         pdev = ioc->pcidev;
> -       if ((pdev == NULL))
> +       if (!pdev)
>                 return -1;
>
>         pci_stop_and_remove_bus_device_locked(pdev);
> --
> 2.18.0
>


-- 
Thanks,
~Nick Desaulniers
