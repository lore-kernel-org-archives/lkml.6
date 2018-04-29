Date: Sun, 29 Apr 2018 17:59:24 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Gregory Panic <airman.price@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: RW GDT replaced by Read-Only GDT and a GPL Interface
Message-ID: <20180429155924.GA28565@kroah.com>
References: <CAMB+E4gS=F8kXMNTtKdLr9y-C_+NaSPQm3M1m9xC0Sbhn+hjYw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMB+E4gS=F8kXMNTtKdLr9y-C_+NaSPQm3M1m9xC0Sbhn+hjYw@mail.gmail.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, Apr 17, 2018 at 05:33:25PM -0400, Gregory Panic wrote:
> Hi,
> 
> I have been working on a VMX driver for a custom hypervisor which
> depends on features that KVM is not built for.  Up until recently
> (4.12.x), our module has been working just fine.  When we started to
> build support for Ubuntu 18.04 (4.15.x+), we ran into an issue.
> 
> Unfortunately the following commits broke functionality, causing
> kernel segfaults, due to a placing the GDT in the FIXMAP area, and
> setting that mapping to Read-Only.
> #69218e47994da614e7af600bf06887750ab6657a
> and
> #45fc8757d1d2128e342b4e7ef39adedf7752faac
> 
> Up until now, the GDT has been Read-Write, which allowed for resetting
> the TSS to available, and then Reloading it after a VMExit.  The KVM
> and Xen work-arounds for this were implemented by creating a GPL'd
> interface to remap the GDT to the original Read/Write mapping and then
> back.
> 
> Up to this point we've been able to maintain independence from GPL,

As has been stated numberous times, the lack of EXPORT_SYMBOL_GPL() does
NOT mean that the interface you are using is not covered under the GPL
license of the kernel.

Please consult with an IP lawyer for the details if you are interested.

Best of luck with your driver!

greg k-h
