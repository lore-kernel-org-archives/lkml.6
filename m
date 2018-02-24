Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751481AbeBXNyE (ORCPT <rfc822;w@1wt.eu>);
        Sat, 24 Feb 2018 08:54:04 -0500
Received: from mail-ua0-f195.google.com ([209.85.217.195]:35931 "EHLO
        mail-ua0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751131AbeBXNyC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Feb 2018 08:54:02 -0500
X-Google-Smtp-Source: AG47ELs5PQkgrPsL958/O/t6TEzcNMjzzIONGf8lx/hD+/w0d77JlIZpW4w0WPFpI9qldnE1Fvq/HQ==
Date: Sat, 24 Feb 2018 10:53:58 -0300
From: Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Hartmut Knaack <knaack.h@gmx.de>, Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>, daniel.baluta@nxp.com,
        kernel-janitors@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio:dummy: Fix coding style in Kconfig
Message-ID: <20180224135358.35tqecq74plebenu@smtp.gmail.com>
References: <20180220132804.fnlsi6ag6h5rrqya@smtp.gmail.com>
 <20180224122428.007ccf89@archlinux>
 <20180224123609.ysidednaigprxq7m@smtp.gmail.com>
 <20180224134422.58c444c6@archlinux>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180224134422.58c444c6@archlinux>
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/24, Jonathan Cameron wrote:
> On Sat, 24 Feb 2018 09:36:09 -0300
> Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com> wrote:
> 
> > On 02/24, Jonathan Cameron wrote:
> > > On Tue, 20 Feb 2018 10:28:04 -0300
> > > Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com> wrote:
> > >   
> > > > This patch fixes the checkpatch.pl warning:
> > > > 
> > > > drivers/iio/dummy/Kconfig:21: WARNING: please write a paragraph that
> > > > describes the config symbol fully
> > > > drivers/iio/dummy/Kconfig:29: WARNING: please write a paragraph that
> > > > describes the config symbol fully
> > > > 
> > > > This patch expands the explanation about IIO_DUMMY_EVGEN by using the
> > > > code documentation found in iio/dummy/iio_dummy_evgen.c. In the same
> > > > way, the information related to IIO_SIMPLE_DUMMY_BUFFER was extracted
> > > > from file iio_simple_dummy_buffer.c. Finally, this patch apply the
> > > > coding-style for Kconfig files (Documentation/process/coding-style.rst)
> > > > 
> > > > Signed-off-by: Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>  
> > > 
> > > Several different things going on in the one patch, please do
> > > it as a short series with one thing per patch.
> > > 
> > > Certainly do the coding style separately from the additional documentation.
> > > 
> > > Thanks,
> > > 
> > > Jonathan  
> > 
> > So, should I split it into two different patches? One patch for the fix
> > and other for the extra documentation?
> Yes that would be perfect.

Ok, I will send a v2 with two patches.

Thanks

> > 
> > Finally, in the two warnings related to "please write a paragraph that
> > describes the config symbol fully" the extra documentation that fixes
> > it. Other fixes, are related to the coding-style.rst however checkpatch
> > does not complain about them.
> 
> Sure, checkpatch doesn't get everything.
> 
> Jonathan
> >  
> > >   
> > > > ---
> > > >  drivers/iio/dummy/Kconfig | 26 ++++++++++++++++----------
> > > >  1 file changed, 16 insertions(+), 10 deletions(-)
> > > > 
> > > > diff --git a/drivers/iio/dummy/Kconfig b/drivers/iio/dummy/Kconfig
> > > > index 5a29fbd3c531..4a7127fb2979 100644
> > > > --- a/drivers/iio/dummy/Kconfig
> > > > +++ b/drivers/iio/dummy/Kconfig
> > > > @@ -9,20 +9,24 @@ config IIO_DUMMY_EVGEN
> > > >  	tristate
> > > >  
> > > >  config IIO_SIMPLE_DUMMY
> > > > -       tristate "An example driver with no hardware requirements"
> > > > -       depends on IIO_SW_DEVICE
> > > > -       help
> > > > -	 Driver intended mainly as documentation for how to write
> > > > -	 a driver. May also be useful for testing userspace code
> > > > -	 without hardware.
> > > > +	tristate "An example driver with no hardware requirements"
> > > > +	depends on IIO_SW_DEVICE
> > > > +	help
> > > > +	  Driver intended mainly as documentation for how to write
> > > > +	  a driver. May also be useful for testing userspace code
> > > > +	  without hardware.
> > > >  
> > > >  if IIO_SIMPLE_DUMMY
> > > >  
> > > >  config IIO_SIMPLE_DUMMY_EVENTS
> > > > -       bool "Event generation support"
> > > > -       select IIO_DUMMY_EVGEN
> > > > -       help
> > > > -         Add some dummy events to the simple dummy driver.
> > > > +	bool "Event generation support"
> > > > +	select IIO_DUMMY_EVGEN
> > > > +	help
> > > > +	  Add some dummy events to the simple dummy driver.
> > > > +
> > > > +	  The purpose of this is to generate 'fake' event interrupts thus
> > > > +	  allowing that driver's code to be as close as possible to that
> > > > +	  a normal driver talking to hardware.
> > > >  
> > > >  config IIO_SIMPLE_DUMMY_BUFFER
> > > >  	bool "Buffered capture support"
> > > > @@ -32,6 +36,8 @@ config IIO_SIMPLE_DUMMY_BUFFER
> > > >  	help
> > > >  	  Add buffered data capture to the simple dummy driver.
> > > >  
> > > > +	  Buffer handling elements of industrial I/O reference driver.
> > > > +	  Uses the kfifo buffer.
> > > >  endif # IIO_SIMPLE_DUMMY
> > > >  
> > > >  endmenu  
> > >   
> 
