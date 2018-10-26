Return-Path: <SRS0=FPao=NG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A544BC6786E
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 15:49:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5984B20665
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 15:49:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Bkt3CilG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5984B20665
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727573AbeJ0A04 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Oct 2018 20:26:56 -0400
Received: from mail-it1-f196.google.com ([209.85.166.196]:54567 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726113AbeJ0A04 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Oct 2018 20:26:56 -0400
Received: by mail-it1-f196.google.com with SMTP id l191-v6so2055259ita.4;
        Fri, 26 Oct 2018 08:49:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=12bmE5QnwITRe19O+4Lh8FzmnBXQCECHHswUc0rYW9I=;
        b=Bkt3CilGSZANlYi1+AqA15/MuOk6WAtGe5lzuk0LSwRpJuIAqvcCf5gDDfqdPgLU41
         c/o1cOTsssDyHPMA3FuQJKxbgtczj7yNMftO+91ajSfk3AqllaS0ycUDkeQMl6PUntor
         UTG5os7PuXcFcdGtwxm//IhiUm1ZyCoqxg1HNyFZwVTLK1NriANRrFce175rCnPnHV9x
         x6u9Ekoxw0jN6iG12tJwqV5o5Bs2WsCHgDArykaS23UoV25RkjVQeBiCkEYqxYWyc/VG
         b9MLyaIcxPdaoq3zVvuYuKAbUF/pT6UJJfYZ1k3Oe71s8aH4nV2K9sO8w8ryYSCyPGpp
         fa+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=12bmE5QnwITRe19O+4Lh8FzmnBXQCECHHswUc0rYW9I=;
        b=VMI0sjjBXtXjoxYhgCFsSAa9enp/yBD3oflLa9cb+S39nsg9SyLp8nJLGQGF1n/JEi
         MHxlcJWenUlf8IfhrJkNJG52L7cw+pDz3Nb0STI1GPy7tWaCOx8Y5pLFuXNN6bYDPCi2
         SP4OoOT/6fTi7cLEDizNSTGW+ti1l+rGOGneL+KRHupZrP3ylUSXBYKrfyxj4RGLtSYV
         wZiSI4+PWpzORbbHhaYYvXeKBYsFzqj9E5mKIrx9HVkllBNklZSNl7GB2yZyMSFiQwz2
         F5IrYtngPOL600kgt+ephPg71tomVziceemX/hHoqCHXPKk6dLzJ++qsGmeBlVBcrfoj
         3mrw==
X-Gm-Message-State: AGRZ1gLLD4+eV8iiWs2mik2ysaIV5xC2G5yWy44FdMMH9Ah9rszJXS86
        okR2xrF8IXZcAesQvBCO53PtBAB9NU3GtCXtkSc=
X-Google-Smtp-Source: AJdET5crwffZ5m8dA9R2lOop4dS0zZPzb1FytjJnUq8mhyD1BlUj1WRXqcF8C/zj9C+D3j6MKPWgBxIqEdZRlWB1fks=
X-Received: by 2002:a02:8a74:: with SMTP id e49-v6mr2978673jal.81.1540568962339;
 Fri, 26 Oct 2018 08:49:22 -0700 (PDT)
MIME-Version: 1.0
References: <CAEAjamtxZRiFUYb4re3jRf9naoSyJO7sskChfEgcBh-m-uEKWQ@mail.gmail.com>
 <1540567279.66186.99.camel@acm.org>
In-Reply-To: <1540567279.66186.99.camel@acm.org>
From:   Kyungtae Kim <kt0755@gmail.com>
Date:   Fri, 26 Oct 2018 11:49:10 -0400
Message-ID: <CAEAjamuJjjyWFw9Fn4_6-97WDhpWTfvLNQdPHT-AZ843yese9g@mail.gmail.com>
Subject: Re: [PATCH] floppy: Avoid memory access beyond the array bounds in setup_rw_floppy()
To:     bvanassche@acm.org
Cc:     Jens Axboe <axboe@kernel.dk>, jikos@kernel.org,
        Byoungyoung Lee <lifeasageek@gmail.com>,
        DaeRyong Jeong <threeearcat@gmail.com>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thank you for your reply.

> Against which kernel tree did you prepare this patch? Just above the code
> you want to insert I found the following:
>
>         if (ptr->cmd_count > 33) ...

Yes, I saw that code as well. But I find out there is no more
additional code relevant to it.
So I guess, that is for like reserved ones for the future work (e.g.,  RESTORE).
And such code cannot solve this crash issue because the crash happens
even when cmd_count is less than 33.

> or not? Anyway, I don't think it makes sense first to compare cmd_count against
> 33 and next to compare it against 16 ...

I agree. So far, seems that removing if (ptr->cmd_count > 33) looks better.
Please let me know if you have better ideas.

> This comparison looks suspicious to me. Almost every comparison of the type
> "... > ARRAY_SIZE()" I have seen so far was wrong and should be changed into
> "... >= ARRAY_SIZE()" instead.

Well, let me check this part again.

Thanks,
Kyungtae Kim
