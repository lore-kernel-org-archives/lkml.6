Date: Tue, 15 May 2018 17:12:40 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Florian Schmaus <flo@geekplace.eu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 3/3] driver-core: print bus registration error value
Message-ID: <20180515151240.GC23553@kroah.com>
References: <20180504132357.31771-1-flo@geekplace.eu>
 <20180515135114.31939-4-flo@geekplace.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180515135114.31939-4-flo@geekplace.eu>
User-Agent: Mutt/1.9.5 (2018-04-13)
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, May 15, 2018 at 03:51:14PM +0200, Florian Schmaus wrote:
> Signed-off-by: Florian Schmaus <flo@geekplace.eu>
> ---
>  drivers/base/driver.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/base/driver.c b/drivers/base/driver.c
> index afd5b08b7677..c68d35139c0f 100644
> --- a/drivers/base/driver.c
> +++ b/drivers/base/driver.c
> @@ -149,8 +149,9 @@ int driver_register(struct device_driver *drv)
>  	struct device_driver *other;
>  
>  	if (!drv->bus->p) {
> -		printk(KERN_ERR "Driver '%s' was unable to register bus_type\n",
> -			   drv->name);
> +		printk(KERN_ERR "Driver '%s' was unable to register bus_type "
> +			   "(error: %d)\n",
> +			   drv->name, drv->bus->bus_register_retval);

I don't understand, if a bus was never registered, this is going to fail
in lots of odd ways, including the value being 0, so that would show "no
error"?  Is this really needed?

A better message would be something like:
	"Driver '%s" was unable to register with bus_type '%s' because it was not initialized."

right?

thanks,

greg k-h
