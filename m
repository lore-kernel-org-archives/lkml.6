Return-Path: <SRS0=cgxA=JU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BFA8C6778C
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 00:59:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8273E247C5
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 00:59:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="Kbjy9bX8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8273E247C5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753549AbeGDA7b (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 20:59:31 -0400
Received: from mailout3.samsung.com ([203.254.224.33]:18323 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753119AbeGDA73 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 20:59:29 -0400
Received: from epcas1p3.samsung.com (unknown [182.195.41.47])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20180704005928epoutp03674e433b69d2738f9d543a34cec848ae~_BJaOCsO42667826678epoutp03W
        for <linux-kernel@vger.kernel.org>; Wed,  4 Jul 2018 00:59:28 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20180704005928epoutp03674e433b69d2738f9d543a34cec848ae~_BJaOCsO42667826678epoutp03W
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1530665968;
        bh=oEnm1rpMLtGFDTboJmi3XE3mjDev+8cc0HhYFlpQ0vI=;
        h=Subject:Reply-To:From:To:CC:In-Reply-To:Date:References:From;
        b=Kbjy9bX8jYwEqIVp79kg0mnmmbIe9sYD0wzlboQAgKdGf0zyd0SQwh/BTQl6xKu6I
         W0FvjzE81O+fmOx/LngsCk9l8d8jqoao2cwSNsrDkmsY9oHvrCtRrjDYTxkwKqNt4J
         xCsxK/vwoqjpNxEWoAAgGs4sZjesVaarRH+zLJAY=
Received: from epsmges1p3.samsung.com (unknown [182.195.40.156]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTP id
        20180704005925epcas1p22349452733b4cabd387f53fb8bda1e2a~_BJXaGt9T2206822068epcas1p2f;
        Wed,  4 Jul 2018 00:59:25 +0000 (GMT)
X-AuditID: b6c32a37-a71ff70000000fec-46-5b3c1be665ab
Received: from epcas1p2.samsung.com ( [182.195.41.46]) by
        epsmges1p3.samsung.com (Symantec Messaging Gateway) with SMTP id
        2D.5E.04076.6EB1C3B5; Wed,  4 Jul 2018 09:59:18 +0900 (KST)
Mime-Version: 1.0
Subject: RE: [PATCH v4] PM / devfreq: Fix devfreq_add_device() when drivers
 are built as modules.
Reply-To: myungjoo.ham@samsung.com
From:   MyungJoo Ham <myungjoo.ham@samsung.com>
To:     Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "kernel@collabora.com" <kernel@collabora.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
X-Priority: 3
X-Content-Kind-Code: NORMAL
In-Reply-To: <20180703132931.14389-1-enric.balletbo@collabora.com>
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <20180704005918epcms1p6c43766664c42fac3ee4d7eb7375b43eb@epcms1p6>
Date:   Wed, 04 Jul 2018 09:59:18 +0900
X-CMS-MailID: 20180704005918epcms1p6c43766664c42fac3ee4d7eb7375b43eb
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="utf-8"
X-CPGSPASS: Y
X-CPGSPASS: Y
CMS-TYPE: 101P
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpik+LIzCtJLcpLzFFi42LZdlhTT/eZtE20waXHBhYvD2laXP/ynNVi
        ze1DjBabz/WwWpxtesNucXnXHDaLz71HGB3YPXbcXcLo0bdlFaPH501yAcxRqTYZqYkpqUUK
        qXnJ+SmZeem2St7B8c7xpmYGhrqGlhbmSgp5ibmptkouPgG6bpk5QLuVFMoSc0qBQgGJxcVK
        +nY2RfmlJakKGfnFJbZK0YaGRnqGBuZ6RkZA2jjWysgUqCQhNWPFeq+CuUwVD5+GNzA+Yexi
        5OSQEDCR+Nn7maWLkYtDSGAHo8S87rdMXYwcHLwCghJ/dwiD1AgLJEs0de4CqxcSUJJouLmP
        GSKuL9HxYBtYnE1AV2LrhrssILaIQJXEh8dvwGYyC+xllDgx6wYzxDJeiRntT1kgbGmJ7cu3
        gjVzCjhJvLywmg0iLipxc/Vbdhj7/bH5UIeKSLTeOws1R1Diwc/dUHEpiSdvF0LV10tc/7yI
        CWSxhMAERonfN/5DJfQlHl2ZDbaAV8BX4uziuWCDWARUJTYduwM1yEXiRccJsDizgLzE9rdz
        mEEBwSygKbF+lz7M/Q0bf7Ojs5kF+CTefe1hhYnvmPeECcJWkzi0ewlUvYzE6ekLoe73kHi7
        bQvzBEbFWYignoVk8SyExQsYmVcxiqUWFOempxYbFhjrFSfmFpfmpesl5+duYgSnPy3zHYwb
        zvkcYhTgYFTi4V1Rah0txJpYVlyZe4hRgoNZSYT33i+gEG9KYmVValF+fFFpTmrxIUZToP8n
        MkuJJucDU3NeSbyhqZGxsbGFiaGZqaGhkjhvxU2BaCGB9MSS1OzU1ILUIpg+Jg5OqQbGBpOt
        nxVOmWltuf1iC9OifFtjD8eAi++kNj6c1pf0yC/uw9zV+wpjvu5lOhYw3/v0Mr+bmqnGCu66
        bk92i9/JcHjW9fG/M4eG/rWfKwM/t5j7N/wo9Ve5tvHcL7XGCOZFYeYX53UY9q88PWlDqn20
        pBn39lkFj8+d7nlpEX7rufoPvpV2T+xSlViKMxINtZiLihMB6JSvz5UDAAA=
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20180703132943epcas1p25b68c00ca1143d5eabcc2285c2ce27a0
References: <20180703132931.14389-1-enric.balletbo@collabora.com>
        <CGME20180703132943epcas1p25b68c00ca1143d5eabcc2285c2ce27a0@epcms1p6>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>+		if (!strncmp(name, DEVFREQ_GOV_SIMPLE_ONDEMAND,
>+			     DEVFREQ_NAME_LEN))
>+			err = request_module("governor_%s", "simpleondemand");
>+		else
>+			err = request_module("governor_%s", name);
>+		if (err)
>+			return NULL;

You are returning without the lock acquired..
