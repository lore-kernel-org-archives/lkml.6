Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06156ECE563
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 03:11:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A1FE32147A
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 03:11:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="NnqEGkqv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A1FE32147A
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731335AbeIQIcl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 04:32:41 -0400
Received: from mail-sn1nam01on0093.outbound.protection.outlook.com ([104.47.32.93]:10176
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731293AbeIQIcj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 04:32:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G7dSHRRMTrq8X3Gui0OgucABN+AbgTNW+/WxrGf2seQ=;
 b=NnqEGkqvkpd6dA/rlQ4GW7FJ+B+J5bQ6EGEz3orGkKkZh+/XGZAJG8/srEBoenY3AOfs45mKLvn+Q4tWdNeeUbJVc43Sk4SfBfU46h4AUvd0bJD4PAZNRrUXRMJWRoB84CanAFxbgISHNsSS65+Cbiq/HizsDoPm0f6k374z9lA=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0759.namprd21.prod.outlook.com (10.173.192.13) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id
 15.20.1164.5; Mon, 17 Sep 2018 03:07:14 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1185.003; Mon, 17 Sep 2018
 03:07:14 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Tony Lindgren <tony@atomide.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.4 34/43] wlcore: Add missing PM call for
 wlcore_cmd_wait_for_event_or_timeout()
Thread-Topic: [PATCH AUTOSEL 4.4 34/43] wlcore: Add missing PM call for
 wlcore_cmd_wait_for_event_or_timeout()
Thread-Index: AQHUTjM+O3d3DdMQEEq8TqbP5J/wBg==
Date:   Mon, 17 Sep 2018 03:05:10 +0000
Message-ID: <20180917030445.484-34-alexander.levin@microsoft.com>
References: <20180917030445.484-1-alexander.levin@microsoft.com>
In-Reply-To: <20180917030445.484-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0759;6:648xqd+NvnASkuTdY8MW5prrfB6u68Jle846aXoI+0fuuv9qxz7IdpIFa5HZR4/2dG093f39DzRWs92yqd0Sl3r6CQiv6iTHzI//FcwonELHJoz/WD/oVqKCPxb6JeWbh2pN0gZxviulErpg3bv0X25v22qTYobne0tBsMBYaKR/MiWifAkWP1DGUoBc6JKfNwAYza7N8e3DcL5Nqc5zzYHlRjPNGooSbtGiMfZsOcaWfb8ahshEtJKe1+ng2+hMWRnV7ZYWwK5HsREWt8JbdCzAh1FozbYwYfpB9rg2vxB3RmtArFGQ9w/VA/2yzHcsg8Y+B1M5QmHu5NOSRvU9n1OJhGfZmpgxBZmEFqPk8rVI+8Pn9NJ2e2M8plm9KwDKb/rBHJW/mbZoFtgHgJYm7x8rVouSnKKv9mqsmjL+Xrig44LywXr5BRQkzsPWgEUBUorMtT3GUYc7LIqUsKM4TA==;5:WyKQUs/BA3laBOwvtrk5+8LlbeAQNhekOlwgRKxPEF5J+nrtMJ5/AcEA2qmhA7OlEcxT1/6oqwFYsLBELKeIujHY2qVKPX43QJtc4ibc7EzuDYMzDnaRD0D4qP+QdLgCt42pbOOJepH7nYW/NBY3jOCelgQ9+cS5MkiSVbCUqN0=;7:JRStIKuzil7jmD0eOUOyoyzmk1PoF3k+A9jikC/8C4HoMQ+W7byf7YSMFJMy21Qch5bp+A1kNEHvfNXPCGKxGbc76zUErZXlHOGSnk9Jf5QyP25OE9ZGwmB5rnbKKzHNBMloyDBOkhBiaw2i8Ndpx0Mm9CgEDlh+Fs/d9hdahtKxWJjNB1CBBgACqIbsS/1Rvj/9nuNnaCSgvDe7EHUBoKr81v2EkfTgPcjn0dFfqwXrM4a9s/B0TMvkUXLBVc7o
x-ms-office365-filtering-correlation-id: 599c93f9-f677-428f-8001-08d61c4aab0b
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0759;
x-ms-traffictypediagnostic: CY4PR21MB0759:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-prvs: <CY4PR21MB07595556046F9C84D6F5BBD8FB1E0@CY4PR21MB0759.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(3231355)(944501410)(52105095)(2018427008)(93006095)(93001095)(10201501046)(6055026)(149027)(150027)(6041310)(20161123562045)(20161123558120)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(201708071742011)(7699050)(76991041);SRVR:CY4PR21MB0759;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0759;
x-forefront-prvs: 0798146F16
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(346002)(396003)(136003)(39860400002)(366004)(189003)(199004)(2501003)(2900100001)(305945005)(7736002)(5250100002)(6436002)(5660300001)(53936002)(1076002)(86612001)(6512007)(2906002)(6116002)(3846002)(6666003)(6486002)(86362001)(97736004)(10090500001)(26005)(54906003)(256004)(14444005)(106356001)(102836004)(25786009)(99286004)(105586002)(6506007)(446003)(478600001)(10290500003)(72206003)(11346002)(217873002)(66066001)(68736007)(107886003)(4326008)(76176011)(36756003)(486006)(2616005)(476003)(316002)(14454004)(186003)(110136005)(22452003)(8936002)(8676002)(81166006)(81156014);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0759;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: kgM+GZ8zz6nfhh4nQD1toMtTP/53Lg0UoceiCm1v51URg12eoeO1kGhg5WjkaMbVrDhftLqqGT+hrdLrclAh1B+S5joSlCPanSmc0mvQni9ATI+AbkIkbMogMYSC+bvLNUrL1uFG85lZvcN8Bw3fEcbmUmSZ8jB04EfuP6lFsdp/ogF2rbXWuB98jd4WlYuGiCB/trtE6qMh9SjakFXGrk6NWlxxpNnFPUMGagg7/eXXxFBEmD8MXD/T36Vp43WIjhSsg+lM76pse24WD282EBtc3+xfcxeKVSaiGdE/H3SmYAZJWsdJZecuFSQCxwEq8EmOJniKP2f2/3jFDhE5UiBSS8QQmLQ856L/dx4SVU4=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 599c93f9-f677-428f-8001-08d61c4aab0b
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Sep 2018 03:05:10.5859
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0759
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
index f01d24baff7c..15dc7a398b90 100644
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
