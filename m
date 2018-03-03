Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1310899-1520121759-2-7416982981954811819
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520121759; b=AHJj0w1X1vsjelmHCj1aW2iyuFEvI41K79XA8UXEmHkVk93
    slyOYYg+wB/XFcyTFiS7V4A8BTaL7uRbnmZwOZEGEXMTwl2ekrteBb2EMXyrf2Jr
    cJHEhGpZbZvZogJ8pp43/sYvgFjwmQx0GElqxOs0xlKcIBNa06y1bas8WPzo8H5F
    kI52Z7aCltAGsJfV20qOXCd1CvGRFiYZF9Wx/LqM7pOlOevQNbE0d18a0BTZelzo
    SZDtWLDS0xnawbbGwF2uVjrKPdoFrdMUV/ceyDmOX2kzRLLB6Pp2v7HRBxQlSf5w
    EwRHAx6nu6IluxrwHaKnCtQlWSfJcQJIvNbnOKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520121759; bh=Oc+IOK
    po2SNlYYOyR34qxMIXrdS4DxS2cZK6m/ag9UA=; b=PlGapVq4opRcQSgGGpPVyc
    wdhcsbD/Z34hsetNG/tBoqZ6SCwqBpu8l6r06caHocHeyFgJ5uWaOOSH0wyUZlgm
    WXEeaw7V4hDhGKpgJiYNlagZpqGBIJITdtZgbcsX9bC47vQHZ6ReCcZbijqluKjj
    IpNV8FJZypL4VReKBQwafwDcSskUPc57PnbNqInVCn3ngAJhet8S4WntsgU2UHFu
    P/zG3yUf+bqNkVy5pdTsNO5apTGse8Hw/O27hh1PBXTjfTNzQBV+IW2ZrtIOKUCR
    NzbpUYLSzQ9h6/6g44k+dy/tC6OHeCp/Bd/eACDavDRWuzkpyg3nOE/uJrpmiRJQ
    ==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=Ls4wCbZn x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=Ls4wCbZn x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932465AbeCDACE (ORCPT <rfc822;greg@kroah.com>);
        Sat, 3 Mar 2018 19:02:04 -0500
Received: from mail-co1nam03on0109.outbound.protection.outlook.com ([104.47.40.109]:6764
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S933757AbeCCWcB (ORCPT <rfc822;stable@vger.kernel.org>);
        Sat, 3 Mar 2018 17:32:01 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Mohammed Shafi Shajakhan <mohammed@qti.qualcomm.com>,
        Kalle Valo <kvalo@qca.qualcomm.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 036/219] ath10k: fix fetching channel during
 potential radar detection
Thread-Topic: [PATCH AUTOSEL for 4.9 036/219] ath10k: fix fetching channel
 during potential radar detection
Thread-Index: AQHTsz7shLnZ+F89bUGDBAmODTRNsQ==
Date: Sat, 3 Mar 2018 22:28:16 +0000
Message-ID: <20180303222716.26640-36-alexander.levin@microsoft.com>
References: <20180303222716.26640-1-alexander.levin@microsoft.com>
In-Reply-To: <20180303222716.26640-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MW2PR2101MB1083;7:df1WwO3XhJTWAaZxqODfvbgpO0WY5RmplNumUg5FhuWQbrRN5GXoRKuC+26RiFNJ6Jm1ptPHUcDNh3FkrXcPmmVvtdgtGISm6NuwFiA9w+hxhRgxSFeFocTctcFhZ2QKv6GvXZBMVinq1PRXCKGzWDRqGJbZCXgOpdd92XYfvaUMj7aFF6LsG+02Yzpcr9keHmmLf3yThHqDs5bTCs0XwiiD4moGxfvlcZ2fVzIukVqAqLJhXhGktIrxdOcFWu4P
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: cab0b703-9b93-4a63-413a-08d5815693bc
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603307)(7193020);SRVR:MW2PR2101MB1083;
x-ms-traffictypediagnostic: MW2PR2101MB1083:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <MW2PR2101MB1083C05E1C4EBA9955878565FBC40@MW2PR2101MB1083.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3231220)(944501244)(52105095)(3002001)(6055026)(61426038)(61427038)(6041288)(20161123562045)(20161123558120)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:MW2PR2101MB1083;BCL:0;PCL:0;RULEID:;SRVR:MW2PR2101MB1083;
x-forefront-prvs: 0600F93FE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(39860400002)(39380400002)(396003)(346002)(366004)(51234002)(189003)(199004)(106356001)(53936002)(316002)(305945005)(7736002)(3280700002)(107886003)(2906002)(6512007)(6436002)(97736004)(3660700001)(6486002)(99286004)(81166006)(8936002)(81156014)(76176011)(8676002)(25786009)(2950100002)(6506007)(4326008)(110136005)(5250100002)(54906003)(36756003)(575784001)(105586002)(6116002)(6666003)(22452003)(86612001)(10090500001)(186003)(68736007)(26005)(2900100001)(86362001)(66066001)(102836004)(3846002)(14454004)(478600001)(72206003)(10290500003)(5660300001)(59450400001)(1076002)(2501003)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:MW2PR2101MB1083;H:MW2PR2101MB1034.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
x-microsoft-antispam-message-info: 2OPoibxXxV6uBL0Z6aA4NhBLcNxGftXVMFW01OBm/GK7abUBiBDdao3+WIxAKkvCqVoYmQRljINlIIOMLyPJ7icAAuHpY3CG8hsmHvvt6vGgKxPzHmZX81CjU7vr84RTRGmm+OS6n2qDjnYYRE0bWQI9zkAcN2dfLtUeIl60rM4=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cab0b703-9b93-4a63-413a-08d5815693bc
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2018 22:28:16.6350
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB1083
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Mohammed Shafi Shajakhan <mohammed@qti.qualcomm.com>

