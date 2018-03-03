Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1211789-1520118128-2-1016255835400807483
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
    t=1520118127; b=GNycWD1R/n/0KCdiFTmdFZsRjM+tjnRyDWtNObifhwvv0iw
    +FbG4iMsps5f6/SKDuQ45HT+/6jzwoQiulnLoHh9YMsgFvnlk3js77lojv/aIThA
    iL74ATVXAdyErfdfpD0kFJN+NWf+lRcwiB4ghPVv5otgxDSnGX5bBFj5No0J75pC
    CjKrWDbGJ67jCobkKvS5rXMVEhums+ejdpa3xkAzf/70yFszTo4P/uff531c3pn9
    zzeRvpv6BJX9uR5TImeaYWQcL7unlSvktcjBe9FE11N8Z/sFa5aFKaMaNeRHBq5O
    Klw81Ty9HVe0eUpfzCYT/fROCBaFGUwTgnR8qQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520118127; bh=AxfYny
    4qOnCe401muFoU/nERli2I1/0fXwTAAdGR0rc=; b=pL5UFUczy00koU+H3XT5Pi
    oOCaRRFkI3/aRvE6lsOi6thQiFUkrNChYxmpOF3IZCgvJy4cIUfpo3tcPyb39/sP
    YDa56K6iUY5VVXUl+5iekZX+nftuxRMs0najulnpALaI75vlj39dDijYylc5g/+5
    niNDCeVzmpHszptepAfmuWIOdndqjJx9LopTSdKVkuUjjA6SLP+BDAlSccR4Dsse
    Ko4XsMB064xmhtZU6SYsB6ipjmkJmXWKJogVGwZLLDZQa0MfbZp62ZgSccFDw86L
    AGFQkDFdRkp+TNhO+kiaaK7Kijgmxt23sAhA08PzXJaPZLUU32aXehKSPqpQIruw
    ==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=Cr8epq/C x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=Cr8epq/C x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934538AbeCCXBt (ORCPT <rfc822;greg@kroah.com>);
        Sat, 3 Mar 2018 18:01:49 -0500
Received: from mail-co1nam03on0111.outbound.protection.outlook.com ([104.47.40.111]:9680
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S934446AbeCCWks (ORCPT <rfc822;stable@vger.kernel.org>);
        Sat, 3 Mar 2018 17:40:48 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Manikanta Pubbisetty <mpubbise@qti.qualcomm.com>,
        Kalle Valo <kvalo@qca.qualcomm.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.4 097/115] ath10k: update tdls teardown state to
 target
Thread-Topic: [PATCH AUTOSEL for 4.4 097/115] ath10k: update tdls teardown
 state to target
