Date: Wed, 28 Feb 2018 08:11:31 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Kees Cook <keescook@chromium.org>
Cc: "Luis R. Rodriguez" <mcgrof@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Shuah Khan <shuah@kernel.org>, Martin Fuzzey <mfuzzey@parkeon.com>,
	Mimi Zohar <zohar@linux.vnet.ibm.com>,
	David Howells <dhowells@redhat.com>, pali.rohar@gmail.com,
	Takashi Iwai <tiwai@suse.de>, arend.vanspriel@broadcom.com,
	=?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>,
	nbroeking@me.com, Vikram Mulukutla <markivx@codeaurora.org>,
	stephen.boyd@linaro.org, Mark Brown <broonie@kernel.org>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	David Woodhouse <dwmw2@infradead.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Abhay_Salunke@dell.com, bjorn.andersson@linaro.org,
	jewalt@lgsinnovations.com, LKML <linux-kernel@vger.kernel.org>,
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH v2 07/11] firmware: split firmware fallback functionality
 into its own file
Message-ID: <20180228071131.GA17185@kroah.com>
References: <20180224024613.24078-1-mcgrof@kernel.org>
 <20180224024613.24078-8-mcgrof@kernel.org>
 <CAGXu5jKoRsXm00=dQePgrjF+EauphKnPQXVgL=rv_d579eNE7g@mail.gmail.com>
 <20180228012802.GG14069@wotan.suse.de>
 <CAGXu5j+tFg+rGn5baCFRF5ARwExuD45oRE=dmzB8T84XDL=f-w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGXu5j+tFg+rGn5baCFRF5ARwExuD45oRE=dmzB8T84XDL=f-w@mail.gmail.com>
User-Agent: Mutt/1.9.3 (2018-01-21)
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, Feb 27, 2018 at 09:33:28PM -0800, Kees Cook wrote:
> On Tue, Feb 27, 2018 at 5:28 PM, Luis R. Rodriguez <mcgrof@kernel.org> wrote:
> > On Tue, Feb 27, 2018 at 03:14:53PM -0800, Kees Cook wrote:
> >> On Fri, Feb 23, 2018 at 6:46 PM, Luis R. Rodriguez <mcgrof@kernel.org> wrote:
> >> > The firmware fallback code is optional. Split that code out to help
> >> > distinguish the fallback functionlity from othere core firmware loader
> >> > features. This should make it easier to maintain and review code
> >> > changes.
> >> >
> >> > The reason for keeping the configuration onto a table which is built-in
> >> > if you enable firmware loading is so that we can later enable the kernel
> >> > after subsequent patches to tweak this configuration, even if the
> >> > firmware loader is modular.
> >> >
> >> > This introduces no functional changes.
> >> >
> >> > Signed-off-by: Luis R. Rodriguez <mcgrof@kernel.org>
> >> > ---
> >> >  drivers/base/Makefile                  |   4 +-
> >> >  drivers/base/firmware_fallback.c       | 661 +++++++++++++++++++++++++++
> >> >  drivers/base/firmware_fallback.h       |  61 +++
> >> >  drivers/base/firmware_fallback_table.c |  29 ++
> >> >  drivers/base/firmware_loader.c         | 803 +--------------------------------
> >> >  drivers/base/firmware_loader.h         | 115 +++++
> >> >  6 files changed, 874 insertions(+), 799 deletions(-)
> >> >  create mode 100644 drivers/base/firmware_fallback.c
> >> >  create mode 100644 drivers/base/firmware_fallback.h
> >> >  create mode 100644 drivers/base/firmware_fallback_table.c
> >> >  create mode 100644 drivers/base/firmware_loader.h
> >>
> >> Does it make sense to have a separate subdirectory for firmware
> >> instead? I did this _ stuff with lkdtm and have regretted it. (I'm
> >> likely going to make a subdirectory for it this cycle...)
> >
> > Sure, the only eyesore is that drivers/base/firmware.c what is that for?
> >
> > drivers/base/firmware_loader/ ok?
> 
> Yeah? Seems fine to me. Greg, do you have thoughts on this?

I don't care :)
