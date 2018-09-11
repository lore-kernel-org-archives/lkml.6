Return-Path: <SRS0=LZPJ=LZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B553C04ABB
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 21:55:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BFC6620880
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 21:55:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UT22nsCt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BFC6620880
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728051AbeILC4b (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Sep 2018 22:56:31 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:42296 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727775AbeILC4b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Sep 2018 22:56:31 -0400
Received: by mail-pl1-f195.google.com with SMTP id g23-v6so11931864plq.9
        for <linux-kernel@vger.kernel.org>; Tue, 11 Sep 2018 14:55:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nTp56QDYtmSp2uFalGCFyEh4UBBMEBvlTYyxuJq9Xg0=;
        b=UT22nsCtGOC9bHkXfr5aQU3/3LHEaHJlnylHRGFwmZ26aPfAtSvAZOc/tZ6ZX6usbk
         CRIzO/5u6Zsyw+4jycEW/bBHvbvEjVisbns2GN6+R5UoHz+gaRgVeUTw50ci2bg7ufgq
         HeDSO0qEEw3Q0zTw31lrZMsVHsMhUOJlUNbmQFOzWaPfiWR0RN+wDwh6PXZXg/0bCaEF
         QH2/c20rKNyesTKNQVaH5YNU/hEjOcR+DZi8clihihEj8yXf1zM1T3joDkUWmuK8pyXQ
         TzfcRF5mxP4asI2MDssbQY6IzwXHaPyb315oJpM2+pDd9pK7ueL6dRg8Cv6L6yFDCSQN
         8H2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nTp56QDYtmSp2uFalGCFyEh4UBBMEBvlTYyxuJq9Xg0=;
        b=O7DV+B3XkefyFyky8ZltIMV6CxJI3hYLvc+0F2zL2ONRVtAyz4jcDJxpRMEDZX5jcV
         +nOprLea7ftFoLL+07jwjEZkL1b4zmc+2UL62uz35qTWPwmTpZ4M6Bdh/Ji07XVUvlsT
         slI68R5na1/Mo2xUvwOTbaZFh7TLkwQeScMngT6WO3sQQKgP4UGAI/fFhOPyIsgOIuV3
         XPPxc+v92MHX2vIbQFLitanu3OKwf5cPFGvfrdBVqxZchPP06Q1dG6O42v61jORy0Wp3
         soBHQ+GuXPno0VoAzfguvzBGnL93kqoBjIbZD2DUGrHqzYuW22mClT6dxu8M7bzm4zuU
         UiYw==
X-Gm-Message-State: APzg51CPhz1hka72Ef80+jfEKy8cqzphhamLnK3R2L60Uty4zfrZ89K/
        KKSr2HkL/o/A8eW8RSMILIt6I9DfOT8sWTfoAHXNcA==
X-Google-Smtp-Source: ANB0VdYpe11dYOW84Gnjsa3jCA5znq9cKr3XxSdXX7Aa/QOOx1uPthY0cg3NTK63/H97IZQ6WBqCeXtGiFT6wzZ/iQQ=
X-Received: by 2002:a17:902:561:: with SMTP id 88-v6mr29077441plf.320.1536702911844;
 Tue, 11 Sep 2018 14:55:11 -0700 (PDT)
MIME-Version: 1.0
References: <20180911215040.7906-1-natechancellor@gmail.com>
In-Reply-To: <20180911215040.7906-1-natechancellor@gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Tue, 11 Sep 2018 14:55:00 -0700
Message-ID: <CAKwvOdk97dLyTAyt6g29HcQ-moPXqg6WpVHBwSRivDfFvSPREg@mail.gmail.com>
Subject: Re: [PATCH] rsxx: Remove unnecessary parentheses
To:     Nathan Chancellor <natechancellor@gmail.com>
Cc:     josh.h.morris@us.ibm.com, pjk1939@linux.vnet.ibm.com,
        axboe@kernel.dk, linux-block@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 11, 2018 at 2:51 PM Nathan Chancellor
<natechancellor@gmail.com> wrote:
>
> Clang warns when more than one set of parentheses is used for a
> single conditional statement:
>
> drivers/block/rsxx/cregs.c:279:15: warning: equality comparison with
> extraneous parentheses [-Wparentheses-equality]
>         if ((cmd->op == CREG_OP_READ)) {
>              ~~~~~~~~^~~~~~~~~~~~~~~
> drivers/block/rsxx/cregs.c:279:15: note: remove extraneous parentheses
> around the comparison to silence this warning
>         if ((cmd->op == CREG_OP_READ)) {
>             ~        ^              ~
> drivers/block/rsxx/cregs.c:279:15: note: use '=' to turn this equality
> comparison into an assignment
>         if ((cmd->op == CREG_OP_READ)) {
>                      ^~
>                      =
> 1 warning generated.
>
> Reported-by: Nick Desaulniers <ndesaulniers@google.com>
> Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
> ---
>  drivers/block/rsxx/cregs.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/block/rsxx/cregs.c b/drivers/block/rsxx/cregs.c
> index c148e83e4ed7..d9a8758682c9 100644
> --- a/drivers/block/rsxx/cregs.c
> +++ b/drivers/block/rsxx/cregs.c
> @@ -276,7 +276,7 @@ static void creg_cmd_done(struct work_struct *work)
>                 st = -EIO;
>         }
>
> -       if ((cmd->op == CREG_OP_READ)) {
> +       if (cmd->op == CREG_OP_READ) {
>                 unsigned int cnt8 = ioread32(card->regmap + CREG_CNT);
>
>                 /* Paranoid Sanity Checks */
> --
> 2.18.0
>

LGTM
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>

-- 
Thanks,
~Nick Desaulniers
