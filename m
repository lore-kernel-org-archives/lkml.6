Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7750C169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 15:30:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6DC88222A7
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 15:30:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="PhjfGmVB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389518AbfBKPau (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 10:30:50 -0500
Received: from mailout2.w1.samsung.com ([210.118.77.12]:44383 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387658AbfBKPaj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 10:30:39 -0500
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20190211153038euoutp029528efe8c2e21b9cb89b24bc201797be~CWPazJq2x0337003370euoutp02z
        for <linux-kernel@vger.kernel.org>; Mon, 11 Feb 2019 15:30:38 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20190211153038euoutp029528efe8c2e21b9cb89b24bc201797be~CWPazJq2x0337003370euoutp02z
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1549899038;
        bh=iZNbU3hmnXw0xfWxPScdUv+9QbhmsMCOAZDV9PAQsXA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PhjfGmVBI4k/m50GFcmG/UnBziVSsr55PfG1yoKg7Jxi2EAIB3LYdPAK5sZMYWObc
         W2gTsTReI+P8q4xw3D8EtM2q/bSH4Q7TmSduhpFLCDOmwLPGrfQwyMi9JbJf4g6kM+
         w1Z0K7BRQ/Keokaxl4pZVuYMPAvecTqFo4hvPKAU=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20190211153037eucas1p1d4d8a65f0338177232d86a7ee091ceda~CWPaVeZLV1161511615eucas1p1g;
        Mon, 11 Feb 2019 15:30:37 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id F5.F4.04806.D15916C5; Mon, 11
        Feb 2019 15:30:37 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20190211153037eucas1p20b80e44795e3599dabd9c2fc0291c063~CWPZkULYp2542525425eucas1p24;
        Mon, 11 Feb 2019 15:30:37 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20190211153036eusmtrp18836f963a6412fcd44145f88061f7d43~CWPZVcEWh0170801708eusmtrp1B;
        Mon, 11 Feb 2019 15:30:36 +0000 (GMT)
X-AuditID: cbfec7f5-34dff700000012c6-a1-5c61951ddd71
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id AF.C1.04128.C15916C5; Mon, 11
        Feb 2019 15:30:36 +0000 (GMT)
Received: from AMDC3778.DIGITAL.local (unknown [106.120.51.20]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20190211153036eusmtip162663b36549b3bc2517b4d9ca6281bc3~CWPYuPO_42441124411eusmtip1y;
        Mon, 11 Feb 2019 15:30:36 +0000 (GMT)
From:   Lukasz Luba <l.luba@partner.samsung.com>
To:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Cc:     b.zolnierkie@samsung.com, myungjoo.ham@samsung.com,
        cw00.choi@samsung.com, kyungmin.park@samsung.com,
        m.szyprowski@samsung.com, s.nawrocki@samsung.com, tkjos@google.com,
        joel@joelfernandes.org, chris.diamand@arm.com, mka@chromium.org,
        Lukasz Luba <l.luba@partner.samsung.com>
Subject: [PATCH v2 2/2] drivers: devfreq: change deferred work into delayed
Date:   Mon, 11 Feb 2019 16:30:05 +0100
Message-Id: <1549899005-7760-3-git-send-email-l.luba@partner.samsung.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1549899005-7760-1-git-send-email-l.luba@partner.samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprDKsWRmVeSWpSXmKPExsWy7djP87qyUxNjDA7fV7HYOGM9q8W0T5dZ
        LK5/ec5qsaxB1eJs0xt2i1sNMhaXd81hs/jce4TRYu2Ru+wWnzc8ZrS43biCzeLwm3ZWi/eT
        ix14PdbMW8PoMbvhIovHgk2lHgs/fWX1OPhuD5NH35ZVjB6fN8kFsEdx2aSk5mSWpRbp2yVw
        Zayf6lCwnauia/IC1gbG1xxdjJwcEgImEus/3WDrYuTiEBJYwSgx8fUnJgjnC6NEy9E7LCBV
        QgKfGSU2fwiB6ehZOI0domg5o8Sjm5ugioA65s5J62Lk4GAT0JPYsaoQJCwiYCXxov0VWD2z
        wHwmiTNd61hBEsIC3hI933qZQGwWAVWJdS1PmUFsXgFPiRdvu9ghlslJ3DzXCRbnFPCSuLXu
        KtipEgLL2CXmb98HVeQi8f3QVBYIW1ji1fEtUHEZidOTe6DixRJnO1axQdg1Eu0nd0DVWEsc
        Pn6RFeRoZgFNifW79CHCjhLnNrWzgYQlBPgkbrwVBAkzA5mTtk1nhgjzSnS0CUFUa0hs6bnA
        BGGLSSxfMw1quIfE7LeXoIE7l1Hi8rE9bBMY5WchLFvAyLiKUTy1tDg3PbXYOC+1XK84Mbe4
        NC9dLzk/dxMjMM2c/nf86w7GfX+SDjEKcDAq8fBW5CfGCLEmlhVX5h5ilOBgVhLhTZoCFOJN
        SaysSi3Kjy8qzUktPsQozcGiJM5bzfAgWkggPbEkNTs1tSC1CCbLxMEp1cBYMu9q/ETno9fN
        chcrOUlvmuTqLhj0e/f9VWZZq/eV74v47Rjlu0HNVrr409uDX9Yr7oyKz71/5f0TC/OuzboX
        1jolu7wsN8h3/BSe6vPmWnTop68pP+vvTrrn2fEr9racNW/F1p2PxI0VZ57JmGVbdD38fIxp
        nfqWc9Kp6t9+nj5+gOPKr7NlSizFGYmGWsxFxYkAHCeYrC8DAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpgkeLIzCtJLcpLzFFi42I5/e/4XV2ZqYkxBquatCw2zljPajHt02UW
        i+tfnrNaLGtQtTjb9Ibd4laDjMXlXXPYLD73HmG0WHvkLrvF5w2PGS1uN65gszj8pp3V4v3k
        YgdejzXz1jB6zG64yOKxYFOpx8JPX1k9Dr7bw+TRt2UVo8fnTXIB7FF6NkX5pSWpChn5xSW2
        StGGFkZ6hpYWekYmlnqGxuaxVkamSvp2NimpOZllqUX6dgl6GeunOhRs56romryAtYHxNUcX
        IyeHhICJRM/CaexdjFwcQgJLGSU2Tz3KCpEQk5i0bzs7hC0s8edaFxtE0SdGiXdn1rF0MXJw
        sAnoSexYVQhSIyJgI/F+7hkWkBpmgdVMEj+P97KBJIQFvCV6vvUygdgsAqoS61qeMoPYvAKe
        Ei/edkEtkJO4ea4TLM4p4CVxa91VsF4hoJqGPx/YJzDyLWBkWMUoklpanJueW2ykV5yYW1ya
        l66XnJ+7iREY+tuO/dyyg7HrXfAhRgEORiUeXoXcxBgh1sSy4srcQ4wSHMxKIrxJU4BCvCmJ
        lVWpRfnxRaU5qcWHGE2BjprILCWanA+My7ySeENTQ3MLS0NzY3NjMwslcd7zBpVRQgLpiSWp
        2ampBalFMH1MHJxSDYw7FA8lsVQv+2p8ct3q6g8SZ/nOzAl/lj9bhvmmxNVzs/sDP/9POxm0
        KOTDnJ23vqqkhrFrX1CxevJaX8xu4cqdi2Mu1/u8+hDvubjYKlyNpUsoSyd30/NJme1srCkr
        P27luHVXoG7n3n9Tfrfv8jrn4emcd5Hde3Faftty91ObPq9LMthvMuGxEktxRqKhFnNRcSIA
        9CREvZMCAAA=
X-CMS-MailID: 20190211153037eucas1p20b80e44795e3599dabd9c2fc0291c063
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190211153037eucas1p20b80e44795e3599dabd9c2fc0291c063
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190211153037eucas1p20b80e44795e3599dabd9c2fc0291c063
References: <1549899005-7760-1-git-send-email-l.luba@partner.samsung.com>
        <CGME20190211153037eucas1p20b80e44795e3599dabd9c2fc0291c063@eucas1p2.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch changes deferred work to delayed work, which is now not missed
when timer is put on CPU that entered idle state.
The devfreq framework governor was not called, thus changing the device's
frequency did not happen.
Benchmarks for stressing Dynamic Memory Controller show x2 (in edge cases
even x5) performance boost with this patch when 'simpleondemand_governor'
is responsible for monitoring the device load and frequency changes.

With this patch, the delayed work is done no mater CPUs' idle.
All of the drivers in devfreq which rely on periodic, guaranteed wakeup
intervals should benefit from it.

Signed-off-by: Lukasz Luba <l.luba@partner.samsung.com>
---
 drivers/devfreq/devfreq.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
index 882e717..c200b3c 100644
--- a/drivers/devfreq/devfreq.c
+++ b/drivers/devfreq/devfreq.c
@@ -400,7 +400,7 @@ static void devfreq_monitor(struct work_struct *work)
  */
 void devfreq_monitor_start(struct devfreq *devfreq)
 {
-	INIT_DEFERRABLE_WORK(&devfreq->work, devfreq_monitor);
+	INIT_DELAYED_WORK(&devfreq->work, devfreq_monitor);
 	if (devfreq->profile->polling_ms)
 		schedule_delayed_work(&devfreq->work,
 			msecs_to_jiffies(devfreq->profile->polling_ms));
-- 
2.7.4

