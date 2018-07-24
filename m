Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF0BEECDFB8
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 11:32:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 654DD20874
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 11:32:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VoAQCPb8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 654DD20874
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388520AbeGXMiB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 08:38:01 -0400
Received: from mail-yb0-f194.google.com ([209.85.213.194]:37650 "EHLO
        mail-yb0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388319AbeGXMiB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 08:38:01 -0400
Received: by mail-yb0-f194.google.com with SMTP id r3-v6so1480391ybo.4
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jul 2018 04:32:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=z78ND5nftUgqY8GaFw6j80HCAgnx0V2v4Z9DuPZlxtc=;
        b=VoAQCPb8VgPSM4WjW/zgMuVty9spfjv81DJzduvq8cBLejZeU7DxnpFoe8PDCudkDd
         lHx2MSEnbJqRxVgz2lwAidufxhTyFXr66wwnUC2Zg1IxmZU/mTOcuUyPP1kKKorC+L6S
         ggbGWPulMOre6rt+8JPSa8awLorwlaar/hMR7JfO7y2Skb1SDRyAKPQh0QNxajbuASCY
         RhAzA7JiJCcXy3EieURahhcfYIQxuafljlzZceGXx9hlEwxfBIrjSNx7maY3uftXbqwZ
         IGpq4pOUFSc1iKZI814FKQuRo0ZbXERXSYMjDHI4q6wfQKL+a31qg+/KKzxvnTKy/in2
         hWJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=z78ND5nftUgqY8GaFw6j80HCAgnx0V2v4Z9DuPZlxtc=;
        b=Z+5Xi5uwd1KqLnePuOUMEpDMs3snkjfGZh5lZNKYP2SAKLrMhtE2siIJe0+IV546co
         e/4FtcX3UEWYK0KuAvmTf3/nAAYEghd+JC62YgUJD3Nu97enICnTuyLyRkwLDoWQJiUW
         d4VE126eiYw/iqFhtrNvXqvEeuIqtqnfvIDHmESL4VYwQ3GXep9/jY5/QBPpypPKqo2O
         65fqfJoTgq9K1f7Zi1qEfmW6NkuRP/7MmLF/YF/dcMo2TGyHotuiHcIbh/8HqaGauDlm
         MrgM2fMjCgPLOScCfuQwcqp2AJ2YILFhoJBIQuVI6fpHeX3pkI2uyEQisV42cjS4DLfU
         AdiQ==
X-Gm-Message-State: AOUpUlGVVvq/kD3VTvDUs31ck9Kw7NshWMKZ5yxCqZlvsF90ES2M/4tD
        2qa8yCKjrvwSDWA/DMYRIKE+X7ZlvJyhQ7Xyb8mL
X-Google-Smtp-Source: AAOMgpcKpUeLvTJL/vyTwe2ZPcCFHxZEDgVIqy5YNHmuRXnDPGbJmuqPqrMNak4PCsFv+Z2TAFPPBzttKwFw7HyIq3Q=
X-Received: by 2002:a25:4645:: with SMTP id t66-v6mr8838585yba.324.1532431919557;
 Tue, 24 Jul 2018 04:31:59 -0700 (PDT)
MIME-Version: 1.0
References: <20180724093924.1752416-1-arnd@arndb.de>
In-Reply-To: <20180724093924.1752416-1-arnd@arndb.de>
From:   Bjorn Helgaas <bhelgaas@google.com>
Date:   Tue, 24 Jul 2018 06:31:47 -0500
Message-ID: <CAErSpo4wWZGgxWwjLjds7qh9UmMpas4G7jR8UK8AdL8gbfz-rA@mail.gmail.com>
Subject: Re: [PATCH] PCI: fix unused variable warning
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
        james.puthukattukaran@oracle.com,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        linux-pci@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Anders Roxell <anders.roxell@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[+cc Anders]

On Tue, Jul 24, 2018 at 4:39 AM Arnd Bergmann <arnd@arndb.de> wrote:
>
> The newly introduced function produces a warning without CONFIG_PCI_QUIRKS:
>
> drivers/pci/probe.c: In function 'pci_bus_read_dev_vendor_id':
> drivers/pci/probe.c:2221:18: error: unused variable 'bridge' [-Werror=unused-variable]
>
> Move the variable declaration into that #ifdef to avoid the warning.
>
> Fixes: ac5ea104a279 ("PCI: Workaround IDT switch ACS Source Validation erratum")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Fixed already with a patch from Anders Roxell
<anders.roxell@linaro.org>, thanks!

> ---
>  drivers/pci/probe.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> index 1c581346c5b9..7a5323798312 100644
> --- a/drivers/pci/probe.c
> +++ b/drivers/pci/probe.c
> @@ -2218,9 +2218,9 @@ bool pci_bus_generic_read_dev_vendor_id(struct pci_bus *bus, int devfn, u32 *l,
>  bool pci_bus_read_dev_vendor_id(struct pci_bus *bus, int devfn, u32 *l,
>                                 int timeout)
>  {
> +#ifdef CONFIG_PCI_QUIRKS
>         struct pci_dev *bridge = bus->self;
>
> -#ifdef CONFIG_PCI_QUIRKS
>         /*
>          * Certain IDT switches have an issue where they improperly trigger
>          * ACS Source Validation errors on completions for config reads.
> --
> 2.18.0
>
