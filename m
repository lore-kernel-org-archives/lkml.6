Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C9C9C070C3
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 07:22:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E8A8F20881
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 07:22:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="a7SvGwMw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E8A8F20881
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727257AbeJPPL5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 11:11:57 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:48794 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726649AbeJPPLz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 11:11:55 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20181016072250euoutp017313bb9e2a877cf8f3acd7b03e5df45a~eBd1DaPzD1696916969euoutp01H;
        Tue, 16 Oct 2018 07:22:50 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20181016072250euoutp017313bb9e2a877cf8f3acd7b03e5df45a~eBd1DaPzD1696916969euoutp01H
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1539674570;
        bh=cZrZMaFu0XT+cQVHdRGBcBuXnsgaiFRRuci107vDojI=;
        h=From:To:Cc:Subject:Date:In-reply-to:References:From;
        b=a7SvGwMwpz3clX2US2fHlrniQNOlUWjLg6JtfqOKvF4s4wnYjjJ6DUDqZaPFRpdp0
         nBNu2INE8oJc4HWAPg+AS3p2vIj5kLIpPuGq3Ph658tJrPRuGcCSRWxExc8DC0jycw
         H/x0nL2HaPeBnBJfvxb2DE5Xt5f9HdC00czAvYjM=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20181016072250eucas1p164e60452bcdab760f51403ac619e00e6~eBd0nN_C11943519435eucas1p1i;
        Tue, 16 Oct 2018 07:22:50 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id 00.CB.04441.9C195CB5; Tue, 16
        Oct 2018 08:22:49 +0100 (BST)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20181016072249eucas1p2303b8c06a9f7c839a971fe065b0c752e~eBdz2Wwii1940019400eucas1p2o;
        Tue, 16 Oct 2018 07:22:49 +0000 (GMT)
