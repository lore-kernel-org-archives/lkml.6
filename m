Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752094AbeEGIZ0 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 7 May 2018 04:25:26 -0400
Received: from esa6.microchip.iphmx.com ([216.71.154.253]:44252 "EHLO
        esa6.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751900AbeEGIZX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 May 2018 04:25:23 -0400
X-IronPort-AV: E=Sophos;i="5.49,373,1520924400";
   d="scan'208";a="11246767"
Subject: Re: [PATCH] spi-nor: Add support for Atmel Dataflash memories
To: Boris Brezillon <boris.brezillon@bootlin.com>,
        Radu Pirea <radu.pirea@microchip.com>
CC: <cyrille.pitchen@wedev4u.fr>, <marek.vasut@gmail.com>,
        <dwmw2@infradead.org>, <computersforpeace@gmail.com>, <richard@nod.at>,
        <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        Tudor Ambarus - M18064 <Tudor.Ambarus@microchip.com>
References: <1519818901-7116-1-git-send-email-radu.pirea@microchip.com>
 <20180504203844.0c09bf6d@bbrezillon>
From: Nicolas Ferre <nicolas.ferre@microchip.com>
Organization: microchip
Message-ID: <d9b3fffd-dded-b210-e058-13a326b4fb8f@microchip.com>
Date: Mon, 7 May 2018 10:23:56 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180504203844.0c09bf6d@bbrezillon>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/05/2018 at 20:38, Boris Brezillon wrote:
> Hi Radu,
> 
> Sorry for the late reply.
> 
> On Wed, 28 Feb 2018 13:55:01 +0200
> Radu Pirea <radu.pirea@microchip.com> wrote:
> 
>> This patch add support in spi-nor for allmost all dataflash memories
>> supported by old mtd_dataflash driver.
> 
> Those devices clearly use a different instruction set, so I don't think
> they fit in this framework. Can you tell us why you want to move
> dataflash support to the SPI NOR framework. I think I know why, but I'd
> like to get your version. My guess is that some people want to connect
> dataflash chips to the Atmel QSPI controller, and it's not supported
> right now because the Atmel QSPI controller implements the SPI-NOR
> interface and not the generic SPI one, thus preventing anything that
> is not a SPI NOR from being connected to this controller.
> 
> If I'm right, then the solution is to convert the QSPI driver to the
> spi-mem interface [1] and move it to drivers/spi/.

No, I we didn't think about this. Dataflash is not so popular those days 
and we don't want to revive it anyway. Our QSPI driver has already a lot 
of things to handle in QSPI-related topics to not mix it with oldies ;-)

The rationale behind this work is to get rid of the very old dataflash 
standalone driver and benefit from the whole spi-nor infrastructure like 
cache coherency management and DMA handling (which were broken in the 
old dataflash driver in recent kernels).

Best regards,
   Nicolas


> [1]http://patchwork.ozlabs.org/project/linux-mtd/list/?series=41174
> 


-- 
Nicolas Ferre
