Return-Path: <richard@sorico.fr>
X-Google-Smtp-Source: AB8JxZqC8g4QKO+NRpbmwRqC+nP8NsFWR/LnXQeEOwupXKCIFG7XqTWN7MO7Mv6dLVBRwXDHx6H6
ARC-Seal: i=1; a=rsa-sha256; t=1526390092; cv=none;
        d=google.com; s=arc-20160816;
        b=Ki4dpHzWP1CfDPe2fIheH9TYGJ28P1RrSPTkKnzHcqlAu8RoTlwrQrit08oWG+W+vE
         fg8EtxIN2lnE1dFPJgKbwsU71ufVjfuKpLPC92EgdVrCePz3K6fH1OPrPfipkvYgku5c
         O9NxgFJYYOkYon371q+Oq8wTD54LLd/TE6RjD/d/0lSj04Rg+nr1hrzvfkUMG797Y/xO
         tRayq6EmKOPCl3nf4btC3JnjwfwLEg0j5GaDlsUPX1DjuC16iXLz3bz0jU+xybBZj0G8
         +6X7j4j5mNx1/yP9Oti8gGaEleOud1zWYTCYzjkwMFPzR6adfvn3XzlsurYPuJ6F4cND
         LxwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :arc-authentication-results;
        bh=RCVv/ulXfSF8OB0RmfaqASwdgoH3IT/cYwmTlHBubkc=;
        b=hsASIPFtnp/uIqm2+hXpyPThlXVQaqP3jsJ7SugYqfcjfpTU2u2EaAwZadeeD0EJVR
         qhcsaDEtYmGRWz7QKlN6dX0ivIIwHf6goDT/nZqEwC0j0pM1nm6D8hL9fJrDoKJEl7w9
         JWb7WmVS6HnKAwyDvLYxLJ9bA2o2Mwc+Pi9LrNPXmAciQn17G5azexWP3sFu4DyyzbKR
         wycY43NQGPSo8CWUmNlFQ2Vor02gXchBeM8wvwSf0tGTZ0jNGsPWdOawLuaAl7q5Y00T
         /yEqpXW73nHRGxEJvCPRBWRQzOpBYzKgsDCmLFn+caZTFTU8/iT9kDdG/sw1YiGDDfq9
         zOJQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of richard@sorico.fr designates 185.67.36.141 as permitted sender) smtp.mailfrom=richard@sorico.fr;
       dmarc=fail (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of richard@sorico.fr designates 185.67.36.141 as permitted sender) smtp.mailfrom=richard@sorico.fr;
       dmarc=fail (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Subject: Re: [PATCH v3 6/6] tty/serial: atmel: changed the driver to work
 under at91-usart mfd
To: Radu Pirea <radu.pirea@microchip.com>, devicetree@vger.kernel.org,
 linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-spi@vger.kernel.org
Cc: mark.rutland@arm.com, robh+dt@kernel.org, lee.jones@linaro.org,
 gregkh@linuxfoundation.org, jslaby@suse.com, alexandre.belloni@bootlin.com,
 nicolas.ferre@microchip.com, broonie@kernel.org
References: <20180511103822.31698-1-radu.pirea@microchip.com>
 <20180511103822.31698-7-radu.pirea@microchip.com>
 <4a75568e-a52e-3872-f465-d707372a5c12@sorico.fr>
 <95a51c6c69bf1a2422f545ac1f06846ebcdb186a.camel@microchip.com>
From: Richard Genoud <richard.genoud@gmail.com>
Message-ID: <4d70c73e-9db7-bdff-7414-04a4843acae3@sorico.fr>
Date: Tue, 15 May 2018 15:14:47 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <95a51c6c69bf1a2422f545ac1f06846ebcdb186a.camel@microchip.com>
Content-Type: text/plain; charset=utf-8
Content-Language: fr
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1600163742597492266?=
X-GMAIL-MSGID: =?utf-8?q?1600536017482329039?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 15/05/2018 14:47, Radu Pirea wrote:
> On Mon, 2018-05-14 at 12:57 +0200, Richard Genoud wrote:
>> After your patch, the DMA is not selected anymore:
>> atmel_usart_serial atmel_usart_serial.0.auto: TX channel not
>> available, switch to pio
>> instead of:
>> atmel_usart fffff200.serial: using dma1chan2 for tx DMA transfers
>>
> Fixed.
>> And the kernel doesn't log anymore on the serial console, despite the
>> loglevel=8
>> (after reverting this series, the kernel logs reappears on the serial
>> console)
>>
> Which serial are you using as console? 
fffff200.serial (sam9g35-cm)
( stdout-path = "serial0:115200n8"; in the DTS )

With this series applied, all the kernel log goes on the screen.
Without, it goes on the serial debug.

>> (tests done on sam9g35)
>>
> I will consider the rest of suggestions. 
>> regards,
>> Richard
