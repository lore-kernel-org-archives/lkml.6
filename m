Date: Fri, 18 May 2018 17:15:43 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>,
	Paul Menzel <pmenzel+linux-usb@molgen.mpg.de>,
	Mario Limonciello <mario.limonciello@dell.com>,
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
	Thorsten Leemhuis <linux@leemhuis.info>, linux-acpi@vger.kernel.org
Subject: Re: `ucsi_acpi: probe of USBC000:00 failed with error -12` on Dell
 XPS 13 9360/9370
Message-ID: <20180518151543.GA6501@kroah.com>
References: <9365397f-7206-728e-ee76-146629bfd186@molgen.mpg.de>
 <20180515160047.GB26720@kroah.com>
 <69da4aa4-3d4b-0ffc-81ce-500713cd3743@molgen.mpg.de>
 <20180516080226.GC3536@kroah.com>
 <20180516115814.GB11469@kuha.fi.intel.com>
 <df6610738db046e9bd1db77d4346cfc3@ausx13mpc120.AMER.DELL.COM>
 <20180517085930.GD11469@kuha.fi.intel.com>
 <40707f34-e0a6-3114-36a3-6603bdcd8d82@molgen.mpg.de>
 <20180518104000.GA13595@kuha.fi.intel.com>
 <20180518150823.GA14756@kuha.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180518150823.GA14756@kuha.fi.intel.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, May 18, 2018 at 06:08:24PM +0300, Heikki Krogerus wrote:
> 
> Rafael, the problem here with these Dell laptops is that a memory page
> that is used as a mailbox for special communication between EC FW and
> OS (called UCSI mailbox) should be in uncached memory, but the memory
> is marked as cached.
> 
> I'm actually not even sure if the cache mode is something that is set
> based on information from ACPI tables, or is it something that the
> BIOS handles separately?
> 
> If it's information coming from ACPI tables, can we help pin point the
> place the BIOS guys at Dell should fix?

Given that Windows works with this same set of ACPI tables, perhaps the
requirement isn't that this memory location be uncached?

We shouldn't have to fix up ACPI tables just for Linux, we've been down
that path before :(

thanks,

greg k-h
