Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FD1AC6778A
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 10:48:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 071BF24156
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 10:48:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="WOicj+Jz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 071BF24156
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752816AbeGCKr4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 06:47:56 -0400
Received: from mailout3.samsung.com ([203.254.224.33]:10756 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752552AbeGCKry (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 06:47:54 -0400
Received: from epcas1p2.samsung.com (unknown [182.195.41.46])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20180703104753epoutp03f12e4f416c29a60744c5e27d86c4e073~91h4eW7gG0218102181epoutp035
        for <linux-kernel@vger.kernel.org>; Tue,  3 Jul 2018 10:47:53 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20180703104753epoutp03f12e4f416c29a60744c5e27d86c4e073~91h4eW7gG0218102181epoutp035
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1530614873;
        bh=EWW6JZaAeX9LPP20GR7p0crIRtO3/c3xajacVH9Q/Es=;
        h=Subject:Reply-To:From:To:CC:In-Reply-To:Date:References:From;
        b=WOicj+JzoKLz0S7zHMFUTeA4t+PVT589Xo+b4crN86bpFGGUBgS7ayhB943hH8ja/
         0wZmJVK1mDcsTrKl3Ec+Lehvd33ITYEoiS+GpqEXdCLnqVwMjDyJ9XXkJLKuaUZ2SO
         /OtW+Uy3Im7ose0mF4p/NqAfRHmwuXJSmbgW23qs=
Received: from epsmges1p1.samsung.com (unknown [182.195.40.154]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTP id
        20180703104750epcas1p4352376b18d666b307b9858d8f501211b~91h1q1Ojp0578805788epcas1p4Y;
        Tue,  3 Jul 2018 10:47:50 +0000 (GMT)
X-AuditID: b6c32a35-ba1ff70000000fe2-06-5b3b5456befe
Received: from epcas1p2.samsung.com ( [182.195.41.46]) by
        epsmges1p1.samsung.com (Symantec Messaging Gateway) with SMTP id
        14.E6.04066.6545B3B5; Tue,  3 Jul 2018 19:47:50 +0900 (KST)
Mime-Version: 1.0
Subject: RE: Re: [PATCH v3] PM / devfreq: Fix devfreq_add_device() when
 drivers are built as modules.
Reply-To: myungjoo.ham@samsung.com
From:   MyungJoo Ham <myungjoo.ham@samsung.com>
To:     "akhilpo@codeaurora.org" <akhilpo@codeaurora.org>,
        Ezequiel Garcia <ezequiel@collabora.com>
CC:     Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kernel@collabora.com" <kernel@collabora.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
X-Priority: 3
X-Content-Kind-Code: NORMAL
In-Reply-To: <7c67974e40afd15abfca5907b27de097@codeaurora.org>
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <20180703104749epcms1p473b2160f6e2bbe3c6b87827b30e8473b@epcms1p4>
Date:   Tue, 03 Jul 2018 19:47:49 +0900
X-CMS-MailID: 20180703104749epcms1p473b2160f6e2bbe3c6b87827b30e8473b
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="utf-8"
X-CPGSPASS: Y
X-CPGSPASS: Y
CMS-TYPE: 101P
X-Brightmail-Tracker: H4sIAAAAAAAAA12Sa0hTYRjHeXd2OZNmb9PsRSPXAQMLp2c2d7KsII1VBoLRByXsoKdNcpd2
        NlO/NJVu5m0rTJaWs6iwKLXUk0bRigpq+6DdLIwuEwk1jWkYFrWbGX16f/zf/3PlwTGpXRiL
        F+vNjElPlxDCCH7vw0R50t49G/NTmqYFlKN+VEh9cSVSr2fGBNT1dy5A3emcEVG3PLUCyl01
        IaKG+luElK/uEdgqVg/V1/HU3MgloK6/3QHUvu5VOfw8ZpOWoYsYk4zRFxqKivWaDGJXbsG2
        AmVaCplEbqBUhExP65gMIjM7J2l7cYm/FUJWSpdY/FIOzbJE8uZNJoPFzMi0BtacQeSTpEJO
        pqjkCoX/Td2XrlD6LfsZ7Zi9X2isW1JW/d4msgKPuAaIcQTXI5fbJqwBEbgUcgA1zFRiNQDH
        JXAZ+sVFBTxRUIMefHTyAiyFBLIO38NCejI68aEXBFgIk1BP5wg/wNGQRtXf7IJATgz28VDv
        9DVeqJgENR8f5Yc4DvVd6QkGi+FmdPRnjyikL0fD1yb/8tTjCyDE0ejoezcW4mXow4+BsB6L
        vJPOsP8Ieu1r5wUKI9gI0Pyb3+GPZPTpxTlhgCVwN/Ie44I6HyagienmcKJMNGg9FfRgMB71
        TbYEF4HBRHSzP3mhf2vXvOh/xmAk+jpbK1jQufPe8LxrkGvgUti/Ej076wymRFCNbNO6RrDa
        sbhpxz91HYt12wDWAWIYI6vTMCxpJOUsrWMteo280KDrBsF7XKvkwBlPtgtAHBBLJGXx6flS
        AV3KlutcAOEYES3pTfBLkiK6vIIxGQpMlhKGdQGlf3wbFru80OC/br25gFQqUlNTqfVkmpIk
        iRWSsmGYL4Ua2swcZBgjY1qI4+HiWCtom2g0tuY+2ZnmzrrVcCOC4xwnq+0SsmX8gOeQZibm
        3tJ1Oy52FIPTW+bnTLaX9iq7+e1oYuusbCCrVTXYbqi82hQ9pSVq7/oiYx55nCMVeZcj7a+c
        KncpkXtFrbLo7ntvrtttPMbN7csb801in+Oior53j8c/V3SBp28Ot1wl+KyWJtdiJpb+Aw1w
        OwqlAwAA
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20180622212233epcas2p3308116579442dc8a42a9db7445ce8ef8
References: <7c67974e40afd15abfca5907b27de097@codeaurora.org>
        <20180621220430.25644-1-enric.balletbo@collabora.com>
        <0383b4a703a0b619023c0654a4a7637419c72ebd.camel@collabora.com>
        <addc4280-729f-85d7-a314-35afbb7c8bb1@codeaurora.org>
        <1e792d3c972998f92109c127886243e32c4cde71.camel@collabora.com>
        <CGME20180622212233epcas2p3308116579442dc8a42a9db7445ce8ef8@epcms1p4>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> >> Adding to Ezequiel's point, shouldn't we take more granular lock
> >> (devfreq->lock) first and then call devfreq_list_lock at the time of
> >> adding to the list?
> >> 
> > 
> > Not sure why we should do that. devfreq->lock should be used to
> > protect the struct devfreq state, while the devfreq_list_lock
> > is apparently protecting the two lists (which seem unrelated
> > lists).

Correct.

devfreq->lock protects an instance of devfreq.
devfreq_list_lock protects the global devfreq data (list of devfreq / governors)

> > 
> > So, the two locks are not correlated.
> > 
> > Regards,
> > Eze
> In governor_store(), we do 'df->governor = governor;' without taking 
> df->lock. So it is possible to switch governor while update_devfreq() is 
> in progress.

Yup. that's possible.

> I smell trouble there. Don't you think so?
> I am assuming df->lock protects 'struct devfreq' and devfreq_list_lock 
> protects both device and governor lists.

devfreq_list_lock is not supposed to protect a device.

Assuming a memory read of a word is atomic (I'm not aware of one that's not
unless in a case where the address is unaligned in some archtectures),
update_devfreq won't cause such issues because it reads "devfreq->governor"
only one in its execution except for the null check.

Thus, if there could be an error, it'd be a case where someone else is
doing "devfreq->governor = NULL" without devfreq->lock.
And, find_devfreq_governor() does not return NULL.


Cheers,
MyungJoo

> 
> -Akhil.
> 
