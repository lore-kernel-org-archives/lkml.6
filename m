Return-Path: <SRS0=6aQE=N4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 989C8C43441
	for <linux-kernel@archiver.kernel.org>; Sat, 17 Nov 2018 02:46:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D84C20868
	for <linux-kernel@archiver.kernel.org>; Sat, 17 Nov 2018 02:46:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mC1w84XJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4D84C20868
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729996AbeKQNBZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 17 Nov 2018 08:01:25 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:43843 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727116AbeKQNBY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Nov 2018 08:01:24 -0500
Received: by mail-wr1-f67.google.com with SMTP id r10so9158593wrs.10
        for <linux-kernel@vger.kernel.org>; Fri, 16 Nov 2018 18:46:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=m/1yZsYeuQnTiY6Q1XHTf0zV25iE9ci4eniauG/Lbh8=;
        b=mC1w84XJGzvAUX1BdEomofZA2AWsY2831t0md13Fu7x7SA4y7d8SEGQlfoc2pMaarR
         jnCrUL7wpo6iWLNgc70ERCnQqgOtWJB7ZKdo3lE5eqqgmbFjtxfm3p/XXxSoRAMINrI/
         An5QVaiY9qAu7M4jYIIZ1l9BYjkTqp32RPl9KlqxZQgZ0/K3Af2GwmTOPFShvjm/8/Tu
         HFIfJZLocgGr6N0rzB0nJ12VdMwJ/xgm1mBR/phrdw3keuGdLu6Fi5BrOxdIxrdVdzGs
         b8bCMQhm+yZ7dApMWQkAV47/B79a+TwZ5inobt6U6xEtovpF1Q2Z0MAxPCkZ4/GmjGgz
         O5ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=m/1yZsYeuQnTiY6Q1XHTf0zV25iE9ci4eniauG/Lbh8=;
        b=cGLBjvfzhe7XcQi4lpfEyXHmtLCkPQL5uIjB5O8o3TnFgOtIEMpPjxVd09bvbkX3Cg
         cPjkfmAxAEt7OC4F2Lr4QNphXhIWTl9QXWIqFi8hY7UNQIYTBzVhinkTVlwHuE2TXSqr
         LU789cGyGBCUL+JativRaeBW8uLh16Etc0qr8VCgb9fIhk6jGygFKmEDzfu07uR9NaZs
         azaPw7LtDpnlETacUqwwQuDXDYV7jQvK4cLuBMd6wChjh4ZBN3u9ZLf44Lel8MHryqiW
         njpustLlFba9NdoDXymmYH+/FOeZTAOMGoP2IvjEt0FR9jiiGwTVQF6llQEVy4YGK2Zz
         J+7w==
X-Gm-Message-State: AGRZ1gJqzAfn5h2jgWR6h0bNS9fZDmE1KMKtMwRMtR5WtfhYYXRsl3s6
        0+6lNId3v8HgjK/CryXINWNMHmQXenbWNBBv0PjYXw==
X-Google-Smtp-Source: AJdET5e0IDttORQsK6sA5h8d64nudNgTHNOJVvYKn8BJhOw6OEZMSZAt0TDw0EHT/IHMXABP9lsvmNN8r3ppYt2i53A=
X-Received: by 2002:adf:a2cc:: with SMTP id t12-v6mr11914905wra.100.1542422782428;
 Fri, 16 Nov 2018 18:46:22 -0800 (PST)
MIME-Version: 1.0
References: <20181110050434.GA18281@rdeal-VirtualBox>
In-Reply-To: <20181110050434.GA18281@rdeal-VirtualBox>
From:   Todd Poynor <toddpoynor@google.com>
Date:   Fri, 16 Nov 2018 18:46:10 -0800
Message-ID: <CAAW3YpZV_9orrAdkXCuZ_ciab-P14EfsCajdm1M7n3y45NCWQQ@mail.gmail.com>
Subject: Re: [PATCH] staging: gasket: formatting fixes
To:     robert.edward.deal@gmail.com
Cc:     Rob Springer <rspringer@google.com>, benchan@chromium.org,
        Greg KH <gregkh@linuxfoundation.org>,
        devel@driverdev.osuosl.org, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 12, 2018 at 1:27 PM Robert Deal
<robert.edward.deal@gmail.com> wrote:
>
> Reformat arguments in a few functions in gasket_page_table.c to better
> follow linux kernel formatting standards.
>
> Signed-off-by: Robert Deal <robert.edward.deal@gmail.com>
> ---
>  drivers/staging/gasket/gasket_page_table.c | 24 ++++++++++------------
>  1 file changed, 11 insertions(+), 13 deletions(-)
>
> diff --git a/drivers/staging/gasket/gasket_page_table.c b/drivers/staging/gasket/gasket_page_table.c
> index f5253ba9a430..26755d9ca41d 100644
> --- a/drivers/staging/gasket/gasket_page_table.c
> +++ b/drivers/staging/gasket/gasket_page_table.c
> @@ -1088,9 +1088,9 @@ void gasket_page_table_reset(struct gasket_page_table *pg_tbl)
>  }
>
>  /* See gasket_page_table.h for description. */
> -int gasket_page_table_lookup_page(
> -       struct gasket_page_table *pg_tbl, ulong dev_addr, struct page **ppage,
> -       ulong *poffset)
> +int gasket_page_table_lookup_page(struct gasket_page_table *pg_tbl,
> +                                 ulong dev_addr, struct page **ppage,
> +                                 ulong *poffset)
>  {
>         uint page_num;
>         struct gasket_page_table_entry *pte;
> @@ -1134,9 +1134,9 @@ int gasket_page_table_lookup_page(
>  }
>
>  /* See gasket_page_table.h for description. */
> -bool gasket_page_table_are_addrs_bad(
> -       struct gasket_page_table *pg_tbl, ulong host_addr, ulong dev_addr,
> -       ulong bytes)
> +bool gasket_page_table_are_addrs_bad(struct gasket_page_table *pg_tbl,
> +                                    ulong host_addr, ulong dev_addr,
> +                                    ulong bytes)
>  {
>         if (host_addr & (PAGE_SIZE - 1)) {
>                 dev_err(pg_tbl->device,
> @@ -1150,8 +1150,8 @@ bool gasket_page_table_are_addrs_bad(
>  EXPORT_SYMBOL(gasket_page_table_are_addrs_bad);
>
>  /* See gasket_page_table.h for description. */
> -bool gasket_page_table_is_dev_addr_bad(
> -       struct gasket_page_table *pg_tbl, ulong dev_addr, ulong bytes)
> +bool gasket_page_table_is_dev_addr_bad(struct gasket_page_table *pg_tbl,
> +                                      ulong dev_addr, ulong bytes)
>  {
>         uint num_pages = bytes / PAGE_SIZE;
>
> @@ -1226,9 +1226,8 @@ int gasket_page_table_system_status(struct gasket_page_table *page_table)
>  }
>
>  /* Record the host_addr to coherent dma memory mapping. */
> -int gasket_set_user_virt(
> -       struct gasket_dev *gasket_dev, u64 size, dma_addr_t dma_address,
> -       ulong vma)
> +int gasket_set_user_virt(struct gasket_dev *gasket_dev, u64 size,
> +                        dma_addr_t dma_address, ulong vma)
>  {
>         int j;
>         struct gasket_page_table *pg_tbl;
> @@ -1346,8 +1345,7 @@ int gasket_free_coherent_memory(struct gasket_dev *gasket_dev, u64 size,
>  }
>
>  /* Release all coherent memory. */
> -void gasket_free_coherent_memory_all(
> -       struct gasket_dev *gasket_dev, u64 index)
> +void gasket_free_coherent_memory_all(struct gasket_dev *gasket_dev, u64 index)
>  {
>         if (!gasket_dev->page_table[index])
>                 return;
> --
> 2.17.1
>

Acked-by: Todd Poynor <toddpoynor@google.com>

Thanks!
