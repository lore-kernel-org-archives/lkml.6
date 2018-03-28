Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753326AbeC1Nxq (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Mar 2018 09:53:46 -0400
Received: from mailout2.samsung.com ([203.254.224.25]:23368 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753142AbeC1Nxo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Mar 2018 09:53:44 -0400
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20180328135341epoutp02cbf091ad423ca5c2f5d2e151d22d4497~gGfbR5tla1241512415epoutp02N
X-AuditID: b6c32a46-b6dff70000000fe8-e9-5abb9e64aa41
From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
To: SF Markus Elfring <elfring@users.sourceforge.net>
Cc: Arnd Bergmann <arnd@arndb.de>, Bastian Stender <bst@pengutronix.de>,
        Jyri Sarha <jsarha@ti.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>,
        linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH v2] video: ssd1307fb: Improve a size determination in
 ssd1307fb_probe()
Date: Wed, 28 Mar 2018 15:53:38 +0200
Message-id: <3926941.Nf8LXND9kI@amdc3058>
User-Agent: KMail/4.13.3 (Linux/3.13.0-96-generic; KDE/4.13.3; x86_64; ; )
In-reply-to: <c2fc8e5c-e4d3-51da-451c-be70e0d3fef0@users.sourceforge.net>
MIME-version: 1.0
Content-transfer-encoding: 7Bit
Content-type: text/plain; charset="us-ascii"
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmplleLIzCtJLcpLzFFi42LZdljTVDdl3u4og573xhZ/Jx1jt/ixi9vi
        ytf3bBbnO5czW3R3drBabL0lbXGi7wOrxeVdc9gs1s+/xebA6fH71yRGj/vdx5k8+v8aeBy/
        sZ3Jo+lUO6vH501yAWxRXDYpqTmZZalF+nYJXBnNN/8zFUxnrXg5dxpzA+M8li5GTg4JAROJ
        Z60HGLsYuTiEBHYwSry+tY4NJCEk8J1RomVnDUzR5b+H2SGKNjBKzLh2jhnC+coocXrVSXaQ
        KjYBK4mJ7auARnFwiAiYSvw5EQJSwywwlUni/YqDbCBxYYFYiZm9OiDlLAKqErPbnrCC2LwC
        mhLNE96CjREV8JLYsq+dCaScU8BTYtd1fYgSQYkfk++BHc0sIC+xb/9UVghbR+LssXVgD0gI
        XGaTaF13nxniaBeJxYcmQdnCEq+Ob2GHsKUlnq3aCNXQzCjxbcceqKIJjBJ71gtB2NYSh49f
        hNrAJ9Fx+C87yEESArwSHW1QJR4SZ7b2s0LYjhJnjj1kggTcHkaJtc2cExhlZyG5exaSu2ch
        uXsBI/MqRrHUguLc9NRiowIjveLE3OLSvHS95PzcTYzgxKHltoNxyTmfQ4wCHIxKPLwFMbui
        hFgTy4orcw8xSnAwK4nwvtfYHSXEm5JYWZValB9fVJqTWnyIUZqDRUmctzXAJUpIID2xJDU7
        NbUgtQgmy8TBKdXAWPWwsd7zcfepvZlPeqVP5stuXdyQvulyxr3ueMP43eLcufk72V9dnzXr
        b9vOTSLdm/6WbPP11s9af6vTLfPuYoMuTmPpv0/tm3pfbmHWzfDc+nFj6UcvluIFcuyl1Vfn
        r+y1v7LZZI3tQpOHkkwPXJgqSts/zxTS02WKMDSr3X3v+yye93YLlViKMxINtZiLihMB1ylF
        YBgDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrPLMWRmVeSWpSXmKPExsVy+t9jQd2UebujDJ69lLP4O+kYu8WPXdwW
        V76+Z7M437mc2aK7s4PVYustaYsTfR9YLS7vmsNmsX7+LTYHTo/fvyYxetzvPs7k0f/XwOP4
        je1MHk2n2lk9Pm+SC2CL4rJJSc3JLEst0rdL4MpovvmfqWA6a8XLudOYGxjnsXQxcnJICJhI
        XP57mL2LkYtDSGAdo8TUSXNYIJyvjBLT755jBqliE7CSmNi+irGLkYNDRMBU4s+JEJAaZoGp
        TBLdd/vYQeLCArESM3t1QMpZBFQlZrc9YQWxeQU0JZonvGUHsUUFvCS27GtnAinnFPCU2HVd
        H2LVPkaJvTuXsUDUC0r8mHwPzGYWkJfYt38qK4StJbF+53GmCYz8s5CUzUJSNgtJ2QJG5lWM
        kqkFxbnpucVGBUZ5qeV6xYm5xaV56XrJ+bmbGIHBvu2wVv8OxsdL4g8xCnAwKvHwFsTsihJi
        TSwrrsw9xCjBwawkwvteY3eUEG9KYmVValF+fFFpTmrxIUZpDhYlcV7+/GORQgLpiSWp2amp
        BalFMFkmDk4pYPBO3f6MsTtJnTn0FpPz3gs3RcptlsbvnMk2ayFjg/D2iYyq63Mn1fAHnOo/
        /nHRLM/DtRGHhVuerRCpi6k3qX/zf2m4uVTMRaPFp7bULg2YZ9HOuMLOJ7hDrukV77+8HgUB
        /wy3xtQFf7kjHywVVfl6/PbGpV2ualztvS8aBL5c4JrjKcumrsRSnJFoqMVcVJwIADyW9tty
        AgAA
X-CMS-MailID: 20180328135340epcas2p32a6df1b54cf28e3dc3948ee3a9d5b4e7
X-Msg-Generator: CA
CMS-TYPE: 102P
X-CMS-RootMailID: 20171125160425epcas5p43b2d94fbcc74745017c4c91ff08de685
X-RootMTR: 20171125160425epcas5p43b2d94fbcc74745017c4c91ff08de685
References: <CGME20171125160425epcas5p43b2d94fbcc74745017c4c91ff08de685@epcas5p4.samsung.com>
        <2091464.qzRHS0Wsad@amdc3058>
        <c2fc8e5c-e4d3-51da-451c-be70e0d3fef0@users.sourceforge.net>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday, January 07, 2018 07:34:44 PM SF Markus Elfring wrote:
> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Sun, 7 Jan 2018 19:27:28 +0100
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
