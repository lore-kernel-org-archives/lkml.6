Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751026AbeEBFM5 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 2 May 2018 01:12:57 -0400
Received: from mail-ot0-f178.google.com ([74.125.82.178]:43090 "EHLO
        mail-ot0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750849AbeEBFMz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 May 2018 01:12:55 -0400
X-Google-Smtp-Source: AB8JxZruEf55K8/ukTXFebmZobZLyIY+m+dhv6gy+hgalyJHyT0iHS50RimIcXKO8CypRglvx/PyeEtWpYOaRjni3UI=
MIME-Version: 1.0
In-Reply-To: <20180502004234.230662-1-zumeng.chen@gmail.com>
References: <20180502004234.230662-1-zumeng.chen@gmail.com>
From: Michael Chan <michael.chan@broadcom.com>
Date: Tue, 1 May 2018 22:12:54 -0700
Message-ID: <CACKFLikg+p_1iDQtd0XN8tJaKtAgX0jfxGXuoqxhDJZ922UkUg@mail.gmail.com>
Subject: Re: [v2 PATCH 1/1] tg3: fix meaningless hw_stats reading after
 tg3_halt memset 0 hw_stats
To: Zumeng Chen <zumeng.chen@gmail.com>
Cc: Netdev <netdev@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        Siva Reddy Kallam <siva.kallam@broadcom.com>,
        "prashant.sreedharan@broadcom.com" <prashant@broadcom.com>,
        David Miller <davem@davemloft.net>,
        Zumeng Chen <zumeng.chen@windriver.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 1, 2018 at 5:42 PM, Zumeng Chen <zumeng.chen@gmail.com> wrote:

> diff --git a/drivers/net/ethernet/broadcom/tg3.h b/drivers/net/ethernet/broadcom/tg3.h
> index 3b5e98e..c61d83c 100644
> --- a/drivers/net/ethernet/broadcom/tg3.h
> +++ b/drivers/net/ethernet/broadcom/tg3.h
> @@ -3102,6 +3102,7 @@ enum TG3_FLAGS {
>         TG3_FLAG_ROBOSWITCH,
>         TG3_FLAG_ONE_DMA_AT_ONCE,
>         TG3_FLAG_RGMII_MODE,
> +       TG3_FLAG_HALT,

I think you should be able to use the existing INIT_COMPLETE flag and
not have to add a new flag.

>
>         /* Add new flags before this comment and TG3_FLAG_NUMBER_OF_FLAGS */
>         TG3_FLAG_NUMBER_OF_FLAGS,       /* Last entry in enum TG3_FLAGS */
> --
> 2.9.3
>
