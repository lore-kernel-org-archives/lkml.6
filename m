Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1204544-1520118993-2-10669728961542264037
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
    t=1520118992; b=TxTgln4ItQdMu7GZc1nOLEOXWz2EJaUloUMRUJ+/LOUgu1N
    H+9FkwuJZ3P1kbIXPmZL+s+jYY62bAAsrPSw7KZwGWgqGh/7Max9YORvAYcELfoM
    Iayyr6me0kVplQI5PHztIR6pU9jrT7MG+qOTHYXDASy5TpO/gfszuVdIegxYGOQA
    9WM5DUzhToczauwsxqC0EvIl3xyEjP+QZHVOItDSsqggIoczinDxOulvfWuhOod3
    x4G0xlJ0Esywn5QHZApAhio7C0N6Oc3mLGvWqXpYTVE6iTPZ2VnPlB4nox4UbRmy
    3W2VgXUumD9fGrBR+elZsD3fQ66N14DwUUrzhAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520118992; bh=rrP/kY
    CrDG16MPKNOjZRNiiK/ztXgb0Hoye0C/avnRE=; b=oFpAPcu+p4VPgnJJ4OS6K/
    Hesf7zLZZORsEcCxh6BrUHsrG0gzf33EW5kSbq7bu25TJQHCWQk+2oKDZMfkgl2F
    aVEyB9K/hqAe/Jz5iVMO6Qs7/5li0eMsYIElQGEW4Q7rk1GxImClUFFuKaOGPVA7
    ceG6WVi1F0Jz3KWC6kMmIOVt93uroYKN1St4HQ62+tuveh4BWJQ29WsYW/ABUOvj
    m5u0vI1xQH3FcP9bow2F5SELpBZp90v2prFXItBg9Ep948h6zDgek8XswjxB9UzL
    PXpVTDK46f5EaUyrQYpJdzNFLELSchLGw2b6Sr2diwjGEGfGXe09GOuPNRezlbfg
    ==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=DOAIiKLM x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=DOAIiKLM x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934907AbeCCWiO (ORCPT <rfc822;greg@kroah.com>);
        Sat, 3 Mar 2018 17:38:14 -0500
Received: from mail-cys01nam02on0114.outbound.protection.outlook.com ([104.47.37.114]:41081
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S934892AbeCCWiM (ORCPT <rfc822;stable@vger.kernel.org>);
        Sat, 3 Mar 2018 17:38:12 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Andreas Pape <APape@phoenixcontact.com>,
        Andreas Pape <apape@phoenixcontact.com>,
        Sven Eckelmann <sven@narfation.org>,
        Simon Wunderlich <sw@simonwunderlich.de>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.4 022/115] batman-adv: handle race condition for
 claims between gateways
Thread-Topic: [PATCH AUTOSEL for 4.4 022/115] batman-adv: handle race
 condition for claims between gateways
Thread-Index: AQHTsz9O7ptW52ZNIEavMaH69z1/oA==
Date: Sat, 3 Mar 2018 22:31:00 +0000
Message-ID: <20180303223010.27106-22-alexander.levin@microsoft.com>
References: <20180303223010.27106-1-alexander.levin@microsoft.com>
In-Reply-To: <20180303223010.27106-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MW2PR2101MB1067;7:/TktM8gQWIF+WHo9GF29szZmA+jFixxbchVvKBnXtsKIrW0RUj3dT0I7iiOFQgXdn+h5GUFSKIVsDtEzuNhGEiio+Hq4RUIIIjc0+2fYUHMy28eakXWH/9KGlftdPxqKFOwhpA73ZRAQGPNZ3A6Keq0LT/v79QgFOUgiDB4M2DqaTTh9fAN06xHsH0n/q0Fd/0rUQlJXTUOsDjAl7Un8OaUFi8t19Zz068xGVO0qTpHTrTw/ESXk/7YOXJg0P5nV
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 1b0df555-784e-488f-ba35-08d581576f7e
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(48565401081)(5600026)(4604075)(3008032)(2017052603307)(7193020);SRVR:MW2PR2101MB1067;
x-ms-traffictypediagnostic: MW2PR2101MB1067:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <MW2PR2101MB106742A5D23C4AD2BC5CC2DEFBC40@MW2PR2101MB1067.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(5005006)(8121501046)(3231220)(944501244)(52105095)(3002001)(10201501046)(93006095)(93001095)(6055026)(61426038)(61427038)(6041288)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(20161123560045)(20161123562045)(6072148)(201708071742011);SRVR:MW2PR2101MB1067;BCL:0;PCL:0;RULEID:;SRVR:MW2PR2101MB1067;
x-forefront-prvs: 0600F93FE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(366004)(376002)(39860400002)(39380400002)(346002)(199004)(189003)(4326008)(5250100002)(86362001)(1076002)(2501003)(110136005)(6666003)(81156014)(2906002)(8936002)(305945005)(81166006)(2950100002)(7736002)(10290500003)(26005)(186003)(3660700001)(478600001)(72206003)(107886003)(8676002)(3280700002)(59450400001)(2900100001)(76176011)(6116002)(25786009)(3846002)(102836004)(6506007)(5660300001)(97736004)(10090500001)(86612001)(106356001)(99286004)(6512007)(66066001)(316002)(53936002)(14454004)(105586002)(36756003)(6486002)(54906003)(6436002)(68736007)(22452003)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:MW2PR2101MB1067;H:MW2PR2101MB1034.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
x-microsoft-antispam-message-info: rTzslphqjscZmjTO0rmllV1D6OWD+10w7abc2nPws/tmm7D5aPMQlYfWxyq3Uaso0y5tELuC9zLEc3562C7Jgcs0hl1h5ssMyHYvJj5UZOZQ16EcyedijfRUIgx35b2gkiy3L0EjEpOV7hsgH9KSQ5IL9OjfoRpsHwr69Z7DL5U=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b0df555-784e-488f-ba35-08d581576f7e
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2018 22:31:00.7134
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB1067
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Andreas Pape <APape@phoenixcontact.com>

