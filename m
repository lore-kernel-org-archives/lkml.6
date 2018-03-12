Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932468AbeCLOgI (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Mar 2018 10:36:08 -0400
Received: from mailout1.samsung.com ([203.254.224.24]:36408 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752242AbeCLOgF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Mar 2018 10:36:05 -0400
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20180312143603epoutp013ec7ac16509a18bd867b920808902b80~bMv2MJQSF3079030790epoutp01d
X-AuditID: b6c32a39-467ff70000000fc5-ba-5aa690536828
From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
To: Ludovic Desroches <ludovic.desroches@microchip.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-fbdev@vger.kernel.org,
        dri-devel@lists.freedesktop.org, nicolas.ferre@microchip.com,
        alexandre.belloni@bootlin.com, linux-kernel@vger.kernel.org,
        linus.walleij@linaro.org, andy.shevchenko@gmail.com
Subject: Re: [PATCH V2] video: fbdev: atmel_lcdfb: convert to use GPIO
 descriptors
Date: Mon, 12 Mar 2018 15:35:47 +0100
Message-id: <1686002.1YAArENNib@amdc3058>
User-Agent: KMail/4.13.3 (Linux/3.13.0-96-generic; KDE/4.13.3; x86_64; ; )
In-reply-to: <20180206073122.3618-1-ludovic.desroches@microchip.com>
MIME-version: 1.0
Content-transfer-encoding: 7Bit
Content-type: text/plain; charset="us-ascii"
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupjleLIzCtJLcpLzFFi42LZdlhTXzd4wrIog4578hbt75axW7yccJjR
        4srX92wWU/4sZ7LY9Pgaq8WJvg+sFpd3zWGzeLH2OqvF9s0LmR04PeatqfbYOesuu8eda3vY
        PO53H2fy2Lyk3uPOj6WMHp83yQWwR3HZpKTmZJalFunbJXBl9H35wVLQyFIxe8YVpgbGzcxd
        jJwcEgImEj3NjexdjFwcQgI7GCXmbJ/ECOF8Z5TYu6+PCabqy4rVUIkNjBLrnzVBOV8ZJV7v
        72IEqWITsJKY2L4KzBYRMJf4+uUOG0gRs8BvRokZbxeBLRQWCJHYM3kKG4jNIqAq8fXiSTCb
        V0BTYvfKCSwgtqiAl8SWfe1Aqzk4OAVcJNbel4UoEZT4MfkeWAmzgLzEvv1TWSFsHYmzx9aB
        HSQhcJ9NYs7rP4wQZ7tINN85wQJhC0u8Or6FHWSmhIC0xKWjthD1zYwS33bsgQbGBEaJPeuF
        IGxricPHL0It4JN497WHFaKXV6KjDarEQ+Lkz5lQqxwlnt94CQ3H6YwSE6a+Y5nAKDsLyd2z
        kNw9C8ndCxiZVzGKpRYU56anFhsWmOoVJ+YWl+al6yXn525iBKcSLcsdjMfO+RxiFOBgVOLh
        NWheFiXEmlhWXJl7iFGCg1lJhPeOJlCINyWxsiq1KD++qDQntfgQozQHi5I4b0CAS5SQQHpi
        SWp2ampBahFMlomDU6qBkU/d5hG3Quu0Sz+fH1YwLNu5MkWmzW7Jjw8PJ/trPPxz03xi0W1d
        vfefXjo/Pr5ZrD1N6bj0pPurs0oVmBbyeLo7zfr5cOr64mslQm4zjp6bFC5hmX+TN0Tt9h52
        rhCzy3sMc9Wf3zG8ccqT8fCLwypR/zVad1nuVex6uv9i/tYiqTS2JxqPPyixFGckGmoxFxUn
        AgAMY2xaIQMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrOLMWRmVeSWpSXmKPExsVy+t9jQd2gCcuiDNrPcVu0v1vGbvFywmFG
        iytf37NZTPmznMli0+NrrBYn+j6wWlzeNYfN4sXa66wW2zcvZHbg9Ji3ptpj56y77B53ru1h
        87jffZzJY/OSeo87P5YyenzeJBfAHsVlk5Kak1mWWqRvl8CV0fflB0tBI0vF7BlXmBoYNzN3
        MXJySAiYSHxZsZqxi5GLQ0hgHaPE7eXLWSGcr4wSRz5MYgGpYhOwkpjYvooRxBYRMJf4+uUO
        G0gRs8BvRomrE16BjRIWCJHYM3kKG4jNIqAq8fXiSTCbV0BTYvfKCWCDRAW8JLbsa2fqYuTg
        4BRwkVh7XxZi2UxGid8bv0HVC0r8mHwPrJ5ZQF5i3/6prBC2lsT6nceZJjDyz0JSNgtJ2Swk
        ZQsYmVcxSqYWFOem5xYbFRjmpZbrFSfmFpfmpesl5+duYgQG/7bDWn07GO8viT/EKMDBqMTD
        29G6LEqINbGsuDL3EKMEB7OSCO8dTaAQb0piZVVqUX58UWlOavEhRmkOFiVx3tt5xyKFBNIT
        S1KzU1MLUotgskwcnFINjPGuMl5n3sz/vfCH2EuW6A3Mk4xq73x7tCTU5ZtmxFaPzrW/nyw1
        6rtxo+EO12qLdLVy17crGbsLbmhVf3Z+1vHjSnTl+W/fJjLfvqH322zOcbMISc5/aRurZvKu
        MfRf7toUf3pTx93pC3NUT7EdcXPnPP3KNmHurXMrVRz3OT1ovlVdoTdR4JoSS3FGoqEWc1Fx
        IgDE+GptegIAAA==
X-CMS-MailID: 20180312143602epcas1p293746bc228f932a52942615dc5b139c8
X-Msg-Generator: CA
CMS-TYPE: 101P
X-CMS-RootMailID: 20180206073301epcas4p4c19820468635df883cd979272f545bfc
X-RootMTR: 20180206073301epcas4p4c19820468635df883cd979272f545bfc
References: <CGME20180206073301epcas4p4c19820468635df883cd979272f545bfc@epcas4p4.samsung.com>
        <20180206073122.3618-1-ludovic.desroches@microchip.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday, February 06, 2018 08:31:22 AM Ludovic Desroches wrote:
> Use GPIO descriptors instead of relying on the old method.
> 
> Signed-off-by: Ludovic Desroches <ludovic.desroches@microchip.com>
> Acked-by: Nicolas Ferre <nicolas.ferre@microchip.com>
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
> Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

Patch queued for 4.17, thanks.

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics
