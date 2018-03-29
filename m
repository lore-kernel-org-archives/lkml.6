Date: Thu, 29 Mar 2018 13:55:17 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Hans de Goede <hdegoede@redhat.com>
Cc: Arnd Bergmann <arnd@arndb.de>,
	Michael Thayer <michael.thayer@oracle.com>,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH 1/3] virt: vbox: Add vbg_req_free() helper function
Message-ID: <20180329115517.GA6734@kroah.com>
References: <20180329112116.26488-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180329112116.26488-1-hdegoede@redhat.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, Mar 29, 2018 at 01:21:14PM +0200, Hans de Goede wrote:
> --- a/include/linux/vbox_utils.h
> +++ b/include/linux/vbox_utils.h
> @@ -33,6 +33,13 @@ __printf(1, 2) void vbg_debug(const char *fmt, ...);
>   */
>  void *vbg_req_alloc(size_t len, enum vmmdev_request_type req_type);
>  
> +/**
> + * Free a request allocated by vbg_req_alloc()
> + * @req:		Request to free.
> + * @len:		Length, must be the same as the value used for alloc.
> + */
> +void vbg_req_free(void *req, size_t len);
> +

Why is this in vbox_utils.h and not exported?  Shouldn't you just put
this in drivers/virt/vboxguest/vboxguest_core.h?

thanks,

greg k-h
