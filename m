Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751732AbeEBQVI (ORCPT <rfc822;w@1wt.eu>);
        Wed, 2 May 2018 12:21:08 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:47849 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751011AbeEBQVE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 May 2018 12:21:04 -0400
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20180502162101euoutp028fbfeea2e6020c8e31c77cd16d04611a~q4FDaoj301728517285euoutp02P
X-AuditID: cbfec7f2-1dbff70000011644-90-5ae9e56cc714
From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Eduardo Valentin <edubezval@gmail.com>, Keerthy <j-keerthy@ti.com>,
        Zhang Rui <rui.zhang@intel.com>, linux-pm@vger.kernel.org,
        linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] thermal: ti-soc-thermal: fix incorrect entry in
 omap5430_adc_to_temp[]
Date: Wed, 02 May 2018 18:20:59 +0200
Message-id: <1861949.NMJD6FHQNL@amdc3058>
User-Agent: KMail/4.13.3 (Linux/3.13.0-96-generic; KDE/4.13.3; x86_64; ; )
In-reply-to: <20180502154931.GS27619@mai>
MIME-version: 1.0
Content-transfer-encoding: 7Bit
Content-type: text/plain; charset="us-ascii"
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrHIsWRmVeSWpSXmKPExsWy7djPc7o5T19GGfTs4LeY91nWYv6Va6wW
        p7Y3MVlc3jWHzWL2kn4Wi8+9RxgtnjzsY3Ng99g56y67x+I9L5k87lzbw+Zx/MZ2Jo/Pm+QC
        WKO4bFJSczLLUov07RK4MtZum8hc8Ja14svjW4wNjDdZuhg5OSQETCQOL/rD3sXIxSEksIJR
        oqdjIxOE85lRYuHlV0wwVTuX9UMlljFKzJxwGcr5zShx9OQFNpAqNgEriYntqxhBbBEBPYnG
        921gRcwC+xkl9u17zwqSEBZIkJjeewZsOYuAqsT5roVgDbwCmhJfF89mB7FFBbwktuxrB1vN
        CRTf19PDClEjKPFj8j2wXmYBeYl9+6eyQtg6EmePrWMEWSYhsINN4u3dNYwQd7tI/Ok9xgxh
        C0u8Or6FHcKWkejsOMgE0dDMKPFtxx6oogmMEnvWC0HY1hKHj1+E2sAnMWnbdKAaDqA4r0RH
        G1SJh8SF/9fYIGxHiR0rrzNDgmU2o0RLewP7BEbZWUgOn4Xk8FlIDl/AyLyKUTy1tDg3PbXY
        MC+1XK84Mbe4NC9dLzk/dxMjMFWc/nf80w7Gr5eSDjEKcDAq8fAeOPsySog1say4MvcQowQH
        s5II78qOZ1FCvCmJlVWpRfnxRaU5qcWHGKU5WJTEeeM06qKEBNITS1KzU1MLUotgskwcnFIN
        jLt4qt723jrR4T/74eSaN1fKl2893LPRzpaj8cGW+gtx+RXbZe6HfQt2nK224B37S43NquXy
        qZMl1i75++D5hMuF1ydGq4lK3nshe2OKV9uk97a3Yk8b5zyedjgjpssj9+Kjd7fUd5TP/Bek
        v6TwSfKfvLz+L1fTW2b/7Pl0UU/noZaIbK1JWZoSS3FGoqEWc1FxIgCfSUnKEQMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrPLMWRmVeSWpSXmKPExsVy+t/xq7rZT19GGfz5q28x77Osxfwr11gt
        Tm1vYrK4vGsOm8XsJf0sFp97jzBaPHnYx+bA7rFz1l12j8V7XjJ53Lm2h83j+I3tTB6fN8kF
        sEZx2aSk5mSWpRbp2yVwZazdNpG54C1rxZfHtxgbGG+ydDFyckgImEjsXNbP1MXIxSEksIRR
        4teu28wgCSGBv4wSD3YngthsAlYSE9tXMYLYIgJ6Eo3v28AamAX2M0p8aJnJDpIQFkiQmN57
        Bmwqi4CqxPmuhWANvAKaEl8XzwarERXwktiyr50JxOYEiu/r6WGF2DyXUWJe7xE2iAZBiR+T
        74ENYhaQl9i3fyorhK0lsX7ncaYJjPyzkJTNQlI2C0nZAkbmVYwiqaXFuem5xYZ6xYm5xaV5
        6XrJ+bmbGIHBvO3Yz807GC9tDD7EKMDBqMTDe+Dsyygh1sSy4srcQ4wSHMxKIrwrO55FCfGm
        JFZWpRblxxeV5qQWH2KU5mBREuc9b1AZJSSQnliSmp2aWpBaBJNl4uCUamBkSJCxWpUuajOb
        vfDB2kXn5xmszbP6v3lp1TcL/9P+1f8q/3f8eDS9uuCHQLyuQMdExzj7OJ9WD2Pu9Ul/lGZG
        6P86n/11xm7Zbekb0r5w/F1Ts8n0TGRe124DowefK4Ldr0z+tFFE6l7DWTvhkt+xkr4zn1Y4
        cf3WXFAs1eed5NUUFuIvf1uJpTgj0VCLuag4EQCGuOqPYgIAAA==
X-CMS-MailID: 20180502162059eucas1p1f9cb93b04c30933149fe7936db382e4b
X-Msg-Generator: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20180502141432eucas1p1c85aa366979b73c59a46ec0c2f7ef8e6
X-RootMTR: 20180502141432eucas1p1c85aa366979b73c59a46ec0c2f7ef8e6
References: <CGME20180502141432eucas1p1c85aa366979b73c59a46ec0c2f7ef8e6@eucas1p1.samsung.com>
        <17742083.Vu59BImYbG@amdc3058> <20180502154931.GS27619@mai>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday, May 02, 2018 05:49:31 PM Daniel Lezcano wrote:
> On Wed, May 02, 2018 at 04:14:32PM +0200, Bartlomiej Zolnierkiewicz wrote:
> > Entry for Index 941 has one zero too much. Fix it.
> > 
> > Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
> 
> Good catch :)

Thanks. :)

> I'm curious, how did you spot it ?

While I was reading the driver code I've noticed that
omap5430_adc_to_temp[] and dra752_adc_to_temp[] look pretty
similar so I've diff-ed them to find the actual differences
(+ to see if one of the tables can be removed). One of such
differences was the line containing the incorrect entry.

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics
