Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752899AbeC1NeR (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Mar 2018 09:34:17 -0400
Received: from mailout4.samsung.com ([203.254.224.34]:57985 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752416AbeC1NeO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Mar 2018 09:34:14 -0400
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20180328133412epoutp045b2d31c6e835731bfc9ce86968ce131c~gGOaZDqwy0517505175epoutp04M
X-AuditID: b6c32a46-b6dff70000000fe8-4f-5abb99d42807
From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
To: SF Markus Elfring <elfring@users.sourceforge.net>
Cc: linux-fbdev@vger.kernel.org, linux-parisc@vger.kernel.org,
        dri-devel@lists.freedesktop.org, Helge Deller <deller@gmx.de>,
        "James E. J. Bottomley" <jejb@parisc-linux.org>,
        Rolf Eike Beer <eike-kernel@sf-tec.de>,
        LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH v2 1/2] video/fbdev/stifb: Return -ENOMEM after a failed
 kzalloc() in stifb_init_fb()
Date: Wed, 28 Mar 2018 15:34:08 +0200
Message-id: <2557729.Jl5E8iEh4q@amdc3058>
User-Agent: KMail/4.13.3 (Linux/3.13.0-96-generic; KDE/4.13.3; x86_64; ; )
In-reply-to: <6341951e-df28-0b40-974e-dedd890b5228@users.sourceforge.net>
MIME-version: 1.0
Content-transfer-encoding: 7Bit
Content-type: text/plain; charset="us-ascii"
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpnleLIzCtJLcpLzFFi42LZdljTVPfKzN1RBkdmK1nc/3Sb0eLK1/ds
        FmterGK3ON+5nNni/rpVrBZbb0lbnOj7wGpxedccNotHpy4wOXB6fPgY53G/+ziTx4VFv1k9
        jvy19mg61c7q8XmTXABbFJdNSmpOZllqkb5dAlfG6Z16Be9ZKs7d2MLSwNjJ0sXIySEhYCIx
        89w7xi5GLg4hgR2MEsc2PGWFcL4zSix93s8IU3Xx/GxmiMRuRolVs5awQThfGSWudt5kA6li
        E7CSmNi+CqiDg0NEwFTiz4kQkBpmgYVMEk0b25lAaoQFsiUuv3kFZrMIqEqsXLeEFcTmFdCU
        uDu3ix3EFhXwktiyD6Seg4NTwFPi54NqiBJBiR+T74GdzSwgL7Fv/1RWCFtH4uyxdWAvSAjc
        ZpN4+LGBFeJqF4n+Z91QHwhLvDq+hR3ClpZ4tmojVEMzo8S3HXuYIRITGCX2rBeCsK0lDh+/
        CLWBT6Lj8F92kIMkBHglOtqgSjwkjhy+zARhO0o8fXOFHRIos5gkHk/qZZzAKDsLyeGzkBw+
        C8nhCxiZVzGKpRYU56anFhsVGOkVJ+YWl+al6yXn525iBCcPLbcdjEvO+RxiFOBgVOLhLYjZ
        FSXEmlhWXJl7iFGCg1lJhPe9xu4oId6UxMqq1KL8+KLSnNTiQ4zSHCxK4rytAS5RQgLpiSWp
        2ampBalFMFkmDk6pBsbm3iadX6emHuSzYGmIOKY56/y92Wud377Zz1Z2QUZsbsHk99+2ZD4/
        VHFc9+auqPKOhG3HY26nNuybK/KEU/9z9LGpTjOmu6zsmLKGYWvFBtXANuX47wx3S1fsiT4i
        4vusdfohPkXhR7obSixdf798wbU8L8os1eDCsitX+2KtqkucE9VigxuUWIozEg21mIuKEwGl
        1d3IGgMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrPLMWRmVeSWpSXmKPExsVy+t9jAd3LM3dHGbx5qmRx/9NtRosrX9+z
        Wax5sYrd4nzncmaL++tWsVpsvSVtcaLvA6vF5V1z2CwenbrA5MDp8eFjnMf97uNMHhcW/Wb1
        OPLX2qPpVDurx+dNcgFsUVw2Kak5mWWpRfp2CVwZp3fqFbxnqTh3YwtLA2MnSxcjJ4eEgInE
        xfOzmbsYuTiEBHYySky/dYkdwvnKKHF54Sw2kCo2ASuJie2rGLsYOThEBEwl/pwIAalhFljM
        JDHj119GkBphgWyJy29eMYHYLAKqEivXLWEFsXkFNCXuzu1iB7FFBbwktuxrZwKZwyngKfHz
        QTXErmOMEi8fHGaHqBeU+DH5Hth1zALyEvv2T2WFsLUk1u88zjSBkX8WkrJZSMpmISlbwMi8
        ilEytaA4Nz232KjAKC+1XK84Mbe4NC9dLzk/dxMjMNi3Hdbq38H4eEn8IUYBDkYlHt6CmF1R
        QqyJZcWVuYcYJTiYlUR432vsjhLiTUmsrEotyo8vKs1JLT7EKM3BoiTOy59/LFJIID2xJDU7
        NbUgtQgmy8TBKdXAeEji8au9h0KOVK+7JZm96U7s9oAJzle/yLR+mTjzcmtJ0YzPJ/JzDq0J
        mjOhU+Ph61QHj2mPPW/McV0obTRL/+WP+DNlsaGntTsb5AuePLf5evfsiZCG//XZQvOXOTq6
        XStcbKE6+9CHDU+L2d6pzfptNXsRf0ZvasY9D7WdbWW6DQdOdKaf/qrEUpyRaKjFXFScCACR
        X4hXcgIAAA==
X-CMS-MailID: 20180328133411epcas2p442e8f8a85d6c6e72ec5a5122519fe5eb
X-Msg-Generator: CA
CMS-TYPE: 102P
X-CMS-RootMailID: 20180328133411epcas2p442e8f8a85d6c6e72ec5a5122519fe5eb
X-RootMTR: 20180328133411epcas2p442e8f8a85d6c6e72ec5a5122519fe5eb
References: <7dcd32b6-9691-14a1-29cf-3a746ef5adfc@users.sourceforge.net>
        <889131fe-199c-3bef-0781-00761b807426@users.sourceforge.net>
        <6341951e-df28-0b40-974e-dedd890b5228@users.sourceforge.net>
        <CGME20180328133411epcas2p442e8f8a85d6c6e72ec5a5122519fe5eb@epcas2p4.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday, January 07, 2018 12:56:45 PM SF Markus Elfring wrote:
> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Sun, 7 Jan 2018 11:33:59 +0100
> 
> Replace an error code for the indication of a memory allocation failure
> in this function.
> 
> Fixes: 1da177e4c3f41524e886b7f1b8a0c1fc7321cac ("Linux-2.6.12-rc2: Initial git repository build")
> Suggested-by: Rolf Eike Beer <eike-kernel@sf-tec.de>
> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>

Patch queued for 4.17, thanks.

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics
