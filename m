Return-Path: <SRS0=cgxA=JU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2402C6778C
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 02:24:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 59B48246DE
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 02:24:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="RDd/JM42"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 59B48246DE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933049AbeGDCYK (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 22:24:10 -0400
Received: from mailout2.samsung.com ([203.254.224.25]:62686 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932853AbeGDCYI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 22:24:08 -0400
Received: from epcas1p4.samsung.com (unknown [182.195.41.48])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20180704022404epoutp02d2e5cb560ea8b20ea79751aa414bf135~_CTSJ8ARy1261312613epoutp02c
        for <linux-kernel@vger.kernel.org>; Wed,  4 Jul 2018 02:24:04 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20180704022404epoutp02d2e5cb560ea8b20ea79751aa414bf135~_CTSJ8ARy1261312613epoutp02c
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1530671044;
        bh=F7sHlurQLVuZ8u9+JCpT7c2pqM08siB2L28Nq9vpW4I=;
        h=To:Subject:Reply-To:From:CC:In-Reply-To:Date:References:From;
        b=RDd/JM42NCf8mKXROQ7UHyzKwm82vyYyN2PXQvByiYvv8HQiVPzdtHyM1GhPFNqVh
         aeeyGSCoDvcrqAfa6yT6S1xuVGLlLM0yTFg3WKzj38qsAHO9rf4zQgSchLXAgY0jGg
         lseKaHnJHZUZGAnFrbLKa7Wkjf2FkfVLrU1+1BE0=
Received: from epsmges1p2.samsung.com (unknown [182.195.40.156]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTP id
        20180704022401epcas1p3834d64776cadd95a6bee662e78c68eb5~_CTPsTlw80191001910epcas1p3Z;
        Wed,  4 Jul 2018 02:24:01 +0000 (GMT)
X-AuditID: b6c32a36-bd1ff70000000fe4-ef-5b3c2fc13738
Received: from epcas1p1.samsung.com ( [182.195.41.45]) by
        epsmges1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        F0.38.04068.1CF2C3B5; Wed,  4 Jul 2018 11:24:01 +0900 (KST)
To:     undisclosed-recipients:;
Mime-Version: 1.0
Subject: RE: [PATCH v5 01/12] PM / devfreq: Init user limits from OPP
 limits, not viceversa
Reply-To: myungjoo.ham@samsung.com
From:   MyungJoo Ham <myungjoo.ham@samsung.com>
CC:     Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Brian Norris <briannorris@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Lee Jones <lee.jones@linaro.org>,
        Benson Leung <bleung@chromium.org>,
        Olof Johansson <olof@lixom.net>,
        Matthias Kaehlcke <mka@chromium.org>
X-Priority: 3
X-Content-Kind-Code: NORMAL
In-Reply-To: <20180703234705.227473-2-mka@chromium.org>
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <20180704022401epcms1p5859d1d7af6340deb531071faadc8f237@epcms1p5>
Date:   Wed, 04 Jul 2018 11:24:01 +0900
X-CMS-MailID: 20180704022401epcms1p5859d1d7af6340deb531071faadc8f237
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="utf-8"
X-CPGSPASS: Y
X-CPGSPASS: Y
CMS-TYPE: 101P
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrOJsWRmVeSWpSXmKPExsWy7bCmru5BfZtogw1XzS3+TjrGbjH9yWUW
        i00f37NavDykaXH9y3NWi/lHzrFanF12kM1ize1DjBbNi9ezWZxtesNucf/rUUaLy7vmsFl8
        7j3CaLH0+kUmi88bHjNanLr+mc3izOlLrBate4+wW2z86uEg7LFm3hpGj9+/JjF6zG64yOKx
        4+4SRo9NqzrZPO5c28PmsX/uGnaPKyeaWD22XG1n8ejbsorR4/MmuQDuqFSbjNTElNQihdS8
        5PyUzLx0WyXv4HjneFMzA0NdQ0sLcyWFvMTcVFslF58AXbfMHKD3lBTKEnNKgUIBicXFSvp2
        NkX5pSWpChn5xSW2StGGhkZ6hgbmekZGQNo41srIFKgkITVj9bm3jAWfuCpeXn/M1MA4hbOL
        kZNDQsBE4sHLS2xdjFwcQgI7GCUWXrzKApIQEZCRmDv7MWsXIwcHr4CgxN8dwiBhYYFYiXXn
        elhBbCEBJYmGm/uYIeL6Eh0PtjGC2GwCuhJbN9xlAZnJLDCLTaJzdg8zxDJeiRntT1kgbGmJ
        7cu3gjVwCphLrN0wgRUiLipxc/Vbdhj7/bH5jBC2iETrvbNQcwQlHvzcDRWXknjydiFUfb3E
        9c+LmEAWSwhMYJT4feM/VEJf4tGV2WwgNq+Ar0TXk0tMIDaLgKrE82mtbBA1LhKP1t4EW8As
        IC+x/e0cZpDnmQU0Jdbv0oe5v2Hjb3Z0NrMAn8S7rz2sMPEd854wQdhqEod2L4Gql5E4PX0h
        1P0eElsWdzFNYFSchQjeWUgWz0JYvICReRWjWGpBcW56arFhgZFecWJucWleul5yfu4mRnAi
        1zLbwbjonM8hRgEORiUe3hWl1tFCrIllxZW5hxglOJiVRHjv/QIK8aYkVlalFuXHF5XmpBYf
        YjQF+n8is5Rocj4wy+SVxBuaGhkbG1uYGJqZGhoqifNW3BSIFhJITyxJzU5NLUgtgulj4uCU
        amDsulrWeTJUYB+ne/8yu3Xfn6QXc1cW7639/3LalOpueZbj03+nbV0gerpfY9qWzR9OyBU6
        TYss356T9ohD7nqt6XNO8Rklx5X5xXN/B+4q9rcJZxJrM8nJlPC00xM+vD411qAr5FjH3XqV
        1BWXNs70qNf4dkkyTbriyxrH0OvMerUq716uuKnEUpyRaKjFXFScCAALkASV+gMAAA==
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20180703234727epcas3p1b9f4a41b1f1714c8c059100d46b816dd
References: <20180703234705.227473-2-mka@chromium.org>
        <20180703234705.227473-1-mka@chromium.org>
        <CGME20180703234727epcas3p1b9f4a41b1f1714c8c059100d46b816dd@epcms1p5>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>Commit ab8f58ad72c4 ("PM / devfreq: Set min/max_freq when adding
>the devfreq device") introduced the initialization of the user
>limits min/max_freq from the lowest/highest available OPPs. Later
>commit f1d981eaecf8 ("PM / devfreq: Use the available min/max
>frequency") added scaling_min/max_freq, which actually represent
>the frequencies of the lowest/highest available OPP. scaling_min/
>max_freq are initialized with the values from min/max_freq, which
>is totally correct in the context, but a bit awkward to read.
>
>Swap the initialization and assign scaling_min/max_freq with the
>OPP freqs and then the user limts min/max_freq with scaling_min/
>max_freq.
>
>Needless to say that this change is a NOP, intended to improve
>readability.
>
>Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
>Reviewed-by: Chanwoo Choi <cw00.choi@samsung.com>
>Reviewed-by: Brian Norris <briannorris@chromium.org>
>---
>Changes in v5:
>- none
>
>Changes in v4:
>- added 'Reviewed-by: Brian Norris <briannorris@chromium.org>' tag
>
>Changes in v3:
>- none
>
>Changes in v2:
>- added 'Reviewed-by: Chanwoo Choi <cw00.choi@samsung.com>' tag
>---
> drivers/devfreq/devfreq.c | 12 ++++++------
> 1 file changed, 6 insertions(+), 6 deletions(-)

Acked-by: MyungJoo Ham <myungjoo.ham@samsung.com>

This can be applied independently from other commits in this series.

