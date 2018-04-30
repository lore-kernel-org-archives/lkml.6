Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754601AbeD3PYW (ORCPT <rfc822;w@1wt.eu>);
        Mon, 30 Apr 2018 11:24:22 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:57147 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753334AbeD3PYU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Apr 2018 11:24:20 -0400
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20180430152418euoutp021764b5e0f6f9b79ff85f979c0279aa15~qQA9kcHpu0655406554euoutp02b
X-AuditID: cbfec7f5-b5fff700000028a9-19-5ae735213c18
From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Eduardo Valentin <edubezval@gmail.com>,
        Zhang Rui <rui.zhang@intel.com>, linux-samsung-soc@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 03/18] thermal: exynos: always check for critical trip
 points existence
Date: Mon, 30 Apr 2018 17:24:15 +0200
Message-id: <5229331.iYYXeBBCxK@amdc3058>
User-Agent: KMail/4.13.3 (Linux/3.13.0-96-generic; KDE/4.13.3; x86_64; ; )
In-reply-to: <20180430144450.GI11457@mai>
MIME-version: 1.0
Content-transfer-encoding: 7Bit
Content-type: text/plain; charset="us-ascii"
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrAIsWRmVeSWpSXmKPExsWy7djPc7qKps+jDDbt47GY91nWYv6Va6wW
        l3fNYbP43HuE0WLG+X1MFk8e9rE5sHnsnHWX3WPxnpdMHneu7WHz+LxJLoAlissmJTUnsyy1
        SN8ugSvj8bn7bAUNLBWvu3rZGhhnMHcxcnBICJhIPJyT1sXIxSEksIJRYtqMc0wQzmdGiY5b
        f+CKFrdFQMSXMUpM3z2XHcL5zSjRf/s2UBEnB5uAlcTE9lWMILaIgJ5E4/s2sEnMAquAij69
        YwJJCAvESsy59JkNxGYRUJX4vXUrK4jNK6ApcW32TBYQW1TAS2LLvnawek6g+I7uPSwQNYIS
        PybfA7OZBeQl9u2fygph60icPbaOEWSZhMAKNomLGz9Cne0iceCBAUiNhICwxKvjW9ghbBmJ
        zo6DTBD1zYwS33bsYYZITGCU2LNeCMK2ljh8/CLUAj6JSdumQ83klehogyrxkHjeOYcVwnaU
        mHjhHNh8IYFfjBKtbVUTGGVnITl7FpKzZyE5ewEj8ypG8dTS4tz01GLjvNRyveLE3OLSvHS9
        5PzcTYzAdHD63/GvOxj3/Uk6xCjAwajEw8sh/zxKiDWxrLgy9xCjBAezkgjvyo5nUUK8KYmV
        ValF+fFFpTmpxYcYpTlYlMR54zTqooQE0hNLUrNTUwtSi2CyTBycUg2MsvEHJ55JfXhVO5DF
        1bDhLRv3zV8X54qkaT2bvVlo6csL/79YH5Z9EqIqPXvvnIdJjTfPbi6768jKLacQytSxfXL6
        LZ13C/weaaz50h/y9LZr+XHNzbc3Hgu/en5bCd9STck1/+e7nONuNTN1yGHfPon3kvOMa9kP
        Vh7dGvzOp/BMypKXhf17JZVYijMSDbWYi4oTAR1dpiIDAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrCLMWRmVeSWpSXmKPExsVy+t/xa7oKps+jDD7P5bKY91nWYv6Va6wW
        l3fNYbP43HuE0WLG+X1MFk8e9rE5sHnsnHWX3WPxnpdMHneu7WHz+LxJLoAlissmJTUnsyy1
        SN8ugSvj8bn7bAUNLBWvu3rZGhhnMHcxcnBICJhILG6L6GLk4hASWMIo8bf/IjOE85dR4tTr
        Y0AOJwebgJXExPZVjCC2iICeROP7NiaQImaBVYwSK1t7wYqEBWIl5lz6zAZiswioSvzeupUV
        xOYV0JS4NnsmC4gtKuAlsWVfOxOIzQkU39G9BywuJLCMUaLjFQdEvaDEj8n3wOLMAvIS+/ZP
        ZYWwtSTW7zzONIGRfxaSsllIymYhKVvAyLyKUSS1tDg3PbfYUK84Mbe4NC9dLzk/dxMjMGy3
        Hfu5eQfjpY3BhxgFOBiVeHg55J9HCbEmlhVX5h5ilOBgVhLhXdnxLEqINyWxsiq1KD++qDQn
        tfgQozQHi5I473mDyighgfTEktTs1NSC1CKYLBMHp1QDY/jTpSdSy9z10jr5jGsM7iz0CVu9
        UWh/XLKtz9wpuy4+OynxKme2VPPTPzICVrvVVrj5nJ0xi+1ZxKvQEgkZ+T/P6t7/CZZbdOvk
        tUmmJzct+bzioMKVVAbGZBWv5fO/uNhvkLV44mC4oXyPoF+T2tmzh86UyKVs18/84Jv6enLp
        /D/p0tEV/5RYijMSDbWYi4oTAc6MeUpXAgAA
X-CMS-MailID: 20180430152416eucas1p10bde2c1501e7f5f4b284caca3b630ea3
X-Msg-Generator: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20180430152416eucas1p10bde2c1501e7f5f4b284caca3b630ea3
X-RootMTR: 20180430152416eucas1p10bde2c1501e7f5f4b284caca3b630ea3
References: <1524743493-28113-1-git-send-email-b.zolnierkie@samsung.com>
        <1524743493-28113-4-git-send-email-b.zolnierkie@samsung.com>
        <20180430144450.GI11457@mai>
        <CGME20180430152416eucas1p10bde2c1501e7f5f4b284caca3b630ea3@eucas1p1.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday, April 30, 2018 04:44:50 PM Daniel Lezcano wrote:
> On Thu, Apr 26, 2018 at 01:51:18PM +0200, Bartlomiej Zolnierkiewicz wrote:
> > * Check for critical trip point existence in exynos_tmu_initialize()
> >   so it is checked on all SoCs (except Exynos5433 for now).
> 
> Why "except Exynos5433" ?

I was a bit vague here - Exynos5433 DTS needs to be fixed first to define
critical trip points.

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics
