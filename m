Return-Path: <SRS0=LZPJ=LZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FORGED_MUA_MOZILLA,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4D10C6778D
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 08:47:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 45DBD20839
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 08:47:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="KaM0hMSD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 45DBD20839
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726933AbeIKNp4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Sep 2018 09:45:56 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:32909 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726569AbeIKNp4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Sep 2018 09:45:56 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20180911084738euoutp015df25f9f8e0701bc6243b1cdb6c3171f~TTC3t767j1268412684euoutp01d
        for <linux-kernel@vger.kernel.org>; Tue, 11 Sep 2018 08:47:38 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20180911084738euoutp015df25f9f8e0701bc6243b1cdb6c3171f~TTC3t767j1268412684euoutp01d
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1536655658;
        bh=VpcFTL8j7C6QCEiHBtPHWMfBO37R51CLx90wOkGyjYw=;
        h=Subject:To:From:Date:In-Reply-To:References:From;
        b=KaM0hMSDfCJACt/Xy7VuuY+5Ia9EbEPq59IFyNLZcbnFO5lOFfkmXWoUBvNXmDKYt
         B2NF2B7kExIOeuyOUjMLU3ZOLZuy2vvf9qBoQoEz180D4/7X7jiYJivr0rLiwgGSaj
         ca6f4vWWd/5ON10C5jlUAKTPwc/s+xyFt5MMbs4k=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20180911084736eucas1p27b05c99f04f1daa70ce3b492961e4e23~TTC2sLXrF3003330033eucas1p2Z;
        Tue, 11 Sep 2018 08:47:36 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id 7F.33.04806.821879B5; Tue, 11
        Sep 2018 09:47:36 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20180911084736eucas1p1e7f98eb3bc4e30bdc1041744fc7fc7a6~TTC14JPXa1980019800eucas1p1O;
        Tue, 11 Sep 2018 08:47:36 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20180911084735eusmtrp123eb14a16a92d4e1c3109c4388a4d938~TTC1mdrpq0800308003eusmtrp16;
        Tue, 11 Sep 2018 08:47:35 +0000 (GMT)
X-AuditID: cbfec7f5-367ff700000012c6-a5-5b9781287d63
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 0C.73.04128.721879B5; Tue, 11
        Sep 2018 09:47:35 +0100 (BST)
