Return-Path: <SRS0=AKhD=M3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2C71C04AA5
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 20:14:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6AC17208D9
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 20:14:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fnx6O4PJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6AC17208D9
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726068AbeJPEAp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 00:00:45 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:44530 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725889AbeJPEAp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 00:00:45 -0400
Received: by mail-pg1-f193.google.com with SMTP id g2-v6so9669893pgu.11
        for <linux-kernel@vger.kernel.org>; Mon, 15 Oct 2018 13:13:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9Jq9EWWdaZGE+Hmkisn6JLAPJwm3/aCKAcAu4cQONx0=;
        b=fnx6O4PJvbG4u3RbvnW1ICeUfejxUfWyjSRZ8LDWFCatYOTtlTvmWdqO0BnrTqFDSr
         4U2S/rfOZ1d0qfA5hIp1nk9B4q8h6I2QbVO/BaaZwFiGfy4OIwxTHCmud2VaGyQm2E00
         XnGNALIUTBZerS/46DT0Z/VGGPk7jX3vyx2VwZ44KhrlCdYaOm5R9uFGhynkvnfvJE1h
         GAa7WAbUZd7OHSZ0Vh5Gb0od5ZtS0bXN2Chm45eL7ZKaX3Qmitiht3yftVpcgS3vowNK
         w0YvUPZnujqPh0jzTly/ysMnnXTTdwY7fo8OHDBiWQJEzi6OZW/qPv2Hr9jKMTget1yh
         Z+ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9Jq9EWWdaZGE+Hmkisn6JLAPJwm3/aCKAcAu4cQONx0=;
        b=CW5/rfb/bTZ7Mh8s/hGDiYMMP8+DLDM992CLcqYwR38n17d29cLUVoG9MaUKuLqyyJ
         cxEy4RQYUr2kaQmYZMqpCAixeF4RhvNKeVJm4CqUGeBr+aThtr6awU+nnfyQqi6jHKX0
         UOP2UXUhjtQD6b2UMp91rdlAP+RrLHKhywtJJsdOpDNY1BD3ea2YDxBW5k5Nw9SxNKx9
         ce9mziUsht+oVGC/ZRO/E5GngIKhBZJ5V93orFVogcceoCkgsCo61ecT7hnmGDuPiZjK
         zlwM5M8fq1umsL+MUN0vAwzG/AzvaIj3dNxJp7hOUm0U8qhsXM6jOSWqMX34w+oJ3jKP
         +5IA==
X-Gm-Message-State: ABuFfoggNzSy0ol699tMK/R2NCybfmN7U5mhH41oBroz3IRk6409MA4W
        zohNqslz03pTRI8VPf+As6sdC6gbHYyDFjVCKFlI5Q==
X-Google-Smtp-Source: ACcGV606C1gHOGKIP+4yLiOtN151k/bsn8yXvJ/8TrM1Po1NcjWtnK8qYZV+1L1R7DSdameOPeE4R1L7FGOXiflSyrI=
X-Received: by 2002:a63:2f42:: with SMTP id v63-v6mr3255862pgv.202.1539634438351;
 Mon, 15 Oct 2018 13:13:58 -0700 (PDT)
MIME-Version: 1.0
References: <20181015172221.35709-1-ndesaulniers@google.com> <CANiq72kLs-Z=ZDdWU_1JV-NG+D5yPEfgREny+nXQgPioyOB=mg@mail.gmail.com>
In-Reply-To: <CANiq72kLs-Z=ZDdWU_1JV-NG+D5yPEfgREny+nXQgPioyOB=mg@mail.gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Mon, 15 Oct 2018 13:13:46 -0700
Message-ID: <CAKwvOdnwfXSdBw_Y2zpAEdcn3aWRqUq9Fh8uk8EnkxPMC+c2Sw@mail.gmail.com>
Subject: Re: [PATCH] compiler.h: update definition of unreachable()
To:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc:     luto@amacapital.net, Josh Poimboeuf <jpoimboe@redhat.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        sparse@chrisli.org, linux-sparse@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 15, 2018 at 11:21 AM Miguel Ojeda
<miguel.ojeda.sandonis@gmail.com> wrote:
>
> On Mon, Oct 15, 2018 at 7:22 PM <ndesaulniers@google.com> wrote:
> >
> > Fixes the objtool warning seen with Clang:
> > arch/x86/mm/fault.o: warning: objtool: no_context()+0x220: unreachable
> > instruction
> >
> > Fixes commit 815f0ddb346c ("include/linux/compiler*.h: make compiler-*.h
> > mutually exclusive")
> >
> > Josh noted that the fallback definition was meant to work around a
> > pre-gcc-4.6 bug. GCC still needs to work around
> > https://gcc.gnu.org/bugzilla/show_bug.cgi?id=82365, so compiler-gcc.h
> > defines its own version of unreachable().  Clang and ICC can use this
> > shared definition.
>
> Could we, at the same time, update the comment on compiler-gcc.h as
> well? i.e. remove the 4.5 comment, add the link to the GCC PR.

Looking at commit cb984d101b30 ("compiler-gcc: integrate the various
compiler-gcc[345].h files") it seems that the comment is referring to
gcc 4.4 not supporting __builtin_unreachable().  Looks like it was
added in 4.5 timeframe: https://godbolt.org/z/ugv5QO, so the comment
can be deleted.  Would you prefer a v2 (single patch), or an
additional patch on top?

>
> >
> > Link: https://github.com/ClangBuiltLinux/linux/issues/204
> > Suggested-by: Andy Lutomirski <luto@amacapital.net>
> > Suggested-by: Josh Poimboeuf <jpoimboe@redhat.com>
> > Tested-by: Nathan Chancellor <natechancellor@gmail.com>
> > Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
> > ---
> > Miguel, would you mind taking this up in your new compiler attributes
> > tree?
>
> Sure, will do.
>
> Thanks,
>
> Cheers,
> Miguel



-- 
Thanks,
~Nick Desaulniers
