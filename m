Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1B7BC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 18:58:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A69121900
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 18:58:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="FsIWpgjk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732572AbfBNS6L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 13:58:11 -0500
Received: from mailout1.w1.samsung.com ([210.118.77.11]:59283 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726360AbfBNS6L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 13:58:11 -0500
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20190214185809euoutp0153384747a552ca90a789b9f7fd69590d~DUAdqie9c2899128991euoutp01i
        for <linux-kernel@vger.kernel.org>; Thu, 14 Feb 2019 18:58:09 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20190214185809euoutp0153384747a552ca90a789b9f7fd69590d~DUAdqie9c2899128991euoutp01i
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1550170689;
        bh=Su1rPLTicRiOsH5SVc0+7ylWj2PWIwZR7g4kDCP0QnM=;
        h=From:To:Cc:Subject:Date:References:From;
        b=FsIWpgjky8D+YheeFgIvwKr2yKMcHih57Aja9CzPmyLkGk0z/xoh1iohFvn52XLTS
         LNvTdQjSYOlPxPGardkMD/vkbKWfhvTDfwrrYEVVk3lkq+EkzfggOud3WjK6q2xK+a
         ywYyRVfx0egJtIMLPfKeErg0UhIKqTXzTMu/Cmv8=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20190214185808eucas1p2fa970247e6efdc4f54eef46b264c7c8d~DUAc0PhUa0150201502eucas1p2L;
        Thu, 14 Feb 2019 18:58:08 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id 2E.D9.04806.04AB56C5; Thu, 14
        Feb 2019 18:58:08 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20190214185807eucas1p10432f753eeb3ce7c3e9ce8245a3aee20~DUAb6BOsQ3265232652eucas1p1G;
        Thu, 14 Feb 2019 18:58:07 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20190214185807eusmtrp2a4b684c609c28bfdbd1d07be60248f7b~DUAbrReJk1343513435eusmtrp2o;
        Thu, 14 Feb 2019 18:58:07 +0000 (GMT)
X-AuditID: cbfec7f5-367ff700000012c6-07-5c65ba40a7ee
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 40.39.04284.F3AB56C5; Thu, 14
        Feb 2019 18:58:07 +0000 (GMT)
Received: from AMDC3778.DIGITAL.local (unknown [106.120.51.20]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20190214185806eusmtip21a7e63625761f501e47e8f144c153985~DUAbHZl260560105601eusmtip2L;
        Thu, 14 Feb 2019 18:58:06 +0000 (GMT)
From:   Lukasz Luba <l.luba@partner.samsung.com>
To:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Cc:     b.zolnierkie@samsung.com, myungjoo.ham@samsung.com,
        cw00.choi@samsung.com, kyungmin.park@samsung.com,
        m.szyprowski@samsung.com, s.nawrocki@samsung.com, mka@chromium.org,
        rostedt@goodmis.org, mingo@redhat.com,
        Lukasz Luba <l.luba@partner.samsung.com>
Subject: [PATCH 0/2] tracing: drivers: devfreq: add basic trace mechanism
Date:   Thu, 14 Feb 2019 19:57:54 +0100
Message-Id: <1550170676-14173-1-git-send-email-l.luba@partner.samsung.com>
X-Mailer: git-send-email 2.7.4
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupileLIzCtJLcpLzFFi42LZduznOV2HXakxBgeXCVhsnLGe1eL6l+es
        Fmeb3rBb3GqQsbi8aw6bxefeI4wWa4/cZbe4dGABk8XnDY8ZLW43rmCz2NfxgMni8Jt2Vgce
        j9kNF1k8WvbdYvc4+G4Pk8f7fVfZPPq2rGL0+LxJLoAtissmJTUnsyy1SN8ugStjx7457AXX
        eSvWzTnF1MDYy93FyMkhIWAiMXXDedYuRi4OIYEVjBKrJn5gBUkICXxhlOg/HgmR+Mwo0XD3
        LxNMx4K+OSwQieWMElMev2OHcIA61vc1AWU4ONgE9CR2rCoEaRARsJJ40f4KrIZZoJlJ4lnb
        QhaQhLCAp8SktgWMIDaLgKrE/r5L7CA2r4CXRMPzT8wQ2+Qkbp7rZAZplhBoZpdY0tvICJFw
        kZgxYz+ULSzx6vgWdghbRuL/zvlQpxZLnO1YxQZh10i0n9wBVWMtcfj4RVaQQ5kFNCXW79KH
        CDtKdLcfYwQJSwjwSdx4KwgSZgYyJ22bzgwR5pXoaBOCqNaQ2NJzAWqRmMTyNdOghntIvJ/V
        Cw3EWIm71zqZJzDKzULYtYCRcRWjeGppcW56arFxXmq5XnFibnFpXrpecn7uJkZgCjn97/jX
        HYz7/iQdYhTgYFTi4V2RkRojxJpYVlyZe4hRgoNZSYT39TagEG9KYmVValF+fFFpTmrxIUZp
        DhYlcd5qhgfRQgLpiSWp2ampBalFMFkmDk6pBkbOnv19EjdXJc5n3MvVrfp5aY9KevhSiWfB
        IZYlMm0LT933VrO3XSY045l63he7949inA2C/b36/q7Odkib/7XI4MbHFTbrKo6e5z57p3uJ
        8EWllCnzuMSTi1b9bU3Y9vHS5d5vnqbTr/2ufeQYt/NUe8ws8+Tu5VL7RJuWvmH9ovmJMXub
        yC8lluKMREMt5qLiRAC0VB2FHQMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrILMWRmVeSWpSXmKPExsVy+t/xe7r2u1JjDL52illsnLGe1eL6l+es
        Fmeb3rBb3GqQsbi8aw6bxefeI4wWa4/cZbe4dGABk8XnDY8ZLW43rmCz2NfxgMni8Jt2Vgce
        j9kNF1k8WvbdYvc4+G4Pk8f7fVfZPPq2rGL0+LxJLoAtSs+mKL+0JFUhI7+4xFYp2tDCSM/Q
        0kLPyMRSz9DYPNbKyFRJ384mJTUnsyy1SN8uQS9jx7457AXXeSvWzTnF1MDYy93FyMkhIWAi
        saBvDksXIxeHkMBSRonVPSuYIBJiEpP2bWeHsIUl/lzrYgOxhQQ+MUpsWlXUxcjBwSagJ7Fj
        VSFIWETARuL93DNgc5gF+pkkmpZ0sIIkhAU8JSa1LWAEsVkEVCX2910Cm8kr4CXR8PwTM8R8
        OYmb5zqZJzDyLGBkWMUoklpanJueW2yoV5yYW1yal66XnJ+7iREYvNuO/dy8g/HSxuBDjAIc
        jEo8vCsyUmOEWBPLiitzDzFKcDArifC+3gYU4k1JrKxKLcqPLyrNSS0+xGgKtHwis5Rocj4w
        svJK4g1NDc0tLA3Njc2NzSyUxHnPG1RGCQmkJ5akZqemFqQWwfQxcXBKNTDOTIu37Vgo2fTu
        sG5V4BV2Fsk/q3hmGnvt2m08V0FEInfpnlXbXqmfYvD5wKzLOF9K0dth/p3/PMX/2+ZUmuW8
        0PL6eHaWsYuyuHlxUsmdSdsqFQvm1f7ZufPIDbGNNt0cpmqaLzT7ihsTW8/tTfkQpLNrPa/m
        eWHt9L+5jB+sDvXcPcZvHavEUpyRaKjFXFScCACwT1WfdAIAAA==
X-CMS-MailID: 20190214185807eucas1p10432f753eeb3ce7c3e9ce8245a3aee20
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190214185807eucas1p10432f753eeb3ce7c3e9ce8245a3aee20
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190214185807eucas1p10432f753eeb3ce7c3e9ce8245a3aee20
References: <CGME20190214185807eucas1p10432f753eeb3ce7c3e9ce8245a3aee20@eucas1p1.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

This patch set adds support for tracing in devfreq framework. It is related
to the discussion regarding devfreq workqueue mechanism and wake-ups.
These two tracing patches have been submitted in larger patch set, which
needs more discussion. For the further discussion and development there
is a need of measurements/testing, though. It was agreed that trace events
would help. The whole discussion is here [1].

With these patches it is possible to capture current behaviour for the 
devfreq subsystem and devices such as when and which workqueue is used,
on which CPU, what is the load and frequency of the device.

A few comments for the first version has been addressed here:
- moved long '/' operation to post-processing phase, according to Seven's
  comments [2] 
- re-ordered fields in the structure to avoid holes, according to Seven's
  comments [3] 
- removed unneeded variable, according to Chanwoo's comment [4]

I did not dare to add 'Reviewed-by: Chanwoo Choi <cw00.choi@samsung.com>'
for the 1st patch, which was in [5], since the code slightly changed.
The 2nd patch has it. 

Regards,
Lukasz Luba

[1] https://lkml.org/lkml/2019/2/12/1179
[2] https://lkml.org/lkml/2019/2/12/1201
[3] https://lkml.org/lkml/2019/2/13/532
[4] https://lkml.org/lkml/2019/2/13/1587
[5] https://lkml.org/lkml/2019/2/14/2

Lukasz Luba (2):
  trace: events: add devfreq trace event file
  drivers: devfreq: add tracing for scheduling work

 MAINTAINERS                    |  1 +
 drivers/devfreq/devfreq.c      |  8 ++++++++
 include/trace/events/devfreq.h | 42 ++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 51 insertions(+)
 create mode 100644 include/trace/events/devfreq.h

-- 
2.7.4

