Return-Path: <SRS0=aodX=LQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1C09C43334
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 13:24:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 507282077B
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 13:24:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="fnq2nf1B"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 507282077B
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729329AbeIBRkA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Sep 2018 13:40:00 -0400
Received: from mail-co1nam03on0123.outbound.protection.outlook.com ([104.47.40.123]:41136
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729276AbeIBRaU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Sep 2018 13:30:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6q0mNKrUVZzE/fPHf3iy6kQUxjMu6PHm0MKjkatitis=;
 b=fnq2nf1B77UBtxYdbyKoMZbUlSSfJXSKyEZiPSN9cj7Dyc9j6Y+GfIXV1vy3NLjOSQkDOJnO5Ig4wlySoZBKL6g1QI14S710RQ8+MPxC9MZqrYlm49R7rzQVxbDxPixAgdrLdvunGXp39jBkMxOczA4X8Tb/L5+RzIVr28Cefk4=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0120.namprd21.prod.outlook.com (10.173.189.14) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1122.2; Sun, 2 Sep 2018 13:14:26 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611%7]) with mapi id 15.20.1143.000; Sun, 2 Sep 2018
 13:14:26 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Loic Poulain <loic.poulain@linaro.org>,
        Kalle Valo <kvalo@codeaurora.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.9 21/62] wlcore: Set rx_status boottime_ns field on
 rx
Thread-Topic: [PATCH AUTOSEL 4.9 21/62] wlcore: Set rx_status boottime_ns
 field on rx
Thread-Index: AQHUQr7fWQGkf43yvk6HaFWQCzmfzg==
Date:   Sun, 2 Sep 2018 13:14:26 +0000
Message-ID: <20180902131411.183978-11-alexander.levin@microsoft.com>
References: <20180902131411.183978-1-alexander.levin@microsoft.com>
In-Reply-To: <20180902131411.183978-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0120;6:jePItx4z3CbL4ABFClxBU2LPhNIPmSeW2Dm9znZRGrxWdVr6K0HXpXK866madcp+uaaedmSUBfXjKTqktYqXZ203cRxU/KsvLgn7Krzql6L49JvmwRGTZPOKDUxRZ8K+fcYxvSTrrX+15WEZOixEDgOakhzvEspgBZcdKmuxOaMXzbtdADwvQg2X5ZKyLL/lgcweDmuujZimPNTPKWdtDhl+lsWBTo2QMNiW0kZDXMMzVipZ7p5I73MwGIwI8rbcm6vUFg5KV78px+C+bIhcVq5zVXvxrNnSVmFG1L1UrPQmfEDIkXo0o0xW39sGS8beD9g5LHwJfCG52Ufaqj3mTAN3ToDOLJG0IQgicOeJaMuoFtVELrYAZNJPjfX6P9S1uISmfrlJLh+q8+lt+2v5GgtvX8VoWUzwumOiuqm5URGA8UIps6FLLTbstZox5ZVPKRNxKvGCxGzwdvFgcx7F5Q==;5:11cXlPEpunI3QAqs/9YH3VxtzZTX2w4uHxMnwQ8KH2gXSJ6a+evfmaoxJgZ6HfWwnqOUvnAAAFmnBh0hZ8gJeF7ywfp/DZC4BqvM0doAaKkeF286qgHUVOpY+MOuu5d50dJtSGG3c5L49ZTTp+lugX7Jfj1S38NFwIOaGCN6+04=;7:cIk8wK4HonBd3HIyKbcxATsV5oZVemtuS8Mo8RJSob7G0U630VFNTezAkQYECWg3pChZtSx+QP7PtX3XtgyPCUQe9C2xZhOLwUV5H5zdCWdxnmtFbqwNqwPoC/izGuDLqCUGyLJdj+AVvdyS5xLBiL9MQDMFZ/btt/4MAXQZw52Bf1m1EX7VMEy6lBuEcMqy74uTqvQHxPruLpM5KfJq8DEH5Q8LSkH9VSW7YCXu6shmFWSav6xyoVQD/kSX05aV
x-ms-office365-filtering-correlation-id: ae9bfff8-7ad4-4f79-bc0d-08d610d60266
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(4534165)(4627221)(201703031133081)(201702281549075)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0120;
x-ms-traffictypediagnostic: CY4PR21MB0120:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-prvs: <CY4PR21MB012075D1A02E61F772A47882FB0D0@CY4PR21MB0120.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(3002001)(93006095)(93001095)(3231340)(944501410)(52105095)(2018427008)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123560045)(20161123564045)(20161123562045)(201708071742011)(7699049)(76991033);SRVR:CY4PR21MB0120;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0120;
x-forefront-prvs: 078310077C
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(346002)(136003)(376002)(396003)(366004)(189003)(199004)(106356001)(53936002)(72206003)(5250100002)(22452003)(97736004)(6512007)(10090500001)(2616005)(2501003)(446003)(11346002)(478600001)(10290500003)(476003)(14454004)(81166006)(186003)(486006)(25786009)(4326008)(36756003)(102836004)(8676002)(81156014)(105586002)(8936002)(2900100001)(99286004)(66066001)(68736007)(110136005)(26005)(107886003)(6506007)(5660300001)(76176011)(14444005)(54906003)(316002)(1076002)(86612001)(3846002)(6116002)(256004)(7736002)(6486002)(86362001)(6436002)(305945005)(217873002)(2906002)(83323001);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0120;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: gX8q2H6fmjCEcX+2H/gUI9egASm5DM3Ev516YmAxhAYGj4PFhALJ2xdP44KooGnwj+qy2heai7kMTlLGykt+oHizfyDQ7AAXiUej5riZ1gXu9uN14P5T7aWhYnOKM+GuRNbAK4DndXuSOjlH+uOOG/du4p+a6W5ixXUakSxR/HcfL0WCd/uy+RhkGUjaYMVnKJQF31Uj0sEkG2XEo6wdtLpKHpvWitPhxapNYpe+cMbkBPgLBfXuKnws6FKU/GzKqdMGAtLjDDz3Q/kgMm9/bQsPgi1VpfZpV/OTtWniNPekKElZ8csm47Wuilr1MhFsDK5jwgFO3JIAJ2pDrTo4oQlv7p/DrucEkB30CnKCM08=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ae9bfff8-7ad4-4f79-bc0d-08d610d60266
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Sep 2018 13:14:26.7625
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
index b9e14045195f..7367f0947825 100644
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
@@ -194,7 +197,8 @@ static int wl1271_rx_handle_data(struct wl1271 *wl, u8 =
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
