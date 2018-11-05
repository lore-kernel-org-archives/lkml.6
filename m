Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BE69C0044C
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 12:41:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E1E2B20825
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 12:41:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="PIicIM+l"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E1E2B20825
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729731AbeKEWBD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Nov 2018 17:01:03 -0500
Received: from mail-it1-f196.google.com ([209.85.166.196]:52790 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729184AbeKEWBC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Nov 2018 17:01:02 -0500
Received: by mail-it1-f196.google.com with SMTP id t190-v6so6679320itb.2
        for <linux-kernel@vger.kernel.org>; Mon, 05 Nov 2018 04:41:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=pt5KHoWI6l6iI5z9KDB7wQV3P5aeR/3gwZloRf/Y0hU=;
        b=PIicIM+lkkNpGqUly2nHS/9q9/lXjDCOVxEIRwpxriFqcRlTMlDwCXR1T3zUIg31/B
         pZXa2wSNC3j9HeP4duc3yFTanRvtEYxI/2Dq2s10v7QSSa+eqk6p35XBztCv/hY5lAfA
         CE6zeW5gjOysjky49BMP41ryuNtMHHkgjyx9k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=pt5KHoWI6l6iI5z9KDB7wQV3P5aeR/3gwZloRf/Y0hU=;
        b=Lils3fQ6kVuF2NvJWzx527X0B9fRcTUFHdRljyebbnxso6pjN25oMkFpasR3A2IbvC
         YAqSstUIo9RLB114Rb2psULmBkGNQUvFDF2oXwk13+NLZ7wo3SuFZJ/1VAaMmEYwbotb
         jJjH04toMeL2QkL2ud8WQOnO7x3Pl2Yjc5IAjilTecSeAPuEhE8mJ37u8cgRIw/Tm8du
         Uq/JVQhz6RNITlpvVz4w/aJoCu3L297MFs6MRnQt+Qzmr2FWQmHdRpXK9V/UaT9nZBoT
         npKC0iY5/CtfjuZmKBOE9+rFSH1/RAMhvoiFE7ayhHoHxykDYSSk9pd5Qa29i9rHotpZ
         frPQ==
X-Gm-Message-State: AGRZ1gK5Z1Rl+bzrxAHiTHii1RVzdp2okpBe3fGF9LFoHQuZ0Sfb0piY
        hmOulrbeuBdycDhepNAJ8JXjUoIX66KLZEiPgXqW2w==
X-Google-Smtp-Source: AJdET5elMqKvGJKfBZZ+JXDLmMF2mgCnkN/ZJ1levLXQi5MLNWRXb7djVdOqxOLVPIKMYwFn7K+bqtoomZyG9rpcUMM=
X-Received: by 2002:a24:d3c2:: with SMTP id n185-v6mr6750907itg.71.1541421688196;
 Mon, 05 Nov 2018 04:41:28 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a6b:4f16:0:0:0:0:0 with HTTP; Mon, 5 Nov 2018 04:41:27 -0800 (PST)
In-Reply-To: <1540808142-33208-3-git-send-email-julien.thierry@arm.com>
References: <1540808142-33208-1-git-send-email-julien.thierry@arm.com> <1540808142-33208-3-git-send-email-julien.thierry@arm.com>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Mon, 5 Nov 2018 13:41:27 +0100
Message-ID: <CAKv+Gu9tERHAibZ+0rE=xAYtKa5M4ZdNudwe3_VpW0ic56FdwA@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] efi/fdt: Simplify get_fdt flow
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
> Reorganize get_fdt lookup loop, clearly showing that:
> - Nothing is done for table entries that do not have fdt_guid
> - Once an entry with fdt_guid is found, break out of the loop
>
> No functional changes.
>
> Signed-off-by: Julien Thierry <julien.thierry@arm.com>
> Suggested-by: Joe Perches <joe@perches.com>
> Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> ---
>  drivers/firmware/efi/libstub/fdt.c | 25 +++++++++++++------------
>  1 file changed, 13 insertions(+), 12 deletions(-)
>
> diff --git a/drivers/firmware/efi/libstub/fdt.c b/drivers/firmware/efi/libstub/fdt.c
> index 8b6696e..5b7e2b3 100644
> --- a/drivers/firmware/efi/libstub/fdt.c
> +++ b/drivers/firmware/efi/libstub/fdt.c
> @@ -366,23 +366,24 @@ void *get_fdt(efi_system_table_t *sys_table, unsigned long *fdt_size)
>  {
>         efi_guid_t fdt_guid = DEVICE_TREE_GUID;
>         efi_config_table_t *tables;
> -       void *fdt;
>         int i;
>
> -       tables = (efi_config_table_t *) sys_table->tables;
> -       fdt = NULL;
> +       tables = (efi_config_table_t *)sys_table->tables;
>
>         for (i = 0; i < sys_table->nr_tables; i++) {
> -               if (efi_guidcmp(tables[i].guid, fdt_guid) == 0) {
> -                       fdt = (void *) tables[i].table;
> -                       if (fdt_check_header(fdt) != 0) {
> -                               pr_efi_err(sys_table, "Invalid header detected on UEFI supplied FDT, ignoring ...\n");
> -                               return NULL;
> -                       }
> -                       *fdt_size = fdt_totalsize(fdt);
> -                       break;
> +               void *fdt;
> +
> +               if (efi_guidcmp(tables[i].guid, fdt_guid) != 0)
> +                       continue;
> +
> +               fdt = (void *) tables[i].table;
> +               if (fdt_check_header(fdt) != 0) {
> +                       pr_efi_err(sys_table, "Invalid header detected on UEFI supplied FDT, ignoring ...\n");
> +                       return NULL;
>                 }
> +               *fdt_size = fdt_totalsize(fdt);
> +               return fdt;
>         }
>
> -       return fdt;
> +       return NULL;
>  }
> --
> 1.9.1
>

Queued in efi/next

Thanks.
