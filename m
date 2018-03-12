Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932785AbeCLP6u (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Mar 2018 11:58:50 -0400
Received: from mailout4.samsung.com ([203.254.224.34]:11613 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932582AbeCLP6s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Mar 2018 11:58:48 -0400
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20180312155846epoutp0453288b886cc316f87f43a1fbc5c30c01~bN4D8CF2q1388113881epoutp04l
X-AuditID: b6c32a47-19fff7000000100c-37-5aa6a3b544be
From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
To: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc: dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <garsilva@embeddedor.com>
Subject: Re: [PATCH] video: fbdev: vermilion: use 64-bit arithmetic instead
 of 32-bit
Date: Mon, 12 Mar 2018 16:58:38 +0100
Message-id: <3883400.1vCYa0i6ig@amdc3058>
User-Agent: KMail/4.13.3 (Linux/3.13.0-96-generic; KDE/4.13.3; x86_64; ; )
In-reply-to: <20180207000424.GA32680@embeddedgus>
MIME-version: 1.0
Content-transfer-encoding: 7Bit
Content-type: text/plain; charset="us-ascii"
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrCIsWRmVeSWpSXmKPExsWy7bCmme62xcuiDGanW1z5+p7NYuWS/WwW
        W/eoWpzo+8BqcXnXHDYHVo91B1U97ncfZ/L4vEkugDmKyyYlNSezLLVI3y6BK2P1igOMBR/Y
        Kr5/PMrawHiKtYuRk0NCwETiyd1TbF2MXBxCAjsYJf52r2WGcL4zSjStaAWq4gCr6vquDBHf
        wCgxfXUXC0i3kMBXRol1i+NAbDYBK4mJ7asYQWwRASOJ2TO6WUEamAUmM0q0b1vLBJIQFgiX
        uHBvO5jNIqAqsXEdiM3BwSugKfFtthVIWFTAS2LLvnawEk4BQ4mJ91eB2bwCghI/Jt8D28ss
        IC+xb/9UVghbR+LssXWMILskBJawSazeNY0N4jUXiSmXvjBC2MISr45vYYewpSWerdoI1dDM
        KPFtxx5miMQERok964UgbGuJw8cvQm3gk+g4/JcdEhK8Eh1tUCUeEpv+vIdqdZRo3PWFERJC
        LYwSN9t3sk9glJ2F5PBZSA6fheTwBYzMqxjFUguKc9NTi40KjPWKE3OLS/PS9ZLzczcxguNe
        y30H47ZzPocYBTgYlXh4DZqXRQmxJpYVV+YeYpTgYFYS4fWfChTiTUmsrEotyo8vKs1JLT7E
        KM3BoiTO2xrgEiUkkJ5YkpqdmlqQWgSTZeLglGpgTPzf2May/MIEIwe5jWr1l7fqztOs/aKc
        0MdiZudQGczsO90hUfKSv1uv1I5Lzmy/U3/f9Nw8SVuEsySgt8j79fJnDAePOdrvfx257qF8
        n8ibRLczX/b67fuuySyxrq92/53CgsxF+n+Nhf/NvchfN3tNsUuZv+O2jwl9b/61z2U8/3Xx
        1Bu3lFiKMxINtZiLihMB0b5ZLvcCAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrHLMWRmVeSWpSXmKPExsVy+t9jQd2ti5dFGey8yWNx5et7NouVS/az
        WWzdo2pxou8Dq8XlXXPYHFg91h1U9bjffZzJ4/MmuQDmKC6blNSczLLUIn27BK6M1SsOMBZ8
        YKv4/vEoawPjKdYuRg4OCQETia7vyl2MXBxCAusYJY68v8IG4XxllDj5o4uli5GTg03ASmJi
        +ypGEFtEwEhi9oxuVpAiZoGJjBJ3p7xlBkkIC4RLrPw6iwnEZhFQldi4bjsTyAZeAU2Jb7Ot
        QMKiAl4SW/a1g5VwChhKTLy/igliWRujxIq5O9hAErwCghI/Jt8DW8wsIC+xb/9UVghbS2L9
        zuNMExj5ZyEpm4WkbBaSsgWMzKsYJVMLinPTc4uNCozyUsv1ihNzi0vz0vWS83M3MQJDddth
        rf4djI+XxB9iFOBgVOLh7WhdFiXEmlhWXJl7iFGCg1lJhNd/KlCINyWxsiq1KD++qDQntfgQ
        ozQHi5I4L3/+sUghgfTEktTs1NSC1CKYLBMHp1QDo2/0WqaHUUXv/32V1Ilrkd6rdqMnmiM1
        SyVd48XVg508O0wVJ/YdtPq/dvG8Tj2t85ZPgmfp7jCvCxZcJTs7dnaaS9IZw6Jc96Pe/ete
        61p9uOp+3ObWH7+9+/hmlojNELcsY746ocErQaR9UeRUr7IDdle7j18Qjr6z70TejhsHkpvn
        bKq7pcRSnJFoqMVcVJwIAENz+PlRAgAA
X-CMS-MailID: 20180312155845epcas2p45ac49e920a8b708fcd5d8244a658857a
X-Msg-Generator: CA
CMS-TYPE: 102P
X-CMS-RootMailID: 20180207000429epcas3p49ce7f7528d02b9799713e8806d77847d
X-RootMTR: 20180207000429epcas3p49ce7f7528d02b9799713e8806d77847d
References: <CGME20180207000429epcas3p49ce7f7528d02b9799713e8806d77847d@epcas3p4.samsung.com>
        <20180207000424.GA32680@embeddedgus>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday, February 06, 2018 06:04:24 PM Gustavo A. R. Silva wrote:
> Cast _pitch_ to u64 in order to give the compiler complete information
> about the proper arithmetic to use. Notice that this variable is
> being used in a context that expects an expression of type u64
> (64 bits, unsigned).
> 
> The expression pitch * var->yres_virtual is currently being evaluated
> using 32-bit arithmetic and the result of the operation is being stored
> into variable mem, which is a variable of type u64. Based on that,
> chances are there is a potential integer overflow as a result of the
> operation.
> 
> Addresses-Coverity-ID: 200655 ("Unintentional integer overflow")
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>

Patch queued for 4.17, thanks.

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics
