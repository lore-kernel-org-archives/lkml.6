Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932080AbeCCPVo (ORCPT <rfc822;w@1wt.eu>);
        Sat, 3 Mar 2018 10:21:44 -0500
Received: from mail.kernel.org ([198.145.29.99]:48500 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751896AbeCCPVm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Mar 2018 10:21:42 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 448A42133D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=jic23@kernel.org
Date: Sat, 3 Mar 2018 15:21:37 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>
Cc: Hartmut Knaack <knaack.h@gmx.de>, Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>, daniel.baluta@nxp.com,
        kernel-janitors@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] iio:dummy: Add extra paragraphs on Kconfig
Message-ID: <20180303152137.780533f0@archlinux>
In-Reply-To: <7cfd9fd93e76fede44d328045e7885cd78324a78.1519738995.git.rodrigosiqueiramelo@gmail.com>
References: <cover.1519738995.git.rodrigosiqueiramelo@gmail.com>
        <7cfd9fd93e76fede44d328045e7885cd78324a78.1519738995.git.rodrigosiqueiramelo@gmail.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 27 Feb 2018 10:47:06 -0300
Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com> wrote:

> This patch fixes the checkpatch.pl warning:
> 
> drivers/iio/dummy/Kconfig:21: WARNING: please write a paragraph that
> describes the config symbol fully
> drivers/iio/dummy/Kconfig:27: WARNING: please write a paragraph that
> describes the config symbol fully
> 
> This patch expands the explanation about IIO_DUMMY_EVGEN by using the
> code documentation found in iio/dummy/iio_dummy_evgen.c. In the same
> way, the information related to IIO_SIMPLE_DUMMY_BUFFER was extracted
> from file iio_simple_dummy_buffer.c.
> 
> Signed-off-by: Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>
Applied to the togreg branch of iio.git and pushed out as testing
for the autobuilders to play with it,

Thanks,

Jonathan

> ---
>  drivers/iio/dummy/Kconfig | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/drivers/iio/dummy/Kconfig b/drivers/iio/dummy/Kconfig
> index 85e13b2e35bf..c4fd108e91d3 100644
> --- a/drivers/iio/dummy/Kconfig
> +++ b/drivers/iio/dummy/Kconfig
> @@ -24,6 +24,10 @@ config IIO_SIMPLE_DUMMY_EVENTS
>  	help
>  	  Add some dummy events to the simple dummy driver.
>  
> +	  The purpose of this is to generate 'fake' event interrupts thus
> +	  allowing that driver's code to be as close as possible to that
> +	  a normal driver talking to hardware.
> +
>  config IIO_SIMPLE_DUMMY_BUFFER
>  	bool "Buffered capture support"
>  	select IIO_BUFFER
> @@ -32,6 +36,9 @@ config IIO_SIMPLE_DUMMY_BUFFER
>  	help
>  	  Add buffered data capture to the simple dummy driver.
>  
> +	  Buffer handling elements of industrial I/O reference driver.
> +	  Uses the kfifo buffer.
> +
>  endif # IIO_SIMPLE_DUMMY
>  
>  endmenu
