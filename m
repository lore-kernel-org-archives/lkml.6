Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1161413AbeBPQwB (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Feb 2018 11:52:01 -0500
Received: from mail-qt0-f179.google.com ([209.85.216.179]:42097 "EHLO
        mail-qt0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755832AbeBPQv7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Feb 2018 11:51:59 -0500
X-Google-Smtp-Source: AH8x224VIArE/crxGvCKZBIrtcipvlL/QRJx4qV8UOLUUk2Dgfxs6Eb4BmlhrlStTO3oPORlv41i8XG8z5oQOQ7+y0M=
MIME-Version: 1.0
In-Reply-To: <20180215194245.28860-1-colin.king@canonical.com>
References: <20180215194245.28860-1-colin.king@canonical.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Fri, 16 Feb 2018 18:51:57 +0200
Message-ID: <CAHp75Vcxt0kkzRaF1Zzkt4hVqcPt0VG61yTLgB7HvG1xwhPUbg@mail.gmail.com>
Subject: Re: [PATCH] i40evf: remove redundant array comparisons to 0 checks
To: Colin King <colin.king@canonical.com>
Cc: Jeff Kirsher <jeffrey.t.kirsher@intel.com>,
        intel-wired-lan@lists.osuosl.org, netdev <netdev@vger.kernel.org>,
        kernel-janitors@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 15, 2018 at 9:42 PM, Colin King <colin.king@canonical.com> wrote:
> From: Colin Ian King <colin.king@canonical.com>
>
> The checks to see if key->dst.s6_addr and key->src.s6_addr are null
> pointers are redundant because these are constant size arrays and
> so the checks always return true.  Fix this by removing the redundant
> checks.

> +               for (i = 0; i < 4; i++)

> +                       filter->f.mask.tcp_spec.dst_ip[i] |=
>                                                         cpu_to_be32(0xffffffff);

Can it be one line then?

> +               memcpy(&filter->f.data.tcp_spec.dst_ip,
> +                      &key->dst.s6_addr32,

Ditto.

> +                      sizeof(filter->f.data.tcp_spec.dst_ip));
> +
> +               for (i = 0; i < 4; i++)

> +                       filter->f.mask.tcp_spec.src_ip[i] |=
>                                                         cpu_to_be32(0xffffffff);

Ditto.

> +               memcpy(&filter->f.data.tcp_spec.src_ip,
> +                      &key->src.s6_addr32,

Ditto.

> +                      sizeof(filter->f.data.tcp_spec.src_ip));

-- 
With Best Regards,
Andy Shevchenko
