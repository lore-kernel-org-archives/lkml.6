Return-Path: <afd@ti.com>
X-Google-Smtp-Source: AIpwx4/GUF4iBdh+8mXyikSifEmbHTsJRG79Vksyeqh8Ilrrsfcemg4y3ELH7HCuxOA7qmJLvBdf
ARC-Seal: i=1; a=rsa-sha256; t=1523460912; cv=none;
        d=google.com; s=arc-20160816;
        b=ysmpblxTjUOn07gUDUs6lwUXg8bDAIWlsXRqu3FPX8k/8D2G2HdOMRF4NmKtU8N59G
         Map7zXGBNTAIbB8g4cvH3vevjuXgo1McYpNZ5sbnElanNJJe2eZY6C6m0hXX6h2kx9uz
         8HQQv/J/lYBaCZzv0bpeLJrkUXwgVcgBhgETxPgipwCrImUXRSBi4v+itDQ85oVRMRAY
         JiMQhMaPMjoRNFBEsi2uvG0LvEnjD/Li5D24QdRVeB79NxS+tq0uOuJngtRnKom/DVpi
         Sj15bC1CgK6YH2hRKI0Y3sdoq96mb5NcCvvmkzdbMD8P0fIsBLWvAgsfCBVlLrodQl4V
         Mvlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :dkim-signature:arc-authentication-results;
        bh=jCdkI968dLvu2GU2NXfbBhjfjaIrj3mFF5NZNqtybcY=;
        b=IuurGL5BM6CPYgE8e68DsdE6jMauroPPU8/bmjRt3Uv1fZYQ3hChKu6bv1BxUmRRY9
         pmGDGcsLMz+2+d033Ximz906AqtQ7o43iS6oKQ7lt7CizufqKGSjyTvj+WOj/Ta2oJkl
         UVVRzFiEx64uhjXQV+8tI8HBPjHxvT6Z4QDarKL81TPoNw5bL67Eii5xByYlUexm80+h
         Mx4uqgXwu1ROXLmvOs19QDBNRPEZuwOukEkAzWCeqCKmfNFCOeZPiJ3Xtp17H5HFPimG
         TH8Wft6cUME7OEI7Znga9H6KwlJVqqP+lxISCh1j6arQCVkV3jpWVyDpzyZzc1eIzgjM
         fF2Q==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@ti.com header.s=ti-com-17Q1 header.b=dHALT6Sj;
       spf=pass (google.com: domain of afd@ti.com designates 198.47.27.80 as permitted sender) smtp.mailfrom=afd@ti.com;
       dmarc=pass (p=QUARANTINE sp=NONE dis=NONE) header.from=ti.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@ti.com header.s=ti-com-17Q1 header.b=dHALT6Sj;
       spf=pass (google.com: domain of afd@ti.com designates 198.47.27.80 as permitted sender) smtp.mailfrom=afd@ti.com;
       dmarc=pass (p=QUARANTINE sp=NONE dis=NONE) header.from=ti.com
Subject: Re: [PATCH v3 0/2] iio: add unit converter
To: Peter Rosin <peda@axentia.se>, <linux-kernel@vger.kernel.org>
CC: Jonathan Cameron <jic23@kernel.org>, Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler
	<pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland
	<mark.rutland@arm.com>,
        "David S. Miller" <davem@davemloft.net>,
        Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mauro Carvalho Chehab
	<mchehab@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Andrew Morton
	<akpm@linux-foundation.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Fabio
 Estevam <festevam@gmail.com>, <linux-iio@vger.kernel.org>,
        <devicetree@vger.kernel.org>
References: <20180410152802.30958-1-peda@axentia.se>
 <20180411141555.15044-1-peda@axentia.se>
From: "Andrew F. Davis" <afd@ti.com>
Message-ID: <fe90dc62-ef2b-d999-6841-2d9d5943654c@ti.com>
Date: Wed, 11 Apr 2018 10:34:40 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180411141555.15044-1-peda@axentia.se>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597373525263580007?=
X-GMAIL-MSGID: =?utf-8?q?1597464549351080235?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 04/11/2018 09:15 AM, Peter Rosin wrote:
> Hi!
> 
> I'm now following up with one more binding for the unit-converter.
> This time with a real IC, namely LT6106 from Analog Devices.

This makes more sense to me, I wasn't thinking about more complex ICs
like this when I made my "resistor being part of the sensing device"
argument.

I can see how having a new node will probably be needed. It just seems
strange to ask a resistor for its current, although it is the "device"
that "knows" how much current if flowing though it..

A case I'm more familiar with, fuel gauges, we have a gauge device that
has a handle to the battery it is gauging [0], we still ask the
"fuel-gauge" node to get out the state of charge, not the "battery"
node, the battery is not a "device" from our perspective.

Thinking more about that, I like your way better, so I recant my earlier
objections.

Andrew

[0] Documentation/devicetree/bindings/power/supply/bq27xxx.txt

> It's
> a current sense amplifier. I was a but unsure if I should have
> the Rin and Rout resistors in the binding or if I instead should
> have used the "gain". In the end I went with the resistors since
> while the normal case is an integer gain, that may not always be
> the case. And when it's not, that could get tricky. But I'm open
> for arguments on that.
> 
> Cheers,
> Peter
> 
> Peter Rosin (2):
>   dt-bindings: iio: afe: add binding for adi,lt6106
>   iio: afe: unit-converter: add support for adi,lt6106
> 
>  .../devicetree/bindings/iio/afe/adi,lt6106.txt     | 50 ++++++++++++++++++++
>  MAINTAINERS                                        |  1 +
>  drivers/iio/afe/Kconfig                            |  3 +-
>  drivers/iio/afe/iio-unit-converter.c               | 54 ++++++++++++++++++++++
>  4 files changed, 107 insertions(+), 1 deletion(-)
>  create mode 100644 Documentation/devicetree/bindings/iio/afe/adi,lt6106.txt
> 
