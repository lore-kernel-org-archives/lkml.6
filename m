Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754976AbeDZKPx (ORCPT <rfc822;w@1wt.eu>);
        Thu, 26 Apr 2018 06:15:53 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:39120 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753403AbeDZKPs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Apr 2018 06:15:48 -0400
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20180426101546euoutp01cf842b2fd8f3df408cc95dae36e1fe82~o9ObloIjX1606516065euoutp01b
X-AuditID: cbfec7f4-b4fc79c0000043e4-bd-5ae1a6cc3b3b
From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
To: SF Markus Elfring <elfring@users.sourceforge.net>
Cc: linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Alexey Khoroshilov <khoroshilov@ispras.ru>,
        Bhumika Goyal <bhumirks@gmail.com>,
        Colin Ian King <colin.king@canonical.com>,
        "Gustavo A. R. Silva" <garsilva@embeddedor.com>,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH 2/4] video: sm501fb: Improve a size determination in
 sm501fb_probe()
Date: Thu, 26 Apr 2018 12:15:38 +0200
Message-id: <1859038.Xq2p7m02WJ@amdc3058>
User-Agent: KMail/4.13.3 (Linux/3.13.0-96-generic; KDE/4.13.3; x86_64; ; )
In-reply-to: <08ed1e90-5714-04b7-b3dc-067a3d9bc38b@users.sourceforge.net>
MIME-version: 1.0
Content-transfer-encoding: 7Bit
Content-type: text/plain; charset="us-ascii"
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprEKsWRmVeSWpSXmKPExsWy7djP87pnlj2MMtj+2sbi071+Novfq3vZ
        LK58fc9mcb5zObPFyiX72Sy23pK22LFuJ7vFib4PrBaXd81hszhwegqzA5fHrIZeNo91B1U9
        ds66y+4x499URo/73ceZPJpOtbN6fN4kF8AexWWTkpqTWZZapG+XwJVx9dA31oIlrBVHdv1i
        bmBcydLFyMkhIWAise/xdVYQW0hgBaPEp0nBXYxcQPZnRoktc5czwhSdeneEDSKxjFHi453J
        zBDOb0aJL7ueg7WzCVhJTGxfBdTBwSEiYCrx50QISA2zwAsmiTd728AmCQtESXyYfAzMZhFQ
        lZi5fA4TSD2vgKZE17wSkLCogJfEln3tTCA2p4CnxOcda8DG8woISvyYfA/samYBeYl9+6ey
        Qtg6EmePrWME2SUhcJ9N4uTjt2AzJQRcJL61qUE8ICzx6vgWdghbRqKz4yATRH0zo8S3HXuY
        IRITGCX2rBeCsK0lDh+/CLWAT2LStunMEDN5JTraoEo8JB6tfQcNIEeJ64fWsULC5DajxK01
        3cwTGGVnIbl7FpK7ZyG5ewEj8ypG8dTS4tz01GKjvNRyveLE3OLSvHS95PzcTYzAlHL63/Ev
        Oxh3/Uk6xCjAwajEw/tj3oMoIdbEsuLK3EOMEhzMSiK88a0Po4R4UxIrq1KL8uOLSnNSiw8x
        SnOwKInzxmnURQkJpCeWpGanphakFsFkmTg4pRoYecqu3t438Vp5YPeDFw8f/vk48aDPXbdV
        te4vI27sWHiX+QV3ztY2F6nt5TxL6kPDFMSSfB79SNFN61nypfNzbv93oTdPtTdJNcmx65xi
        Umm+/J4z68L+R1/n5LfqLizjtvmrc3NjrNgSDyGP3Ok614Nez78i5D1v3eeD1nds47z7P1fc
        0/FTUGIpzkg01GIuKk4EAAmE5+ElAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrGLMWRmVeSWpSXmKPExsVy+t/xq7qnlj2MMmh6Ymrx6V4/m8Xv1b1s
        Fle+vmezON+5nNli5ZL9bBZbb0lb7Fi3k93iRN8HVovLu+awWRw4PYXZgctjVkMvm8e6g6oe
        O2fdZfeY8W8qo8f97uNMHk2n2lk9Pm+SC2CP4rJJSc3JLEst0rdL4Mq4eugba8ES1ooju34x
        NzCuZOli5OSQEDCROPXuCFsXIxeHkMASRolHk7qgnL+MEn1nVjGCVLEJWElMbAexOThEBEwl
        /pwIAalhFnjFJDG19TJYjbBAlMSHycfAbBYBVYmZy+cwgdTzCmhKdM0rAQmLCnhJbNnXzgRi
        cwp4SnzesYYVYtdtRomGP8vYQBK8AoISPybfA7uOWUBeYt/+qawQtpbE+p3HmSYw8s9CUjYL
        SdksJGULGJlXMYqklhbnpucWG+oVJ+YWl+al6yXn525iBIb+tmM/N+9gvLQx+BCjAAejEg/v
        j3kPooRYE8uKK3MPMUpwMCuJ8Ma3PowS4k1JrKxKLcqPLyrNSS0+xCjNwaIkznveoDJKSCA9
        sSQ1OzW1ILUIJsvEwSnVwDhrloHQnrO5R3+/05lU/Viz1Ks5aXvcDJmyt1azGbwXXHNjutbS
        nWZWoZ71rnfKTJOVsiwv50b/F/V/2TN/0l5VN4/YGe19HBuijnLNOy1Yq5WunmBqGqVjum5Z
        W/6LTa8vHfih+KDSdP2KU4dDd3KeCcnhttuyUn+5i4+ZePKm6bWPtDentyixFGckGmoxFxUn
        AgC8ry7AeQIAAA==
X-CMS-MailID: 20180426101538eucas1p176c9e18041fd069396d89e130e4bc5ab
X-Msg-Generator: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20171126101848epcas2p3725dcc0b645cf4d4d9730f8f8edbad70
X-RootMTR: 20171126101848epcas2p3725dcc0b645cf4d4d9730f8f8edbad70
References: <efb981db-e9a0-d6f7-00d4-c76e1162770c@users.sourceforge.net>
        <CGME20171126101848epcas2p3725dcc0b645cf4d4d9730f8f8edbad70@epcas2p3.samsung.com>
        <08ed1e90-5714-04b7-b3dc-067a3d9bc38b@users.sourceforge.net>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday, November 26, 2017 11:18:26 AM SF Markus Elfring wrote:
> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Sun, 26 Nov 2017 10:22:37 +0100
> 
> Replace the specification of a data structure by a pointer dereference
> as the parameter for the operator "sizeof" to make the corresponding size
> determination a bit safer according to the Linux coding style convention.
> 
> This issue was detected by using the Coccinelle software.
> 
> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>

Hand applied and queued for 4.18, thanks.

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics
