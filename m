Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751343AbeD1SgV (ORCPT <rfc822;w@1wt.eu>);
        Sat, 28 Apr 2018 14:36:21 -0400
Received: from mail-oi0-f44.google.com ([209.85.218.44]:46692 "EHLO
        mail-oi0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750935AbeD1SgT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Apr 2018 14:36:19 -0400
X-Google-Smtp-Source: AB8JxZo+NNVA+g5GW9JcJ/M/BAeIXHld6VrCbjr1uZRLfIYOuftM5jsIbwD5XH9ywMxO4/8aPU6y/HiooGZsJAbj92U=
MIME-Version: 1.0
In-Reply-To: <20180428031544.210054-1-zumeng.chen@gmail.com>
References: <20180428031544.210054-1-zumeng.chen@gmail.com>
From: Michael Chan <michael.chan@broadcom.com>
Date: Sat, 28 Apr 2018 11:36:18 -0700
Message-ID: <CACKFLi=UxiSUAx8CoMKpx16d7mVSAbbmhR-m=1W_kzNrePu7XQ@mail.gmail.com>
Subject: Re: [PATCH 1/1] tg3: fix meaningless hw_stats reading after tg3_halt
 memset 0 hw_stats
To: Zumeng Chen <zumeng.chen@gmail.com>
Cc: Netdev <netdev@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        Siva Reddy Kallam <siva.kallam@broadcom.com>,
        "michael.chan@broadcom.com" <mchan@broadcom.com>,
        "prashant.sreedharan@broadcom.com" <prashant@broadcom.com>,
        David Miller <davem@davemloft.net>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 27, 2018 at 8:15 PM, Zumeng Chen <zumeng.chen@gmail.com> wrote:

> diff --git a/drivers/net/ethernet/broadcom/tg3.h b/drivers/net/ethernet/broadcom/tg3.h
> index 3b5e98e..6727d93 100644
> --- a/drivers/net/ethernet/broadcom/tg3.h
> +++ b/drivers/net/ethernet/broadcom/tg3.h
> @@ -3352,6 +3352,7 @@ struct tg3 {
>         struct pci_dev                  *pdev_peer;
>
>         struct tg3_hw_stats             *hw_stats;
> +       bool                            hw_stats_flag;

You can just add another bit to enum TG3_FLAGS for this purpose.

While this scheme will probably work, I think a better and more
elegant way to fix this is to use RCU.

>         dma_addr_t                      stats_mapping;
>         struct work_struct              reset_task;
>
> --
> 2.9.3
>
