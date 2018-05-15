Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752613AbeEOJqy (ORCPT <rfc822;w@1wt.eu>);
        Tue, 15 May 2018 05:46:54 -0400
Received: from mailout4.samsung.com ([203.254.224.34]:32152 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752452AbeEOJqv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 May 2018 05:46:51 -0400
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20180515094649epoutp0472df71ee95942ad862ecc05ef9338bbb~uyFkxXcSE2532225322epoutp04j
X-AuditID: b6c32a35-9cbff70000001024-8d-5afaac883377
Subject: Re: [PATCH 27/61] media: platform: s5p-mfc: simplify getting
 .drvdata
To: Wolfram Sang <wsa+renesas@sang-engineering.com>,
        linux-kernel@vger.kernel.org
Cc: linux-renesas-soc@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Kamil Debski <kamil@wypas.org>, Jeongtae Park <jtp.park@samsung.com>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-media@vger.kernel.org
From: Sylwester Nawrocki <s.nawrocki@samsung.com>
Message-id: <0684984f-6e52-5e91-f6bb-1084c588e1b4@samsung.com>
Date: Tue, 15 May 2018 11:46:41 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
        Thunderbird/52.7.0
MIME-version: 1.0
In-reply-to: <20180419140641.27926-28-wsa+renesas@sang-engineering.com>
Content-type: text/plain; charset="utf-8"
Content-language: en-GB
Content-transfer-encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrJKsWRmVeSWpSXmKPExsWy7bCmvm7Hml9RBr8WSVvcWneO1eLI2qtM
        FjNPtLNabL0lbXG26Q27xabH11gtLu+aw2bRs2ErUPzlOyaLZZv+MFn0nXN34PbYtKqTzWPz
        knqPvi2rGD2eLVzP4vF5k5zHlSON7AFsUVw2Kak5mWWpRfp2CVwZ16Z8YipYzFTRcvcCcwPj
        V8YuRg4OCQETidMHlboYuTiEBHYwSixc3MEM4XxnlDi6fhuQwwlW1PZ4MRuILSSwm1Gie4ci
        RNF9RomHn4+ygySEBQIkNj19ygJiiwgES1w/dYwRpIhZ4DKTxNpXT1hBEmwChhK9R/sYQWxe
        ATuJCQv/gtksAqoSD56fAtsgKhAh0fT8JztEjaDEj8n3wIZyCrhLXFl0GqyGWUBT4sWXSSwQ
        trjEsfs3GSFseYnNa96CvSAh8J5N4s2BX6wQL7hI9NycDfWOsMSr41vYIf6Xlrh01BYiXC3R
        2dbFDtHbwijxZ9olNoiEtcTh4xdZIRbwSbz72sMK0csr0dEmBFHiITFlxX6o8Y4SNy/shgbj
        NUaJB4/nMk9glJuF5J9ZSH6YheSHWUh+WMDIsopRLLWgODc9tdiwwFCvODG3uDQvXS85P3cT
        IzgBaZnuYJxyzucQowAHoxIPb8K0n1FCrIllxZW5hxglOJiVRHh3GwGFeFMSK6tSi/Lji0pz
        UosPMUpzsCiJ885R+holJJCeWJKanZpakFoEk2Xi4JRqYDTNmrFJaqpwpLjR0ZwdlfOuNvL9
        krW4m7Nhb8l8QcuWAp1nc7zMOi/tufLCsuGWyYclSyvDxdcp32I8M3NDc41fcMT+KEUxPs/y
        IubKrW433t87qmNts9jJqvh6BH9s1ow0Nvsa92msHvuynC7v9SqUua99Rm93p7hB1o87V2c0
        PzmdacT/UImlOCPRUIu5qDgRAIQzAVQ8AwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpikeLIzCtJLcpLzFFi42I5/e+xgG77ml9RBgsnGVvcWneO1eLI2qtM
        FjNPtLNabL0lbXG26Q27xabH11gtLu+aw2bRs2ErUPzlOyaLZZv+MFn0nXN34PbYtKqTzWPz
        knqPvi2rGD2eLVzP4vF5k5zHlSON7AFsUVw2Kak5mWWpRfp2CVwZ16Z8YipYzFTRcvcCcwPj
        V8YuRk4OCQETibbHi9m6GLk4hAR2Mkrs6n7NCOE8ZJTonNDAAlIlLOAnMXXNNjYQW0QgWOJZ
        ZxMrSBGzwGUmidv9c9khOpoYJQ41TGIHqWITMJToPdoHtoNXwE5iwsK/YDaLgKrEg+enwCaJ
        CkRI3Dv/iQ2iRlDix+R7YNs4Bdwlriw6DRTnANqgLjFlSi5ImFlAXOLY/ZuMELa8xOY1b5kn
        MArMQtI9C6FjFpKOWUg6FjCyrGKUTC0ozk3PLTYqMMxLLdcrTswtLs1L10vOz93ECIyZbYe1
        +nYw3l8Sf4hRgINRiYc3YdrPKCHWxLLiytxDjBIczEoivLuNgEK8KYmVValF+fFFpTmpxYcY
        pTlYlMR5b+cdixQSSE8sSc1OTS1ILYLJMnFwSjUwGikas4oeEtuj2/LVYt5y0TNVQZv/elg0
        dqh+ZT3zS+rfg+PScjpvHr/dkp67ZLaCK/NMY8fMZMcQkTRnl9x+na15Koteuv/ykzNRKH93
        +9urg9YGSx+WSnL57/z5NjOX7WfUixUN4iGSL+3yJj0yKF33VLD73aYnW75uLzddz8ou5WwV
        eshfiaU4I9FQi7moOBEAZxz7Z5UCAAA=
X-CMS-MailID: 20180515094647epcas1p49b3c5d47dcedd034aec9589aab473cc0
X-Msg-Generator: CA
CMS-TYPE: 101P
X-CMS-RootMailID: 20180515094647epcas1p49b3c5d47dcedd034aec9589aab473cc0
X-RootMTR: 20180515094647epcas1p49b3c5d47dcedd034aec9589aab473cc0
References: <20180419140641.27926-1-wsa+renesas@sang-engineering.com>
        <20180419140641.27926-28-wsa+renesas@sang-engineering.com>
        <CGME20180515094647epcas1p49b3c5d47dcedd034aec9589aab473cc0@epcas1p4.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/19/2018 04:05 PM, Wolfram Sang wrote:
> We should get drvdata from struct device directly. Going via
> platform_device is an unneeded step back and forth.
> 
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

Acked-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
