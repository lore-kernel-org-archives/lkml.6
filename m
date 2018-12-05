Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FF85C04EB9
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 11:06:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F28A62082B
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 11:06:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="oz+LRLzT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F28A62082B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=partner.samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727716AbeLELGy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 06:06:54 -0500
Received: from mailout2.w1.samsung.com ([210.118.77.12]:53284 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727447AbeLELGY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 06:06:24 -0500
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20181205110622euoutp0245b6e42ccb434da524eb6111aea8250d~taxR4KFM00210202102euoutp02W
        for <linux-kernel@vger.kernel.org>; Wed,  5 Dec 2018 11:06:22 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20181205110622euoutp0245b6e42ccb434da524eb6111aea8250d~taxR4KFM00210202102euoutp02W
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1544007982;
        bh=RttaSuYsdrhZVNquhEdaCMsC9uRDqEtNN9PxfKoRjA4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=oz+LRLzTFGqcJdBOL9+evNX/REFY0m8eFE6iEb2Lfi88gQEwDcGarM5Yug1iYFxGf
         STjgZSEmDbkxrFPmiCHUJk9vBmYopI9sSSDtlTWFmB+gmjrt5xD93kzzDzRnkXypnP
         WsxjMGNGq2415ZA3tXAXK62InvPa5XG1TAg4DIIw=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20181205110621eucas1p154269306679bdae7a4ebd38971834ead~taxQznU7X1455414554eucas1p1K;
        Wed,  5 Dec 2018 11:06:21 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id 54.AB.04806.D21B70C5; Wed,  5
        Dec 2018 11:06:21 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20181205110620eucas1p14de70dc092580b684a0304b5ce771605~taxQAL0V11457014570eucas1p1D;
        Wed,  5 Dec 2018 11:06:20 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20181205110620eusmtrp2a41be8a87e68ac1d977d5f549b9accb2~taxPwb_uB2749027490eusmtrp2i;
        Wed,  5 Dec 2018 11:06:20 +0000 (GMT)
X-AuditID: cbfec7f5-79db79c0000012c6-4c-5c07b12da7d1
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id F3.72.04128.C21B70C5; Wed,  5
        Dec 2018 11:06:20 +0000 (GMT)
Received: from AMDC3778.DIGITAL.local (unknown [106.120.51.20]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20181205110619eusmtip1bf8b9d1eb7ba11c3e19d535702fb78e0~taxO0knQl2314923149eusmtip1U;
        Wed,  5 Dec 2018 11:06:19 +0000 (GMT)
From:   Lukasz Luba <l.luba@partner.samsung.com>
To:     linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org
Cc:     tjakobi@math.uni-bielefeld.de, myungjoo.ham@samsung.com,
        kyungmin.park@samsung.com, cw00.choi@samsung.com,
        rjw@rjwysocki.net, len.brown@intel.com, pavel@ucw.cz,
        gregkh@linuxfoundation.org, keescook@chromium.org,
        anton@enomsg.org, ccross@android.com, tony.luck@intel.com,
        robh+dt@kernel.org, mark.rutland@arm.com, kgene@kernel.org,
        krzk@kernel.org, m.szyprowski@samsung.com,
        b.zolnierkie@samsung.com, Lukasz Luba <l.luba@partner.samsung.com>
Subject: [PATCH v3 2/5] devfreq: add support for suspend/resume of a devfreq
 device
Date:   Wed,  5 Dec 2018 12:05:53 +0100
Message-Id: <1544007956-28889-3-git-send-email-l.luba@partner.samsung.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1544007956-28889-1-git-send-email-l.luba@partner.samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA0VSfUyMcRz3e95rrj0u4yepdmiylQzbz4ox/njG1mz4A7fp0rOY7so9Snm9
        pPQiL9U4b0Uvc65LLic5r72n0/t0JSyrlq4yFGKUezxn/vt8Py/f73fffRlcPkF6Mfs0B3mt
        RhWtoNyJivofLYGBZloZPHDKF1XdD0BmfRmJHpi/kcg+MUSi/NoWEiUXllHoZaYanesfwVFr
        610aNZ8cpdFrnTe6kvsEQ+X9XSTqtF6j0HhWLUD61qcYKq19S6NiezuGepMMFHrbVOfsYesg
        UcqTWhqllnwi0WjbO2Id5CoeVZCcKc8EuKu6doI7f+4L4AofD2NcuTGd4p5dN9HcvaIT3FQ9
        zVV9fIxxllenCe6sxQg4Q8l3mhsv99nisdM9NJKP3hfPa5etDXffay0qArEW3wSzqZfUgfF5
        GYBhILsS9jWvyADujJw1AFha1EpkADdnMQHggEUtCeMAPqp6T4mCGGiyDmKScAvAIXsjJRXO
        RGd3My62pdggWGk8IAZms4UAdlQGiB6cbcSh9XM2Jgqe7HY42GEkRUywi2GuffovL2M3wY+G
        Pkya5gN7WtJxEbuxm2Hm9B3XFqUMHCncKuGNMGXYQkvYEzoa/mFvOP0w39VHgM1pRlf2KDz9
        otLlCYE1De2kuDPOBsAy6zKJXg/rBk2EdCEP2D02S6RxJ8yuuIRLtAympcol9xJoOdPmGjQH
        3jJdpCULB9vq/KTj5AE4mtuBnwe+V/7PugGAEczl4wR1FC+s0PCHggSVWojTRAXtiVGXA+cv
        2qYavlaCp78iqgHLAMVMGcyllHJSFS8kqqsBZHDFbJkhlFbKZZGqxMO8Nma3Ni6aF6rBfIZQ
        zJUdmdG3S85GqQ7y+3k+ltf+UzHGzUsHwh01OceC7Rd68n6H+KxanXXbTYGl2Rx0Y0mOH29b
        7e8wBV7WJ+vH/JWKiKRFx5eHeRacmTCur7Km3NQv3NA1kGqbzMf1k6P8+6aBa2u26eOpkAKz
        V/DPyZruBcpnIYrG+TNi2MxhD9PzloSA/uebFhd/eGcZTNqRpdE5tG/kYQpC2KtavhTXCqo/
        fL4qKIcDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrNIsWRmVeSWpSXmKPExsVy+t/xu7o6G9ljDI59VbE4uFXTYuOM9awW
        2zd+Y7W4/uU5q8X8I+dYLZoXr2ezONOda9H/+DWzxfnzG9gtzja9Ybe41SBjMWvKXiaLTY+v
        sVpc3jWHzeJz7xFGixnn9zFZrD1yl91i6fWLTBa3G1ewWdw9dRRoxulLrBate4+wW7St/sBq
        8ebCPRYHCY9tu7exeqyZt4bRY3bDRRaPCf2fGD0W73nJ5LFpVSebx/65a9g9Ni+p9/h3jN3j
        4Ls9TB5brrazePRtWcXosWL1d3aPz5vkAvii9GyK8ktLUhUy8otLbJWiDS2M9AwtLfSMTCz1
        DI3NY62MTJX07WxSUnMyy1KL9O0S9DJ2LVnCWLBFvmLjmtusDYyfJbsYOTkkBEwkTu16ytTF
        yMUhJLCUUeJR6wt2iISYxKR926FsYYk/17rYIIo+MUr8erKAuYuRg4NNQE9ix6pCkLiIwHJG
        ifs/Z7ODOMwCD5glOp5vYgXpFhYIljhw9TWYzSKgKjHl+n8mEJtXwEvi3YoHTBAb5CRunutk
        BrE5Bbwluv+vYwOxhYBqpvYvZ5rAyLeAkWEVo0hqaXFuem6xkV5xYm5xaV66XnJ+7iZGYMRu
        O/Zzyw7GrnfBhxgFOBiVeHglprDFCLEmlhVX5h5ilOBgVhLhXWHDHiPEm5JYWZValB9fVJqT
        WnyI0RToqInMUqLJ+cBkklcSb2hqaG5haWhubG5sZqEkznveoDJKSCA9sSQ1OzW1ILUIpo+J
        g1OqgZHLpfdQmKbpc46Ky1Me3rpsdKJoZeGdwiSelb+u3dix7f7bqhiTd73b7K4IHo3WiHZ9
        GDRNXrLq2m9D045ty+4LtBw538vI7rHpgnGJ8WTJJinLpBP9oXuCDmekZ0xIX3WhxslU6mfm
        P1HWOO6b3EdM1x8+0cj57kSGzKJNDzdeKpHXnZtdmKHEUpyRaKjFXFScCABy7U1o7gIAAA==
X-CMS-MailID: 20181205110620eucas1p14de70dc092580b684a0304b5ce771605
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20181205110620eucas1p14de70dc092580b684a0304b5ce771605
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20181205110620eucas1p14de70dc092580b684a0304b5ce771605
References: <1544007956-28889-1-git-send-email-l.luba@partner.samsung.com>
        <CGME20181205110620eucas1p14de70dc092580b684a0304b5ce771605@eucas1p1.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch prepares devfreq device for handling suspend/resume
functionality. The new fields will store needed information during this
process. Devfreq framework handles opp-suspend DT entry and there is no
need of modyfications in the drivers code. It uses atomic variables to
make sure no race condition affects the process.

Suggested-by: Tobias Jakobi <tjakobi@math.uni-bielefeld.de>
Suggested-by: Chanwoo Choi <cw00.choi@samsung.com>
Signed-off-by: Lukasz Luba <l.luba@partner.samsung.com>
---
 drivers/devfreq/devfreq.c | 47 +++++++++++++++++++++++++++++++++++++++++------
 include/linux/devfreq.h   |  7 +++++++
 2 files changed, 48 insertions(+), 6 deletions(-)

diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
index a9fd61b..46517b6 100644
--- a/drivers/devfreq/devfreq.c
+++ b/drivers/devfreq/devfreq.c
@@ -316,6 +316,10 @@ static int devfreq_set_target(struct devfreq *devfreq, unsigned long new_freq,
 			"Couldn't update frequency transition information.\n");
 
 	devfreq->previous_freq = new_freq;
+
+	if (devfreq->suspend_freq)
+		devfreq->resume_freq = cur_freq;
+
 	return err;
 }
 
@@ -667,6 +671,9 @@ struct devfreq *devfreq_add_device(struct device *dev,
 	}
 	devfreq->max_freq = devfreq->scaling_max_freq;
 
+	devfreq->suspend_freq = dev_pm_opp_get_suspend_opp_freq(dev);
+	atomic_set(&devfreq->suspend_count, 0);
+
 	dev_set_name(&devfreq->dev, "devfreq%d",
 				atomic_inc_return(&devfreq_no));
 	err = device_register(&devfreq->dev);
@@ -867,14 +874,28 @@ EXPORT_SYMBOL(devm_devfreq_remove_device);
  */
 int devfreq_suspend_device(struct devfreq *devfreq)
 {
+	int ret;
+
 	if (!devfreq)
 		return -EINVAL;
 
-	if (!devfreq->governor)
+	if (atomic_inc_return(&devfreq->suspend_count) > 1)
 		return 0;
 
-	return devfreq->governor->event_handler(devfreq,
-				DEVFREQ_GOV_SUSPEND, NULL);
+	if (devfreq->governor) {
+		ret = devfreq->governor->event_handler(devfreq,
+					DEVFREQ_GOV_SUSPEND, NULL);
+		if (ret)
+			return ret;
+	}
+
+	if (devfreq->suspend_freq) {
+		ret = devfreq_set_target(devfreq, devfreq->suspend_freq, 0);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
 }
 EXPORT_SYMBOL(devfreq_suspend_device);
 
@@ -888,14 +909,28 @@ EXPORT_SYMBOL(devfreq_suspend_device);
  */
 int devfreq_resume_device(struct devfreq *devfreq)
 {
+	int ret;
+
 	if (!devfreq)
 		return -EINVAL;
 
-	if (!devfreq->governor)
+	if (atomic_dec_return(&devfreq->suspend_count) >= 1)
 		return 0;
 
-	return devfreq->governor->event_handler(devfreq,
-				DEVFREQ_GOV_RESUME, NULL);
+	if (devfreq->resume_freq) {
+		ret = devfreq_set_target(devfreq, devfreq->resume_freq, 0);
+		if (ret)
+			return ret;
+	}
+
+	if (devfreq->governor) {
+		ret = devfreq->governor->event_handler(devfreq,
+					DEVFREQ_GOV_RESUME, NULL);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
 }
 EXPORT_SYMBOL(devfreq_resume_device);
 
diff --git a/include/linux/devfreq.h b/include/linux/devfreq.h
index e4963b0..d985199 100644
--- a/include/linux/devfreq.h
+++ b/include/linux/devfreq.h
@@ -131,6 +131,9 @@ struct devfreq_dev_profile {
  * @scaling_min_freq:	Limit minimum frequency requested by OPP interface
  * @scaling_max_freq:	Limit maximum frequency requested by OPP interface
  * @stop_polling:	 devfreq polling status of a device.
+ * @suspend_freq:	 frequency of a device set during suspend phase.
+ * @resume_freq:	 frequency of a device set in resume phase.
+ * @suspend_count:	 suspend requests counter for a device.
  * @total_trans:	Number of devfreq transitions
  * @trans_table:	Statistics of devfreq transitions
  * @time_in_state:	Statistics of devfreq states
@@ -167,6 +170,10 @@ struct devfreq {
 	unsigned long scaling_max_freq;
 	bool stop_polling;
 
+	unsigned long suspend_freq;
+	unsigned long resume_freq;
+	atomic_t suspend_count;
+
 	/* information for device frequency transition */
 	unsigned int total_trans;
 	unsigned int *trans_table;
-- 
2.7.4

