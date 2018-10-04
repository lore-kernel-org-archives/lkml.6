Return-Path: <SRS0=SFDS=MQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADEB0C64EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 14:10:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E5982082A
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 14:10:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GNC0YrS/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5E5982082A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727753AbeJDVD6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Oct 2018 17:03:58 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:36824 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727355AbeJDVD5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Oct 2018 17:03:57 -0400
Received: by mail-wm1-f66.google.com with SMTP id a8-v6so5186033wmf.1;
        Thu, 04 Oct 2018 07:10:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EP+hAHkqhC4uHVQ+14r5ce+EW1DJ7+BFMjEeH7ku7Ow=;
        b=GNC0YrS/fivTUvcFs4FOTPGP+tygk4D+qdwmoYa66UjXxHrsiZmU0t5Q2WhLQyCa+3
         dilHxjUyFVMXvZDMbMZLXySNsdARH6o4TFNDqusdZeoE3NeYuEs80xosZ0gwDvz1VIZR
         /9KEk3s9/idMUxGtnSQBt90O1qVdnUBTHVaWMlbkfXINMrAryaqRgA12CpJ66Q1qkcOZ
         Oa7gXKnk7ge7pl0d5aoHChYi4MLHGLR2pg8C+RyGyDpF7pcriyDK8fV92srA+YFs2E6l
         md1oUgNh1dtPmh0gypFcWBj447hywL17z16Gf+yKZQBp8zStBJa4CGSjN1AZs+4PyniK
         vEPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EP+hAHkqhC4uHVQ+14r5ce+EW1DJ7+BFMjEeH7ku7Ow=;
        b=PADb40/za+sLS3nLDzEHd0TFHhs1bad9unQbA652EM+Z1XLDs8tykUdnux4JlBOOEh
         bpqqUlSHh25Ls6iveRTEJ54KFP5d2C4tq9YY8Mxn1klIdTPlId1sBhDPjVI7ROJtlBfS
         pm07niZNR0rK6lro/cHpY4BG2/Nrvcs3djic5hrta9IKy/nqNfNVPbl1XvAj9hg7DlLI
         5EaP57FKI/HA3jZR5SDftmAYQwdMGR5Rlo9wxXaf8u41a0bZhxS6YaHB8GFvrdMfVvso
         jO8rBiky/3nQonIH7NrwIpcqHgEECHPbdZB44pAqP3ZIGlQnuLZkmrMx7D0/Whre2LTb
         chRA==
X-Gm-Message-State: ABuFfojO9429S5tnljEai5t7I2wvOkrl0uO5mdCffeaX51dux330c6s2
        lBat2+w7LiKWzEa/TH9ViIo8jvNPhbJo1eLiJywTbQ==
X-Google-Smtp-Source: ACcGV62b9D5Jd54HohKbxEqVY76PvJ4l8tsQNOXFddfeUe8fW8Y1xrttBCKfYpHp2toclw+1jNf2mFbP4ogrxikOW84=
X-Received: by 2002:a1c:3745:: with SMTP id e66-v6mr4642131wma.142.1538662227225;
 Thu, 04 Oct 2018 07:10:27 -0700 (PDT)
MIME-Version: 1.0
References: <20181004134223.17735-1-michael@schupikov.de>
In-Reply-To: <20181004134223.17735-1-michael@schupikov.de>
From:   Richard Weinberger <richard.weinberger@gmail.com>
Date:   Thu, 4 Oct 2018 16:10:14 +0200
Message-ID: <CAFLxGvw6tsdO2rqH1XzW84jN5kRqjzMP+cLtKhkDU1MtYUgJow@mail.gmail.com>
Subject: Re: [PATCH] kernel/sysctl.c: remove duplicated include
To:     michael@schupikov.de
Cc:     mcgrof@kernel.org, Kees Cook <keescook@chromium.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 4, 2018 at 3:48 PM Michael Schupikov <michael@schupikov.de> wrote:
>
> Remove one include of <linux/pipe_fs_i.h>.
> No functional changes.
>
> Signed-off-by: Michael Schupikov <michael@schupikov.de>
> ---
>  kernel/sysctl.c | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/kernel/sysctl.c b/kernel/sysctl.c
> index cc02050fd0c4..523cb36b72eb 100644
> --- a/kernel/sysctl.c
> +++ b/kernel/sysctl.c
> @@ -66,7 +66,6 @@
>  #include <linux/kexec.h>
>  #include <linux/bpf.h>
>  #include <linux/mount.h>
> -#include <linux/pipe_fs_i.h>
>
>  #include <linux/uaccess.h>
>  #include <asm/processor.h>

Reviewed-by: Richard Weinberger <richard@nod.at>

-- 
Thanks,
//richard
