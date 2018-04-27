Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757299AbeD0CjY (ORCPT <rfc822;w@1wt.eu>);
        Thu, 26 Apr 2018 22:39:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:38928 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1757029AbeD0CjW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Apr 2018 22:39:22 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C87122184F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=robh+dt@kernel.org
X-Google-Smtp-Source: AB8JxZpnKbBMjap3ZA+aZPqLYkevst8pE7kRU6aVBk0U/v4QRcVm6xtlNLkqlg/2AXWr7thnuVCZtKmO+IZQAxr+xJk=
MIME-Version: 1.0
In-Reply-To: <6045807691c310ccdd57ab16524b7525f26a1dc1.1524751696.git.michal.simek@xilinx.com>
References: <cover.1524751696.git.michal.simek@xilinx.com> <6045807691c310ccdd57ab16524b7525f26a1dc1.1524751696.git.michal.simek@xilinx.com>
From: Rob Herring <robh+dt@kernel.org>
Date: Thu, 26 Apr 2018 21:39:00 -0500
X-Gmail-Original-Message-ID: <CAL_Jsq+69p1GstFua1-27LGv9MKT8dtbd1ytcq+GuvQ=VcEHKg@mail.gmail.com>
Message-ID: <CAL_Jsq+69p1GstFua1-27LGv9MKT8dtbd1ytcq+GuvQ=VcEHKg@mail.gmail.com>
Subject: Re: [RFC PATCH 1/3] of: base: Introduce of_alias_check_id() to check
 alias IDs
To: Michal Simek <michal.simek@xilinx.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Michal Simek <monstr@monstr.eu>,
        One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>,
        Alexander Graf <agraf@suse.de>, devicetree@vger.kernel.org,
        Frank Rowand <frowand.list@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 26, 2018 at 9:08 AM, Michal Simek <michal.simek@xilinx.com> wrote:
> The function travers the lookup table to check if the request alias
> id is compatible with the device driver match structure.
> This function will be used by serial drivers to check if requested alias
> is allocated or free to use.
>
> Signed-off-by: Michal Simek <michal.simek@xilinx.com>
> ---
>
>  drivers/of/base.c  | 49 ++++++++++++++++++++++++++++++++++++++++++++++
>  include/linux/of.h |  2 ++
>  2 files changed, 51 insertions(+)
>
> diff --git a/drivers/of/base.c b/drivers/of/base.c
> index 848f549164cd..382de01acc72 100644
> --- a/drivers/of/base.c
> +++ b/drivers/of/base.c
> @@ -1892,6 +1892,55 @@ int of_alias_get_id(struct device_node *np, const char *stem)
>  }
>  EXPORT_SYMBOL_GPL(of_alias_get_id);
>
> +/**
> + * of_alias_check_id - Check alias id for the give compatibility
> + * @matches:   Array of of device match structures to search in
> + * @stem:      Alias stem of the given device_node
> + * @id:                Alias ID for checking
> + *
> + * The function travers the lookup table to check if the request alias id
> + * is compatible with the device driver match structure
> + *
> + * Return true if ID is allocated, return false if not
> + */
> +bool of_alias_check_id(const struct of_device_id *matches, const char *stem,
> +                      int id)

Wouldn't it be simpler to just return a bitmap of all allocated ids
that match rather than trying to build that up 1 bit at a time?

Rob
