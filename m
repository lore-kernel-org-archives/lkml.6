Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1352585-1520124053-2-14059802279539121925
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
    t=1520124053; b=NTLD/Qy2R3dciMJCxBD9WBT/tTfPBqrBCE+Q7SgVsUx2GK0
    9irvMSYYJraKQ6sIUxibbF+kKRQwmQl8DVkfp64bJpNt5vr5StDRYTWL9DnFYl70
    p3yvlNfwnjNYufOmAMZLc/r1uNEhrruz7/IIzvw/SK59+rJK8XiCGzY2F/2kQ/Td
    mfB83YZP/epV+nPLyxCG0fjiGZXbT9uySfgaLln7z0OwAhthUoznR2I2iW+bIKk7
    eQtaN9WWptRY5LoB8AAzMcszxzRZssQ8glh5hU4e+cXYIyn5561Tj6WLqTYVskQT
    NkCDUA42Cshw6Lh9FHoAMWhnz6BtXju+lbpOKDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520124053; bh=U/xkGU
    yAK5F6pIWf/S7GdpJo1jEs36hPRNGuGu218+E=; b=iRjVSgbYFLg4COYO32zC9c
    crJPE/naDKFwnAXjJnqaoLWV0raf1FMODxU/MWkc0XjO7IG1NXRTZf3SrjO9peR0
    aWUv/oAfrdor7ft3JnKmNvM7wxFVfS7VypqyA76fcwxXmrytDToLIXBcEEh3eyha
    +Qdffd3j88+rtQwWJX8IZc74a6drb6NcA6yIWJ/4UR8LaiH+QUcdOGNG/bEU802Q
    u2+w+BuZFnAeyBH8XQ5ng+TlUAVK27GjOtdD4lGDB5FZDGauk3CPu9rGsKp4JoC1
    Dzw0sTe5SMiGwZG/yLr4hnDcmfmKhbMIGOllh0Ud1SL8Dohs2zcBAl7fAMoCpJNg
    ==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=SUaFnR25 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=SUaFnR25 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932653AbeCDAku (ORCPT <rfc822;greg@kroah.com>);
        Sat, 3 Mar 2018 19:40:50 -0500
Received: from mail-sn1nam01on0131.outbound.protection.outlook.com ([104.47.32.131]:14704
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932628AbeCCW0S (ORCPT <rfc822;stable@vger.kernel.org>);
        Sat, 3 Mar 2018 17:26:18 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Manikanta Pubbisetty <mpubbise@qti.qualcomm.com>,
        Kalle Valo <kvalo@qca.qualcomm.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.15 050/102] ath10k: update tdls teardown state
 to target
Thread-Topic: [PATCH AUTOSEL for 4.15 050/102] ath10k: update tdls teardown
 state to target
Thread-Index: AQHTsz5q+yT1Q0onh0Gal7HDQ99vFQ==
Date: Sat, 3 Mar 2018 22:24:38 +0000
Message-ID: <20180303222318.26006-50-alexander.levin@microsoft.com>
References: <20180303222318.26006-1-alexander.levin@microsoft.com>
In-Reply-To: <20180303222318.26006-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MW2PR2101MB0970;7:MLdRYURVsJl+J1WJcicugYv3rUN9j3XiMwoKGLOgNTIB+GmAZmRLDm4Sh1KZRqF627nrfWw18USzCBsJu2lzGUt2vbd0bGilAt0hPDyzc9vW7Q6ewkG+dUF4Gm16IOGoFpuYHf2X4VzvqWL6Kqil/ZLsXaPCzFcKRITMo/PFoHaYpS/VmLJxFLcLFS1A/S901H3fiZDeh+mF9w6EdpdwKiFENKF3dTZc6WlxTT22i9Vtsn6Bgph59yLHjEcK13IF
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 438bdd0e-dceb-4c2e-4ae8-08d58155c3cc
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(48565401081)(5600026)(4604075)(3008032)(2017052603307)(7193020);SRVR:MW2PR2101MB0970;
x-ms-traffictypediagnostic: MW2PR2101MB0970:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <MW2PR2101MB0970DE9472FD72CFFBA73E23FBC40@MW2PR2101MB0970.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(5005006)(8121501046)(93006095)(93001095)(10201501046)(3002001)(3231220)(944501244)(52105095)(6055026)(61426038)(61427038)(6041288)(20161123562045)(20161123558120)(20161123560045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:MW2PR2101MB0970;BCL:0;PCL:0;RULEID:;SRVR:MW2PR2101MB0970;
x-forefront-prvs: 0600F93FE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(39860400002)(366004)(39380400002)(376002)(396003)(199004)(189003)(3660700001)(10290500003)(2950100002)(3846002)(2900100001)(22452003)(10090500001)(86612001)(6116002)(6666003)(68736007)(105586002)(5660300001)(5250100002)(106356001)(97736004)(2501003)(66066001)(8936002)(1076002)(99286004)(15650500001)(2906002)(36756003)(575784001)(86362001)(14454004)(6506007)(110136005)(4326008)(102836004)(6512007)(81156014)(305945005)(81166006)(7736002)(8676002)(53936002)(72206003)(59450400001)(6436002)(316002)(478600001)(76176011)(25786009)(6486002)(26005)(54906003)(3280700002)(186003)(107886003)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:MW2PR2101MB0970;H:MW2PR2101MB1034.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
x-microsoft-antispam-message-info: Ng+njxQb9dxdBjdy0A2LSbq+aE96UyRi4P8YKUe5hojiNpaV+oSGNYfszlGI5wYGNFEtCfp7NgsK98Ju99LMxA8+sQP5k+DuPBLURGJlRSpEb7JXfFct3l5sjcxxl9o59JkLU7DyEgTAPfEE5C2MQq0OSuGoVWbu7lW2hU2A4Is=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 438bdd0e-dceb-4c2e-4ae8-08d58155c3cc
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2018 22:24:38.0878
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB0970
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
index 0a947eef348d..c6460e7f6d78 100644
--- a/drivers/net/wireless/ath/ath10k/mac.c
+++ b/drivers/net/wireless/ath/ath10k/mac.c
@@ -6201,6 +6201,16 @@ static int ath10k_sta_state(struct ieee80211_hw *hw,
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
