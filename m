Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59C43ECDE30
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 08:58:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 132132151D
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 08:58:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="NZpJ2o2O"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 132132151D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727191AbeJQQxR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 12:53:17 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:40100 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726768AbeJQQxR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 12:53:17 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20181017085834euoutp028baae7162b3e2e3a480f5b44889bf589~eWasogqg21870518705euoutp021;
        Wed, 17 Oct 2018 08:58:34 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20181017085834euoutp028baae7162b3e2e3a480f5b44889bf589~eWasogqg21870518705euoutp021
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1539766714;
        bh=KZ/e2xySQS+OE+AFMvIGc6tBNmknZ1uPpkiJ7OxGnvg=;
        h=From:To:Cc:Subject:Date:In-reply-to:References:From;
        b=NZpJ2o2Ox2Y+es08qKpIVPY0XCkHjDeIa7NuOpewB8TJA/PYTX0t0ETyhY0Fuxdmd
         gNSSBgL+YzYJOns5zhTR5F6IiSIFtnjgyBu38bvJh1YHylFGOuQr04/E8LwvkM1NLE
         Br3jJqSRIl4e3s7ktclgxbxNZyoSzLirYPHtaLtA=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20181017085833eucas1p285833f4f82de46a976d7d673518a7b35~eWasIwXnZ0823608236eucas1p2T;
        Wed, 17 Oct 2018 08:58:33 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id 99.43.04441.9B9F6CB5; Wed, 17
        Oct 2018 09:58:33 +0100 (BST)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20181017085832eucas1p23dbb86230149a13634b8a091c3b1301f~eWarb_6p90824808248eucas1p2C;
        Wed, 17 Oct 2018 08:58:32 +0000 (GMT)
