Return-Path: <SRS0=VkHl=QP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A0F0C169C4
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 17:25:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3FC7020855
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 17:25:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="mpE1oWYo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727643AbfBHRZO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Feb 2019 12:25:14 -0500
Received: from mailout2.w1.samsung.com ([210.118.77.12]:52204 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726522AbfBHRZN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Feb 2019 12:25:13 -0500
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20190208172511euoutp025f884065d9aaf2cfc512f26a37ddd8f9~Bc3ljm37l2005220052euoutp02D
        for <linux-kernel@vger.kernel.org>; Fri,  8 Feb 2019 17:25:11 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20190208172511euoutp025f884065d9aaf2cfc512f26a37ddd8f9~Bc3ljm37l2005220052euoutp02D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1549646712;
        bh=G2rVGDN7z5nw/lxbw9ooUmGtDE/shZTqpsdxaRQKquY=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=mpE1oWYo7G7Y1YfX/L3kX4lhGrEUZVTYfqM2eC+KCmE+oB1I7Eu+md9xbCJEu3g/9
         w78dH3p3OrhyQYj7sa6dRIi+v2Pm4WMVn4EoaQtxVmtmM0HZk3p07/5XikVsSgxLr1
         GbNpWveCWNaWzfOdhd43pZ83fWhnqwdx72tQDzOA=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20190208172511eucas1p11d3c09d74ca342877657b0c02251ea1c~Bc3lRIL3h0238602386eucas1p1x;
        Fri,  8 Feb 2019 17:25:11 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id 2D.8D.04294.77BBD5C5; Fri,  8
        Feb 2019 17:25:11 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20190208172510eucas1p1c7af38b36bfea59a3257092113a88b04~Bc3kmkCBs2285622856eucas1p1R;
        Fri,  8 Feb 2019 17:25:10 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20190208172510eusmtrp2eb1c9744de49659fbb489fa2e20dcc4c~Bc3kYWRAN0898008980eusmtrp2L;
        Fri,  8 Feb 2019 17:25:10 +0000 (GMT)
X-AuditID: cbfec7f4-84fff700000010c6-5f-5c5dbb77d07d
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id DD.E4.04284.67BBD5C5; Fri,  8
        Feb 2019 17:25:10 +0000 (GMT)
Received: from [106.120.53.102] (unknown [106.120.53.102]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20190208172510eusmtip28b8988a547c85cb466ff94069b3e809d~Bc3kEWUwE1721017210eusmtip2C;
        Fri,  8 Feb 2019 17:25:10 +0000 (GMT)
Subject: Re: [PATCH] fbdev: omap2: no need to check return value of
 debugfs_create functions
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org,
        dri-devel@lists.freedesktop.org
From:   Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Message-ID: <5ad3b534-e673-9ff4-e171-a12445694938@samsung.com>
Date:   Fri, 8 Feb 2019 18:25:09 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
        Thunderbird/45.3.0
MIME-Version: 1.0
In-Reply-To: <20190122152151.16139-15-gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprOKsWRmVeSWpSXmKPExsWy7djP87rlu2NjDP5/lbC48vU9m0Xz4vVs
        Fif6PrBaXN41h81i9pJ+Fov3nzqZHNg8Nq3qZPPYP3cNu8f97uNMHp83yQWwRHHZpKTmZJal
        FunbJXBl9L74zFQwn7ViZc8CxgbGLSxdjJwcEgImEtN7T7F1MXJxCAmsYJS4ePUkC4TzhVGi
        f/V6JgjnM6PE6d1n4FqaV7SyQiSWM0o8PNfPCOG8Z5RY9e4YUBUHh7BAnMTpY0UgDSICxhL9
        Z2exg9QwC2xilFjZv48ZJMEmYCUxsX0VI4jNK2AnsfJ4ByuIzSKgInF1xV0mkDmiAhES/WfU
        IUoEJU7OfAJ2BKeAo8TS62vBbGYBA4kji+awQtjyEtvfzmEG2SUhMJldYtX29awQV7tIXLrQ
        wwRhC0u8Or6FHcKWkfi/cz4TRMN0Rok3v5ayQDjrGSXWnDkG1WEtcfj4RahJjhILll8Eu05C
        gE/ixltBiM18EpO2TWeGCPNKdLQJQVSrSWxYtoENZlfXzpXMELaHxLqtxxknMCrOQvLbLCT/
        zELyzwJG5lWM4qmlxbnpqcVGeanlesWJucWleel6yfm5mxiByeX0v+NfdjDu+pN0iFGAg1GJ
        hzeiJTZGiDWxrLgy9xCjBAezkgjvwe1AId6UxMqq1KL8+KLSnNTiQ4zSHCxK4rzVDA+ihQTS
        E0tSs1NTC1KLYLJMHJxSDYyhIUEfz30W5wqoLi4sS/HoudfLbOG595X/5rzfK/7+1z6yR1bi
        jHNHToduykUx3imi289V5/lvZJjS+Ur7h6bY+dMBKyavqfi/4pKX+gFxVlfe+cFJl50KwvdP
        3HK01D5nN/MdiTNdTmYJLXfDs5bd8I1lm3lyuXkxU9mLbdaJLI8qmB7c0VZiKc5INNRiLipO
        BADEokaIKgMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprNIsWRmVeSWpSXmKPExsVy+t/xe7plu2NjDB7t0LS48vU9m0Xz4vVs
        Fif6PrBaXN41h81i9pJ+Fov3nzqZHNg8Nq3qZPPYP3cNu8f97uNMHp83yQWwROnZFOWXlqQq
        ZOQXl9gqRRtaGOkZWlroGZlY6hkam8daGZkq6dvZpKTmZJalFunbJehl9L74zFQwn7ViZc8C
        xgbGLSxdjJwcEgImEs0rWlm7GLk4hASWMkq8e/cXyOEASshIHF9fBlEjLPHnWhcbRM1bRonJ
        d6cyg9QIC8RJnD5WBFIjImAs0X92FjtEzRRGif6urWBDmQW2MEq0Lp3KBFLFJmAlMbF9FSOI
        zStgJ7HyeAcriM0ioCJxdcVdsBpRgQiJWw87WCBqBCVOznwCZnMKOEosvb4WzGYW0JPYcf0X
        K4QtL7H97RzmCYyCs5C0zEJSNgtJ2QJG5lWMIqmlxbnpucWGesWJucWleel6yfm5mxiBEbPt
        2M/NOxgvbQw+xCjAwajEw8vQFBsjxJpYVlyZe4hRgoNZSYT34HagEG9KYmVValF+fFFpTmrx
        IUZToCcmMkuJJucDozmvJN7Q1NDcwtLQ3Njc2MxCSZz3vEFllJBAemJJanZqakFqEUwfEwen
        VAOj0DvZu+zbqq8/qL00ZVpOYvZTTq55lseWrrm8p8q7wf3Zh92lpp97H4XJvNzzvf3jssk8
        vGYMGobWmufEGVdt4+Aq//E66nutNNv3YImV3rvef/I83rDsehyb04nCH/vZzG6saGHQ0+Dc
        tmKq8U7JVe8+VTNGrhOxqY/PTPd5oBmRrr7qghqvEktxRqKhFnNRcSIAPmsWUq4CAAA=
X-CMS-MailID: 20190208172510eucas1p1c7af38b36bfea59a3257092113a88b04
X-Msg-Generator: CA
X-RootMTR: 20190122152306epcas4p1c240839621d10e97226c657457805ea4
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190122152306epcas4p1c240839621d10e97226c657457805ea4
References: <CGME20190122152306epcas4p1c240839621d10e97226c657457805ea4@epcas4p1.samsung.com>
        <20190122152151.16139-15-gregkh@linuxfoundation.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 01/22/2019 04:21 PM, Greg Kroah-Hartman wrote:
> When calling debugfs functions, there is no need to ever check the
> return value.  The function can work or not, but the code logic should
> never do something different based on this.
> 
> Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
> Cc: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
> Cc: linux-omap@vger.kernel.org
> Cc: linux-fbdev@vger.kernel.org
> Cc: dri-devel@lists.freedesktop.org
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

Patch queued for v5.1, thanks.

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics
