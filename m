Date: Mon, 23 Apr 2018 09:55:19 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Stefan Potyra <Stefan.Potyra@elektrobit.com>
Cc: Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org, ldv-project@linuxtesting.org,
	sil2review@lists.osadl.org
Subject: Re: [PATCH] Check for an error when the clock is enabled.
Message-ID: <20180423075519.GA13262@kroah.com>
References: <20180419130228.rdee6hwsjcui5py7@agrajag.zerfleddert.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180419130228.rdee6hwsjcui5py7@agrajag.zerfleddert.de>
User-Agent: Mutt/1.9.5 (2018-04-13)
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, Apr 19, 2018 at 03:02:28PM +0200, Stefan Potyra wrote:
> Found by Linux Driver Verification project (linuxtesting.org).

Please fix up your subject line to have something "real" in it, along
with the proper prefix.

And put more context here in the changelog, saying why you are doing
this, this "empty line" doesn't mean anything.

> 
> Fixes: 0814e8d5da2b sc16is7xx: enable the clock

Fixes: 0814e8d5da2b ("sc16is7xx: enable the clock")

is the correct format.

> Signed-off-by: Stefan Potyra <Stefan.Potyra@elektrobit.com>
> ---
>  drivers/tty/serial/sc16is7xx.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/tty/serial/sc16is7xx.c b/drivers/tty/serial/sc16is7xx.c
> index 65792a3539d0..243c96025053 100644
> --- a/drivers/tty/serial/sc16is7xx.c
> +++ b/drivers/tty/serial/sc16is7xx.c
> @@ -1168,7 +1168,10 @@ static int sc16is7xx_probe(struct device *dev,
>  		else
>  			return PTR_ERR(s->clk);
>  	} else {
> -		clk_prepare_enable(s->clk);
> +		ret = clk_prepare_enable(s->clk);
> +		if (ret)
> +			return ret;
> +

Please fix up the above and resend.

thanks,

greg k-h
