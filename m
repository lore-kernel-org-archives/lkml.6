Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1352585-1520123726-2-7729207453413930314
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
    t=1520123725; b=H5h2PUO4EzoJrZPEZYCtI4Iamd9zaW84waEeor5jSlG2mig
    pmwx2ERjcb+ZyWJYvQHiJmVVXnrQWbRbEE65xZpgD9Q+BLrgL7s1XwjNMaMHj6mt
    Gx+emmEgXWJDGVTOxA5YQDsnZKQ2faHQJyijVR6squ7UO6RboRhoenlsj6tonNCo
    wEkq52vrjTaMJtOj1iuwo94t04J/diUNQxXvRnmZ3wRGZ6geaM+ixRhYh53cQP9Y
    x7Ap0eHhCCts5xorvvoq7nxBe+utSJR6CbUoWuQWs7ICdF3y/xjkai77gqtfdOcT
    E0bpZuB2kEdGwPwjgVdTEzYiKg0dRLml5dkNdtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520123725; bh=zMPC0+
    YbF03ZpFxfFEpI3etLW4jDJITEvDRuI5LmzIY=; b=HEaXe/FNNou/EY7wbPQmja
    VCdsvi+/rjnEUsNl3buUU4ry4RV7SjjZ4+mQ1Aa38p2sIWI3eti60GTUvnK21D1N
    QiZnLh51MREUTF/Df1qlT/oU+hyTJe+rc7WFqCQExnu6LJNjgwnmH5Qr//GFmt6g
    BBbfdPiiIkvWLLj+GAF/3Ep64F762wf2qJhxhm4hzxne/M5kiRG8j4HD7xLt7Vk7
    gJ1+oObxdU6MOmWkWvKSYVMLKtSreyTN9U/gFr5UNKKBnJnLZZiStWCjuR6q6x7p
    3gIdQk8yBtMhqPfOu0h9QUVE6sSc9KlTRClAePLaM6RTXL40CIoQdvIzDNfrGZog
    ==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=lzVywSuO x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=lzVywSuO x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932896AbeCCW1M (ORCPT <rfc822;greg@kroah.com>);
        Sat, 3 Mar 2018 17:27:12 -0500
Received: from mail-by2nam01on0137.outbound.protection.outlook.com ([104.47.34.137]:52173
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932850AbeCCW1E (ORCPT <rfc822;stable@vger.kernel.org>);
        Sat, 3 Mar 2018 17:27:04 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Michael Chan <michael.chan@broadcom.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.15 073/102] bnxt_en: Don't print "Link speed -1
 no longer supported" messages.
Thread-Topic: [PATCH AUTOSEL for 4.15 073/102] bnxt_en: Don't print "Link
 speed -1 no longer supported" messages.
