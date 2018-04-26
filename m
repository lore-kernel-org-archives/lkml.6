Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755069AbeDZKXF (ORCPT <rfc822;w@1wt.eu>);
        Thu, 26 Apr 2018 06:23:05 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:41094 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754811AbeDZKW5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Apr 2018 06:22:57 -0400
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20180426102254euoutp011275c097213ce7874adf825d8ee3011e~o9Up7YGLu1832818328euoutp01e
X-AuditID: cbfec7f2-5ffe19c000011644-cf-5ae1a87a1618
From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
To: SF Markus Elfring <elfring@users.sourceforge.net>
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org,
        dri-devel@lists.freedesktop.org,
        Tomi Valkeinen <tomi.valkeinen@ti.com>,
        LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH 2/3] video: omap: Improve a size determination in
 omapfb_do_probe()
Date: Thu, 26 Apr 2018 12:22:48 +0200
Message-id: <6664625.Vrlhroeaex@amdc3058>
User-Agent: KMail/4.13.3 (Linux/3.13.0-96-generic; KDE/4.13.3; x86_64; ; )
In-reply-to: <3e367b91-a7ae-fc2e-f145-d62cfee14c77@users.sourceforge.net>
MIME-version: 1.0
Content-transfer-encoding: 7Bit
Content-type: text/plain; charset="us-ascii"
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrOIsWRmVeSWpSXmKPExsWy7djPc7pVKx5GGWw+zGtx5et7NovzncuZ
        LbbekrY40feB1eLyrjlsFrOX9LNYrJ9/i82B3eN+93Emj+M3tjN5NJ1qZ/X4vEkugCWKyyYl
        NSezLLVI3y6BK2PzySlsBTNZK7b39rE2MC5g6WLk5JAQMJGY2HUKyObiEBJYwSixcctJdgjn
        M6PEhSPrWGGqdux5zAyRWMYoMfvTYSYI5zejRN/TdnaQKjYBK4mJ7asYuxg5OEQETCX+nAgB
        qWEWOMcocXLFJrAaYYFIie7HR1lAalgEVCVaWoRAwrwCmhLvjr8CKxEV8JLYsq+dCcTmFPCU
        2DuliQmiRlDix+R7YGczC8hL7Ns/lRXC1pE4e2wdI8guCYENbBJfr5yB+s1F4sPPg2wQtrDE
        q+Nb2CFsGYnLk7tZIBqaGSW+7djDDJGYwCixZ70QhG0tcfj4RagNfBKTtk1nBjlaQoBXoqMN
        qsRDYtbzCYwQtqPExKat0HC8zSixdf8FtgmMsrOQHD4LyeGzkBy+gJF5FaN4amlxbnpqsWFe
        arlecWJucWleul5yfu4mRmByOP3v+KcdjF8vJR1iFOBgVOLh/THvQZQQa2JZcWXuIUYJDmYl
        Ed741odRQrwpiZVVqUX58UWlOanFhxilOViUxHnjNOqihATSE0tSs1NTC1KLYLJMHJxSDYx1
        mb6+Bm/f1svlvGA01/BS/lPvlplsmFY7P+NTQ9HCldmdRi/vZ+grt7QtKgrUUNbLPi2zPiNq
        ZVe4QKv5nb+HdRZIPNZY6Xbh+k6DaYbGx7pZy87ePal0IJPN1+r6V3FZB+urC7uqXvAqqR/p
        XfM7wlNUvedPfYauLKd27vvjoTetWEr2KLEUZyQaajEXFScCAMbCeN8KAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrBLMWRmVeSWpSXmKPExsVy+t/xq7oVKx5GGTS817W48vU9m8X5zuXM
        FltvSVuc6PvAanF51xw2i9lL+lks1s+/xebA7nG/+ziTx/Eb25k8mk61s3p83iQXwBLFZZOS
        mpNZllqkb5fAlbH55BS2gpmsFdt7+1gbGBewdDFyckgImEjs2POYGcQWEljCKHFgUmUXIxeQ
        /ZdRYvq9H4wgCTYBK4mJ7auAbA4OEQFTiT8nQkBqmAXOMUr83tQJNkhYIFKi+/FRFpAaFgFV
        iZYWIZAwr4CmxLvjr9hBbFEBL4kt+9qZQGxOAU+JvVOamCB23WaUmLvmAitEg6DEj8n3wGYy
        C8hL7Ns/lRXC1pJYv/M40wRG/llIymYhKZuFpGwBI/MqRpHU0uLc9NxiI73ixNzi0rx0veT8
        3E2MwPDdduznlh2MXe+CDzEKcDAq8fD+mPcgSog1say4MvcQowQHs5IIb3zrwygh3pTEyqrU
        ovz4otKc1OJDjNIcLErivOcNKqOEBNITS1KzU1MLUotgskwcnFINjDESp3jUfbkZtSw0G6dF
        RrhyXlXrFs9UtLg9qbFqblv31wxRG46+nTbJ3gfivwc8ivu04ujOUO40iVu/bt94vdqLPyT4
        uV943J9/2Vs5zWxUt3a8WP13qW2u2vHnfjphHT4L3I6cPO5+t7TtzFW1/Hg247Iv4pMS8oWf
        VBzcu0L3w4I3x1JllViKMxINtZiLihMBDVrSFFsCAAA=
X-CMS-MailID: 20180426102248eucas1p2de9987e33569c09a218d82f7729c9b7a
X-Msg-Generator: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20171126174230epcas2p263bbe1e8888487b01b51550c24b5c0d4
X-RootMTR: 20171126174230epcas2p263bbe1e8888487b01b51550c24b5c0d4
References: <1e17c727-884d-5745-2726-48dd3a53c32f@users.sourceforge.net>
        <CGME20171126174230epcas2p263bbe1e8888487b01b51550c24b5c0d4@epcas2p2.samsung.com>
        <3e367b91-a7ae-fc2e-f145-d62cfee14c77@users.sourceforge.net>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday, November 26, 2017 06:42:23 PM SF Markus Elfring wrote:
> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Sun, 26 Nov 2017 18:16:20 +0100
> 
> Replace the specification of a data structure by a pointer dereference
> as the parameter for the operator "sizeof" to make the corresponding size
> determination a bit safer according to the Linux coding style convention.
> 
> This issue was detected by using the Coccinelle software.
> 
> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>

Patch queued for 4.18, thanks.

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics
