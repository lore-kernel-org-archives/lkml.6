Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E1A6ECE564
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 03:08:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2ED892147A
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 03:08:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="nAm+HcgH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2ED892147A
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731589AbeIQIdP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 04:33:15 -0400
Received: from mail-bn3nam01on0100.outbound.protection.outlook.com ([104.47.33.100]:24062
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731526AbeIQIdP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 04:33:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8aPl5683LVGOblQMOp4jpxD+W9VV/gr9173MDem2aSk=;
 b=nAm+HcgHqCVksB15DOsGWa5HN/oUFJJfwSFkToOk2+DPdaX5e/JdDZiJiBuRFJD+mTw3OrNgzBfTB/0shMwLntaIp2ZzbRfLv4jxzUk5bAf7YEZDOuxzcGujND5wqf8Wy5vvItjagSYkgLHrZjx3pivYfowhzhjlY4wuJ/IiTqo=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0821.namprd21.prod.outlook.com (10.173.192.7) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1164.13; Mon, 17 Sep 2018 03:07:56 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1185.003; Mon, 17 Sep 2018
 03:07:56 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Tony Lindgren <tony@atomide.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 3.18 22/29] wlcore: Add missing PM call for
 wlcore_cmd_wait_for_event_or_timeout()
Thread-Topic: [PATCH AUTOSEL 3.18 22/29] wlcore: Add missing PM call for
 wlcore_cmd_wait_for_event_or_timeout()
Thread-Index: AQHUTjNXEV7PbGb+ckKT8fW8ijPfyQ==
Date:   Mon, 17 Sep 2018 03:05:51 +0000
Message-ID: <20180917030533.592-22-alexander.levin@microsoft.com>
References: <20180917030533.592-1-alexander.levin@microsoft.com>
In-Reply-To: <20180917030533.592-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0821;6:K0I52ds0vHd1W8Vj6i+Z2H14vkzuHt0EzPew9bfsuSt65ySElddsX6RgixbwfJvAzt0h+zzpXdw5Z9nld5LuNsBUxuGePVB63RRy79At0Lb/zZo1KlErd0f5/MxBHyhPiQUEqtD/B15MyTJYyVZ/FHMqNSVAyNoCU12GLXSL0xfRtr6eOqvFTJjfVCr5+1fJ2s9VcymjlInL1VOyouvd6Alw5tGV6wH41mZN879ND+cbXgZhTGYgppRJO0MISIlH7NLBX39s1+LxJjhJtnFTlTlQx+eiEpoQkMKd5Nj4TuCyXLr8oEQ7lrrCs7iLDDXjqyoI2tNkxLlD7o7QWglhuvKkjmoUZ6FltuUmTCDp3DfrecTi111yRsxQ/fsfdZFIzgX4p56fpMPfF1ngZ5ipdzXWmNxFVgMMlqn1Ar1dKYMKJGYJXZjAPr0n5FW3ECaO7Xg1n6fLEhJ3LOdRawnohQ==;5:/9iVYhXj2CxbyjpDFDZXIX/qzJQC7HncuX8NTZBZMF7FGr8YElF+m7ZJwQSPW9abKxmVrunX1rkpWHBxX1y2upx4OMgVrGnH84mj7WYGzQABJPa2ECazcnKETITLDxDb2EfbmKO2MDZutjTFS7BlqvjXJz8DQeOTkBxBBQK2nTc=;7:nF4WTyep1jnxiTxdumn4rk9qoHsUIvzdJSRFy4O+FkMREE7NCqQ5fza6Z8rvtVXpMCy2El8208h/hymhet+m8rGs2IfUJUSGS79l0UabVI4sBsi6CgcLLMaatkUM9ZxJdzVnvpHrsniYMTQj0ge5qD7bLgNp3g9EuXP1po/oIwM4CYFFvV+DcBNjPBVgdiqldxKanJqbSaj9YFR6PAH3RpCn3rmyYEB+928LeK+hei44IjZiiCzkNWdxZQD8FAlB
x-ms-office365-filtering-correlation-id: 8051bcff-9ab5-42be-6341-08d61c4ac42e
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0821;
x-ms-traffictypediagnostic: CY4PR21MB0821:
x-microsoft-antispam-prvs: <CY4PR21MB08212BDC4762A4F6EEDDE3CFFB1E0@CY4PR21MB0821.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231355)(944501410)(52105095)(2018427008)(3002001)(10201501046)(6055026)(149027)(150027)(6041310)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123560045)(20161123558120)(201708071742011)(7699050)(76991041);SRVR:CY4PR21MB0821;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0821;
x-forefront-prvs: 0798146F16
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(346002)(396003)(376002)(136003)(366004)(189003)(199004)(5250100002)(53936002)(14454004)(10090500001)(6436002)(97736004)(68736007)(7736002)(8936002)(305945005)(105586002)(106356001)(36756003)(10290500003)(81166006)(81156014)(72206003)(6486002)(8676002)(99286004)(6512007)(478600001)(2501003)(2906002)(446003)(217873002)(14444005)(256004)(2616005)(66066001)(6666003)(2900100001)(4326008)(107886003)(86612001)(5660300001)(3846002)(86362001)(110136005)(54906003)(186003)(316002)(22452003)(102836004)(6506007)(25786009)(26005)(11346002)(476003)(76176011)(486006)(6116002)(6346003)(1076002);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0821;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: 1bFRC4KZdgKFxVYIRhJJQJ0RDJjiFN4gzRHL6lcMH1eP3Nr8Sr/kLs6bzomMQ0DAyaZ5ZV7scj3KzT8o3n5M6z9jCiBj/09347mHVivs0Y4cN9zEVJfqM3db1TWVYk/Ebu8vY/F5bsNrZTxkfd+weR3yfM4TCuB43CjnV0WB2mjnCOnzFs/m49X2KrN2NiNshb2WFKwIf6WIECC/U3wciKDMpxgDM5jG8xegua4cayAjlFAK5HKSM5T7zxQngnzvZh0GVCIYmefjUzYObhLfWFntVM5k5zZ0cdOQVNPEEVYfg8huukYWZZ802TGsjN+k0Y+OoXJFrx3rLFAdmoRFr7Yq3n1KTLVfdHrqjMy2WGo=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8051bcff-9ab5-42be-6341-08d61c4ac42e
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Sep 2018 03:05:51.1076
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0821
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
index 05604ee31224..de43c0376143 100644
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
@@ -187,6 +188,10 @@ int wlcore_cmd_wait_for_event_or_timeout(struct wl1271=
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
@@ -218,6 +223,7 @@ int wlcore_cmd_wait_for_event_or_timeout(struct wl1271 =
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
