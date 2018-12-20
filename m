Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15E99C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 15:42:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD724218C3
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 15:42:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="Wpl0Q71I"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731838AbeLTPmx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 10:42:53 -0500
Received: from mailout1.w1.samsung.com ([210.118.77.11]:48694 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729184AbeLTPmx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 10:42:53 -0500
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20181220154251euoutp010fcb50e2761c58fd29ca7331d823c774~yFN9DcuXq3110231102euoutp01w
        for <linux-kernel@vger.kernel.org>; Thu, 20 Dec 2018 15:42:51 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20181220154251euoutp010fcb50e2761c58fd29ca7331d823c774~yFN9DcuXq3110231102euoutp01w
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1545320571;
        bh=zxRPt0Q/5rMMomLAHj3d3MQIU4XhgYSZLaGCm71334I=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=Wpl0Q71IF6cuZ+37Gtko0lo5BZ3mNNK4zEuuQ1mz0VgE4DMjN+p6x0TjRLstF44WA
         sGOvOqucJQQJO7Q8rRpxDY3x73LAk6PPL7V2Aemx0JIYCeqxCCdiSYowk0M3X2cyPD
         h6VX8Ox2iuSJ4ilUh5fR/9hrSSSIKxMkA7HLPAqE=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20181220154250eucas1p2ef19a2c19a934d4580ecad2720b5997e~yFN8Tas9Y1620316203eucas1p2I;
        Thu, 20 Dec 2018 15:42:50 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id 7F.22.04806.A78BB1C5; Thu, 20
        Dec 2018 15:42:50 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20181220154249eucas1p2205a1febc87460f910de4c7ac1ea8a0b~yFN7dC_Lm0373103731eucas1p2E;
        Thu, 20 Dec 2018 15:42:49 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20181220154249eusmtrp17696d6b2b6733b4e86ff2bd2c0422dd7~yFN7LkgjA0038600386eusmtrp1W;
        Thu, 20 Dec 2018 15:42:49 +0000 (GMT)
X-AuditID: cbfec7f5-34dff700000012c6-ae-5c1bb87a0f4e
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id FC.42.04284.978BB1C5; Thu, 20
        Dec 2018 15:42:49 +0000 (GMT)
Received: from [106.120.53.102] (unknown [106.120.53.102]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20181220154248eusmtip2d65368e3fa7ad8ca05c0d99cef1fb659~yFN6s1HNB1995219952eusmtip2k;
        Thu, 20 Dec 2018 15:42:48 +0000 (GMT)
Subject: Re: [PATCH] fbdev: make FB_BACKLIGHT a tristate
To:     Rob Clark <robdclark@gmail.com>,
        dri-devel <dri-devel@lists.freedesktop.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Simon Horman <horms+renesas@verge.net.au>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Ulf Magnusson <ulfalizer@gmail.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Hans de Goede <j.w.r.degoede@gmail.com>,
        Linux Fbdev development list <linux-fbdev@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
From:   Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Message-ID: <c5378c0f-d2f8-720c-e633-24673af87a53@samsung.com>
Date:   Thu, 20 Dec 2018 16:42:48 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
        Thunderbird/45.3.0
MIME-Version: 1.0
In-Reply-To: <CAF6AEGuUXt-c9Bmi8yfU=d_pUvrsXwDq4CzZ9GfrhZBP+zbe-A@mail.gmail.com>
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA01Sa0xSYRju4xzgwKROWPZOWy3WZbZpNWs7lXO1dTlrrdsvM1uRnqlL0IFS
        2h/DQqCsoBqJ2nBlEGk6MC+1mNOCTGldqJjVus7SQt26aF6w4ODq3/M83/O+z/NuH4GJu7ix
        RI68gFHIpbkSnhBvdv9+lFDcGpe+8pZWSE0a3XxqqtmAUb6fQzyqutKIqMeBYR719Z6aS+kM
        V/nUgzPDXOrZ7SoeFXhtwqnPNaMY9XisF9sQRY+PGRF995cFpw3eBLrN/IZPV2oruLTTtpx+
        e8rDoat+/8Lp744FuwRpwuRMJjdHxShWpBwUZk+4JrH8Efyoy+fGS5Aa1yMBAeRq8H0McvVI
        SIhJG4Imp5fPkh8IHMdfRsh3BCVdATQ9Yj9ZzwthMWlFUN4gZ01DCPqtr8KmaJKC+sGP4Yw5
        5B54MXABC2GM9GDQ5wt7eOQ6MJTZw1hEpoD3uSuMcXIJaPw6jh4RxFwyFc72LGMts6Gr4lN4
        pYDcDc4vTTx25UJoCVRhoQ5A9vPBV6nD2KKbwK9Tc1kcDQOeJj6L50P3+dM4O2BC8G2sNkIa
        ENT1uDmsaz10ep5wQy0wMh4abq9g5Y1wPliDhWQgZ4I/MJstMROMzaaILAKtRsy6l0LjtUbe
        dKy+7XqkGg2+iwP4ObTI/N9p5v/OMf/LtSDMjuYxhUpZFqNMkjNHEpVSmbJQnpWYkSdzoL8f
        rDvo+dmKXBOHOhBJIEmU6FJabLqYK1Upi2QdCAhMMkdUrotLF4sypUXFjCLvgKIwl1F2oDgC
        l8wTHZvxbp+YzJIWMIcZJp9RTL9yCEFsCcLid15e2Wvjn3IsvrN/ZPP7k94X28sJk2/d1phb
        JwYDux7OsubcNAa39T1R78jMqE4su3KmOA/HK7bgWku8qtdODaqsAVm/M2lrm01Tq9kgqGu/
        3z7uxwNrSy2dexc+TZW5q903Uh7Wl45+SOZMfnmwhpjie7UxQ5pZU2Utx/wSXJktXbUcUyil
        fwDRaabTXAMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrIIsWRmVeSWpSXmKPExsVy+t/xe7qVO6RjDO6d4rP4O+kYu8X/bROZ
        La58fc9mMXf2JEaLC28/sFm8PtLEatE5cQm7xYm+D6wWl3fNYbN4e2c6i8XzhT+YLS78usXs
        wOPx+9ckRo+93xaweEw8q+uxc9Zddo/ZHTNZPTav0PK4332cyWPOz28sHp83yQVwRunZFOWX
        lqQqZOQXl9gqRRtaGOkZWlroGZlY6hkam8daGZkq6dvZpKTmZJalFunbJehl/Nn3l7ngO0vF
        vivHWBoYm1i6GDk5JARMJFa1rmXrYuTiEBJYyijRfOw8cxcjB1BCRuL4+jKIGmGJP9e6oGre
        Mkq09q1nBUkIC1hIrH33GGyQiECQxP3rHawQRZcZJeb3vWUBcZgFTjJLzGzuZwKpYhOwkpjY
        vooRxOYVsJM4e3UfmM0ioCrRdqMTrEZUIELi1sMOFogaQYmTM5+A2ZwCgRKbX2xhA7GZBdQl
        /sy7xAxhy0tsfzuHeQKj4CwkLbOQlM1CUraAkXkVo0hqaXFuem6xoV5xYm5xaV66XnJ+7iZG
        YHRuO/Zz8w7GSxuDDzEKcDAq8fDOiJKKEWJNLCuuzD3EKMHBrCTC29spHSPEm5JYWZValB9f
        VJqTWnyI0RToiYnMUqLJ+cDEkVcSb2hqaG5haWhubG5sZqEkznveoDJKSCA9sSQ1OzW1ILUI
        po+Jg1OqgTH0r4awa9ON5brrl259efPVsjt2t5dHXCz35UqUsXiks9ukcSZfWsOGAsO0+1ln
        Fy/33dQ3K+LAE79qZ7OEwG0cSUmiTUvj5f55+kvxLUhM+f+12Hf3hZznandTEvxKAnaZf2Xq
        93BLWXj5sPP35mlv5p4zP/P6i8GG7rsPqq5fEbD79vHxvzYlluKMREMt5qLiRAAhEUR55AIA
        AA==
X-CMS-MailID: 20181220154249eucas1p2205a1febc87460f910de4c7ac1ea8a0b
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20181218132030epcas4p341162d849e429c85fdd265246aee6630
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20181218132030epcas4p341162d849e429c85fdd265246aee6630
References: <20181026140931.15771-1-robdclark@gmail.com>
        <CGME20181218132030epcas4p341162d849e429c85fdd265246aee6630@epcas4p3.samsung.com>
        <CAF6AEGuUXt-c9Bmi8yfU=d_pUvrsXwDq4CzZ9GfrhZBP+zbe-A@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 12/18/2018 02:19 PM, Rob Clark wrote:
> On Fri, Oct 26, 2018 at 10:09 AM Rob Clark <robdclark@gmail.com> wrote:
>>
>> BACKLIGHT_CLASS_DEVICE is already tristate, but a dependency
>> FB_BACKLIGHT prevents it from being built as a module.  There
>> doesn't seem to be any particularly good reason for this, so
>> switch FB_BACKLIGHT over to tristate.
>>
>> Signed-off-by: Rob Clark <robdclark@gmail.com>
>> Tested-by: Arnd Bergmann <arnd@arndb.de>
> 
> bump

Patch queued for 4.21, thanks (also sorry for the delay).

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics
