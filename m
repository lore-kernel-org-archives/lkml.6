Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAD46C0044C
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 12:38:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 728DA20854
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 12:38:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="YHn4KMKg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 728DA20854
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729584AbeKEV5c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Nov 2018 16:57:32 -0500
Received: from mail-io1-f66.google.com ([209.85.166.66]:38478 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729015AbeKEV5c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Nov 2018 16:57:32 -0500
Received: by mail-io1-f66.google.com with SMTP id q18-v6so6345092iod.5
        for <linux-kernel@vger.kernel.org>; Mon, 05 Nov 2018 04:37:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=QtkOgGWJRoC6+4JmBFDQkBEuIb/ac1OOr2Z0SmDq+Z4=;
        b=YHn4KMKgoVaAiLS8yj3A6Onivza/w2sKNUojnHIUZWHXkNpLmd9BZymvAkZ3vBNouD
         yKfAb+t90LesfaIUF67mhR68VOIbl9QirZz4yozUGwZlApwBfCukxH198yhqMtqBO6fA
         fOMJufJn47DSV0bBFjErmVxQhqclixx8aJwJc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=QtkOgGWJRoC6+4JmBFDQkBEuIb/ac1OOr2Z0SmDq+Z4=;
        b=k80FBazHBUo1QRFPo86Jv3jeIF+OuqDznioSprLBBoNRG5aB01QsYmxzLJRB1JOVH2
         sZpHM3Cbx0BSbmZo11URhzSuh5mApRy5wog6g1yPGqcUSIC4SKg4tXLrWQ7NyOFMjOs8
         FEjCRbTcruC4dsyzZDZ4ykpf1OK82gi+sBf8HWrjhBnOA+ozljepfP1vPh4ywnZhjZZR
         tMYYbL3MaQkTPkVGWTCt8jKr5Ieo8Mco9JESckcUgUjWR1OOPL8js1kwZE/fsaB57Qg1
         Tkw1dc9DTM0y/cLlzH95mr9I+RGeNgXeZ9nRzbW1VQ4MQui4hZingjJI5UZif3uMCoZu
         Qvwg==
X-Gm-Message-State: AGRZ1gIkRLJNsrzUwEtUktiek0jmiOM5gwe6fmq7u4gpU+S/opW5Dm9Q
        A4xE+gCgIQbR88jNuVbFTZ1OyuMx5BFF8SVJcMbC2g==
X-Google-Smtp-Source: AJdET5fpdp5Or8TO69hAQqLyMNq1QsOVwvjOo3bnZScuN6iDU7FT72bWpNctTFEgu3bGM1eUEC8MWYW7+Y3NvHnoCKA=
X-Received: by 2002:a6b:5d18:: with SMTP id r24-v6mr17045168iob.170.1541421478762;
 Mon, 05 Nov 2018 04:37:58 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a6b:4f16:0:0:0:0:0 with HTTP; Mon, 5 Nov 2018 04:37:58 -0800 (PST)
In-Reply-To: <1540808142-33208-2-git-send-email-julien.thierry@arm.com>
References: <1540808142-33208-1-git-send-email-julien.thierry@arm.com> <1540808142-33208-2-git-send-email-julien.thierry@arm.com>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Mon, 5 Nov 2018 13:37:58 +0100
Message-ID: <CAKv+Gu-LogTWHsjPcJDt1PLp0E1kspQoOrkregknp9NXY9nfdg@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] efi/fdt: Indentation fix
To:     Julien Thierry <julien.thierry@arm.com>
Cc:     linux-efi <linux-efi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Joe Perches <joe@perches.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29 October 2018 at 11:15, Julien Thierry <julien.thierry@arm.com> wrote:
> Closing bracket seems to end a for statement when it is actually ending
> the contained if. Add some brackets to have clear delimitation of each
> scope.
>
> No functional change/fix, just fix the indentation.
>
> Signed-off-by: Julien Thierry <julien.thierry@arm.com>
> Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> ---
>  drivers/firmware/efi/libstub/fdt.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/firmware/efi/libstub/fdt.c b/drivers/firmware/efi/libstub/fdt.c
> index 8830fa6..8b6696e 100644
> --- a/drivers/firmware/efi/libstub/fdt.c
> +++ b/drivers/firmware/efi/libstub/fdt.c
> @@ -372,7 +372,7 @@ void *get_fdt(efi_system_table_t *sys_table, unsigned long *fdt_size)
>         tables = (efi_config_table_t *) sys_table->tables;
>         fdt = NULL;
>
> -       for (i = 0; i < sys_table->nr_tables; i++)
> +       for (i = 0; i < sys_table->nr_tables; i++) {
>                 if (efi_guidcmp(tables[i].guid, fdt_guid) == 0) {
>                         fdt = (void *) tables[i].table;
>                         if (fdt_check_header(fdt) != 0) {
> @@ -381,7 +381,8 @@ void *get_fdt(efi_system_table_t *sys_table, unsigned long *fdt_size)
>                         }
>                         *fdt_size = fdt_totalsize(fdt);
>                         break;
> -        }
> +               }
> +       }
>
>         return fdt;
>  }
> --
> 1.9.1
>


Queued in efi/next

Thanks.
