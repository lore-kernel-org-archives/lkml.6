Return-Path: <phil@raspberrypi.org>
X-Google-Smtp-Source: AIpwx4+J8wqZJ44CCvcnH2i19Vec+vdzy8KzrtQjJjYoMB2oYy+rz5+uz7Xtsy2slpmQ+xIH4U1R
ARC-Seal: i=1; a=rsa-sha256; t=1523542723; cv=none;
        d=google.com; s=arc-20160816;
        b=hloMoVTZgHNkpnWly8KGWa9uQ50Q04LiOpzWk31xRakONUgtLG9Qq+9OC+cs5v4ezR
         2A7HpM2Ja7EIwkXbzBSwkhPE/RUaL6Ra6xXfGxfpnahSbYawGyapAUCkzEq/mwJFyxt0
         98745dv1C3+ddwTbTJPhTR+mzBQhLnxV/1xOFqS1L2lOMGyJfgnGk+81ZmLMY7EY8x5s
         9iIwgA6+5ViAdYBjup0n+LF2CBIhx6R38PKdYVLExgxJZ9oSsMRX7BlnYaeyUnMY19rs
         2xgo0uMjaY8SEjeX7ldA2QeGJCqCtHBZSuOn5QhSsIC00GnDqNRr63kmaLXZi98jtqbh
         JxeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :dkim-signature:dkim-signature:arc-authentication-results;
        bh=gOePZq6/BEqfu+MRZK10p1n3gwkv9l47Ic4PwzcrdWA=;
        b=s+pPd54I98J4bDsq0fYioCvoE/WUVad1kb1DjSHpuI/payjJ39id48N54CfQTFmnb1
         2GpQgMQ3suSe2GJaEneh5yEGk0DlWM5KaEf2nuUOg+KtomLc2KIyP+naLZ6qocIMxwZr
         aQFqZAFLwyjt9c4ePDrfRbEk2Lu7g4geNtTvPcxh38eVA7EbFoqCiC6dtD06MfNorGrn
         p5PXfMOMdYoZ223mZU0KPv+xfnBBk/Yk1Z5yyD+VbCF5ZfO+TCO9PZFnDsOzGnABeHOB
         7ZTna/nzkiFqYJdKWkdnzDp6INj9k9yFQvKc0ev2jDSXmRBHTCbgodmLBvM5Z60jTdBF
         OkYA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=fail header.i=@raspberrypi.org header.s=pp header.b=jPeM68NN;
       dkim=pass header.i=@raspberrypi-org.20150623.gappssmtp.com header.s=20150623 header.b=aPbXV3b6;
       spf=pass (google.com: domain of phil@raspberrypi.org designates 62.209.51.214 as permitted sender) smtp.mailfrom=phil@raspberrypi.org
Authentication-Results: mx.google.com;
       dkim=fail header.i=@raspberrypi.org header.s=pp header.b=jPeM68NN;
       dkim=pass header.i=@raspberrypi-org.20150623.gappssmtp.com header.s=20150623 header.b=aPbXV3b6;
       spf=pass (google.com: domain of phil@raspberrypi.org designates 62.209.51.214 as permitted sender) smtp.mailfrom=phil@raspberrypi.org
Subject: Re: [PATCH 1/4] lan78xx: Read MAC address from DT if present
To: Andrew Lunn <andrew@lunn.ch>
Cc: Woojung Huh <woojung.huh@microchip.com>,
        Microchip Linux Driver Support <UNGLinuxDriver@microchip.com>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        "David S. Miller" <davem@davemloft.net>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Randy Dunlap <rdunlap@infradead.org>, netdev@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org
References: <1523541336-145953-1-git-send-email-phil@raspberrypi.org>
 <1523541336-145953-2-git-send-email-phil@raspberrypi.org>
 <20180412140640.GL28963@lunn.ch>
From: Phil Elwell <phil@raspberrypi.org>
Message-ID: <4f95f1bc-412f-6926-0a61-f00e3abe7ecf@raspberrypi.org>
Date: Thu, 12 Apr 2018 15:18:43 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180412140640.GL28963@lunn.ch>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-04-12_07:,,
 signatures=0
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597548895926153829?=
X-GMAIL-MSGID: =?utf-8?q?1597550334847793952?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi Andrew,

On 12/04/2018 15:06, Andrew Lunn wrote:
> Hi Phil
> 
>> -			ret = lan78xx_write_reg(dev, RX_ADDRL, addr_lo);
>> -			ret = lan78xx_write_reg(dev, RX_ADDRH, addr_hi);
>> +		mac_addr = of_get_mac_address(dev->udev->dev.of_node);
> 
> It might be better to use the higher level eth_platform_get_mac_address().

OK - I'll take your word for it.

Phil
