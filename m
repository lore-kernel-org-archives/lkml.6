Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 874D7C43143
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 12:12:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 40B16205C9
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 12:12:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="B8eUV75J"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 40B16205C9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=paul-moore.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728405AbeJBSzi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 14:55:38 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:42735 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727942AbeJBSzh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 14:55:37 -0400
Received: by mail-lj1-f194.google.com with SMTP id y71-v6so1503367lje.9
        for <linux-kernel@vger.kernel.org>; Tue, 02 Oct 2018 05:12:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SpM/aoFy445qMko0vLoJ2ExH5nJRcWRLuT6ut0sSZZ4=;
        b=B8eUV75JKOR4VpVS5sljVe7wXpx0RS/r3WxiykH4pscaGk0oMVHFkwxcD0NNKOvGsz
         zMtT1qUalkKaZNXa1+bOjN3LOvFugqFZFxCCncGFNgSHKVdAoZpqOlNJXWBBLf25U/NX
         BWgKjvuEGNk/cjpLPs2ZNRQpxVbiXY2TCXGsdBKfk35/S9utk7t4kL2s56NmiMnoDvmT
         n9rx8d5TbLtO2+YurkdNCFe/Wt3qUapeyMxixIj3hphNjgjnA39bG/lASdlEOPAcuEq6
         mZYbfRJKgIeE+IH9MS0s9b/fSmlSH4BwWG34Q3HmKIBszKi/aFcxej4r3bVjmVR4FotN
         K8tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SpM/aoFy445qMko0vLoJ2ExH5nJRcWRLuT6ut0sSZZ4=;
        b=ZJE+NDa9vMpge50g0OjrfYnPVnxUi93Y/LyLmA+LbxfUZmDaBSx+7883i5ljhHCmQ9
         7xUy1edSF7Pzx4uXz3/jxS+FUdwCYcENdPa5a11LnoTznvzfJcyjAjI22dQtKKx+fZbj
         JbUXVfPrEJNuu1PuDiozibaR3isKi0o9pD2oDoWImkl2Bewl8bA8ThHRoFGgxvW60BIV
         MmRUoSZvAAvSCb979+UhVdeR26RA6RsXT0PfKMX33+SlbvjUrcrbikU50bkF9lQhOrez
         TkC4Z+bfTcc0NnV7O7Epf4SmiqrrPEVlwxYdYZBXzIfI73XpjzXa6dRdcQljZEG2vHQ6
         9O3A==
X-Gm-Message-State: ABuFfohXGu41soSWgbEvK6tPm/KXa5neWG7MW9qOn5rKutdIeJxs/Uoc
        Z2dSKlIUD5MbA1S+s1tNqj5cLV/gj/r1F5YMvBMT
X-Google-Smtp-Source: ACcGV61ljfuIR0uDiBFyz6VZVK9LIPrFczTXzzQnGazTYu9SYCu0lgZTCE3obYV4l9/Ukq4y8F7vcmHYFLX3nuExgIs=
X-Received: by 2002:a2e:d11:: with SMTP id 17-v6mr4835502ljn.18.1538482354829;
 Tue, 02 Oct 2018 05:12:34 -0700 (PDT)
MIME-Version: 1.0
References: <20181002005505.6112-1-keescook@chromium.org> <20181002005505.6112-24-keescook@chromium.org>
In-Reply-To: <20181002005505.6112-24-keescook@chromium.org>
From:   Paul Moore <paul@paul-moore.com>
Date:   Tue, 2 Oct 2018 08:12:23 -0400
Message-ID: <CAHC9VhQjMfH6Q+Tif8nBknZojgxrb6x+oDz4vHRiZN8rb8MZ5Q@mail.gmail.com>
Subject: Re: [PATCH security-next v4 23/32] selinux: Remove boot parameter
To:     keescook@chromium.org
Cc:     James Morris <jmorris@namei.org>, casey@schaufler-ca.com,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        Stephen Smalley <sds@tycho.nsa.gov>, casey.schaufler@intel.com,
        linux-security-module@vger.kernel.org, corbet@lwn.net,
        linux-doc@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 1, 2018 at 9:04 PM Kees Cook <keescook@chromium.org> wrote:
