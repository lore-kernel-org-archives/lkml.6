Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB3CEC169C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 00:26:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ABD6120842
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 00:26:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="EcXGbVeN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727878AbfBLA0S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 19:26:18 -0500
Received: from mail-ua1-f68.google.com ([209.85.222.68]:39394 "EHLO
        mail-ua1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727344AbfBLA0R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 19:26:17 -0500
Received: by mail-ua1-f68.google.com with SMTP id w12so289804uaq.6
        for <linux-kernel@vger.kernel.org>; Mon, 11 Feb 2019 16:26:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BlOmcajIsX/TyRVqHHcJ2IUxXPM+kmCdH3mAHl/Kkko=;
        b=EcXGbVeNKTOlIXwKyuvoJEAuGqe9r28DubSTCS+eblu1zA8W6bjlfgxtbGOghAo3UT
         vkgbCjimvjPoVuDV59cux5VLhz54bE/8DOd3S+JDBQ5DaSIQtsASEjHRvOsVmeNbNefX
         rTuBao5M+KmOrhw9HW7BwgHqZUpPOd7t0yjbk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BlOmcajIsX/TyRVqHHcJ2IUxXPM+kmCdH3mAHl/Kkko=;
        b=k1n2VwrNYcKOL+2DP8oMWdAz5BIvhrFsJFAYj+K0JmpnE4mFnA0GVC7RdeAmClvUWH
         6z2AOjHiZS94WBWvW9Hmdr850yTh54m6wSZLxbb8ob/VXaOE7vxVUDVwk2DCGSNUqkaK
         cmPt4Ul3QyAGtbXJxV914TWNUl1PE86M/N+NtjFSiGGeqQrXSpb6jef1lPsP6mDD48W1
         fhysPgpaYl2YV612O+IcyM05eCA983AybIoo2fLIoc1JxsMeA45TwXXf5PjIY4LtxRPf
         ah9E2/lTRntpfUGQuqi5B2dWwv638hHvb4VNXU94kfr/TkBnqgiOJXxdMCGj3/IWs5qj
         ZNsQ==
X-Gm-Message-State: AHQUAuZZ5uS93nmurwZXn4LuFpCXQaaZPg1ySYIdZ4fAA2wF2RdTrjP1
        H6BXfVgKEFudGjPp1cjd+BI1J/KhDA0=
X-Google-Smtp-Source: AHgI3IZF3stlmyp6j2+6XuGtS+shfmadIhc2EtFDLCSX6vcXJzCpljLO7g4E4OBF3ZGSN5dyYPgBwg==
X-Received: by 2002:ab0:6446:: with SMTP id j6mr439317uap.2.1549931175744;
        Mon, 11 Feb 2019 16:26:15 -0800 (PST)
Received: from mail-vs1-f42.google.com (mail-vs1-f42.google.com. [209.85.217.42])
        by smtp.gmail.com with ESMTPSA id d66sm13105154vkh.9.2019.02.11.16.26.14
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 11 Feb 2019 16:26:14 -0800 (PST)
Received: by mail-vs1-f42.google.com with SMTP id z18so520969vso.7
        for <linux-kernel@vger.kernel.org>; Mon, 11 Feb 2019 16:26:14 -0800 (PST)
X-Received: by 2002:a67:7d01:: with SMTP id y1mr447476vsc.48.1549931173601;
 Mon, 11 Feb 2019 16:26:13 -0800 (PST)
MIME-Version: 1.0
References: <20190211225403.GA7769@beast> <201902120021.x1C0LeYB051392@www262.sakura.ne.jp>
In-Reply-To: <201902120021.x1C0LeYB051392@www262.sakura.ne.jp>
From:   Kees Cook <keescook@chromium.org>
Date:   Mon, 11 Feb 2019 16:26:02 -0800
X-Gmail-Original-Message-ID: <CAGXu5jJ86XosW71111EaaSKcVwzw+UYvi4j619KwoBn=DNwrNw@mail.gmail.com>
Message-ID: <CAGXu5jJ86XosW71111EaaSKcVwzw+UYvi4j619KwoBn=DNwrNw@mail.gmail.com>
Subject: Re: [PATCH] LSM: Ignore "security=" when "lsm=" is specified
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     James Morris <jmorris@namei.org>,
        linux-security-module <linux-security-module@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 11, 2019 at 4:21 PM Tetsuo Handa
<penguin-kernel@i-love.sakura.ne.jp> wrote:
>
> Kees Cook wrote:
> > To avoid potential confusion, explicitly ignore "security=" when "lsm=" is
> > used on the command line, and report that it is happening.
>
> To maintain the existing behavior of CONFIG_DEFAULT_SECURITY, I also suggest this change.
> This saves e.g. Ubuntu users who are using only AppArmor from explicitly specifying
> security=apparmor when they don't want to enable other LSM_FLAG_LEGACY_MAJOR modules.

No, this completely disables the purpose of lsm=

I don't understand the use-case you're concerned about?

-Kees

>
> ---
>  security/Kconfig    | 37 +++++++++++++++++++++++++++++++++++++
>  security/security.c |  5 ++++-
>  2 files changed, 41 insertions(+), 1 deletion(-)
>
> diff --git a/security/Kconfig b/security/Kconfig
> index 9555f49..6a40995 100644
> --- a/security/Kconfig
> +++ b/security/Kconfig
> @@ -250,5 +250,42 @@ config LSM
>
>           If unsure, leave this as the default.
>
> +choice
> +       prompt "Default exclusive security module"
> +       default DEFAULT_SECURITY_SELINUX if SECURITY_SELINUX
> +       default DEFAULT_SECURITY_SMACK if SECURITY_SMACK
> +       default DEFAULT_SECURITY_TOMOYO if SECURITY_TOMOYO
> +       default DEFAULT_SECURITY_APPARMOR if SECURITY_APPARMOR
> +       default DEFAULT_SECURITY_DAC
> +
> +       help
> +         The security module where only one of these modules should be enabled if
> +         neither the "security=" parameter nor the "lsm=" parameter is specified.
> +
> +       config DEFAULT_SECURITY_SELINUX
> +               bool "SELinux" if SECURITY_SELINUX=y
> +
> +       config DEFAULT_SECURITY_SMACK
> +               bool "Simplified Mandatory Access Control" if SECURITY_SMACK=y
> +
> +       config DEFAULT_SECURITY_TOMOYO
> +               bool "TOMOYO" if SECURITY_TOMOYO=y
> +
> +       config DEFAULT_SECURITY_APPARMOR
> +               bool "AppArmor" if SECURITY_APPARMOR=y
> +
> +       config DEFAULT_SECURITY_DAC
> +               bool "Unix Discretionary Access Controls"
> +
> +endchoice
> +
> +config DEFAULT_SECURITY
> +       string
> +       default "selinux" if DEFAULT_SECURITY_SELINUX
> +       default "smack" if DEFAULT_SECURITY_SMACK
> +       default "tomoyo" if DEFAULT_SECURITY_TOMOYO
> +       default "apparmor" if DEFAULT_SECURITY_APPARMOR
> +       default "" if DEFAULT_SECURITY_DAC
> +
>  endmenu
>
> diff --git a/security/security.c b/security/security.c
> index e6153ed..c44e3cd 100644
> --- a/security/security.c
> +++ b/security/security.c
> @@ -294,8 +294,11 @@ static void __init ordered_lsm_init(void)
>                         chosen_major_lsm = NULL;
>                 }
>                 ordered_lsm_parse(chosen_lsm_order, "cmdline");
> -       } else
> +       } else {
> +               if (!chosen_major_lsm)
> +                       chosen_major_lsm = CONFIG_DEFAULT_SECURITY;
>                 ordered_lsm_parse(builtin_lsm_order, "builtin");
> +       }
>
>         for (lsm = ordered_lsms; *lsm; lsm++)
>                 prepare_lsm(*lsm);
> --
> 1.8.3.1
>


-- 
Kees Cook
