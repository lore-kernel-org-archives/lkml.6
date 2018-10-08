Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FORGED_MUA_MOZILLA,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2BCDC00449
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 10:52:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F92820652
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 10:52:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="BtwATOuX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4F92820652
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727840AbeJHSDF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 14:03:05 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:56499 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726689AbeJHSDF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 14:03:05 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20181008105157euoutp01b311b0c5bbc1e5a42098b313a9cbc5db~bnKILIZD82014020140euoutp01m
        for <linux-kernel@vger.kernel.org>; Mon,  8 Oct 2018 10:51:57 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20181008105157euoutp01b311b0c5bbc1e5a42098b313a9cbc5db~bnKILIZD82014020140euoutp01m
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1538995917;
        bh=+acYHQLpleDp1D0phhyccTbKm3WjhLprLfxNPcnOQCs=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=BtwATOuXvJsd8CUb0d3+h2cvUu5zL5Nirroejab0YX6gr/kpGQS+hkQqgl5PV6pxW
         rwECkme2voSKZTVYV3kQ3rtJmtMkSkZhCtlqLSNVrVCUToMui89spEYRMrzYDIJxp0
         +5RqQFyjBONzvH+ugI7d1Fn+2sqO5hdS5aEb4y9o=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20181008105157eucas1p11c2fe324d4b4b76f7e0f0a31378d5e25~bnKHyfH1B1871418714eucas1p1d;
        Mon,  8 Oct 2018 10:51:57 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id D5.00.04441.CC63BBB5; Mon,  8
        Oct 2018 11:51:56 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20181008105156eucas1p106251d3dc728ce13a4710b94ac02f1ba~bnKHB1gLf1421814218eucas1p1p;
        Mon,  8 Oct 2018 10:51:56 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20181008105156eusmtrp1d09c0170e6e9ca81f268d094e009d983~bnKHA6fE32360223602eusmtrp1w;
        Mon,  8 Oct 2018 10:51:56 +0000 (GMT)
X-AuditID: cbfec7f2-5c9ff70000001159-69-5bbb36cccf45
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 98.67.04128.CC63BBB5; Mon,  8
        Oct 2018 11:51:56 +0100 (BST)
