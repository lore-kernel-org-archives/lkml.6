Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BD8BC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 18:24:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C89F8217D7
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 18:24:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="oNAzwyC/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390384AbfBRSYr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 13:24:47 -0500
Received: from mailout2.w1.samsung.com ([210.118.77.12]:37650 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392069AbfBRSVc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 13:21:32 -0500
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20190218182130euoutp0272ff2e76e4828c8cd6883991f3558724~EiFnF6WgA3120931209euoutp02x
        for <linux-kernel@vger.kernel.org>; Mon, 18 Feb 2019 18:21:30 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20190218182130euoutp0272ff2e76e4828c8cd6883991f3558724~EiFnF6WgA3120931209euoutp02x
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1550514090;
        bh=OkY6lRvYM88PwmxXw0VoZAdgJpDbCNwILmynIm+Zug0=;
        h=From:To:Cc:Subject:Date:References:From;
        b=oNAzwyC/T4hay/ppBVwBslrxSuWVlz9wmKnq0rOCcaMxSt2XzD33Epkd39scsxvLJ
         XgSwHEqIxjPHRR/rtwBUEL9YySzUXAsTjndg5p+cHD4//5VgtDSqF22RYCTUbHvHlj
         3L9wysiZ2I7Zciv/EGar2XE9dLXzQEsmi4QrjTlQ=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20190218182129eucas1p156e1968d5736f62a0de0ab347fff0d92~EiFmLhdTL0369503695eucas1p16;
        Mon, 18 Feb 2019 18:21:29 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id 43.1D.04806.9A7FA6C5; Mon, 18
        Feb 2019 18:21:29 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20190218182128eucas1p1bac39e9f11572143697b5cb854b2eb87~EiFk9W3Yx0369603696eucas1p1y;
        Mon, 18 Feb 2019 18:21:28 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20190218182128eusmtrp2e85903663f486544cab6b6a7f309dfa0~EiFkufyDZ1181111811eusmtrp2d;
        Mon, 18 Feb 2019 18:21:28 +0000 (GMT)
X-AuditID: cbfec7f5-34dff700000012c6-6f-5c6af7a98d45
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 69.81.04284.8A7FA6C5; Mon, 18
        Feb 2019 18:21:28 +0000 (GMT)
Received: from AMDC3778.DIGITAL.local (unknown [106.120.51.20]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20190218182127eusmtip10b3f8edad688ba714e3386a70bdef19a~EiFkNkT211423114231eusmtip1k;
        Mon, 18 Feb 2019 18:21:27 +0000 (GMT)
From:   Lukasz Luba <l.luba@partner.samsung.com>
To:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Cc:     b.zolnierkie@samsung.com, myungjoo.ham@samsung.com,
        cw00.choi@samsung.com, kyungmin.park@samsung.com,
        m.szyprowski@samsung.com, s.nawrocki@samsung.com, mka@chromium.org,
        rostedt@goodmis.org, mingo@redhat.com,
        Lukasz Luba <l.luba@partner.samsung.com>
Subject: [PATCH v3 0/2] tracing: drivers: devfreq: add basic trace mechanism
Date:   Mon, 18 Feb 2019 19:21:07 +0100
Message-Id: <1550514069-9237-1-git-send-email-l.luba@partner.samsung.com>
X-Mailer: git-send-email 2.7.4
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupgleLIzCtJLcpLzFFi42LZduzned2V37NiDD6cULLYOGM9q8X1L89Z
        Lc42vWG3uNUgY3F51xw2i8+9Rxgt1h65y25x6cACJovPGx4zWtxuXMFmsa/jAZPF4TftrA48
        HrMbLrJ4tOy7xe5x8N0eJo/3+66yefRtWcXo8XmTXABbFJdNSmpOZllqkb5dAlfGqhVL2Aq+
        81cs+WfUwPiep4uRk0NCwETi8JF/zF2MXBxCAisYJb7372UGSQgJfGGUeL6lDiLxmVHi05R5
        jDAds+fvYIVILGeUONnewQLhAHX8WHSNrYuRg4NNQE9ix6pCkAYRASuJF+2v2EFqmAWamSSe
        tS1kAakRFvCRaGg1BalhEVCVmLaxH2wzr4CnxKN/y1khlslJ3DzXCXaehMBvNokdk18xQSRc
        JD7Pb4SyhSVeHd/CDmHLSPzfOR8qXixxtmMVG4RdI9F+cgdUjbXE4eMXWUFuYBbQlFi/Sx8i
        7Cixomcl2GkSAnwSN94KgoSZgcxJ26YzQ4R5JTrahCCqNSS29FyAWiQmsXzNNKjhHhLbpp9j
        goRhrMSxg2/YJjDKzULYtYCRcRWjeGppcW56arFxXmq5XnFibnFpXrpecn7uJkZg+jj97/jX
        HYz7/iQdYhTgYFTi4V2wPCtGiDWxrLgy9xCjBAezkgjvsRtAId6UxMqq1KL8+KLSnNTiQ4zS
        HCxK4rzVDA+ihQTSE0tSs1NTC1KLYLJMHJxSDYw3li53fxh2hMcw6bMs42W57HbH2x5Nf3kq
        DsqI9v5esK3i4LLT72Le3WEQ37Ir56xk52y+7Xt6I7zLMqp6e7T7J7/oLXNnKQkMjmVKnb7h
        1dVZim6yzWZ7zsywPGjcvvNLEDffLfZvd7kj55bMv5PQ/+VbzsrtF6dcO/s2Zdqr31c3Bkt4
        rIxTYinOSDTUYi4qTgQAgAlIahsDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrHLMWRmVeSWpSXmKPExsVy+t/xu7orvmfFGExfJ2yxccZ6VovrX56z
        WpxtesNucatBxuLyrjlsFp97jzBarD1yl93i0oEFTBafNzxmtLjduILNYl/HAyaLw2/aWR14
        PGY3XGTxaNl3i93j4Ls9TB7v911l8+jbsorR4/MmuQC2KD2bovzSklSFjPziElulaEMLIz1D
        Sws9IxNLPUNj81grI1MlfTublNSczLLUIn27BL2MVSuWsBV8569Y8s+ogfE9TxcjJ4eEgInE
        7Pk7WEFsIYGljBITPlVCxMUkJu3bzg5hC0v8udbFBlHziVFi7nvDLkYODjYBPYkdqwpBwiIC
        NhLv555h6WLk4mAW6GeSaFrSwQpSIyzgI9HQagpSwyKgKjFtYz8ziM0r4Cnx6N9yVojxchI3
        z3UyT2DkWcDIsIpRJLW0ODc9t9hQrzgxt7g0L10vOT93EyMwbLcd+7l5B+OljcGHGAU4GJV4
        eBcsz4oRYk0sK67MPcQowcGsJMJ77AZQiDclsbIqtSg/vqg0J7X4EKMp0PKJzFKiyfnAmMor
        iTc0NTS3sDQ0NzY3NrNQEuc9b1AZJSSQnliSmp2aWpBaBNPHxMEp1cCYe/vpgwhmPyHLcxo1
        m7/dSjl+KGPblNd1OVZlvv/q86w1PE5oVbryfpW47ZbgYGIUUVF2v2Ey56XPrkuFN15P/P3D
        KuNQimhL3Oe+Er3XrGLh19dKfwyMPzLr2qyrzq9j3soVtLmGSkTP6IjImKMsr9j+zl53j2Fs
        5C49mc6AP/YNHBKG35VYijMSDbWYi4oTAREGojRxAgAA
X-CMS-MailID: 20190218182128eucas1p1bac39e9f11572143697b5cb854b2eb87
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190218182128eucas1p1bac39e9f11572143697b5cb854b2eb87
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190218182128eucas1p1bac39e9f11572143697b5cb854b2eb87
References: <CGME20190218182128eucas1p1bac39e9f11572143697b5cb854b2eb87@eucas1p1.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

This is v3 which addresses suggestions from reviews.

This patch set adds support for tracing in devfreq framework. It is related
to the discussion regarding devfreq workqueue mechanism and wake-ups.
These two tracing patches have been submitted in larger patch set, which
needs more discussion. For the further discussion and development there
is a need of measurements/testing, though. It was agreed that trace events
would help. The whole discussion is here [1].

With these patches it is possible to capture current behaviour for the 
devfreq subsystem and devices such as when and which workqueue is used,
on which CPU, what is the load and frequency of the device.

v3:
- change 'load' value to 0 when 'total_time' is equal to 0,
- re-base on top of v5.0-rc7
v2:
- simplified arguments list, according to Steven's comments, with only
  one arg: 'devfreq' and the rest fields taken from there,
v1:
- moved long '/' operation to post-processing phase, according to Seven's
  comments [2] 
- re-ordered fields in the structure to avoid holes, according to Seven's
  comments [3] 
- removed unneeded variable, according to Chanwoo's comment [4]
basic in larget patch set:
- added support for trace events

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
 drivers/devfreq/devfreq.c      |  5 +++++
 include/trace/events/devfreq.h | 40 ++++++++++++++++++++++++++++++++++++++++
 3 files changed, 46 insertions(+)
 create mode 100644 include/trace/events/devfreq.h

-- 
2.7.4

