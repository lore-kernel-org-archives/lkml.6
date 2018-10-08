Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FORGED_MUA_MOZILLA,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52E1AC00449
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 10:41:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 17E5C20841
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 10:41:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="NHbKuxGe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 17E5C20841
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727396AbeJHRwy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 13:52:54 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:52822 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726511AbeJHRwy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 13:52:54 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20181008104148euoutp01d195a93f7e6b7d46443ae5c10458298e~bnBQ5gQY71496414964euoutp01w
        for <linux-kernel@vger.kernel.org>; Mon,  8 Oct 2018 10:41:48 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20181008104148euoutp01d195a93f7e6b7d46443ae5c10458298e~bnBQ5gQY71496414964euoutp01w
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1538995308;
        bh=B84lC24EbdL3Q9SRo+kvelyWDAeOG2H7kJoUL56ABJ4=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=NHbKuxGe9i56cyZYW+dGQxf3zJfgNnwkvIEiWgkRpDJ6MBrtX/7QuD05pX+vh9HHL
         JN+U3dKA8MILEp8iywJUT//8gsAbRBI36QTMye8NLQwyi0bt7HFsyi5J+//BpLX1qn
         H8bxQVaA5/FcwG2YcNAXI5qCCZTmNwt7pqJPUHOg=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20181008104147eucas1p137823d340f3a40cd3f88fe16075664e2~bnBQdm8xi1612016120eucas1p1U;
        Mon,  8 Oct 2018 10:41:47 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id 3A.78.04294.B643BBB5; Mon,  8
        Oct 2018 11:41:47 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20181008104146eucas1p206774c188cefcfd36e33b467ed7b67ad~bnBPnnsKU2190121901eucas1p2U;
        Mon,  8 Oct 2018 10:41:46 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20181008104146eusmtrp1d9800a0b101f7850a7844b53f27a369e~bnBPXAqaa2059120591eusmtrp1j;
        Mon,  8 Oct 2018 10:41:46 +0000 (GMT)
X-AuditID: cbfec7f4-84fff700000010c6-6c-5bbb346b87cc
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 85.C6.04284.A643BBB5; Mon,  8
        Oct 2018 11:41:46 +0100 (BST)
