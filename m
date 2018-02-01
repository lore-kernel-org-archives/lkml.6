Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755042AbeBAU3e (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Feb 2018 15:29:34 -0500
Received: from mail-qk0-f196.google.com ([209.85.220.196]:38943 "EHLO
        mail-qk0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754906AbeBAU3Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Feb 2018 15:29:25 -0500
X-Google-Smtp-Source: AH8x225xl1XgVTHn2pm8kaRlDcw2aXcN6Zja2tQJwy04iDboXCM912rNneE/OGOym9S8D2Zck6hJgenrLXldcgMJRVI=
MIME-Version: 1.0
In-Reply-To: <20180201183539.24776-1-colin.king@canonical.com>
References: <20180201183539.24776-1-colin.king@canonical.com>
From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Thu, 1 Feb 2018 12:29:24 -0800
Message-ID: <CAKgT0UdjYMWV4x7-yy4pkA_8cNY+Bvc4WvJ0yKYRKO5dWf9mTA@mail.gmail.com>
Subject: Re: [Intel-wired-lan] [PATCH] ixgbevf: remove redundant
 initialization of variable 'dma'.
To: Colin King <colin.king@canonical.com>
Cc: Jeff Kirsher <jeffrey.t.kirsher@intel.com>,
        intel-wired-lan <intel-wired-lan@lists.osuosl.org>,
        Netdev <netdev@vger.kernel.org>, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 1, 2018 at 10:35 AM, Colin King <colin.king@canonical.com> wrote:
> From: Colin Ian King <colin.king@canonical.com>
>
> Variable dma is initialized with a value that is never read, later
> on it is re-assigned a new value, hence the initialization is redundant
> and can be removed.
>
> Cleans up clang warning:
> drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c:584:13: warning: Value
> stored to 'dma' during its initialization is never read
>
> Signed-off-by: Colin Ian King <colin.king@canonical.com>

Acked-by: Alexander Duyck <alexander.h.duyck@intel.com>

> ---
>  drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c b/drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c
> index 9b3d43d28106..be50facec93f 100644
> --- a/drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c
> +++ b/drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c
> @@ -558,7 +558,7 @@ static bool ixgbevf_alloc_mapped_page(struct ixgbevf_ring *rx_ring,
>                                       struct ixgbevf_rx_buffer *bi)
>  {
>         struct page *page = bi->page;
> -       dma_addr_t dma = bi->dma;
> +       dma_addr_t dma;
>
>         /* since we are recycling buffers we should seldom need to alloc */
>         if (likely(page))
> --
> 2.15.1
>
> _______________________________________________
> Intel-wired-lan mailing list
> Intel-wired-lan@osuosl.org
> https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
