Date: Fri, 6 Apr 2018 10:21:38 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Ben Hutchings <ben.hutchings@codethink.co.uk>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	Kevin Hilman <khilman@baylibre.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <alexander.levin@verizon.com>
Subject: Re: [PATCH 4.4 071/101] spi: davinci: use dma_mapping_error()
Message-ID: <20180406082138.GA12342@kroah.com>
References: <20170703133334.237346187@linuxfoundation.org>
 <20170703133346.376540288@linuxfoundation.org>
 <1499264677.1935.91.camel@codethink.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1499264677.1935.91.camel@codethink.co.uk>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, Jul 05, 2017 at 03:24:37PM +0100, Ben Hutchings wrote:
> On Mon, 2017-07-03 at 15:35 +0200, Greg Kroah-Hartman wrote:
> > 4.4-stable review patch.  If anyone has any objections, please let me know.
> > 
> > ------------------
> > 
> > From: Kevin Hilman <khilman@baylibre.com>
> > 
> > 
> > [ Upstream commit c5a2a394835f473ae23931eda5066d3771d7b2f8 ]
> > 
> > The correct error checking for dma_map_single() is to use
> > dma_mapping_error().
> > 
> > Signed-off-by: Kevin Hilman <khilman@baylibre.com>
> > Signed-off-by: Mark Brown <broonie@kernel.org>
> > Signed-off-by: Sasha Levin <alexander.levin@verizon.com>
> > Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > ---
> >  drivers/spi/spi-davinci.c |    4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> > --- a/drivers/spi/spi-davinci.c
> > +++ b/drivers/spi/spi-davinci.c
> > @@ -651,7 +651,7 @@ static int davinci_spi_bufs(struct spi_d
> >  			buf = t->rx_buf;
> >  		t->rx_dma = dma_map_single(&spi->dev, buf,
> >  				t->len, DMA_FROM_DEVICE);
> > -		if (!t->rx_dma) {
> > +		if (dma_mapping_error(&spi->dev, !t->rx_dma)) {
> [...]
> 
> The '!' needs to be deleted.  This appears to have been fixed upstream
> by:
> 
> commit 8aedbf580d21121d2a032e4c8ea12d8d2d85e275
> Author: Fabien Parent <fparent@baylibre.com>
> Date:   Thu Feb 23 19:01:56 2017 +0100
> 
>     spi: davinci: Use SPI framework to handle DMA mapping
> 
> which is not suitable for stable.

Sorry for the delay, now fixed up.

greg k-h
