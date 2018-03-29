Date: Thu, 29 Mar 2018 13:57:19 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Hans de Goede <hdegoede@redhat.com>
Cc: Arnd Bergmann <arnd@arndb.de>,
	Michael Thayer <michael.thayer@oracle.com>,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH 2/3] virt: vbox: Use __get_free_pages instead of kmalloc
 for DMA32 memory
Message-ID: <20180329115719.GC6734@kroah.com>
References: <20180329112116.26488-1-hdegoede@redhat.com>
 <20180329112116.26488-2-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180329112116.26488-2-hdegoede@redhat.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, Mar 29, 2018 at 01:21:15PM +0200, Hans de Goede wrote:
> @@ -87,7 +88,7 @@ void vbg_req_free(void *req, size_t len)
>  	if (!req)
>  		return;
>  
> -	kfree(req);
> +	free_pages((unsigned long)req, get_order(PAGE_ALIGN(len)));
>  }

Really?  This feels wrong to me, why is this driver so special that it
has to use free_pages and the like?

greg k-h