Thread-Index: AQHTsz9qfuqc/kyqWE6TX5/N1nmOuA==
Date: Sat, 3 Mar 2018 22:31:47 +0000
Message-ID: <20180303223010.27106-97-alexander.levin@microsoft.com>
References: <20180303223010.27106-1-alexander.levin@microsoft.com>
In-Reply-To: <20180303223010.27106-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MW2PR2101MB0939;6:w9GkVBEcYiPR567rPgxQjOkMhFqKK+9RxJfCdkZCFAtRV4q20ds7uQ2cv87fwDuYuHRl244G6dcfn3bDKRdAJeaFzXs6/L67JcsjnoXstBaZJuhOeXtsO4Y+1oqwdIz9hZMxrDepJZ7bRPk1UC4EZm42zFVUwRV36pmPuLHTfP67DyESMr0JjNeZ5md5Qy2DqEfyYmGXStLqrmfS+Y07cSSXWK8X3Zf4+nUG7ngnyeYf/DXrXa9PB9J80HS+Amk2lrp+ZPbMWeYZaU2H7cw+feoECFz7gy9dZHxDWVQCEEbh7GjIHJ2ImFUEY1VKITCXnArZB8QhyaZG0rNPOGTwb6aOUQNCKTUsa6z221uanFTcaWtr7ozvIx2ADb8s20lt;5:EXZ0bphMheGnwy5dWAJykKhgcjjZYspBXzW5BUcRDOsfdloIs49q+BNOJBpee5sIgV0B/lTA+GO7tapMl5WcX/jCuqNDGzV7SgrKQIEn4CqsPYNcWDF4ldzwp0ymme+hpbWn86mtlbci4RtnIjssaXfCjHbzBA5aQIF7ZwT7hUM=;24:BAc8YcVnvTH0leWRtrTg3i0Fzi87I0gDWFij5JSFoF4XSn+fsCYUCr6PqK1HCbZC/Kkr/57ECuzXsj9JAmnJT+AROzSKVywZVwk9qOOftpg=;7:qo9okzbnFncY/Mas+4JYjjpJfYzhzDY5JE9PypzkIp0rwuS3yPNh/kBky3bcsPo4CZgpb9f8SAMUbnIXRhHsBj5RgXR8pEK8fV/V7qbdj4i3KoLhsSGGv0zlmGdhSVpKRdWUBZUn4ahETZJSJcIYqTw3e5pKz+/zvgp9cYxSnzLpoSNMiG+UHoRxAmp6y9GjR51yu5VIE2EMiUPBQI4XTIW/VkUcnQfOVRYUeaPURXbpHokf69uBkWMmRvmZpJhj
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 0199fcaf-0c74-41bf-e1ce-08d58157cdab
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603307)(7193020);SRVR:MW2PR2101MB0939;
x-ms-traffictypediagnostic: MW2PR2101MB0939:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <MW2PR2101MB09394A74645167C43B308546FBC40@MW2PR2101MB0939.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(8121501046)(5005006)(3231220)(944501244)(52105095)(3002001)(10201501046)(93006095)(93001095)(6055026)(61426038)(61427038)(6041288)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123558120)(20161123562045)(6072148)(201708071742011);SRVR:MW2PR2101MB0939;BCL:0;PCL:0;RULEID:;SRVR:MW2PR2101MB0939;
x-forefront-prvs: 0600F93FE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(346002)(366004)(376002)(39380400002)(39860400002)(189003)(199004)(86612001)(76176011)(478600001)(81166006)(81156014)(72206003)(5660300001)(8936002)(25786009)(59450400001)(26005)(6506007)(102836004)(316002)(22452003)(6486002)(8676002)(14454004)(4326008)(6436002)(107886003)(10090500001)(6512007)(53936002)(36756003)(10290500003)(86362001)(575784001)(2900100001)(3660700001)(305945005)(2950100002)(5250100002)(99286004)(3280700002)(97736004)(54906003)(110136005)(2501003)(186003)(106356001)(7736002)(66066001)(3846002)(2906002)(6116002)(105586002)(68736007)(1076002)(15650500001)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:MW2PR2101MB0939;H:MW2PR2101MB1034.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
x-microsoft-antispam-message-info: P2lZuQVnhOtD1cU1IbzzgSeV05lWb0jsiFJ7wQ0jXVF/ZX4fyemcT7G3ctchkRu4turseItosHjVaR82r6IydZ53S6zPQJOlgjSaDIDSxMXPGdRNK2itU61joOC1ftEvAm4qKsYLeRW8PTz/4TzSV5SG3lFxF8nydY+BUAhdu/o=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0199fcaf-0c74-41bf-e1ce-08d58157cdab
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2018 22:31:47.4801
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB0939
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
index d5c9ca47219c..09e14ce85dd0 100644
--- a/drivers/net/wireless/ath/ath10k/mac.c
+++ b/drivers/net/wireless/ath/ath10k/mac.c
@@ -5497,6 +5497,16 @@ static int ath10k_sta_state(struct ieee80211_hw *hw,
 			   "mac vdev %d peer delete %pM (sta gone)\n",
 			   arvif->vdev_id, sta->addr);
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
