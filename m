Return-Path: <SRS0=n7Wc=J2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55971C3279B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 15:19:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 047B4208E7
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 15:19:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="eg9xzL+g";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="F9bmH8bY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 047B4208E7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933973AbeGJPTX (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Jul 2018 11:19:23 -0400
Received: from mail-yb0-f194.google.com ([209.85.213.194]:33060 "EHLO
        mail-yb0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933703AbeGJPTV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jul 2018 11:19:21 -0400
Received: by mail-yb0-f194.google.com with SMTP id e84-v6so8754356ybb.0
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jul 2018 08:19:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=4D+OOMrd7N1LxSegYrV/kqnTJTSNk+qLuuf+tvnlQxw=;
        b=eg9xzL+gbQ/Qatim7yigNESA4qA7xM87Cyymo0cOnDE+CtodK2BhuLxgWd/1l8cZ43
         5xAlR1C+tMAW2LEnYsXAK8GmO4kTf1FQVG5w7uD5kvwJ1AnJMOwLScDEZ+1q3H2NNJQt
         5gaJzY2ruBzQ6OrWaapU69MJOG2OKYWIoNO+W03NmS+I8ekfkaf3Jui0VwDPQVoHvt1v
         MF9/acgKrF1GpMEaTnCsGtoW9+tIEG0NdSwsixSQ3pjbriTshU3M1Lqz5YbWMPwx9f6H
         rp787HFfGIsDdKshwVgFFuIvCuON8EDOTAecrXgyWebYtcffhCiMzRMZXyZEJshC2FV6
         u2YA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=4D+OOMrd7N1LxSegYrV/kqnTJTSNk+qLuuf+tvnlQxw=;
        b=F9bmH8bYAHJmK4CzNqrcnaeTPtZvOfX13MWbBiwO719qRzRFbeq/4ZvnKaLouDKvVG
         f2PD5i1KgfTE9vwO0g42EbJRNMRZCSlIsGepnmnJC2a/WRV/IuF70lteJh9aPJBnp9f2
         AhdiVyjvsI1qDsRsiFUCHwAms7wl4md4Kv7Gc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=4D+OOMrd7N1LxSegYrV/kqnTJTSNk+qLuuf+tvnlQxw=;
        b=n/82GXH4Uj9UPCt9JyfwquTB57oYeBxIJleno+3kLUNElZJr8UMnFS+wqEw+M4rx/4
         DUPwTa9bcU9OCV1WLFIm9vhZmG8gcPmgskrnfZOPTaxGjGTME8Yxt6WRIPHiLclZ6amt
         CHgPctinWTjxm39hy1YAORBluKcqdI/EbglELNnh9+iCbDWa4OwnwvVyZx0WIDXOhPbl
         xGAu/lD0zjqjIGhuOnEpRD11b9fhMj9byv0JNFlt1uP6Q/WtRHoDboI35hYH9wBDwNpf
         85olZsSHW1nrc/ydBM6UM8ZJ3wCMc3gsEpVkutMlL95zFyyGMoQl2Wtls/LALkeF0Agy
         YAkg==
X-Gm-Message-State: APt69E3FQ7e61nhNPGCovWjEYrGPYItdoYJ+BMTMl9xDh85hhFSsrv57
        HMMAiILqiYG8oeJIzLZ3aI7u/zkulsIT7uHvT8fjEQ==
X-Google-Smtp-Source: AAOMgpdO4iQ6+ribMHq23vdYeMzMSOpffpo0dvWd31r/cT1lPQShK0A9h+HghiMJ+mOT4tSk70WNVtTuoTS3A5cTLtw=
X-Received: by 2002:a25:afce:: with SMTP id d14-v6mr12722831ybj.343.1531235960398;
 Tue, 10 Jul 2018 08:19:20 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:5f51:0:0:0:0:0 with HTTP; Tue, 10 Jul 2018 08:19:18
 -0700 (PDT)
In-Reply-To: <ghwou4prif.fsf@lena.gouders.net>
References: <1530758389-30862-1-git-send-email-yamada.masahiro@socionext.com>
 <1530758389-30862-6-git-send-email-yamada.masahiro@socionext.com>
 <ghva9simch.fsf@lena.gouders.net> <ghbmbk0wbj.fsf@quad.gouders.net> <ghwou4prif.fsf@lena.gouders.net>
From:   Kees Cook <keescook@chromium.org>
Date:   Tue, 10 Jul 2018 08:19:18 -0700
X-Google-Sender-Auth: eeok9UGwjM0AjaOXCjQef5THCpg
Message-ID: <CAGXu5jLLAE7H37Ug+vFJ42gv5gOV1mc28BMVQeiP_kkkodjsSw@mail.gmail.com>
Subject: Re: [PATCH v3 05/12] kconfig: make syncconfig update .config
 regardless of sym_change_count
To:     Dirk Gouders <dirk@gouders.net>
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-kbuild <linux-kbuild@vger.kernel.org>,
        Ulf Magnusson <ulfalizer@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Sam Ravnborg <sam@ravnborg.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 9, 2018 at 4:39 AM, Dirk Gouders <dirk@gouders.net> wrote:
> I think, I solved the puzzle and perhaps, that saves others some time:
>
> The problem is that "if_changed" was not designed for multiple use
> inside a recipe and in the case of compressed/vmlinux, the 2-fold use
> created a kind of flip-flop for situations when nothing has to be done
> to build the target.
>
> Because each of the two users of "if_changed" stores it's footprint in
> .vmlinux.cmd but that file then isn't re-read, one of the two
> "if_changed" calculates that nothing has to be done wheras the other one
> recognizes a change in the commandline, because it sees the command-line
> for the other part of the reciepe.

Ooh, nice find. Thanks for debugging this!

> In the next make, the roles flip, because the previously satisfied
> "if_changed" now sees the command-line of the other one.  And so on...
>
> I am not a Kbuild expert but the attached patch fixes that problem by
> introducing "if_changed_multi" that accepts two commands -- one whose
> commandline should be checked and a second one that should be
> executed.
>
> Dirk
>
>
> diff --git a/arch/x86/boot/compressed/Makefile b/arch/x86/boot/compressed/Makefile
> index fa42f895fdde..f39822fca994 100644
> --- a/arch/x86/boot/compressed/Makefile
> +++ b/arch/x86/boot/compressed/Makefile
> @@ -107,8 +107,8 @@ define cmd_check_data_rel
>  endef
>
>  $(obj)/vmlinux: $(vmlinux-objs-y) FORCE
> -       $(call if_changed,check_data_rel)
> -       $(call if_changed,ld)
> +       $(call if_changed_multi,ld,check_data_rel)
> +       $(call if_changed_multi,ld,ld)

This does seem to do the right thing, but mainly because arg1 is what
actually writes vmlinux, which seems a bit fragile here.

However, the combination is "if_changed" with the "FORCE". This is to
make sure the command line is evaluated in addition to the build deps.
The check_data_rel isn't as sensitive, so maybe the right solution is
just:

-$(obj)/vmlinux: $(vmlinux-objs-y) FORCE
-       $(call if_changed,check_data_rel)
+$(obj)/vmlinux:: $(vmlinux-objs-y)
+       $(call cmd,check_data_rel)
+$(obj)/vmlinux:: $(vmlinux-objs-y) FORCE
        $(call if_changed,ld)

Then check_data_rel is only evaluated with when the deps change (no
FORCE nor if_changed needed), and doesn't interfere with the "ld"
call?

Regardless, the docs for if_changed should be updated to explicitly
mention it should only be called once per target.

-Kees

-- 
Kees Cook
Pixel Security