Received: from [106.120.53.102] (unknown [106.120.53.102]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20181008104146eusmtip232fcd89cea30648d3e562bd7948a097d~bnBPIeThs2343823438eusmtip2n;
        Mon,  8 Oct 2018 10:41:46 +0000 (GMT)
Subject: Re: [PATCH] fbdev: Convert to using %pOFn instead of
 device_node.name
To:     Rob Herring <robh@kernel.org>
Cc:     linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-fbdev@vger.kernel.org
From:   Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Date:   Mon, 8 Oct 2018 12:41:45 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
        Thunderbird/45.3.0
MIME-Version: 1.0
In-Reply-To: <20180828015252.28511-49-robh@kernel.org>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmplleLIzCtJLcpLzFFi42LZduzned1sk93RBh97VS2ufH3PZnGi7wOr
        xeVdc9gs/u/Zwe7A4rFpVSebx/3u40wenzfJBTBHcdmkpOZklqUW6dslcGXM/n2TteAjc8Wr
        iydYGxgXMHcxcnJICJhItG6bz9LFyMUhJLCCUWLnqpmsEM4XRonL0z6zQTifGSWmLbzIDtOy
        bt1+dojEckaJ6dOPMkI47xklvvU0AmU4OIQFAiTW/tYEaRARUJT43TaNFSTMLJAgsXuRGUiY
        TcBKYmL7KkYQm0VAReLp3Y2MICWiAhES/WfUQcK8AoISJ2c+YQGxOQXMJK5NbGMFsZkFDCSO
        LJoDZctLbH87B+qb32wSt89zQ/SWSVzfNpMFIu4isex0LyOELSzx6vgWqFdkJE5P7gH7XkJg
        OqPEm19LoZz1jBJrzhxjgqiyljh8/CIrhO0o8XtpJxPIoRICfBI33gpCHMEnMWnbdGaIMK9E
        R5sQRLWaxIZlG9hgdnXtXAl1p4fE5ustjBMYFWcheXMWktdmIXltASPzKkbx1NLi3PTUYqO8
        1HK94sTc4tK8dL3k/NxNjMDEcfrf8S87GHf9STrEKMDBqMTDuyJgV7QQa2JZcWXuIUYJDmYl
        EV7R7UAh3pTEyqrUovz4otKc1OJDjNIcLErivMvmbYwWEkhPLEnNTk0tSC2CyTJxcEo1MGpM
        PH+J78kMB4v93yvk9ngZ5HxXjXM5Ey5W5G4S6Llv43Wl0mf5sVbLqo9Gxx8u97ose+tdX8nP
        Zp+il3kPN2ifCNxk18L8WKdxzo7fVppnLyl59j/h45y/5+7XCVaH+hS0k84sZpM+73lBXLAj
        IUPh8ZLQ3Z7sP/7yyxpP9ll2n9Vw3foZskosxRmJhlrMRcWJAFXSyE4YAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFuphkeLIzCtJLcpLzFFi42I5/e/4Pd0sk93RBnPva1hc+fqezeJE3wdW
        i8u75rBZ/N+zg92BxWPTqk42j/vdx5k8Pm+SC2CO0rMpyi8tSVXIyC8usVWKNrQw0jO0tNAz
        MrHUMzQ2j7UyMlXSt7NJSc3JLEst0rdL0MuY/fsma8FH5opXF0+wNjAuYO5i5OSQEDCRWLdu
        P3sXIxeHkMBSRonfMxYAORxACRmJ4+vLIGqEJf5c62KDqHnLKPFixyU2kISwgJ/Eif9PwQaJ
        CChK/G6bxgpRtIVR4tLpr6wgCWaBBIkVb9vBbDYBK4mJ7asYQWxeATuJH1c2MoHYLAIqEk/v
        bgSLiwpESNx62MECUSMocXLmEzCbU8BM4trENqiZehI7rv+CsuUltr+dwzyBUXAWkpZZSMpm
        ISlbwMi8ilEktbQ4Nz232FCvODG3uDQvXS85P3cTIzAmth37uXkH46WNwYcYBTgYlXh4A/x2
        RQuxJpYVV+YeYpTgYFYS4RXdDhTiTUmsrEotyo8vKs1JLT7EaAr0xERmKdHkfGC85pXEG5oa
        mltYGpobmxubWSiJ8543qIwSEkhPLEnNTk0tSC2C6WPi4JRqYOx+1c37JJe9t3k3f+ra2IZZ
        kzusZ645XjC96v/PB48uy6xMW/bPzOBu29mY+X59E6W+hWfwhgglL61cqWJ8SiXGWlQodt7a
        4rfLdha0nuRLzxRdIZHVWGL09xnT1W+Pv4rkfXL/GhxWNXHK2eXcE9d2BggdU86pccr9wbF0
        y1+mu7wfz15ftVCJpTgj0VCLuag4EQCBLBV5nwIAAA==
Message-Id: <20181008104146eucas1p206774c188cefcfd36e33b467ed7b67ad~bnBPnnsKU2190121901eucas1p2U@eucas1p2.samsung.com>
X-CMS-MailID: 20181008104146eucas1p206774c188cefcfd36e33b467ed7b67ad
X-Msg-Generator: CA
X-RootMTR: 20180828015547epcas1p421d327fc2f675bcf45431bb3fe9e678f
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20180828015547epcas1p421d327fc2f675bcf45431bb3fe9e678f
References: <20180828015252.28511-1-robh@kernel.org>
        <CGME20180828015547epcas1p421d327fc2f675bcf45431bb3fe9e678f@epcas1p4.samsung.com>
        <20180828015252.28511-49-robh@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 08/28/2018 03:52 AM, Rob Herring wrote:
> In preparation to remove the node name pointer from struct device_node,
> convert printf users to use the %pOFn format specifier.
> 
> Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
> Cc: dri-devel@lists.freedesktop.org
> Cc: linux-fbdev@vger.kernel.org
> Signed-off-by: Rob Herring <robh@kernel.org>

Patch queued for 4.20, thanks.

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics
