Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91C67C282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 22:24:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B350222C0
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 22:24:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="PeVHQkz7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731936AbfBLWY1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 17:24:27 -0500
Received: from mailout2.w1.samsung.com ([210.118.77.12]:43112 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726654AbfBLWY1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 17:24:27 -0500
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20190212222425euoutp02916f500a7a3994f220a4314e9d6c1e3d~Cvh-O8AkK2691126911euoutp02V
        for <linux-kernel@vger.kernel.org>; Tue, 12 Feb 2019 22:24:25 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20190212222425euoutp02916f500a7a3994f220a4314e9d6c1e3d~Cvh-O8AkK2691126911euoutp02V
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1550010265;
        bh=fxhyOv8Mb1Y1xGEZiG9K0FtpXxR6Cv0FVq5EcMn37dQ=;
        h=From:To:Cc:Subject:Date:References:From;
        b=PeVHQkz7bUya89Uhnuuob4oP5csc1CHNkas3kL6rvegky+e9/JckcA+sN5lsWQdL/
         ViKgnL4gh3cLgmDIs2rgugeQjspQdMJTcUnIsPmqmv6l0gBaFeVCliPum6QzNo9CoR
         TmRcuIPM+s1cAMcvLxUGc112cYEdETrQ0QfdrdXU=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20190212222424eucas1p18570f6e241fa8e1ec37f244c3aaa398a~Cvh_D9pZq2825528255eucas1p1U;
        Tue, 12 Feb 2019 22:24:24 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id 4B.0F.04806.897436C5; Tue, 12
        Feb 2019 22:24:24 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20190212222422eucas1p1624203db4db3e495035820dea542e23a~Cvh8g4dns3241332413eucas1p1U;
        Tue, 12 Feb 2019 22:24:22 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20190212222422eusmtrp13e8027a4ed621920e6364d5a60cef0ed~Cvh8R-Xrr2311323113eusmtrp1e;
        Tue, 12 Feb 2019 22:24:22 +0000 (GMT)
X-AuditID: cbfec7f5-34dff700000012c6-78-5c6347988ce1
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id EB.2C.04284.697436C5; Tue, 12
        Feb 2019 22:24:22 +0000 (GMT)
Received: from AMDC3778.DIGITAL.local (unknown [106.120.51.20]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20190212222421eusmtip10c1d3201ed5dad657c1e3bb6c61a7bb6~Cvh7n-m4m0525605256eusmtip13;
        Tue, 12 Feb 2019 22:24:21 +0000 (GMT)
From:   Lukasz Luba <l.luba@partner.samsung.com>
To:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Cc:     b.zolnierkie@samsung.com, myungjoo.ham@samsung.com,
        cw00.choi@samsung.com, kyungmin.park@samsung.com,
        m.szyprowski@samsung.com, s.nawrocki@samsung.com, tkjos@google.com,
        joel@joelfernandes.org, chris.diamand@arm.com, mka@chromium.org,
        rostedt@goodmis.org, mingo@redhat.com,
        Lukasz Luba <l.luba@partner.samsung.com>
Subject: [PATCH v3 0/7] drivers: devfreq: fix and optimize workqueue
 mechanism
Date:   Tue, 12 Feb 2019 23:23:51 +0100
Message-Id: <1550010238-24002-1-git-send-email-l.luba@partner.samsung.com>
X-Mailer: git-send-email 2.7.4
X-Brightmail-Tracker: H4sIAAAAAAAAA0WSfSxVYRzHPfe83MO6OS7xTKa5G6WWl/THszKrZnPKVqr1T6GO63DNa/d4
        rVZX8z4ihCRvK25SdJndGSYv987EklphySqFcM1lTaPldqj/Pr/P7/t7nt+zPRQmrSXsqYiY
        eE4Zw0bJSAu8Tbc2fLDMTx7osV6IoxdlTQQqWR7F0fuV7wSqUzmjodvzYjSuckCj7RUkMub1
        AfSs76MYvemuFiFj8xeAJlLVJOrKmhKh3vlMAhmK+GOWTGNlI2AeqEZwJq1rXMxUaxKYmuVV
        gnm52CFiDF3vSOZOawNgjBrHAPOLFt6hXFREIqd097liocif2QBxOttkdc4PQgU+WeUAioL0
        YVhuiMwBFpSUVgPYq1sGQrECYLqxgBQKI4DNP8fA9sTauIPg6wHU3y3H/008qughTSGSdoPa
        hqs5wJyyoY/Amcw5sSmD0ToRXO4sxkwNazoAGjKrCBPjtDO8V9vx10voUzB1KV1kYkg7wrHh
        bEzg52KYPRMvsC98WztLCGwN5/StYoEd4GBRLi4wD4eyGkiBb8DMAe1W5ijs1Y8Qpj0x2hU2
        tbsL+jhcqJ/AhTfuhB8WrEwa28TCtlJM0BKYlSEV0vtga+7rrSVtYX1jydbhDFybnBSZ4lI6
        CPbNnSgAjuX/r6oGoAHYcQl8dDjHe8VwSW48G80nxIS7yWOjNWDz5wz+1q9qQdd6SA+gKSDb
        IVH3hwRKCTaRT4nuAZDCZDaSk97yQKkklE25xiljLysToji+B+ymcJmd5LrZ1CUpHc7Gc5Ec
        F8cpt7siytxeBfJy5SOBlg+TPwe0KMI6L0Qa1P6DTk6y6q9KbenNRfKb54rXUnCnR4sTenxo
        ek+4Zu3skzrLSORjaeYKX81yTQPp6sK958okZruwNP+nSerYqgO3XMqCdEzNqEKvnA7uDXOX
        K1i/lv6IptOV7V6sb4HLr26f4o3zZ+iM+1Pe+TKcV7Ce+zElz/4BgNpnSjUDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrDLMWRmVeSWpSXmKPExsVy+t/xu7rT3JNjDDZMFbXYOGM9q8W0T5dZ
        LK5/ec5qsaxB1eJs0xt2i1sNMhaXd81hs/jce4TRYu2Ru+wWlw4sYLL4vOExo8XtxhVsFvs6
        HjBZHH7TzmrxfnKxA7/HmnlrGD1mN1xk8WjZd4vdY8GmUo+Fn76yehx8t4fJ4/2+q2wefVtW
        MXp83iQXwBmlZ1OUX1qSqpCRX1xiqxRtaGGkZ2hpoWdkYqlnaGwea2VkqqRvZ5OSmpNZllqk
        b5egl9H/4i9jwTGxihVdr1kbGO8LdjFycEgImEj8vCXTxcjFISSwlFHiXts09i5GTqC4mMSk
        fduhbGGJP9e62CCKPjFK3NiykB2kmU1AT2LHqkKQGhEBG4n3c8+wgNQwC1xjkrjdcZ8VJCEs
        4CfRM+E9I4jNIqAqMXXRHmYQm1fAS6LxQysTxAI5iZvnOpknMPIsYGRYxSiSWlqcm55bbKhX
        nJhbXJqXrpecn7uJERjy24793LyD8dLG4EOMAhyMSjy8K44mxQixJpYVV+YeYpTgYFYS4fW0
        SY4R4k1JrKxKLcqPLyrNSS0+xGgKtHwis5Rocj4wHvNK4g1NDc0tLA3Njc2NzSyUxHnPG1RG
        CQmkJ5akZqemFqQWwfQxcXBKNTBO2Xt3w7ffd1YsrtDIkNVZPF80YerP6QE/J/zYeWdycJ3g
        PaP2R45zHR+yzkjbL77D7Jx3evrZgr71N6+93Ck7N3kjz7zJf5YEvzr2/9J7sX+XWerVGM3c
        57Id+mgw676ZxFbB5wZMsc2czw1v6ijULC+KWneoVI5d+WqWoLFuqMaaTas77dT3KrEUZyQa
        ajEXFScCALnJzWKPAgAA
X-CMS-MailID: 20190212222422eucas1p1624203db4db3e495035820dea542e23a
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190212222422eucas1p1624203db4db3e495035820dea542e23a
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190212222422eucas1p1624203db4db3e495035820dea542e23a
References: <CGME20190212222422eucas1p1624203db4db3e495035820dea542e23a@eucas1p1.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch set changes workqueue related features in devfreq framework.
First patch switches to delayed work instead of deferred.
The second switches to regular system work and deletes custom 'devfreq'.

Using deferred work in this context might harm the system performance.
When the CPU enters idle, deferred work is not fired. The devfreq device's
utilization does not have to be connected with a particular CPU.
The drivers for GPUs, Network on Chip, cache L3 rely on devfreq governor.
They all are missing opportunity to check the HW state and react when
the deferred work is not fired.
A corner test case, when Dynamic Memory Controller is utilized by CPUs running
on full speed, might show x5 worse performance if the crucial CPU is in idle.

There was a discussion regarding v2 that the power usage because of waking up
an idle CPU would be too high. In my opinion it won't and fixing bug is more
important than < 1% more power used [1].
I have addressed also this issue. In this patch set there is a mechanism
which prevents from to frequent checks when there is no need.
When the device enters its lowest state (OPP) the framework sets polling
interval to 'polling_idle_ms'. In default Kconfig it is 500ms, so 2 times per
second.
It is tunable from the sysfs interface per device, thus driver developer can
experiment and choose best intervals for the system.

Changes:
v3:
- reordered first two patches
- added functionality to lower power consumption when the device is less busy;
  there is a new polling interval enabled when device enters lowest frequency;
- added trace events to capture the behaviour of the system
v2:
- single patch split into two
- added cover letter

link for the previous version and discussion:
https://marc.info/?l=linux-pm&m=154989907416072&w=2
https://marc.info/?l=linux-pm&m=154904631226997&w=2

Regards,
Lukasz Luba

[1] https://marc.info/?l=linux-kernel&m=155000641622443&w=2

Lukasz Luba (7):
  drivers: devfreq: change deferred work into delayed
  drivers: devfreq: change devfreq workqueue mechanism
  Kconfig: drivers: devfreq: add default idle polling
  include: devfreq: add polling_idle_ms to 'profile'
  drivers: devfreq: add longer polling interval in idle
  trace: events: add devfreq trace event file
  drivers: devfreq: add tracing for scheduling work

 MAINTAINERS                               |   1 +
 drivers/devfreq/Kconfig                   |  13 +++
 drivers/devfreq/devfreq.c                 | 184 ++++++++++++++++++++++++------
 drivers/devfreq/governor.h                |   3 +-
 drivers/devfreq/governor_simpleondemand.c |   6 +-
 include/linux/devfreq.h                   |   6 +
 include/trace/events/devfreq.h            |  39 +++++++
 7 files changed, 218 insertions(+), 34 deletions(-)
 create mode 100644 include/trace/events/devfreq.h

-- 
2.7.4

