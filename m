Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1310899-1520121424-2-7664071967997601064
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
    t=1520121424; b=HTZNBbIJlBgDg+kJg+mi3DOQ2rmvwFvrLiTIW04COtQnnHJ
    XCmWmMgy+MjylWjbYBYjppqszTXot1Jz97C7IEWEpsPX09XsP+ihzuGiHqSigwCp
    VBPcqMx12wz9xPZT4VmukQeC8negYeFRc80Z1bow9GoZrYoKlX8nirUR9nCiYVjG
    ko90Mw89zDLBkzpxy15sHkdofTM6RIv7QMjyviiaFXVQul3J0aq6RoNPT8nxg5mM
    RUL3YkrjBseBR97ZZd3PluaQaaW9PfY7OxhRecwQA64jQTkDJ2dRWv2AieTfa8Ul
    /QKqHgaNQ5YHBAdJXP6YmLw7ABDfh2K7iuxuyew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520121424; bh=C7PeYw
    CmAenLW+yr8QXC2DQS52devIvkrp0tSSJjS0k=; b=oxJpgKaOM5UhT1HCsLqz5A
    QH8hjgPUql6yCniKBKD61WvtaFTwYI9rN5WXxmKwGzaZtV+hrGjx0/MMCdSObmhw
    GfU11cW+KNS3Beo1zOpeOW4IqP4NsUjuMiZnARqi8KjAvAuMOMFzPw0kWq3pAA0L
    LlCJZuENfMVVNzq2hkkYyFs4QdaWmiyerohN5pKCRG8klBv7tESCg9qf93pYb5Wz
    n4YY4WmrAKUi5QxxG74QFE0ILwAjT1S+hZlgZyzY84SnkSgAioD5gwVX/rpTl9s3
    cyTjHxLuVNO+RVeXwNEW4J0IsejUP92oVgq+XNIAnwECLH071Qy/RSicXOfJ7+Lw
    ==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=MnglLN1g x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=MnglLN1g x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932501AbeCCWcZ (ORCPT <rfc822;greg@kroah.com>);
        Sat, 3 Mar 2018 17:32:25 -0500
Received: from mail-by2nam01on0120.outbound.protection.outlook.com ([104.47.34.120]:24496
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S933793AbeCCWcT (ORCPT <rfc822;stable@vger.kernel.org>);
        Sat, 3 Mar 2018 17:32:19 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Andreas Pape <APape@phoenixcontact.com>,
        Andreas Pape <apape@phoenixcontact.com>,
        Sven Eckelmann <sven@narfation.org>,
        Simon Wunderlich <sw@simonwunderlich.de>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 051/219] batman-adv: handle race condition for
 claims between gateways
Thread-Topic: [PATCH AUTOSEL for 4.9 051/219] batman-adv: handle race
 condition for claims between gateways
Thread-Index: AQHTsz7yzkqxCZGark+/717K2s0ryw==
Date: Sat, 3 Mar 2018 22:28:25 +0000
Message-ID: <20180303222716.26640-51-alexander.levin@microsoft.com>
References: <20180303222716.26640-1-alexander.levin@microsoft.com>
In-Reply-To: <20180303222716.26640-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MW2PR2101MB1036;7:Wgvv3qmBbdLjezW7c2AM6gLgfPWPF5H6xrmTVYFipLunmVgkAjkFUK3yE/8HfwDVSFezdVC+SYh/W1nWRqxUWbyrSDf3bklkVsZLZrQGVnubpT6xRe7eIAAlVx2VTxf66e1OKb8BmcAguL45GcXk8c92JfjVVp9+DyXG0NyGdbQQlrtLs/Vzybhs6CBlgWfBozq9UaxcW891pRVTd2xHkiX0bZawOg632Z/K/TViT39RhQ2ONaD9t5ZGWZivIfd3
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: df868126-5dee-4c19-1692-08d581569c6f
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(48565401081)(5600026)(4604075)(3008032)(2017052603307)(7193020);SRVR:MW2PR2101MB1036;
x-ms-traffictypediagnostic: MW2PR2101MB1036:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <MW2PR2101MB1036C12121B5161B240FE6C6FBC40@MW2PR2101MB1036.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231220)(944501244)(52105095)(3002001)(10201501046)(6055026)(61426038)(61427038)(6041288)(20161123562045)(20161123564045)(20161123558120)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:MW2PR2101MB1036;BCL:0;PCL:0;RULEID:;SRVR:MW2PR2101MB1036;
x-forefront-prvs: 0600F93FE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(366004)(39380400002)(346002)(376002)(39860400002)(199004)(189003)(10290500003)(81166006)(5660300001)(107886003)(8936002)(81156014)(3846002)(6506007)(2906002)(8676002)(3280700002)(59450400001)(72206003)(76176011)(4326008)(478600001)(6116002)(6486002)(53936002)(1076002)(68736007)(6512007)(102836004)(2501003)(66066001)(3660700001)(5250100002)(6436002)(105586002)(86612001)(36756003)(316002)(7736002)(97736004)(26005)(186003)(110136005)(305945005)(22452003)(86362001)(99286004)(6666003)(25786009)(106356001)(2900100001)(14454004)(54906003)(10090500001)(2950100002)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:MW2PR2101MB1036;H:MW2PR2101MB1034.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
x-microsoft-antispam-message-info: h3klCQqfyNW185BLQZf6jUVbmXYvuMqjJCz66f7hjJgdjJvOTZz0MLAZv33bQQsp6chjvah54LVWfmROUGbNi1MdfPyB3tMMHJNCJ0OHdz97Phy3ABr+b33i4iG+EA8FA5PZbHy6G6HQwyyx/+tGMRAqPFPEDTlqmfcdnwkkzQk=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: df868126-5dee-4c19-1692-08d581569c6f
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2018 22:28:25.5412
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB1036
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
index e7f690b571ea..5419b1214abd 100644
--- a/net/batman-adv/bridge_loop_avoidance.c
+++ b/net/batman-adv/bridge_loop_avoidance.c
@@ -1964,10 +1964,22 @@ bool batadv_bla_tx(struct batadv_priv *bat_priv, st=
ruct sk_buff *skb,
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
