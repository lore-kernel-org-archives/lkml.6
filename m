Return-Path: <SRS0=aodX=LQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44413C433F5
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 13:33:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E8B412077B
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 13:33:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="UO7N+XCE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E8B412077B
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728586AbeIBRtJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Sep 2018 13:49:09 -0400
Received: from mail-eopbgr700093.outbound.protection.outlook.com ([40.107.70.93]:58944
        "EHLO NAM04-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728037AbeIBRUq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Sep 2018 13:20:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8movVkFd11BFbwEzn83QjVr6cJBPOMaHE9q6TWK0H48=;
 b=UO7N+XCEGuB8iHvC7EThha3kuMYJTWpPZlvNOK6sLNrQ2V8rRtfSxEN1IPjC7SpWbV7zlIQH8WGixEIkjs+QMqpUNAsySx5wY1bYWyx+kjby5Ibgv1QJb9tvWmxhh+T5OL7z3svJd1sE+Tfahx3oXuIkPSF9cISUpGX9uF3UII4=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0120.namprd21.prod.outlook.com (10.173.189.14) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1122.2; Sun, 2 Sep 2018 13:04:16 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611%7]) with mapi id 15.20.1143.000; Sun, 2 Sep 2018
 13:04:16 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Loic Poulain <loic.poulain@linaro.org>,
        Kalle Valo <kvalo@codeaurora.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.18 056/131] wlcore: Set rx_status boottime_ns field
 on rx
Thread-Topic: [PATCH AUTOSEL 4.18 056/131] wlcore: Set rx_status boottime_ns
 field on rx
Thread-Index: AQHUQr1xTCPRg7oR8ESovdBZKReQgw==
Date:   Sun, 2 Sep 2018 13:04:11 +0000
Message-ID: <20180902064601.183036-56-alexander.levin@microsoft.com>
References: <20180902064601.183036-1-alexander.levin@microsoft.com>
In-Reply-To: <20180902064601.183036-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0120;6:FJfzGlYnFkSPDXeRtsKQArTFfSYCpVfrHIC6KiFZx1F+1qs62qNXcF2ngV/ZSpPQJ67X4eXtGHQEJkMFNcjM+fuD7yiRd+9oXAuiB4EnuoLT7xuZW53wCCiYSUJuL/W9vMXO9MlQApmlkv24L2SvbWwX21lI/8QUeoW5kcijjilY9ikjGNNoEZEYhW5erQIipCN4rVppcu87hAaA+5zS9ooXsgEUPTKif30osaicGRHrVRabAM9yzs/yKgSju+9zr463K1GIisbgmnwnFxSkVTke/UdAC7NqCtxZd6fKL8ERqJ6j7I7Tsgsokgv30fl819gGhzXSxRGZRdTHT9wPPsFetr6udUqK98WfcMNyFdBqIa7iUJPjvmv4wzmWwStJJh4TMa0rvhj+1bE1+MqLJMAyVGPuLkHcw1WmYBUUNK2VIW3W6zRjBD9NmhMYi2dmv86DfU4mGP47kmBXdakVVg==;5:76lYTZ2p3aHAM0OGNNtao4rraG1aAUKUMtjBh1IrNc2jaFenJKwM4/DVnNeZa7QRPZaA9Z12bmWCazZCHf+qg3voLfzPjOsLM2UQzwaqgI51JzaymbbWl4120suhdFOZ9LrT9c/1VB1mWXYE9vd9A3JJxUQnbmqxS/LJMiLLzqA=;7:Kt2GCpzkRr/6JxJ9HnienaFJbahv11/4K10qpCcw/96Lw+7vMqlDicrLGZc02prY5IKFDkM8tnih8OC9vQ3kR5DuJZsKtD+c0jR154oQLXWkApl/MVaybNebPOd8/XyWehPdynlIWfvJAEd3SxNWNzqT6z1gCA/JxAzxA6GtRu9MXIIt4295rhZG7o7KqnmaIV1MFFKYbb115xAJGviraLUD7HdQ0o2nFzn/WKHhxJ9ZVqWF9g9WHhA6otipCgpp
x-ms-office365-filtering-correlation-id: 9c222fb5-12a0-44a4-290f-08d610d496d7
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(4534165)(4627221)(201703031133081)(201702281549075)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0120;
x-ms-traffictypediagnostic: CY4PR21MB0120:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-prvs: <CY4PR21MB01200D85CBB3356067E790C3FB0D0@CY4PR21MB0120.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(3002001)(93006095)(93001095)(3231340)(944501410)(52105095)(2018427008)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123560045)(20161123564045)(20161123562045)(201708071742011)(7699049)(76991033);SRVR:CY4PR21MB0120;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0120;
x-forefront-prvs: 078310077C
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(136003)(376002)(366004)(346002)(39860400002)(199004)(189003)(110136005)(5660300001)(107886003)(26005)(6506007)(6666003)(2900100001)(8936002)(68736007)(66066001)(99286004)(76176011)(217873002)(2906002)(1076002)(316002)(3846002)(6116002)(86612001)(14444005)(54906003)(6436002)(305945005)(7736002)(256004)(86362001)(6486002)(25786009)(10290500003)(478600001)(14454004)(476003)(22452003)(5250100002)(97736004)(106356001)(72206003)(53936002)(2501003)(2616005)(446003)(11346002)(6512007)(10090500001)(4326008)(36756003)(105586002)(102836004)(8676002)(81156014)(81166006)(186003)(486006)(83323001);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0120;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: EV2nLmhVJ3UzvkAAvZp2BGpOoYpIvJleQA7V5Y6y3yNcDkiJbsYoUn7b5fBhgi9HDCKzw16dREIcJzEHIBbt6imZCCQqhN9/4WrlTLc4a08TIc3XHwxh8WWPPh6hAWWaFylyK6Vz79v0mqRnBW7GGz0CuLBddpQGxJIJrQKpuIGHHs0DyGNJWXdC0QHrfZOgGX84mmaNf/mMpj+CCl831CWNfljeJ6ITZh2QA7a4YhTpfwwssW/FIE85FGZA/8tiIpeTNsRuSZIjmJAdVdTV/r4U7104uN+9auQj/UX8JdRVXhaV+pBLNUOEkRm73nUWW//Ypm6O2ZRSpmZlVsnmHMWeXCxdIwL/K9cZRHHOIn0=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c222fb5-12a0-44a4-290f-08d610d496d7
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Sep 2018 13:04:11.6955
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0120
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Loic Poulain <loic.poulain@linaro.org>

