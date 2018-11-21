Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A537C43610
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 18:02:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB57A214D9
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 18:02:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="MwK0PQha"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CB57A214D9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=partner.samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732907AbeKVEhd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Nov 2018 23:37:33 -0500
Received: from mailout1.w1.samsung.com ([210.118.77.11]:38119 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732888AbeKVEhb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Nov 2018 23:37:31 -0500
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20181121180207euoutp014ba86e253fe6c2cc2a5d2744854c0dc0~pNaRww-8e0920709207euoutp01D
        for <linux-kernel@vger.kernel.org>; Wed, 21 Nov 2018 18:02:07 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20181121180207euoutp014ba86e253fe6c2cc2a5d2744854c0dc0~pNaRww-8e0920709207euoutp01D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1542823327;
        bh=axMoCdjjhQCxHj2Q1e8pQzBP0D1acRsUCt4LxqCbmyo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MwK0PQhaPHWj6hoEkprkeWu/62ovg6f226P9H4PVg18+eiwGqHkTjT/bJ++z7J4Ua
         IksdapoVw8ZsHbkdAxNkWNGQl1YC0sa8vNXxJ8BTY1loZe5Tml1+V+YRT7IZrp5fYt
         MbEaxYVNo+vImmok6xRCtN2m6W4vYwSobQmnbOBc=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20181121180206eucas1p143bfcd4572435bcb997b49b95d6d17dc~pNaQrRJhe3116331163eucas1p1g;
        Wed, 21 Nov 2018 18:02:06 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id 19.89.04294.E9D95FB5; Wed, 21
        Nov 2018 18:02:06 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20181121180205eucas1p1dc52369476400cd07058d232bd8dbcd7~pNaPq-yFi3115931159eucas1p1W;
        Wed, 21 Nov 2018 18:02:05 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20181121180205eusmtrp2c0f09882ef4f00cb548235e0fe26c4b3~pNaPbcUsd0880108801eusmtrp2I;
        Wed, 21 Nov 2018 18:02:05 +0000 (GMT)
X-AuditID: cbfec7f4-835ff700000010c6-c5-5bf59d9eb799
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 0E.48.04284.D9D95FB5; Wed, 21
        Nov 2018 18:02:05 +0000 (GMT)
Received: from AMDC3778.DIGITAL.local (unknown [106.120.51.20]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20181121180204eusmtip2a122851a9fd70407df58db04269308ad~pNaOjDyEp1642316423eusmtip2P;
        Wed, 21 Nov 2018 18:02:04 +0000 (GMT)
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
Subject: [PATCH 4/6] devfreq: add devfreq_suspend/resume() functions
Date:   Wed, 21 Nov 2018 19:01:39 +0100
Message-Id: <1542823301-23563-5-git-send-email-l.luba@partner.samsung.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1542823301-23563-1-git-send-email-l.luba@partner.samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA0WSbVBMYRTHe+7L3tuyubboDA3NKlONytuHZyYMow93MCbjUy3D0lVGm+xV
        hGFFSqEGU4a2mKRsJSVbthdaS/T+MnnJbIMYQxhshRlir7v49nv+5/zP/8yZhyXVY/QMdnvi
        bsGQqEvQKJSU5f737tBC05h2vqlEhVtuBuPqc1U0rqsep/Hj0Tc0LrJ30fhIcZUCd2Trcc7w
        CIm7u68zuDPtPYMHjX74/NkmAtcMP6Jxv7VAgZ0n7Qif624mcKXdweCSx70Efna4TIEdbfdc
        M9r7aJzeZGfwsfJPNH7fM0QtB97SYKH5isIKxF8w9lJ8bs4XxBc3viX4GvNxBX/bVMHwNy4f
        4ifuM3zLx0aCrx3IoPhTtWbEl5V/ZXhnzaworxjlklghYXuKYAhftlkZb6l8RSQ1++19kTOB
        jOidbxbyZIFbDNnDPQqJ1VwZgoy2eVlI6eJRBHbna0J+OBHY8qzor8PZ04jkQikC5+AP4p9l
        cLyTykIsq+DCoN68SzL4cMUI+uqDpR6Se0CC9fNpQip4c5HQceTTn6kUFwhNaWcYiVXcKigY
        KqDktFnwtOs4KbEntxqc5lz3FldZuHd2scyRUDme49a94V1rLSOzH/y6VUTILEJnplkh8wHI
        eFjv7omAu629tLQzyQVDlTVclldA85UiUpKB84InH6ZKMunC05Z8t6yCzGNquTsIak/0uIOm
        Q2lFnns4Dy32IUI+biGC8pcrc9Hs8/+zLiJkRr5CsqiPE8SFicKeMFGnF5MT48K27tTXINdn
        bJ9oHa1H1h9bbIhjkWayKih6TKumdSliqt6GgCU1PqrMGJekitWl7hMMOzcZkhME0YZmspTG
        V7Xf47lWzcXpdgs7BCFJMPytEqznDCO6lNzeshUiTBHBWubwnQVEdKTSNHJ9yBi7w2F94pGu
        d5QPCL5RsdPqUn7C2tRAsW0/15e7xmdYFTpw5srEtvUhGm1p356C9Jsjk1o7DlYFtDlsHUu0
        Wu9FCdlpXXjKlOlxod+W5ocbYq4VrpvTcNffe4PT/9ncR3O9Jh/N5wI29msoMV63IIQ0iLrf
        YhhZjIgDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrNIsWRmVeSWpSXmKPExsVy+t/xe7pz536NNni9jNvi4FZNi40z1rNa
        bN/4jdXi+pfnrBbzj5xjtWhevJ7N4kx3rkX/49fMFufPb2C3ONv0ht3iVoOMxawpe5ksNj2+
        xmpxedccNovPvUcYLWac38dksfbIXXaLpdcvMlncblzBZnH31FGgGacvsVq07j3CbtG2+gOr
        xZsL91gcJDy27d7G6rFm3hpGj9kNF1k8JvR/YvRYvOclk8emVZ1sHvvnrmH32Lyk3uPfMXaP
        g+/2MHlsudrO4tG3ZRWjx4rV39k9Pm+SC+CL0rMpyi8tSVXIyC8usVWKNrQw0jO0tNAzMrHU
        MzQ2j7UyMlXSt7NJSc3JLEst0rdL0MvYtvYJU8E+mYqH/f8YGxhfiXcxcnJICJhIfL6wh7GL
        kYtDSGApo8Sb5h/sEAkxiUn7tkPZwhJ/rnWxQRR9YpS4d2g1kMPBwSagJ7FjVSFIXERgOaPE
        /Z+z2UEcZoEHzBIdzzexgnQLC7hInGn+wAhiswioSuxtmgw2lVfAS2LOvTksEBvkJG6e62QG
        sTkFvCU+r5oAVi8EVHNl3kLWCYx8CxgZVjGKpJYW56bnFhvqFSfmFpfmpesl5+duYgRG7LZj
        PzfvYLy0MfgQowAHoxIPr0bk12gh1sSy4srcQ4wSHMxKIrwdUUAh3pTEyqrUovz4otKc1OJD
        jKZAR01klhJNzgcmk7ySeENTQ3MLS0NzY3NjMwslcd7zBpVRQgLpiSWp2ampBalFMH1MHJxS
        DYy+u9/F2lf+YvblDnt3JGqp5aarQV+OGuu8evzzw0JXWceIZ1pRa8y1L69YpbAqftOlgOay
        /SUa2y4aKJTHn9vGf+ipvvrUJfKl/++IXtXaXKQ085iP0LN5bY2rAy9ap1Rbzi70tuS2mi9a
        y1LY/evvRZMd599LPDtmZ9RqP1Fa5fSjAr/ZLGZKLMUZiYZazEXFiQAcq5Dr7gIAAA==
X-CMS-MailID: 20181121180205eucas1p1dc52369476400cd07058d232bd8dbcd7
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20181121180205eucas1p1dc52369476400cd07058d232bd8dbcd7
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20181121180205eucas1p1dc52369476400cd07058d232bd8dbcd7
References: <1542823301-23563-1-git-send-email-l.luba@partner.samsung.com>
        <CGME20181121180205eucas1p1dc52369476400cd07058d232bd8dbcd7@eucas1p1.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds implementation for global suspend/resume for
devfreq framework. System suspend will next use these functions.

The patch draws on Tobias Jakobi's work posted ~2 years ago, who tried to
solve issue with devfreq device's frequency during suspend/resume.
During the discussion on LKML some corner cases and comments appeared
related to the design. This patch address them keeping in mind suggestions
from Chanwoo Choi.

Suggested-by: Tobias Jakobi <tjakobi@math.uni-bielefeld.de>
Suggested-by: Chanwoo Choi <cw00.choi@samsung.com>
Signed-off-by: Lukasz Luba <l.luba@partner.samsung.com>
---
 drivers/devfreq/devfreq.c | 49 +++++++++++++++++++++++++++++++++++++++++++++++
 include/linux/devfreq.h   |  7 +++++++
 2 files changed, 56 insertions(+)

diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
index 7e09de8..2f4391c 100644
--- a/drivers/devfreq/devfreq.c
+++ b/drivers/devfreq/devfreq.c
@@ -44,6 +44,9 @@ static LIST_HEAD(devfreq_governor_list);
 static LIST_HEAD(devfreq_list);
 static DEFINE_MUTEX(devfreq_list_lock);
 
+/* Flag showing state of suspend/resume */
+static bool devfreq_suspended;
+
 /**
  * find_device_devfreq() - find devfreq struct using device pointer
  * @dev:	device pointer used to lookup device devfreq.
@@ -938,6 +941,52 @@ int devfreq_resume_device(struct devfreq *devfreq)
 EXPORT_SYMBOL(devfreq_resume_device);
 
 /**
+ * devfreq_suspend() - Suspend devfreq governors and devices
+ *
+ * Called during system wide Suspend/Hibernate cycles for suspending governors
+ * and devices preserving the state for resume. On some platforms the devfreq
+ * device must have precise state (frequency) after resume in order to provide
+ * fully operating setup.
+ */
+void devfreq_suspend(void)
+{
+	struct devfreq *devfreq;
+	int ret;
+
+	mutex_lock(&devfreq_list_lock);
+	list_for_each_entry(devfreq, &devfreq_list, node) {
+		ret = devfreq_suspend_device(devfreq);
+		if (ret)
+			dev_warn(&devfreq->dev, "device suspend failed\n");
+	}
+	mutex_unlock(&devfreq_list_lock);
+
+	devfreq_suspended = true;
+}
+
+/**
+ * devfreq_resume() - Resume devfreq governors and devices
+ *
+ * Called during system wide Suspend/Hibernate cycle for resuming governors and
+ * devices that are suspended with devfreq_suspend().
+ */
+void devfreq_resume(void)
+{
+	struct devfreq *devfreq;
+	int ret;
+
+	devfreq_suspended = false;
+
+	mutex_lock(&devfreq_list_lock);
+	list_for_each_entry(devfreq, &devfreq_list, node) {
+		ret = devfreq_resume_device(devfreq);
+		if (ret)
+			dev_warn(&devfreq->dev, "device resume failed\n");
+	}
+	mutex_unlock(&devfreq_list_lock);
+}
+
+/**
  * devfreq_add_governor() - Add devfreq governor
  * @governor:	the devfreq governor to be added
  */
diff --git a/include/linux/devfreq.h b/include/linux/devfreq.h
index 7fe96f9..4f0fea8 100644
--- a/include/linux/devfreq.h
+++ b/include/linux/devfreq.h
@@ -202,6 +202,10 @@ extern void devm_devfreq_remove_device(struct device *dev,
 extern int devfreq_suspend_device(struct devfreq *devfreq);
 extern int devfreq_resume_device(struct devfreq *devfreq);
 
+
+extern void devfreq_suspend(void);
+extern void devfreq_resume(void);
+
 /**
  * update_devfreq() - Reevaluate the device and configure frequency
  * @devfreq:	the devfreq device
@@ -396,6 +400,9 @@ static inline int devfreq_update_stats(struct devfreq *df)
 {
 	return -EINVAL;
 }
+
+static inline void devfreq_suspend(void) {}
+static inline void devfreq_resume(void) {}
 #endif /* CONFIG_PM_DEVFREQ */
 
 #endif /* __LINUX_DEVFREQ_H__ */
-- 
2.7.4

