Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751982AbeCLPUa (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Mar 2018 11:20:30 -0400
Received: from mailout2.samsung.com ([203.254.224.25]:39741 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751248AbeCLPU1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Mar 2018 11:20:27 -0400
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20180312152026epoutp027005dda70a256f048851590ccb62cdfa~bNWlqgcFT1086710867epoutp025
X-AuditID: b6c32a46-3c1ff70000001029-e8-5aa69ab81ad7
From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
To: Mathieu Malaterre <malat@debian.org>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Tomi Valkeinen <tomi.valkeinen@ti.com>, linux-fbdev@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5] Fix loading of module radeonfb on PowerMac
Date: Mon, 12 Mar 2018 16:20:22 +0100
Message-id: <2379985.mFGi9AtZPr@amdc3058>
User-Agent: KMail/4.13.3 (Linux/3.13.0-96-generic; KDE/4.13.3; x86_64; ; )
In-reply-to: <20180213180316.11934-1-malat@debian.org>
MIME-version: 1.0
Content-transfer-encoding: 7Bit
Content-type: text/plain; charset="us-ascii"
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrGIsWRmVeSWpSXmKPExsWy7bCmme6OWcuiDC5P07P40NTKbHHl63s2
        ixN9H1gtLu+aw2ZxdtNbFov182+xObB5/Gqby+zR86aF1eN+93Emj+M3tjN5fN4kF8AaxWWT
        kpqTWZZapG+XwJWxffIjxoIp3BVfb69jbmBcztnFyMEhIWAicXi+YRcjF4eQwA5GiTvrX7BB
        ON8ZJe5vOMLcxcgJVjT9wQ0miMRuRonzf1ayQzhfGSWav8xgB6liE7CSmNi+ihHEFhHQkLh1
        5TnYKGaBvYwSD3t/ghUJCzhJPHx9FMxmEVCV6Hm/FayBV0BTYnXHZTBbVMBLYsu+diYQm1PA
        TKL/5wk2iBpBiR+T77GA2MwC8hL79k9lhbB1JM4eW8cIskxCYAebxI8zb9kg7naRuDhtFyuE
        LSzx6vgWdghbWuLZqo1QDc2MEt927IF6dAKjxJ71QhC2tcTh4xehNvBJdBz+yw4JMV6JjjYh
        CNNDYtkTfohqR4lfU9+CTRES6GSUaGtRnsAoOwvJ2bOQnD0LydkLGJlXMYqlFhTnpqcWGxUY
        6RUn5haX5qXrJefnbmIEpwYttx2MS875HGIU4GBU4uE1aF4WJcSaWFZcmXuIUYKDWUmE138q
        UIg3JbGyKrUoP76oNCe1+BCjNAeLkjhva4BLlJBAemJJanZqakFqEUyWiYNTqoGRr2nSPJ9l
        b/5n7Wi69+dfweXWpu312xOi81Q99/G+exmwbJ4V19Jpq6bFRr80yfQ8vv8f13+3EM4Hn1au
        dH0vu/tP3F5Fhe0eobu1bW4E7zhWXsOTefA1d+QSjQe1Gy+n/RYsPzn1iVSJqmaDhreeU7Tr
        xr/MN31Pa3tNvVqfumfTFc17rmwnlFiKMxINtZiLihMBwU7oDQkDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrILMWRmVeSWpSXmKPExsVy+t9jAd0ds5ZFGfz/KmbxoamV2eLK1/ds
        Fif6PrBaXN41h83i7Ka3LBbr599ic2Dz+NU2l9mj500Lq8f97uNMHsdvbGfy+LxJLoA1issm
        JTUnsyy1SN8ugStj++RHjAVTuCu+3l7H3MC4nLOLkZNDQsBEYvqDG0xdjFwcQgI7GSVu725m
        hXC+Mkq8mH2cFaSKTcBKYmL7KkYQW0RAQ+LWledsIEXMAnsZJXZvm80GkhAWcJJ4+PooO4jN
        IqAq0fN+K1gDr4CmxOqOy2C2qICXxJZ97UwgNqeAmUT/zxNsENu6GSU6Nl9mhmgQlPgx+R4L
        iM0sIC+xb/9UVghbS2L9zuNMExj5ZyEpm4WkbBaSsgWMzKsYJVMLinPTc4uNCozyUsv1ihNz
        i0vz0vWS83M3MQIDetthrf4djI+XxB9iFOBgVOLh7WhdFiXEmlhWXJl7iFGCg1lJhNd/KlCI
        NyWxsiq1KD++qDQntfgQozQHi5I4L3/+sUghgfTEktTs1NSC1CKYLBMHp1QD4yrOYO27au82
        p7d7xF7OYXi2OfpDk7YgP8e65xcy1cP7HrPdDX1ULSB+fsaDXRw637ONGaKLfYsPyV8KMZ/H
        yhJcJXOlbqmg5yy5GBdJTd9X9SyRcw3r/3648o9RP99wgfbBDTHJnhXrbyiaKqz++1V1kt3d
        TWdmJcVFCDRamay4csBw64d9SizFGYmGWsxFxYkAwNUlbWQCAAA=
X-CMS-MailID: 20180312152024epcas2p3bcd02212941aa48f8e1f0c4b2fbe230f
X-Msg-Generator: CA
CMS-TYPE: 102P
X-CMS-RootMailID: 20180213180332epcas2p30b385519194cf8c820610768b93abed2
X-RootMTR: 20180213180332epcas2p30b385519194cf8c820610768b93abed2
References: <CGME20180213180332epcas2p30b385519194cf8c820610768b93abed2@epcas2p3.samsung.com>
        <20180213180316.11934-1-malat@debian.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday, February 13, 2018 07:03:16 PM Mathieu Malaterre wrote:
> When the linux kernel is build with (typical kernel ship with Debian
> installer):
> 
> CONFIG_FB=y
> CONFIG_FB_OF=y
> CONFIG_VT_HW_CONSOLE_BINDING=y
> CONFIG_FB_RADEON=m
> 
> The offb driver takes precedence over module radeonfb. It is then
> impossible to load the module, error reported is:
> 
> [   96.551486] radeonfb 0000:00:10.0: enabling device (0006 -> 0007)
> [   96.551526] radeonfb 0000:00:10.0: BAR 0: can't reserve [mem 0x98000000-0x9fffffff pref]
> [   96.551531] radeonfb (0000:00:10.0): cannot request region 0.
> [   96.551545] radeonfb: probe of 0000:00:10.0 failed with error -16
> 
> This patch reproduce the behavior of the module radeon, so as to make it
> possible to load radeonfb when offb is first loaded, see
> commit a56f7428d753 ("drm/radeon: Add early unregister of firmware fb's").
> 
> Signed-off-by: Mathieu Malaterre <malat@debian.org>
> Link: https://bugs.debian.org/826629#57
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=119741
> Suggested-by: Lennart Sorensen <lsorense@csclub.uwaterloo.ca>
> Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>

Patch queued for 4.17, thanks.

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics
