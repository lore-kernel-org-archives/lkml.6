Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17DD3C282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 22:24:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE0A6222C0
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 22:24:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="c0cEtikC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732647AbfBLWYm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 17:24:42 -0500
Received: from mailout1.w1.samsung.com ([210.118.77.11]:37944 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732165AbfBLWYi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 17:24:38 -0500
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20190212222436euoutp015eb23d540e12d44845ea4341fbd3aa6b~CviJTmzi50553905539euoutp01X
        for <linux-kernel@vger.kernel.org>; Tue, 12 Feb 2019 22:24:36 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20190212222436euoutp015eb23d540e12d44845ea4341fbd3aa6b~CviJTmzi50553905539euoutp01X
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1550010276;
        bh=EWZ2nEYUcUm6vDd+rU+I3vpcaDBj9+sDWK6WcLFzG/A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=c0cEtikClTjr6ZxaF5ulKqvMYLyDiYVsc7SWMMLSkng+NX2lOHyqRk+tO8edDFEGT
         YVGf7tgaNDEJf8gBN7y+bA5n5Cz+l9GxF0rws8QSZYw2t1ilQKW4fiMZERtne286ec
         BMRDZRwjp7768WM/ENbJK3tEOaGqQJ4L8jgFLofM=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20190212222435eucas1p287880cc375816e75e161b605c9d22f7d~CviInW9_51608916089eucas1p2x;
        Tue, 12 Feb 2019 22:24:35 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id C0.45.04294.3A7436C5; Tue, 12
        Feb 2019 22:24:35 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20190212222434eucas1p134dcdce827df19704c698fd6452b0a06~CviHyE6xG2824728247eucas1p1U;
        Tue, 12 Feb 2019 22:24:34 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20190212222434eusmtrp262d1d8f6e688e30afdccec48285d360b~CviHjWnmX2980329803eusmtrp2O;
        Tue, 12 Feb 2019 22:24:34 +0000 (GMT)
X-AuditID: cbfec7f4-835ff700000010c6-00-5c6347a34d52
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 2E.2C.04284.2A7436C5; Tue, 12
        Feb 2019 22:24:34 +0000 (GMT)
Received: from AMDC3778.DIGITAL.local (unknown [106.120.51.20]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20190212222433eusmtip1712679907e8da16d668fff6043ecc269~CviG7grD20525605256eusmtip17;
        Tue, 12 Feb 2019 22:24:33 +0000 (GMT)
From:   Lukasz Luba <l.luba@partner.samsung.com>
To:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Cc:     b.zolnierkie@samsung.com, myungjoo.ham@samsung.com,
        cw00.choi@samsung.com, kyungmin.park@samsung.com,
        m.szyprowski@samsung.com, s.nawrocki@samsung.com, tkjos@google.com,
        joel@joelfernandes.org, chris.diamand@arm.com, mka@chromium.org,
        rostedt@goodmis.org, mingo@redhat.com,
        Lukasz Luba <l.luba@partner.samsung.com>
Subject: [PATCH v3 4/7] include: devfreq: add polling_idle_ms to 'profile'
Date:   Tue, 12 Feb 2019 23:23:55 +0100
Message-Id: <1550010238-24002-5-git-send-email-l.luba@partner.samsung.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1550010238-24002-1-git-send-email-l.luba@partner.samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrAKsWRmVeSWpSXmKPExsWy7djP87qL3ZNjDL49FbPYOGM9q8W0T5dZ
        LK5/ec5qsaxB1eJs0xt2i1sNMhaXd81hs/jce4TRYu2Ru+wWlw4sYLL4vOExo8XtxhVsFvs6
        HjBZHH7TzmrxfnKxA7/HmnlrGD1mN1xk8WjZd4vdY8GmUo+Fn76yehx8t4fJ4/2+q2wefVtW
        MXp83iQXwBnFZZOSmpNZllqkb5fAlbF82UPGgpXcFQv2vWdrYJzM2cXIySEhYCLx8cVB1i5G
        Lg4hgRWMEu+2nmaGcL4wShy4fYoRwvnMKPGh8z8zTMvZIyehqpYzSnz9fYYdruXyw1dAwzg4
        2AT0JHasKgRpEBGwknjR/gqshlngGJPEp71TmEFqhAW8JB61soLUsAioSuw/2QS2gBcovPbJ
        AVaIZXISN891gsU5BbwlzkxbCXarhMA+donGSR3sEEUuEpNutbFB2MISr45vgYrLSPzfOZ8J
        wi6WONuxCqqmRqL95A6oGmuJw8cvgt3MLKApsX6XPogpIeAocfajNoTJJ3HjrSBIMTOQOWnb
        dGaIMK9ER5sQxAwNiS09F6D2iEksXzONHaLEQ6JhSQAkbOYxSuy+c5V5AqP8LIRVCxgZVzGK
        p5YW56anFhvlpZbrFSfmFpfmpesl5+duYgSmo9P/jn/ZwbjrT9IhRgEORiUe3hVHk2KEWBPL
        iitzDzFKcDArifB62iTHCPGmJFZWpRblxxeV5qQWH2KU5mBREuetZngQLSSQnliSmp2aWpBa
        BJNl4uCUamCcEO7Zflei3OJFHXerwOP61kb3t3sVy8PeRtnfUHzFbT7fj3ON778Pm1zCeOKr
        X6ULLtlwNkfN5Ob0rNyiFfeOS0dmNL6esnpa5tKudm1mLV71I65MZ4W2XOVcYxgz7fm77s61
        T21D1m76cvSDi/j11GTZCUu2ecRIXHesd3qQcv30+Untgt+VWIozEg21mIuKEwFY3ZysQwMA
        AA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprEIsWRmVeSWpSXmKPExsVy+t/xu7qL3JNjDPadlrXYOGM9q8W0T5dZ
        LK5/ec5qsaxB1eJs0xt2i1sNMhaXd81hs/jce4TRYu2Ru+wWlw4sYLL4vOExo8XtxhVsFvs6
        HjBZHH7TzmrxfnKxA7/HmnlrGD1mN1xk8WjZd4vdY8GmUo+Fn76yehx8t4fJ4/2+q2wefVtW
        MXp83iQXwBmlZ1OUX1qSqpCRX1xiqxRtaGGkZ2hpoWdkYqlnaGwea2VkqqRvZ5OSmpNZllqk
        b5egl7F82UPGgpXcFQv2vWdrYJzM2cXIySEhYCJx9shJ5i5GLg4hgaWMEg+ftLJCJMQkJu3b
        zg5hC0v8udbFBmILCXxilHh1iauLkYODTUBPYseqQpCwiICNxPu5Z1hA5jALXGOSuN1xnxWk
        RljAS+IRxEgWAVWJ/SebmEFsXqDw2icHoFbJSdw81wkW5xTwljgzbSVYqxBQTdNBgwmMfAsY
        GVYxiqSWFuem5xYb6hUn5haX5qXrJefnbmIExse2Yz8372C8tDH4EKMAB6MSD++Ko0kxQqyJ
        ZcWVuYcYJTiYlUR4PW2SY4R4UxIrq1KL8uOLSnNSiw8xmgLdNJFZSjQ5Hxi7eSXxhqaG5haW
        hubG5sZmFkrivOcNKqOEBNITS1KzU1MLUotg+pg4OKUaGMs5ohWirrHJznr8LOSrgXi19WIT
        tU9nSqprv7lxLGFNirYrZq47xurf+M63Zn6kp6Xu1ifF5nm9y3tZH9/c8LLJvOZ8g1TD62k3
        s7696Tkm5Cue68d/WmOL+S9Rt6PC+8s8zl9zFIpfxzmh1THlyrZDczhCnoo3rbjpcUzKv0Jo
        NUu6T99OJZbijERDLeai4kQAN1Qbh6UCAAA=
X-CMS-MailID: 20190212222434eucas1p134dcdce827df19704c698fd6452b0a06
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190212222434eucas1p134dcdce827df19704c698fd6452b0a06
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190212222434eucas1p134dcdce827df19704c698fd6452b0a06
References: <1550010238-24002-1-git-send-email-l.luba@partner.samsung.com>
        <CGME20190212222434eucas1p134dcdce827df19704c698fd6452b0a06@eucas1p1.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add needed fields to support new state: idle, where different polling
interval is in use. It provides better control of the devfreq device
and lower the power consumption when the device is not busy.

Signed-off-by: Lukasz Luba <l.luba@partner.samsung.com>
---
 include/linux/devfreq.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/include/linux/devfreq.h b/include/linux/devfreq.h
index fbffa74..5140970 100644
--- a/include/linux/devfreq.h
+++ b/include/linux/devfreq.h
@@ -72,6 +72,11 @@ struct devfreq_dev_status {
  * @initial_freq:	The operating frequency when devfreq_add_device() is
  *			called.
  * @polling_ms:		The polling interval in ms. 0 disables polling.
+ * @polling_idle_ms:	The polling interval in 'idle state' in ms.
+ *			When the device is running at lowest frequency and has
+ *			low-load, it is considered as in 'idle state'.
+ *			Thus, longer polling interval is used for the device
+ *			to save some power.
  * @target:		The device should set its operating frequency at
  *			freq or lowest-upper-than-freq value. If freq is
  *			higher than any operable frequency, set maximum.
@@ -98,6 +103,7 @@ struct devfreq_dev_status {
 struct devfreq_dev_profile {
 	unsigned long initial_freq;
 	unsigned int polling_ms;
+	unsigned int polling_idle_ms;
 
 	int (*target)(struct device *dev, unsigned long *freq, u32 flags);
 	int (*get_dev_status)(struct device *dev,
-- 
2.7.4

