Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S940181AbeE1QhZ (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 12:37:25 -0400
Received: from mout01.posteo.de ([185.67.36.141]:38575 "EHLO mout01.posteo.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934400AbeE1KIP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 06:08:15 -0400
Subject: Re: [PATCH v4 6/6] tty/serial: atmel: changed the driver to work
 under at91-usart mfd
To: Radu Pirea <radu.pirea@microchip.com>, broonie@kernel.org,
        nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com,
        lee.jones@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com,
        gregkh@linuxfoundation.org
Cc: linux-spi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-serial@vger.kernel.org
References: <20180525171941.26766-1-radu.pirea@microchip.com>
 <20180525171941.26766-7-radu.pirea@microchip.com>
From: Richard Genoud <richard.genoud@gmail.com>
Message-ID: <e1445467-2df0-4593-852d-939e6795f318@sorico.fr>
Date: Mon, 28 May 2018 12:08:02 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180525171941.26766-7-radu.pirea@microchip.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25/05/2018 19:19, Radu Pirea wrote:
> This patch modifies the place where resources and device tree properties
> are searched.
> 
> Signed-off-by: Radu Pirea <radu.pirea@microchip.com>
> ---
>  drivers/tty/serial/Kconfig        |  1 +
>  drivers/tty/serial/atmel_serial.c | 40 +++++++++++++++++--------------
>  2 files changed, 23 insertions(+), 18 deletions(-)
the stdout-path property of the chosen node is still broken in this verion.
if :
stdout-path = "serial0:115200n8";
is set in the DTS, the console output should go on serial0 (aka dbgu)
cf Documentation/devicetree/bindings/chosen.txt

With this patch applied, this is not the case anymore.
Adding console=ttyS0,115200 in the chosen node is not the solution here.


regards,
Richard.
