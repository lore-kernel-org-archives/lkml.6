Return-Path: <SRS0=aodX=LQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 656DCC43334
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 13:12:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 12A2220855
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 13:12:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="nZnY/yST"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 12A2220855
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729673AbeIBR2c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Sep 2018 13:28:32 -0400
Received: from mail-dm3nam03on0093.outbound.protection.outlook.com ([104.47.41.93]:1728
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728127AbeIBRXh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Sep 2018 13:23:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VPkunMDu6p1v7/2wbXHlMi846EvFkzHGIGbWEZkpDSI=;
 b=nZnY/ySTtVXBtoz3bnlF9BM0PdJ4Eg2R1ll1/R/pmYI+5iajT0y/fDIPZWFC0V7UYnzBeCObGCiNi1JUaQaJTOMe8W+t4Tt5KBfd1Ih0dZZ7QV8qSBt8Fkcm0TQy935FKRkJanaXfpy422q45BAGkbDNphyu/8v4NbP06MXrY6w=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0149.namprd21.prod.outlook.com (10.173.189.19) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1122.2; Sun, 2 Sep 2018 13:07:49 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611%7]) with mapi id 15.20.1143.000; Sun, 2 Sep 2018
 13:07:49 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Lars-Peter Clausen <lars@metafoo.de>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>,
        "Stable@vger.kernel.org" <Stable@vger.kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.14 62/89] iio: ad9523: Fix return value for
 ad952x_store()
Thread-Topic: [PATCH AUTOSEL 4.14 62/89] iio: ad9523: Fix return value for
 ad952x_store()
