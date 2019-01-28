Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17F9BC282C8
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 08:05:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD05721736
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 08:05:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="IWRE2rmf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726869AbfA1IFq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 03:05:46 -0500
Received: from mailout3.samsung.com ([203.254.224.33]:43888 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726654AbfA1IFp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 03:05:45 -0500
Received: from epcas1p4.samsung.com (unknown [182.195.41.48])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20190128080542epoutp03096cdc27e05a2576759aafe884267ad9~99I8z34rw0692706927epoutp03J
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jan 2019 08:05:42 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20190128080542epoutp03096cdc27e05a2576759aafe884267ad9~99I8z34rw0692706927epoutp03J
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1548662742;
        bh=TM9djE3L0yJ81lsZxrNZ0rovqWWXgV3h5YaPywYLCUU=;
        h=Subject:Reply-To:From:To:CC:In-Reply-To:Date:References:From;
        b=IWRE2rmfISbTC1J0Wy9ZfGyZxzh1gFtFEPmkicVfu3ByVGGVoeWNHXjrDHF/YLN5y
         Q7aG6KdNuSXRPSNn/ADMFoXjNOGSX1Gnb402Bapq4Bhg6Oq+VGyb5I54vKNSE++KXh
         KWr9Sy+0oAZbp6TO+AkW7VFml7M3Jigkv7HLcTsM=
Received: from epsmges1p1.samsung.com (unknown [182.195.40.157]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTP id
        20190128080538epcas1p299102d865a77f168357787b62df02213~99I5SpOO_2177421774epcas1p2Q;
        Mon, 28 Jan 2019 08:05:38 +0000 (GMT)
X-AuditID: b6c32a35-297ff70000000fea-7b-5c4eb7cff98f
Received: from epcas1p2.samsung.com ( [182.195.41.46]) by
        epsmges1p1.samsung.com (Symantec Messaging Gateway) with SMTP id
        45.8C.04074.FC7BE4C5; Mon, 28 Jan 2019 17:05:35 +0900 (KST)
Mime-Version: 1.0
Subject: RE: [PATCH] devfreq: Suspend all devices on system shutdown
Reply-To: myungjoo.ham@samsung.com
From:   MyungJoo Ham <myungjoo.ham@samsung.com>
To:     Marek Szyprowski <m.szyprowski@samsung.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-samsung-soc@vger.kernel.org" 
        <linux-samsung-soc@vger.kernel.org>
CC:     Chanwoo Choi <cw00.choi@samsung.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Lukasz Luba <l.luba@partner.samsung.com>,
        Markus Reichl <m.reichl@fivetechno.de>
X-Priority: 3
X-Content-Kind-Code: NORMAL
In-Reply-To: <20190125135403.10228-1-m.szyprowski@samsung.com>
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <20190128080535epcms1p44636143629448c4e24a6628e87a72bf2@epcms1p4>
Date:   Mon, 28 Jan 2019 17:05:35 +0900
X-CMS-MailID: 20190128080535epcms1p44636143629448c4e24a6628e87a72bf2
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="utf-8"
X-CPGSPASS: Y
X-CPGSPASS: Y
CMS-TYPE: 101P
X-Brightmail-Tracker: H4sIAAAAAAAAA11Sa0gUURTmOrvrKI1cV7OLSW0DigruOuraWL5Ai5VUpP5EWTrooOI+pp1d
        yzLaMqlMM0tIxTLBijbEfK5oBG5iT11CyEwNEUWFLEqLzNT2idK/73znO+c7596DY+JGkT9e
        oNaxWjWjJEWegu4XIdIwiyk9M7xsKYZuq20V0gvmEHp0eU5IWyxP3elPhgB6pLdBRC9VDgC6
        1vLcjV4Y+A3oloFJ90RPxaeJC4p24zWRov/rMzfFjU4jUCy178oQHiuMzWeZXFYrYdU5mtwC
        dV4ceehIVlKWPDqcCqNi6L2kRM2o2DgyOTUj7GCB0joSKSlilHorlcHwPCmLj9Vq9DpWkq/h
        dXEky+UquRhOyjMqXq/Ok+ZoVPuo8PAIuVWYXZhfPR3MdeJnZl4sCgzgl6gceOAIRqHvQ18E
        5cATF8MegEaq/lgDHCegN1rr8bFBH5iMpof8bHIxJJFh7Dlmwz5Qhq5OdQMbFsEw1PV00t7G
        Fy4DdKnto9AWYHASIPPyD+AwI1DtlVmBA+9Epkdddt4DxqO65Q9CB78djT1ZdHfhb4ONzlpf
        VPZ5CHNgbzS10gdcfWprNpw9z6HpiveYzRjBywAZ67rdHAkZenf3tX1jAqah2duLmG0zAQxE
        G9NeDkkyanvywO6Lwd3ItNhgl2AwBLX2ylzjG9pW3f/HGPRCX39WCF18z70Zp2sQMvc1O/UB
        6O2dJuf4CjTXMYrdBHvqN1+6fotx/abxfYAZgR/L8ao8lqc4auvftgP7cYbKe0DNcKoZQByQ
        24ija2mZYiFTxBerzADhGOlL9DenZ4qJXKb4LKvVZGn1SpY3A7l1/WrMf3uOxnrqal0WJY+I
        jIyko6hoOUWRO4jWxKRMMcxjdGwhy3Ks1lXnhnv4G4CeXFv9+fCv5lQXV1zzMurE1DfR+umI
        BHx06jDXNL/EFC0cvWWqGTz+6jxBXI/J6Zc2FKiC+58lec62hO5HCScPXKySRksqjR2HS7wK
        o6qNK4EdRevjM5ZS2Xj6cGxieRDzRpD2mOoeSZnRZ88HtYDKzyI0YRo4fipl9UHJWikp4PMZ
        KhTT8sw/WsnORrIDAAA=
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20190125135414eucas1p2ffc71c63f1a27f67d076dec889954b40
References: <20190125135403.10228-1-m.szyprowski@samsung.com>
        <CGME20190125135414eucas1p2ffc71c63f1a27f67d076dec889954b40@epcms1p4>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>This way devfreq core ensures that all its devices will be set to safe
>operation points before reboot operation. There are board on which some
>aggressive power saving operation points are behind the capabilities of
>the bootloader to properly reset the hardware and boot the board. This
>way one can avoid board crash early after reboot.
>
>Similar pattern is used in CPUfreq subsystem.
>
>Reported-by: Markus Reichl <m.reichl@fivetechno.de>
>Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
>---

You are invoking ALL devfreq suspend callbacks at shutdown
with this commit.

Can you make it invoke only devices explicitly saying their needs
to handle "SHUTDOWN" event?

For example, we can add a flag at struct devfreq_dev_profile:
"uint32_t requirement"
, where
0x1: need to operate at the initial frequency for suspend
0x2: need to operate at the initial frequency for shutdown
0x4: it forgets its status at resume, reconfigure frequency at resume.
(or reverse 0x1's semantics for the backward compatibility)
...

Cheers,
MyungJoo
