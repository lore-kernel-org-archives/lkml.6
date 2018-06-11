Return-Path: <SRS0=KDb5=I5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id B053EC004E4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Jun 2018 21:20:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B09E2086D
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Jun 2018 21:20:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rYLAM2SE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5B09E2086D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754243AbeFKVUA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Jun 2018 17:20:00 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:44895 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753511AbeFKVT5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jun 2018 17:19:57 -0400
Received: by mail-pf0-f196.google.com with SMTP id h12-v6so10897370pfk.11;
        Mon, 11 Jun 2018 14:19:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=dFnG0ytiAJsiUuvY96IZtLtpblNzyKtG9+Idqx5LyLw=;
        b=rYLAM2SEszUi0TI4xlUzGfHtAHcFR8R20Xz1WLZUUeNY3f1Mo76/N825V4Xum9Kpji
         2FsD8gOrY/tOdpn5+EYY1cn6dk/emu98KH8gBMhEosSJmUCBSGMhZitv8SDJh5tnP9pA
         xmQyoBhlMF9e1z//bAQk/IHYD/kQxOkd36SXoTagbqLfUZO75eMrowgbGH9zsMOUngER
         DLgyrMtB0Rz+Jb3hGDnyFd+pZ1HuDEvDe++qIpZkvMWuxhQeGI0nC5hZbVbYe9u6+5oa
         bzvvSiaiyvOpeGEEIaN+egm95x4Tp1bvk74KzT8LdQci7mPSoQeHQ7sc8+6LPHEfZCE5
         7bGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=dFnG0ytiAJsiUuvY96IZtLtpblNzyKtG9+Idqx5LyLw=;
        b=bQ8FNb5nNHxu/Zhabf7f2hjg5VxpwG7IApsuTURp80stSNxG07OTm3lVH24nCzYKBa
         YJM+rccSTrs/OYll/qDiCMebn1jPGtL1OpVopJKqCxEVItPo2Hc0N+VmRkAYkeNBf9QU
         /tsXJ/plZ7fTjJvRZV3dcgjvCrupG/y4hXb8bAQGzXgyRqk28g65vRhIQ12aaSNTop2c
         mQqSEDghpdF6Jg8DcXPAt7ZD3xv3NQkpGKEkb/YqUf4OkO+qmcHqClexBFlaOb8/JBa/
         yeU3HFCHQQ7ZVCJwSkhnDJfnB0SXiDuAU7ySDmZFZNBAEJ2lzg6l9twpGOTOYUQiZ6nh
         s3/w==
X-Gm-Message-State: APt69E3FXGTQfqhJI446TBPhHtbOPUSaErcKYjQrzZ6MdunjYInGMVwN
        RqQmhOZF8nHSxiA4iA5AzTuhOpajWeU=
X-Google-Smtp-Source: ADUXVKKWmHjkxnpaI5cOcItOLOLEtyYwlO2wHUxFgOecQuiY34Cq0eIfd1Az3vo7RxxJ/5dVzgkYxA==
X-Received: by 2002:a65:6559:: with SMTP id a25-v6mr696253pgw.82.1528751996635;
        Mon, 11 Jun 2018 14:19:56 -0700 (PDT)
Received: from localhost (g134.124-44-9.ppp.wakwak.ne.jp. [124.44.9.134])
        by smtp.gmail.com with ESMTPSA id t134-v6sm57507773pgb.93.2018.06.11.14.19.55
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 11 Jun 2018 14:19:55 -0700 (PDT)
Date:   Tue, 12 Jun 2018 06:19:53 +0900
From:   Stafford Horne <shorne@gmail.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     linux-kbuild@vger.kernel.org,
        Michal Marek <michal.lkml@markovi.net>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Douglas Anderson <dianders@chromium.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Matthew Wilcox <matthew@wil.cx>,
        Matthias Kaehlcke <mka@chromium.org>,
        Deepa Dinamani <deepa.kernel@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Stephan Mueller <smueller@chronox.de>,
        "David S. Miller" <davem@davemloft.net>,
        Yonghong Song <yhs@fb.com>,
        Thomas Garnier <thgarnie@google.com>,
        David Howells <dhowells@redhat.com>,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org
Subject: Re: [PATCH 2/2] [RFC] disable -Wattribute-alias warning for
 SYSCALL_DEFINEx()
Message-ID: <20180611211953.GJ3652@lianli.shorne-pla.net>
References: <20171205153259.2522368-1-arnd@arndb.de>
 <20171205160651.2920270-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171205160651.2920270-1-arnd@arndb.de>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 05, 2017 at 05:06:31PM +0100, Arnd Bergmann wrote:
> gcc-8 warns for every single definition of a system call entry
> point, e.g.:
> 
> include/linux/compat.h:56:18: error: 'compat_sys_rt_sigprocmask' alias between functions of incompatible types 'long int(int,  compat_sigset_t *, compat_sigset_t *, compat_size_t)' {aka 'long int(int,  struct <anonymous> *, struct <anonymous> *, unsigned int)'} and 'long int(long int,  long int,  long int,  long int)' [-Werror=attribute-alias]
>   asmlinkage long compat_sys##name(__MAP(x,__SC_DECL,__VA_ARGS__))\
>                   ^~~~~~~~~~
> include/linux/compat.h:45:2: note: in expansion of macro 'COMPAT_SYSCALL_DEFINEx'
>   COMPAT_SYSCALL_DEFINEx(4, _##name, __VA_ARGS__)
>   ^~~~~~~~~~~~~~~~~~~~~~
> kernel/signal.c:2601:1: note: in expansion of macro 'COMPAT_SYSCALL_DEFINE4'
>  COMPAT_SYSCALL_DEFINE4(rt_sigprocmask, int, how, compat_sigset_t __user *, nset,
>  ^~~~~~~~~~~~~~~~~~~~~~
> include/linux/compat.h:60:18: note: aliased declaration here
>   asmlinkage long compat_SyS##name(__MAP(x,__SC_LONG,__VA_ARGS__))\
>                   ^~~~~~~~~~
> 
> The new warning seems reasonable in principle, but it doesn't
> help us here, since we rely on the type mismatch to sanitize the
> system call arguments. After I reported this as GCC PR82435, a new
> -Wno-attribute-alias option was added that could be used to turn the
> warning off globally on the command line, but I'd prefer to do it a
> little more fine-grained.
> 
> Interestingly, turning a warning off and on again inside of
> a single macro doesn't always work, in this case I had to add
> an extra statement inbetween and decided to copy the __SC_TEST
> one from the native syscall to the compat syscall macro.  See
> https://gcc.gnu.org/bugzilla/show_bug.cgi?id=83256 for more details
> about this.
> 
> Link: https://gcc.gnu.org/bugzilla/show_bug.cgi?id=82435
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Hi Arnd,

What ever happened to this patch?  I am compiline the kernel with the new
OpenRISC GCC backend port https://github.com/stffrdhrn/gcc/commits/or1k-port,
which is based on gcc 9.0.0 and seeing similar 'alias between functions of
incompatible types' warnings.

I found this old patch which seems will fix the issue, but it seems to not have
been merged.  Did we find another solution?

Case in point, when I build x86 64 on gcc 8.1.1, I am not seeing the warnings.
Is this not an issue for x86?

-Stafford
