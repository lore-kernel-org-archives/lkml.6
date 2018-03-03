Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1254417-1520121079-2-6073191524482050689
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
    t=1520121078; b=jy3/7F3NePEVNBj/yE+5xFigysc8mIL/aJHUvoH8gwaS/lv
    T5DW34L93LkUvtYtX8WQ8lX9KJWsU582W+76ybM4KdQ4+sEtrui5wJf1RUM46xed
    XZdwTFTH5eqC2hQaykJVBzgEBd67DqdlQ/DcBQfGWFckZIHiXoaO+7o7r7xN9b3s
    msTAMXG3QnPh3JzdUi9vNc1FI8PUIICTs3AmTkxlWvSsfmKenJaxicFhrmgic3MA
    hHzGdGKrfqY6ptNNu8phTaIxVlCM8hYNktsAdCydbdl/9oBNubYsFOtlGToaJa4s
    EoR4cWD4IpMjbWxEkuSLcFBe/FxML/jSOIOzczA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520121078; bh=UAxC2w
    MRsKEfh6SxJBYPIQZOosWW7ACUpkOIZaOx4vA=; b=qIu7rzrPT/gTRv7m1GwLw1
    vo/eFe6X2jkzhurEXu2NjJ8tmbH8vCUh6udEDI0+k3DRPMTzLy8NcwncpgcD9mP9
    LNqhZevtbdfrLA731t/VsJ6SOy6gtTCASHilVLN4KNKFOqQ3QMATO+W2oIldhHT7
    ZTHNQcD98Y1qPcc00jh6kHiAp2GanvcX1Wckw3PXgOPXaET3r2CAngcpns2YOk0J
    G/UI1xDOUNpmu8+ukGwxuyquAIwViQGx+Bwq0uh0NUgfQi4zSJ0H7S7JrjQ+2QA5
    DiPc9eKQRsE4VyuEdkjaVRjN1H7ohqIyZ5RE+ELvGO8JkG785ShMy329gZz2gemw
    ==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=nfOAwSeU x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=nfOAwSeU x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933988AbeCCWdL (ORCPT <rfc822;greg@kroah.com>);
        Sat, 3 Mar 2018 17:33:11 -0500
Received: from mail-by2nam01on0133.outbound.protection.outlook.com ([104.47.34.133]:49841
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S933742AbeCCWdI (ORCPT <rfc822;stable@vger.kernel.org>);
        Sat, 3 Mar 2018 17:33:08 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Takashi Sakamoto <o-takashi@sakamocchi.jp>,
        Takashi Iwai <tiwai@suse.de>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 078/219] ALSA: firewire-lib: add a quirk of
 packet without valid EOH in CIP format
Thread-Topic: [PATCH AUTOSEL for 4.9 078/219] ALSA: firewire-lib: add a quirk
 of packet without valid EOH in CIP format
Thread-Index: AQHTsz77IDXaeTCDwUGoERaPP17iEA==
Date: Sat, 3 Mar 2018 22:28:41 +0000
Message-ID: <20180303222716.26640-78-alexander.levin@microsoft.com>
References: <20180303222716.26640-1-alexander.levin@microsoft.com>
In-Reply-To: <20180303222716.26640-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MW2PR2101MB1097;7:h6EqjKZgDcpqdpVN3oz3izsy1g20DCC8JarmM6oj27WDxIsyqhies5qS7Oj+Bih6ytlnBU9FP5TeG4VnVS8RugscyYWakv0rp4UmTDzKpGo7N395XZmOzBxvXSxSMEtP+jT7toyKImQlxU6ILgDA0l3EwXVHbPks/5Bu7xR9FjyBuLdOjPuz+LkB3ZWKoN2ezgVAGfbWaA10V+xE9CmHqG4X6nOdlMyJYobMglEcljoxALDaaLOZB3i+JlN9r2PD
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 524a3408-38cf-44ae-4e95-08d58156bc1e
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(48565401081)(5600026)(4604075)(3008032)(2017052603307)(7193020);SRVR:MW2PR2101MB1097;
x-ms-traffictypediagnostic: MW2PR2101MB1097:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <MW2PR2101MB1097D8BBD9F859CCC95EE427FBC40@MW2PR2101MB1097.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(5005006)(8121501046)(10201501046)(3002001)(3231220)(944501244)(52105095)(93006095)(93001095)(6055026)(61426038)(61427038)(6041288)(20161123560045)(20161123558120)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(6072148)(201708071742011);SRVR:MW2PR2101MB1097;BCL:0;PCL:0;RULEID:;SRVR:MW2PR2101MB1097;
x-forefront-prvs: 0600F93FE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(366004)(39380400002)(396003)(39860400002)(346002)(189003)(199004)(305945005)(105586002)(36756003)(3660700001)(86362001)(575784001)(6666003)(66066001)(2900100001)(5660300001)(8676002)(10090500001)(81166006)(81156014)(8936002)(22452003)(10290500003)(2950100002)(4326008)(25786009)(5250100002)(2501003)(68736007)(7736002)(72206003)(14454004)(478600001)(186003)(110136005)(26005)(316002)(2906002)(97736004)(6512007)(99286004)(107886003)(54906003)(1076002)(6506007)(106356001)(53936002)(6116002)(3846002)(102836004)(6486002)(86612001)(3280700002)(6436002)(76176011)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:MW2PR2101MB1097;H:MW2PR2101MB1034.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
x-microsoft-antispam-message-info: R21CLvEbDYMCL7q+ZYk6R5a7U002YPnicBdLJWRzC+N6Ur9g/5qDSsPsZqnkD0TVeAMEtgIGAcoHcwHEBjFNCUmwnCLxtK3FKb1uHWrhHN/+nTP1VNB/uaeGibC/lI65BzqGGOGR6UKb1pMI2sfUWI5coPQxsFFz35Vt4apQWKs=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 524a3408-38cf-44ae-4e95-08d58156bc1e
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2018 22:28:41.3538
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB1097
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Takashi Sakamoto <o-takashi@sakamocchi.jp>

[ Upstream commit 2128f78f75a36a34dfef0e127273c2f820c5c904 ]

In IEC 61883-1, when two quadlets CIP header is used, the most significant
bit in second CIP header stands. However, packets from units with MOTU
protocol version 3 have a quirk without this flag. Current packet streaming
layer handles this as protocol error.

This commit adds a new enumeration constant for this quirk, to handle MOTU
protocol version 3.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 sound/firewire/amdtp-stream.c | 5 +++--
 sound/firewire/amdtp-stream.h | 3 +++
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/sound/firewire/amdtp-stream.c b/sound/firewire/amdtp-stream.c
index 9741757436be..d0ad61f563e2 100644
--- a/sound/firewire/amdtp-stream.c
+++ b/sound/firewire/amdtp-stream.c
@@ -471,8 +471,9 @@ static int handle_in_packet(struct amdtp_stream *s,
 	 * This module supports 'Two-quadlet CIP header with SYT field'.
 	 * For convenience, also check FMT field is AM824 or not.
 	 */
-	if (((cip_header[0] & CIP_EOH_MASK) =3D=3D CIP_EOH) ||
-	    ((cip_header[1] & CIP_EOH_MASK) !=3D CIP_EOH)) {
+	if ((((cip_header[0] & CIP_EOH_MASK) =3D=3D CIP_EOH) ||
+	     ((cip_header[1] & CIP_EOH_MASK) !=3D CIP_EOH)) &&
+	    (!(s->flags & CIP_HEADER_WITHOUT_EOH))) {
 		dev_info_ratelimited(&s->unit->device,
 				"Invalid CIP header for AMDTP: %08X:%08X\n",
 				cip_header[0], cip_header[1]);
diff --git a/sound/firewire/amdtp-stream.h b/sound/firewire/amdtp-stream.h
index f7c054bc9d92..8136bd20c8b1 100644
--- a/sound/firewire/amdtp-stream.h
+++ b/sound/firewire/amdtp-stream.h
@@ -29,6 +29,8 @@
  * @CIP_JUMBO_PAYLOAD: Only for in-stream. The number of data blocks in an
  *	packet is larger than IEC 61883-6 defines. Current implementation
  *	allows 5 times as large as IEC 61883-6 defines.
+ * @CIP_HEADER_WITHOUT_EOH: Only for in-stream. CIP Header doesn't include
+ *	valid EOH.
  */
 enum cip_flags {
 	CIP_NONBLOCKING		=3D 0x00,
@@ -39,6 +41,7 @@ enum cip_flags {
 	CIP_SKIP_DBC_ZERO_CHECK	=3D 0x10,
 	CIP_EMPTY_HAS_WRONG_DBC	=3D 0x20,
 	CIP_JUMBO_PAYLOAD	=3D 0x40,
+	CIP_HEADER_WITHOUT_EOH	=3D 0x80,
 };
=20
 /**
--=20
2.14.1
