Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7750DC282DB
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 07:23:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 44A7D20823
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 07:23:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="WBwN8DYP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728394AbfAUHXw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 02:23:52 -0500
Received: from mailout2.samsung.com ([203.254.224.25]:56539 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727992AbfAUHXs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 02:23:48 -0500
Received: from epcas1p4.samsung.com (unknown [182.195.41.48])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20190121012753epoutp0288f97c57543fbd9e1206e371e8fc907f~7uMnGY4mv0822908229epoutp02M
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jan 2019 01:27:53 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20190121012753epoutp0288f97c57543fbd9e1206e371e8fc907f~7uMnGY4mv0822908229epoutp02M
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1548034073;
        bh=n7gckqyZyZLjOOQ09nraz2rV2FeNQAdB346VcThszXE=;
        h=Subject:Reply-To:From:To:CC:In-Reply-To:Date:References:From;
        b=WBwN8DYPV9xnA8H2hjGzvI9hTthLSgUvXvHJ8gz+uGMV4owjCq3kaxZJUWK0pbBwx
         l6pexgAS/F8dZQ2GsROBCrcKXXMBS/RCaojBYh29SsJby3NB0Ux7Yolfm4YxMP9POn
         WiU8rWPuobilnR8yCaX9nxwWCzlZGUdIouOQ597A=
Received: from epsmges1p5.samsung.com (unknown [182.195.40.153]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTP id
        20190121012751epcas1p44d236a952bfad3d9bdb7ff43c154d7d9~7uMlFEmfs2102521025epcas1p4p;
        Mon, 21 Jan 2019 01:27:51 +0000 (GMT)
X-AuditID: b6c32a39-1ce159c00000106e-8e-5c4520160cbf
Received: from epcas1p4.samsung.com ( [182.195.41.48]) by
        epsmges1p5.samsung.com (Symantec Messaging Gateway) with SMTP id
        F5.44.04206.610254C5; Mon, 21 Jan 2019 10:27:50 +0900 (KST)
Mime-Version: 1.0
Subject: RE: [PATCH 2/3] PM / devfreq: fix missing check of return value in
 devfreq_add_device()
Reply-To: myungjoo.ham@samsung.com
From:   MyungJoo Ham <myungjoo.ham@samsung.com>
To:     Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Yangtao Li <tiny.windzz@gmail.com>
X-Priority: 3
X-Content-Kind-Code: NORMAL
In-Reply-To: <20190119160454.23151-2-tiny.windzz@gmail.com>
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <20190121012750epcms1p1b3fae992e1ae0f83c1d530feae02104c@epcms1p1>
Date:   Mon, 21 Jan 2019 10:27:50 +0900
X-CMS-MailID: 20190121012750epcms1p1b3fae992e1ae0f83c1d530feae02104c
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 101P
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrCKsWRmVeSWpSXmKPExsWy7bCmga6YgmuMwe6XJhbXvzxntTjb9Ibd
        4vKuOWwWn3uPMFrM/T2BzYHVY+esu+wefVtWMXp83iQXwByVbZORmpiSWqSQmpecn5KZl26r
        5B0c7xxvamZgqGtoaWGupJCXmJtqq+TiE6DrlpkDtFJJoSwxpxQoFJBYXKykb2dTlF9akqqQ
        kV9cYquUWpCSU2BZoFecmFtcmpeul5yfa2VoYGBkClSYkJ3xYmttwQ/mir7JXA2MG5m7GDk5
        JARMJPq7TgDZXBxCAjsYJSZu7wJyODh4BQQl/u4QBqkRFkiS+LP6LxOILSSgJNFwcx8zRFxf
        ouPBNkYQm01AV2LrhrssIHNEBPoYJa5c/ccKkmAWSJdY93AOE8QyXokZ7U9ZIGxpie3Lt4I1
        cwpYA9nL2CHiohI3V7+Fs98fm88IYYtItN47C3W0oMSDn7sZYebMmPIfama1xKOei2DPSAi0
        MEqsmrkNarG+xJm5J9lAbF4BX4k3nZPAmlkEVCWW7jsPVeMicWfdR2aIo+Ultr+dAw4IZgFN
        ifW79CHCfBLvvvawwvyyY94TqFY1iUO7l0DdLCNxevpCqDs9JF7cn84KCdzNjBI3v6xin8Ao
        PwsRvrOQbJuFsG0BI/MqRrHUguLc9NRiwwJT5AjdxAhOcVqWOxiPnfM5xCjAwajEw/vjnkuM
        EGtiWXFl7iFGCQ5mJRHejOPOMUK8KYmVValF+fFFpTmpxYcYTYGensgsJZqcD0y/eSXxhqZG
        xsbGFiaGZqaGhkrivOsdgJoE0hNLUrNTUwtSi2D6mDg4pRoY8+5MPsU/f8LcOz9fV3hEnBHb
        cmWV0ZTd5zck610yLF8fNO9ZvN0/6R/Tvs5/NfEA55qst3vOPlG48+TMju0vzx3PnGv/cqWY
        rtCquVviq02u8c7Y3fH3s8TXiiXztzpPsA5TTnfqEH/60is/IUeb6apQMN9/ofzAb4e/3P+u
        z3Rdar9KuWy+XacSS3FGoqEWc1FxIgBr3Q/6hwMAAA==
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20190119183509epcas1p27012fefeafe539c3f82030caf85ad308
References: <20190119160454.23151-2-tiny.windzz@gmail.com>
        <20190119160454.23151-1-tiny.windzz@gmail.com>
        <CGME20190119183509epcas1p27012fefeafe539c3f82030caf85ad308@epcms1p1>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>devm_kzalloc() could fail, so insert a check of its return value. And
>if it fails, returns -ENOMEM.
>
>Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
>---
> drivers/devfreq/devfreq.c | 14 +++++++++++++-
> 1 file changed, 13 insertions(+), 1 deletion(-)
>
>diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
>index 076b1c2f40a4..923889229a0b 100644
>--- a/drivers/devfreq/devfreq.c
>+++ b/drivers/devfreq/devfreq.c

Acked-by: MyungJoo Ham <myungjoo.ham@samsung.com>


