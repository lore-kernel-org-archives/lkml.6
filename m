Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9335C4360F
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 22:06:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 97E762089F
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 22:06:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550700364;
	bh=p0tg7Sp2rtV6ovX/pgZyJKWb9Kb6FEQOn7uJo4II6vI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=y3FKrZxoqgJbRQgwDjNnWZILj//q52VZUlBJExCJZcK2zeRA8agrWTPoBBdpTTBge
	 cIx6pfKn5iDBlll2b6wq/p2lI+O36pY+g4WlMd+3a9TDei619duoz+pEYC7TiRBpry
	 fiGkD289WuCWBGDOocc1v61SPvtvfAWXypqb3Ccw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727338AbfBTWGD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 17:06:03 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:40093 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725826AbfBTWGD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 17:06:03 -0500
Received: by mail-ot1-f67.google.com with SMTP id v20so10965208otk.7;
        Wed, 20 Feb 2019 14:06:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=80wq8RIr4brdNYYPZ3tyyCou77N/Hx2TQOUNzTc41no=;
        b=L7L6aqLvYaNcEN/kIFGHfXn8pm76jL/u4fUJnBRXFVKh17BsKIvHsyijTFV9yplqRe
         DtK1jcwTMOaJKQX4eMmLQ2XHZuJvf1nFCXX+H8R/mHBIyQrDJ0WH5wSkro+MMmg6M5/h
         Gqpfda8LmYA1NnUdwD9KuNjQPaduwWrfMpImKu1oOTNluJWRPxqV446dW7tceHmysJTt
         m3Va0sRGjHIqFdFxry3e1CTfnejD8qRCudjUdeCD5clbeDzPhA5SXoViES4ZjlsojstU
         VarRwnRRMDJ9x43BV/7NDTJ+pymWP0eMS/vgMSTZnaNNzIvmwLMhqKrTl6jpKRmnXpam
         ThsA==
X-Gm-Message-State: AHQUAub3brQ4RiBvE6Ato/lolwQgaieH801965tJ4z3km1A6KujqrCpH
        wA6dKOQf4K04z5eVzFVsOBNr11YFcfteCENxI5k=
X-Google-Smtp-Source: AHgI3IZgSJLWQHESjaz/a33C8nm9iD+15dSEraM1gzX9abpO+ZxRAQ3C6pYxcVetewbDWe7dMB4V9WFZdYSa6ZcLK1Y=
X-Received: by 2002:a9d:5a0b:: with SMTP id v11mr21134786oth.124.1550700361880;
 Wed, 20 Feb 2019 14:06:01 -0800 (PST)
MIME-Version: 1.0
References: <20190214171017.9362-1-keith.busch@intel.com> <20190214171017.9362-10-keith.busch@intel.com>
In-Reply-To: <20190214171017.9362-10-keith.busch@intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 20 Feb 2019 23:05:51 +0100
Message-ID: <CAJZ5v0i6ZD0azWmLWkuzt4Sms+L8+wvKYao8-JCJp0zOgjdx5A@mail.gmail.com>
Subject: Re: [PATCHv6 09/10] acpi/hmat: Register memory side cache attributes
To:     Keith Busch <keith.busch@intel.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Linux API <linux-api@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rafael Wysocki <rafael@kernel.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Dan Williams <dan.j.williams@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 14, 2019 at 6:10 PM Keith Busch <keith.busch@intel.com> wrote:
>
> Register memory side cache attributes with the memory's node if HMAT
> provides the side cache iniformation table.
>
> Signed-off-by: Keith Busch <keith.busch@intel.com>

Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

> ---
>  drivers/acpi/hmat/hmat.c | 32 ++++++++++++++++++++++++++++++++
>  1 file changed, 32 insertions(+)
>
> diff --git a/drivers/acpi/hmat/hmat.c b/drivers/acpi/hmat/hmat.c
> index 6833c4897ff4..e2a15f53fe45 100644
> --- a/drivers/acpi/hmat/hmat.c
> +++ b/drivers/acpi/hmat/hmat.c
> @@ -314,6 +314,7 @@ static __init int hmat_parse_cache(union acpi_subtable_headers *header,
>                                    const unsigned long end)
>  {
>         struct acpi_hmat_cache *cache = (void *)header;
> +       struct node_cache_attrs cache_attrs;
>         u32 attrs;
>
>         if (cache->header.length < sizeof(*cache)) {
> @@ -327,6 +328,37 @@ static __init int hmat_parse_cache(union acpi_subtable_headers *header,
>                 cache->memory_PD, cache->cache_size, attrs,
>                 cache->number_of_SMBIOShandles);
>
> +       cache_attrs.size = cache->cache_size;
> +       cache_attrs.level = (attrs & ACPI_HMAT_CACHE_LEVEL) >> 4;
> +       cache_attrs.line_size = (attrs & ACPI_HMAT_CACHE_LINE_SIZE) >> 16;
> +
> +       switch ((attrs & ACPI_HMAT_CACHE_ASSOCIATIVITY) >> 8) {
> +       case ACPI_HMAT_CA_DIRECT_MAPPED:
> +               cache_attrs.associativity = NODE_CACHE_DIRECT_MAP;
> +               break;
> +       case ACPI_HMAT_CA_COMPLEX_CACHE_INDEXING:
> +               cache_attrs.associativity = NODE_CACHE_INDEXED;
> +               break;
> +       case ACPI_HMAT_CA_NONE:
> +       default:
> +               cache_attrs.associativity = NODE_CACHE_OTHER;
> +               break;
> +       }
> +
> +       switch ((attrs & ACPI_HMAT_WRITE_POLICY) >> 12) {
> +       case ACPI_HMAT_CP_WB:
> +               cache_attrs.write_policy = NODE_CACHE_WRITE_BACK;
> +               break;
> +       case ACPI_HMAT_CP_WT:
> +               cache_attrs.write_policy = NODE_CACHE_WRITE_THROUGH;
> +               break;
> +       case ACPI_HMAT_CP_NONE:
> +       default:
> +               cache_attrs.write_policy = NODE_CACHE_WRITE_OTHER;
> +               break;
> +       }
> +
> +       node_add_cache(pxm_to_node(cache->memory_PD), &cache_attrs);
>         return 0;
>  }
>
> --
> 2.14.4
>
