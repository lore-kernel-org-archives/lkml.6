Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9435ECE562
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 03:20:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 68BAE214C4
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 03:20:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="UXlfpOCW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 68BAE214C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730532AbeIQIqE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 04:46:04 -0400
Received: from mail-dm3nam03on0114.outbound.protection.outlook.com ([104.47.41.114]:30720
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729649AbeIQIaU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 04:30:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ch0I5uQUpVMFBgpCV20+zWcyZzVrt08jLykegEMAC5U=;
 b=UXlfpOCWKIzhu/96J2JCcGYqrHYbTUpPuruAOn2sVtBJobER2Jp0V8766qEFd7K721ECZkUjIgKtAhouIfKOJUwLI1Obj/pTrU6p1UEC4Pm7Wy9PZCvVmL41y7a2ErVluwWorsHImYUjSBg2eEI16F8HNLPSd+I5F/qdp8d8ijA=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0774.namprd21.prod.outlook.com (10.173.192.20) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1185.5; Mon, 17 Sep 2018 03:04:56 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1185.003; Mon, 17 Sep 2018
 03:04:56 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Tony Lindgren <tony@atomide.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.14 67/87] wlcore: Add missing PM call for
 wlcore_cmd_wait_for_event_or_timeout()
Thread-Topic: [PATCH AUTOSEL 4.14 67/87] wlcore: Add missing PM call for
 wlcore_cmd_wait_for_event_or_timeout()
Thread-Index: AQHUTjL1Gh7TFDYqd0e23NJVeNFJyw==
Date:   Mon, 17 Sep 2018 03:03:07 +0000
Message-ID: <20180917030220.245686-67-alexander.levin@microsoft.com>
References: <20180917030220.245686-1-alexander.levin@microsoft.com>
In-Reply-To: <20180917030220.245686-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0774;6:pebes+bDAZBJxoDmYamcsAihSNptglI0x45flGpr96xEQVrO11phWFQHBAujzX7DAVVm+q9qj3MohUpyZxA9H9W7Kw3nDiZI0sGnLVZ745Q1W9E3TPOal4Z+VjUuE0O3Ty2u4bjwJ9LMKTV94OMriyXPjo/SaPrCx3W48a757tcZTHHiJS8w46gHyEOQ2oc4FpPmYZqHIyo1hMXX0k3bME6boQK1T/90pTarnMDmBWl0M/bUPM2rfhsfqLXxVv/2yhOe2US7FYzbqf13pE8HfV85bUYOsEslZ2E/dMrBPI1s5oy8qt4az7YtzDn00mkQBAu9irqv8va2q6HK46kPl1a+oiKxhktkD8aGyzjtQGIO3TVAamyuKfu6bIZPVaU/XNRaVNNI9m2iih1qf7b19w43qtAMu0jgR9zAg+ij1iA/yI0jdltV7Ls8bIsR4JcSmryAMP6MN/STec4O98bg7g==;5:EIm0Oax2w4a/18AS5/8gAArLWjZRlzB06rcAK19CXR3nXQis5fdmmymPyPBwLtsz1OvOKPRFXtPvw4suUOaPdgHWH4/DQVF4CLQ4iqPXLLmG1/Yoi9+wIpCep1JJ6vvfgpeNGJbWWcElDPVT28ynG9jfO/e4GJoAzwaelcBOwZA=;7:+C3GvqMKCw+kWSIovD9Kqk0FMlNI60MpOXa0mOSCr030y2FTzIWiCRziu/O0S29ZCeRGtxAK+eUChwsunlV8mc6gct0fZQSQDViixMx2HwYd4sKMVUwQ0z8yLUf+ea3PpyGGOnsxEEWDKn5S/qA6IfsPWyatj1hcNgmQEDycSMZ2H/BXm8Rk+LsSZBVj+GV5Tq7/0H/oBR1u1TwGgiCFTnlq09f0eGhMjdj705icILMlMSXE2XEoLOChJXL/OxnZ
x-ms-office365-filtering-correlation-id: f6887bd5-aab0-4d62-a840-08d61c4a58fb
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0774;
x-ms-traffictypediagnostic: CY4PR21MB0774:
x-microsoft-antispam-prvs: <CY4PR21MB0774F2B8C3010B7D10BD787AFB1E0@CY4PR21MB0774.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231355)(944501410)(52105095)(2018427008)(10201501046)(3002001)(6055026)(149027)(150027)(6041310)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(20161123560045)(201708071742011)(7699050)(76991041);SRVR:CY4PR21MB0774;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0774;
x-forefront-prvs: 0798146F16
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(136003)(376002)(396003)(39860400002)(346002)(199004)(189003)(54906003)(105586002)(316002)(4326008)(6116002)(1076002)(14454004)(305945005)(7736002)(22452003)(81156014)(66066001)(81166006)(99286004)(8936002)(8676002)(3846002)(478600001)(72206003)(53936002)(10290500003)(68736007)(106356001)(6512007)(25786009)(76176011)(110136005)(11346002)(476003)(2616005)(446003)(6436002)(486006)(6506007)(86612001)(10090500001)(102836004)(86362001)(6346003)(186003)(26005)(36756003)(97736004)(2906002)(256004)(14444005)(2900100001)(6486002)(217873002)(107886003)(2501003)(6666003)(5250100002)(5660300001);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0774;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: szWwKTkzQtwp8jVrU2xzpO3Eu4R8eCzKelAUPHdib93rLs73L1EEOlElaVSxI1JY2VY8GMQB3YaHQVeAwGr+uMDXW/EUORaZTAZzrTfkcgrony5SAub3twHneHrr2JtsDASMDbhEp8TASoiuiU7O1Remxmqe1YkN9/Tz0dar6PJs2MjAAfmOfMi4UTdU4XBRmEpcufw6sH5voyv6tCWiMIrZoegF19LGLWlGQHANQCREsbAKwalItH9gNjxt9QDkepHrq1sNDCHJI6ircJYVrWhwIEGLmRuOudh1wt3kX9S3E4SOAGE8K7s8z9HNzEA/nnDp7GMAEQ1aPg56SEkkGaZSNRZg5pbQTO88Kky/cKg=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f6887bd5-aab0-4d62-a840-08d61c4a58fb
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Sep 2018 03:03:07.6497
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0774
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tony Lindgren <tony@atomide.com>