[ Upstream commit 37a634f60fd6dfbda2c312657eec7ef0750546e7 ]

When receiving a beacon or probe response, we should update the
boottime_ns field which is the timestamp the frame was received at.
(cf mac80211.h)

This fixes a scanning issue with Android since it relies on this
timestamp to determine when the AP has been seen for the last time
(via the nl80211 BSS_LAST_SEEN_BOOTTIME parameter).

Signed-off-by: Loic Poulain <loic.poulain@linaro.org>
Signed-off-by: Kalle Valo <kvalo@codeaurora.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/net/wireless/ti/wlcore/rx.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/ti/wlcore/rx.c b/drivers/net/wireless/ti/=
wlcore/rx.c
index 0f15696195f8..078a4940bc5c 100644
--- a/drivers/net/wireless/ti/wlcore/rx.c
+++ b/drivers/net/wireless/ti/wlcore/rx.c
@@ -59,7 +59,7 @@ static u32 wlcore_rx_get_align_buf_size(struct wl1271 *wl=
, u32 pkt_len)
 static void wl1271_rx_status(struct wl1271 *wl,
 			     struct wl1271_rx_descriptor *desc,
 			     struct ieee80211_rx_status *status,
-			     u8 beacon)
+			     u8 beacon, u8 probe_rsp)
 {
 	memset(status, 0, sizeof(struct ieee80211_rx_status));
=20
@@ -106,6 +106,9 @@ static void wl1271_rx_status(struct wl1271 *wl,
 		}
 	}
=20
+	if (beacon || probe_rsp)
+		status->boottime_ns =3D ktime_get_boot_ns();
+
 	if (beacon)
 		wlcore_set_pending_regdomain_ch(wl, (u16)desc->channel,
 						status->band);
@@ -191,7 +194,8 @@ static int wl1271_rx_handle_data(struct wl1271 *wl, u8 =
*data, u32 length,
 	if (ieee80211_is_data_present(hdr->frame_control))
 		is_data =3D 1;
=20
-	wl1271_rx_status(wl, desc, IEEE80211_SKB_RXCB(skb), beacon);
+	wl1271_rx_status(wl, desc, IEEE80211_SKB_RXCB(skb), beacon,
+			 ieee80211_is_probe_resp(hdr->frame_control));
 	wlcore_hw_set_rx_csum(wl, desc, skb);
=20
 	seq_num =3D (le16_to_cpu(hdr->seq_ctrl) & IEEE80211_SCTL_SEQ) >> 4;
--=20
2.17.1
