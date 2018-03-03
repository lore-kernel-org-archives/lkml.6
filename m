Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1153505-1520116245-2-17487380234022331966
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
    t=1520116244; b=mBwaTn6vZ2GRnS7ehJmfYbfWyz8+NsMpHqB4iZb46CUo5fa
    QKeg0cXqAzm4nCAWCtdLtDw1HSVh/HxQldATto9pPXcj0JU3Y/0eEvd3hXzpC8pr
    ImtSdcuKI4fLkW5Ht9ZfnYUpQVKCXV6zXlEHPeNPv5AYoJn0XurSdv3HzCJvBHr9
    E9AnB4hl+bEVqvRJMB9Lx8p9JWjk8wBv0gHLHq4/7jtYB5CRCBwYu+NsM0o9Ds9E
    39rw+8De1Lsu1Dka3BsWafOssiIXkx7b41c+SHdgVxS+Dj8bc+dQux9UgcPuIQfE
    EO572UbdE7Gp563VOK7O9fMdO4a0nofnOdL5vsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520116244; bh=FTCpQa
    e4USts6KbWXB+gboXK4P2DlDrxbm1Htjzrp3s=; b=py9xxvw7GU+yGXWLnzr9Q9
    hdJFd9gPxrI4GqeeazB93iePucOZJojLLwcZqlT+4DKLv8NyOCIadkXW7N3rZNd2
    PEdOXTxwNcexdNYoovnF4Bixtk2v+vfbaQAJRXhTTJaXbx3Ckm1sGYKlCjITj9rp
    mWlYZCdCOkID6E9BSC8o/DSiF/eXJQhWtH8fwbYapLX7w5swUKDU703iR17Bs9kZ
    ym3bKV2n5CdXMTiro4bL/AEU2M27hYQeO6o6x+qSMgwWyhXnrLOhackHtOE/aiss
    P2VVhlyI+5+OSvTGuoAoWCxmNrMDg/gkSecgylUpqw1uIyuMOlGun8eyIpR4CdWA
    ==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=FF9soTw9 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=FF9soTw9 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933058AbeCCWaR (ORCPT <rfc822;greg@kroah.com>);
        Sat, 3 Mar 2018 17:30:17 -0500
Received: from mail-bn3nam01on0135.outbound.protection.outlook.com ([104.47.33.135]:45024
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932498AbeCCWaM (ORCPT <rfc822;stable@vger.kernel.org>);
        Sat, 3 Mar 2018 17:30:12 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Michael Chan <michael.chan@broadcom.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.14 57/84] bnxt_en: Don't print "Link speed -1 no
 longer supported" messages.
Thread-Topic: [PATCH AUTOSEL for 4.14 57/84] bnxt_en: Don't print "Link speed
 -1 no longer supported" messages.
Thread-Index: AQHTsz6vVPCgkxyhTEKQkVVg7dQ4hA==
Date: Sat, 3 Mar 2018 22:26:33 +0000
Message-ID: <20180303222518.26271-57-alexander.levin@microsoft.com>
References: <20180303222518.26271-1-alexander.levin@microsoft.com>
In-Reply-To: <20180303222518.26271-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MW2PR2101MB1065;6:Q6g3dHWZTR7k2vOU4OE323oNOHE/KWu8z2o4YcPpw0QPn3q6rY703qQepAf5XY1MCLvRAz7HORv7qUV+jLEqL3kg76B5CMQNwCbZZ0yhKk0QJOwM87MjQXjTAjAga+gYlJCIvrUMIIR2UDPWkRZHzgounOv9s8F353z0TnlPsSZPnpaGs4tmOMezPoNCM4uKQl2ImoflyYOEGic2pYMfvDv5ssfWi7mo4J7u3Oc6Md5nMZaRvuSYvO/kbZ0y7ty1H8mA8YqlZ3T5A0pwH37/8jeSv4o5DImj+tEXkNCAHsdk4GPm5Gt3FbtnxpJZyweZY03DSyOOKjA+mXylNUi3fpT3bPKM7OYmXUrPZsQx4HYoz4+8wNtuHSG4zs8he7I4;5:hjahlmEHqgQ0Y/8X24Owcn1je0FDuLOjz4H2jTEXIX0N96a17Qo0Y+VAogsfVVj3UtyqQS2vje8VbsOlnj1GbJzmUI89Li/AWKNRwweGBgKA2Qpd4b5E2HMjuMieaYy0xO6GdtsNDWFYaAzM/5eJUWFqrnluoNOZ3Anqs1xytAc=;24:0X7w4J/8XODr0vKfKkdwNPqwMitOEsK8wlKZc/IydGXpN3y+KVT3n5PSwYMSyqZKsP/Jaz3BCoZyI0uFFcnMYOfNFl7Yly1/LSInLMt3F/4=;7:ri5kD1WsRRfZu1Kp2z6yh3x+3T39x96+X7JFf9zVagUW2XkMgRS2Bk+9P5oNQZHVBZO6pK2sPcYVrDE4Abvgf2bZ3FnX4bcn7Fc01nYxZBHAWmcC2v7YA9V063x8coZuI0haTP7KZVzAlLH0QQTnAzeH9Mvxr1aRRL7+0ZA5ieEjZnM+7sanEemQVNHk0R9GKuAF6UshV3EdNb1JlEC7ggXVvNlWU83/3DrKmILZUNkBLbKjv42/8NqagFH8bMVV
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 38fdd30f-c6fb-4c67-2e8a-08d5815651d3
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(48565401081)(5600026)(4604075)(3008032)(2017052603307)(7193020);SRVR:MW2PR2101MB1065;
x-ms-traffictypediagnostic: MW2PR2101MB1065:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <MW2PR2101MB106564C66855212521129CF4FBC40@MW2PR2101MB1065.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(5005006)(8121501046)(3002001)(10201501046)(93006095)(93001095)(3231220)(944501244)(52105095)(6055026)(61426038)(61427038)(6041288)(20161123558120)(20161123564045)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:MW2PR2101MB1065;BCL:0;PCL:0;RULEID:;SRVR:MW2PR2101MB1065;
x-forefront-prvs: 0600F93FE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(346002)(376002)(396003)(39380400002)(39860400002)(189003)(199004)(6506007)(22452003)(54906003)(25786009)(6666003)(186003)(2950100002)(102836004)(5250100002)(2501003)(110136005)(97736004)(316002)(2900100001)(36756003)(76176011)(6436002)(59450400001)(6486002)(26005)(4326008)(99286004)(68736007)(6512007)(6116002)(10090500001)(106356001)(105586002)(478600001)(66066001)(107886003)(3660700001)(305945005)(86612001)(14454004)(81166006)(7736002)(86362001)(575784001)(1076002)(15650500001)(72206003)(2906002)(10290500003)(8676002)(8936002)(81156014)(3846002)(5660300001)(3280700002)(53936002)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:MW2PR2101MB1065;H:MW2PR2101MB1034.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
x-microsoft-antispam-message-info: LCu8avKjdTFemVdTtBYqlMmSQcH0MMFZhlStzNKAjk494t/POdlST2B3tH0azFoOcMfdvaDpMF/6KRdz1V8UcyjLcLOgctVKXGQ+ILHByjkIahqLfkyWLZl2We7YMkMWfimMqLMFG6GKCOOP5TIoieRWJpgP4gCdpDOWThbtDds=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 38fdd30f-c6fb-4c67-2e8a-08d5815651d3
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2018 22:26:33.2130
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB1065
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
index b66689a6eac0..807cf75f0a98 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -1698,12 +1698,16 @@ static int bnxt_async_event_process(struct bnxt *bp=
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
