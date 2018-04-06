Date: Fri, 6 Apr 2018 09:51:35 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Ben Hutchings <ben.hutchings@codethink.co.uk>
Cc: Jerry Hoemann <jerry.hoemann@hpe.com>, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
	Guenter Roeck <linux@roeck-us.net>,
	Wim Van Sebroeck <wim@iguana.be>
Subject: Re: [PATCH 4.4 29/63] watchdog: hpwdt: fix unused variable warning
Message-ID: <20180406075135.GA5326@kroah.com>
References: <20180316152259.964532775@linuxfoundation.org>
 <20180316152303.262268098@linuxfoundation.org>
 <20180316225537.GA5989@anatevka.americas.hpqcorp.net>
 <20180318101416.GD13276@kroah.com>
 <1521587979.23626.117.camel@codethink.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1521587979.23626.117.camel@codethink.co.uk>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, Mar 20, 2018 at 11:19:39PM +0000, Ben Hutchings wrote:
> On Sun, 2018-03-18 at 11:14 +0100, Greg Kroah-Hartman wrote:
> > On Fri, Mar 16, 2018 at 04:55:37PM -0600, Jerry Hoemann wrote:
> > > 
> > > Greg,
> > > 
> > > Sorry, if I'm missing something, but I see 3 patches for
> > > hpwdt queued up for 4.4:
> > > 
> > > 	queue-4.4/watchdog-hpwdt-fix-unused-variable-warning.patch
> > > 	queue-4.4/watchdog-hpwdt-smbios-check.patch
> > > 	queue-4.4/watchdog-hpwdt-check-source-of-nmi.patch
> > > 
> > > 
> > > Shouldn't there also be a 4.4 patch for
> > > 
> > > 	commit 2b3d89b402b085b08498e896c65267a145bed486
> > > 	watchdog: hpwdt: Remove legacy NMI sourcing.
> > > 
> > > As there was for 4.15, 4.14, and 4.9?
> > 
> > It does not apply to the 4.4.y kernel branch.  If you feel it should be
> > there, please provide a working backport.
> > 
> > > commit 2b3d89b40 is the Spectre related patch.
> > 
> > If you look closely, not many Spectre-related patches are merged into
> > 4.4.y as no one has taken the time to do the backporting.  I thought
> > someone was working on this, but odds are they just moved to 4.9.y or
> > 4.14.y as everyone really should if they care about these issues with
> > their platforms.
> > 
> > So if you care about Spectre, I strongly recommend using 4.14.y or
> > newer.
> 
> I think you have most of the Spectre stuff aside from microcode
> supported fixes.  These are still missing on the 4.4 branch though:
> 
> 8fa80c503b48 nospec: Move array_index_nospec() parameter checking into separate macro
> 1d91c1d2c80c nospec: Kill array_index_nospec_mask_check()
> 
> I think there may also be some extra uaccess functions that didn't get
> the nospec treatment.

I'm sure there are :(

I've queued up these 2 patches now, thanks.

greg k-h
