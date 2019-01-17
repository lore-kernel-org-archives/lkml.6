Return-Path: <SRS0=R5eS=PZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D08FC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 15:21:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4921E205C9
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 15:21:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547738492;
	bh=rfVhgYO/9Jz6NJBuNfSBUv6uW7LxHQBgi0UCGL2YdlA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=ViFPOgfayY47OfU7Bjgp8cZwFmvmfV0kUMEc7NLloW4Hz2GodnnIO+k92+gAfBEqK
	 bAbtxk58H6I4BDtUT7waFhuSqHZDHNs+4iVaIJ4S8953tzI/iVJqMzJK1wGqDloSPk
	 jU31yA/VX1CVApBBEFKwrT3D+2GAo4MfzqNHILAc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728410AbfAQPVa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Jan 2019 10:21:30 -0500
Received: from mail-oi1-f194.google.com ([209.85.167.194]:44259 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727306AbfAQPV3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jan 2019 10:21:29 -0500
Received: by mail-oi1-f194.google.com with SMTP id m6so6394203oig.11;
        Thu, 17 Jan 2019 07:21:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gO0CRcGYzFQ3a4ks8/KW/sDVv+Nz1F5Jm24CDMNgFDM=;
        b=ci9lTKCiW8AlmY1lot0S5jr8KBM4HL7GZFaHOPyiaxKI8UKO6DMbmHkgK2w7IWTXt/
         dNOu+/Y57m0PSTjMzRimZRg9kI2DXS/XPl/BDOoc0Q6Q3qfgW25S3BDrUz08tFhyP345
         VSr5XThZLPaJJFxpU2CpoHIdjpKo7h0viD7uXKFDW/hN0GdPRjDcAOVpBQjVnvY+zAvE
         afnCKUNNT5uKtmGsHAGlohM4Szvn0bOkTYXtVm7EY1lqZy3YyBp2rKeDDbwXhhQBA026
         /Z83XnXR/LdYv+1awUzXKNHddx8xKGxt9F/IkPR7FSakEYi/muMwBZo4d+JxYJbrqgv3
         mgbQ==
X-Gm-Message-State: AJcUukcqzTuUMGY8qf9HEDBAdTFZAV5g8qlYzOMffpL+f0J4cre6ryDb
        3yDyA8M2+1W/QnJ1mzcN2E326iUWCLWBZcpB0KQ=
X-Google-Smtp-Source: ALg8bN4dV+8tV9gxc+vINbtTgdtmZW9Wee2gDi6uyf9uehcf/xCJ3ZeP8cGX6j3dPv5tvCCqiJbha2VCFnpXLriGERs=
X-Received: by 2002:aca:e715:: with SMTP id e21mr8039215oih.76.1547738488501;
 Thu, 17 Jan 2019 07:21:28 -0800 (PST)
MIME-Version: 1.0
References: <20190116175804.30196-1-keith.busch@intel.com> <20190116175804.30196-10-keith.busch@intel.com>
In-Reply-To: <20190116175804.30196-10-keith.busch@intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 17 Jan 2019 16:21:16 +0100
Message-ID: <CAJZ5v0hFFZjMNr+_iRRvTE7XMsw1+2hOQDPuT6PD6UnAjjxoZw@mail.gmail.com>
Subject: Re: [PATCHv4 09/13] acpi/hmat: Register performance attributes
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
> Save the best performace access attributes and register these with the
> memory's node if HMAT provides the locality table. While HMAT does make
> it possible to know performance for all possible initiator-target
> pairings, we export only the best pairings at this time.
>
> Signed-off-by: Keith Busch <keith.busch@intel.com>
> ---
>  drivers/acpi/hmat/Kconfig |  1 +
>  drivers/acpi/hmat/hmat.c  | 34 ++++++++++++++++++++++++++++++++++
>  2 files changed, 35 insertions(+)
>
> diff --git a/drivers/acpi/hmat/Kconfig b/drivers/acpi/hmat/Kconfig
> index a4034d37a311..20a0e96ba58a 100644
> --- a/drivers/acpi/hmat/Kconfig
> +++ b/drivers/acpi/hmat/Kconfig
> @@ -2,6 +2,7 @@
>  config ACPI_HMAT
>         bool "ACPI Heterogeneous Memory Attribute Table Support"
>         depends on ACPI_NUMA
> +       select HMEM_REPORTING

If you want HMEM_REPORTING to be only set when ACPI_HMAT is set, then
don't make HMEM_REPORTING user-selectable.

>         help
>          Parses representation of the ACPI Heterogeneous Memory Attributes
>          Table (HMAT) and set the memory node relationships and access
> diff --git a/drivers/acpi/hmat/hmat.c b/drivers/acpi/hmat/hmat.c
> index efb33c74d1a3..45e20dc677f9 100644
> --- a/drivers/acpi/hmat/hmat.c
> +++ b/drivers/acpi/hmat/hmat.c
> @@ -23,6 +23,8 @@ struct memory_target {
>         struct list_head node;
>         unsigned int memory_pxm;
>         unsigned long p_nodes[BITS_TO_LONGS(MAX_NUMNODES)];
> +       bool hmem_valid;
> +       struct node_hmem_attrs hmem;
>  };
>
>  static __init struct memory_target *find_mem_target(unsigned int m)
> @@ -108,6 +110,34 @@ static __init void hmat_update_access(u8 type, u32 value, u32 *best)
>         }
>  }
>
> +static __init void hmat_update_target(struct memory_target *t, u8 type,
> +                                     u32 value)
> +{
> +       switch (type) {
> +       case ACPI_HMAT_ACCESS_LATENCY:
> +               t->hmem.read_latency = value;
> +               t->hmem.write_latency = value;
> +               break;
> +       case ACPI_HMAT_READ_LATENCY:
> +               t->hmem.read_latency = value;
> +               break;
> +       case ACPI_HMAT_WRITE_LATENCY:
> +               t->hmem.write_latency = value;
> +               break;
> +       case ACPI_HMAT_ACCESS_BANDWIDTH:
> +               t->hmem.read_bandwidth = value;
> +               t->hmem.write_bandwidth = value;
> +               break;
> +       case ACPI_HMAT_READ_BANDWIDTH:
> +               t->hmem.read_bandwidth = value;
> +               break;
> +       case ACPI_HMAT_WRITE_BANDWIDTH:
> +               t->hmem.write_bandwidth = value;
> +               break;
> +       }
> +       t->hmem_valid = true;

What if 'type' is none of the above?  After all these values come from
the firmware and that need not be correct.

Do you still want to set hmem_valid in that case?

> +}
> +
>  static __init int hmat_parse_locality(union acpi_subtable_headers *header,
>                                       const unsigned long end)
>  {
> @@ -166,6 +196,8 @@ static __init int hmat_parse_locality(union acpi_subtable_headers *header,
>                                         set_bit(p_node, t->p_nodes);
>                         }
>                 }
> +               if (t && best)
> +                       hmat_update_target(t, type, best);
>         }
>         return 0;
>  }
> @@ -267,6 +299,8 @@ static __init void hmat_register_targets(void)
>                 m = pxm_to_node(t->memory_pxm);
>                 for_each_set_bit(p, t->p_nodes, MAX_NUMNODES)
>                         register_memory_node_under_compute_node(m, p, 0);
> +               if (t->hmem_valid)
> +                       node_set_perf_attrs(m, &t->hmem, 0);
>                 kfree(t);
>         }
>  }
> --
