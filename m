Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B56B8C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 13:06:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C85721A80
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 13:06:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="J0NfcFf1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394856AbfBONF7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Feb 2019 08:05:59 -0500
Received: from mailout1.w1.samsung.com ([210.118.77.11]:49375 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387425AbfBONF6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Feb 2019 08:05:58 -0500
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20190215130557euoutp013ffa164b8925e2ed7aab3cffbb66f650~Di2O9xtFy1609716097euoutp01k
        for <linux-kernel@vger.kernel.org>; Fri, 15 Feb 2019 13:05:57 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20190215130557euoutp013ffa164b8925e2ed7aab3cffbb66f650~Di2O9xtFy1609716097euoutp01k
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1550235957;
        bh=wUN2vzB5U0AoORJfr99gPFk8Dy3g4fg9Lyo7amxIwqc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=J0NfcFf1hcihLx4l2V5yn+7bemkAAoyoFbRkM36DbELQq/VHWMwjb9E9Li99xUeV/
         8DpgBq0VKLefH7EAzNBkzm2EinZzDffwtgV4GDOKdBse2/9KnPpokSn59WYkEtVv6K
         utCxcTMBl8JQVzV27mRUbF/xtHNspAxJykAeyGVk=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20190215130556eucas1p2b865e4aa4f324532e42bc911b0a24a6c~Di2OfVBMV3216232162eucas1p2E;
        Fri, 15 Feb 2019 13:05:56 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id BA.34.04806.439B66C5; Fri, 15
        Feb 2019 13:05:56 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20190215130555eucas1p297d048d01902e2bb88e6db158d53fd88~Di2NntX0j3216232162eucas1p2D;
        Fri, 15 Feb 2019 13:05:55 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20190215130555eusmtrp168f7e06f0725d2879e8b1951a2861c50~Di2NZCmqx2508625086eusmtrp14;
        Fri, 15 Feb 2019 13:05:55 +0000 (GMT)
X-AuditID: cbfec7f5-34dff700000012c6-cb-5c66b934e45b
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 36.22.04284.339B66C5; Fri, 15
        Feb 2019 13:05:55 +0000 (GMT)
Received: from AMDC3778.DIGITAL.local (unknown [106.120.51.20]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20190215130554eusmtip29921333beb3690b3a7142b2ac93a6937~Di2MxJ-4N1399213992eusmtip2z;
        Fri, 15 Feb 2019 13:05:54 +0000 (GMT)
From:   Lukasz Luba <l.luba@partner.samsung.com>
To:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Cc:     b.zolnierkie@samsung.com, myungjoo.ham@samsung.com,
        cw00.choi@samsung.com, kyungmin.park@samsung.com,
        m.szyprowski@samsung.com, s.nawrocki@samsung.com, mka@chromium.org,
        rostedt@goodmis.org, mingo@redhat.com,
        Lukasz Luba <l.luba@partner.samsung.com>
Subject: [PATCH v2 2/2] drivers: devfreq: add tracing for scheduling work
Date:   Fri, 15 Feb 2019 14:05:13 +0100
Message-Id: <1550235913-5189-3-git-send-email-l.luba@partner.samsung.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1550235913-5189-1-git-send-email-l.luba@partner.samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprKKsWRmVeSWpSXmKPExsWy7djP87omO9NiDI41ylpsnLGe1eL6l+es
        Fmeb3rBb3GqQsbi8aw6bxefeI4wWa4/cZbe4dGABk8XnDY8ZLW43rmCz2NfxgMni8Jt2Vgce
        j9kNF1k8WvbdYvc4+G4Pk8f7fVfZPPq2rGL0+LxJLoAtissmJTUnsyy1SN8ugStj5eWT7AV9
        7BX9q20bGH+xdjFyckgImEhc7jkAZgsJrGCUeDWXCcL+wijxeL10FyMXkP2ZUWJr+124hnVv
        FzFDJJYzSryb9AvKAepYeOA0WxcjBwebgJ7EjlWFIA0iAlYSL9pfsYPUMAs0M0k8a1vIApIQ
        FvCUuNxyCmwdi4CqxJnW82BxXqD4/At7GSG2yUncPNfJDGJzCnhJnL7yE2yZhMB0domv87dA
        FblILL7SxwZhC0u8Or6FHcKWkTg9uYcFwi6WONuxCqqmRqL95A6oGmuJw8cvsoIczSygKbF+
        lz5E2FFiwsabjCBhCQE+iRtvBUHCzEDmpG3TmSHCvBIdbUIQ1RoSW3ouMEHYYhLL10yDGu4h
        8ft4AzskeOYySpw5u5x1AqP8LIRlCxgZVzGKp5YW56anFhvnpZbrFSfmFpfmpesl5+duYgQm
        ltP/jn/dwbjvT9IhRgEORiUe3hUZqTFCrIllxZW5hxglOJiVRHg516TFCPGmJFZWpRblxxeV
        5qQWH2KU5mBREuetZngQLSSQnliSmp2aWpBaBJNl4uCUamA0VtoozPWf2fLSUSvDSia23Otv
        9vQ+S3/x1cbDxjbiBy9rZLhdeIzhFbt9ekH/Wp7faEjVSn5+R0z9f1dZn5I983XxMJ6L4Tx+
        /GtlDmy+EtO2m8PXxm+vne7zD4rXXDJ+MO2ddK02oea6xu3ei87/UwR3Pmn6Jj2ncHfwvsgv
        ddNnfDIPzFNiKc5INNRiLipOBADRSBC6KAMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrBLMWRmVeSWpSXmKPExsVy+t/xe7rGO9NiDPb8kLHYOGM9q8X1L89Z
        Lc42vWG3uNUgY3F51xw2i8+9Rxgt1h65y25x6cACJovPGx4zWtxuXMFmsa/jAZPF4TftrA48
        HrMbLrJ4tOy7xe5x8N0eJo/3+66yefRtWcXo8XmTXABblJ5NUX5pSapCRn5xia1StKGFkZ6h
        pYWekYmlnqGxeayVkamSvp1NSmpOZllqkb5dgl7Gyssn2Qv62Cv6V9s2MP5i7WLk5JAQMJFY
        93YRcxcjF4eQwFJGie6NP5ggEmISk/ZtZ4ewhSX+XOtigyj6xCjx5tl1IIeDg01AT2LHqkKQ
        GhEBG4n3c8+wgNQwC/QzSTQt6QDbICzgKXG55RTYUBYBVYkzredZQGxeoPj8C3sZIRbISdw8
        18kMYnMKeEmcvvKTGWS+EFDNi57cCYx8CxgZVjGKpJYW56bnFhvqFSfmFpfmpesl5+duYgSG
        +rZjPzfvYLy0MfgQowAHoxIP74qM1Bgh1sSy4srcQ4wSHMxKIryca9JihHhTEiurUovy44tK
        c1KLDzGaAt00kVlKNDkfGId5JfGGpobmFpaG5sbmxmYWSuK85w0qo4QE0hNLUrNTUwtSi2D6
        mDg4pRoYXcq3TzrNsXb/RKZlWZ5ObPteT4zcoF1t81yQ50fel53cPg+t+eNv6Ti8/9paH7P1
        stV2fveH/2sePpiXVWXA/YVDwsEx1XCyxJwM//WHRRqmK032/c4vnMetbWz397HXVfkdXQXF
        B6MUnMu+zD4s4n+7yTri3n/OnzoWln4VCzhDP9QvOqGgxFKckWioxVxUnAgAOKMF7osCAAA=
X-CMS-MailID: 20190215130555eucas1p297d048d01902e2bb88e6db158d53fd88
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190215130555eucas1p297d048d01902e2bb88e6db158d53fd88
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190215130555eucas1p297d048d01902e2bb88e6db158d53fd88
References: <1550235913-5189-1-git-send-email-l.luba@partner.samsung.com>
        <CGME20190215130555eucas1p297d048d01902e2bb88e6db158d53fd88@eucas1p2.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch add basic tracing of the devfreq workqueue and delayed work.
It aims to capture changes of the polling intervals and device state.

Signed-off-by: Lukasz Luba <l.luba@partner.samsung.com>
---
 drivers/devfreq/devfreq.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
index 0ae3de7..660365a 100644
--- a/drivers/devfreq/devfreq.c
+++ b/drivers/devfreq/devfreq.c
@@ -29,6 +29,9 @@
 #include <linux/of.h>
 #include "governor.h"
 
+#define CREATE_TRACE_POINTS
+#include <trace/events/devfreq.h>
+
 static struct class *devfreq_class;
 
 /*
@@ -394,6 +397,8 @@ static void devfreq_monitor(struct work_struct *work)
 	queue_delayed_work(devfreq_wq, &devfreq->work,
 				msecs_to_jiffies(devfreq->profile->polling_ms));
 	mutex_unlock(&devfreq->lock);
+
+	trace_devfreq_monitor(devfreq);
 }
 
 /**
-- 
2.7.4

