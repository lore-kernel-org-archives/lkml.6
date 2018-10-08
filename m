Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FORGED_MUA_MOZILLA,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C311C00449
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 10:41:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B883A20841
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 10:41:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="TqQ4cxso"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B883A20841
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727675AbeJHRwU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 13:52:20 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:59347 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726612AbeJHRwT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 13:52:19 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20181008104114euoutp023d0ff17fe250820703c8dbb970839c12~bnAxjXv582213822138euoutp02g
        for <linux-kernel@vger.kernel.org>; Mon,  8 Oct 2018 10:41:14 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20181008104114euoutp023d0ff17fe250820703c8dbb970839c12~bnAxjXv582213822138euoutp02g
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1538995274;
        bh=OmS9pqBD5NYp+kk+tJT6/TX0fv2QeNIc/GPwrEl9qQ4=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=TqQ4cxsosmLVUVqTQlNf6nY9St007A+9mWc3zUd7RVLwQ20T2FKhurcFtZEjWdPxX
         YHVIXtkLiFUS4cc4Yj7xveaBICjWOEs6moNuz2g/SL+4PxEtqb/Ir34wxnrREfeeAf
         pDd43Z2GPNHomPBMDSYw+q1DStXoHmX2jvZEPbog=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20181008104113eucas1p19c879de593450f2ed1bcb0829c3e8311~bnAw1ULDc1913919139eucas1p1q;
        Mon,  8 Oct 2018 10:41:13 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id 03.68.04294.9443BBB5; Mon,  8
        Oct 2018 11:41:13 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20181008104113eucas1p2b13ae804576bf7bcb25ecee9d85f5514~bnAwFQAp51046810468eucas1p2e;
        Mon,  8 Oct 2018 10:41:13 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20181008104112eusmtrp18441357d3d35914b5f19d9cf71f7db55~bnAv0Yj-e2059120591eusmtrp1h;
        Mon,  8 Oct 2018 10:41:12 +0000 (GMT)
X-AuditID: cbfec7f4-835ff700000010c6-f5-5bbb344930f2
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id F1.B6.04284.8443BBB5; Mon,  8
        Oct 2018 11:41:12 +0100 (BST)
