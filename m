Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D482C433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 14:53:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE61F2087A
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 14:53:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="k2D6auQC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BE61F2087A
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732559AbeIXUzj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 16:55:39 -0400
Received: from mail-dm3nam03on0113.outbound.protection.outlook.com ([104.47.41.113]:27672
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1732398AbeIXUy0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 16:54:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=poabpjawfkr4URhWRrATCB94/nZaRhdSt4jgz/7Cvp4=;
 b=k2D6auQC7UKGMunp8VF3oDhGtHcqOu5oeUJYsciv2datc9bq8v9xK4IRgorE5u977r+yeoo571Ri2kwo7NzoUWCBShgO/4s8XA/E1pyo+EFR09DR7PvS65/Ff2VFNb/iHwPTocNKdmvU3HT54U7JtDCsBN+f/OgJZ6FvwXsWeE0=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0136.namprd21.prod.outlook.com (10.173.189.18) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1207.3; Mon, 24 Sep 2018 14:51:51 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1207.003; Mon, 24 Sep 2018
 14:51:51 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Emmanuel Grumbach <emmanuel.grumbach@intel.com>,
        Luca Coelho <luciano.coelho@intel.com>,
        Johannes Berg <johannes.berg@intel.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 3.18 11/13] mac80211: shorten the IBSS debug messages
Thread-Topic: [PATCH AUTOSEL 3.18 11/13] mac80211: shorten the IBSS debug
 messages
Thread-Index: AQHUVBXm+2YM78BmikujMjOyUWN5zg==
Date:   Mon, 24 Sep 2018 14:50:13 +0000
Message-ID: <20180924144959.164754-11-alexander.levin@microsoft.com>
References: <20180924144959.164754-1-alexander.levin@microsoft.com>
In-Reply-To: <20180924144959.164754-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0136;6:2UIyf6mD4OB116Ts7zU3p7/XzMgvFs8XiUkxPi5ooI7xsbMS/u0T3B95uDUead82TJ7Vgus59GdUHDSUVhqSnTp5hmQl5F0GjZbV3uoO4UUm0Cgmc1/5RqJYb5etHTLxRgOYXR+aSlCT5fEQ5hHqEbyrTEVgWbUfQT/jvhgN4UtOnkWf++1Hz9VGmw6ojP+5Wh+RgJ3IEaRe9k0ChPdGH0ieKJU0RnxJ5fZrhdyUFtf5hIRcZZM3UqKUUca8htA8YCqR5D4dlIf/IWEMwzXG5tkff+9UPvCstrIHjuLIXQ7q7COT01kBFnZtpvQRr3+mblS52cYLcATZIvKlqKU6W3z/0olJcGtS9+puZT+FooZCnrtrBUKPpHyORUhki3exTFmhCZ5ytCdv82JWClPFuLHS7KXCN55DBuklyuI+XhQdS3w2w7kE/j2wz4lsaXpYBJ8vTMNn06PjvmXJo0tYwQ==;5:6n0BY6yURcZiuXcSh360eL6v+Rqfu2sH3DdIlEg2wKm9WORL+AEdgL+gHa7HfSHI6/wnTNj/pxl0r2RkLOaoRAaaYNmL3+KQl2LfDRrB2kUkb+b9bR0c4pQye0diJyFYhXCe1GZVGrPktP7vwnQgbVBh28FSVU2ddEm5QVo+xGc=;7:acnOQPS+1YYq73s9e5GOl7KfqJ+Q2eMVMy8ihwLn+N3VwDA0NsRBakMjzGSGu2zQ157VeADNNWYUxt3/yVuhCC/vr5efGCJNbRnXrKV+/S2MWqAvqorl6Efxy2qHyf3dxKHyGsJ5WO938n72pjk3dNjDSWvdIT5QKdGdYCnA7beaK+liFntk12JqM7TpvePyeq9nP7FzbyuQ3We0tobqRw2TeoQE4Tr0vhnQZb1S7o9rjcwc3WBKKIm0n0hqmDTA
x-ms-office365-filtering-correlation-id: 036de16e-c204-4b63-d462-08d6222d4330
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0136;
x-ms-traffictypediagnostic: CY4PR21MB0136:
x-microsoft-antispam-prvs: <CY4PR21MB01368A326B717F9C34069043FB170@CY4PR21MB0136.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(228905959029699)(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231355)(944501410)(52105095)(2018427008)(93006095)(93001095)(10201501046)(3002001)(6055026)(149066)(150027)(6041310)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123558120)(20161123562045)(201708071742011)(7699051)(76991041);SRVR:CY4PR21MB0136;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0136;
x-forefront-prvs: 0805EC9467
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(136003)(346002)(396003)(366004)(376002)(199004)(189003)(51234002)(478600001)(6436002)(2900100001)(2501003)(6666003)(5660300001)(102836004)(26005)(6346003)(86612001)(86362001)(97736004)(186003)(71200400001)(305945005)(14454004)(1076002)(7736002)(106356001)(5250100002)(6512007)(72206003)(6116002)(3846002)(10290500003)(6486002)(105586002)(53936002)(25786009)(71190400001)(8936002)(110136005)(99286004)(54906003)(8676002)(316002)(68736007)(81156014)(81166006)(22452003)(2906002)(15650500001)(6506007)(217873002)(4326008)(107886003)(76176011)(486006)(551934003)(66066001)(256004)(476003)(11346002)(2616005)(14444005)(10090500001)(36756003)(446003);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0136;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: IEFEgn3WJVJaEZWkz1I8e5Q2I0pMhWLRkYoBQgC0wBKkzEJmaZ8zlTfe9D65Xgl2fZd2iNsW7x4grSlnuDyZ1SDQKPiD5bPf12khBN85qB9OcrBwM5f5IYtKgUY0CvWrbceGycoPLfH2+wqRyHDx0H67lR/I3WfUTLwJT5oQAAcjwyX9s/e1hyOc65wAGdvjuCTLwm7h/ErqucrARORwiWOwtEI6KR8xxmn/HtRPtOj8oA+N/XdFbzztTbQCkkDJffO4hbwjbX4aS6o/XsVTB3czkMY0fV3sy6acLlZmL00ZgAbtvYuyBemYXk6bzEx9ZxXEVGg6yC48bt4Cr3ohmetWl5+bLbsCH+GrtCJLcAk=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 036de16e-c204-4b63-d462-08d6222d4330
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Sep 2018 14:50:13.5252
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0136
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Emmanuel Grumbach <emmanuel.grumbach@intel.com>

[ Upstream commit c6e57b3896fc76299913b8cfd82d853bee8a2c84 ]

When tracing is enabled, all the debug messages are recorded and must
not exceed MAX_MSG_LEN (100) columns. Longer debug messages grant the
user with:

WARNING: CPU: 3 PID: 32642 at /tmp/wifi-core-20180806094828/src/iwlwifi-sta=
ck-dev/net/mac80211/./trace_msg.h:32 trace_event_raw_event_mac80211_msg_eve=
nt+0xab/0xc0 [mac80211]
Workqueue: phy1 ieee80211_iface_work [mac80211]
 RIP: 0010:trace_event_raw_event_mac80211_msg_event+0xab/0xc0 [mac80211]
 Call Trace:
  __sdata_dbg+0xbd/0x120 [mac80211]
  ieee80211_ibss_rx_queued_mgmt+0x15f/0x510 [mac80211]
  ieee80211_iface_work+0x21d/0x320 [mac80211]

Signed-off-by: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 net/mac80211/ibss.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/net/mac80211/ibss.c b/net/mac80211/ibss.c
index 76de04be8900..1e3966750b4d 100644
--- a/net/mac80211/ibss.c
+++ b/net/mac80211/ibss.c
@@ -944,8 +944,8 @@ static void ieee80211_rx_mgmt_deauth_ibss(struct ieee80=
211_sub_if_data *sdata,
 	if (len < IEEE80211_DEAUTH_FRAME_LEN)
 		return;
=20
-	ibss_dbg(sdata, "RX DeAuth SA=3D%pM DA=3D%pM BSSID=3D%pM (reason: %d)\n",
-		 mgmt->sa, mgmt->da, mgmt->bssid, reason);
+	ibss_dbg(sdata, "RX DeAuth SA=3D%pM DA=3D%pM\n", mgmt->sa, mgmt->da);
+	ibss_dbg(sdata, "\tBSSID=3D%pM (reason: %d)\n", mgmt->bssid, reason);
 	sta_info_destroy_addr(sdata, mgmt->sa);
 }
=20
@@ -963,9 +963,9 @@ static void ieee80211_rx_mgmt_auth_ibss(struct ieee8021=
1_sub_if_data *sdata,
 	auth_alg =3D le16_to_cpu(mgmt->u.auth.auth_alg);
 	auth_transaction =3D le16_to_cpu(mgmt->u.auth.auth_transaction);
=20
-	ibss_dbg(sdata,
-		 "RX Auth SA=3D%pM DA=3D%pM BSSID=3D%pM (auth_transaction=3D%d)\n",
-		 mgmt->sa, mgmt->da, mgmt->bssid, auth_transaction);
+	ibss_dbg(sdata, "RX Auth SA=3D%pM DA=3D%pM\n", mgmt->sa, mgmt->da);
+	ibss_dbg(sdata, "\tBSSID=3D%pM (auth_transaction=3D%d)\n",
+		 mgmt->bssid, auth_transaction);
=20
 	if (auth_alg !=3D WLAN_AUTH_OPEN || auth_transaction !=3D 1)
 		return;
@@ -1130,10 +1130,10 @@ static void ieee80211_rx_bss_info(struct ieee80211_=
sub_if_data *sdata,
 		rx_timestamp =3D drv_get_tsf(local, sdata);
 	}
=20
-	ibss_dbg(sdata,
-		 "RX beacon SA=3D%pM BSSID=3D%pM TSF=3D0x%llx BCN=3D0x%llx diff=3D%lld @=
%lu\n",
+	ibss_dbg(sdata, "RX beacon SA=3D%pM BSSID=3D%pM TSF=3D0x%llx\n",
 		 mgmt->sa, mgmt->bssid,
-		 (unsigned long long)rx_timestamp,
+		 (unsigned long long)rx_timestamp);
+	ibss_dbg(sdata, "\tBCN=3D0x%llx diff=3D%lld @%lu\n",
 		 (unsigned long long)beacon_timestamp,
 		 (unsigned long long)(rx_timestamp - beacon_timestamp),
 		 jiffies);
@@ -1414,9 +1414,9 @@ static void ieee80211_rx_mgmt_probe_req(struct ieee80=
211_sub_if_data *sdata,
=20
 	tx_last_beacon =3D drv_tx_last_beacon(local);
=20
-	ibss_dbg(sdata,
-		 "RX ProbeReq SA=3D%pM DA=3D%pM BSSID=3D%pM (tx_last_beacon=3D%d)\n",
-		 mgmt->sa, mgmt->da, mgmt->bssid, tx_last_beacon);
+	ibss_dbg(sdata, "RX ProbeReq SA=3D%pM DA=3D%pM\n", mgmt->sa, mgmt->da);
+	ibss_dbg(sdata, "\tBSSID=3D%pM (tx_last_beacon=3D%d)\n",
+		 mgmt->bssid, tx_last_beacon);
=20
 	if (!tx_last_beacon && is_multicast_ether_addr(mgmt->da))
 		return;
--=20
2.17.1
