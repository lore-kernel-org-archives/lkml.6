Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EB05ECE563
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 03:13:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D3C820693
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 03:13:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="iWAUXp0K"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2D3C820693
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731073AbeIQIb4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 04:31:56 -0400
Received: from mail-cys01nam02on0108.outbound.protection.outlook.com ([104.47.37.108]:42432
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730988AbeIQIbz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 04:31:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UJDeCDB+Q5Iw2HhduSat7batpnHT+5jyIJf2S3MUMo4=;
 b=iWAUXp0KpoMt9vzxdUN8Zd1Yv9rlyt+Jw4/xnqiw23nukdh3aTakXPIJUz7s9ig1fhXNXbnyGkMi+1pmaPdFCTKX2A2Pa1wv3bzvZfQZ2WF7YBiA9zkz9wFCGZ/bc4q6TWfsx+6pX9AXSXUNNCbDS1BCBPxfn2iV/m9cC++BeiM=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0742.namprd21.prod.outlook.com (10.173.189.8) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1185.6; Mon, 17 Sep 2018 03:06:22 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1185.003; Mon, 17 Sep 2018
 03:06:22 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Tony Lindgren <tony@atomide.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.9 44/57] wlcore: Add missing PM call for
 wlcore_cmd_wait_for_event_or_timeout()
Thread-Topic: [PATCH AUTOSEL 4.9 44/57] wlcore: Add missing PM call for
 wlcore_cmd_wait_for_event_or_timeout()
Thread-Index: AQHUTjMaAEIX1o1VzkSd2oDFjEUwkQ==
Date:   Mon, 17 Sep 2018 03:04:10 +0000
Message-ID: <20180917030340.378-44-alexander.levin@microsoft.com>
References: <20180917030340.378-1-alexander.levin@microsoft.com>
In-Reply-To: <20180917030340.378-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0742;6:H9Ea1QctpwkbITb3rjm2XOoGqwqz02QsOyEzjqrpJVB7/Lnyo6/Ru1MohWawwAtS+52AFYnhtBNQzmzcDIEvJUWgilSUsCDTE9hG4o8Zf/wsX8/7tIX3wscWEIM9zqZn882tpOKtFqnLB4f3sgeSdoJUBNQeCoeHnySCjUvEq6SZqe+y83nc+jF/WmUMpkXSKF/60ybB7yudWjjweFMN+OjYpS/uf7BbT0g+AqypAZaZ/G4BOJ7rtr6CBLsZnAuuOxdTQVdiXO5nTmGuSivT43r9HriBPfcA/tz7NjZa3kvqBvESVKx8Tvmn97IgwamftbkjeiAI97BJwZfWx4JPTEjkQMwvMWAqKUecvYfndEQrV7V+FP74JNKXNMyjWwQstNvM18ZAIDpup55qOIC+Sk2jTyMnaNYftEQ0EzzUnnoDWmpY5MyGByN9cw1DyJGoYx9UIMdXMtpFnmgZKm/J5A==;5:k2bQO6JkeRKo63gx0UF3FYpo/dGKEFtt5owaPXXMGyIcj51f5UWjc6JIzvh5Aa+f6fxwX0Per/FT5klbnzLVj8re9DKCwBqMfDA0I1tWSCyt0pSPQy5UuEgawDhwHKoO8m5sqqpbNCy+pVIXwlqkHzOyTq7kRMKvVrXWg/3xXic=;7:Q0ehjdlZ8kSCEZxw6PT0z2E9nfatwnI3cq5OEoPBZZBcPOrStAHvB8myU/pJZKalrqO5g8ipa6tMsonx8WUECjzrKe5D2sMkEKPJuzX0i2bqju4O9mu4x3Ni/t8uMCmMVR1LGp9vwH/Ytx8i0uKKTTWFUyCdDxt6Xy9FAy60b2POXLfy3vJuwCKv9Y/Wq0DrUtfTrUcU6tfFvrm+pjjqtLry3GQbVoD61bC+VtyfADugKQxz6VCBUjUEVZNytMHe
x-ms-office365-filtering-correlation-id: d50cbea5-1425-44e1-5ff1-08d61c4a8c0f
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0742;
x-ms-traffictypediagnostic: CY4PR21MB0742:
x-microsoft-antispam-prvs: <CY4PR21MB0742C9A89183F40BC8F63DB1FB1E0@CY4PR21MB0742.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(3002001)(3231355)(944501410)(52105095)(2018427008)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(20161123560045)(20161123564045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(201708071742011)(7699050)(76991041);SRVR:CY4PR21MB0742;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0742;
x-forefront-prvs: 0798146F16
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(136003)(346002)(366004)(396003)(376002)(199004)(189003)(6486002)(6436002)(6512007)(53936002)(4326008)(3846002)(217873002)(25786009)(2616005)(1076002)(14444005)(6506007)(186003)(6346003)(11346002)(446003)(26005)(2900100001)(6116002)(486006)(102836004)(256004)(107886003)(476003)(86612001)(86362001)(2501003)(14454004)(97736004)(66066001)(76176011)(6666003)(316002)(54906003)(110136005)(99286004)(68736007)(10090500001)(22452003)(81156014)(2906002)(36756003)(8676002)(8936002)(81166006)(7736002)(305945005)(105586002)(5660300001)(106356001)(10290500003)(478600001)(72206003)(5250100002);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0742;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: IIROVLK8i435DcUPGBJPXNn15m9NGsnDvXXKhywRZNLSAJQwo+WUp9eYvekimZOejEztWc1pOcGbhdxn6eDbrpC9MiKzVBF05tP+GnApOTjZFg93zDw8KePZDJYiqInyNDuTa+crimo1kGXQZ8EWaLpRcvaZQhe+QPsns5nQ07Tzzdx6oTg55wcYgI5C1tQWq9qxrLfB2FeuhQYe30F7SMhUHvqmixgxQE91aHMVQljzqonfoPZHTtMQ995kIj2w8QXndlstR+6q0q0SjkohC89P/pbqGNVI6MuIg3WDVWy3hSrUrBC/dehAeLORGLwLzTf7LKp6ncNDrxSvNSIax138dJ29QYCVYD+MBIFXXB0=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d50cbea5-1425-44e1-5ff1-08d61c4a8c0f
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Sep 2018 03:04:10.1177
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0742
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
index 7f4da727bb7b..96f83f09b8c5 100644
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
