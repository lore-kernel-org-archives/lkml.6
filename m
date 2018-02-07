Date: Wed, 7 Feb 2018 06:34:28 -0800
From: Greg KH <gregkh@linuxfoundation.org>
To: Borislav Petkov <bp@alien8.de>
Cc: Rolf Neugebauer <rolf.neugebauer@docker.com>,
	Jia Zhang <zhang.jia@linux.alibaba.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Tony Luck <tony.luck@intel.com>, Ingo Molnar <mingo@redhat.com>,
	"H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
	LKML <linux-kernel@vger.kernel.org>
Subject: Re: x86/microcode/intel: Division by zero panic in 4.9.79 and 4.4.114
Message-ID: <20180207143428.GA31944@kroah.com>
References: <CA+pO-2c6z6uc8EO7LwWkGe3g_ygMwfS=VfQPNHzvS4H7RJOt-w@mail.gmail.com>
 <20180206142444.7xxegyyyfwskwrxl@pd.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180206142444.7xxegyyyfwskwrxl@pd.tnic>
User-Agent: Mutt/1.9.3 (2018-01-21)
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, Feb 06, 2018 at 03:24:44PM +0100, Borislav Petkov wrote:
> On Tue, Feb 06, 2018 at 02:09:35PM +0000, Rolf Neugebauer wrote:
> > The backport of 7e702d17ed1 ("x86/microcode/intel: Extend BDW
> > late-loading further with LLC size check") to 4.9.79 and 4.4.14 causes
> > a division by zero panic on some single vCPU machine types on Google
> > Cloud (e.g. g1-small and n1-standard-1):
> 
> The microcode loader is not supposed to load in a guest.
> 
> Greg, I guess you need something like this:
> 
> a15a753539ec ("x86/microcode/AMD: Do not load when running on a hypervisor")
> 
> I haven't tried whether it applies cleanly though...

It applied cleanly to 4.9 (with some fuzz, but looks clean enough...)

But for 4.4, not at all.  Rolf, any chance you could backport the patch
there for this issue?  If not, I can add it to my queue, but it might
take a few days...

thanks,

greg k-h