X-AuditID: cbfec7f2-a1ae89c000001159-74-5bc591c930bb
Received: from eusync1.samsung.com ( [203.254.199.211]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 2D.F5.04284.9C195CB5; Tue, 16
        Oct 2018 08:22:49 +0100 (BST)
Received: from AMDC2768.DIGITAL.local ([106.120.43.17]) by
        eusync1.samsung.com (Oracle Communications Messaging Server 7.0.5.31.0 64bit
        (built May  5 2014)) with ESMTPA id <0PGO0048DKHZVR70@eusync1.samsung.com>;
        Tue, 16 Oct 2018 08:22:49 +0100 (BST)
From:   Andrzej Hajda <a.hajda@samsung.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Andrzej Hajda <a.hajda@samsung.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org,
        Javier Martinez Canillas <javierm@redhat.com>,
        linux-arm-kernel@lists.infradead.org, andy.shevchenko@gmail.com,
        Mark Brown <broonie@kernel.org>
Subject: [PATCH 1/3] driver core: add probe_err log helper
Date:   Tue, 16 Oct 2018 09:22:42 +0200
Message-id: <20181016072244.1216-2-a.hajda@samsung.com>
X-Mailer: git-send-email 2.18.0
In-reply-to: <20181016072244.1216-1-a.hajda@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrIIsWRmVeSWpSXmKPExsWy7djPc7onJx6NNjjTpWVxa905VouXEw4z
        WmycsZ7VYurDJ2wWzYvXs1ksnLac0WLT42usFpd3zWGzWHvkLrvF3C9TmR24PHbOusvusWlV
        J5vH/rlr2D02L6n3eL/vKptH35ZVjB6fN8kFsEdx2aSk5mSWpRbp2yVwZby/61SwR7hi7ctl
        bA2Md/i7GDk5JARMJKZ8m8XWxcjFISSwglFiz5H3zBDOZ0aJlzvXsMFUTdz9nR0isYxR4sS0
        d4wQzn9Gie3vtrGCVLEJaEr83XwTrENEwFii/+wssA5mgTdMEk8eTGECSQgLWEncXzudBcRm
        EVCVeDd7KlicV8Bc4tynTywQ6+QlHh5vZwSxOQUsJK5v2Ax2k4TAGjaJz413gDZwADkuEkdn
        aELUC0u8Or6FHcKWkejsOMgEYddLNM28AtXbAXT24uVQ/1hLHD5+EexqZgE+iUnbpjNDzOSV
        6GgTgijxkJj09z8LxJfdjBL7pi1imcAouYCRYRWjeGppcW56arFhXmq5XnFibnFpXrpecn7u
        JkZgxJ7+d/zTDsavl5IOMQpwMCrx8P64fiRaiDWxrLgy9xCjBAezkgivbOXRaCHelMTKqtSi
        /Pii0pzU4kOM0hwsSuK8y+ZtjBYSSE8sSc1OTS1ILYLJMnFwSjUw6hmJvnw3070otY8l/4a7
        XRWjz7xwy6uRtZeflL04yrSU6/GlvsVJ7b8iRJbV7HH0S7h5e8m6dc4zuZdNj2U4VXO5Ykto
        xQHZU7x3VDeo2M28oTfRaTtHz+9t2ir7/sXn/wvce+LitQK2hXsa3n3e/vRGZIdbvf3GNXmX
        30vcKVk8QTKNPfhlkxJLcUaioRZzUXEiAFZo+HDUAgAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprPLMWRmVeSWpSXmKPExsVy+t/xy7onJx6NNpjzld3i1rpzrBYvJxxm
        tNg4Yz2rxdSHT9gsmhevZ7NYOG05o8Wmx9dYLS7vmsNmsfbIXXaLuV+mMjtweeycdZfdY9Oq
        TjaP/XPXsHtsXlLv8X7fVTaPvi2rGD0+b5ILYI/isklJzcksSy3St0vgynh/16lgj3DF2pfL
        2BoY7/B3MXJySAiYSEzc/Z29i5GLQ0hgCaPEhO0vWSGcRiaJ68v2sYFUsQloSvzdfBPMFhEw
        lug/Owusg1ngHZPErCcvGEESwgJWEvfXTmcBsVkEVCXezZ7KBGLzCphLnPv0iQVinbzEw+Pt
        YPWcAhYS1zdsZgaxhYBqbl9oY5/AyLOAkWEVo0hqaXFuem6xoV5xYm5xaV66XnJ+7iZGYLBt
        O/Zz8w7GSxuDDzEKcDAq8fD+uH4kWog1say4MvcQowQHs5IIr2zl0Wgh3pTEyqrUovz4otKc
        1OJDjNIcLErivOcNKqOEBNITS1KzU1MLUotgskwcnFINjPoCl0OvbbCqEb/Aw8vqfGwd138W
        vy1XVVf1qN3vd5dTSj9lsN5Sx0huRdbnB5+Tp8icUNm285b0tV3ztmUaFetMPvniEG/HvBtv
        TKsPphjuNa37vuby9zsfY59Ev7Kd8vxTzFmu8K0vplw/uf7ZGpfKaPezlcWRgtwFj3a92hQa
        xj7XXD72WJwSS3FGoqEWc1FxIgCwJR4AMgIAAA==
X-CMS-MailID: 20181016072249eucas1p2303b8c06a9f7c839a971fe065b0c752e
X-Msg-Generator: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20181016072249eucas1p2303b8c06a9f7c839a971fe065b0c752e
References: <20181016072244.1216-1-a.hajda@samsung.com>
        <CGME20181016072249eucas1p2303b8c06a9f7c839a971fe065b0c752e@eucas1p2.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

During probe every time driver gets resource it should usually check for error
printk some message if it is not -EPROBE_DEFER and return the error. This
pattern is simple but requires adding few lines after any resource acquisition
code, as a result it is often omited or implemented only partially.
probe_err helps to replace such code seqences with simple call, so code:
	if (err != -EPROBE_DEFER)
		dev_err(dev, ...);
	return err;
becomes:
	return probe_err(dev, err, ...);

Signed-off-by: Andrzej Hajda <a.hajda@samsung.com>
---
 drivers/base/core.c    | 37 +++++++++++++++++++++++++++++++++++++
 include/linux/device.h |  2 ++
 2 files changed, 39 insertions(+)

diff --git a/drivers/base/core.c b/drivers/base/core.c
index 04bbcd779e11..23fabefb217a 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -3067,6 +3067,43 @@ define_dev_printk_level(_dev_info, KERN_INFO);
 
 #endif
 
+/**
+ * probe_err - probe error check and log helper
+ * @dev: the pointer to the struct device
+ * @err: error value to test
+ * @fmt: printf-style format string
+ * @...: arguments as specified in the format string
+ *
+ * This helper implements common pattern present in probe functions for error
+ * checking: print message if the error is not -EPROBE_DEFER and propagate it.
+ * It replaces code sequence:
+ * 	if (err != -EPROBE_DEFER)
+ * 		dev_err(dev, ...);
+ * 	return err;
+ * with
+ * 	return probe_err(dev, err, ...);
+ *
+ * Returns @err.
+ *
+ */
+int probe_err(const struct device *dev, int err, const char *fmt, ...)
+{
+	struct va_format vaf;
+	va_list args;
+
+	if (err != -EPROBE_DEFER) {
+		va_start(args, fmt);
+
+		vaf.fmt = fmt;
+		vaf.va = &args;
+
+		__dev_printk(KERN_ERR, dev, &vaf);
+		va_end(args);
+	}
+
+	return err;
+}
+
 static inline bool fwnode_is_primary(struct fwnode_handle *fwnode)
 {
 	return fwnode && !IS_ERR(fwnode->secondary);
diff --git a/include/linux/device.h b/include/linux/device.h
index 90224e75ade4..06c2c797d132 100644
--- a/include/linux/device.h
+++ b/include/linux/device.h
@@ -1577,6 +1577,8 @@ do {									\
 	WARN_ONCE(condition, "%s %s: " format, \
 			dev_driver_string(dev), dev_name(dev), ## arg)
 
+int probe_err(const struct device *dev, int err, const char *fmt, ...);
+
 /* Create alias, so I can be autoloaded. */
 #define MODULE_ALIAS_CHARDEV(major,minor) \
 	MODULE_ALIAS("char-major-" __stringify(major) "-" __stringify(minor))
-- 
2.18.0

