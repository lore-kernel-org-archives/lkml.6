Return-Path: <SRS0=R5eS=PZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3BF7C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 17:42:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C3D6A20652
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 17:42:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547746963;
	bh=/fwBpxhtjTfvfOBT09ylV2CYDXZ+KI+pdQRA4GC1Vk0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=GBw4eT9NyejsGgXhJtg18sBWqyR/dAupb5+WT9C/JRwUoC8cwljkXDr0mNpmn4V6D
	 I0TB1oA/43Y9uuxPygrM3z0hfHMWXycs7/rDqi7j4EIdsr+4EcPVOZKZtpMySTxUJq
	 paWv2h/UbD28vlODH1pqW9Jqhw7l4kQmz1s09pGM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729400AbfAQRml (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Jan 2019 12:42:41 -0500
Received: from mail-oi1-f172.google.com ([209.85.167.172]:36682 "EHLO
        mail-oi1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725967AbfAQRmk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jan 2019 12:42:40 -0500
Received: by mail-oi1-f172.google.com with SMTP id x23so6830296oix.3;
        Thu, 17 Jan 2019 09:42:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4l33NxMborqisvl0/5peQNrXL5/jqVOWTyG/TbJwZME=;
        b=cPrsR7BWZ/zHeobcQcCJDwdIWmzbPqmKK7KobwivDNYDlMPXXvg7ivsA2SuKj4P43K
         G0oRZe7jNndJGBC5TpFGmpALehnozYKdbFcxG+cpu8fjMYW2Ljwq0pbz2a4jZAPAq3qt
         1B7BT2Ea1Cwu8TcCRkwTowkx9Wh7t+DGyvxT57l5/G+8t9DwzDgPWbmYlYbH2LN8nrIi
         FR4/qlkp6lxjU0ARoKpMFm8UQuTlHG1liVu+4ntydRzfVJVJc5DjOJkWRP3YW1ezDpH1
         aFdGevS10GTgwtfRbh7Fxhj5G+LLr9T+E19tWlRKsbhPhPPwBk9aXfQw3DcnXLXaAt0W
         S/Tg==
X-Gm-Message-State: AJcUukf5Aqpbgd7/bwxeoNCKHVw6Iv8IlBDgrGzXh6IgCOOn7gZtdNaU
        v5I5+4asOW/Uy79yDd/v2Z005dW9owAOSTB7Thc=
X-Google-Smtp-Source: ALg8bN7ZCZU/M8Gzd8tnGaTDyfYGJojPLIitPj6v3VkC0twTsbGW6IJGM7rdOn0kPv0Uyd6CHY/HLFmXvHO4LC8BfTc=
X-Received: by 2002:aca:195:: with SMTP id 143mr5537206oib.322.1547746959614;
 Thu, 17 Jan 2019 09:42:39 -0800 (PST)
MIME-Version: 1.0
References: <20190116175804.30196-1-keith.busch@intel.com> <20190116175804.30196-13-keith.busch@intel.com>
In-Reply-To: <20190116175804.30196-13-keith.busch@intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 17 Jan 2019 18:42:28 +0100
Message-ID: <CAJZ5v0gu0zcyZtHv4mDioS6j4WMsz_59bYdzuGtOPXfKVNOX+g@mail.gmail.com>
Subject: Re: [PATCHv4 12/13] acpi/hmat: Register memory side cache attributes
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

On Wed, Jan 16, 2019 at 6:59 PM Keith Busch <keith.busch@intel.com> wrote:
>
> Register memory side cache attributes with the memory's node if HMAT
> provides the side cache iniformation table.
>
> Signed-off-by: Keith Busch <keith.busch@intel.com>
> ---
>  drivers/acpi/hmat/hmat.c | 32 ++++++++++++++++++++++++++++++++
>  1 file changed, 32 insertions(+)
>
> diff --git a/drivers/acpi/hmat/hmat.c b/drivers/acpi/hmat/hmat.c
> index 45e20dc677f9..9efdd0a63a79 100644
> --- a/drivers/acpi/hmat/hmat.c
> +++ b/drivers/acpi/hmat/hmat.c
> @@ -206,6 +206,7 @@ static __init int hmat_parse_cache(union acpi_subtable_headers *header,
>                                    const unsigned long end)
>  {
>         struct acpi_hmat_cache *cache = (void *)header;
> +       struct node_cache_attrs cache_attrs;
>         u32 attrs;
>
>         if (cache->header.length < sizeof(*cache)) {
> @@ -219,6 +220,37 @@ static __init int hmat_parse_cache(union acpi_subtable_headers *header,
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

This looks slightly odd as "default" covers the other case as well.
Maybe say what other case is covered by "default" in particular in a
comment?

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

And analogously here.

> +               cache_attrs.write_policy = NODE_CACHE_WRITE_OTHER;
> +               break;
> +       }
> +
> +       node_add_cache(pxm_to_node(cache->memory_PD), &cache_attrs);
>         return 0;
>  }
>
> --