Received: from [106.120.53.102] (unknown [106.120.53.102]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20181008105155eusmtip150b9cfc99c1a10b74856efcd5d94a50f~bnKGv8hpY2714527145eusmtip1S;
        Mon,  8 Oct 2018 10:51:55 +0000 (GMT)
Subject: Re: [PATCH] video: fbdev: sis: Remove unnecessary parentheses and
 commented code
To:     Nathan Chancellor <natechancellor@gmail.com>
Cc:     Thomas Winischhofer <thomas@winischhofer.net>,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
From:   Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Date:   Mon, 8 Oct 2018 12:51:54 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
        Thunderbird/45.3.0
MIME-Version: 1.0
In-Reply-To: <20180920202217.27304-1-natechancellor@gmail.com>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprAKsWRmVeSWpSXmKPExsWy7djP87pnzHZHGzR/0bK48vU9m8WJvg+s
        Fpd3zWGz+PC2xGL1ysfsDqweO2fdZfe4332cyePzJjmPBTP+swSwRHHZpKTmZJalFunbJXBl
        vLr9h71gAVfF7plnWBoYj7F3MXJySAiYSHTefQVmCwmsYJT43anWxcgFZH9hlOia+5wZwvnM
        KPHh4DJWmI51J/ayQnQsZ5R4NZUboug9o8TMv3dYQBLCAtESn3t+M4PYIgIGEi0Hm9hBipgF
        JjJKXJzfAJZgE7CSmNi+ihHEZhFQkdi++zBQMweHqECERP8ZdZAwr4CgxMmZT8BmcgrYSfQs
        +gXWygw088iiOawQtrzE9rdzwC6VEGhnl1jc0sAI0VwmMWfVJairXSTuzbwOZQtLvDq+Bep/
        GYnTk3tYIJqnM0q8+bUUylnPKLHmzDEmiCpricPHL0J1O0osuXSUEeRSCQE+iRtvBSGu4JOY
        tG06M0SYV6KjTQiiWk1iw7INbDC7unauZIawPSTuvzrOMoFRcRaSP2ch+W0Wkt8WMDKvYhRP
        LS3OTU8tNsxLLdcrTswtLs1L10vOz93ECEwnp/8d/7SD8eulpEOMAhyMSjy8KwN2RQuxJpYV
        V+YeYpTgYFYS4RXdDhTiTUmsrEotyo8vKs1JLT7EKM3BoiTOu2zexmghgfTEktTs1NSC1CKY
        LBMHp1QDI9fMZ1lystcqM2d3Lr46LWLrv2lLpARf3om8N4lJnelVx6VbZ5S+3Pigf+1e/5yL
        jiU7uWt4/ZmOesw5qSAQ5lZ9f9Mhz/cuwkxV2us670x+qLIgU6v/1Mb1vzsFU8Iy9Mo7P/ZI
        rH2xyem8+Z1DrId/aXAs2vj+/TW5JP1tEz7+mVEWI8bxbLcSS3FGoqEWc1FxIgAVZ1AwIwMA
        AA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprKIsWRmVeSWpSXmKPExsVy+t/xu7pnzHZHG6ydwm1x5et7NosTfR9Y
        LS7vmsNm8eFticXqlY/ZHVg9ds66y+5xv/s4k8fnTXIeC2b8ZwlgidKzKcovLUlVyMgvLrFV
        ija0MNIztLTQMzKx1DM0No+1MjJV0rezSUnNySxLLdK3S9DLeHX7D3vBAq6K3TPPsDQwHmPv
        YuTkkBAwkVh3Yi9rFyMXh5DAUkaJOSvOMnUxcgAlZCSOry+DqBGW+HOtiw2i5i2jxNGfi5hA
        EsIC0RKfe34zg9giAgYSLQeb2CGKJjJK/Ol/zgaSYAZxGi5ygthsAlYSE9tXMYLYvAJ2Eium
        vmYBsVkEVCS27z4MZosKREjcetjBAlEjKHFy5hMwmxOovmfRL2aImXoSO67/YoWw5SW2v53D
        PIFRcBaSlllIymYhKVvAyLyKUSS1tDg3PbfYSK84Mbe4NC9dLzk/dxMjMEq2Hfu5ZQdj17vg
        Q4wCHIxKPLwrAnZFC7EmlhVX5h5ilOBgVhLhFd0OFOJNSaysSi3Kjy8qzUktPsRoCvTERGYp
        0eR8YATnlcQbmhqaW1gamhubG5tZKInznjeojBISSE8sSc1OTS1ILYLpY+LglGpgZHtzzK3P
        teKdZeCe673ftrxdpJsq2Oe7bZN8cYr/l2/VDjPihM6ejRMpu7N+x1q3Jt6ebE2H794LppYJ
        mHhIv+H9ME1Af8Hyq8eyH3Fwt8WF7MvcEtLz+dZtieUPt3zM3dmy/aDpucJXuvbdDx3XxKxk
        Ec4xWDRdMOA8p49QUd/iE/Nu//7CpcRSnJFoqMVcVJwIAOOZDnKoAgAA
Message-Id: <20181008105156eucas1p106251d3dc728ce13a4710b94ac02f1ba~bnKHB1gLf1421814218eucas1p1p@eucas1p1.samsung.com>
X-CMS-MailID: 20181008105156eucas1p106251d3dc728ce13a4710b94ac02f1ba
X-Msg-Generator: CA
X-RootMTR: 20180920202232epcas2p115e690a9ab4b8d70c2c710addb8fbb1e
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20180920202232epcas2p115e690a9ab4b8d70c2c710addb8fbb1e
References: <CGME20180920202232epcas2p115e690a9ab4b8d70c2c710addb8fbb1e@epcas2p1.samsung.com>
        <20180920202217.27304-1-natechancellor@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 09/20/2018 10:22 PM, Nathan Chancellor wrote:
> Clang warns when multiple pairs of parentheses are used for a single
> conditional statement.
> 
> drivers/video/fbdev/sis/init301.c:851:42: warning: equality comparison
> with extraneous parentheses [-Wparentheses-equality]
>       } else if((SiS_Pr->SiS_IF_DEF_LVDS == 1) /* ||
>                  ~~~~~~~~~~~~~~~~~~~~~~~~^~~~
> drivers/video/fbdev/sis/init301.c:851:42: note: remove extraneous
> parentheses around the comparison to silence this warning
>       } else if((SiS_Pr->SiS_IF_DEF_LVDS == 1) /* ||
>                 ~                        ^   ~
> drivers/video/fbdev/sis/init301.c:851:42: note: use '=' to turn this
> equality comparison into an assignment
>       } else if((SiS_Pr->SiS_IF_DEF_LVDS == 1) /* ||
>                                          ^~
>                                          =
> 1 warning generated.
> 
> Remove the parentheses and while we're at it, clean up the commented
> code, which has been here since the beginning of git history.
> 
> Link: https://github.com/ClangBuiltLinux/linux/issues/118
> Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>

Patch queued for 4.20, thanks.

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics
