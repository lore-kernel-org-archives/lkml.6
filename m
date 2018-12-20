Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56B93C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 17:38:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 20E992186A
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 17:38:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="RCkDVDdK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388027AbeLTRiC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 12:38:02 -0500
Received: from mailout2.w1.samsung.com ([210.118.77.12]:40182 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387915AbeLTRiB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 12:38:01 -0500
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20181220173759euoutp02ca3e145a0965d82e2e68b676a82ab525~yGyebo3D33229332293euoutp02Z
        for <linux-kernel@vger.kernel.org>; Thu, 20 Dec 2018 17:37:59 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20181220173759euoutp02ca3e145a0965d82e2e68b676a82ab525~yGyebo3D33229332293euoutp02Z
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1545327479;
        bh=eLby3E+NySR4bAc7cx4VcZXycptpeYcrwo/YVkNknfA=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=RCkDVDdK8zXxdF6zJqDeUYav+d9wWQjhnGRwZ5275DfZ4id7562Nwg5v5sv6a3yFq
         4Aq9tVfrTpwNqTO5ZYGlLVEf+/S/jjdmPr1rCeSE06K9dpc6q7PhS57lv1JrKdW056
         +P+VrEj37x1J4lHtDWTxhUemZc7DiCkNccEP2B9k=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20181220173758eucas1p16823901212d1ed410a18438ac03bd9a2~yGyeD4uSk1130711307eucas1p1O;
        Thu, 20 Dec 2018 17:37:58 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id E4.7A.04806.673DB1C5; Thu, 20
        Dec 2018 17:37:58 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20181220173757eucas1p266756c952503d02d445160b804d3a030~yGydOGQqS1197111971eucas1p2E;
        Thu, 20 Dec 2018 17:37:57 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20181220173757eusmtrp168d072ffc6cb42d548b059e83a8f1b19~yGyc-6SH_0360803608eusmtrp1d;
        Thu, 20 Dec 2018 17:37:57 +0000 (GMT)
X-AuditID: cbfec7f5-34dff700000012c6-c6-5c1bd3767651
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 17.3A.04284.573DB1C5; Thu, 20
        Dec 2018 17:37:57 +0000 (GMT)
Received: from [106.120.53.102] (unknown [106.120.53.102]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20181220173757eusmtip2b141f776dda9d51b50ca5d724364c6ed~yGycyCC_S1928119281eusmtip2Z;
        Thu, 20 Dec 2018 17:37:57 +0000 (GMT)
Subject: Re: [PATCH 1/2] fbdev: fbmem: make fb_show_logo_line return the end
 instead of the height
To:     Peter Rosin <peda@axentia.se>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>
From:   Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Message-ID: <a4130c72-a9db-18d4-aea4-ccebed91b85d@samsung.com>
Date:   Thu, 20 Dec 2018 18:37:56 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
        Thunderbird/45.3.0
MIME-Version: 1.0
In-Reply-To: <20181126215725.2548-2-peda@axentia.se>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmplleLIzCtJLcpLzFFi42LZduzned2yy9IxBnufCltc+fqezeJE3wdW
        i8u75rBZ7D00n9GBxWPagdnsHve7jzN5fN4kF8AcxWWTkpqTWZZapG+XwJXx++FXtoJFzBUL
        Xwg3MF5l6mLk5JAQMJH4+WAxWxcjF4eQwApGiZmbz7JDOF8YJZ5/PswC4XxmlJj+bCoLTMun
        s9ugEssZJSZv3gvV/55R4v7pU0D9HBzCAikSly8ogjSICChKLNg1ixmkhlngOKPE9nl32UAS
        bAJWEhPbVzGC2LwCdhJrdpxjBrFZBFQl5t2fzAIyR1QgQqL/jDpEiaDEyZlPwMKcQEfsPuAC
        EmYWMJA4smgOK4QtL7H97RywVRICzewSsz6uZAWplxBwkXjyqwLifmGJV8e3sEPYMhKnJ/ew
        QNRPZ5R482splLOeUWLNmWPQQLKWOHz8IiuE7Shx8doEZoihfBI33gpCLOaTmLRtOlSYV6Kj
        TQiiWk1iw7INbDC7unauZIawPSSePF3EPoFRcRaSz2YheWcWkncWMDKvYhRPLS3OTU8tNs5L
        LdcrTswtLs1L10vOz93ECEwcp/8d/7qDcd+fpEOMAhyMSjy8GrukY4RYE8uKK3MPMUpwMCuJ
        8K4/BBTiTUmsrEotyo8vKs1JLT7EKM3BoiTOW83wIFpIID2xJDU7NbUgtQgmy8TBKdXAmBfx
        7aMcy8IOI/74kqcil4SWvz/l3xvw7e/mL4ZmPvJ3zu3yVqu8tuJ4yvzSgvxM/YjXtjsiF6UW
        qZQpXM6aOHflnschblJxt8qj/ebcYLNsVnq9sU3bwSiYc927tq89K1bcj2wTqroqsM2mePnJ
        RywdzTuOrUqcLVrH8PzKDX6fnEwx28ojSizFGYmGWsxFxYkAweWdBhgDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupkkeLIzCtJLcpLzFFi42I5/e/4Pd3Sy9IxBlMWyltc+fqezeJE3wdW
        i8u75rBZ7D00n9GBxWPagdnsHve7jzN5fN4kF8AcpWdTlF9akqqQkV9cYqsUbWhhpGdoaaFn
        ZGKpZ2hsHmtlZKqkb2eTkpqTWZZapG+XoJfx++FXtoJFzBULXwg3MF5l6mLk5JAQMJH4dHYb
        SxcjF4eQwFJGiRPzd7B2MXIAJWQkjq8vg6gRlvhzrYsNxBYSeMsocXhXKUiJsECKxOULiiBh
        EQFFiQW7ZjFDjNnIKNE5aQkriMMscJxR4suHeSwgVWwCVhIT21cxgti8AnYSa3acYwaxWQRU
        JebdnwxWIyoQIXHrYQcLRI2gxMmZT1hAlnECHbr7gAtImFlAT2LH9V+sELa8xPa3c5gnMArO
        QtIxC0nZLCRlCxiZVzGKpJYW56bnFhvqFSfmFpfmpesl5+duYgRGw7ZjPzfvYLy0MfgQowAH
        oxIPr8Yu6Rgh1sSy4srcQ4wSHMxKIrzrDwGFeFMSK6tSi/Lji0pzUosPMZoC/TCRWUo0OR8Y
        qXkl8YamhuYWlobmxubGZhZK4rznDSqjhATSE0tSs1NTC1KLYPqYODilGhhFnCvqU+I23ePU
        O3okycHq/uRF2zNNtR5u/H3t7+uH8w8WuOz7cUJp9q8ZtYe9Vm1U/KC7QUVDz1JrW+Kr39vv
        fL7/+IKAdUD3Se9nLxse63++Jt1tnPV6jgvv8W2FDypXc3jcfB06h+GhsYrU60cx1kfsv3ZP
        7i1qCVC5yMlm6nm4pT3m6/WfSizFGYmGWsxFxYkAUTuScJwCAAA=
X-CMS-MailID: 20181220173757eucas1p266756c952503d02d445160b804d3a030
X-Msg-Generator: CA
X-RootMTR: 20181126215801epcas4p3216f5eb0dda773f3a0ea16ee581a318e
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20181126215801epcas4p3216f5eb0dda773f3a0ea16ee581a318e
References: <20181126215725.2548-1-peda@axentia.se>
        <CGME20181126215801epcas4p3216f5eb0dda773f3a0ea16ee581a318e@epcas4p3.samsung.com>
        <20181126215725.2548-2-peda@axentia.se>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 11/26/2018 10:57 PM, Peter Rosin wrote:
> In preparation for allowing centering of the bootup logo, make
> fb_show_logo_line return where the next free framebuffer line is,
> instead of returning the height of the shown logo.
> 
> Signed-off-by: Peter Rosin <peda@axentia.se>

Patch queued for 4.21, thanks.

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics
