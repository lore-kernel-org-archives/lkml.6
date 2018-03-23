Date: Fri, 23 Mar 2018 17:55:43 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Arend van Spriel <aspriel@gmail.com>
Cc: LKML <linux-kernel@vger.kernel.org>,
	Brian Norris <briannorris@chromium.org>
Subject: Re: [PATCH for-4.16 2/3] drivers: change struct
 device_driver::coredump() return type to void
Message-ID: <20180323165543.GA21833@kroah.com>
References: <1521107725-25027-1-git-send-email-aspriel@gmail.com>
 <1521107725-25027-3-git-send-email-aspriel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1521107725-25027-3-git-send-email-aspriel@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, Mar 15, 2018 at 10:55:24AM +0100, Arend van Spriel wrote:
> Upon submitting a patch for mwifiex [1] it was discussed whether this
> callback function could fail. To keep things simple there is no need
> for the error code so the driver can do the task synchronous or not
> without worries. Currently the device driver core already ignores the
> return value so changing it to void.
> 
> [1] https://patchwork.kernel.org/patch/10231933/
> 
> Signed-off-by: Arend van Spriel <aspriel@gmail.com>
> ---
>  include/linux/device.h | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/include/linux/device.h b/include/linux/device.h
> index b093405..f08c25b 100644
> --- a/include/linux/device.h
> +++ b/include/linux/device.h
> @@ -256,6 +256,9 @@ enum probe_type {
>   *		automatically.
>   * @pm:		Power management operations of the device which matched
>   *		this driver.
> + * @coredump:	Called when sysfs entry is written to. The device driver
> + *		is expected to call the dev_coredump API resulting in a
> + *		uevent.
>   * @p:		Driver core's private data, no one other than the driver
>   *		core can touch this.
>   *
> @@ -287,7 +290,7 @@ struct device_driver {
>  	const struct attribute_group **groups;
> 
>  	const struct dev_pm_ops *pm;
> -	int (*coredump) (struct device *dev);
> +	void (*coredump) (struct device *dev);

Isn't this going to cause build warnings now?  Are there no users of
this callback function yet?

thanks,

greg k-h
