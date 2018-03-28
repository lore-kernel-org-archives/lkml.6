Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753534AbeC1ORG (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Mar 2018 10:17:06 -0400
Received: from mailout2.samsung.com ([203.254.224.25]:27775 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753339AbeC1ORD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Mar 2018 10:17:03 -0400
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20180328141702epoutp021b5db729f389a846b5351f5667b64543~gGzzXulmR2841328413epoutp02F
X-AuditID: b6c32a36-f57ff70000000fc2-d3-5abba3ddad5f
From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
To: SF Markus Elfring <elfring@users.sourceforge.net>
Cc: linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Russell King <linux@armlinux.org.uk>,
        LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH 2/2] video: ARM CLCD: Improve a size determination in
 clcdfb_probe()
Date: Wed, 28 Mar 2018 16:16:58 +0200
Message-id: <3181596.jONtYT21fI@amdc3058>
User-Agent: KMail/4.13.3 (Linux/3.13.0-96-generic; KDE/4.13.3; x86_64; ; )
In-reply-to: <3656de6d-53cc-f6a4-1950-71fc989c79a4@users.sourceforge.net>
MIME-version: 1.0
Content-transfer-encoding: 7Bit
Content-type: text/plain; charset="us-ascii"
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrPIsWRmVeSWpSXmKPExsWy7bCmvu7dxbujDFa+YLO48vU9m8X5zuXM
        FltvSVuc6PvAanF51xw2i0NT9zI6sHlcvnaR2eN+93Emj6ZT7awenzfJBbBEcdmkpOZklqUW
        6dslcGX07L7AVjCTteJOSwNLA+MCli5GTg4JAROJxXOOsnUxcnEICexglHi/YiI7hPOdUeLe
        tdPMMFXPJvyESuxmlNi1cjMThPOVUWLR5W52kCo2ASuJie2rGLsYOThEBEwl/pwIAalhFtjA
        KHH05lewGmGBKImrzz6wgtgsAqoSm3rPg9XzCmhK7FtUARIWFfCS2LKvnQkkzCngKXHkjBlI
        mFdAUOLH5HtgVzMLyEvs2z+VFcLWkTh7bB0jyCoJgQ1sEg9mXGeEONpFonvNUagHhCVeHd/C
        DjJTQkBa4tJRW4j6ZkaJbzv2QNVMYJTYs14IwraWOHz8ItQCPol3X3tYIXp5JTraoEo8JF5e
        fcIEYTtK3PtwDxo+txklFl5cyDyBUXYWkrtnIbl7FpK7FzAyr2IUSy0ozk1PLTYsMNIrTswt
        Ls1L10vOz93ECE4GWmY7GBed8znEKMDBqMTDa7Fod5QQa2JZcWXuIUYJDmYlEd73GkAh3pTE
        yqrUovz4otKc1OJDjNIcLErivAEBLlFCAumJJanZqakFqUUwWSYOTqkGRm4RiyWP9dtTDNxC
        /rZ5Z/gf3GSvH3TJaMHXboN/nvKiK0y+pHhNZKmUfBRb4njRPeKi91HrRL2KSdY5d4+Zz9/D
        kSVzaXnltxcufUYMgVG5Z232PFY+dC0xz/uLU3D+QZlQ94dxu6b3urStSy42nhfTIcC0+Uit
        7Hm35SW/tb4tldnlIsmuxFKckWioxVxUnAgAzOreKAIDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrBLMWRmVeSWpSXmKPExsVy+t9jAd07i3dHGUztVLe48vU9m8X5zuXM
        FltvSVuc6PvAanF51xw2i0NT9zI6sHlcvnaR2eN+93Emj6ZT7awenzfJBbBEcdmkpOZklqUW
        6dslcGX07L7AVjCTteJOSwNLA+MCli5GTg4JAROJZxN+sncxcnEICexklDj5pRfK+coocfPs
        bCaQKjYBK4mJ7asYuxg5OEQETCX+nAgBqWEW2MAo8Xv5XFaQGmGBKImrzz6A2SwCqhKbes+D
        1fMKaErsW1QBEhYV8JLYsq+dCSTMKeApceSMGcSq24wSDc/mgK3iFRCU+DH5HthxzALyEvv2
        T2WFsLUk1u88zjSBkX8WkrJZSMpmISlbwMi8ilEytaA4Nz232KjAMC+1XK84Mbe4NC9dLzk/
        dxMjMHy3Hdbq28F4f0n8IUYBDkYlHl6LRbujhFgTy4orcw8xSnAwK4nwvtcACvGmJFZWpRbl
        xxeV5qQWH2KU5mBREue9nXcsUkggPbEkNTs1tSC1CCbLxMEp1cAory53mtWrsuodx6puGY6r
        ykUqlv0C+4KXz5JJnS+y9+Dq162uh/LelWjOMP4yVeVi8dSgOPOlHS9Mjy1ctJ7hnX+c+485
        769Z263SszjhoHs1QyvxYDdb9wal/RsWXQt5FHo9aB7X+1ITpwnL/7MESAasXujyQkDl3kkZ
        T9st0zsCv7UdchBWYinOSDTUYi4qTgQAXirPKVsCAAA=
X-CMS-MailID: 20180328141700epcas1p165a1e3d1010b5bb3aea7b524a314eccc
X-Msg-Generator: CA
CMS-TYPE: 101P
X-CMS-RootMailID: 20171205171416epcas5p170833154061d837027c6dccfee0ccc6c
X-RootMTR: 20171205171416epcas5p170833154061d837027c6dccfee0ccc6c
References: <107ed35f-1775-14e0-a7b5-20e7ee02ac16@users.sourceforge.net>
        <CGME20171205171416epcas5p170833154061d837027c6dccfee0ccc6c@epcas5p1.samsung.com>
        <3656de6d-53cc-f6a4-1950-71fc989c79a4@users.sourceforge.net>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday, December 05, 2017 06:13:33 PM SF Markus Elfring wrote:
> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Tue, 5 Dec 2017 17:53:19 +0100
> 
> Replace the specification of a data structure by a pointer dereference
> as the parameter for the operator "sizeof" to make the corresponding size
> determination a bit safer according to the Linux coding style convention.
> 
> This issue was detected by using the Coccinelle software.
> 
> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>

Patch queued for 4.17, thanks.

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics
