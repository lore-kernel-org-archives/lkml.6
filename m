Return-Path: <SRS0=aodX=LQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03167C43334
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 13:19:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A396620837
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 13:19:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="HUHKBgVl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A396620837
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730349AbeIBRfo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Sep 2018 13:35:44 -0400
Received: from mail-cys01nam02on0107.outbound.protection.outlook.com ([104.47.37.107]:15264
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729339AbeIBRcQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Sep 2018 13:32:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PCtC7DfvcfKKSSUASxNUjTfwdMyZr/r94BWI4RqYdt0=;
 b=HUHKBgVlfwrDDm0TgjavI+S9BYOAUeQBc4ej0Yf29h1ZCP/h3st6u+vn/pmHkk4SLvybLKpbJqbypJ3ZRHWD/KPysLEsx7xTPOYqSeZJX4OHo4Fr3a1G1tCX12Xkcjfsu5gr9STFMavVbdfkN2pWUF07e8HZA5goTdHjeb+xonU=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0629.namprd21.prod.outlook.com (10.175.115.19) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1122.7; Sun, 2 Sep 2018 13:16:21 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611%7]) with mapi id 15.20.1143.000; Sun, 2 Sep 2018
 13:16:21 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Loic Poulain <loic.poulain@linaro.org>,
        Kalle Valo <kvalo@codeaurora.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.4 16/47] wlcore: Set rx_status boottime_ns field on
 rx
Thread-Topic: [PATCH AUTOSEL 4.4 16/47] wlcore: Set rx_status boottime_ns
 field on rx
Thread-Index: AQHUQr8UZJMr3ccen0ahyt/L/u4scQ==
Date:   Sun, 2 Sep 2018 13:15:55 +0000
Message-ID: <20180902131533.184092-16-alexander.levin@microsoft.com>
References: <20180902131533.184092-1-alexander.levin@microsoft.com>
In-Reply-To: <20180902131533.184092-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0629;6:zxboj36aT1gyeww4GwudcnNoIps4izNaTWF9r17GWRHTCQjIpJkBQydGoBWsKGwE9ag1KnR5Xuqapa7TP3++5HrEY2qFdbz2S+38QEleNQt6wMp/wdNxk3BMKzZpfbILXt3RxeJWB/21sfHJhSd9RkCvEV+nHf1HzHO/7ufILr8Bfs1dPlB7oyT8b+J6KuXJp1G3v6fPv0YPpga4BvDwBv5lcdAn+jBVqk8utnIeHuHDV01wt8Mcfaz1vjduMtQT/57qk3KiXy2idH0bNLPl2zv/U0tf1Z30L1dpHhflMl+ebf2dWulGyiVZGrn2/BEGAjRMya2z5CktyaLtkbYSgdgjU6UGaVI5y73Sq/r59UjbwQSx5Mo2rSG1X+reB9QNIq3Zx9lQZjaNw1S/BEVgpPPrVPATngYfoKdyw2aOWISgUAgfPvpsw0x6M8v0kg9ai+5GGmrIzTPNZ5cwo7ng7w==;5:DBjedQ+bscnJAPl8F7Xw1vCRusftZRq3SJ+dbnb/DZ1W8DEqTwESnlV0irSysqfnc1T/p9mujtTsmT6yN0l2GfuGtsKKr0nQvxBfY6pButFDt+Xc2gkOWXwkbjG0v/fX0FC0dKpQQ3E8ZxwaimRD5cxFfyTA/I5JN4KT/pyFQ60=;7:w5vpPtJNwZZMFUqG5Q9KsX2OFaWNSsJWGKhOomx5zp6fBurYNxefk3oGLHjH//6KWsE29Gf34Q80jUl8FUbsqwYXo/nCoNw0WxyA1We1ImSCtN/APfIHUPa9RbGUwrR87NWZ01uxM3iLljKLB1W2SXztH2Dj1sODMZahnw7OFpYbSN/hja19xAoBwufZJDemWUWZmXoB3SZLDIdZ/Uc9UdsejEpVZkhJ6dWDR27stMBDtuWYsBnMVvaOkDQMB0eW
x-ms-office365-filtering-correlation-id: 4ce77fa7-da34-453a-d63f-08d610d646dd
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(4534165)(4627221)(201703031133081)(201702281549075)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0629;
x-ms-traffictypediagnostic: CY4PR21MB0629:
x-microsoft-antispam-prvs: <CY4PR21MB06296BBD919A18F52A1ED468FB0D0@CY4PR21MB0629.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(10201501046)(3002001)(3231340)(944501410)(52105095)(2018427008)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123558120)(20161123562045)(201708071742011)(7699049)(76991033);SRVR:CY4PR21MB0629;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0629;
x-forefront-prvs: 078310077C
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(136003)(366004)(39860400002)(346002)(376002)(199004)(189003)(8676002)(478600001)(10090500001)(14454004)(10290500003)(72206003)(476003)(5660300001)(5250100002)(106356001)(110136005)(54906003)(316002)(105586002)(86612001)(102836004)(14444005)(26005)(256004)(6506007)(2616005)(6116002)(217873002)(305945005)(446003)(1076002)(3846002)(2906002)(11346002)(97736004)(6346003)(81166006)(81156014)(7736002)(6436002)(66066001)(25786009)(86362001)(4326008)(186003)(53936002)(8936002)(6486002)(22452003)(6512007)(99286004)(2501003)(36756003)(68736007)(6666003)(2900100001)(486006)(107886003)(76176011)(83323001);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0629;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: iiUWcnQcN9xIrO1D+zA7DMNK8fg8t5ufL/l1cMPxr3IIQCq/3bVRKeVF0jat+vz9O2t0U26o9lE/9PCMDQdxf8i7UhNHUpPHZELIF2mg3Iis3C5JPAgGqBfKgLWav0tiji4Bxc1772vMiA2qEvLrne0yItG6exDe2h+YpDYZwmc+deGVhF1//G54rfkDuev9HZ69YMrc8mrDJ/c2GX9C1H1URfLC9NXCOhlYe+stz4wW1eYSTdaVwFg9VM8HoaxBDHAvTCi7jfCjRnpCcoGpESUOeu64dp/JeJRnMGazLcbR3Lf42oug8EP0Y+WB714uG9JMbJIEYUpJEi/ZZAnZe8OKqCYkcqBr8CuN6/Eiq2Q=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ce77fa7-da34-453a-d63f-08d610d646dd
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Sep 2018 13:15:55.0332
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0629
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
index 5b2927391d1c..e9e449ec68d2 100644
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
@@ -195,7 +198,8 @@ static int wl1271_rx_handle_data(struct wl1271 *wl, u8 =
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
