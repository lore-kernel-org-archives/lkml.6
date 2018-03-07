Date: Wed, 7 Mar 2018 12:58:40 -0800
From: Greg KH <gregkh@linuxfoundation.org>
To: sathyanarayanan.kuppuswamy@linux.intel.com
Cc: johan@kernel.org, linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/1] USB: serial: Add boundry check for read_urbs
 array access
Message-ID: <20180307205840.GA6242@kroah.com>
References: <f48feae7582a5669422066b4821a9e310eebc9ba.1520454192.git.sathyanarayanan.kuppuswamy@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f48feae7582a5669422066b4821a9e310eebc9ba.1520454192.git.sathyanarayanan.kuppuswamy@linux.intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, Mar 07, 2018 at 12:23:56PM -0800, sathyanarayanan.kuppuswamy@linux.intel.com wrote:
> From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
> 
> In usb_serial_generic_submit_read_urb() function we are accessing the
> port->read_urbs array without any boundry checks. This might lead to
> kernel panic when index value goes above array length.
> 
> One posible call path for this issue is,
> 
> usb_serial_generic_read_bulk_callback()
> {
>  ...
>  if (!port->throttled) {
> 	usb_serial_generic_submit_read_urb(port, i, GFP_ATOMIC);
>  ...
> }

How does i ever get to be greater than the array size here in this
function?  It directly came from looking in that array in the first
place :)

So I don't see why your check is needed, what other code path would ever
call this function in a way that the bounds check would be needed?

thanks,

greg k-h
