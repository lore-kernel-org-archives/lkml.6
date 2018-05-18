Return-Path: <robherring2@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1526681991; cv=none;
        d=google.com; s=arc-20160816;
        b=dea4JUoL+0TsgcYCSw9e+hly9irwOgCmturuc/xdiK8MnfkotbmVtltJyW2b8tz19K
         QLVhWC4Qa9W1ceHcJPHYRHJ2Ch3AR+Ax/i5wzzEmKMYvgXeT5HEmBAZnbyFdgp84FeC9
         NZKtxXPsD1JkPzq7LzAv1ki96amsjdu6IM1RvavQDjQfyMNHZ1Yu1Dr1phlT7FkWNRrf
         0zSQjXS4UTfPPyBkwAHbiGYiGMSYCjREdXzEZRtp8MtkovnTt6Uj2UX/MbNMhp61oGd5
         NMmrkTnTUlA1j2XAvmEuZJPkw8gboIQKy6AxrMgc6sYwDYs6SWtzAWOTkmnN3i5tkghK
         j0sA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:arc-authentication-results;
        bh=NHyDoZHpTcBD3xTaaRDP6jmUbYwxuseed1p8jD8KUlg=;
        b=ujq+UJKrnKDBS03bQy7O3pmVcqxfyLCRQ7aQI1O4wgRyQlXK5YxBVKCrfPmhHeFjN9
         jFJ4miBcxLBZ59SBaOLc/rMJOanigS8R+XyLTp6Ym1rDBEVtFiuXaC+AYinSSxLGMnqF
         ZOjIDr8Fb4oR4qRdU0vuVRAHe5Os8FL5keTPbV+OXZvn9maYVaC1qzN0TXThwS6FeAeu
         dSJ3mAwyVvXVdVrEeobmRQcAED3a92x/1CmVn7+HKg5oHooYpcyQUG9suwxSO3dX5lBc
         PcAsRfiX4ofoxusmmOgEga+wwGVA4/hzDUTpl3ftpsO3lqN1iX8o/L2/aF8iEusE/RRq
         ZTOA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of robherring2@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=robherring2@gmail.com;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of robherring2@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=robherring2@gmail.com;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=kernel.org
X-Google-Smtp-Source: AB8JxZrOp5bOc7MhsDPnxBI2KZQ1s3rx6qeglm13aw/BBVZEvP5/MEP3GhIJ2p/RnYaj83Z8Y3xGhw==
Date: Fri, 18 May 2018 17:19:49 -0500
From: Rob Herring <robh@kernel.org>
To: Radu Pirea <radu.pirea@microchip.com>
Cc: devicetree@vger.kernel.org, linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-spi@vger.kernel.org, mark.rutland@arm.com,
	lee.jones@linaro.org, gregkh@linuxfoundation.org, jslaby@suse.com,
	richard.genoud@gmail.com, alexandre.belloni@bootlin.com,
	nicolas.ferre@microchip.com, broonie@kernel.org
Subject: Re: [PATCH v3 2/6] mfd: at91-usart: added mfd driver for usart
Message-ID: <20180518221949.GA13443@rob-hp-laptop>
References: <20180511103822.31698-1-radu.pirea@microchip.com>
 <20180511103822.31698-3-radu.pirea@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180511103822.31698-3-radu.pirea@microchip.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1600163722809709607?=
X-GMAIL-MSGID: =?utf-8?q?1600842096288472605?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, May 11, 2018 at 01:38:18PM +0300, Radu Pirea wrote:
> This mfd driver is just a wrapper over atmel_serial driver and
> spi-at91-usart driver. Selection of one of the drivers is based on a
> property from device tree. If the property is not specified, the default
> driver is atmel_serial.
> 
> Signed-off-by: Radu Pirea <radu.pirea@microchip.com>
> ---
>  drivers/mfd/Kconfig                  | 10 ++++
>  drivers/mfd/Makefile                 |  1 +
>  drivers/mfd/at91-usart.c             | 75 ++++++++++++++++++++++++++++
>  include/dt-bindings/mfd/at91-usart.h | 17 +++++++
>  4 files changed, 103 insertions(+)
>  create mode 100644 drivers/mfd/at91-usart.c
>  create mode 100644 include/dt-bindings/mfd/at91-usart.h
> 

> +#ifndef __DT_BINDINGS_AT91_USART_H__
> +#define __DT_BINDINGS_AT91_USART_H__
> +
> +#define AT91_USART_MODE_SERIAL	1
> +#define AT91_USART_MODE_SPI	2

Won't this require a DT update for serial mode to add the mode property? 
That breaks compatibility.

Rob
