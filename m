Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1247250-1520119657-5-810361878838503930
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
    t=1520119657; b=FvdrzdZQistkXUrmtpwHbyFzmY4Y/lzN1e3Fxuy5rD+9cEv
    OiobERQWcG13W6f6I38RwREuMQcIjio7WxcOl5eyMrRKV2EryWoPbx+Hv5qx0pZM
    ufszfOLOUGZRlB/kvB6U2TatvKLcfeLwmW2fAGLXZinJOIjOqQ+jffEWltk8kNre
    SunR0v4zejshFbraSESRxtbOUAFxxZYl1BOHfidVHn4RLv3bbP9OLKP/D9J5b08T
    rdrRrelbKfycnIXCge88S6O9p/I+LaunEHKUhy9XFijAkW80zFZtrqfn+8H1Kwky
    B63eK3fif9sJRTUKvbrtnqCIn2s7kSCYO9iO7LA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520119657; bh=C2DqMQ
    rjpWaXkKZZMSMdj22tktcXWVF2yKtzSO4q+aI=; b=ojDIyGlIwOY4GmQDRPGjOV
    JYPvlnp+ThhxTTtfhaqmiM/isMQmB6dKUkYtnEB0vMatItgzX47KaZSaDWteidKl
    XVWBeLWUVZtVqK/V3nEzx724bua+awwZQb/XGecRcP6MgAmIMDLfqEKx90Ls3sks
    7oc8ldL3KzzNlAIp7ybOAExOPmDIsVkzuFNEiW1IrjePO4Co4HDoRBrVP6s77vfo
    HDdeJmfa/jFb+BxOtazhuikGpOIUGP84u3lC8GkqpQS5JvgcbSFBbAfL37ctQIFF
    w5a1e68NU40m/9nSR93x9XwRl0DkeyTB73Ttr733HS0hIbedNGhhrVpTqg85a2IQ
    ==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=N1iAUYeM x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=N1iAUYeM x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932416AbeCCX1e (ORCPT <rfc822;greg@kroah.com>);
        Sat, 3 Mar 2018 18:27:34 -0500
Received: from mail-by2nam03on0136.outbound.protection.outlook.com ([104.47.42.136]:28821
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S934657AbeCCWhE (ORCPT <rfc822;stable@vger.kernel.org>);
        Sat, 3 Mar 2018 17:37:04 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Manikanta Pubbisetty <mpubbise@qti.qualcomm.com>,
        Kalle Valo <kvalo@qca.qualcomm.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 193/219] ath10k: update tdls teardown state to
 target
Thread-Topic: [PATCH AUTOSEL for 4.9 193/219] ath10k: update tdls teardown
 state to target
Thread-Index: AQHTsz8jdVR+vo/pwEy67enJYEIG4g==
Date: Sat, 3 Mar 2018 22:29:49 +0000
Message-ID: <20180303222716.26640-193-alexander.levin@microsoft.com>
References: <20180303222716.26640-1-alexander.levin@microsoft.com>
In-Reply-To: <20180303222716.26640-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MW2PR2101MB0969;7:gGDQotTPIboFd4FDw5E/Qywg4eiezxOa4GX8rlMfVgKJgux2MdimMJ4Vd7YMdNsHG/jcCHmOwpR1TzUysB72ep8I5TbdZaRJQ87zMlI1dOvkMPA2TI3wxb+w0rZa98eyewWqkPS3nt/8EGjkUrVKyMp8TQhyh8XEkaCAO7PoYC3m/pUg6LzkjUxap8rkc5U0reREzY4elnzamSQhNq/PUPWIUJwSQO9gIiOgV3Zj4YOb+re7LumRr3LR0fEQUrFF
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: a88bd64f-b9f8-4ba2-9b74-08d58157412b
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603307)(7193020);SRVR:MW2PR2101MB0969;
x-ms-traffictypediagnostic: MW2PR2101MB0969:
x-microsoft-antispam-prvs: <MW2PR2101MB0969980185F54482DCDB1315FBC40@MW2PR2101MB0969.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3231220)(944501244)(52105095)(3002001)(6055026)(61426038)(61427038)(6041288)(20161123562045)(20161123558120)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:MW2PR2101MB0969;BCL:0;PCL:0;RULEID:;SRVR:MW2PR2101MB0969;
x-forefront-prvs: 0600F93FE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(376002)(39380400002)(366004)(396003)(39860400002)(189003)(199004)(105586002)(5250100002)(53936002)(107886003)(36756003)(6436002)(4326008)(2501003)(6486002)(1076002)(2906002)(6512007)(2900100001)(54906003)(110136005)(305945005)(106356001)(7736002)(316002)(3280700002)(478600001)(14454004)(15650500001)(59450400001)(10290500003)(68736007)(2950100002)(72206003)(3660700001)(66066001)(3846002)(6116002)(102836004)(6506007)(5660300001)(10090500001)(25786009)(186003)(26005)(99286004)(22452003)(81166006)(76176011)(575784001)(86362001)(81156014)(97736004)(86612001)(8676002)(8936002)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:MW2PR2101MB0969;H:MW2PR2101MB1034.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
x-microsoft-antispam-message-info: ki2PcRXjy3uzJBJzWUgZeCNpEVBhsXj1v4O4EZxgsBbuJVYXuZXLV4L4dzp/vIG9zbIYbpCNznU5BCwdsd/pUDg88nmwSYHggktgS2gQ7d0qK2s4g0SMmu2tZJIrha2DYZPzjPkCVvL/vxQj5AsKHvb8QYomPrGx29Nxjhk1EX4=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a88bd64f-b9f8-4ba2-9b74-08d58157412b
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2018 22:29:49.2133
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB0969
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
index 696b90270615..1e6e63dbd61c 100644
--- a/drivers/net/wireless/ath/ath10k/mac.c
+++ b/drivers/net/wireless/ath/ath10k/mac.c
@@ -6054,6 +6054,16 @@ static int ath10k_sta_state(struct ieee80211_hw *hw,
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