Received: from [106.120.53.102] (unknown [106.120.53.102]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20180911084735eusmtip2054d5483afbb82c39c51f3d10de4e98f~TTC1DLryn2255422554eusmtip2w;
        Tue, 11 Sep 2018 08:47:35 +0000 (GMT)
Subject: Re: [PATCH 1/4] fbdev: Drop FBINFO_CAN_FORCE_OUTPUT flag
To:     DRI Development <dri-devel@lists.freedesktop.org>,
        Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ben Skeggs <bskeggs@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Alexander Kapshuk <alexander.kapshuk@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        Thierry Reding <treding@nvidia.com>,
        David Lechner <david@lechnology.com>,
        nouveau@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        Daniel Vetter <daniel.vetter@intel.com>
From:   Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Date:   Tue, 11 Sep 2018 10:47:34 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
        Thunderbird/45.3.0
MIME-Version: 1.0
In-Reply-To: <20180911074228.GI19774@phenom.ffwll.local>
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrPKsWRmVeSWpSXmKPExsWy7djPc7oajdOjDd58ULLYdvIYu8XL5R2M
        FsvPrGO2WNQgZnHl63s2i+bF69ks3hyfzmQxe8JmJosz3bkWJ/o+sFpc3jWHzeJ7Xx+rxe3f
        fA68HrMbLrJ47Jx1l91j8Z6XTB6f+k+yeuyfu4bd4373cSaP3uZ3bB7v911l8/i8SS6AM4rL
        JiU1J7MstUjfLoErY8Xa00wFB3gqNn66y97AuJuri5GTQ0LARGLewZfsXYxcHEICKxgluo7P
        hnK+MEp8ftbPDOF8ZpTYdWsFO0zL1gMbWSASyxklJrfMhnLeM0osOb+IDaRKWMBRYuKHj4wg
        tojAQhaJTT/5QGw2ASuJie2rwOIsAqoSr/e2Ak3l4BAViJDoP6MOEuYVEJQ4OfMJC4jNKWAh
        se/aGbDFzALyEtvfzgG7SELgHrvE79mzWSEayiReX/nEDHGdi8SKAw8YIWxhiVfHt0BdLSNx
        enIPC0TzdEaJN7+WQjnrGSXWnDnGBFFlLXH4+EVWkIuYBTQl1u/Shwg7Spy6dZQFJCwhwCdx
        460gxEF8EpO2TWeGCPNKdLQJQVSrSWxYtoENZm3XzpVQp3lI7Lx9jRESVquYJLbdm8Y8gVFh
        FpKfZyH5cxbCEQsYmVcxiqeWFuempxYb56WW6xUn5haX5qXrJefnbmIEJrPT/45/3cG470/S
        IUYBDkYlHt4LWdOihVgTy4orcw8xSnAwK4nw7tIBCvGmJFZWpRblxxeV5qQWH2KU5mBREufl
        00qLFhJITyxJzU5NLUgtgskycXBKNTB2SNx3P6h0k5X3aVpqpw17fp/efecga9t/77dPXiqx
        026nQcVCnyVxT8LMZ302ydTUKbK3DHnHUmR6YJ82e5HQDvf4El5P45eX0w1eP5pZaT/10s/X
        e717OxbuPbSicP2FhFcXgm601pzSXtj64YCGpS3bzTneixZdPzBpf+BD3xtCuStS7N4rsRRn
        JBpqMRcVJwIATYRcR2IDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrJIsWRmVeSWpSXmKPExsVy+t/xe7rqjdOjDbZd1LDYdvIYu8XL5R2M
        FsvPrGO2WNQgZnHl63s2i+bF69ks3hyfzmQxe8JmJosz3bkWJ/o+sFpc3jWHzeJ7Xx+rxe3f
        fA68HrMbLrJ47Jx1l91j8Z6XTB6f+k+yeuyfu4bd4373cSaP3uZ3bB7v911l8/i8SS6AM0rP
        pii/tCRVISO/uMRWKdrQwkjP0NJCz8jEUs/Q2DzWyshUSd/OJiU1J7MstUjfLkEvY8Xa00wF
        B3gqNn66y97AuJuri5GTQ0LARGLrgY0sXYxcHEICSxklDi0+ydTFyAGUkJE4vr4MokZY4s+1
        LjaImreMEqsfvGMBSQgLOEpM/PCRESQhIrCYReL7yvesEFWrmCQOPNvNBlLFJmAlMbF9FSOI
        zStgJ/H4RxNYnEVAVeL13lZ2EFtUIELi1sMOFogaQYmTM5+A2ZwCFhL7rp0Bq2EWUJf4M+8S
        M4QtL7H97RzmCYwCs5C0zEJSNgtJ2QJG5lWMIqmlxbnpucVGesWJucWleel6yfm5mxiB0bjt
        2M8tOxi73gUfYhTgYFTi4b2QNS1aiDWxrLgy9xCjBAezkgjvLh2gEG9KYmVValF+fFFpTmrx
        IUZToCcmMkuJJucDE0VeSbyhqaG5haWhubG5sZmFkjjveYPKKCGB9MSS1OzU1ILUIpg+Jg5O
        qQZGuzPnJrpnXaq38qs/n73h8s+6CdPn7Z7UarvkkJlne+OO+96ubye33l3boPck+K+Bz5sJ
        GwXf9nMuKusI1t8uESagXBfS7sOQyc3ZbLPFJzq+/cqGNXtEXtWFxs8Rr/18seyFr7+AeOvM
        2UW/XJ9sObhcMmPpzR8LmmrXn8vb7vdFOstww/GLSizFGYmGWsxFxYkAEk5mQtwCAAA=
Message-Id: <20180911084736eucas1p1e7f98eb3bc4e30bdc1041744fc7fc7a6~TTC14JPXa1980019800eucas1p1O@eucas1p1.samsung.com>
X-CMS-MailID: 20180911084736eucas1p1e7f98eb3bc4e30bdc1041744fc7fc7a6
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20180822085418epcas5p30ab8aa4b49ba204f4891760af002bce1
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20180822085418epcas5p30ab8aa4b49ba204f4891760af002bce1
References: <CGME20180822085418epcas5p30ab8aa4b49ba204f4891760af002bce1@epcas5p3.samsung.com>
        <20180822085405.10787-1-daniel.vetter@ffwll.ch>
        <20180910124845eucas1p1b51674cd657757aadf5138e277e57ebe~TCsHYsLqt1779917799eucas1p18@eucas1p1.samsung.com>
        <20180911074228.GI19774@phenom.ffwll.local>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/11/2018 09:42 AM, Daniel Vetter wrote:
> On Mon, Sep 10, 2018 at 02:48:43PM +0200, Bartlomiej Zolnierkiewicz wrote:
>>
>> On 08/22/2018 10:54 AM, Daniel Vetter wrote:
>>> This was only added for the drm's fbdev emulation support, so that it
>>> would try harder to show the Oops.
>>>
>>> Unfortunately this never really worked reliably, and in practice ended
>>> up pushing the real Oops off the screen due to plentyfull locking,
>>> sleep-while-atomic and other issues. So we removed all that support
>>> from the fbdev emulation a while back. Aside: We've also removed the
>>> kgdb support, for similar reasons.
>>>
>>> Since it's such a small patch I figured I don't split this up into the
>>> usual 3-phase removal.
>>>
>>> Cc: Ben Skeggs <bskeggs@redhat.com>
>>> Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
>>> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>>> Cc: Hans de Goede <hdegoede@redhat.com>
>>> Cc: Daniel Vetter <daniel.vetter@ffwll.ch>
>>> Cc: Alexander Kapshuk <alexander.kapshuk@gmail.com>
>>> Cc: Kees Cook <keescook@chromium.org>
>>> Cc: Thierry Reding <treding@nvidia.com>
>>> Cc: David Lechner <david@lechnology.com>
>>> Cc: nouveau@lists.freedesktop.org
>>> Cc: linux-fbdev@vger.kernel.org
>>> Signed-off-by: Daniel Vetter <daniel.vetter@intel.com>
>>
>> Acked-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
> 
> Ack for merging the entire series through drm-misc-next?

Yes, thanks for taking care of this.

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics
