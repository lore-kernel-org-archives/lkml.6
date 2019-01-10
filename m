Return-Path: <SRS0=lBHl=PS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C277C43444
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 15:36:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D083E214C6
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 15:36:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547134574;
	bh=MqOpU4kypkOPs9atMDeKOvrBjZaFcVyWeBQKjhm66Ig=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=lCRKaJE748u+e3FWbEC1T4jzDjK294qAcmUskl0YV9TQXhSHFkwdViWM21J7Qm/DL
	 58S1XVPA1rjKv2te7886HxcC6F/QEXhNPKZKbVJM/n+XqCe956FDOTOYuANSG6rN7K
	 djvcHeeeQnCmazpXFd+sY2eviF2UPS5mgvLdbugc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729343AbfAJPgN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Jan 2019 10:36:13 -0500
Received: from mail-oi1-f180.google.com ([209.85.167.180]:42177 "EHLO
        mail-oi1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727753AbfAJPgN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jan 2019 10:36:13 -0500
Received: by mail-oi1-f180.google.com with SMTP id w13so9559391oiw.9;
        Thu, 10 Jan 2019 07:36:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UiU+kA6pOL4I/NJ8tGII0wrxzss2hVQQaB07bU+wRUs=;
        b=DiVVN6LQm+UZGFcdpP2kIgLOHxq/pLLhNAu0CDQ78RVjzHGZV32PbVS6zlnb8HIygs
         dMpjdT+NLNpHOROssWTZHJDp02mUTZweHBPZ5t6I0YmuCZRtwKGlb04sVpHckDc5D11L
         +bZnzLA74BWOnOAdGg/opzGjqWwtMEk5SHoHkIfnp7o3PB9oSAfLgXchAsowFQZka60Y
         YuUjRdEigoUv9BUm8vmif+ki9fus+PkM/x47tBr1Aehz3PrAMHGu9HlNPC2TEOKSlqYc
         tYR072W1xcpkuRQ0Bb9OVnEd32tAmCa/jeXcDH3GsA6QOkHBxAlIRb78ZJI5bHshfj0Q
         Thsg==
X-Gm-Message-State: AJcUukfyzpsxJ/tmq4t/NmYVvBsGpzP14R6Mptr7UJ25+AI0XAR6NfNt
        +MTPXKfVmNIZX4OhRSkh60i1LQWXEGBEezSkMX4=
X-Google-Smtp-Source: ALg8bN66yvy4aWxFnPpM3qIPLZztg5sJXcCuuPHEy4wLOCflX88+A8EMxVn/8pB4NPvGmkXodmS3t+NShQxSG2ysr5Y=
X-Received: by 2002:aca:368a:: with SMTP id d132mr7178539oia.193.1547134572310;
 Thu, 10 Jan 2019 07:36:12 -0800 (PST)
MIME-Version: 1.0
References: <20190109174341.19818-1-keith.busch@intel.com> <20190109174341.19818-3-keith.busch@intel.com>
In-Reply-To: <20190109174341.19818-3-keith.busch@intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 10 Jan 2019 16:36:01 +0100
Message-ID: <CAJZ5v0j40_+-Jjbu4miBKUt8Gnw817G_r1rgCxWHoa9oH-a-Tg@mail.gmail.com>
Subject: Re: [PATCHv3 02/13] acpi: Add HMAT to generic parsing tables
To:     Keith Busch <keith.busch@intel.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rafael Wysocki <rafael@kernel.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Dan Williams <dan.j.williams@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 9, 2019 at 6:47 PM Keith Busch <keith.busch@intel.com> wrote:
>
> The Heterogeneous Memory Attribute Table (HMAT) header has different
> field lengths than the existing parsing uses. Add the HMAT type to the
> parsing rules so it may be generically parsed.
>
> Cc: Dan Williams <dan.j.williams@intel.com>
> Signed-off-by: Keith Busch <keith.busch@intel.com>

Reviewed-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

> ---
>  drivers/acpi/tables.c | 9 +++++++++
>  include/linux/acpi.h  | 1 +
>  2 files changed, 10 insertions(+)
>
> diff --git a/drivers/acpi/tables.c b/drivers/acpi/tables.c
> index 967e1168becf..d9911cd55edc 100644
> --- a/drivers/acpi/tables.c
> +++ b/drivers/acpi/tables.c
> @@ -51,6 +51,7 @@ static int acpi_apic_instance __initdata;
>
>  enum acpi_subtable_type {
>         ACPI_SUBTABLE_COMMON,
> +       ACPI_SUBTABLE_HMAT,
>  };
>
>  struct acpi_subtable_entry {
> @@ -232,6 +233,8 @@ acpi_get_entry_type(struct acpi_subtable_entry *entry)
>         switch (entry->type) {
>         case ACPI_SUBTABLE_COMMON:
>                 return entry->hdr->common.type;
> +       case ACPI_SUBTABLE_HMAT:
> +               return entry->hdr->hmat.type;
>         }
>         return 0;
>  }
> @@ -242,6 +245,8 @@ acpi_get_entry_length(struct acpi_subtable_entry *entry)
>         switch (entry->type) {
>         case ACPI_SUBTABLE_COMMON:
>                 return entry->hdr->common.length;
> +       case ACPI_SUBTABLE_HMAT:
> +               return entry->hdr->hmat.length;
>         }
>         return 0;
>  }
> @@ -252,6 +257,8 @@ acpi_get_subtable_header_length(struct acpi_subtable_entry *entry)
>         switch (entry->type) {
>         case ACPI_SUBTABLE_COMMON:
>                 return sizeof(entry->hdr->common);
> +       case ACPI_SUBTABLE_HMAT:
> +               return sizeof(entry->hdr->hmat);
>         }
>         return 0;
>  }
> @@ -259,6 +266,8 @@ acpi_get_subtable_header_length(struct acpi_subtable_entry *entry)
>  static enum acpi_subtable_type __init
>  acpi_get_subtable_type(char *id)
>  {
> +       if (strncmp(id, ACPI_SIG_HMAT, 4) == 0)
> +               return ACPI_SUBTABLE_HMAT;
>         return ACPI_SUBTABLE_COMMON;
>  }
>
> diff --git a/include/linux/acpi.h b/include/linux/acpi.h
> index 7c3c4ebaded6..53f93dff171c 100644
> --- a/include/linux/acpi.h
> +++ b/include/linux/acpi.h
> @@ -143,6 +143,7 @@ enum acpi_address_range_id {
>  /* Table Handlers */
>  union acpi_subtable_headers {
>         struct acpi_subtable_header common;
> +       struct acpi_hmat_structure hmat;
>  };
>
>  typedef int (*acpi_tbl_table_handler)(struct acpi_table_header *table);
> --
> 2.14.4
>
