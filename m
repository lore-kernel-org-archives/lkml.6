Date: Wed, 14 Mar 2018 19:08:30 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Samuel Holland <samuel@sholland.org>
Cc: linux-kernel@vger.kernel.org, coreboot@coreboot.org,
	Thierry Escande <thierry.escande@collabora.com>,
	Wei-Ning Huang <wnhuang@google.com>,
	Julius Werner <jwerner@chromium.org>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH 0/5] coreboot table bus and framebuffer driver
Message-ID: <20180314180830.GA6311@kroah.com>
References: <20180125014120.20851-1-samuel@sholland.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180125014120.20851-1-samuel@sholland.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, Jan 24, 2018 at 07:41:15PM -0600, Samuel Holland wrote:
> On many systems, coreboot[1] firmware can initialize graphics hardware
> and set up a high-resolution linear framebuffer. It exports information
> about this framebuffer, along with various other information, in a table
> discoverable via ACPI or a device tree.
> 
> coreboot also supports booting Linux directly from flash as a "payload".
> Projects such as Heads[2], u-root[3], and petitboot[4] provide a minimal
> userland that can then be used to chainload (via kexec) into a full
> Linux system loaded from disk or over the network.
> 
> Fitting even a minimal Linux system on an SPI flash chip is challenging.
> Reusing the framebuffer setup from coreboot provides an enormous benefit
> to these projects by allowing them to omit full graphics drivers from
> their kernel builds. It also speeds up boot times by avoiding duplicated
> effort, and because coreboot's graphics initialization is often much
> faster than the Linux driver.
> 
> Patch 1 of this series expands coreboot table support into an enumerable
> bus that devices can hang off of. Patches 2-3 convert the existing
> drivers to use the new bus structure instead of ad-hoc platform devices,
> and patch 4 removes the old coreboot_table_find function.
> 
> Finally, patch 5 adds a new driver for the coreboot-initialized
> framebuffer. It improves on earlier work[5] by being architecture-
> independent and not needing to scan through low memory.
> 
> This patchset has been tested on a Lenovo ThinkPad X220, and earlier
> versions of these patches have been tested by various members of the
> coreboot community on other hardware.

It would be great to get some of the google developers to ack these, as
this touches their code...

thanks,

greg k-h
