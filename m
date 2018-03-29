Date: Thu, 29 Mar 2018 11:56:37 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Chris Coffey <cmc@babblebit.net>
Cc: NeilBrown <neil@brown.name>, Matthias Brugger <matthias.bgg@gmail.com>,
	devel@driverdev.osuosl.org, linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: mt7621-eth: Fix sparse warning in ethtool.c
Message-ID: <20180329095637.GA16778@kroah.com>
References: <20180328211848.11085-1-cmc@babblebit.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180328211848.11085-1-cmc@babblebit.net>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, Mar 28, 2018 at 10:18:48PM +0100, Chris Coffey wrote:
> Include the local ethtool.h header file in mtk_eth_soc.h so
> implementation files have centralized access to it.
> 
> This fixes the following sparse warning:
> 
> drivers/staging/mt7621-eth/ethtool.c:213:6: warning: symbol
> 'mtk_set_ethtool_ops' was not declared. Should it be static?
> 
> Signed-off-by: Chris Coffey <cmc@babblebit.net>
> ---
>  drivers/staging/mt7621-eth/mtk_eth_soc.c | 1 -
>  drivers/staging/mt7621-eth/mtk_eth_soc.h | 1 +
>  2 files changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/mt7621-eth/mtk_eth_soc.c b/drivers/staging/mt7621-eth/mtk_eth_soc.c
> index cbc7339843..0574e71573 100644
> --- a/drivers/staging/mt7621-eth/mtk_eth_soc.c
> +++ b/drivers/staging/mt7621-eth/mtk_eth_soc.c
> @@ -35,7 +35,6 @@
>  
>  #include "mtk_eth_soc.h"
>  #include "mdio.h"
> -#include "ethtool.h"

How about just moving ethtool.h above the mtk_eth_soc.h include?

Putting .h file dependancies in other .h files is generally not a good
idea if at all possible.  Keeping them "clean" is better, and this
driver has a bunch of work to go there, so let's not make it worse :)

thanks,

greg k-h
