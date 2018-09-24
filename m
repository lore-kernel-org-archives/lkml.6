Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D56A7ECE561
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 14:53:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 83CA42087A
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 14:53:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="V0g0f4VO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 83CA42087A
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731082AbeIXU4E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 16:56:04 -0400
Received: from mail-eopbgr720135.outbound.protection.outlook.com ([40.107.72.135]:34196
        "EHLO NAM05-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731724AbeIXUyF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 16:54:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/+pzi09/uOJBMDf6I2/D+reqTDFu51i8SGvC16aq3ak=;
 b=V0g0f4VOFMEDk0WSNVSONhC23ox9+g6LEwtRzaWnllEOvJybkEjoQQGiPQX34IiEtEhew6hEOMnlG0X61AFEbWyUFbg0vKXYfZdUZnsGUqr6qYSwGKWLx9acWbnrRhTnLRg/iNwD4EaV+NhsigcNY09t2yfZkQt/W55qY+7AZbQ=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0821.namprd21.prod.outlook.com (10.173.192.7) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1207.3; Mon, 24 Sep 2018 14:51:16 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1207.003; Mon, 24 Sep 2018
 14:51:16 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Emmanuel Grumbach <emmanuel.grumbach@intel.com>,
        Luca Coelho <luciano.coelho@intel.com>,
        Johannes Berg <johannes.berg@intel.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.4 16/18] mac80211: shorten the IBSS debug messages
Thread-Topic: [PATCH AUTOSEL 4.4 16/18] mac80211: shorten the IBSS debug
 messages
Thread-Index: AQHUVBXaXN0chDPf0k+ou5OWzJaVgg==
Date:   Mon, 24 Sep 2018 14:49:53 +0000
Message-ID: <20180924144942.164688-16-alexander.levin@microsoft.com>
References: <20180924144942.164688-1-alexander.levin@microsoft.com>
In-Reply-To: <20180924144942.164688-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0821;6:yJTNC3cOrtPph7BODp0MNF6RDpUTJnmQFvG3ieRZ2EgPD1sz+udNUPFQDB1q7+WHQ2tScltgiuYMY66/WNb/ny+jZEu+ttXTauARSIp2kybb0LtFSnvArS5JmYr+Hk8L2k63jbfadhU8M6byTTwzJhTLH/gySe3Sg1LmmCEQKzG3E+VjOdA6X/sYGEo9nvuD9GSKj8fqcno8dpJY331Q4Q1/Z1T7ck0CTmIf18zt1BIaB6sk+K1GLvDm7w1Ru+RrFGMyOKZTerSYetFHxbN4kHvgDjRst7YA3JOw/gtqd5xnry2iWLDuaPR2sawfIDV+55MnvT8u6H6kDYoqCI6IknBHFTu63Y7QkoXavoJAAZ1TlGXLdTzBxNyOpA8vqjF6G24aS7Mwfcpa48ZRfg2X4gpToKi9IoFXKZ4hq9BnY5nSo+xJFZLooDxkXf7AI23bFgDsM1upAywbNpKpjR1B0w==;5:h+PXDKKWwJSzH1GiTNuJsq7WY6U9EcvfmlwFtkXdmPZLG+9AE+gkvc/Y9P5RpUxhFafTjaodEdEnRHNwUoKlEEUhMB4pXxCwpE1zFsPfzif0heUzCztkTHqI7Y6SaLqp+xJg7r7jlRkdeVitPdh5zosMY3mnKbWs4SHfHid3odE=;7:NfTZbU1TS2rhxGkZp6kvp9FqJdpDa7XR+Q9n6lQc49JGS8lZhD2HW8v2cl6pSDYx6fTamMtVibMKyOjE7nYqUrA+lreUByp0KFSW/hBHQuQEJcuZdd6Z5Oz3q6BEU9T9LsSnZepij6pvAM4OoA9b8jEQHvHE6xykitXsVEsZLNVRSC1auRqbC7C7IparxLxKPkP84GpG2Z2EGKpnMb+JuJkinaP5r0ZdyiwlcIQvBtTL2GPyQG6DYZuVo3l8smVh
x-ms-office365-filtering-correlation-id: aacbfb72-7afe-4db3-a1b9-08d6222d2e24
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0821;
x-ms-traffictypediagnostic: CY4PR21MB0821:
x-microsoft-antispam-prvs: <CY4PR21MB082152046E1FA17DFBD6963BFB170@CY4PR21MB0821.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(228905959029699)(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(3002001)(93006095)(93001095)(3231355)(944501410)(52105095)(2018427008)(6055026)(149066)(150027)(6041310)(20161123562045)(20161123558120)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(201708071742011)(7699051)(76991041);SRVR:CY4PR21MB0821;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0821;
x-forefront-prvs: 0805EC9467
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(346002)(376002)(136003)(396003)(366004)(199004)(189003)(51234002)(102836004)(5660300001)(53936002)(551934003)(6512007)(6436002)(256004)(14444005)(217873002)(6666003)(6486002)(2501003)(15650500001)(10090500001)(2906002)(68736007)(5250100002)(97736004)(107886003)(66066001)(36756003)(4326008)(25786009)(1076002)(3846002)(6116002)(2900100001)(8936002)(81166006)(81156014)(8676002)(86612001)(86362001)(7736002)(305945005)(72206003)(186003)(26005)(10290500003)(6506007)(6346003)(478600001)(14454004)(110136005)(2616005)(446003)(11346002)(476003)(76176011)(486006)(54906003)(99286004)(105586002)(106356001)(71190400001)(71200400001)(22452003)(316002);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0821;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: JCcQpNJOEdldGTz8wJzPIkftxhKNDoSYy2AaANBDMUYep8pFRyY6sRGFciM4cpb78OpC+6WCHeqIn0uNZkpa9sFF9yTWvTWtbOYqHoluGbfWPIgKd1erQs3s6ugKhVT5Ko3ptzOev6HHUJeDCRA+tRa7uHKSm+sPxkRt1tUtjPAagyYkkCb+s/U4Qd5+N1jBk6R5VkAT2ezxyMYgvgwue9TtaKouF63bAlo0DquJPx5DVzTp62ZtkupwWTcgQIerfMhXdwBu01ueDd2K1dCcohKyRoLK3pZkfiS81gNa5eeXgjzvVTB+x5P/690djmoiy9SVwbX/rM30MbjXy7Q7DadYtakBDMae6qsJHzgTPFQ=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aacbfb72-7afe-4db3-a1b9-08d6222d2e24
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Sep 2018 14:49:53.5688
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0821
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
index 24ba31601fc9..f2af19673b26 100644
--- a/net/mac80211/ibss.c
+++ b/net/mac80211/ibss.c
@@ -948,8 +948,8 @@ static void ieee80211_rx_mgmt_deauth_ibss(struct ieee80=
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
@@ -967,9 +967,9 @@ static void ieee80211_rx_mgmt_auth_ibss(struct ieee8021=
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
@@ -1174,10 +1174,10 @@ static void ieee80211_rx_bss_info(struct ieee80211_=
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
@@ -1536,9 +1536,9 @@ static void ieee80211_rx_mgmt_probe_req(struct ieee80=
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
