Date: Thu, 1 Feb 2018 11:29:20 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Jiri Slaby <jslaby@suse.cz>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Hans de Goede <hdegoede@redhat.com>
Subject: Re: [PATCH 4.4 28/74] ACPI / scan: Prefer devices without _HID/_CID
 for _ADR matching
Message-ID: <20180201102920.GB13686@kroah.com>
References: <20180129123847.507563674@linuxfoundation.org>
 <20180129123848.888319573@linuxfoundation.org>
 <ffdd5d23-0080-6b00-1b46-2b7952200ac7@suse.cz>
 <bdb6b0ed-0c79-0053-ddd3-78da186fc33e@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bdb6b0ed-0c79-0053-ddd3-78da186fc33e@suse.cz>
User-Agent: Mutt/1.9.3 (2018-01-21)
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, Feb 01, 2018 at 09:57:21AM +0100, Jiri Slaby wrote:
> On 02/01/2018, 09:46 AM, Jiri Slaby wrote:
> > On 01/29/2018, 01:56 PM, Greg Kroah-Hartman wrote:
> >> 4.4-stable review patch.  If anyone has any objections, please let me know.
> >>
> >> ------------------
> >>
> >> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >>
> >> commit c2a6bbaf0c5f90463a7011a295bbdb7e33c80b51 upstream.
> >>
> >> The way acpi_find_child_device() works currently is that, if there
> >> are two (or more) devices with the same _ADR value in the same
> >> namespace scope (which is not specifically allowed by the spec and
> >> the OS behavior in that case is not defined), the first one of them
> >> found to be present (with the help of _STA) will be returned.
> >>
> >> This covers the majority of cases, but is not sufficient if some of
> >> the devices in question have a _HID (or _CID) returning some valid
> >> ACPI/PNP device IDs (which is disallowed by the spec) and the
> >> ASL writers' expectation appears to be that the OS will match
> >> devices without a valid ACPI/PNP device ID against a given bus
> >> address first.
> >>
> >> To cover this special case as well, modify find_child_checks()
> >> to prefer devices without ACPI/PNP device IDs over devices that
> >> have them.
> >>
> >> Suggested-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> >> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >> Tested-by: Hans de Goede <hdegoede@redhat.com>
> >> Signed-off-by: Jiri Slaby <jslaby@suse.cz>
> > 
> > You seem you took this from SLE12-SP2? But where did you take the
> > upstream commit SHA from? In SLE, I have "Git-commit: fdad4e7a876a2..."
> > which is the correct SHA of this patch. The above c2a6bbaf0c is a
> > different patch. So are your scripts broken or is this a manual oversight?
> 
> Not only the SHA, the whole commit message is taken from c2a6bbaf0c. But
> the diff below is fdad4e7a876a2.
> 
> To clarify: upstream c2a6bbaf0c is in 4.4.80 already (as f4a42f8492).
> The diff below is a fix for it with upstream SHA fdad4e7a876a2 (in 4.4
> as 1fe277d48f). So the code is correct, unlike meta data.

This was my fault, I searched the kernel log for the real git commit id
by just looking at the start of the shortlog string, not the full thing.
It matched on the wrong one, which I used here for the body of the
patch, but not the content.

Thanks for finding this, sorry for the confusion.

greg k-h
