Return-Path: <Radu.Pirea@microchip.com>
X-Google-Smtp-Source: AB8JxZqM6lBDXD3BouGUtnAJ5iwM53+K5/EQJX5FvhtPRxIVmdP9ky6qe6ru2WOO3MrSbDiXwOuv
ARC-Seal: i=1; a=rsa-sha256; t=1527062956; cv=none;
        d=google.com; s=arc-20160816;
        b=Y0HXx/UGYimorb77Of3aUw+YYsQZIFXK4UhZL7y7N/5/HjURpaKIzivoz6vRPhXqY0
         ellPlyuWIq1p/uWu3ute97eO+RQlkRhB7gv2ADki0KHGNSUCILLH+Q7ZGprifR5E0a2r
         SVDEDRvy20BwmtXdn1XdyHPUsS7Y6MoQkZZYzytT0lVkqRgqhK9oYpHBMjY/whEcwegD
         gwrnqREYOcz3vQXeDz0N+XojatM5QaJ8SneFFtz0r0lSBBfgHNDha4MiGfY1I68U2+bE
         SX7snV5dxUYLV2RNbXidO19GXuedmwnB8X8Kul31wJe4gByesPNHNyyOU0szHne1CZ+u
         8qKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :arc-authentication-results;
        bh=DNt9KVUZIVnJif6Z/ALPGZAs7lpEks1HSkIoPuq2YDc=;
        b=LPCjKpOYInnmyJGujz7nR1fTc0TMxSmEWKHYVRYIXvrDyFzFCsvZoSQ5VNbvauFfjE
         emtLhnFNJ/fQ/S9FZyk5G/22z+63Yof9/BJ6YgGOf7Ujbp8Y8nxwz/w1Qt1m5rlM81SW
         Pe+BjAVmqJ2e+BwF43Fm+RRlzb7IolJzSYCz8DxElnGQPflww6sQ6OQ2DduYVdmget0F
         1Aji8svBjtSeZqzDJF4eQcfaW71siu5xnKllhB6NYYjCyqGUQA1+4ivU/RDgQPcx4IvX
         lZm0TI5FU2w1NHIfRqXtvlcJrXv5peuGkueYhttY9SEnnjRjktdFzTPu/OQPZbRR+TDg
         jqOA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of radu.pirea@microchip.com designates 68.232.153.233 as permitted sender) smtp.mailfrom=Radu.Pirea@microchip.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of radu.pirea@microchip.com designates 68.232.153.233 as permitted sender) smtp.mailfrom=Radu.Pirea@microchip.com
X-IronPort-AV: E=Sophos;i="5.49,432,1520924400";
   d="scan'208";a="14563992"
Subject: Re: [PATCH v3 5/6] spi: at91-usart: add driver for at91-usart as spi
To: Mark Brown <broonie@kernel.org>
CC: <devicetree@vger.kernel.org>, <linux-serial@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-spi@vger.kernel.org>, <mark.rutland@arm.com>, <robh+dt@kernel.org>,
	<lee.jones@linaro.org>, <gregkh@linuxfoundation.org>, <jslaby@suse.com>,
	<richard.genoud@gmail.com>, <alexandre.belloni@bootlin.com>,
	<nicolas.ferre@microchip.com>
References: <20180511103822.31698-1-radu.pirea@microchip.com>
 <20180511103822.31698-6-radu.pirea@microchip.com>
 <20180517050406.GF20254@sirena.org.uk>
From: Radu Pirea <radu.pirea@microchip.com>
Message-ID: <6a59e071-3159-4939-8535-6c7a9d491379@microchip.com>
Date: Wed, 23 May 2018 11:10:28 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180517050406.GF20254@sirena.org.uk>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1600163736740058885?=
X-GMAIL-MSGID: =?utf-8?q?1601241567180175131?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>



On 05/17/2018 08:04 AM, Mark Brown wrote:
> On Fri, May 11, 2018 at 01:38:21PM +0300, Radu Pirea wrote:
> 
>> +config SPI_AT91_USART
>> +        tristate "Atmel USART Controller as SPI"
>> +	depends on HAS_DMA
>> +	depends on (ARCH_AT91 || COMPILE_TEST)
>> +        select MFD_AT91_USART
>> +	help
>> +	  This selects a driver for the AT91 USART Controller as SPI Master,
>> +	  present on AT91 and SAMA5 SoC series.
>> +
> 
> This looks like there's some tab/space mixing going on here.
> 
>> +// SPDX-License-Identifier: GPL-2.0
>> +/*
>> + * Driver for AT91 USART Controllers as SPI
>> + *
>> + * Copyright (C) 2018 Microchip Technology Inc.
> 
> Make the entire block a C++ comment so it looks more intentional rather
> tha mixing C and C++.

Hi Mark,

I know it's ugly, but SPDX license identifier must be in a separate 
comment block.

> 
>> +static inline void at91_usart_spi_tx(struct at91_usart_spi *aus)
>> +{
>> +	unsigned int len = aus->current_transfer->len;
>> +	unsigned int remaining = aus->current_tx_remaining_bytes;
>> +	const u8  *tx_buf = aus->current_transfer->tx_buf;
>> +
>> +	if (tx_buf && remaining) {
>> +		if (at91_usart_spi_tx_ready(aus))
>> +			spi_writel(aus, THR, tx_buf[len - remaining]);
>> +			aus->current_tx_remaining_bytes--;
> 
> Missing braces here - we only write to the FIFO if there's space but we
> unconditionally decrement the counter.
> 

Thanks. I will fix it.

>> +	} else {
>> +		if (at91_usart_spi_tx_ready(aus))
>> +			spi_writel(aus, THR, US_DUMMY_TX);
>> +	}
>> +}
> 
> This looks like you're open coding SPI_CONTROLLER_MUST_TX
> 
>> +	int len = aus->current_transfer->len;
>> +	int remaining = aus->current_rx_remaining_bytes;
>> +	u8  *rx_buf = aus->current_transfer->rx_buf;
>> +
>> +	if (aus->current_rx_remaining_bytes) {
>> +		rx_buf[len - remaining] = spi_readb(aus, RHR);
>> +		aus->current_rx_remaining_bytes--;
>> +	} else {
>> +		spi_readb(aus, RHR);
>> +	}
> 
> Similarly for _MUST_RX.
> 
>> +	controller->flags = SPI_MASTER_MUST_RX | SPI_MASTER_MUST_TX;
> 
> You're actually setting both flags...  this means that the handling for
> cases with missing TX or RX buffers can't happen.

Sorry. My mistake. I will remove unnecessary code.
