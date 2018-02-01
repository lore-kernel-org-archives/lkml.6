Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752657AbeBAP4T (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Feb 2018 10:56:19 -0500
Received: from mailout1.samsung.com ([203.254.224.24]:35778 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751547AbeBAP4Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Feb 2018 10:56:16 -0500
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20180201155614epoutp01682459a4fe850fb0115df14bb56e1587~PPruGZz7m1004610046epoutp01S
X-AuditID: b6c32a48-9adff70000000ff0-71-5a73389e1179
From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
To: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Cc: Hans de Goede <hdegoede@redhat.com>, linux-fbdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org
Subject: Re: [PATCH] fbdev: simplefb: add support for 'memory-region'
 property on DT node
Date: Thu, 01 Feb 2018 16:56:08 +0100
Message-id: <2359956.Z9lQWSAgHb@amdc3058>
User-Agent: KMail/4.13.3 (Linux/3.13.0-96-generic; KDE/4.13.3; x86_64; ; )
In-reply-to: <1516707296-23667-1-git-send-email-hayashi.kunihiko@socionext.com>
MIME-version: 1.0
Content-transfer-encoding: 7Bit
Content-type: text/plain; charset="us-ascii"
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrNIsWRmVeSWpSXmKPExsWy7bCmme48i+Iogz2HRSzmHznHanH4RhOj
        xZvj05ksTvR9YLW4vGsOm8XS6xeZLFr3HmF3YPdYM28No8emVZ1sHu/3XWXzODH9O4vH501y
        AaxRXDYpqTmZZalF+nYJXBnvnx1lLVgiVTFz0hH2Bsbtol2MHBwSAiYSC2f4dDFycQgJ7GCU
        2PWxnQ3C+c4ocW/PAuYuRk6woj8bL7JDJHYDJXofQVV9BWo5c5YVpIpNwEpiYvsqRhBbRMBU
        oq9tN1gRs8BJRokLb58ygSSEBaIlZj3YCtbAIqAqsbR3FRuIzSugKfFh4mSwuKiAl8SWfe1g
        9ZwC/hIrzjxhgagRlPgx+R6YzSwgL7Fv/1RWCFtH4uyxdYwgyyQEjrBJfL+whx3iOReJxSfi
        IF4Qlnh1fAs7hC0t8WzVRkYIezqjxPbfEhC9mxklVu2eAFVkLXH4+EWoBXwSHYf/Qs3kleho
        E4Io8ZCYOrODBcJ2lJizaSZYq5DAIkaJ7x/0JzDKzkJy9iwkZ89CcvYCRuZVjGKpBcW56anF
        RgUmesWJucWleel6yfm5mxjBSULLYwfjgXM+hxgFOBiVeHgTZIujhFgTy4orcw8xSnAwK4nw
        vtlXFCXEm5JYWZValB9fVJqTWnyIUZqDRUmcty3AJUpIID2xJDU7NbUgtQgmy8TBKdXAWNec
        uLoqVvRVWexjFuPNAebZNW/WiD474W8XFvz1xPLstQ8TjTOEP9xundz6+7oOI3PZ2rLgcz5b
        3jxfdf7VP+6M9QLvFy8Pf/0ifaZTyqQ391hVhKoe3ys/KKUfpLdgxxvxKx8EH0x5MSmjVGTD
        8sg1KxhtNA1sVvp9Zz9te/t/66bHdsk+b5RYijMSDbWYi4oTAbPoidMOAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrCLMWRmVeSWpSXmKPExsVy+t9jAd25FsVRBmvOaljMP3KO1eLwjSZG
        izfHpzNZnOj7wGpxedccNoul1y8yWbTuPcLuwO6xZt4aRo9NqzrZPN7vu8rmcWL6dxaPz5vk
        AlijuGxSUnMyy1KL9O0SuDLePzvKWrBEqmLmpCPsDYzbRbsYOTkkBEwk/my8yA5iCwnsZJTY
        uaqwi5ELyP7KKDGp7SYrSIJNwEpiYvsqRhBbRMBUoq9tNxtIEbPASUaJ5XNXA3VzcAgLREuc
        uBAKUsMioCqxtHcVG4jNK6Ap8WHiZLA5ogJeElv2tTOB2JwC/hIrzjxhgVi2hFHifeNVVogG
        QYkfk++xgNjMAvIS+/ZPZYWwtSTW7zzONIGRfxaSsllIymYhKVvAyLyKUTK1oDg3PbfYqMAo
        L7Vcrzgxt7g0L10vOT93EyMwrLcd1urfwfh4SfwhRgEORiUeXg7p4igh1sSy4srcQ4wSHMxK
        Irxv9hVFCfGmJFZWpRblxxeV5qQWH2KU5mBREuflzz8WKSSQnliSmp2aWpBaBJNl4uCUamCc
        JD2l4dNCKa8vIp/cvv657eEsb7codW6l+funRS8rvrRxTYl+knL+1Zeg9APer7il74XW9eTK
        Hso6arrCIJxB9/FPrS2+m5+zn7HcZlf2YGnfraapq2wZdyXsLcqwXFXY46mS5KUxh/FGgFWc
        0RH1ZoVJkzRVLbct51yn+0d1k2P1rRfvr1oosRRnJBpqMRcVJwIAR0CdCGcCAAA=
X-CMS-MailID: 20180201155613epcas2p2ed96bb78dc101a604c5690fec5f7a0a0
X-Msg-Generator: CA
CMS-TYPE: 102P
X-CMS-RootMailID: 20180123113510epcas1p1fc8a6e3ad50127bb84fe350b156a8c07
X-RootMTR: 20180123113510epcas1p1fc8a6e3ad50127bb84fe350b156a8c07
References: <CGME20180123113510epcas1p1fc8a6e3ad50127bb84fe350b156a8c07@epcas1p1.samsung.com>
        <1516707296-23667-1-git-send-email-hayashi.kunihiko@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

On Tuesday, January 23, 2018 08:34:56 PM Kunihiko Hayashi wrote:
> Enables 'memory-region' property referring to the memory description on
> the reserved-memory node in case of devicetree use.
> If there is no 'reg' property that specifies the address and size of
> the framebuffer, the address and size written in the memory description
> on the reserved-memory node can be used for the framebuffer.
> 
> Furthermore, the reserved-memory node needs to have "no-map" attributes
> because simplefb driver maps the region by ioremap_wc().
> 
> Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>

This needs an ACK from Rob or Mark (DT bindings Maintainers).

> ---
>  .../bindings/display/simple-framebuffer.txt        |  3 ++
>  drivers/video/fbdev/simplefb.c                     | 32 ++++++++++++++++++++++
>  2 files changed, 35 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/display/simple-framebuffer.txt b/Documentation/devicetree/bindings/display/simple-framebuffer.txt
> index 5a9ce51..be5139f 100644
> --- a/Documentation/devicetree/bindings/display/simple-framebuffer.txt
> +++ b/Documentation/devicetree/bindings/display/simple-framebuffer.txt
> @@ -56,6 +56,9 @@ Optional properties:
>    framebuffer remains active.
>  
>  - display : phandle pointing to the primary display hardware node
> +- memory-region: phandle to a node describing memory region as framebuffer
> +		 memory instead of reg property. The node should include
> +		 'no-map'.
>  
>  Example:
>  
> diff --git a/drivers/video/fbdev/simplefb.c b/drivers/video/fbdev/simplefb.c
> index a3c44ec..aefc4b1 100644
> --- a/drivers/video/fbdev/simplefb.c
> +++ b/drivers/video/fbdev/simplefb.c
> @@ -29,6 +29,7 @@
>  #include <linux/clk.h>
>  #include <linux/clk-provider.h>
>  #include <linux/of.h>
> +#include <linux/of_address.h>
>  #include <linux/of_platform.h>
>  #include <linux/parser.h>
>  #include <linux/regulator/consumer.h>
> @@ -294,6 +295,35 @@ static void simplefb_clocks_enable(struct simplefb_par *par,
>  static void simplefb_clocks_destroy(struct simplefb_par *par) { }
>  #endif
>  
> +#if defined CONFIG_OF
> +static struct resource *simplefb_parse_dt_reserved_mem(struct device *dev)
> +{
> +	static struct resource res;
> +	struct device_node *np;
> +	int ret;
> +
> +	np = of_parse_phandle(dev->of_node, "memory-region", 0);
> +	if (!np)
> +		return NULL;
> +
> +	ret = of_address_to_resource(np, 0, &res);
> +	if (ret < 0)
> +		return NULL;
> +
> +	if (!of_find_property(np, "no-map", NULL)) {
> +		dev_err(dev, "Can't apply mapped reserved-memory\n");
> +		return NULL;
> +	}
> +
> +	return &res;
> +}
> +#else
> +static struct resource *simplefb_parse_dt_reserved_mem(struct device *dev)
> +{
> +	return NULL;
> +}
> +#endif
> +
>  #if defined CONFIG_OF && defined CONFIG_REGULATOR
>  
>  #define SUPPLY_SUFFIX "-supply"
> @@ -428,6 +458,8 @@ static int simplefb_probe(struct platform_device *pdev)
>  		return ret;
>  
>  	mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	if (!mem)
> +		mem = simplefb_parse_dt_reserved_mem(&pdev->dev);
>  	if (!mem) {
>  		dev_err(&pdev->dev, "No memory resource\n");
>  		return -EINVAL;

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics
