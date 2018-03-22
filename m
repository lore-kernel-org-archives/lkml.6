Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752571AbeCVHpM (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Mar 2018 03:45:12 -0400
Received: from mail-lf0-f66.google.com ([209.85.215.66]:33302 "EHLO
        mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752356AbeCVHpJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Mar 2018 03:45:09 -0400
X-Google-Smtp-Source: AG47ELtqwR+WZPIVz8a9QHmSDUR2qPegIPh+euS7cf9GBUy0e3kuAfh68zOnxPe3U8x327GTOimbTdr4pXa9ZgDoQ5g=
MIME-Version: 1.0
In-Reply-To: <c6e11bd4-3d22-f8aa-c905-d06b16b1f5e2@siemens.com>
References: <c6e11bd4-3d22-f8aa-c905-d06b16b1f5e2@siemens.com>
From: Riku Voipio <riku.voipio@linaro.org>
Date: Thu, 22 Mar 2018 09:45:07 +0200
Message-ID: <CAAqcGH=fFv=Fh43mbi19_A-c551adVV5OSJ-53HF09ev2u-E1g@mail.gmail.com>
Subject: Re: [PATCH] builddeb: Fix header package regarding dtc source links
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>,
        "linux-kbuild@vger.kernel.org" <linux-kbuild@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21 March 2018 at 07:15, Jan Kiszka <jan.kiszka@siemens.com> wrote:
> Since d5d332d3f7e8, a couple of links in scripts/dtc/include-prefixes
> are additionally required in order to build device trees with the header
> package.

A bit odd usecase IMHO, but:

Reviewed-by: Riku Voipio <riku.voipio@linaro.org>

> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
> ---
>  scripts/package/builddeb | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/scripts/package/builddeb b/scripts/package/builddeb
> index b4f0f2b3f8d2..13fabb1f81db 100755
> --- a/scripts/package/builddeb
> +++ b/scripts/package/builddeb
> @@ -313,7 +313,7 @@ fi
>
>  # Build kernel header package
>  (cd $srctree; find . -name Makefile\* -o -name Kconfig\* -o -name \*.pl) > "$objtree/debian/hdrsrcfiles"
> -(cd $srctree; find arch/*/include include scripts -type f) >> "$objtree/debian/hdrsrcfiles"
> +(cd $srctree; find arch/*/include include scripts -type f -o -type l) >> "$objtree/debian/hdrsrcfiles"
>  (cd $srctree; find arch/$SRCARCH -name module.lds -o -name Kbuild.platforms -o -name Platform) >> "$objtree/debian/hdrsrcfiles"
>  (cd $srctree; find $(find arch/$SRCARCH -name include -o -name scripts -type d) -type f) >> "$objtree/debian/hdrsrcfiles"
>  if grep -q '^CONFIG_STACK_VALIDATION=y' $KCONFIG_CONFIG ; then
> --
> 2.13.6
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kbuild" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