Received: from [106.120.53.102] (unknown [106.120.53.102]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20181008104112eusmtip103fece3c75aea1b1e58c26553d3649bf~bnAvhbonr2548125481eusmtip1j;
        Mon,  8 Oct 2018 10:41:12 +0000 (GMT)
Subject: Re: [PATCH v2 1/1] atmel_lcdfb: support native-mode display-timings
To:     Sam Ravnborg <sam@ravnborg.org>
Cc:     Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
From:   Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Date:   Mon, 8 Oct 2018 12:41:11 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
        Thunderbird/45.3.0
MIME-Version: 1.0
In-Reply-To: <20180825182320.GA3285@ravnborg.org>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprJKsWRmVeSWpSXmKPExsWy7djP87qeJrujDbbcVbVof7eM3eLK1/ds
        Fif6PrBaXN41h81i++aFzBYrfm5ldGDzmLem2uN+93Emjzs/ljJ6LJl2lc3j8ya5ANYoLpuU
        1JzMstQifbsEroxNx66xFizmqDh9+wJjA+NFti5GTg4JAROJb1dnsnQxcnEICaxglJh8dj+U
        84VRYtLZB2wQzmdGiYcfl7N3MXKAtdz4pgTSLSSwnFFi1ytBiJr3QA0bZjGBJIQFfCROnXjM
        DmKLCChLHD9/jRXEZhY4xCix+Xc4iM0mYCUxsX0VI4jNIqAiseLHJRaQ+aICERL9Z9RBwrwC
        ghInZz5hAbE5BQwlGo6sZocYYyBxZNEcqJHyEtvfzmEGuUFCYB67xPKlPewQzWUST16dYoJ4
        00Via+NkKFtY4tXxLewQtozE6ck9LBDN0xkl3vxaCuWsZ5RYc+YYVIe1xOHjF1khbEeJFwcu
        M0FCgk/ixltBiCv4JCZtm84MEeaV6GgTgqhWk9iwbAMbzK6unSuZIWwPian9O9knMCrOQvLn
        LCS/zULy2wJG5lWM4qmlxbnpqcVGeanlesWJucWleel6yfm5mxiBCeb0v+NfdjDu+pN0iFGA
        g1GJh3dFwK5oIdbEsuLKXGCQczArifCKbgcK8aYkVlalFuXHF5XmpBYfYpTmYFES5102b2O0
        kEB6YklqdmpqQWoRTJaJg1OqgdH48vbvqfOl15yOWnyT1UyziumOze4T894Fd9zZxSX5dM6/
        W158WTGFScHnBOb9XW1694qzpoGt+xVemQltybX2UkcybF4sU+0+rbE0bCpvtJiuohNvw+ep
        3ttFlFlyoyab5Gw79PDxUzaVsiqTiX4bZwnvf9vaL6ZjLX3z7eH7cUecosyCVyuxFGckGmox
        FxUnAgADy8DsLAMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprHIsWRmVeSWpSXmKPExsVy+t/xu7oeJrujDboXGFi0v1vGbnHl63s2
        ixN9H1gtLu+aw2axffNCZosVP7cyOrB5zFtT7XG/+ziTx50fSxk9lky7yubxeZNcAGuUnk1R
        fmlJqkJGfnGJrVK0oYWRnqGlhZ6RiaWeobF5rJWRqZK+nU1Kak5mWWqRvl2CXsamY9dYCxZz
        VJy+fYGxgfEiWxcjB4eEgInEjW9KXYxcHEICSxkl7m35zAIRl5E4vr6si5ETyBSW+HOtiw2i
        5i2jxOYVl5hAEsICPhKnTjxmB7FFBJQljp+/xgpR1MIocfXAXBYQh1ngCKPEoeMn2UCq2ASs
        JCa2r2IE2cArYCdx9qo0SJhFQEVixY9LLCC2qECExK2HHWA2r4CgxMmZT8BsTgFDiYYjq8GW
        MQvoSey4/osVwpaX2P52DvMERsFZSFpmISmbhaRsASPzKkaR1NLi3PTcYkO94sTc4tK8dL3k
        /NxNjMC42Xbs5+YdjJc2Bh9iFOBgVOLhDfDbFS3EmlhWXJl7iFGCg1lJhFd0O1CINyWxsiq1
        KD++qDQntfgQoynQExOZpUST84ExnVcSb2hqaG5haWhubG5sZqEkznveoDJKSCA9sSQ1OzW1
        ILUIpo+Jg1OqgVGjv4Tj8ITLeyTa+ScFPv72ZLrQZU6F3gRt38+HFl5x6vv3S87X4vbs6j0e
        Nz/4rdhjlCLAKrxvknP7HV+ennvfGA16XXYoTjoTkPXU/4fZkszpCYIbpb59Oa/F7BCl+N97
        6f3s3NJohhdJq1Z/4dlnpP6vg/cYX75hre+CF+aaeaE6zS3pjUosxRmJhlrMRcWJAFwO6a+x
        AgAA
Message-Id: <20181008104113eucas1p2b13ae804576bf7bcb25ecee9d85f5514~bnAwFQAp51046810468eucas1p2e@eucas1p2.samsung.com>
X-CMS-MailID: 20181008104113eucas1p2b13ae804576bf7bcb25ecee9d85f5514
X-Msg-Generator: CA
X-RootMTR: 20180825182327epcas2p288809a2555ca2a8dc85bf05d713cce09
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20180825182327epcas2p288809a2555ca2a8dc85bf05d713cce09
References: <CGME20180825182327epcas2p288809a2555ca2a8dc85bf05d713cce09@epcas2p2.samsung.com>
        <20180825182320.GA3285@ravnborg.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 08/25/2018 08:23 PM, Sam Ravnborg wrote:
> When a device tree set a display-timing using native-mode
> then according to the bindings doc this should:
> 
>     native-mode:
>     The native mode for the display, in case multiple
>     modes are provided.
>     When omitted, assume the first node is the native.
> 
> The atmel_lcdfb used the last timing subnode and did not
> respect the timing mode specified with native-mode.
> 
> Introduce use of of_get_videomode() which allowed
> a nice simplification of the code while also
> added support for native-mode.
> 
> As a nice side-effect this fixes a memory leak where the
> data used for timings and the display_np was not freed.
> 
> Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
> Cc: Nicolas Ferre <nicolas.ferre@microchip.com>
> Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
> Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>

Patch queued for 4.20, thanks.

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics
