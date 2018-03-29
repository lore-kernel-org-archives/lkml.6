Date: Thu, 29 Mar 2018 13:56:30 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Hans de Goede <hdegoede@redhat.com>
Cc: Arnd Bergmann <arnd@arndb.de>,
	Michael Thayer <michael.thayer@oracle.com>,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH 1/3] virt: vbox: Add vbg_req_free() helper function
Message-ID: <20180329115630.GB6734@kroah.com>
References: <20180329112116.26488-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180329112116.26488-1-hdegoede@redhat.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, Mar 29, 2018 at 01:21:14PM +0200, Hans de Goede wrote:
> +void vbg_req_free(void *req, size_t len)
> +{
> +	if (!req)
> +		return;
> +
> +	kfree(req);
> +}

Wait, no, this isn't ok.  Don't create wrapper functions that you never
use except as a wrapper :(

I can see someone sending me almost the indental revert patch right
after this one gets applied...

thanks,

greg k-h
