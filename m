Return-Path: <SRS0=IvFc=NU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E3E2C43441
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 16:20:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D2DE920855
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 16:20:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="pNmokW+e"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D2DE920855
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728266AbeKJCBR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 21:01:17 -0500
Received: from conssluserg-02.nifty.com ([210.131.2.81]:44106 "EHLO
        conssluserg-02.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727828AbeKJCBR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 21:01:17 -0500
Received: from mail-vk1-f177.google.com (mail-vk1-f177.google.com [209.85.221.177]) (authenticated)
        by conssluserg-02.nifty.com with ESMTP id wA9GJlw6007424;
        Sat, 10 Nov 2018 01:19:48 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-02.nifty.com wA9GJlw6007424
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1541780388;
        bh=aLO+d5mDllVIgrJ76MGsAbPmgd7rmlLBSpsDbbRTvEk=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=pNmokW+ePIxR4mtFW4N0ZwBHVBKYLilRyTgFphlDLPdiYihdDgdRybYpHJrggusaI
         nhJwVflM/9cyIqB7pGn7NRf2KhHALfrcvzQJ4kgmuKNTRLs7xBXJtDAYimRAGUYuSQ
         sqBUEhpdHZRyLmVz0ZDkEjaVEHaDhboviRu1lYKH3cztFU9Gj0axhGTYhq00RPK55C
         QKTCj06UbeeSKKI/ymGDPmjKMvxo9CAtWtCLmjCAHl0uXiefIL/utToLVPVuxS/7/J
         wh/ig/iulhbruld9NA9InNJUN4cxUodLUolFRlXsNUGnj0AB3RgCrA1zNsVJr1h3Eo
         ZCIPwR9IGEXWQ==
X-Nifty-SrcIP: [209.85.221.177]
Received: by mail-vk1-f177.google.com with SMTP id n126so521708vke.12;
        Fri, 09 Nov 2018 08:19:48 -0800 (PST)
X-Gm-Message-State: AGRZ1gKnm2c3bBQQ/Th2hUVW7lrk8XDIKYbWigWeMGr36y1tLlhJgtvf
        sRSCZ6jRl/PPC2ZV0TdVEE3qhqfkverxMGDPrB8=
X-Google-Smtp-Source: AJdET5e5S4zyUEwUv8ZrHJ+87bRfeW/T6mGE981XePQYgu8aJvQ9qyVw4JWHSopj/tiWYEAIRHaJyCQ4kHBST0uLo/0=
X-Received: by 2002:a1f:fcc3:: with SMTP id a186mr4319195vki.0.1541780386757;
 Fri, 09 Nov 2018 08:19:46 -0800 (PST)
MIME-Version: 1.0
References: <1541404309-30210-1-git-send-email-yamada.masahiro@socionext.com>
In-Reply-To: <1541404309-30210-1-git-send-email-yamada.masahiro@socionext.com>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Sat, 10 Nov 2018 01:19:11 +0900
X-Gmail-Original-Message-ID: <CAK7LNARxO-wawD6pOoFNyJ8Sh1=XucX=K5ACOuksKKBTzdxMiQ@mail.gmail.com>
Message-ID: <CAK7LNARxO-wawD6pOoFNyJ8Sh1=XucX=K5ACOuksKKBTzdxMiQ@mail.gmail.com>
Subject: Re: [PATCH] kbuild: rpm-pkg: fix binrpm-pkg breakage when O= is used
To:     Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>
Cc:     zhenzhong.duan@oracle.com, Michal Marek <michal.lkml@markovi.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 5, 2018 at 4:52 PM Masahiro Yamada
<yamada.masahiro@socionext.com> wrote:
>
> Zhenzhong Duan reported that running 'make O=/build/kernel binrpm-pkg'
> failed with the following errors:
>
>   Running 'make O=/build/kernel binrpm-pkg' failed with below two errors.
>
>   Makefile:600: include/config/auto.conf: No such file or directory
>
>   + cp make -C /mnt/root/kernel O=/build/kernel image_name make -f
>   /mnt/root/kernel/Makefile ...
>   cp: invalid option -- 'C'
>   Try 'cp --help' for more information.
>
> Prior to commit 80463f1b7bf9 ("kbuild: add --include-dir flag only
> for out-of-tree build"), both objtree and srctree were added to
> --include-dir, and the wrong code 'make image_name' was working
> relying on that. Now, the potential issue that had previously been
> hidden just showed up.
>
> 'make image_name' recurses to the generated $(objtree)/Makefile and
> ends up with running in srctree, which is incorrect. It should be
> invoked with '-f $srctree/Makefile' (or KBUILD_SRC=) to be executed
> in objtree.
>
> Fixes: 80463f1b7bf9 ("kbuild: add --include-dir flag only for out-of-tree build")
> Reported-by: Zhenzhong Duan <zhenzhong.duan@oracle.com>
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> ---

Applied to linux-kbuild/fixes.



>  scripts/package/mkspec | 11 ++++++-----
>  1 file changed, 6 insertions(+), 5 deletions(-)
>
> diff --git a/scripts/package/mkspec b/scripts/package/mkspec
> index e05646d..009147d 100755
> --- a/scripts/package/mkspec
> +++ b/scripts/package/mkspec
> @@ -12,6 +12,7 @@
>  # how we were called determines which rpms we build and how we build them
>  if [ "$1" = prebuilt ]; then
>         S=DEL
> +       MAKE="$MAKE -f $srctree/Makefile"
>  else
>         S=
>  fi
> @@ -78,19 +79,19 @@ $S  %prep
>  $S     %setup -q
>  $S
>  $S     %build
> -$S     make %{?_smp_mflags} KBUILD_BUILD_VERSION=%{release}
> +$S     $MAKE %{?_smp_mflags} KBUILD_BUILD_VERSION=%{release}
>  $S
>         %install
>         mkdir -p %{buildroot}/boot
>         %ifarch ia64
>         mkdir -p %{buildroot}/boot/efi
> -       cp \$(make image_name) %{buildroot}/boot/efi/vmlinuz-$KERNELRELEASE
> +       cp \$($MAKE image_name) %{buildroot}/boot/efi/vmlinuz-$KERNELRELEASE
>         ln -s efi/vmlinuz-$KERNELRELEASE %{buildroot}/boot/
>         %else
> -       cp \$(make image_name) %{buildroot}/boot/vmlinuz-$KERNELRELEASE
> +       cp \$($MAKE image_name) %{buildroot}/boot/vmlinuz-$KERNELRELEASE
>         %endif
> -$M     make %{?_smp_mflags} INSTALL_MOD_PATH=%{buildroot} KBUILD_SRC= modules_install
> -       make %{?_smp_mflags} INSTALL_HDR_PATH=%{buildroot}/usr KBUILD_SRC= headers_install
> +$M     $MAKE %{?_smp_mflags} INSTALL_MOD_PATH=%{buildroot} modules_install
> +       $MAKE %{?_smp_mflags} INSTALL_HDR_PATH=%{buildroot}/usr headers_install
>         cp System.map %{buildroot}/boot/System.map-$KERNELRELEASE
>         cp .config %{buildroot}/boot/config-$KERNELRELEASE
>         bzip2 -9 --keep vmlinux
> --
> 2.7.4
>


-- 
Best Regards
Masahiro Yamada
