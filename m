Return-Path: <SRS0=QLNC=JI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8706C43142
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 09:48:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7687E23FAF
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 09:48:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7687E23FAF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754206AbeFVJsP convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Jun 2018 05:48:15 -0400
Received: from mail-ot0-f194.google.com ([74.125.82.194]:45619 "EHLO
        mail-ot0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751284AbeFVJsN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jun 2018 05:48:13 -0400
Received: by mail-ot0-f194.google.com with SMTP id a5-v6so6823348otf.12
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jun 2018 02:48:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=b2kF+WQOiC8RO3ptapIhdhEln8LhkXJfim1zJwlF7Eg=;
        b=dz7Avr8BlvJ1HjLtW1AXve7cMXSw7GT3DN/EUlz3OPw8AHe9+rRJk+VZFb/mI3oHsK
         EA0rL/3ByAtLsbRGgH6DQvUggD6eZdMU/tILAJxrWK3+xPxrGCLHegMn9K+gLgTFVtkK
         Muw8bwaa1IxKRvEAdaSjeAKpmh8g708oE4yKnMnW8TTWpWRAVwPZE3ene+kGUWTS/84p
         8w8o318/WAk64pgF0UHM/HmrMAwMf9muyju2wswknK0UltlOoBe5VsQzI/Bt3RxWoDAJ
         pBiW0lbUplpoA+Yx7NN6kZfjalQW2GIJ4atSmPhDh3g5Nacfnrk/S/7zpVI+TXwhf/ai
         fbMw==
X-Gm-Message-State: APt69E3FdwKY1uP7JBTUuLliHVLV8AifA71kSZOxE92v4NAIWrlrKHYq
        oSg84DUukfI+KNjh04GaPCm8nzfK+GAu8Q5YGFg=
X-Google-Smtp-Source: ADUXVKICJzdoLc0TCD1a3eFU5AB8fZH3vCNuxl/DF4eWsHVgkD0A4j5V/8o7ahvvFTv0Slf6ox2W6LdBRKIWoHpd/HE=
X-Received: by 2002:a9d:27a6:: with SMTP id c35-v6mr526155otb.56.1529660893214;
 Fri, 22 Jun 2018 02:48:13 -0700 (PDT)
MIME-Version: 1.0
References: <20180328193307.978-1-malat@debian.org> <20180404200836.27446-1-malat@debian.org>
In-Reply-To: <20180404200836.27446-1-malat@debian.org>
From:   Mathieu Malaterre <malat@debian.org>
Date:   Fri, 22 Jun 2018 11:48:02 +0200
Message-ID: <CA+7wUswQGhQS6FTdRkGhhJKFbfoVpmzwWdT_9GoOicEF0OXFPQ@mail.gmail.com>
Subject: Re: [PATCH v3 03/19] powerpc: Move `path` variable inside DEBUG_PROM
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     Christophe LEROY <christophe.leroy@c-s.fr>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This one should be ok.

On Wed, Apr 4, 2018 at 10:08 PM Mathieu Malaterre <malat@debian.org> wrote:
>
> Add gcc attribute unused for two variables. Fix warnings treated as errors
> with W=1:
>
>   arch/powerpc/kernel/prom_init.c:1388:8: error: variable ‘path’ set but not used [-Werror=unused-but-set-variable]
>
> Suggested-by: Christophe Leroy <christophe.leroy@c-s.fr>
> Signed-off-by: Mathieu Malaterre <malat@debian.org>
> ---
> v3: really move path within ifdef DEBUG_PROM
> v2: move path within ifdef DEBUG_PROM
>
>  arch/powerpc/kernel/prom_init.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
>
> diff --git a/arch/powerpc/kernel/prom_init.c b/arch/powerpc/kernel/prom_init.c
> index acf4b2e0530c..223b35acbbdd 100644
> --- a/arch/powerpc/kernel/prom_init.c
> +++ b/arch/powerpc/kernel/prom_init.c
> @@ -603,7 +603,7 @@ static void __init early_cmdline_parse(void)
>         const char *opt;
>
>         char *p;
> -       int l = 0;
> +       int l __maybe_unused = 0;
>
>         prom_cmd_line[0] = 0;
>         p = prom_cmd_line;
> @@ -1385,7 +1385,10 @@ static void __init reserve_mem(u64 base, u64 size)
>  static void __init prom_init_mem(void)
>  {
>         phandle node;
> -       char *path, type[64];
> +#ifdef DEBUG_PROM
> +       char *path;
> +#endif
> +       char type[64];
>         unsigned int plen;
>         cell_t *p, *endp;
>         __be32 val;
> @@ -1406,7 +1409,9 @@ static void __init prom_init_mem(void)
>         prom_debug("root_size_cells: %x\n", rsc);
>
>         prom_debug("scanning memory:\n");
> +#ifdef DEBUG_PROM
>         path = prom_scratch;
> +#endif
>
>         for (node = 0; prom_next_node(&node); ) {
>                 type[0] = 0;
> --
> 2.11.0
>