Thread-Index: AQHTsz5yeyD0GPf/EUCBSyWraADBcw==
Date: Sat, 3 Mar 2018 22:24:51 +0000
Message-ID: <20180303222318.26006-73-alexander.levin@microsoft.com>
References: <20180303222318.26006-1-alexander.levin@microsoft.com>
In-Reply-To: <20180303222318.26006-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MW2SPR01MB06;6:uczFrCyRsF5Stq8eo6rpGPoOPunl+p/lpC/F/qn66IQ2WKfmk2p6yKyYOrtKWgoGWLMfcYFZL5V42bSgZno++8p8+GAeW32uaXnTYLDunFg8RW9uanPtWcKHPhSwnWafKHzPtzQbbCyfsi3FVdreTzQg9i9N5MzNtEl5/2fxR6qekBlBjkNTB1iPHpuP1DJVO6TYAph4EFlA16xl1bW37VjZVVGDNWGR3/7PaXm8yrnRhVgdTdQkF1oBDeBKZQR92Ial+fUzEIvaFxtBAxz5UXuGYVnMviCc/24aLZ7o62cVoVrOokvLya8hF7SDKfL+X3Kh94UsUo08g8KPBTNObXyfd9ClywPm/uylt28/WV0Ljoesxpx39zXNRxR204vX;5:lLjX5qEVLCW8ghoe/x6ZMqtkN768AORb+XCLm5UGQYxOxU/Lm29VKGcxErvk/GB3O+6n4QVVz2bAyP2ik0evip3lDJ1MUxlTnT08qBd0EpBUqUK4RbVm5OFm0ZvFN4EngvFgZdR8O3P4LnULHfmhLI55X1Y4QGHYWqRiPo8guYA=;24:81I5sW+Gu8MCVuVFZfkkjzZhOTARefKufKNph9GLcW6qFevhRis5VMxTYFoIE8MRBIAikKdW9+Bk3pdj2ouPwf7eViedCOxvUtXXDW2wz/A=;7:V6zaBv431JMUByt/SrCdEe4cTWNJ3DDAqEJCsnJuuJ2tE6SFTsypyGyhW0UB4VViUnCUQAZAeNRH5AeDCEvfyIi7JhNA313vUHMH9ClICRvU83FCXnrw2PZNUi6C8i/LdjVIU3mSYbiZPUphJfRkYmGpKSZw6RFBbVlHfkZOwQ5P0IYqAbGgoqXpxcp2Zaz7bwFM3nl7bjg7+ES4OaslKNdBqZB2iNTiPHqgh8tNKDzuuJMQtUyeSCGBD1zohnxk
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 8128c0ab-678b-420c-8921-08d58155e1d0
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(48565401081)(5600026)(4604075)(3008032)(2017052603307)(7193020);SRVR:MW2SPR01MB06;
x-ms-traffictypediagnostic: MW2SPR01MB06:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <MW2SPR01MB06C156B4A1B173D685EED0FBC40@MW2SPR01MB06.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(5005006)(8121501046)(3002001)(10201501046)(93006095)(93001095)(3231220)(944501244)(52105095)(6055026)(61426038)(61427038)(6041288)(20161123562045)(20161123560045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(6072148)(201708071742011);SRVR:MW2SPR01MB06;BCL:0;PCL:0;RULEID:;SRVR:MW2SPR01MB06;
x-forefront-prvs: 0600F93FE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(366004)(39380400002)(396003)(346002)(39860400002)(189003)(199004)(68736007)(2900100001)(97736004)(107886003)(36756003)(1076002)(76176011)(86612001)(6666003)(6116002)(99286004)(22452003)(10090500001)(3280700002)(105586002)(2950100002)(3846002)(26005)(2501003)(6506007)(4326008)(305945005)(25786009)(7736002)(66066001)(54906003)(86362001)(8936002)(72206003)(3660700001)(6512007)(110136005)(15650500001)(14454004)(5660300001)(5250100002)(478600001)(102836004)(106356001)(8676002)(81166006)(6486002)(186003)(316002)(10290500003)(53936002)(6436002)(59450400001)(2906002)(81156014)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:MW2SPR01MB06;H:MW2PR2101MB1034.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
x-microsoft-antispam-message-info: G/joE0WPcKU8I9BH2m4Hteh8sQacQ0i1mI0qq6U313fDoy94J7VL/SDWJhyeKz8efzIqlg3b+WBMdvB2r/iWchX7hyzCkhETdidQZ2pbSCYiD/96xVS8RmSwUf68DGi7j94A3kP1GmtT0+qOdNwLAXs+n4PbuVPGYG4sbj7TYJs=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8128c0ab-678b-420c-8921-08d58155e1d0
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2018 22:24:51.8222
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2SPR01MB06
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Michael Chan <michael.chan@broadcom.com>

[ Upstream commit a8168b6cee6e9334dfebb4b9108e8d73794f6088 ]

On some dual port NICs, the 2 ports have to be configured with compatible
link speeds.  Under some conditions, a port's configured speed may no
longer be supported.  The firmware will send a message to the driver
when this happens.

Improve this logic that prints out the warning by only printing it if
we can determine the link speed that is no longer supported.  If the
speed is unknown or it is in autoneg mode, skip the warning message.

Reported-by: Thomas Bogendoerfer <tbogendoerfer@suse.de>
Signed-off-by: Michael Chan <michael.chan@broadcom.com>
Tested-by: Thomas Bogendoerfer <tbogendoerfer@suse.de>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethern=
et/broadcom/bnxt/bnxt.c
index 61ca4eb7c6fa..6a9ee65099a6 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -1706,12 +1706,16 @@ static int bnxt_async_event_process(struct bnxt *bp=
,
=20
 		if (BNXT_VF(bp))
 			goto async_event_process_exit;
-		if (data1 & 0x20000) {
+
+		/* print unsupported speed warning in forced speed mode only */
+		if (!(link_info->autoneg & BNXT_AUTONEG_SPEED) &&
+		    (data1 & 0x20000)) {
 			u16 fw_speed =3D link_info->force_link_speed;
 			u32 speed =3D bnxt_fw_to_ethtool_speed(fw_speed);
=20
-			netdev_warn(bp->dev, "Link speed %d no longer supported\n",
-				    speed);
+			if (speed !=3D SPEED_UNKNOWN)
+				netdev_warn(bp->dev, "Link speed %d no longer supported\n",
+					    speed);
 		}
 		set_bit(BNXT_LINK_SPEED_CHNG_SP_EVENT, &bp->sp_event);
 		/* fall thru */
--=20
2.14.1