[ Upstream commit a28f6f27a88f047f03f04b9246ca260ebc91455e ]

Fetch target operating channel during potential radar detection when
the interface is just brought up, but no channel is assigned from
userspace. In this scenario rx_channel may not be having a valid pointer
hence fetch the target operating channel to avoid warnings as below
which can be triggered by the commands with DFS testing over longer run

comamnds:
iw wlan1 set type mesh
ifconfig wlan1 up (valid tgt_oper_chan only)
iw wlan1 cac trigger freq 5260 HT20 (valid rx_channel, tgt_oper_chan)
iw wlan1 cac trigger freq 5280 HT20
iw wlan1 cac trigger freq 5300 HT20

Once the CAC expires, current channel context will be removed and
we are only left with the fallback option of using 'target operating
channel'

Firmware and driver log:
ath: phy1: DFS: radar found on freq=3D5300: id=3D1, pri=3D1125, count=3D5,
count_false=3D4
ath: phy1: DFS: radar found on freq=3D5260: id=3D5, pri=3D3151, count=3D6,
count_false=3D11
ath: phy1: DFS: radar found on freq=3D5280: id=3D1, pri=3D1351, count=3D6,
count_false=3D4
ath: phy1: DFS: radar found on freq=3D5300: id=3D1, pri=3D1125, count=3D5,
count_false=3D4
ath10k_pci 0001:01:00.0: failed to derive channel for radar pulse,
treating as radar
ath10k_pci 0001:01:00.0: failed to derive channel for radar pulse,
treating as radar

Call trace:

WARNING: CPU: 1 PID: 2145 at
backports-20161201-3.14.77-9ab3068/net/wireless/chan.c:265
cfg80211_set_dfs_state+0x3c/0x88 [cfg80211]()

 Workqueue: phy1 ieee80211_dfs_radar_detected_work
[mac80211]
[<c0320770>] (warn_slowpath_null) from [<bf79b90c>]
(cfg80211_set_dfs_state+0x3c/0x88 [cfg80211])
[<bf79b90c>] (cfg80211_set_dfs_state [cfg80211]) from
[<bf79697c>] (cfg80211_radar_event+0xc4/0x140 [cfg80211])
[<bf79697c>] (cfg80211_radar_event [cfg80211]) from
[<bf83c058>] (ieee80211_dfs_radar_detected_work+0xa8/0xb4 [mac80211])
[<bf83c058>] (ieee80211_dfs_radar_detected_work
[mac80211]) from [<c0339518>] (process_one_work+0x298/0x4a4)

Signed-off-by: Mohammed Shafi Shajakhan <mohammed@qti.qualcomm.com>
Signed-off-by: Kalle Valo <kvalo@qca.qualcomm.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/net/wireless/ath/ath10k/wmi.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/net/wireless/ath/ath10k/wmi.c b/drivers/net/wireless/a=
th/ath10k/wmi.c
index 54df425bb0fc..e518b640aad0 100644
--- a/drivers/net/wireless/ath/ath10k/wmi.c
+++ b/drivers/net/wireless/ath/ath10k/wmi.c
@@ -3638,6 +3638,11 @@ static void ath10k_dfs_radar_report(struct ath10k *a=
r,
=20
 	spin_lock_bh(&ar->data_lock);
 	ch =3D ar->rx_channel;
+
+	/* fetch target operating channel during channel change */
+	if (!ch)
+		ch =3D ar->tgt_oper_chan;
+
 	spin_unlock_bh(&ar->data_lock);
=20
 	if (!ch) {
--=20
2.14.1
