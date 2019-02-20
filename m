Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 725BFC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 22:04:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 415262086C
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 22:04:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550700274;
	bh=B5VG/gDLP1ZcNbcBY1ZpCXMvPK0TBamhJm/FpoIybz4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=Y7lJpFy9EjJddm2A/rTNefUzJyEfrszc5Xuy2I7U5cJYIJs24IZvU0eVOq5OmESJ0
	 cQCJ8WjJnMBDO3VPU77PYfPhlv2nKkgmegMB8CdeRlgyeUY45yGgY0PleX2quFDqtw
	 2T+tAXphuDUuWPjW8tKft3442KGyXUm6CiDHbM58=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727281AbfBTWEb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 17:04:31 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:40918 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725869AbfBTWEb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 17:04:31 -0500
Received: by mail-ot1-f68.google.com with SMTP id v20so10958101otk.7;
        Wed, 20 Feb 2019 14:04:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4yZxY3Y+S+KiVezA6TMkDyySmRqgAo0AmO1w1O/wAho=;
        b=H3dgYyrRoIUs13jzXV5cVaHokHSFM+BkA7rkmajKMmlkeS+j6e2/IxvSwIMRrEjuVn
         H3qK4Pk1/F+YwK8JXqmuQKcSOeagYSKhzezEj4Lwa9OsUowtnEIg5e4o9rK+kfpSVU2u
         eclFAU+UQoKGRmr4BRKG7sJm8ScAkeY8Llie87p5pOnopdeKsjleckLdRPadi44LEjXm
         ed+L9/p+Wshp3+g9RFJw+sZhFAUvdIY+dniEzdw1jgiUH2Zit96Hg08zWwt+28rjDbok
         LXjD4xaJiWKUTGnz/EvWB/may23gK7sssNaXBuzSS+pej+b/mcjkIK4ponOr7WdhE9R0
         Ectg==
X-Gm-Message-State: AHQUAua+tBcd6kLdPUBDK07C3BXMj9oIxrU++bpb0YszAyZwl9UB/SV6
        pHB+1Xf2Wj6WvzaNulel41CQR/4horVM0UcLh3Y=
X-Google-Smtp-Source: AHgI3IZ/5ZrH44I/xQLpQFBA1eX0LciDDyBHLZxZPOE/gs0KhKqDjYxda9HRw9mda9P291ig5HLaXDSGrqCQI+OfHK8=
X-Received: by 2002:a9d:5e8c:: with SMTP id f12mr23391011otl.343.1550700270606;
 Wed, 20 Feb 2019 14:04:30 -0800 (PST)
MIME-Version: 1.0
References: <20190214171017.9362-1-keith.busch@intel.com> <20190214171017.9362-9-keith.busch@intel.com>
In-Reply-To: <20190214171017.9362-9-keith.busch@intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 20 Feb 2019 23:04:19 +0100
Message-ID: <CAJZ5v0giQ+Xbjem-FLsYGestzBq9BpmpaQk8Zsa7-ry+Z=1gWw@mail.gmail.com>
Subject: Re: [PATCHv6 08/10] acpi/hmat: Register performance attributes
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
> Save the best performance access attributes and register these with the
> memory's node if HMAT provides the locality table. While HMAT does make
> it possible to know performance for all possible initiator-target
> pairings, we export only the local pairings at this time.
>
> Signed-off-by: Keith Busch <keith.busch@intel.com>

Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

> ---
>  drivers/acpi/hmat/hmat.c | 17 ++++++++++++++++-
>  1 file changed, 16 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/acpi/hmat/hmat.c b/drivers/acpi/hmat/hmat.c
> index b29f7160c7bb..6833c4897ff4 100644
> --- a/drivers/acpi/hmat/hmat.c
> +++ b/drivers/acpi/hmat/hmat.c
> @@ -549,12 +549,27 @@ static __init void hmat_register_target_initiators(struct memory_target *target)
>         }
>  }
>
> +static __init void hmat_register_target_perf(struct memory_target *target)
> +{
> +       unsigned mem_nid = pxm_to_node(target->memory_pxm);
> +
> +       if (!target->hmem_attrs.read_bandwidth &&
> +           !target->hmem_attrs.read_latency &&
> +           !target->hmem_attrs.write_bandwidth &&
> +           !target->hmem_attrs.write_latency)
> +               return;
> +
> +       node_set_perf_attrs(mem_nid, &target->hmem_attrs, 0);
> +}
> +
>  static __init void hmat_register_targets(void)
>  {
>         struct memory_target *target;
>
> -       list_for_each_entry(target, &targets, node)
> +       list_for_each_entry(target, &targets, node) {
>                 hmat_register_target_initiators(target);
> +               hmat_register_target_perf(target);
> +       }
>  }
>
>  static __init void hmat_free_structures(void)
> --
> 2.14.4
>