[ Upstream commit a3a5129e122709306cfa6409781716c2933df99b ]

Consider the following situation which has been found in a test setup:
Gateway B has claimed client C and gateway A has the same backbone
network as B. C sends a broad- or multicast to B and directly after
this packet decides to send another packet to A due to a better TQ
value. B will forward the broad-/multicast into the backbone as it is
the responsible gw and after that A will claim C as it has been
chosen by C as the best gateway. If it now happens that A claims C
before it has received the broad-/multicast forwarded by B (due to
backbone topology or due to some delay in B when forwarding the
packet) we get a critical situation: in the current code A will
immediately unclaim C when receiving the multicast due to the
roaming client scenario although the position of C has not changed
in the mesh. If this happens the multi-/broadcast forwarded by B
will be sent back into the mesh by A and we have looping packets
until one of the gateways claims C again.
In order to prevent this, unclaiming of a client due to the roaming
client scenario is only done after a certain time is expired after
the last claim of the client. 100 ms are used here, which should be
slow enough for big backbones and slow gateways but fast enough not
to break the roaming client use case.

Acked-by: Simon Wunderlich <sw@simonwunderlich.de>
Signed-off-by: Andreas Pape <apape@phoenixcontact.com>
[sven@narfation.org: fix conflicts with current version]
Signed-off-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 net/batman-adv/bridge_loop_avoidance.c | 20 ++++++++++++++++----
 1 file changed, 16 insertions(+), 4 deletions(-)

diff --git a/net/batman-adv/bridge_loop_avoidance.c b/net/batman-adv/bridge=
_loop_avoidance.c
index f5d2fe5e31cc..c5208136e3fc 100644
--- a/net/batman-adv/bridge_loop_avoidance.c
+++ b/net/batman-adv/bridge_loop_avoidance.c
@@ -1603,10 +1603,22 @@ int batadv_bla_tx(struct batadv_priv *bat_priv, str=
uct sk_buff *skb,
 		/* if yes, the client has roamed and we have
 		 * to unclaim it.
 		 */
-		batadv_handle_unclaim(bat_priv, primary_if,
-				      primary_if->net_dev->dev_addr,
-				      ethhdr->h_source, vid);
-		goto allow;
+		if (batadv_has_timed_out(claim->lasttime, 100)) {
+			/* only unclaim if the last claim entry is
+			 * older than 100 ms to make sure we really
+			 * have a roaming client here.
+			 */
+			batadv_dbg(BATADV_DBG_BLA, bat_priv, "bla_tx(): Roaming client %pM dete=
cted. Unclaim it.\n",
+				   ethhdr->h_source);
+			batadv_handle_unclaim(bat_priv, primary_if,
+					      primary_if->net_dev->dev_addr,
+					      ethhdr->h_source, vid);
+			goto allow;
+		} else {
+			batadv_dbg(BATADV_DBG_BLA, bat_priv, "bla_tx(): Race for claim %pM dete=
cted. Drop packet.\n",
+				   ethhdr->h_source);
+			goto handled;
+		}
 	}
=20
 	/* check if it is a multicast/broadcast frame */
--=20
2.14.1