> Since LSM enabling is now centralized with CONFIG_LSM_ENABLE and
> "lsm.enable=...", this removes the LSM-specific enabling logic from
> SELinux.
>
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---
>  .../admin-guide/kernel-parameters.txt         |  9 ------
>  security/selinux/Kconfig                      | 29 -------------------
>  security/selinux/hooks.c                      | 15 +---------
>  3 files changed, 1 insertion(+), 52 deletions(-)
>
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index cf963febebb0..0d10ab3d020e 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -4045,15 +4045,6 @@
>                         loaded. An invalid security module name will be treated
>                         as if no module has been chosen.
>
> -       selinux=        [SELINUX] Disable or enable SELinux at boot time.
> -                       Format: { "0" | "1" }
> -                       See security/selinux/Kconfig help text.
> -                       0 -- disable.
> -                       1 -- enable.
> -                       Default value is set via kernel config option.
> -                       If enabled at boot time, /selinux/disable can be used
> -                       later to disable prior to initial policy load.

No comments yet on the rest of the patchset, but the subject line of
this patch caught my eye and I wanted to comment quickly on this one
...

Not a fan unfortunately.

Much like the SELinux bits under /proc/self/attr, this is a user
visible thing which has made its way into a lot of docs, scripts, and
minds; I believe removing it would be a big mistake.

>         serialnumber    [BUGS=X86-32]
>
>         shapers=        [NET]
> diff --git a/security/selinux/Kconfig b/security/selinux/Kconfig
> index 8af7a690eb40..86936528a0bb 100644
> --- a/security/selinux/Kconfig
> +++ b/security/selinux/Kconfig
> @@ -8,35 +8,6 @@ config SECURITY_SELINUX
>           You will also need a policy configuration and a labeled filesystem.
>           If you are unsure how to answer this question, answer N.
>
> -config SECURITY_SELINUX_BOOTPARAM
> -       bool "NSA SELinux boot parameter"
> -       depends on SECURITY_SELINUX
> -       default n
> -       help
> -         This option adds a kernel parameter 'selinux', which allows SELinux
> -         to be disabled at boot.  If this option is selected, SELinux
> -         functionality can be disabled with selinux=0 on the kernel
> -         command line.  The purpose of this option is to allow a single
> -         kernel image to be distributed with SELinux built in, but not
> -         necessarily enabled.
> -
> -         If you are unsure how to answer this question, answer N.
> -
> -config SECURITY_SELINUX_BOOTPARAM_VALUE
> -       int "NSA SELinux boot parameter default value"
> -       depends on SECURITY_SELINUX_BOOTPARAM
> -       range 0 1
> -       default 1
> -       help
> -         This option sets the default value for the kernel parameter
> -         'selinux', which allows SELinux to be disabled at boot.  If this
> -         option is set to 0 (zero), the SELinux kernel parameter will
> -         default to 0, disabling SELinux at bootup.  If this option is
> -         set to 1 (one), the SELinux kernel parameter will default to 1,
> -         enabling SELinux at bootup.
> -
> -         If you are unsure how to answer this question, answer 1.
> -
>  config SECURITY_SELINUX_DISABLE
>         bool "NSA SELinux runtime disable"
>         depends on SECURITY_SELINUX
> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> index 71a10fedecb3..8f5eea097612 100644
> --- a/security/selinux/hooks.c
> +++ b/security/selinux/hooks.c
> @@ -120,20 +120,7 @@ __setup("enforcing=", enforcing_setup);
>  #define selinux_enforcing_boot 1
>  #endif
>
> -#ifdef CONFIG_SECURITY_SELINUX_BOOTPARAM
> -int selinux_enabled = CONFIG_SECURITY_SELINUX_BOOTPARAM_VALUE;
> -
> -static int __init selinux_enabled_setup(char *str)
> -{
> -       unsigned long enabled;
> -       if (!kstrtoul(str, 0, &enabled))
> -               selinux_enabled = enabled ? 1 : 0;
> -       return 1;
> -}
> -__setup("selinux=", selinux_enabled_setup);
> -#else
> -int selinux_enabled = 1;
> -#endif
> +int selinux_enabled __lsm_ro_after_init;
>
>  static unsigned int selinux_checkreqprot_boot =
>         CONFIG_SECURITY_SELINUX_CHECKREQPROT_VALUE;
> --
> 2.17.1
>


-- 
paul moore
www.paul-moore.com
