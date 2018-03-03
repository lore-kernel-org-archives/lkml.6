Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1312649-1520122876-2-7662900695403702961
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
    t=1520122876; b=AkfBjt0E4FkzszDBqT7kSOFinkpvRNzRBeBjIOEiUJcsSSw
    HOM+VnDe8WTtJXmPZH/sOjtLwfpT6ggjrI9EYGwxOs6FImQpM3MBmZDedvPedHVE
    3Aem2diBvpF0uIiLbc0pfkQd7Q9cxUSpwPdyJYoBNAsQyok6GpywBxmgMtNfySq1
    /8uGcn/fzN/nGkvBB1xbNMFHHHVBDbV8YT2PXUTEXlgrPLSPL5hMDguNDTOy9k21
    ynHpsdPhpZwco7PA2Vj+XHdsrsCiw2hH65l9o5C9HQ983Ixq4YsMQ53k93JckCvd
    CXC+5X8KtSk0wTrd1xQgeKIP2ZbYmNkHJkQ0EQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520122876; bh=SdIS7d
    RVpbo+z1NhFaMXzBrHqndI0WPE/x5beKF9jhE=; b=JgPhWMTEaLRN3oyZmXFHk3
    /qME2tf4k19+0JN6+Om0FG/dVwBmMjWkBGFbGj1um/F5SjWeTXvLjqwHLn/I3zWu
    MeuUNCTEnF5mN0nzt+64z0tvMAIpkMtZufY+Fps+MiyB6dyNb2g/xRd8hJfb/oNK
    +EHMLAhERN+qN7tomm/wyzzykEZEuw9O7pMWXnZA9bJAKLTsk6suEGX1wvWjRbSH
    DNYJYKcgawF+4RokF7U9QpwJ7M6S1Kmnaeiz8YS7i3Ru1SsFjZ++s1+lIIwBH2a/
    zAzTJvVVsqXLOKldiwLJRIjhXbdp5hixmqskD82dczJjgRVpTwW+p/WgL+V2+HYQ
    ==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=gUoVXReO x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=gUoVXReO x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932887AbeCDAU6 (ORCPT <rfc822;greg@kroah.com>);
        Sat, 3 Mar 2018 19:20:58 -0500
Received: from mail-by2nam01on0114.outbound.protection.outlook.com ([104.47.34.114]:45301
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S933285AbeCCW3B (ORCPT <rfc822;stable@vger.kernel.org>);
        Sat, 3 Mar 2018 17:29:01 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Manikanta Pubbisetty <mpubbise@qti.qualcomm.com>,
        Kalle Valo <kvalo@qca.qualcomm.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.14 38/84] ath10k: update tdls teardown state to
 target
Thread-Topic: [PATCH AUTOSEL for 4.14 38/84] ath10k: update tdls teardown
 state to target
