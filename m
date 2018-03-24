Return-Path: <linus.walleij@linaro.org>
ARC-Seal: i=1; a=rsa-sha256; t=1521909258; cv=none;
        d=google.com; s=arc-20160816;
        b=1FY2axvu73ZYb+Sn+x2dt1jnQl7ZefD9pFEky3jO2ddBgS1Df3/a7TPEnLM4wGq7PY
         VroNh+5ESBckX4qQ4WXUtDuEglp4t6SFIT/CQ8XcTnmtNq2D6c6khbLKrPHvbKQLLCSG
         wjWzeNMujsSM/g8kPlRWhjHT6CYRkO35Qk5B3S1lDKY9jCuPLNlj9CL2saNC9SISNDv5
         jx2vxnPKDipbsj0xWUiWYpIGEvF07UPF97oFLWWXke+OIBLcaRSSOZ9n6dCufX8+mgf9
         SHwQbyK3cjIVSk7SpKDz1uicwwnFmNtuY+/tdJ/yVBdSNW6fm/HNTIqBhCt9N+T46Nzk
         BOLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:dkim-signature:arc-authentication-results;
        bh=aBhyvkMzqH5zoNRN64eTSHUwgS+l8bOo17+XyTHCrt8=;
        b=YjjKCDPC7mxJFoHZoqgDBkWZahZqC5kV15unTgAXSS+6mbL/TbeCBDG53OgqepR9Ad
         7UdlHMKfqhKDlsNN25GcyXfxyZUkha2KHPQaWurhVY1ZHfOnqqLGdT5/MPA3sg5J40vk
         vd4d8WgL+ahhuKvIPcG91G3tg8rXwFTBre7mazJZVk8VdKu4tpLv55y2WC9E/dxbIzkk
         Q4fjtYYsOBOM+CA56vDyGTBxx8Qay11o6wa4o4/+8P0TGeoBMj6DKi7HTfAOJprjWlC/
         WCO98EaQPO+eApRCG6i29pv8LbnctEZGxMzirDn5beaSODBco1jrC+LOHC7rWTM106sT
         ZK0w==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@linaro.org header.s=google header.b=CTyU6QQ9;
       spf=pass (google.com: domain of linus.walleij@linaro.org designates 209.85.220.41 as permitted sender) smtp.mailfrom=linus.walleij@linaro.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=linaro.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@linaro.org header.s=google header.b=CTyU6QQ9;
       spf=pass (google.com: domain of linus.walleij@linaro.org designates 209.85.220.41 as permitted sender) smtp.mailfrom=linus.walleij@linaro.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=linaro.org
X-Google-Smtp-Source: AG47ELt5CT29+3bF6eFZGUKy4bCJAUDFIzVlEB3+858tdab8KMTawdywkEiscxK1hFpnbZjV7/7i4F27UlhCwFfzayg=
MIME-Version: 1.0
In-Reply-To: <20180324134801.0e6254ee@archlinux>
References: <20180319170246.26830-1-peda@axentia.se> <20180323141401.000031cc@huawei.com>
 <0863dfa7-c1da-7691-a896-9b414e2fddfa@axentia.se> <20180324134801.0e6254ee@archlinux>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Sat, 24 Mar 2018 17:34:17 +0100
Message-ID: <CACRpkdYPayHqYdFMmts20yLRdMEy6SW-qqnC+BsYip-RdN2HSQ@mail.gmail.com>
Subject: Re: [PATCH 0/3] iio: add unit converter
To: Jonathan Cameron <jic23@kernel.org>
Cc: Peter Rosin <peda@axentia.se>, Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>, Peter Meerwald-Stadler <pmeerw@pmeerw.net>, Rob Herring <robh+dt@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>, "David S. Miller" <davem@davemloft.net>,
	Mauro Carvalho Chehab <mchehab@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Randy Dunlap <rdunlap@infradead.org>, linux-iio@vger.kernel.org,
	"open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595386339632135527?=
X-GMAIL-MSGID: =?utf-8?q?1595837522794873569?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Sat, Mar 24, 2018 at 2:48 PM, Jonathan Cameron <jic23@kernel.org> wrote:
> On Fri, 23 Mar 2018 14:59:41 +0100
> Peter Rosin <peda@axentia.se> wrote:

>> So, not super-happy about that either. And maybe leave the mux
>> where it is? It's just that I have the feeling that the iio-mux
>> is never going to get any friends in its category, and the mux
>> and the unit-converter are kind of related in that they operate
>> on other channels. But maybe that's only logical it you know how
>> they are implemented...
>
> Perhaps Analog Front ends?
> We could move the amplifier driver into the same directory as well,
> though right now that driver is not passing the channels through
> (it's often used without there being an IIO ADC behind it I think...)

(passive) linear scaler?
analog linear scaler?
But maybe these supersets are not broad enough.

Or just invent another acronym akin to "PHY" such as
"AIF" (analog interface)?

Yours,
Linus Walleij
