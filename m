Date: Fri, 23 Mar 2018 14:34:48 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Daniel Kurtz <djkurtz@chromium.org>
Cc: Matthias Kaehlcke <mka@chromium.org>,
	Guenter Roeck <groeck@chromium.org>, adurbin@chromium.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/2] Fix __earlycon_table stride... again
Message-ID: <20180323133448.GA3434@kroah.com>
References: <20180320175712.201572-1-djkurtz@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180320175712.201572-1-djkurtz@chromium.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, Mar 20, 2018 at 11:57:10AM -0600, Daniel Kurtz wrote:
> The __earlycon_table lives in a special "__earlycon_table" section.  The
> contents of this table are added using some macros that deposit individual
> struct earlycon_id entries into this section.  The linker then defines a symbol
> __earlycon_table that is supposed to contain the addresss of the first of these
> entries.  The code in earlycon.c and fdt.c then tries to access the memory
> pointed to by __earlycon_table as an array of struct earlycon_id entries.
> 
> Unfortunately, the compiler doesn't always place the entries such that they
> are an array.  Let's fix that.
> 
> Patch 1 of the series is a fix that should hopefully fix a kbuild error that
> seems to be triggered by Patch 2.

Doesn't seem like that worked :(

And I have a bunch of different versions of this patch in my to-review
queue, and I can't figure out which is the "latest" one.

Can you resend it, after getting the build error fixed, so I know which
to attempt to apply?

thanks,

greg k-h
