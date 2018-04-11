Date: Wed, 11 Apr 2018 08:41:35 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Jia-Ju Bai <baijiaju1990@gmail.com>
Cc: samuel@sortiz.org, davem@davemloft.net, johan@kernel.org,
	arvind.yadav.cs@gmail.com, devel@driverdev.osuosl.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] staging: irda: Replace mdelay with usleep_range in
 stir421x_fw_upload
Message-ID: <20180411064135.GA28354@kroah.com>
References: <1523410174-1553-1-git-send-email-baijiaju1990@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1523410174-1553-1-git-send-email-baijiaju1990@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, Apr 11, 2018 at 09:29:34AM +0800, Jia-Ju Bai wrote:
> stir421x_fw_upload() is never called in atomic context.
> 
> The call chain ending up at stir421x_fw_upload() is:
> [1] stir421x_fw_upload() <- stir421x_patch_device() <- irda_usb_probe()
> 
> irda_usb_probe() is set as ".probe" in struct usb_driver.
> This function is not called in atomic context.
> 
> Despite never getting called from atomic context, stir421x_fw_upload()
> calls mdelay() to busily wait.
> This is not necessary and can be replaced with usleep_range() to
> avoid busy waiting.
> 
> This is found by a static analysis tool named DCNS written by myself.
> And I also manually check it.
> 
> Signed-off-by: Jia-Ju Bai <baijiaju1990@gmail.com>
> ---
>  drivers/staging/irda/drivers/irda-usb.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Please, at the very least, work off of Linus's tree.  There is no
drivers/staging/irda/ anymore :)

thanks,

greg k-h
