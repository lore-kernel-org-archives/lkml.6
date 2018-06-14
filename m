Return-Path: <SRS0=BQBr=JA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,T_DKIM_INVALID,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 0C998C433EF
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 16:13:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B65382086A
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 16:13:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="VG2QOlDB";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ipcMXnZ6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B65382086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S964982AbeFNQNy (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Jun 2018 12:13:54 -0400
Received: from mail-yw0-f196.google.com ([209.85.161.196]:40573 "EHLO
        mail-yw0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S964880AbeFNQNt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jun 2018 12:13:49 -0400
Received: by mail-yw0-f196.google.com with SMTP id p129-v6so2326576ywg.7
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jun 2018 09:13:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=zxqjC377tcuFDQITmV9sWytuj84H7jEEskfCcURQuTY=;
        b=VG2QOlDBO7p9DULDqyGfWXUyKB96WnzUVfKxFmL/phBNYKpQ3FTWgjXiYbXoE1w6NB
         IGrhgFUC7ASh7Zl5GbJxasD4BGvhkB23h7kTS3xHl4EY93W9TjMwfGq0Yv1VyczYu0ai
         BcpgCDBchZgldHcS7ca6oAGrdGXImvIA/WFud7nYzkhJjhY/RRBSEcfSzAeEZSBxeoDU
         unqZed4vRQnEHSiWuy0pvUbk9m37UjJpCK+Hzgy1XShIZEXI8Pdp+bKu3GKla9P8UrMs
         ochotXy7BOObElA6FObLWFDTEw36i/qQX3zPOKub4FYjwiaycYC+b+qM/LOIuMOjBG/z
         ED6g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=zxqjC377tcuFDQITmV9sWytuj84H7jEEskfCcURQuTY=;
        b=ipcMXnZ6dscQ8jFYOsYeFAVdaNXcCFJWCM3Ic+0PlSU/COcS/xh56S7jPQqDBEf3D/
         ajipV3FR0eho/L3YQoOs9hpLtC36chPkv3TSpkUW8SrJyvz6549TgbEmTtpivU0sLQCe
         jMnOLbfzZl62gvkLTGyIfSSIUcmOhngs7OzII=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=zxqjC377tcuFDQITmV9sWytuj84H7jEEskfCcURQuTY=;
        b=YdddAs03HqHjObhGoaJH++0UjFcA+syH09q+O/CtdB84Es0fFBNrjEM58V6wCMfL1l
         zt+4tOkgNQtXe1BLnEwLC3xkM8VJWoXq8g9LI0YsyuEo6LHoMYemiit+x1xvi7CMQ2km
         XppzHjyzjTHGy1b89dD8ZDCBKjW5igs/YPBsdccvj/d1fOaqpnPLsS3WDX04T/SAD8+/
         y+dUHgKknM/4GG0Jyzf5BJ+0uWHJR0oX9SNnsfwPt/NI4IRroHzkJuv7qbcWoYeBuC9b
         50AWPSxbufSdg7Mu9h68xQiDTk3LC9zLpFEUVsqSJ9A7XEk/A2PvN7nyhJWlhDefrPmQ
         /TsQ==
X-Gm-Message-State: APt69E16xjVyS4Fny6yzWI1FDfb4ACYakhWrjiF+34nVoDeXluJhfUHZ
        b2mcG1FQ43SqF8BmCkh+Yr8JyC7X4Saj09mH53dtjA==
X-Google-Smtp-Source: ADUXVKIVKEw7Kzth2n2kkvHtuv6+Gv1mYB5vEjaep2j8oAN93ow0CfL9zQ37REzuNdc5PdEsjlMtLBnlDgkPBRKlhx4=
X-Received: by 2002:a0d:d105:: with SMTP id t5-v6mr1776932ywd.53.1528992828084;
 Thu, 14 Jun 2018 09:13:48 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:d6c5:0:0:0:0:0 with HTTP; Thu, 14 Jun 2018 09:13:47
 -0700 (PDT)
In-Reply-To: <1528972605-24264-1-git-send-email-yamada.masahiro@socionext.com>
References: <1528972605-24264-1-git-send-email-yamada.masahiro@socionext.com>
From:   Kees Cook <keescook@chromium.org>
Date:   Thu, 14 Jun 2018 09:13:47 -0700
X-Google-Sender-Auth: KXlXYeyfDu3SrbbobIZAv3d16XQ
Message-ID: <CAGXu5j+NCxOa9LWss5LF94q8=pSaSw=HxRuGJ8QV-eKXA57Eww@mail.gmail.com>
Subject: Re: [PATCH 0/3] Some more changes for stack protector config symbols
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kbuild <linux-kbuild@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 14, 2018 at 3:36 AM, Masahiro Yamada
<yamada.masahiro@socionext.com> wrote:
> Hi Linus,
>
> While I was checking the renaming commit,
> I noticed some more fixups.
>
> The first two patches take care of what I missed to update.
>
> The last one is another renaming for consistency.
> (Sorry, I should have asked you that.)
>
> Please consider applying this series.

Consider the series:

Acked-by: Kees Cook <keescook@chromium.org>

Thanks for the fixes!

-Kees

>
>
>
> Masahiro Yamada (3):
>   x86: fix dependency of X86_32_LAZY_GS
>   kconfig: tinyconfig: remove stale stack protector fixups
>   Kbuild: rename HAVE_CC_STACKPROTECTOR config variable
>
>  Documentation/features/debug/stackprotector/arch-support.txt | 2 +-
>  arch/Kconfig                                                 | 4 ++--
>  arch/arm/Kconfig                                             | 2 +-
>  arch/arm64/Kconfig                                           | 2 +-
>  arch/mips/Kconfig                                            | 2 +-
>  arch/sh/Kconfig                                              | 2 +-
>  arch/x86/Kconfig                                             | 4 ++--
>  arch/xtensa/Kconfig                                          | 2 +-
>  kernel/configs/tiny.config                                   | 4 ----
>  9 files changed, 10 insertions(+), 14 deletions(-)
>
> --
> 2.7.4
>



-- 
Kees Cook
Pixel Security
