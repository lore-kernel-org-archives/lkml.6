Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753705AbeC1O1J (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Mar 2018 10:27:09 -0400
Received: from mailout2.samsung.com ([203.254.224.25]:29496 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753199AbeC1O1H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Mar 2018 10:27:07 -0400
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20180328142704epoutp02a950d32595960cda32550fbc49260176~gG8khJsb33167231672epoutp02d
X-AuditID: b6c32a46-b6dff70000000fe8-99-5abba63816f0
From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
To: SF Markus Elfring <elfring@users.sourceforge.net>
Cc: linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH 2/3] video: au1100fb: Improve a size determination in
 au1100fb_drv_probe()
Date: Wed, 28 Mar 2018 16:27:01 +0200
Message-id: <2447043.1duYbrvBpc@amdc3058>
User-Agent: KMail/4.13.3 (Linux/3.13.0-96-generic; KDE/4.13.3; x86_64; ; )
In-reply-to: <231de972-f0bf-18ce-e681-a29767c086ea@users.sourceforge.net>
MIME-version: 1.0
Content-transfer-encoding: 7Bit
Content-type: text/plain; charset="us-ascii"
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrBIsWRmVeSWpSXmKPExsWy7bCmua7Fst1RBn3trBZXvr5nszjfuZzZ
        YustaYsTfR9YLS7vmsPmwOpxv/s4k0fTqXZWj8+b5AKYo7hsUlJzMstSi/TtErgyzs7+ylow
        k7Viz/GpTA2MC1i6GDk5JARMJP4tnMbYxcjFISSwg1Hi1PlVTBDOd0aJF8vms8FUXdt8jR0i
        sYFR4vuLm2wQzldGibVnFrGCVLEJWElMbF8FNIuDQ0TAVOLPiRCQGmaBDkaJjcengO0TFkiQ
        eLX5DyOIzSKgKjFl9mN2EJtXQFPi+bIjTCC2qICXxJZ97WA2p4CnxO8Hm6FqBCV+TL4HNodZ
        QF5i3/6prBC2jsTZY+vAfpAQWMAmcePMBEaIs10klnVvh3pBWOLV8S3sELa0xLNVG6Eamhkl
        vu3YwwyRmMAosWe9EIRtLXH4+EWoDXwSHYf/soN8JiHAK9HRBlXiIdH7czLULkeJh5+3QIPo
        NqPEu0+LWSYwys5CcvgsJIfPQnL4AkbmVYxiqQXFuempxUYFRnrFibnFpXnpesn5uZsYwfGv
        5baDcck5n0OMAhyMSjy8Fot2RwmxJpYVV+YeYpTgYFYS4X2vARTiTUmsrEotyo8vKs1JLT7E
        KM3BoiTO2xrgEiUkkJ5YkpqdmlqQWgSTZeLglGpgZCtjOz/5zYrKCNGVhx8eD5/z9HfWs0dO
        ioV+wiHzBT+t+yggZfDcTl/rvNP2XHUbl/DtbybP/3di+t+rr2XKg6JnsBa2HbEyXCF/ILew
        Ufr0dV+JSyvbGc8VRE2yav632jU+xnnOufTX80+Xa2yX6ru26uLKlZ/d/3E8Epp5+mmL7k5P
        xrbmPiWW4oxEQy3mouJEACWy/6X7AgAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrALMWRmVeSWpSXmKPExsVy+t9jQV3zZbujDDYdUba48vU9m8X5zuXM
        FltvSVuc6PvAanF51xw2B1aP+93HmTyaTrWzenzeJBfAHMVlk5Kak1mWWqRvl8CVcXb2V9aC
        mawVe45PZWpgXMDSxcjJISFgInFt8zX2LkYuDiGBdYwSF6ZfgnK+Mkocm7idFaSKTcBKYmL7
        KsYuRg4OEQFTiT8nQkBqmAU6GCUm/lvCDFIjLJAg8WrzH0YQm0VAVWLK7MfsIDavgKbE82VH
        mEBsUQEviS372sFsTgFPid8PNkMtu80o0TmtgQWiQVDix+R7YDazgLzEvv1TWSFsLYn1O48z
        TWDkn4WkbBaSsllIyhYwMq9ilEwtKM5Nzy02KjDKSy3XK07MLS7NS9dLzs/dxAgM122Htfp3
        MD5eEn+IUYCDUYmH12LR7igh1sSy4srcQ4wSHMxKIrzvNYBCvCmJlVWpRfnxRaU5qcWHGKU5
        WJTEefnzj0UKCaQnlqRmp6YWpBbBZJk4OKUaGFlMzSYqi/5SyWG5L8S6ZvJ35WreX6mfX7n+
        Ebyxy/Ka8D3VEuGvR3sumdiY7mTdVV9yk53ryNaFDMnZu4XC/vx3zZi3snsFg8Bnd/dTtxly
        7i9sPVZ+8/Yt9xObr698vf+P6GP/bWxq0oc8tvMEllrq/u0Rncl2bGddrExevc4H04J+laml
        aUosxRmJhlrMRcWJAPyAlnhTAgAA
X-CMS-MailID: 20180328142703epcas2p39e411eef517caa92f77ed4b2861898d5
X-Msg-Generator: CA
CMS-TYPE: 102P
X-CMS-RootMailID: 20171127180003epcas3p1a6c7cbe1be9bee79555a0e7f05b28024
X-RootMTR: 20171127180003epcas3p1a6c7cbe1be9bee79555a0e7f05b28024
References: <980dc009-429b-ad88-966b-0e75808cbacc@users.sourceforge.net>
        <CGME20171127180003epcas3p1a6c7cbe1be9bee79555a0e7f05b28024@epcas3p1.samsung.com>
        <231de972-f0bf-18ce-e681-a29767c086ea@users.sourceforge.net>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday, November 27, 2017 06:59:57 PM SF Markus Elfring wrote:
> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Mon, 27 Nov 2017 18:18:34 +0100
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
