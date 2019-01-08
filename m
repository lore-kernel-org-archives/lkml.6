Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43BB7C43387
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 11:10:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0614A206B7
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 11:10:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GfaqbCRX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728525AbfAHLKh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 06:10:37 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:43075 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728369AbfAHLKg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 06:10:36 -0500
Received: by mail-pf1-f196.google.com with SMTP id w73so1763325pfk.10;
        Tue, 08 Jan 2019 03:10:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=e42acyZkHQ/RKHvKonSuJ3oOeal/c3QK1to9X5ezg2w=;
        b=GfaqbCRX7YuAwQ+Z7dN10mQyOMgTNGrxqZMYP2e/ML2ox5YKNOeWIHoING54g7d59q
         fciJNMDjGtvCieSv6iXG/PWrhKzVI/TgIooLMqmE/jZrcEVdh2m69m/yUmf84ObFB76g
         ADRRQvO7FkHLYuKD/0etnhjbezunK5r6hHGQEiCv6zy/QeOIpPknhGMuwTrY4x4vy4xJ
         voN9DNA31lG1H4Ki1K78YskSkQ+Ff978y4mDswzrdPRcFfnO2TM1Wnlm+JuOCOLk+mRi
         sBloDMyM0AbXiWHa3uglT2gWpU3aF1ZRqIHX5UnVduT/Sua/quv/qPjzWz0caHdI8pRD
         tgwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=e42acyZkHQ/RKHvKonSuJ3oOeal/c3QK1to9X5ezg2w=;
        b=r0Jhdpx03c03W6aQCQSDGrS49PLWjNF4dYBQzJSyA1AuiH1zZeslBknAi8gJMbkasj
         JsXAY2xYlvARO7dAMXGoQLsGIoETv5mZBoR5yqn2GlY6Xc2UbXSCcuYnbwyaUtq2B82L
         otmNBiiwO708a4PqAbhr97l74ClV+n+O1KIOLDWmgLW6eNPkNuYpbxBudOJdElJMNtqd
         8Jvonc1SD7UhHuPZp4MxNll3pIVis30MgEnI3ZT8KhSpujjjCOl9UZXgxB6Vtqpi8HSV
         AWjIlgl6/C/YSl5lcmh/irzb+PyKfWfGcMBMPwX1PvPnQHMei/wQt9OTRLwJXv84wjW1
         FEfw==
X-Gm-Message-State: AJcUukdgCx8W0DGouhcaYV8GKxx6S8CZL1f94oLk61xSEgqdp+rzOPZx
        wlxNYs9RPl1fFykMkZNYUxs=
X-Google-Smtp-Source: ALg8bN4g0ngLUTYrVMvbcz8rLu60b4T3FH/JyovhOu7G8+fWZcmFLuoSPYg1ZGJDsMj8HNuz9A1WDQ==
X-Received: by 2002:a65:514c:: with SMTP id g12mr1107264pgq.169.1546945835031;
        Tue, 08 Jan 2019 03:10:35 -0800 (PST)
Received: from localhost (g206.124-44-15.ppp.wakwak.ne.jp. [124.44.15.206])
        by smtp.gmail.com with ESMTPSA id b9sm98180662pfi.118.2019.01.08.03.10.33
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 08 Jan 2019 03:10:34 -0800 (PST)
Date:   Tue, 8 Jan 2019 20:10:32 +0900
From:   Stafford Horne <shorne@gmail.com>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Michal Simek <monstr@monstr.eu>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Richard Kuo <rkuo@codeaurora.org>,
        linux-hexagon@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Guan Xuetao <gxt@pku.edu.cn>, linux-arch@vger.kernel.org,
        Nicolas Dichtel <nicolas.dichtel@6wind.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Aurelien Jacquiot <jacquiot.aurelien@gmail.com>,
        linux-riscv@lists.infradead.org, Greentime Hu <green.hu@gmail.com>,
        linux-c6x-dev@linux-c6x.org, Guo Ren <guoren@kernel.org>,
        Palmer Dabbelt <palmer@sifive.com>,
        uclinux-h8-devel@lists.sourceforge.jp,
        Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
        linux-m68k@lists.linux-m68k.org, openrisc@lists.librecores.org,
        Mark Salter <msalter@redhat.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Jonas Bonn <jonas@southpole.se>, linux-kernel@vger.kernel.org,
        Vincent Chen <deanbo422@gmail.com>
Subject: Re: [PATCH] arch: unexport asm/shmparam.h for all architectures
Message-ID: <20190108111032.GP3235@lianli.shorne-pla.net>
References: <1546904307-11124-1-git-send-email-yamada.masahiro@socionext.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1546904307-11124-1-git-send-email-yamada.masahiro@socionext.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Masahiro,

On Tue, Jan 08, 2019 at 08:38:27AM +0900, Masahiro Yamada wrote:
> Most architectures do not export shmparam.h to user-space.
> 
>   $ find arch -name shmparam.h  | sort
>   arch/alpha/include/asm/shmparam.h
>   arch/arc/include/asm/shmparam.h
>   arch/arm64/include/asm/shmparam.h
>   arch/arm/include/asm/shmparam.h
>   arch/csky/include/asm/shmparam.h
>   arch/ia64/include/asm/shmparam.h
>   arch/mips/include/asm/shmparam.h
>   arch/nds32/include/asm/shmparam.h
>   arch/nios2/include/asm/shmparam.h
>   arch/parisc/include/asm/shmparam.h
>   arch/powerpc/include/asm/shmparam.h
>   arch/s390/include/asm/shmparam.h
>   arch/sh/include/asm/shmparam.h
>   arch/sparc/include/asm/shmparam.h
>   arch/x86/include/asm/shmparam.h
>   arch/xtensa/include/asm/shmparam.h
> 
> Strangely, some users of the asm-generic wrapper export shmparam.h
> 
>   $ git grep 'generic-y += shmparam.h'
>   arch/c6x/include/uapi/asm/Kbuild:generic-y += shmparam.h
>   arch/h8300/include/uapi/asm/Kbuild:generic-y += shmparam.h
>   arch/hexagon/include/uapi/asm/Kbuild:generic-y += shmparam.h
>   arch/m68k/include/uapi/asm/Kbuild:generic-y += shmparam.h
>   arch/microblaze/include/uapi/asm/Kbuild:generic-y += shmparam.h
>   arch/openrisc/include/uapi/asm/Kbuild:generic-y += shmparam.h
>   arch/riscv/include/asm/Kbuild:generic-y += shmparam.h
>   arch/unicore32/include/uapi/asm/Kbuild:generic-y += shmparam.h
> 
> The newly added riscv correctly creates the asm-generic wrapper
> in the kernel space, but the others (c6x, h8300, hexagon, m68k,
> microblaze, openrisc, unicore32) create the one in the uapi directory.
> 
> Digging into the git history, now I guess fcc8487d477a ("uapi:
> export all headers under uapi directories") was the misconversion.
> Prior to that commit, no architecture exported to shmparam.h
> As its commit description said, that commit exported shmparam.h
> for c6x, h8300, hexagon, m68k, openrisc, unicore32.
> 
> 83f0124ad81e ("microblaze: remove asm-generic wrapper headers")
> accidentally exported shmparam.h for microblaze.
> 
> This commit unexports shmparam.h for those architectures.
> 
> There is no more reason to export include/uapi/asm-generic/shmparam.h,
> so it has been moved to include/asm-generic/shmparam.h
> 
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> ---
> 
>  arch/c6x/include/asm/Kbuild               | 1 +
>  arch/c6x/include/uapi/asm/Kbuild          | 1 -
>  arch/h8300/include/asm/Kbuild             | 1 +
>  arch/h8300/include/uapi/asm/Kbuild        | 1 -
>  arch/hexagon/include/asm/Kbuild           | 1 +
>  arch/hexagon/include/uapi/asm/Kbuild      | 1 -
>  arch/m68k/include/asm/Kbuild              | 1 +
>  arch/m68k/include/uapi/asm/Kbuild         | 1 -
>  arch/microblaze/include/asm/Kbuild        | 1 +
>  arch/microblaze/include/uapi/asm/Kbuild   | 1 -
>  arch/openrisc/include/asm/Kbuild          | 1 +
>  arch/openrisc/include/uapi/asm/Kbuild     | 1 -
>  arch/unicore32/include/asm/Kbuild         | 1 +
>  arch/unicore32/include/uapi/asm/Kbuild    | 1 -
>  include/{uapi => }/asm-generic/shmparam.h | 0
>  15 files changed, 7 insertions(+), 7 deletions(-)
>  rename include/{uapi => }/asm-generic/shmparam.h (100%)
> 

[...]

> diff --git a/arch/openrisc/include/asm/Kbuild b/arch/openrisc/include/asm/Kbuild
> index eb87cd8..1f04844b 100644
> --- a/arch/openrisc/include/asm/Kbuild
> +++ b/arch/openrisc/include/asm/Kbuild
> @@ -34,6 +34,7 @@ generic-y += qrwlock_types.h
>  generic-y += qrwlock.h
>  generic-y += sections.h
>  generic-y += segment.h
> +generic-y += shmparam.h
>  generic-y += string.h
>  generic-y += switch_to.h
>  generic-y += topology.h
> diff --git a/arch/openrisc/include/uapi/asm/Kbuild b/arch/openrisc/include/uapi/asm/Kbuild
> index 6c6f630..0febf1a 100644
> --- a/arch/openrisc/include/uapi/asm/Kbuild
> +++ b/arch/openrisc/include/uapi/asm/Kbuild
> @@ -1,5 +1,4 @@
>  include include/uapi/asm-generic/Kbuild.asm
>  
>  generic-y += kvm_para.h
> -generic-y += shmparam.h
>  generic-y += ucontext.h

What is this patch based on?  I tried to apply it to 5.0-rc1 and am having an
issue with applying the arch/openrisc/include/uapi/asm/Kbuild part.

    $ ~/work/bin/am-incoming PATCH_arch_unexport_asm-shmparam.h_for_all_architectures.patch
    Applying: arch: unexport asm/shmparam.h for all architectures
    error: patch failed: arch/c6x/include/uapi/asm/Kbuild:1
    error: arch/c6x/include/uapi/asm/Kbuild: patch does not apply
    error: patch failed: arch/h8300/include/uapi/asm/Kbuild:1
    error: arch/h8300/include/uapi/asm/Kbuild: patch does not apply
    error: patch failed: arch/hexagon/include/uapi/asm/Kbuild:1
    error: arch/hexagon/include/uapi/asm/Kbuild: patch does not apply
    error: patch failed: arch/m68k/include/uapi/asm/Kbuild:2
    error: arch/m68k/include/uapi/asm/Kbuild: patch does not apply
    error: patch failed: arch/microblaze/include/uapi/asm/Kbuild:2
    error: arch/microblaze/include/uapi/asm/Kbuild: patch does not apply
    error: patch failed: arch/openrisc/include/uapi/asm/Kbuild:1
    error: arch/openrisc/include/uapi/asm/Kbuild: patch does not apply
    error: patch failed: arch/unicore32/include/uapi/asm/Kbuild:1
    error: arch/unicore32/include/uapi/asm/Kbuild: patch does not apply
    Patch failed at 0001 arch: unexport asm/shmparam.h for all architectures
    hint: Use 'git am --show-current-patch' to see the failed patch

It seems shmparam.h is not there. It was removed with the others in your
("d6e4b3e326d8") arch: remove redundant UAPI generic-y defines, commit a few
days ago.

Note, I can't compile 5.0-rc1 without the first part of this patch.  So please
get it merged asap :)

-Stafford