Thread-Index: AQHTsz6oHmeR2u4kbE+mV+V5pLvp4w==
Date: Sat, 3 Mar 2018 22:26:21 +0000
Message-ID: <20180303222518.26271-38-alexander.levin@microsoft.com>
References: <20180303222518.26271-1-alexander.levin@microsoft.com>
In-Reply-To: <20180303222518.26271-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MW2PR2101MB1115;7:IdJ+Au3En3dZUJdEDVQiyW+pRcrno2I1rqJ75cUqJJ6RIqaukMYF9DnoJ+l0PBNMv4Xy+8GelxZRkzlVVMFTXhUNM7fKBNhTieKORReas7ab57lN7cyT2lq/siNl+WIm9LqG/SLHlASbHe1Z1kb4zW1ysodYvYNEi5UaFs8j2sIo7xYkwt3goiCGehXbx/gUuyq5KE+k220/G0/nY0bs/+OdCesKRhG/oguOkYX11t7LcITu28w1QUplHdA4Fqyp
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: eeef9234-6074-4f58-811b-08d581562775
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603307)(7193020);SRVR:MW2PR2101MB1115;
x-ms-traffictypediagnostic: MW2PR2101MB1115:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <MW2PR2101MB1115FC1D674EF54EFE272E16FBC40@MW2PR2101MB1115.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(5005006)(8121501046)(3002001)(3231220)(944501244)(52105095)(10201501046)(93006095)(93001095)(6055026)(61426038)(61427038)(6041288)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123558120)(20161123562045)(6072148)(201708071742011);SRVR:MW2PR2101MB1115;BCL:0;PCL:0;RULEID:;SRVR:MW2PR2101MB1115;
x-forefront-prvs: 0600F93FE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(396003)(39860400002)(346002)(366004)(39380400002)(189003)(199004)(26005)(97736004)(186003)(2900100001)(316002)(59450400001)(6506007)(102836004)(36756003)(110136005)(106356001)(54906003)(72206003)(4326008)(8676002)(81156014)(25786009)(2950100002)(6666003)(305945005)(10290500003)(5660300001)(107886003)(14454004)(8936002)(3660700001)(3280700002)(105586002)(81166006)(15650500001)(478600001)(2906002)(6116002)(3846002)(1076002)(2501003)(6436002)(5250100002)(6486002)(68736007)(7736002)(10090500001)(6512007)(66066001)(53936002)(99286004)(86612001)(76176011)(575784001)(22452003)(86362001)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:MW2PR2101MB1115;H:MW2PR2101MB1034.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
x-microsoft-antispam-message-info: AN56IZil/8mes0aO/5l4SmyEs8PS9Mte8eto6u3Xbfjxl+TuJYf4ROdJe427fP1TLx0MlixvyNGLZRRf3g9gCh3+YXLKA73g56GdteDOt0A26R/aGGN/2kwwPAFnoHbVRSMHbr/ZKFnXApMzf+WEFu8NsqpEx6Kt0vqpuFglVRE=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eeef9234-6074-4f58-811b-08d581562775
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2018 22:26:21.8692
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB1115
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Manikanta Pubbisetty <mpubbise@qti.qualcomm.com>

[ Upstream commit 424ea0d174e82365f85c6770225dba098b8f1d5f ]

It is required to update the teardown state of the peer when
a tdls link with that peer is terminated. This information is
useful for the target to perform some cleanups wrt the tdls peer.

Without proper cleanup, target assumes that the peer is connected and
blocks future connection requests, updating the teardown state of the
peer addresses the problem.

Tested this change on QCA9888 with 10.4-3.5.1-00018 fw version.

Signed-off-by: Manikanta Pubbisetty <mpubbise@qti.qualcomm.com>
Signed-off-by: Kalle Valo <kvalo@qca.qualcomm.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/net/wireless/ath/ath10k/mac.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/net/wireless/ath/ath10k/mac.c b/drivers/net/wireless/a=
th/ath10k/mac.c
index 5683f1a5330e..35b752353aee 100644
--- a/drivers/net/wireless/ath/ath10k/mac.c
+++ b/drivers/net/wireless/ath/ath10k/mac.c
@@ -6183,6 +6183,16 @@ static int ath10k_sta_state(struct ieee80211_hw *hw,
 			   "mac vdev %d peer delete %pM sta %pK (sta gone)\n",
 			   arvif->vdev_id, sta->addr, sta);
=20
+		if (sta->tdls) {
+			ret =3D ath10k_mac_tdls_peer_update(ar, arvif->vdev_id,
+							  sta,
+							  WMI_TDLS_PEER_STATE_TEARDOWN);
+			if (ret)
+				ath10k_warn(ar, "failed to update tdls peer state for %pM state %d: %i=
\n",
+					    sta->addr,
+					    WMI_TDLS_PEER_STATE_TEARDOWN, ret);
+		}
+
 		ret =3D ath10k_peer_delete(ar, arvif->vdev_id, sta->addr);
 		if (ret)
 			ath10k_warn(ar, "failed to delete peer %pM for vdev %d: %i\n",
--=20
2.14.1
