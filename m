Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752106AbeC3OON (ORCPT <rfc822;w@1wt.eu>);
        Fri, 30 Mar 2018 10:14:13 -0400
Received: from vps0.lunn.ch ([185.16.172.187]:47326 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750794AbeC3OOM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Mar 2018 10:14:12 -0400
Date: Fri, 30 Mar 2018 16:14:09 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Frans Meulenbroeks <fransmeulenbroeks@gmail.com>
Cc: torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
        netdev <netdev@vger.kernel.org>
Subject: Re: [PATCH] fix typo in command value in
 drivers/net/phy/mdio-bitbang.
Message-ID: <20180330141409.GC28244@lunn.ch>
References: <CACW_hTauBL6but9143Kio-ZU5jsMKx2uTEUv3kHFaTGuwdyHZA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACW_hTauBL6but9143Kio-ZU5jsMKx2uTEUv3kHFaTGuwdyHZA@mail.gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 30, 2018 at 02:03:38PM +0200, Frans Meulenbroeks wrote:
> mdio-bitbang mentioned 10 for both read and write.
> However mdio read opcode is 10 and write opcode is 01
> Fixed comment.
> 
> Signed-off-by: Frans Meulenbroeks <fransmeulenbroeks@gmail.com>

Hi Frans

The correct place to send this patch is <netdev@vger.kernel.org> and
David Miller <davem@davemloft.net>. Please can you submit it again, to
these addresses.

In general, if you don't know where to send a patch,
scripts/get_maintainers.pl will tell you.

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew


> ---
>  drivers/net/phy/mdio-bitbang.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/phy/mdio-bitbang.c b/drivers/net/phy/mdio-bitbang.c
> index 61a543c..403b085 100644
> --- a/drivers/net/phy/mdio-bitbang.c
> +++ b/drivers/net/phy/mdio-bitbang.c
> @@ -113,7 +113,7 @@ static void mdiobb_cmd(struct mdiobb_ctrl *ctrl, int
> op, u8 phy, u8 reg)
>         for (i = 0; i < 32; i++)
>                 mdiobb_send_bit(ctrl, 1);
> 
> -       /* send the start bit (01) and the read opcode (10) or write (10).
> +       /* send the start bit (01) and the read opcode (10) or write (01).
>            Clause 45 operation uses 00 for the start and 11, 10 for
>            read/write */
>         mdiobb_send_bit(ctrl, 0);
> -- 
> 2.7.4
