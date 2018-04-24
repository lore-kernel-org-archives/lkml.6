Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752641AbeDXQCd (ORCPT <rfc822;w@1wt.eu>);
        Tue, 24 Apr 2018 12:02:33 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:36080 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752074AbeDXQC3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Apr 2018 12:02:29 -0400
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20180424160227euoutp022e407425668b52c139de1f54475d5830~oaqjqEWJ00886708867euoutp02M
X-AuditID: cbfec7f2-5ffe19c000011644-c3-5adf550dfffa
From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
To: Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        kernel-janitors@vger.kernel.org,
        Tomi Valkeinen <tomi.valkeinen@ti.com>, linux-omap@vger.kernel.org,
        linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org
Subject: Re: [PATCH 58/61] video: fbdev: omap2: omapfb: displays: simplify
 getting .drvdata
Date: Tue, 24 Apr 2018 18:02:11 +0200
Message-ID: <1726457.eauaWiscAe@amdc3058>
User-Agent: KMail/4.13.3 (Linux/3.13.0-96-generic; KDE/4.13.3; x86_64; ; )
In-Reply-To: <20180419140641.27926-59-wsa+renesas@sang-engineering.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprLKsWRmVeSWpSXmKPExsWy7djP87p8ofejDP7uZ7S48vU9m8XWW9IW
        J/o+sFpc3jWHzWL2kn4Wi60v3zFZrJ9/i82i75y7A4fH/e7jTB7PFq5n8Th+YzuTx+dNcgEs
        UVw2Kak5mWWpRfp2CVwZL659YC1oZK6Y9JSngXE3UxcjJ4eEgIlE58Je5i5GLg4hgRWMElu7
        b7NDOF8YJU5NXMIE4XxmlFh14TALTMv6aR+hEssZJS6+uA7lfGCUaHo4mRmkik3ASmJi+ypG
        EFtEwFhiTfNssLnMAm8YJY48PgC2XVggVuJH80KwBhYBVYmGbXvAGngFNCXmT5rECmKLCnhJ
        bNnXDlbPKeAu0bZvOxtEjaDEyZlPwE5iFpCX6LjcyAqyQEJgEbvEzNWnoG51kZg95QUbhC0s
        8er4FnYIW0bi/875TBANzYwS33bsYYZITGCU2LNeCMK2ljh8/CLQVA6gDZoS63fpQ4RtJc7t
        +ccMEpYQ4JO48VYQ4gY+iUnbpkOFeSU62qCGqElsWLaBDWZr186VUIs8JJYcW8U6gVFpFpJv
        ZiH5ZhbC3gWMzKsYxVNLi3PTU4sN81LL9YoTc4tL89L1kvNzNzECE83pf8c/7WD8einpEKMA
        B6MSD++P33ejhFgTy4orcw8xSnAwK4nw7pW7FyXEm5JYWZValB9fVJqTWnyIUZqDRUmcN06j
        LkpIID2xJDU7NbUgtQgmy8TBKdXA2LLdUaFbX9cjjkn09IYkBo05jy+e8zt2V+f8SbMj7Dzz
        jdi8ly976WW1j3Xlj5Ltiql3H2U9rHR9pyYUknKY49rLCyoW2bKsGx5ceXTKbcVB16TIn1r7
        /FsnLvkw3Wjta5Uom48b+ten7nnmpijGtfyCkrXAg9sO7O+Kz+w44f3/GvfalcLfJJRYijMS
        DbWYi4oTAZd4IVowAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrEIsWRmVeSWpSXmKPExsVy+t/xu7qcofejDFYeELK48vU9m8XWW9IW
        J/o+sFpc3jWHzWL2kn4Wi60v3zFZrJ9/i82i75y7A4fH/e7jTB7PFq5n8Th+YzuTx+dNcgEs
        UXo2RfmlJakKGfnFJbZK0YYWRnqGlhZ6RiaWeobG5rFWRqZK+nY2Kak5mWWpRfp2CXoZL659
        YC1oZK6Y9JSngXE3UxcjJ4eEgInE+mkfwWwhgaWMEm177bsYOYDiMhLH15dBlAhL/LnWxdbF
        yAVU8o5R4v2hWcwgCTYBK4mJ7asYQWwRAWOJNc2z2UGKmAWeMUp82HWVFSQhLBAtsXTXZ7AF
        LAKqEg3b9oA18ApoSsyfNAmsRlTAS2LLvnawGk4Bd4m2fduhtl1ilPi74gYzRIOgxMmZT1hA
        bGYBeYmOy42sELaOxILdn9gmMArOQlI2C0nZLCRlCxiZVzGKpJYW56bnFhvqFSfmFpfmpesl
        5+duYgTGz7ZjPzfvYLy0MfgQowAHoxIP74/fd6OEWBPLiitzDzFKcDArifDulbsXJcSbklhZ
        lVqUH19UmpNafIjRFOi7icxSosn5wNjOK4k3NDU0t7A0NDc2NzazUBLnPW9QGSUkkJ5Ykpqd
        mlqQWgTTx8TBKdXAGO+mYr55+blV+f//8B/+3zn/lb628+uv4VdltPc+cpifHpDy/8I/gwPV
        E9Ne/H/IlxyotpNv/nOxAkVJsxdHZjDNeuL5oYX59UWzuDPNzorvFb+t7T8lmmL0dgZbfql3
        NU+OubW098q5k5juzNp5Skra+qLFPxmRxsWPqyfNNAvcLahQ/udsgBJLcUaioRZzUXEiANqi
        EMa1AgAA
X-CMS-MailID: 20180424160219eucas1p29d0055ef9d1f3dcd83954215b92274e6
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-MTR: 20180424160219eucas1p29d0055ef9d1f3dcd83954215b92274e6
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20180419140716epcas2p3dd25b3be301017affaef3908823c5ace
X-RootMTR: 20180419140716epcas2p3dd25b3be301017affaef3908823c5ace
References: <20180419140641.27926-1-wsa+renesas@sang-engineering.com>
        <CGME20180419140716epcas2p3dd25b3be301017affaef3908823c5ace@epcas2p3.samsung.com>
        <20180419140641.27926-59-wsa+renesas@sang-engineering.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday, April 19, 2018 04:06:28 PM Wolfram Sang wrote:
> We should get drvdata from struct device directly. Going via
> platform_device is an unneeded step back and forth.
> 
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

Patch queued for 4.18, thanks.

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics
