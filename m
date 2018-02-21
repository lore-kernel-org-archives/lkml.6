Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751510AbeBUFj7 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Feb 2018 00:39:59 -0500
Received: from mailout4.samsung.com ([203.254.224.34]:64995 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750740AbeBUFj5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Feb 2018 00:39:57 -0500
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20180221053955epoutp04e4d77f7f8c1d03e0eb2d77d777de3ca9~VQLTvS-pC2303823038epoutp04P
X-AuditID: b6c32a47-19fff7000000100c-1b-5a8d062ac799
Subject: Re: [PATCH] mmc: dw_mmc-k3: Fix out-of-bounds access through DT
 alias
To: Geert Uytterhoeven <geert@linux-m68k.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Ulf Hansson <ulf.hansson@linaro.org>,
        Linux MMC List <linux-mmc@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
        <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
From: Jaehoon Chung <jh80.chung@samsung.com>
Message-id: <7b59b34b-92ee-da85-9c76-1d7f8f72c318@samsung.com>
Date: Wed, 21 Feb 2018 14:39:53 +0900
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:52.0) Gecko/20100101
        Thunderbird/52.5.0
MIME-version: 1.0
In-reply-to: <CAMuHMdWa5RgkGCAucN5ykGRW=FdHUZw=+t5jMAsKhdixMUSQzQ@mail.gmail.com>
Content-type: text/plain; charset="utf-8"
Content-language: en-US
Content-transfer-encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrLKsWRmVeSWpSXmKPExsWy7bCmha4WW2+UwZo2YYv5R86xWsydPYnR
        4tmtvUwWl3fNYbM48r+f0eL42nAHNo+JZ3U97lzbw+Zx6HAHo8fnTXIBLFGpNhmpiSmpRQqp
        ecn5KZl56bZK3sHxzvGmZgaGuoaWFuZKCnmJuam2Si4+AbpumTlAq5UUyhJzSoFCAYnFxUr6
        djZF+aUlqQoZ+cUltkrRhoZGeoYG5npGRkZ6JsaxVkamQCUJqRk/ms6zFZznrFj6/zRTA+MK
        9i5GTg4JAROJhYdvMHcxcnEICexglDjwsoERwvnOKHHv9VOmLkYOsKo9zSoQ8d2MEm2zX0IV
        3WOUePqnkRVklLBAgMTd5oMsILaIQKzE8vUNYGOZBd4zSmyc8oAZJMEmoCOx/dtxJhCbV8BO
        ovnvB7A4i4CqxKvpk8AGiQqESRyd+YkRokZQ4sfke2BDOQWCJV593gEWZxbQlHjxZRILhC0u
        0dx6E8qWl9i85i0zxG8H2CQ2Pi2HsF0k+rv2M0LYwhKvjm+B+l9a4tmqjVDxdkaJs7OFQY6W
        EJjCKLFiRjcTRMJY4tnCLiaIBXwSHYf/skOChVeio00IosRDoqXpPQuE7SjxcRvIL6AQesQo
        saupnXECo9wsJP/MQvLDLCQ/zELywwJGllWMYqkFxbnpqcVGBcZ6xYm5xaV56XrJ+bmbGMFJ
        T8t9B+O2cz6HGAU4GJV4eC10eqKEWBPLiitzDzFKcDArifBW/wcK8aYkVlalFuXHF5XmpBYf
        YjQFhvdEZinR5HxgQs4riTc0sTQwMTMzMjezACY3cd7WAJcoIYH0xJLU7NTUgtQimD4mDk6p
        Bkb1/bOYf/2+PbXdRurUfkH/eg0ro99BE49HWq3Z26prkeFf3G3+TlfP7gD3TQ+952KBRzat
        fO/+xWbi0nL9mw17bCptp0nds59xTJzf92Ql67S/c+dvMpgZHZ612UN9ZdztEP4fV+V0Dsy7
        F7Rc88pj9o8vCr1cxUSXrZbNErFTe8ov9WTrJUElluKMREMt5qLiRAAPXWT8kAMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrHLMWRmVeSWpSXmKPExsVy+t9jAV1Ntt4ogyUvZSzmHznHajF39iRG
        i2e39jJZXN41h83iyP9+Rovja8Md2DwmntX1uHNtD5vHocMdjB6fN8kFsERx2aSk5mSWpRbp
        2yVwZfxoOs9WcJ6zYun/00wNjCvYuxg5OCQETCT2NKt0MXJxCAnsZJTo/fiTBcJ5wCjx5Opc
        pi5GTg5hAT+Jw28WsIE0iAjESuxqrQWpYRb4yChx7P4OqIZHjBIP/h8Aa2AT0JHY/u04mM0r
        YCfR/PcDM4jNIqAq8Wr6JFYQW1QgTKJn02VGiBpBiR+T77GA2JwCwRL/JrxjBlnGLKAuMWVK
        LkiYWUBcorn1JguELS+xec1b5gmMArOQdM9C6JiFpGMWko4FjCyrGCVTC4pz03OLjQqM8lLL
        9YoTc4tL89L1kvNzNzECQ33bYa3+HYyPl8QfYhTgYFTi4bXQ6YkSYk0sK67MPcQowcGsJMJb
        /R8oxJuSWFmVWpQfX1Sak1p8iFGag0VJnJc//1ikkEB6YklqdmpqQWoRTJaJg1OqgXF3thJ3
        3N0pngbGzqpPJ6+42OG2JOC+1QGtJRbKRgZSPx+9zF7+7a3JOa0Le4uW9L197+7uVpPE9uVZ
        cL34ckf7rwnX73FPkNZ5/3xte/7F/bnbn8yIC3/s0J3S82S+mkCQkATfvM4bvzS+Hl0YfiD6
        7A23dasnLniz8L/Cy497WzbE2KX1fVuvxFKckWioxVxUnAgAzThWm3ECAAA=
X-CMS-MailID: 20180221053953epcas2p2fbc857bb70566d31cb6b58fa6410e9c0
X-Msg-Generator: CA
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20180220105101epcas1p32dced553004bbcb54512e5c144ca2a1c
X-RootMTR: 20180220105101epcas1p32dced553004bbcb54512e5c144ca2a1c
References: <1519117393-31302-1-git-send-email-geert+renesas@glider.be>
        <CGME20180220105101epcas1p32dced553004bbcb54512e5c144ca2a1c@epcas1p3.samsung.com>
        <CAMuHMdWa5RgkGCAucN5ykGRW=FdHUZw=+t5jMAsKhdixMUSQzQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Geert,

On 02/20/2018 07:50 PM, Geert Uytterhoeven wrote:
> On Tue, Feb 20, 2018 at 10:03 AM, Geert Uytterhoeven
> <geert+renesas@glider.be> wrote:
>> The hs_timing_cfg[] array is indexed using a value derived from the
>> "mshcN" alias in DT, which may lead to an out-of-bounds access.
>>
>> Fix this by adding a range check.
>>
>> Fixes: 7d92895208a008a2 ("mmc: dw_mmc-k3: Fix out-of-bounds access through DT alias")
> 
> Oops
> 
> Fixes: 361c7fe9b02eee7e ("mmc: dw_mmc-k3: add sd support for hi3660")

Could you resend the patch with changing commit-msg?
Then i will pick yours.

Best Regards,
Jaehoon Chung

> 
> Gr{oetje,eeting}s,
> 
>                         Geert
> 
> --
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org
> 
> In personal conversations with technical people, I call myself a hacker. But
> when I'm talking to journalists I just say "programmer" or something like that.
>                                 -- Linus Torvalds
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
> 
