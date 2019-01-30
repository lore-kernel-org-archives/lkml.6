Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 822CEC282D7
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 17:33:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C11321473
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 17:33:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ucr.edu header.i=@ucr.edu header.b="McPqcDwM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732540AbfA3Rds (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 12:33:48 -0500
Received: from mx2.ucr.edu ([138.23.62.3]:29657 "EHLO mx2.ucr.edu"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726341AbfA3Rds (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 12:33:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=ucr.edu; i=@ucr.edu; q=dns/txt; s=selector3;
  t=1548869627; x=1580405627;
  h=from:to:cc:subject:date:message-id;
  bh=sD3YsFFxFFf5mI1/Slp1q9iWxdDGyH2Fo/moTt7ef6w=;
  b=McPqcDwMyzq1+BEvk/iTtp9+LanhmI+7eJFmiAVzyBxJI1Odvu2M3h7s
   vj8wInRizSiFp8KcH8uKqA0blhtr/8pTDqEwy0QGCaeeYy7QZCVnD944C
   iNF/T4UdXUeFz/isrm7kJgjmFk/2cU3Cy93EUnAV5yT3jrfsz2Q/wnkUu
   Xjoz77D6wwvmznA4wMVpYZDq79vKwssF5dkl+3c52l1cLAXNpkDtS5ID8
   0JdzCsxsY9PjvxcG+uPcJKzx8ADnJ8pMExnobpCprWkvakmp26vOqAOvQ
   HdmH7+jJ4LwIlffsmkfSn7UQ2eji0Tnulfrp1wpUFcpwemrdZCsuJzraE
   Q==;
IronPort-PHdr: =?us-ascii?q?9a23=3AomGvURNMXO+xM7bTI6Yl6mtUPXoX/o7sNwtQ0KIM?=
 =?us-ascii?q?zox0LfT5rarrMEGX3/hxlliBBdydt6oUzbKO+4nbGkU4qa6bt34DdJEeHzQksu?=
 =?us-ascii?q?4x2zIaPcieFEfgJ+TrZSFpVO5LVVti4m3peRMNQJW2aFLduGC94iAPERvjKwV1?=
 =?us-ascii?q?Ov71GonPhMiryuy+4ZLebxlLiTanfb9+MAi9oBnMuMURnYZsMLs6xAHTontPde?=
 =?us-ascii?q?RWxGdoKkyWkh3h+Mq+/4Nt/jpJtf45+MFOTav1f6IjTbxFFzsmKHw65NfqtRbY?=
 =?us-ascii?q?UwSC4GYXX3gMnRpJBwjF6wz6Xov0vyDnuOdxxDWWMMvrRr0vRz+s87lkRwPpiC?=
 =?us-ascii?q?cfNj427mfXitBrjKlGpB6tvgFzz5LIbI2QMvd+e6LdfcgBRWpAWMZRWDFKDJ2l?=
 =?us-ascii?q?YYASAeoBPPhXr43gqFATqRezCxWgCObpxzRVhHH5wLc63vwhHw/YwQIuEdEAvn?=
 =?us-ascii?q?PPodnpKKsfS/y5wbPUwTnfaf5dxDfz6JLPchAkufyDX7NwcMvRyUkyEAPOk1Kd?=
 =?us-ascii?q?qIzkPjOVzOsNsnSX4/ZuWO+0lm4otxtxriKxycgxl4nEn4QYwU3H+yVh2Is5O8?=
 =?us-ascii?q?G0RUphbdOnEJZcrT+WO5Z2T884XW1kpDo2xqUbtZO6eCUG0ooryhDfZvCdbYSF?=
 =?us-ascii?q?4wjvWeSeLDp+mXlrYqiwhwyo/kil0uD8U86030tUoSddidnMs2wN1wTU6siaVv?=
 =?us-ascii?q?tx5keh1iiL1wDU8uxEJFo7lavfK5I42r4wmYcfvV3NHiPohEn6kLWadkoj+uiv?=
 =?us-ascii?q?5OTnZqvpqoWAOI9zjwHyKqUumsqhDuQkKgUCQXSX9OCm2LDg/UD1WqtGguA2n6?=
 =?us-ascii?q?XDrpzWOdgXqra8AwBP04Yj7xi/Dy2h0NQdhXQGLFNEeBKdgIjoJ13CPP71AOyi?=
 =?us-ascii?q?g1uwijdn3e7JMaD8ApnVNHjMjK/hfaph605b0AczydFf55RJCrAOOf7zWVH+tM?=
 =?us-ascii?q?beDhAnNwy52PjnCNpj2YMEQ26PAbGWMLnUsVCW4uIjOe6MZJUauGW1BeIi4qvf?=
 =?us-ascii?q?jG05hFhVKbi73ZIWMCjjNultOQOUbWe60YRJKnsDogdrFL+is1aFSzMGIinqUg?=
 =?us-ascii?q?=3D=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A2DHAgCT31Fcf8jXVdFkHAEBAQQBAQcEA?=
 =?us-ascii?q?QGBZQKDOkoPjHyLZwaKZBhthViCc4cJAQoBASyEQIMJIkoBAwEBAgEDARMBAQk?=
 =?us-ascii?q?LCwgnMUIBDgGBaCmCXzZSgRUBBQE1W4JHAYF0DaBIPIwXM4hjAQeBSwkBCIdth?=
 =?us-ascii?q?EGBD4EHg26Ef4NUgkMCgSwBAQGPdZEzAQYCAYFjgUKPASSDMoZ1iAsBLZsOAgQ?=
 =?us-ascii?q?CBAUCBQ8hgzNNJYFsCoFEglGOLB4zgQeGSIVrgk0B?=
X-IPAS-Result: =?us-ascii?q?A2DHAgCT31Fcf8jXVdFkHAEBAQQBAQcEAQGBZQKDOkoPjHy?=
 =?us-ascii?q?LZwaKZBhthViCc4cJAQoBASyEQIMJIkoBAwEBAgEDARMBAQkLCwgnMUIBDgGBa?=
 =?us-ascii?q?CmCXzZSgRUBBQE1W4JHAYF0DaBIPIwXM4hjAQeBSwkBCIdthEGBD4EHg26Ef4N?=
 =?us-ascii?q?UgkMCgSwBAQGPdZEzAQYCAYFjgUKPASSDMoZ1iAsBLZsOAgQCBAUCBQ8hgzNNJ?=
 =?us-ascii?q?YFsCoFEglGOLB4zgQeGSIVrgk0B?=
X-IronPort-AV: E=Sophos;i="5.56,541,1539673200"; 
   d="scan'208";a="1054440854"
Received: from mail-pg1-f200.google.com ([209.85.215.200])
  by smtp2.ucr.edu with ESMTP/TLS/AES128-GCM-SHA256; 30 Jan 2019 09:33:46 -0800
Received: by mail-pg1-f200.google.com with SMTP id f3so187103pgq.13
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jan 2019 09:33:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=GtM9J7PYJtxRl5BZuKcAvjHRXIRqsfAVBpYWSsT6ylE=;
        b=r3lShEhuxMBG+mZVAEzjVcVcAxEquFm9qp/jBztrUExRVKM+1aXlP1VXLdV1iRCBX+
         OlNPGWtm86fP8LjRMAN9yFD4gayGJu4BgL4KXAj7AMeqOPYRt3nV4h7rx94YQE1grCr0
         SWexDD3F2BGmUBgN2Hnl965K/+4hVs75oiLTa16atq/RIJ3NQjsy92cLVIEhOZrPGKUg
         Zmrs38k3PxOrAMAkvYmn9IHgSlFFGhjywuitzLInpHlcKI55NrdxUkjahXuQtKLnYa84
         zGaLk0kMtuDkDo3CC1XYbKfXeEJVA3uAJAxL3wUT9ATxfh1fYSrwQDsPdP6FjHPudI6c
         KQpw==
X-Gm-Message-State: AJcUukft2ipyWCTZt7h7lJ3VJT0HtL9n3+b1XLUC/FvCcs2+QQoZvAgZ
        BXVmhq58+fJ2DTXbr2HINqepL7QKBYagBv2LgmUTYoPkOjDZZkMIW2e7U0rs2jK5Yz6+sqFYLmg
        Bs6d2dc+7I1YOuH7MvKmhGqmoFQ==
X-Received: by 2002:a17:902:7e0d:: with SMTP id b13mr31671333plm.154.1548869626533;
        Wed, 30 Jan 2019 09:33:46 -0800 (PST)
X-Google-Smtp-Source: ALg8bN7aw1Nz1H93FMudfOy5NE53BPL9EwY5HYqHDs8E/VMwVrjm5xUaIJqekqsExzUDQEqM1xFAxA==
X-Received: by 2002:a17:902:7e0d:: with SMTP id b13mr31671312plm.154.1548869626143;
        Wed, 30 Jan 2019 09:33:46 -0800 (PST)
Received: from Yizhuo.cs.ucr.edu (yizhuo.cs.ucr.edu. [169.235.26.74])
        by smtp.googlemail.com with ESMTPSA id x27sm6729222pfe.178.2019.01.30.09.33.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 30 Jan 2019 09:33:45 -0800 (PST)
From:   Yizhuo <yzhai003@ucr.edu>
Cc:     csong@cs.ucr.edu, zhiyunq@cs.ucr.edu, Yizhuo <yzhai003@ucr.edu>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] [media] ts2020: Variable "utmp" in function ts2020_set_tuner_rf() could be uninitialized
Date:   Wed, 30 Jan 2019 09:33:30 -0800
Message-Id: <20190130173331.4672-1-yzhai003@ucr.edu>
X-Mailer: git-send-email 2.17.1
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In function ts2020_set_tuner_rf(), local variable "utmp" could
be uninitialized if function regmap_read() returns -EINVAL.
However, this value is used in if statement and written to
the register, which is potentially unsafe.

Signed-off-by: Yizhuo <yzhai003@ucr.edu>
---
 drivers/media/dvb-frontends/ts2020.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/media/dvb-frontends/ts2020.c b/drivers/media/dvb-frontends/ts2020.c
index 931e5c98da8a..e351039f2eae 100644
--- a/drivers/media/dvb-frontends/ts2020.c
+++ b/drivers/media/dvb-frontends/ts2020.c
@@ -177,9 +177,12 @@ static int ts2020_set_tuner_rf(struct dvb_frontend *fe)
 {
 	struct ts2020_priv *dev = fe->tuner_priv;
 	int ret;
-	unsigned int utmp;
+	unsigned int utmp = 0;
 
 	ret = regmap_read(dev->regmap, 0x3d, &utmp);
+	if (ret)
+		return ret;
+
 	utmp &= 0x7f;
 	if (utmp < 0x16)
 		utmp = 0xa1;
-- 
2.17.1