[ Upstream commit 4ec7cece87b3ed21ffcd407c62fb2f151a366bc1 ]

Otherwise we can get:

WARNING: CPU: 0 PID: 55 at drivers/net/wireless/ti/wlcore/io.h:84

I've only seen this few times with the runtime PM patches enabled
so this one is probably not needed before that. This seems to
work currently based on the current PM implementation timer. Let's
apply this separately though in case others are hitting this issue.

Signed-off-by: Tony Lindgren <tony@atomide.com>
Signed-off-by: Kalle Valo <kvalo@codeaurora.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/net/wireless/ti/wlcore/cmd.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/net/wireless/ti/wlcore/cmd.c b/drivers/net/wireless/ti=
/wlcore/cmd.c
index 761cf8573a80..f48c3f62966d 100644
--- a/drivers/net/wireless/ti/wlcore/cmd.c
+++ b/drivers/net/wireless/ti/wlcore/cmd.c
@@ -35,6 +35,7 @@
 #include "wl12xx_80211.h"
 #include "cmd.h"
 #include "event.h"
+#include "ps.h"
 #include "tx.h"
 #include "hw_ops.h"
=20
@@ -191,6 +192,10 @@ int wlcore_cmd_wait_for_event_or_timeout(struct wl1271=
 *wl,
=20
 	timeout_time =3D jiffies + msecs_to_jiffies(WL1271_EVENT_TIMEOUT);
=20
+	ret =3D wl1271_ps_elp_wakeup(wl);
+	if (ret < 0)
+		return ret;
+
 	do {
 		if (time_after(jiffies, timeout_time)) {
 			wl1271_debug(DEBUG_CMD, "timeout waiting for event %d",
@@ -222,6 +227,7 @@ int wlcore_cmd_wait_for_event_or_timeout(struct wl1271 =
*wl,
 	} while (!event);
=20
 out:
+	wl1271_ps_elp_sleep(wl);
 	kfree(events_vector);
 	return ret;
 }
--=20
2.17.1
