Return-Path: <SRS0=Yw3T=OB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=CHARSET_FARAWAY_HEADER,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C19B7C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 13:38:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9318F20672
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 13:38:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9318F20672
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=tencent.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436962AbeKWASC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 19:18:02 -0500
Received: from mail2.tencent.com ([163.177.67.195]:45359 "EHLO
        mail2.tencent.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388648AbeKWASB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 19:18:01 -0500
X-Greylist: delayed 479 seconds by postgrey-1.27 at vger.kernel.org; Thu, 22 Nov 2018 19:15:25 EST
Received: from EXHUB-SZMAIL02.tencent.com (unknown [10.14.6.23])
        by mail2.tencent.com (Postfix) with ESMTP id BD6568EB2B;
        Thu, 22 Nov 2018 21:28:04 +0800 (CST)
Received: from EXMBX-SZMAIL003.tencent.com ([fe80::b5c3:10b3:7066:5904]) by
 EXHUB-SZMAIL02.tencent.com ([::1]) with mapi id 14.03.0415.000; Thu, 22 Nov
 2018 21:28:04 +0800
From:   =?gb2312?B?ZGJ5aW4o0vzsxyk=?= <dbyin@tencent.com>
To:     "darrick.wong@oracle.com" <darrick.wong@oracle.com>
CC:     "linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        =?gb2312?B?ZGJ5aW4o0vzsxyk=?= <dbyin@tencent.com>
Subject: [PATCH] fs/xfs: fix f_ffree value for statfs when project quota is
 set
Thread-Topic: [PATCH] fs/xfs: fix f_ffree value for statfs when project
 quota is set
Thread-Index: AdSCZx1EJQJu25maTjmyYf9Hnxg2Tw==
Date:   Thu, 22 Nov 2018 13:28:04 +0000
Message-ID: <6EC51EE77FA0264BB8DAD779E0C341C9014BD77C91@EXMBX-SZMAIL003.tencent.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.32.219.177]
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

V2hlbiBwcm9qZWN0IGlzIHNldCwgd2Ugc2hvdWxkIHVzZSBpbm9kZSBsaW1pdCBtaW51cyB0aGUg
dXNlZCBjb3VudA0KDQpTaWduZWQtb2ZmLWJ5OiBZZSBZaW4gPGRieWluQHRlbmNlbnQuY29tPg0K
LS0tDQogZnMveGZzL3hmc19xbV9iaHYuYyB8IDIgKy0NCiAxIGZpbGUgY2hhbmdlZCwgMSBpbnNl
cnRpb24oKyksIDEgZGVsZXRpb24oLSkNCg0KZGlmZiAtLWdpdCBhL2ZzL3hmcy94ZnNfcW1fYmh2
LmMgYi9mcy94ZnMveGZzX3FtX2Jodi5jDQppbmRleCA3M2ExZDc3ZWMxODcuLjMwOTFlNGJjMDRl
ZiAxMDA2NDQNCi0tLSBhL2ZzL3hmcy94ZnNfcW1fYmh2LmMNCisrKyBiL2ZzL3hmcy94ZnNfcW1f
Ymh2LmMNCkBAIC00MCw3ICs0MCw3IEBAIHhmc19maWxsX3N0YXR2ZnNfZnJvbV9kcXVvdCgNCiAg
ICAgICAgICAgICAgICBzdGF0cC0+Zl9maWxlcyA9IGxpbWl0Ow0KICAgICAgICAgICAgICAgIHN0
YXRwLT5mX2ZmcmVlID0NCiAgICAgICAgICAgICAgICAgICAgICAgIChzdGF0cC0+Zl9maWxlcyA+
IGRxcC0+cV9yZXNfaWNvdW50KSA/DQotICAgICAgICAgICAgICAgICAgICAgICAgKHN0YXRwLT5m
X2ZmcmVlIC0gZHFwLT5xX3Jlc19pY291bnQpIDogMDsNCisgICAgICAgICAgICAgICAgICAgICAg
ICAoc3RhdHAtPmZfZmlsZXMgLSBkcXAtPnFfcmVzX2ljb3VudCkgOiAwOw0KICAgICAgICB9DQog
fQ0KIA0KLS0gDQoyLjE2LjINCg==
