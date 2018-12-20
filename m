Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05952C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 16:57:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B8B4D20815
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 16:57:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="eHkB1H4y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733095AbeLTQ5r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 11:57:47 -0500
Received: from mailout1.w1.samsung.com ([210.118.77.11]:38655 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732563AbeLTQ5q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 11:57:46 -0500
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20181220165745euoutp018a42291c9e0ff8054972cebc26b14a7f~yGPWlto5X0205702057euoutp01S
        for <linux-kernel@vger.kernel.org>; Thu, 20 Dec 2018 16:57:45 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20181220165745euoutp018a42291c9e0ff8054972cebc26b14a7f~yGPWlto5X0205702057euoutp01S
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1545325065;
        bh=RCuF4m0yqtwV7CmWsYoJ6WFf6FClVYUN+YFR8iVnO84=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=eHkB1H4y5LSamPKCO4lCXde9QJTHP5QH3TApi/w0Z8qETAMCuBnRJUrPUaFX5XKVj
         UAI+TK8+5uuALdTa0yZHx246XKTfnn0eFogGdLSqZaXz3OGqtXly6B8KN6otHB2ION
         cK3jLFSPaEk2Jn0B6+mJ4zH6nwyjfGTDyAHjbv4w=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20181220165744eucas1p14c7bc4a55c03d97d5623840cf9bce5ef~yGPWBd7ov3181531815eucas1p1f;
        Thu, 20 Dec 2018 16:57:44 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id A7.4C.04441.80ACB1C5; Thu, 20
        Dec 2018 16:57:44 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20181220165744eucas1p14b9208ef80078c1be55eb961ffdb53aa~yGPVQ-xlp2582925829eucas1p1J;
        Thu, 20 Dec 2018 16:57:44 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20181220165743eusmtrp1825029cff05b588357bae8104a47c257~yGPVCpCKz2333623336eusmtrp1X;
        Thu, 20 Dec 2018 16:57:43 +0000 (GMT)
X-AuditID: cbfec7f2-5c9ff70000001159-a6-5c1bca085e77
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 5C.EC.04128.70ACB1C5; Thu, 20
        Dec 2018 16:57:43 +0000 (GMT)
Received: from [106.120.53.102] (unknown [106.120.53.102]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20181220165743eusmtip29a73c9ea8cb81045545387928200114e~yGPUp4lwx0790807908eusmtip2j;
        Thu, 20 Dec 2018 16:57:43 +0000 (GMT)
Subject: Re: [PATCH v2 -next] video: fbdev: pxafb: Fix
 "WARNING: invalid free of devm_ allocated data"
To:     YueHaibing <yuehaibing@huawei.com>
Cc:     daniel@zonque.org, robert.jarzmik@free.fr,
        linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org,
        dri-devel@lists.freedesktop.org, stable@kernel.org
From:   Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Message-ID: <bb0e51ad-eb6d-7adf-34e5-8e9959081c26@samsung.com>
Date:   Thu, 20 Dec 2018 17:57:42 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
        Thunderbird/45.3.0
MIME-Version: 1.0
In-Reply-To: <20181119013642.18080-1-yuehaibing@huawei.com>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrKKsWRmVeSWpSXmKPExsWy7djPc7ocp6RjDPb1KFk0/X3FYnHl63s2
        ixN9H1gtLu+aw2Yx642wxafzF9gs7nx9zuLA7tG/7jOrR8uRt6wem1Z1snnc7z7O5PF5k5zH
        9t3LWQLYorhsUlJzMstSi/TtErgyPp1ezlpwhqXixJWDLA2M75i7GDk4JARMJBY88epi5OIQ
        EljBKNH8+TQbhPOFUWL+vRnsEM5nRol1M98DdXCCdexf/YwRIrGcUWLLy8nMEM57Ronl7xrY
        QKqEBTIkfr+ZC2aLCKhJtJzaAlbELLCAUeL83huMIAk2ASuJie2rwGxeATuJ37uvs4DYLAKq
        EpferWUEOVBUIEKi/4w6RImgxMmZT8BKOAWsJVaduQJ2EbOAgcSRRXNYIWx5ie1v54DtkhBY
        xy7x5fBqNoizXSQa+5dA2cISr45vYYewZSROT+5hgWiYzijx5tdSKGc9o8SaM8eYIKqsJQ4f
        v8gKYTtKTLx1gAUSfHwSN94KQmzmk5i0bTo0VHklOtqEIKrVJDYs28AGs6tr50poMHpIvLz5
        n3UCo+IsJL/NQvLPLCT/LGBkXsUonlpanJueWmyYl1quV5yYW1yal66XnJ+7iRGYeE7/O/5p
        B+PXS0mHGAU4GJV4eC9sl44RYk0sK67MPcQowcGsJMK7/hBQiDclsbIqtSg/vqg0J7X4EKM0
        B4uSOG81w4NoIYH0xJLU7NTUgtQimCwTB6dUA+OCl3HZPTsmCxeZiE7OmGzKHfe9kOuNu/se
        DZFi4z++rDN19Gefm58YtvFu68LyA+77FMWO3n5X9eF7zZvZ9tNq05ou27Pc0bpZ88xkwh/T
        Wp0TEpFT59x9umdO47LXjqu/FrI/FXU4+aHqUNE9dblTdWpZ6y5dKGr+yqImPr1H0H3npr3l
        F88psRRnJBpqMRcVJwIA+qpw/zgDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrJIsWRmVeSWpSXmKPExsVy+t/xe7rsp6RjDHb90bJo+vuKxeLK1/ds
        Fif6PrBaXN41h81i1hthi0/nL7BZ3Pn6nMWB3aN/3WdWj5Yjb1k9Nq3qZPO4332cyePzJjmP
        7buXswSwRenZFOWXlqQqZOQXl9gqRRtaGOkZWlroGZlY6hkam8daGZkq6dvZpKTmZJalFunb
        JehlfDq9nLXgDEvFiSsHWRoY3zF3MXJySAiYSOxf/Yyxi5GLQ0hgKaPEiolLmLoYOYASMhLH
        15dB1AhL/LnWxQZR85ZRonP9RjaQhLBAhsTGx1uYQGwRATWJllNbwIYKCfQxSuxYqgvSwCyw
        gFHiW9NsVpAEm4CVxMT2VYwgNq+AncTv3ddZQGwWAVWJS+/WgsVFBSIkbj3sYIGoEZQ4OfMJ
        mM0pYC2x6swVsAXMAnoSO67/YoWw5SW2v53DPIFRcBaSlllIymYhKVvAyLyKUSS1tDg3PbfY
        SK84Mbe4NC9dLzk/dxMjMJq2Hfu5ZQdj17vgQ4wCHIxKPLwau6RjhFgTy4orcw8xSnAwK4nw
        rj8EFOJNSaysSi3Kjy8qzUktPsRoCvTERGYp0eR8YKTnlcQbmhqaW1gamhubG5tZKInznjeo
        jBISSE8sSc1OTS1ILYLpY+LglGpgnJ4od+vKVM4l6ZefzFzg+cKr9aBcyttLzs8bX7zm2+B1
        fUVCtU9JSOWjG5mL+t+J7Os12PStqjnbc3OepoDLrka+jDwWNU65eQ8aN3Qv/Fp70bdim8uP
        Kxo7H9g/e21gdHLxH1ub+X9n51uIH7g40+3QyWTz8radHzZohl9drH9l/lMP7x1t85RYijMS
        DbWYi4oTAZTnzoq8AgAA
X-CMS-MailID: 20181220165744eucas1p14b9208ef80078c1be55eb961ffdb53aa
X-Msg-Generator: CA
X-RootMTR: 20181119013711epcas5p1a247965989728e7b28b90ca0a3947229
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20181119013711epcas5p1a247965989728e7b28b90ca0a3947229
References: <CGME20181119013711epcas5p1a247965989728e7b28b90ca0a3947229@epcas5p1.samsung.com>
        <20181119013642.18080-1-yuehaibing@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 11/19/2018 02:36 AM, YueHaibing wrote:
> 'info->modes' got allocated with devm_kcalloc in of_get_pxafb_display.
> 
> This gives this error message:
>   ./drivers/video/fbdev/pxafb.c:2238:2-7: WARNING: invalid free of devm_ allocated data
> 
> Fixes: c8f96304ec8b4 ("video: fbdev: pxafb: switch to devm_* API")
> Cc: stable@kernel.org [v4.19+]
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> Reviewed-by: Daniel Mack <daniel@zonque.org>

Patch queued for 4.21, thanks.

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics
