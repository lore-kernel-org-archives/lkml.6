Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0B05ECE563
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 03:30:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 61B81208AE
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 03:30:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="fvB0abQJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 61B81208AE
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729858AbeIQIzn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 04:55:43 -0400
Received: from mail-eopbgr710116.outbound.protection.outlook.com ([40.107.71.116]:59328
        "EHLO NAM05-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727664AbeIQI1z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 04:27:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ch0I5uQUpVMFBgpCV20+zWcyZzVrt08jLykegEMAC5U=;
 b=fvB0abQJ/2gK0znVNJbxCMGUToxRcpBjWRi0qjaxsygK3OJ9vT7yI4DJvPs9TqP75JkBGb5kSNMNjJQ5TPiU3/g1xx0iifneC2csPdno0q06DuHmUYDfwwXxJ60vVeMBXTdyaYTjrPYl67f27NOr8Gazoo+z2EnlNpOqIi4VFa4=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0790.namprd21.prod.outlook.com (10.175.121.144) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1164.9; Mon, 17 Sep 2018 03:02:35 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1185.003; Mon, 17 Sep 2018
 03:02:35 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Tony Lindgren <tony@atomide.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.18 095/136] wlcore: Add missing PM call for
 wlcore_cmd_wait_for_event_or_timeout()
Thread-Topic: [PATCH AUTOSEL 4.18 095/136] wlcore: Add missing PM call for
 wlcore_cmd_wait_for_event_or_timeout()
Thread-Index: AQHUTjKwKYLJfaNciESpTnxVOc12dw==
Date:   Mon, 17 Sep 2018 03:01:11 +0000
Message-ID: <20180917030006.245495-95-alexander.levin@microsoft.com>
References: <20180917030006.245495-1-alexander.levin@microsoft.com>
In-Reply-To: <20180917030006.245495-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0790;6:VJKcNulzpJBTk5sccokZSFdzxxwzmP7mA7hlkE7Kr7pXXgRSVmtQ5vyQHhkFB8p2GlqKiuskxstnNFHfu8JYuwprKyekVae+ESBNDCmw8xYZTO8Cq+9ymM1ntgVMGO3Cy5ccSa3ixh1O3HWIY+FNu8GyelvTNpVb6nJnSvVfFxjQLahf/9aEWbnRJlv8nHKGxP3jUVyFARGdBWefSOWlRRy5J7c6JQceb3dFnOZWZAmnRXoExAJPpNaZMxUS/FDQpowgHzBEfWZtYGRi9gZsTv2Hd/lGsjWS4j1FvjjvHZ8XY+pgoUzTer7PbcXOesHvYrqbQdGqBnELTJsKIyzs7XiJuLFEyqqd9PyL2zE0byGBCP3SGAJ78676N0gFVy40+EcAXL5WQdIV1nFtOROI5i3CVKMiI9sn3TLv5+sXinQvvdgn7DUeLJ9DJR0TpKkFrq4vA+u413qCh+ewxX/ejw==;5:WQqK8JuJzN6l2rorEuVpP6jAiYf78GItPFEvN3rHIJ7scTwb3gckHiAa19PEx9zSknmXzK5sIWeWwShsspSH7fa+zbQMruT4N5IWyTk2kkRNhW6Urxqe7MUUnWfoVc6GKhaiJqNOXgAYnkp/uBddqifA1A5l/7W6XgXCA69Lt+w=;7:Eam2SXF8X9rbm1uaXCfUqJmqaFovkIGhq76RBZymD3v1MNozSv1qoMEdjAPyDkPpbDeegPx9KHM0SpopcO2YW+46jUb1GjcD0wZb2DCjZdc5cPEKKzjzjlVvgQYzMh+0Uv8D6chsyJYq4BSxQmjdrb6LZPeKscfzsBP/FGoXOWpd5BzwgfuRFNFMWINfhZ8vt4TJukOOsxkir7lec4SHTjl7+v4ciWRSzdtIwS8krcJtYaRk3xQ7J1z1UzgOZBCR
x-ms-office365-filtering-correlation-id: 83a3ff31-dafd-4b4e-e6d8-08d61c4a051b
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0790;
x-ms-traffictypediagnostic: CY4PR21MB0790:
x-microsoft-antispam-prvs: <CY4PR21MB07900DC5C57BEB25A83BCC6EFB1E0@CY4PR21MB0790.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(3002001)(93006095)(93001095)(3231355)(944501410)(52105095)(2018427008)(6055026)(149027)(150027)(6041310)(20161123562045)(20161123564045)(20161123560045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699050)(76991041);SRVR:CY4PR21MB0790;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0790;
x-forefront-prvs: 0798146F16
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(39860400002)(136003)(396003)(376002)(366004)(199004)(189003)(76176011)(22452003)(6666003)(110136005)(99286004)(6436002)(6486002)(2900100001)(2906002)(54906003)(6346003)(10090500001)(5660300001)(7736002)(6512007)(14444005)(217873002)(316002)(256004)(53936002)(36756003)(6506007)(25786009)(106356001)(26005)(86612001)(10290500003)(1076002)(68736007)(476003)(6116002)(3846002)(478600001)(5250100002)(11346002)(446003)(72206003)(2501003)(81156014)(81166006)(8676002)(14454004)(102836004)(107886003)(186003)(2616005)(97736004)(86362001)(66066001)(305945005)(486006)(8936002)(4326008)(105586002);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0790;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: fh3cp0dwMofvoBTEtwQVvUWowfpbBd2MwL/aAip4jQpN2yfqUmfCeZIFAg+0j2dhGAp+T9S9O38kdsbFTLabNkYSkMkK0zKTbK5bQhenuEf9JP2sgeHGHTeSFtceJN7UJWQ2gl1vK7IRSFhrKmbewoAN41gs2u1CRzdkzizKbi963iYdGuXd/xPYKLf7TpgXYs9a4p4YW5HoaC8k6JOSR0Bei4QDB5+KknjbNyYz84v9jkzH6yTE8h1rCTQuKwE5rmBEp96dcia7Q/4EXLaWSV7noIbSct1TovTTniV2n4tZpz9wCzoy1sy+rbpMo3gDQR8dJT2a5bV1Ps9bwDzcDnHecYFVZ82WBf7q9Nr2ecU=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 83a3ff31-dafd-4b4e-e6d8-08d61c4a051b
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Sep 2018 03:01:11.9792
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0790
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
