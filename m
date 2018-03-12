Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752063AbeCLPbn (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Mar 2018 11:31:43 -0400
Received: from mailout2.samsung.com ([203.254.224.25]:41398 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751458AbeCLPb2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Mar 2018 11:31:28 -0400
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20180312153127epoutp025f6ad929b965e0f7881d038b905eb8e5~bNgNTvmid1789917899epoutp028
X-AuditID: b6c32a38-adbff70000001054-c2-5aa69d4e2bd8
From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
To: Mathieu Malaterre <malat@debian.org>
Cc: Rob Herring <robh@kernel.org>, dri-devel@lists.freedesktop.org,
        linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] video: offb: Deallocate the color map
Date: Mon, 12 Mar 2018 16:31:23 +0100
Message-id: <2500950.WnLxRKliRb@amdc3058>
User-Agent: KMail/4.13.3 (Linux/3.13.0-96-generic; KDE/4.13.3; x86_64; ; )
In-reply-to: <20180213180747.12666-1-malat@debian.org>
MIME-version: 1.0
Content-transfer-encoding: 7Bit
Content-type: text/plain; charset="us-ascii"
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrLIsWRmVeSWpSXmKPExsWy7bCmrq7f3GVRBhc+clhc+fqezeJE3wdW
        i8u75rBZnN30lsXi/54d7A6sHr/a5jJ7bFrVyeZxv/s4k8fnTXIBLFFcNimpOZllqUX6dglc
        GUcaDjEWPBKp2PR8LlMD426BLkZODgkBE4lZX1YydzFycQgJ7GCUWHV/EROE851RomXeejaY
        qiObmhkhEhsYJS6sWQflfGWU2HJjCgtIFZuAlcTE9lWMILaIgIbErSvPwbqZBeollp+5zQpi
        CwPVvHywGsxmEVCVmNg3E8zmFdCU+Lb2KzuILSrgJbFlXzsTiM0pYCZxefVGdogaQYkfk++x
        QMyUl9i3fyorhK0jcfYYxEESAkvYJLbO/MQKcbaLxLlfz6BeEJZ4dXwL0CAOIFta4tJRW4j6
        ZkaJbzv2MEPUTGCU2LNeCMK2ljh8/CLUAj6Jd197WCF6eSU62qBKPCRat/5lh7AdJS4/6IQG
        XSejxPFF65gmMMrOQnL3LCR3z0Jy9wJG5lWMYqkFxbnpqcWGBSZ6xYm5xaV56XrJ+bmbGMGJ
        QMtiB+Oecz6HGAU4GJV4eA2al0UJsSaWFVfmHmKU4GBWEuH1nwoU4k1JrKxKLcqPLyrNSS0+
        xCjNwaIkzhsQ4BIlJJCeWJKanZpakFoEk2Xi4JRqYGzTqugIsdy03/xLcdBz9j7pE1vKm4+f
        dPKyORRb8vy+XqD05FOLzVNLGCyO223y5Utc2se8cerpLt5dm7675Rkmz+17b7+rtb/mvFGQ
        7wUDfuG1T7cFNMtmfq0Vudb7f9nL9b8vfbsv4bD75cpeBjfTu/HiQiudOBQPXtTQthJwWBok
        3z43W4mlOCPRUIu5qDgRACqRZGIAAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrKLMWRmVeSWpSXmKPExsVy+t9jQV3fucuiDNbON7O48vU9m8WJvg+s
        Fpd3zWGzOLvpLYvF/z072B1YPX61zWX22LSqk83jfvdxJo/Pm+QCWKK4bFJSczLLUov07RK4
        Mo40HGIseCRSsen5XKYGxt0CXYycHBICJhJHNjUzgthCAusYJXadjOti5AKyvzJKHJzziB0k
        wSZgJTGxfRVYkYiAhsStK8/ZQGxmgXqJXYc2MYHYwkA1Lx+sZgWxWQRUJSb2zQSzeQU0Jb6t
        /Qo2R1TAS2LLvnawek4BM4nLqzeyQyzrZpT49/wbI0SDoMSPyfdYIBbIS+zbP5UVwtaSWL/z
        ONMERv5ZSMpmISmbhaRsASPzKkbJ1ILi3PTcYqMCw7zUcr3ixNzi0rx0veT83E2MwMDddlir
        bwfj/SXxhxgFOBiVeHg7WpdFCbEmlhVX5h5ilOBgVhLh9Z8KFOJNSaysSi3Kjy8qzUktPsQo
        zcGiJM57O+9YpJBAemJJanZqakFqEUyWiYNTqoFxVfmtH3umP5tS9S9d48tT4bUPC3per+/z
        Mmaf1l/4reC12rS2tV+uvBTq21hXtuy59g3rpRO9tl+U5f6r8uKSgzX3DO2tApEzZ6nOsI17
        cNbaUIbtRfGF4KoJ7xznWOloMJ3uLnWaU//m/8dpq45Mal3l8U11r23fgk81olVmX341L/EJ
        /mE0X4mlOCPRUIu5qDgRAJWijqFYAgAA
X-CMS-MailID: 20180312153125epcas1p2e57298cac2b9c7ddba463e8ab31b43f8
X-Msg-Generator: CA
CMS-TYPE: 101P
X-CMS-RootMailID: 20180213180825epcas1p44674e978de3188bb9a42970b28e20d52
X-RootMTR: 20180213180825epcas1p44674e978de3188bb9a42970b28e20d52
References: <CGME20180213180825epcas1p44674e978de3188bb9a42970b28e20d52@epcas1p4.samsung.com>
        <20180213180747.12666-1-malat@debian.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday, February 13, 2018 07:07:45 PM Mathieu Malaterre wrote:
> The function offb_destroy did not deallocate the color map leaving some
> memory around after destruction. Call the color map deallocate function to
> remove the memory leak.
> 
> Handle another case where color map should have been deallocated during an
> error code path.
> 
> Fix memory leaks reported by kmemleak:
> 
> # dmesg
> ...
> [ 1884.719941] kmemleak: 3 new suspected memory leaks (see /sys/kernel/debug/kmemleak)
> # cat /sys/kernel/debug/kmemleak
> unreferenced object 0xde3d9000 (size 512):
>   comm "swapper", pid 1, jiffies 4294892827 (age 1906.784s)
>   hex dump (first 32 bytes):
>     00 00 00 00 00 00 00 00 aa aa aa aa aa aa aa aa  ................
>     55 55 55 55 55 55 55 55 ff ff ff ff ff ff ff ff  UUUUUUUU........
>   backtrace:
>     [<f1433400>] fb_alloc_cmap_gfp+0x54/0x15c
>     [<cb6b409b>] offb_init_nodriver+0x8e8/0xa3c
>     [<b5a1c019>] offb_init+0xd0/0x164
>     [<322f82a3>] do_one_initcall+0x4c/0x178
>     [<b592db9f>] kernel_init_freeable+0x138/0x1cc
>     [<2a17fa0e>] kernel_init+0x24/0x118
>     [<4079749a>] ret_from_kernel_thread+0x5c/0x64
> unreferenced object 0xde3d9200 (size 512):
>   comm "swapper", pid 1, jiffies 4294892827 (age 1906.784s)
>   hex dump (first 32 bytes):
>     00 00 00 00 aa aa aa aa 00 00 00 00 55 55 aa aa  ............UU..
>     55 55 55 55 ff ff ff ff 55 55 55 55 ff ff ff ff  UUUU....UUUU....
>   backtrace:
>     [<4bf3594d>] fb_alloc_cmap_gfp+0x6c/0x15c
>     [<cb6b409b>] offb_init_nodriver+0x8e8/0xa3c
>     [<b5a1c019>] offb_init+0xd0/0x164
>     [<322f82a3>] do_one_initcall+0x4c/0x178
>     [<b592db9f>] kernel_init_freeable+0x138/0x1cc
>     [<2a17fa0e>] kernel_init+0x24/0x118
>     [<4079749a>] ret_from_kernel_thread+0x5c/0x64
> unreferenced object 0xde3d9600 (size 512):
>   comm "swapper", pid 1, jiffies 4294892827 (age 1906.784s)
>   hex dump (first 32 bytes):
>     00 00 aa aa 00 00 aa aa 00 00 aa aa 00 00 aa aa  ................
>     55 55 ff ff 55 55 ff ff 55 55 ff ff 55 55 ff ff  UU..UU..UU..UU..
>   backtrace:
>     [<23a3ea03>] fb_alloc_cmap_gfp+0x84/0x15c
>     [<cb6b409b>] offb_init_nodriver+0x8e8/0xa3c
>     [<b5a1c019>] offb_init+0xd0/0x164
>     [<322f82a3>] do_one_initcall+0x4c/0x178
>     [<b592db9f>] kernel_init_freeable+0x138/0x1cc
>     [<2a17fa0e>] kernel_init+0x24/0x118
>     [<4079749a>] ret_from_kernel_thread+0x5c/0x64
> 
> Signed-off-by: Mathieu Malaterre <malat@debian.org>

Patch queued for 4.17, thanks.

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics
