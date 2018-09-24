Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F550C433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 14:56:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0DD762087A
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 14:56:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="gQ0bTGdU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0DD762087A
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731437AbeIXU64 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 16:58:56 -0400
Received: from mail-eopbgr690124.outbound.protection.outlook.com ([40.107.69.124]:21344
        "EHLO NAM04-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730069AbeIXUxA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 16:53:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WCeUtmrTGKzU7Dzygq32vkhrU2uay0foYv+FUScW6zg=;
 b=gQ0bTGdUpFs4tVS0iXq8dsy9Adan0J3jNawcclFjzwqNiUKo/mxy6PyjYc1QDkk9YaLZKjYGwM7XNE1RQ7Em/MEs+ieTWz9oewcr8DxjPd/Ck+ikMtrx6kJc0+Q+khk3k2a9tK4OvQWwV7uac4nZOo0Et7j2JVDMieOJQ7J20ck=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0744.namprd21.prod.outlook.com (10.173.189.10) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1207.2; Mon, 24 Sep 2018 14:50:22 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1207.003; Mon, 24 Sep 2018
 14:50:22 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Emmanuel Grumbach <emmanuel.grumbach@intel.com>,
        Luca Coelho <luciano.coelho@intel.com>,
        Johannes Berg <johannes.berg@intel.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.14 34/36] mac80211: shorten the IBSS debug messages
Thread-Topic: [PATCH AUTOSEL 4.14 34/36] mac80211: shorten the IBSS debug
 messages
Thread-Index: AQHUVBXBCLkmOvs+2EKrnKxq/pKgCQ==
Date:   Mon, 24 Sep 2018 14:49:12 +0000
Message-ID: <20180924144851.164533-34-alexander.levin@microsoft.com>
References: <20180924144851.164533-1-alexander.levin@microsoft.com>
In-Reply-To: <20180924144851.164533-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0744;6:CFljFdSi4KEdBFmwHFfEfy2v9pT9t45Kfy1BffOYCF4VcOkJGXW6GXPoDBqgvYJ9ko4ocYPR8txpscCQ1Trsiw307Fd8w3ImvmQ2GQNsh0O2tndM65UgSJMeq06N7sFZys0uqbHd4Ja4HOycCxBYqbCe0pUeCxYSO/B2MjYBYHCnjR46so4gYYrQK+6yVo6oHN8t3BshQUOdkik94jJ2bq04PQyChp3a8Col6D+bwUTPT6gxFcKX2G48gmKOQ5+osmk/JIuw8T+Xym0cC505Y+r+oRXeKrEjk7moR8gVaMa35nqAVlOYwXKrRtRe+NMr50FQHlVLpgJFVpzUPeasr3nrrXjTBrnYw7H7irwtqnbAhMo2B39liWWRPdGjN/1qYM1WSZQ4LQ3uQcj2vz/ZHo/bUgMqwdmWYdxNbaRZs2Q7fY2tKuMkxvs9CPQNrUqPdjnDNpHXRvWwfsgjQAxRxg==;5:2LczzgswyvRLxJWjXuKbFSoeIJPHDYTyjZqVAfBZ9DQx9Vat2L2dEgiKF+yyW1URv7GbFR8D8OQYbmGY9O+ZVDSlog9m7ZOZ4MZpa6TCvjDUdkuq/3aOtuwskbkPnRL9H/219pmr3j9on1IhyMXPc0YGMaHBJh2GRx8lpsJmZto=;7:Ui3SrkE8cIxsVr1qFiIX+FV2s5HEJUUPbFri9C8+F7CciDEJtcycT9DTmih2yImWuShBMNE4CPvH/ScWyCuUmRQLkUlq5crixWWoOnsEEq2qO+pfIGbjfAle7HTsRaL8pjg30kYJ6KshVS1xH6TBRTSVLGIQGG+quLnK9sNUOi/yVyykgtmGYc+Zioiobk5seer9NIwYw+4z4JqQFt4WnI+bV4atrubCbrbxmQbK/DHGFFPXb6Iur8u4ICzVjVHA
x-ms-office365-filtering-correlation-id: 74ee801c-6bc5-45d2-1338-08d6222d0e39
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0744;
x-ms-traffictypediagnostic: CY4PR21MB0744:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-prvs: <CY4PR21MB0744BE55C0B2EE9161261386FB170@CY4PR21MB0744.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(228905959029699)(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231355)(944501410)(52105095)(2018427008)(10201501046)(93006095)(93001095)(3002001)(6055026)(149066)(150027)(6041310)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123558120)(201708071742011)(7699051)(76991041);SRVR:CY4PR21MB0744;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0744;
x-forefront-prvs: 0805EC9467
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(136003)(346002)(39860400002)(376002)(366004)(51234002)(189003)(199004)(11346002)(446003)(476003)(86362001)(575784001)(186003)(81166006)(6506007)(8676002)(81156014)(6666003)(5660300001)(486006)(99286004)(53936002)(305945005)(6512007)(6436002)(2616005)(71200400001)(71190400001)(68736007)(6486002)(102836004)(10090500001)(7736002)(36756003)(97736004)(86612001)(316002)(3846002)(6116002)(1076002)(217873002)(14444005)(256004)(54906003)(110136005)(107886003)(10290500003)(4326008)(478600001)(22452003)(15650500001)(5250100002)(26005)(8936002)(2906002)(2501003)(2900100001)(66066001)(72206003)(105586002)(14454004)(551934003)(76176011)(25786009)(106356001);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0744;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: 6aXHvdKnI+ymNsRcza/qKP5uEzsgZkkM8OiePL2f6QFaIHvMUhQOyF2HAsheYWde4wDftiLphTtugLCXdzBN2B88wLxckhQKsp3Kt+EZgwKCatkHy9GvH6w5AaMwk3OZqQNV9IMOxDEvl3Qi/CrYDtfQemPrB7SGFExWDnQwi64MLKVw9d7iMxqVioFGY8uRkQwLRmuYqX7veVjQ2aEjLxAImsDKWYgjS6KMYZlGgnVfKqVXgihAm4hlSL5S58LOlGR1M92Fkp12LTtW3kLLlbI422cePqvWqMw82IEokUQRs8N8uDSDv8LASKbhJaqaAvDKy/XQuZCq2KtD0DA4SiJf4zlnYOeiDAbI9mTOacg=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 74ee801c-6bc5-45d2-1338-08d6222d0e39
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Sep 2018 14:49:12.4719
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0744
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
index e9c6aa3ed05b..3d0d12fbd8dd 100644
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