X-AuditID: cbfec7f2-5c9ff70000001159-8e-5bc6f9b958e7
Received: from eusync4.samsung.com ( [203.254.199.214]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id E6.C8.04128.8B9F6CB5; Wed, 17
        Oct 2018 09:58:32 +0100 (BST)
Received: from AMDC2768.DIGITAL.local ([106.120.43.17]) by
        eusync4.samsung.com (Oracle Communications Messaging Server 7.0.5.31.0 64bit
        (built May  5 2014)) with ESMTPA id <0PGQ00HKSJLJEQ40@eusync4.samsung.com>;
        Wed, 17 Oct 2018 09:58:32 +0100 (BST)
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
Subject: [PATCH v2 1/3] driver core: add probe_err log helper
Date:   Wed, 17 Oct 2018 10:58:24 +0200
Message-id: <20181017085824.30806-1-a.hajda@samsung.com>
X-Mailer: git-send-email 2.18.0
In-reply-to: <CAHp75VecquoNrzOuRvWcZ-Qa1b-5P0V0MWq=sNj-SnVcd2EhRw@mail.gmail.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrIIsWRmVeSWpSXmKPExsWy7djP87o7fx6LNrj0Stri1rpzrBYvJxxm
        tNg4Yz2rxdSHT9gsmhevZ7NYOG05o8Wmx9dYLS7vmsNmsfbIXXaLuV+mMjtweeycdZfdY9Oq
        TjaP/XPXsHtsXlLv8X7fVTaPvi2rGD0+b5ILYI/isklJzcksSy3St0vgyrjw+wprwSPRiuf/
        nrI0MJ4V7GLk5JAQMJHYsLOdrYuRi0NIYAWjxJtdh6Gcz4wSlyf0scFUvf/8mhEisYxR4tTq
        b1DOf0aJvjVnGUGq2AQ0Jf5uvgnWISJgLNF/dhY7SBGzwBsmiScPpjCBJIQFbCV+9c8FK2IR
        UJVYvX0jK4jNK2AhMf1cHwvEOnmJh8fbwYZyCgRL9C6YBxVfwSbRuVKpi5EDyHaROLCCCyIs
        LPHq+BZ2CFtG4vLkbqjyeommmVeYQW6QEOhglDixeDnUO9YSh49fBNvLLMAnMWnbdGaImbwS
        HW1CECUeEtuajkKDYgmjRPO1PcwTGCUXMDKsYhRPLS3OTU8tNsxLLdcrTswtLs1L10vOz93E
        CIzY0/+Of9rB+PVS0iFGAQ5GJR7eHWLHooVYE8uKK3MPMUpwMCuJ8GYuBgrxpiRWVqUW5ccX
        leakFh9ilOZgURLnXTZvY7SQQHpiSWp2ampBahFMlomDU6qBMVGjZ4ZuqAVT2kzlrNmcWSwL
        E5c5vHk3e5vxiqDi0HUvPcttc0+8WSjOsO5r0on3Elltm5crbnssks2k9Hm9xlY/zZpikwWS
        CY7Sh0LOs5X+dlj5hefvc3OxdVYn2/hCxd9u1+1heZwnLGJd2fwrRHKq2JSp7xZKtCsx/Ge7
        LalnJ/HLu15RiaU4I9FQi7moOBEAjXLxs9QCAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprPLMWRmVeSWpSXmKPExsVy+t/xa7o7fh6LNpj+3dLi1rpzrBYvJxxm
        tNg4Yz2rxdSHT9gsmhevZ7NYOG05o8Wmx9dYLS7vmsNmsfbIXXaLuV+mMjtweeycdZfdY9Oq
        TjaP/XPXsHtsXlLv8X7fVTaPvi2rGD0+b5ILYI/isklJzcksSy3St0vgyrjw+wprwSPRiuf/
        nrI0MJ4V7GLk5JAQMJF4//k1I4gtJLCEUeLQA+UuRi4gu5FJ4vrVNawgCTYBTYm/m2+ygdgi
        AsYS/WdnsYMUMQu8Y5KY9eQFWLewgK3Er/65YEUsAqoSq7dvBGvmFbCQmH6ujwVim7zEw+Pt
        YPWcAsESPe8vsUFsDpD4fHky6wRGngWMDKsYRVJLi3PTc4uN9IoTc4tL89L1kvNzNzECg23b
        sZ9bdjB2vQs+xCjAwajEw7tD7Fi0EGtiWXFl7iFGCQ5mJRHezMVAId6UxMqq1KL8+KLSnNTi
        Q4zSHCxK4rznDSqjhATSE0tSs1NTC1KLYLJMHJxSDYwHzpxOKXbYdeubV6jHkhWx8wwYTtsp
        ndCpPRF+Ma2p3HPWRqb4v1P2v3c6MU9DzPDa4bwnlys+rejQSWs2em0WcFBup3/G3qXl5xI5
        kp0M1GNO/mU6sOpX+ayABVsZX6zLaNlw29m7q2jm/Qu1Hx4UJ/Xej27yvGSwxShvbYOJktCj
        6qeTDxsqsRRnJBpqMRcVJwIA999RMTICAAA=
X-CMS-MailID: 20181017085832eucas1p23dbb86230149a13634b8a091c3b1301f
X-Msg-Generator: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20181017085832eucas1p23dbb86230149a13634b8a091c3b1301f
References: <CAHp75VecquoNrzOuRvWcZ-Qa1b-5P0V0MWq=sNj-SnVcd2EhRw@mail.gmail.com>
        <CGME20181017085832eucas1p23dbb86230149a13634b8a091c3b1301f@eucas1p2.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

During probe every time driver gets resource it should usually check for error
printk some message if it is not -EPROBE_DEFER and return the error. This
pattern is simple but requires adding few lines after any resource acquisition
code, as a result it is often omited or implemented only partially.
probe_err helps to replace such code sequences with simple call, so code:
	if (err != -EPROBE_DEFER)
		dev_err(dev, ...);
	return err;
becomes:
	return probe_err(dev, err, ...);

Signed-off-by: Andrzej Hajda <a.hajda@samsung.com>
Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

---
v2:
  - added error value to log message,
  - fixed code style,
  - added EXPORT_SYMBOL_GPL,
  - Added R-B by Javier (I hope the changes did not invalidate it).
---
 drivers/base/core.c    | 37 +++++++++++++++++++++++++++++++++++++
 include/linux/device.h |  2 ++
 2 files changed, 39 insertions(+)

diff --git a/drivers/base/core.c b/drivers/base/core.c
index 04bbcd779e11..aa6f3229d066 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -3067,6 +3067,43 @@ define_dev_printk_level(_dev_info, KERN_INFO);
 
 #endif
 
+/**
+ * probe_err - probe error check and log helper
+ * @dev: the pointer to the struct device
+ * @err: error value to test
+ * @fmt: printf-style format string, not ended with newline
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
+	if (err == -EPROBE_DEFER)
+		return err;
+
+	va_start(args, fmt);
+	vaf.fmt = fmt;
+	vaf.va = &args;
+	dev_err(dev, "%pV, %d\n", &vaf, err);
+	va_end(args);
+
+	return err;
+}
+EXPORT_SYMBOL_GPL(probe_err);
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

