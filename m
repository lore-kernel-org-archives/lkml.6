Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1211789-1520119404-2-11205074691899998321
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
    t=1520119404; b=M0q6fGkBW1k7MVGgXawuQVi8vHuPGJV3Z5WvCgCTHXD9h7I
    Bjx7xCAL8iniw7Vhr7t6Ozkw7jxzACFKWSADcnvY3ZbozI7D0dztQXeEC+RHve/t
    xL2jY181lqQdbSSxrhtE+YV7snJF2ExEoZpBMx5X28UkyENPEi+Uu5gIALjc/zsh
    qgrpUsS+lXR0Qy7Gbv7Wkz4nsGdKLaHFHyaFTus3SwF6/p19AEUGzjUCUhgdMaHI
    lnIWA8NKEf9Ir6uA1JPBnbhaoBEWGR2MygWk13/oz4XgaAHcDT+L18WFfjcCq8jS
    GZ5wzu74tLkTkExWiWkmcA82gBYf3hrDYAXXQjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520119404; bh=iH4jeU
    Nj73zmDx27IwSaJzBxyGk5HRiKwUog6rpjTSM=; b=rc4PC67paMcdspUkMlYpBr
    uBjiIQLHikzp7ubchWlRFRL7EOjZqI0FflHrt+olY6ZzyLM1ZcUcCCfjiAMbteud
    gZT1GT9wJhqmGwvaniV7hw/hhvUSgBWizUGL/kmznL4k7mcOo/npF7S9nicj/rt5
    gr/aYxiEQEpl+GZNC+RzQYZscXj117VTkfQt3ZrFOsCTtB435r/YiD1RVGDPldCC
    oz23K/WCMTE0l1d8OEwK/aoRyAdk8MTliM5QU/VTOph0hGMT0djOg/FxvWHxT1cZ
    pUjcoKZEvyvcgDPX2SyU/Bdv2kXzAkDWjDaHDbbsLYzmd8k+v0erpUAwOLfJ5MOw
    ==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=cM266bZv x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=cM266bZv x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934717AbeCCWhv (ORCPT <rfc822;greg@kroah.com>);
        Sat, 3 Mar 2018 17:37:51 -0500
Received: from mail-by2nam03on0124.outbound.protection.outlook.com ([104.47.42.124]:23840
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S934684AbeCCWhK (ORCPT <rfc822;stable@vger.kernel.org>);
        Sat, 3 Mar 2018 17:37:10 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Michael Chan <michael.chan@broadcom.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 203/219] bnxt_en: Don't print "Link speed -1
 no longer supported" messages.
Thread-Topic: [PATCH AUTOSEL for 4.9 203/219] bnxt_en: Don't print "Link speed
 -1 no longer supported" messages.
Thread-Index: AQHTsz8nlaLlwqrk20yl3rLv6BiPNA==
Date: Sat, 3 Mar 2018 22:29:54 +0000
Message-ID: <20180303222716.26640-203-alexander.levin@microsoft.com>
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
x-microsoft-exchange-diagnostics: 1;MW2PR2101MB0969;7:RvkFQAEMDXl2vKKu9J+f8w4NeIb7OBtNzTJMul9UyUQIrQHMPzF9K/z392k4M4gW6x8fZJY5p3ijgrCebJjQ18N3JYqzPftPWxoNQXpDDmjWRIIwHmUlb7Dsbb044xO3M1sY1RVWF+xV3nwEmxGn7zM9MAFUrgN2aPnUo25xWgZttPCZsEJE26Exoby9zyvMB/a8s4+SFIV3ja4CZF/eJj70+5aSSgVy4A7mtV1r17GBWj2rRaTpQq9DfsECUvG/
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 8d0ddc80-9148-4c3c-f298-08d581574409
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603307)(7193020);SRVR:MW2PR2101MB0969;
x-ms-traffictypediagnostic: MW2PR2101MB0969:
x-microsoft-antispam-prvs: <MW2PR2101MB09691691C5D11EA046A2EE07FBC40@MW2PR2101MB0969.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3231220)(944501244)(52105095)(3002001)(6055026)(61426038)(61427038)(6041288)(20161123562045)(20161123558120)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:MW2PR2101MB0969;BCL:0;PCL:0;RULEID:;SRVR:MW2PR2101MB0969;
x-forefront-prvs: 0600F93FE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(376002)(39380400002)(366004)(396003)(39860400002)(189003)(199004)(105586002)(5250100002)(53936002)(107886003)(36756003)(6436002)(4326008)(2501003)(6486002)(1076002)(2906002)(6512007)(2900100001)(54906003)(110136005)(305945005)(106356001)(7736002)(316002)(3280700002)(478600001)(14454004)(15650500001)(59450400001)(10290500003)(68736007)(2950100002)(72206003)(3660700001)(66066001)(3846002)(6116002)(102836004)(6506007)(5660300001)(10090500001)(25786009)(186003)(26005)(99286004)(22452003)(81166006)(76176011)(86362001)(81156014)(97736004)(86612001)(8676002)(8936002)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:MW2PR2101MB0969;H:MW2PR2101MB1034.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
x-microsoft-antispam-message-info: rOXgRH4ILZgalePgpPBYJgDzNeenpCRIZFlkPOvz4bofEcvomMNspsk9/KCcgB6gDy7r74IjZviTpp2nWSFTsc5NDUBEi5vxVFm6rDVwQReXeyr8a3C+5cDIEUIe9g03gsZxFPvpUOEH47gr2GSJf2N5CrUVOw/X14s6j+EzlXs=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d0ddc80-9148-4c3c-f298-08d581574409
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2018 22:29:54.5414
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB0969
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
index bbb3641eddcb..3aa993bbafd9 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -1498,12 +1498,16 @@ static int bnxt_async_event_process(struct bnxt *bp=
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
