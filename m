Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40AACC433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 14:49:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DFCFB2098A
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 14:49:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="T47gFtJP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DFCFB2098A
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387568AbeIXUwH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 16:52:07 -0400
Received: from mail-co1nam03on0115.outbound.protection.outlook.com ([104.47.40.115]:2846
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730302AbeIXUwH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 16:52:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rCukNo4ZjCE+cAYkKsX7dFmAiokuzFrrQLBwEbxcTWA=;
 b=T47gFtJP+g3yrxhQtyoeyq8GBcJKAGl32ehPeVJq69UkvESwBxJ+D981CP0yvYPugV6OMqKAjz/GrxQWT5OJSTXvHH9M2vLiB+ie0b6IEkZ9DXQwruaKztj2tG8/19NyOKuIvRKgAFKbhkYiSOiPo/FHu014ZCHPEl39zVibNoM=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0471.namprd21.prod.outlook.com (10.172.121.149) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1207.3; Mon, 24 Sep 2018 14:49:34 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1207.003; Mon, 24 Sep 2018
 14:49:34 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Emmanuel Grumbach <emmanuel.grumbach@intel.com>,
        Luca Coelho <luciano.coelho@intel.com>,
        Johannes Berg <johannes.berg@intel.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.18 63/76] mac80211: shorten the IBSS debug messages
Thread-Topic: [PATCH AUTOSEL 4.18 63/76] mac80211: shorten the IBSS debug
 messages
Thread-Index: AQHUVBWurULEg1sdh0mOGgBHFTqOAg==
Date:   Mon, 24 Sep 2018 14:48:39 +0000
Message-ID: <20180924144751.164410-62-alexander.levin@microsoft.com>
References: <20180924144751.164410-1-alexander.levin@microsoft.com>
In-Reply-To: <20180924144751.164410-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0471;6:9Hz40D3le3ezBdsMsfzA8ALlg1ZhXSQ0ipOe1f13Tpum5YtzbhWUk9npWKBMkN9lU+4tYgufAC4bRdYyrwYuRx/LWa3PIzXO+KaTGNWoS5nMFZcvaFEMt4amxoq66bCCinj1/iXPvfYD8V1wyU+Bdwi8AmmMy/6aUPvPCXXqBsLxx3PVpnky3ppAL7FxgY0NnSlAC0w09J/YfZakByLBPIOU1X/hBnDIiSBlIq4rSgFZZW/OYNvgCYjyCOy71+wC1miYYLJodRayPGjfGBUeBiu/cWwD9P3WbdZEQHPDnBkAnhRIVWH60LKVXlMusSJgFEQr+/MFfL1fCSqlNmtSeKEnjQeuMS5v0V4Ce/iHPEI6O5Xi0sO93Aqxj2Xl8En7D2tIcAdX5u7W98ytH726fzB/rW8eAeMUiRTO6pM6rQ+EadxEhGySW/FviLL1zjKG9su57R+ZuIfAZ6EC1UtG7Q==;5:4T/Nc9ke05jmUVz0qWh//pvFOKnXHwafUiX5fRcxYbOocwQUwvgpMTZOWBZdj1G2Uo7HP+fWFnyJACBFRbq7bvgLiGSUxgUc+K2njOHGFglzJ3fduEg4s9H+kLRB9PRXUGwwNxYX2E8t6B5apDnps6GPReJ1LI9NvJ2WKhPtPBQ=;7:DH4UQPRhSAmKmdR7h4BSdkeBIT3rbj/7drmUJRyMy4tU+xdnfsKSwp/uj6vtW+JitO2yczWbatxToheqbYbgfV9lUPbUB2UqlCISOJ7qyVvmiJtbEuCOkv34t3PTuqXGWRja/25CGd2n515GLyaRbHyP4rrRJIVtmPskS0i0T8YC5JdKFQeq/u0bJSEYn9U958IUAo+f/zKr/HeQ8MLM1OvoyNvo6DreJ9NaYm+27Wzm2cC9apvgxiAkrdLJbO87
x-ms-office365-filtering-correlation-id: 3c013b8f-5f98-42db-fb64-08d6222cf137
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0471;
x-ms-traffictypediagnostic: CY4PR21MB0471:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-prvs: <CY4PR21MB04714F0811067C2E6B63FB10FB170@CY4PR21MB0471.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(228905959029699)(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3002001)(10201501046)(3231355)(944501410)(52105095)(2018427008)(6055026)(149066)(150027)(6041310)(20161123564045)(20161123562045)(20161123560045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991041);SRVR:CY4PR21MB0471;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0471;
x-forefront-prvs: 0805EC9467
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(396003)(376002)(366004)(39860400002)(346002)(199004)(189003)(51234002)(6512007)(105586002)(256004)(53936002)(14444005)(106356001)(10090500001)(6486002)(217873002)(1076002)(6436002)(71190400001)(97736004)(71200400001)(15650500001)(446003)(476003)(11346002)(54906003)(316002)(2616005)(86362001)(575784001)(2906002)(86612001)(8676002)(5250100002)(26005)(81166006)(81156014)(36756003)(10290500003)(4326008)(478600001)(2501003)(7736002)(551934003)(110136005)(2900100001)(186003)(22452003)(102836004)(25786009)(305945005)(68736007)(107886003)(76176011)(486006)(6116002)(6506007)(72206003)(3846002)(99286004)(66066001)(8936002)(5660300001)(14454004);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0471;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: 22tunyZ856GKdhcV6pAhGX8dI0AjGMapP+8VWOZMGnR28nLLW45s0n7Sgm8zW8C9iR2jBfIiy3GinlzFqVBDT3oFO+BSrFmvE8cABxYy5t3cQ8TDNgrNgHwezY/u+s+OB44frFs4qEEZauUf32aM6xupLcD3MVzvmjnT3EAljcmwuq7nw1gYMFqA7+QrMsYc5uMhihVVM+Mv3qbzynfyI6IIYfJbhotC8bG8QB6AkmmRyWQ01ih00qV8RTu1hEew0rxc97xVC4K+8vshhEBoIHdtfuTolAGbDw08QyXEJRp0V5SS0A1JExSObBOLeDgTKqXd3Yoe1BoWDXHGksrTNR0EsKxOQ+JWJItMxeUzXVc=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c013b8f-5f98-42db-fb64-08d6222cf137
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Sep 2018 14:48:39.2085
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0471
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
index 6449a1c2283b..f0f5fedb8caa 100644
--- a/net/mac80211/ibss.c
+++ b/net/mac80211/ibss.c
@@ -947,8 +947,8 @@ static void ieee80211_rx_mgmt_deauth_ibss(struct ieee80=
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
@@ -966,9 +966,9 @@ static void ieee80211_rx_mgmt_auth_ibss(struct ieee8021=
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
@@ -1175,10 +1175,10 @@ static void ieee80211_rx_bss_info(struct ieee80211_=
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
@@ -1537,9 +1537,9 @@ static void ieee80211_rx_mgmt_probe_req(struct ieee80=
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
