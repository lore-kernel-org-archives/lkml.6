Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F611ECE560
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 17:24:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A8937214C2
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 17:24:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CCf3yxXX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A8937214C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728160AbeIQWwm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 18:52:42 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:36336 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727052AbeIQWwm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 18:52:42 -0400
Received: by mail-pg1-f194.google.com with SMTP id d1-v6so7994585pgo.3
        for <linux-kernel@vger.kernel.org>; Mon, 17 Sep 2018 10:24:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uBjWLA14X0zAS/yqvjfnlTzJlOsmNXsgwLntFdw3Ax8=;
        b=CCf3yxXXl0oNcEg+qrrLVOF7e/FdAeFEdbtou/pF9qn9yOYV0K4dzpKeLEJxCDrXOp
         7OLrGXlWcNocLkgHOgwTNSeARPuDqL8gKuWhJfh9bEPEoNN0FuVSD8zU99MXu0BlYS8T
         G0zqZDj+8vRcZyYrryQD2k7q8X6sxhiwimX1SVdUiMRBqRqsVcziHbSMlo78U3lVkS/L
         kCJWI7IYjJAtA4oRy06L6jw4gqcj3ZmZWrGvro1acD8HIdvfpptJxPQ+iq3ekysv+aTG
         kzV/ZlMGPN0ryMEmCTfuasA7ovUGt9YaHX3phS9/zV5+M2XM/wAXaUpb3eVaocThriuP
         JOow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uBjWLA14X0zAS/yqvjfnlTzJlOsmNXsgwLntFdw3Ax8=;
        b=NBsSOfB4tGSEKZ+xToeVR/+nnudHhPfqDqMp4UIFQBwChx0TvCi97axkt+5QHjq1JY
         MUgXhG3GxXLoByyc/2WskY/acP453EGNXC2iGU0pRd4biyFG/fMvF53TDwt6RMwJo4qr
         bKK2ajI8vHVbR7mnFMRCDSpMvx6Gn03u2P8275Pl5v0aS5Pv8NGeNjLm4VthBhy+ACH0
         t7+hxVRrtK47XpfdayCO3zYtoPxY8Xon3/UdkqIAA9qorMgklrJy/Gx5vGP+Bci3zsSf
         lNJxjZNIrQsTauIoB3otr6bEKoTETmuLynfjRcb3r8LsSj4Kd8en6DX++YYhv3lMDHaY
         m5hQ==
X-Gm-Message-State: APzg51CsyOGOqPMdKU1OJ67FwONAIUOIZx6ZEldo2YjbDWRFjv0t5s8d
        bFYabWhxUZCW4kiA/f3WgGIT+5v4ah4HtzH3glXL8mhe8isJEw==
X-Google-Smtp-Source: ANB0VdYtzY3I+NEKXQatTuoIag/4kCAxXtpVo0bl+AMlfBrXU8dUpg1SfsAigh+FPleLFed1S1qxvF+DJ39e3e4ud1M=
X-Received: by 2002:a63:6243:: with SMTP id w64-v6mr24706625pgb.145.1537205063048;
 Mon, 17 Sep 2018 10:24:23 -0700 (PDT)
MIME-Version: 1.0
References: <20180917073754.24048-1-joel@jms.id.au>
In-Reply-To: <20180917073754.24048-1-joel@jms.id.au>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Mon, 17 Sep 2018 10:24:11 -0700
Message-ID: <CAKwvOd=d4FdFzqimdq1os4gkk2JeeC4_-_ZbxVdkkPwd3KmuuQ@mail.gmail.com>
Subject: Re: [PATCH] ftrace: Build with CPPFLAGS to get -Qunused-arguments
To:     joel@jms.id.au
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 17, 2018 at 12:38 AM Joel Stanley <joel@jms.id.au> wrote:
>
> When building to record the mcount locations the kernel uses
> KBUILD_CFLAGS but not KBUILD_CPPFLAGS. This means it lacks
> -Qunused-arguments when building with clang, resulting in a lot of
> noisy warnings.
>
> Signed-off-by: Joel Stanley <joel@jms.id.au>
> ---
> Not sure why -Qunused-arguments is in CPP instead of KBUILD_CFLAGS. We
> could instead put it in KBUILD_CFLAGS, and not need this patch.

The preprocessor has flags that can change the definitions of macros.
So there might be unused flags there.  I'm not a fan of covering up
those warnings via -Qunused-arguments; the flags should be feature
detected via cc-option and friends rather than always added then
silenced if excessive.  That hides flags that are long dead/unused.

Thanks for this patch!
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>

>
>  scripts/Makefile.build | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/scripts/Makefile.build b/scripts/Makefile.build
> index 5a2d1c9578a0..54da4b070db3 100644
> --- a/scripts/Makefile.build
> +++ b/scripts/Makefile.build
> @@ -219,7 +219,7 @@ else
>  sub_cmd_record_mcount = set -e ; perl $(srctree)/scripts/recordmcount.pl "$(ARCH)" \
>         "$(if $(CONFIG_CPU_BIG_ENDIAN),big,little)" \
>         "$(if $(CONFIG_64BIT),64,32)" \
> -       "$(OBJDUMP)" "$(OBJCOPY)" "$(CC) $(KBUILD_CFLAGS)" \
> +       "$(OBJDUMP)" "$(OBJCOPY)" "$(CC) $(KBUILD_CPPFLAGS) $(KBUILD_CFLAGS)" \
>         "$(LD) $(KBUILD_LDFLAGS)" "$(NM)" "$(RM)" "$(MV)" \
>         "$(if $(part-of-module),1,0)" "$(@)";
>  recordmcount_source := $(srctree)/scripts/recordmcount.pl
> --
> 2.17.1
>


-- 
Thanks,
~Nick Desaulniers
