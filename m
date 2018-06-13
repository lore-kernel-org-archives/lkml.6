Return-Path: <SRS0=lWsm=I7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 0B083C004E4
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 08:54:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B5DC62086A
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 08:54:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E21Fjgsc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B5DC62086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934834AbeFMIyu (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Jun 2018 04:54:50 -0400
Received: from mail-ua0-f193.google.com ([209.85.217.193]:40857 "EHLO
        mail-ua0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754478AbeFMIyq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jun 2018 04:54:46 -0400
Received: by mail-ua0-f193.google.com with SMTP id l11-v6so1198768uak.7;
        Wed, 13 Jun 2018 01:54:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=a3qxDkiAN4hKwO5cZ7g8VB8eVH6YSO4iBLN1kEWxHRE=;
        b=E21FjgscgR7qST/Q+Ll3A/0w89TxfmmgGm+J/x/o6HYnvjOKN7xlMOarN+gPP0Bs5C
         eN8PpozgvUnmlkof+57wbpiPHF17jlH9JAPxa0Jxulof8q0siDy+QsHEInWCPnkfyz1v
         xMnORp2qo4ctLxdOsu4tBbFz1qygDRQS78RBcDg8eme2kO/J7pjf5QEVmHYGBfkZvAfC
         GmW26CynU60MzBIni8ewet4DRAMuj/AKuVwSKiD4FfO6hq1hcJCWDfcYNuPGAjgBtX7J
         DKHqdHApmD6GqbatmxUXY6qtFE9mYSlM2EhDn/WWaDysfqqPmIoIC0pZO5LURjYZvG+d
         XSbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=a3qxDkiAN4hKwO5cZ7g8VB8eVH6YSO4iBLN1kEWxHRE=;
        b=h4TIPyaBkPHAVKtQrGNqlhmbntB3MuNHAn8814zhl8GZajiFnRUQuUcwwW2mgEnCNi
         v3fh0j6jXrqM2GOtXSiUsUjpKaNkGcJTmhL2Mdl7ftNSPWvB4xNISQQ+6/Njvi9X77/X
         6gNdaJfxuEc5zqGHG15Kdf5W/t0BTvWESD7uoNEMNzjszDMdWMF/0NSND+LoERqAJ6Zo
         q0blBThdIiD8box33P6Se1IATDZCaE3ijIBi623FzEyN14wE6cMhTsQp0JUhlCvyq9kq
         fwRUFGY6Kjx0xriFMVakaxnaTHC5/3tmBUnVferiKoP7/gQnkBLl83qQwikkmoRZoyWH
         noGQ==
X-Gm-Message-State: APt69E1Z5gRMtvnpQbXbeQgpuIcoBzfI11bEd8Upa/hZO5tPjNnqf/J3
        MsGGsStw+p8jt/TviNWUQ/YkaRC1A3UxRXoIPGQ=
X-Google-Smtp-Source: ADUXVKLIJtKPrumegEUCldF9jxmeuBV5m9I01jHSwPar3m5gfUp/HOhivtX2h4Gcsw8rMxBCI8tCgvF0JQYHsefEvFM=
X-Received: by 2002:ab0:6008:: with SMTP id j8-v6mr2691871ual.28.1528880085894;
 Wed, 13 Jun 2018 01:54:45 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a67:8b02:0:0:0:0:0 with HTTP; Wed, 13 Jun 2018 01:54:45
 -0700 (PDT)
In-Reply-To: <b59027b3-a48e-f168-5f12-c67758c0c2c7@gmail.com>
References: <45b8bde6-aaa8-3f3f-0528-81e5e931751c@gmail.com>
 <bc6846e1-2b6d-dcc2-355c-2699aa1607a2@gmail.com> <CAHp75Vdmqm+r=Orxs6_dCr18y+EwEQ=s-7UgaZKHuKbtjMcOig@mail.gmail.com>
 <20180609010420.GA112645@localhost.localdomain> <CAHp75VcA5ZWahraDP69_hBHuqxw6cng93zAa1op5EBYfuCSPwg@mail.gmail.com>
 <b59027b3-a48e-f168-5f12-c67758c0c2c7@gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 13 Jun 2018 11:54:45 +0300
Message-ID: <CAHp75VcK78jL_7sF+ZGaPpwDED-6Xd+SdH_5WCfSBsVJW2GnDg@mail.gmail.com>
Subject: Re: [PATCH v3] dcdbas: Add support for WSMT ACPI table
To:     Stuart Hayes <stuart.w.hayes@gmail.com>
Cc:     Darren Hart <dvhart@infradead.org>, Douglas_Warzecha@dell.com,
        Mario Limonciello <mario.limonciello@dell.com>,
        Jared.Dominguez@dell.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 13, 2018 at 4:24 AM, Stuart Hayes <stuart.w.hayes@gmail.com> wrote:
>
> If the WSMT ACPI table is present and indicates that a fixed communication
> buffer should be used, use the firmware-specified buffer instead of
> allocating a buffer in memory for communications between the dcdbas driver
> and firmare.

Thanks for an update. My comments below.

> -       if ((pos + count) > MAX_SMI_DATA_BUF_SIZE)
> +       if ((pos + count) > max_smi_data_buf_size)
>                 return -EINVAL;

Parens are redundant, but okay, not purpose of the change.

> +               /* Calling Interface SMI

I suppose the style of the comments like
/*
 * Calling ...
...

> +                *
> +                * Provide physical address of command buffer field within
> +                * the struct smi_cmd... can't use virt_to_phys on smi_cmd
> +                * because address may be from memremap.

Wait, memremap() might return a virtual address. How we be sure that
we got still physical address here?

(Also note () when referring to functions)

> +                */
> +               smi_cmd->ebx = smi_data_buf_phys_addr +
> +                               offsetof(struct smi_cmd, command_buffer);

Btw, can it be one line (~83 character are okay for my opinion).

> +       acpi_get_table(ACPI_SIG_WSMT, 0, (struct acpi_table_header **)&wsmt);
> +       if (!wsmt)
> +               return 0;
> +
> +       /* Check if WSMT ACPI table shows that protection is enabled */
> +       if (!(wsmt->protection_flags & ACPI_WSMT_FIXED_COMM_BUFFERS)

> +           || !(wsmt->protection_flags
> +                & ACPI_WSMT_COMM_BUFFER_NESTED_PTR_PROTECTION))

Better to indent like

if (... ||
 !(... & ...)

> +               return 0;
> +
> +       /* Scan for EPS (entry point structure) */
> +       for (addr = (u8 *)__va(0xf0000);
> +            addr < (u8 *)__va(0x100000 - sizeof(struct smm_eps_table));

> +            addr += 1) {

This wasn't commented IIRC and changed. So, why?

-- 
With Best Regards,
Andy Shevchenko
