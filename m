Return-Path: <SRS0=aodX=LQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 667B0C43334
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 13:13:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 15242205F4
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 13:13:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="E2tsI4WD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 15242205F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729481AbeIBR3U (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Sep 2018 13:29:20 -0400
Received: from mail-eopbgr700118.outbound.protection.outlook.com ([40.107.70.118]:63159
        "EHLO NAM04-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728137AbeIBRXR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Sep 2018 13:23:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8movVkFd11BFbwEzn83QjVr6cJBPOMaHE9q6TWK0H48=;
 b=E2tsI4WDcBK1K6BJqBnaF6llvJBU/m7EYc71bexfmsbK6WhalSUFcVjtDjGjR0bqX6UxBvLjlKV7s9h+uQEke+7XDomWMXSelODG8BBWYmBsnTcGiyAywJvDhM6Zb/SU2KkWDJaPUC74x7uX7TKt/Ia6kBPZ8eDZM75dcQqweTg=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0856.namprd21.prod.outlook.com (10.173.192.145) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1143.1; Sun, 2 Sep 2018 13:07:09 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611%7]) with mapi id 15.20.1143.000; Sun, 2 Sep 2018
 13:07:09 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Loic Poulain <loic.poulain@linaro.org>,
        Kalle Valo <kvalo@codeaurora.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.14 38/89] wlcore: Set rx_status boottime_ns field on
 rx
Thread-Topic: [PATCH AUTOSEL 4.14 38/89] wlcore: Set rx_status boottime_ns
 field on rx
Thread-Index: AQHUQr3RA4VO8mci3EuHkEe8w8bH3Q==
Date:   Sun, 2 Sep 2018 13:06:53 +0000
Message-ID: <20180902064918.183387-38-alexander.levin@microsoft.com>
References: <20180902064918.183387-1-alexander.levin@microsoft.com>
In-Reply-To: <20180902064918.183387-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0856;6:mp7N3CSGwoSuLTOi/GYQtG6SKdqg5iEISMHyGL1btNCyULHJuquUQB3eGSdlxtX8EM0TIUX+WQiaAGJxPehXdZ1G2MntheC6bUAfTlL9bE9syOcr47f4NOkv9a1473ywnY588vopXIEdUrSPUgtk/vzBn0XO5QnkEywOWVfSAj5ldWu+o//gh48Z2gQPeRBiJv7WVu+OkiHICtABVsy/FqjNbj4awaCCGZF9gClbktlPvGtEyDygecRQVqdwskoH1dZPsEw0e2DkKJ15ipQK2wZkaxk07O94eHjpWA6Qb0SlIqNV6udkU+95GzeL/baduOxhqNK5rSuaITWB4369R67Fl0g2GtK0HocCjn61+ZSEI9akIvTFPLBTcOQFw6rPh7pFOSOXk7UOE5qsawQfSD5kqBd5Lq022du7h/I/ikdTMEuEHUsXAED+s1FaHvLOvmocnXEhD0z96mpsfjOFyw==;5:npNZcrF0wK0MgIQUQ4DKU4fCith5OhUSpZzcCFTfWEDshhQPR3OrMv+pHAW9cK40TpFc1nkgck6OLn5MkZbps1dI/G7pXnKw3FviymnfdIdYYPhUh/cDHckyTMtKg7Ru7Cf5PIaoZDz0B8ujmyJTFvy2p5BeeK/91rGFr27hnSc=;7:Aj6ScAmLSOxzUtvy6gvJ921v0cfzwi+yGWekksxOl2KtX8dOf4FjEZNNUbda5irDqqkbNGfCq/rIa5YyarFZV5Rbx0wF4PGG779i0afeMsm80E5KxXsp78chRQG/ThxovsWhxK242q0CXmMjZeo4sFgbezKqP51bGyNDE4cIWHlpXSO4iUlBoKv+/uTmhpB+DPF2oOx4teQkGRfYU1YooWvav7YVLGwshoVoxeEmmogefN3GJ9t1rFNz7ejln0V9
x-ms-office365-filtering-correlation-id: 27dde917-1b71-46fd-fde5-08d610d4fdf9
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(4534165)(4627221)(201703031133081)(201702281549075)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0856;
x-ms-traffictypediagnostic: CY4PR21MB0856:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-prvs: <CY4PR21MB0856730E6B084678F2AD1B55FB0D0@CY4PR21MB0856.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231340)(944501410)(52105095)(2018427008)(3002001)(10201501046)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(20161123558120)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(201708071742011)(7699049)(76991033);SRVR:CY4PR21MB0856;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0856;
x-forefront-prvs: 078310077C
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(136003)(346002)(376002)(39860400002)(366004)(189003)(199004)(53936002)(81166006)(11346002)(81156014)(446003)(476003)(4326008)(5660300001)(25786009)(86612001)(8936002)(26005)(6506007)(6486002)(102836004)(2616005)(86362001)(8676002)(6512007)(14444005)(6436002)(107886003)(66066001)(256004)(10090500001)(217873002)(14454004)(3846002)(478600001)(1076002)(72206003)(6116002)(99286004)(305945005)(7736002)(22452003)(36756003)(76176011)(105586002)(486006)(106356001)(2900100001)(186003)(97736004)(68736007)(6666003)(316002)(10290500003)(2501003)(110136005)(54906003)(2906002)(5250100002)(83323001);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0856;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: plGZBFd9FFGNeALFsmQTzZiUjTDDmLMwoWm3bkQtM7pBt/7PCYKMJPYC1TJfwRjLxsQI0OK4BhcVuuo6CG0YSmUaOuLCmFa8Nl1hJdSAGWSnXGWWbS2KIaB3H10VtnKfVvXbsL/8pJUwH+5Z6jkc5kCjbvGF3Fjcxz7GeN8XHUkV85Y85yKhSlPMivI9G3ZyPS3ML2xTOYoM/NTiKuzkzjj7gnthrRMzRnfCiRLFlS9IEtKnJOAINtkmNSZvcPBiNUFzYUS+8/06dORTMsZ821mMFDrjNaczSMv11qFIUUSJUnB/oJAQRyGrnzYB/9ANNLAY13KCmHqQGlFyR7thM4i7mPAtKKt4K/9ikpUWlog=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 27dde917-1b71-46fd-fde5-08d610d4fdf9
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Sep 2018 13:06:53.5387
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0856
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