Thread-Index: AQHUQr3lSbf1aBwuAkK89y4N4pOLnw==
Date:   Sun, 2 Sep 2018 13:07:26 +0000
Message-ID: <20180902064918.183387-62-alexander.levin@microsoft.com>
References: <20180902064918.183387-1-alexander.levin@microsoft.com>
In-Reply-To: <20180902064918.183387-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0149;6:VpUOLYOSRhrtLLOQ5IPu3bYfXhUsvcV4089ramWW7rjnCVYaHABxgsDZshOv2R3EMjFZu2bcqfnR6mZbxw/kuVXe+MMFk1u9wJBlT1cm/5ISG7NtWwUNxPS/tHPFq6Gb+jpasD6I+7XoqalLCbPSOk2ABQZ0/BlEc9FhZYUTjIIMaZb5iUyMyKrddv453NqOePc7J4pKXbo8tlraP+H5QdI1/KxOI6+ARHSFS45Ncuaydu+IMSjMXsfrlRmxHYEQzDDpJXamWfFR3VVxz9du1WSkuWWOJjXzw3EbVdWE3udfk0m/2VGfd4jAjRhFIvjqxi5hSIP5h5MkgmDjT3MyNpc/Tzoh+4lfag4KGnDoy1mnEK7RQImNXZIjQakHqUysAb3N0ua+wOsvskK5G1wGdkimqy9Zr7SLbjyw8lW8z+vY0GCyomaXsAmTsCdWPlb/LASrmar4oWJseCm4tMIcUQ==;5:Np76JAmuC2CPgNCrH6z8Pt7etE97H3VwbE6iVhm8NbdVRhbf/eQP9PX0zdRnldOLbyo9WW65xb1RmGbKCyEdefFBFu/HmofCl9W1+X+pHxzf+tE35VSwtU0FTNqdF+qGA5B+Eo0vHBCkI7VrUEd6/1eH9PjiXwJ0qUDHSPFvVN8=;7:jkrHuqJb3hfqzZBwS5+UqK71bpXhZmgUbtGQbg5Z9c0VSIc32UXp0sblkf3WdZHdTgQcA4HMhZfp34wjAh+gbqOBQ7r4GR/6ha6534B/SRj4fuN6SKEuongG5+6qY+ZGvmfK5V0obAlhhBf28YViPsVPAljDaqpgwpUG124W8tDjgcz6mUNL5+4MImKxPpSFPef1RxGsZ590OtO0hG15Tf0xyfasr7d5lohDF9ekloF7Dr1pjFJVEecQJT+43Juq
x-ms-office365-filtering-correlation-id: ee96d292-61fd-4d64-bd23-08d610d5156e
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(4534165)(4627221)(201703031133081)(201702281549075)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0149;
x-ms-traffictypediagnostic: CY4PR21MB0149:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-prvs: <CY4PR21MB01499B0B5E788D139E0531EDFB0D0@CY4PR21MB0149.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(9452136761055)(232431446821674)(50582790962513);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(10201501046)(3002001)(3231340)(944501410)(52105095)(2018427008)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123558120)(20161123562045)(201708071742011)(7699049)(76991033);SRVR:CY4PR21MB0149;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0149;
x-forefront-prvs: 078310077C
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(376002)(39860400002)(136003)(346002)(396003)(199004)(189003)(76176011)(6116002)(446003)(11346002)(3846002)(5660300001)(110136005)(54906003)(102836004)(26005)(22452003)(316002)(99286004)(6506007)(186003)(6666003)(107886003)(25786009)(1076002)(4326008)(305945005)(2501003)(7736002)(66066001)(97736004)(10090500001)(68736007)(5250100002)(8676002)(81156014)(81166006)(6486002)(6512007)(6436002)(2906002)(53936002)(256004)(14444005)(217873002)(36756003)(575784001)(86362001)(10290500003)(105586002)(106356001)(72206003)(14454004)(478600001)(2616005)(476003)(486006)(2900100001)(8936002)(86612001);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0149;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: grSv5HxgTnDEN0n6Lig9u2HF/0R6Pe0B+OVqPoPbSCbhUi+qHg+/wKzkmyTmKbI6Xbm8QYAgi6s0AKOkTAnBQPuF+yGf07z2hMaFt9nghKiK4TQ6ayhM5MNGz+01Oz5emahI+VXK9l+I5oB76KYWsFP5LknXaXLcqyJJdOf3MK/S4VBEVYkMHNy/muDdrtq+MQG2atBkjT6ClJzTccYgwQC7YKZaioH3y6uqW5S5mX/qpGgluDlYfhV++vGlg1x2WclM4kqUAZGjlCyaYk/rKupbSGT1Xtr1dVSrps1zAuyp7W4ZqjFICo7mzgZi7eThnBumw+C/3/Y/goJfquMnsh5kKA65fJtTaQ8i/B3IBIA=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ee96d292-61fd-4d64-bd23-08d610d5156e
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Sep 2018 13:07:26.0918
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0149
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lars-Peter Clausen <lars@metafoo.de>

[ Upstream commit 9a5094ca29ea9b1da301b31fd377c0c0c4c23034 ]

A sysfs write callback function needs to either return the number of
consumed characters or an error.

The ad952x_store() function currently returns 0 if the input value was "0",
this will signal that no characters have been consumed and the function
will be called repeatedly in a loop indefinitely. Fix this by returning
number of supplied characters to indicate that the whole input string has
been consumed.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
Fixes: cd1678f96329 ("iio: frequency: New driver for AD9523 SPI Low Jitter =
Clock Generator")
Cc: <Stable@vger.kernel.org>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/iio/frequency/ad9523.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/frequency/ad9523.c b/drivers/iio/frequency/ad9523.=
c
index 99eba524f6dd..26caf7cc1db9 100644
--- a/drivers/iio/frequency/ad9523.c
+++ b/drivers/iio/frequency/ad9523.c
@@ -508,7 +508,7 @@ static ssize_t ad9523_store(struct device *dev,
 		return ret;
=20
 	if (!state)
-		return 0;
+		return len;
=20
 	mutex_lock(&indio_dev->mlock);
 	switch ((u32)this_attr->address) {
--=20
2.17.1
