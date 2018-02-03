Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1639138-1517683917-2-15037907834025303412
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1517683916; b=wxoqSdHTSrrGeRdKqkA2AvEMcm/Fmfwkhyh8YpEf7/erENU
    2AQO4Oqvev7ky8+hYudQ2xLdkS/tUP93mus8WrarcgZPUa3+THn9Feg60aDnCspb
    i+IGAbJs4C2HPxN0Xv5wcJ8YfrvYGtuwqmn7VhlWthVOM1uuWiSkwsjb36QF/E2K
    bnxCkDvgbOJmz4nyWTSJyh7lbECz1R78MFrt7og9E0XBboqmddux59AIWXnyVg4O
    HLarK27p49VOPQ/ZuH/9q2cMZ/ggnemHb99ozkuborsqiwbK+BSf52azHVFQkKK5
    VFtU+siSTwCNW31qlbWGHmn9sFbHy/7T9OOfHGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1517683916; bh=2L7eWA
    HPIZH3qHV6q+ReekqBXiIOjT4iG6MI4JglfiA=; b=GYrJR9HlAID+GP9/lpN3T3
    3XbvHsU2MpxcRoDil8AsPjUJgleoPxwjzNJcYxJzOvMvUhSQoQRaB0H7mG0on8U9
    6676CeylwXTQsQi/Wxd2ug77PMH95HhUB5IBEQ8OPfDlKXALdJkLsTZAp/aYjEXw
    nl14rtI+391QHKkCucNf5vhj5vdTpHDzmlMfjrjhItR01JM/CUclP5poZoXekoQW
    GaB65odtD++Ao5+oyls0YDynjR2jS/2xqe7PWxvtmkUuQ2o0Luga09rTSURDvzJN
    hL0/990TOO3m7VV0oBxPyXwxn/lrAUQAkRg8IKTBSQOOJB8cCz2ypYLhZW4gdmAg
    ==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=e8pQSkqm x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=e8pQSkqm x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754003AbeBCSvv (ORCPT <rfc822;greg@kroah.com>);
        Sat, 3 Feb 2018 13:51:51 -0500
Received: from mail-co1nam03on0122.outbound.protection.outlook.com ([104.47.40.122]:24267
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752701AbeBCSBM (ORCPT <rfc822;stable@vger.kernel.org>);
        Sat, 3 Feb 2018 13:01:12 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Albert Hsieh <wen.hsieh@broadcom.com>,
        Richard Weinberger <richard@nod.at>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.14 014/110] mtd: nand: brcmnand: Zero bitflip is
 not an error
Thread-Topic: [PATCH AUTOSEL for 4.14 014/110] mtd: nand: brcmnand: Zero
 bitflip is not an error
Thread-Index: AQHTnRji0i6T04ZYnE+SRgL4oNGqzg==
Date: Sat, 3 Feb 2018 18:00:33 +0000
Message-ID: <20180203180015.29073-14-alexander.levin@microsoft.com>
References: <20180203180015.29073-1-alexander.levin@microsoft.com>
In-Reply-To: <20180203180015.29073-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BL0PR2101MB1043;6:wR6ZYK+RlpIpjidrrkdNTM+sOsusjTtIrZhQ0e77Dh3vejsVPyACZ2TnrWoKHUoE4SR/a/pppR9Gadzx1jgPI62xTRA8MtB3cPPcv0mkyjl8VHIjPu/XhjrKzGZe4+/dg74XePj8hz4WgL5+EbT/KBLIgFtb7gLP0ru8LFETgkX0mZZBBWtBOy3oL32VLXU2Cu23rNvizAddDWMunPeJLkCkUo8jkgqe8WuMbOUV/VCShNYMdrUWuQfgYcZ9HgvxswQrSvua0HELTcF7WsJbsmWA9RmiqxRFo/fybPbyPutXR8twL3gY/2Ufh+7OXVtXgRjda0tklwarOFMvr2NCqIl5O/8udpO/drGDinBxXxUlpPIB/+uOkUFym5DlU1aZ;5:NjsYapUgVjIUJY+1OIRdc8kbvgXWAFJeGAHqKj8M929ZEmGP9eMiNezYfpFWed8JHP800SE31HKT46JZphD1iWBTu35TQtSw0/31TwyBxd9kwbXiitqTiEessNYe1Fmp/RCv4cg4uq8Iy+qWUijDyTpAbLgD0gYh5JFUrUh5LCY=;24:FjwT+9ZWm1EoynGa/rH/XMQFL88f9BfZdfYiUngmfO6aTKKuyBFjweMXmYqUoO0Bs6eNVWpsivYz4m5W0TUZIqPCWkvQrT0wNmzp03OpWao=;7:TMYXdicO9OvjfrSfaiuCvyDjTkeLZoe8WS551F8SKTDj4VL9Ja0bY4OWUAcvoddTUHa2U3SyQf1FawBl+38vwb4NrOkyvm9aLWWFrVLIWmSm8TL+pF/4GM56FdRkKEgWfE+FlKXUAGzzoSohGdv69Fj0hwNSPCcJjk0DVato6QvHqvoYrHwqf7DiVUeXQu4ixzLRFenMCz5zbTj66QZOIQyD+j2Q9kkQJkatQgPyQwc5o4ZsAbzyd3760x+hVLdP
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 47c8b628-713b-4d43-7c56-08d56b3006b1
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(4604075)(3008032)(2017052603307)(7193020);SRVR:BL0PR2101MB1043;
x-ms-traffictypediagnostic: BL0PR2101MB1043:
x-microsoft-antispam-prvs: <BL0PR2101MB10430D7C6DCE217B548C994CFBF80@BL0PR2101MB1043.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(58145275503218);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(61425038)(6040501)(2401047)(5005006)(8121501046)(3231101)(2400082)(944501161)(93006095)(93001095)(3002001)(10201501046)(6055026)(61426038)(61427038)(6041288)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123558120)(20161123562045)(20161123564045)(6072148)(201708071742011);SRVR:BL0PR2101MB1043;BCL:0;PCL:0;RULEID:;SRVR:BL0PR2101MB1043;
x-forefront-prvs: 05724A8921
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39380400002)(376002)(39860400002)(366004)(346002)(396003)(189003)(199004)(59450400001)(10290500003)(186003)(6486002)(14454004)(1076002)(102836004)(6506007)(76176011)(26005)(6346003)(66066001)(10090500001)(5250100002)(36756003)(6512007)(2501003)(110136005)(99286004)(54906003)(478600001)(53936002)(72206003)(6436002)(316002)(305945005)(7736002)(2950100002)(2906002)(5660300001)(4326008)(106356001)(575784001)(86362001)(97736004)(25786009)(22452003)(2900100001)(3846002)(107886003)(8676002)(8936002)(6116002)(3280700002)(105586002)(81156014)(81166006)(3660700001)(86612001)(68736007)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:BL0PR2101MB1043;H:BL0PR2101MB1027.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-message-info: dDNMxE4Y74/g9xu0tIL7UyeKxpygfjgkvEVt+3/uhE3+5aw7q0ii9faL8LcZBsrKaG7fV5VgYCfzt0C21An/bQ==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 47c8b628-713b-4d43-7c56-08d56b3006b1
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Feb 2018 18:00:33.2377
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR2101MB1043
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Albert Hsieh <wen.hsieh@broadcom.com>

[ Upstream commit e44b9a9c135727f3410e029910275f40681dc8bc ]

A negative return value of brcmstb_nand_verify_erased_page() indicates a
real bitflip error of an erased page, and other return values (>=3D 0) show
the corrected bitflip number. Zero return value means no bitflip, but the
current driver code treats it as an error, and eventually leads to
falsely reported ECC error.

Fixes: 02b88eea9f9c ("mtd: brcmnand: Add check for erased page bitflip")
Signed-off-by: Albert Hsieh <wen.hsieh@broadcom.com>
Acked-by: Boris Brezillon <boris.brezillon@free-electrons.com>
Signed-off-by: Richard Weinberger <richard@nod.at>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/mtd/nand/brcmnand/brcmnand.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mtd/nand/brcmnand/brcmnand.c b/drivers/mtd/nand/brcmna=
nd/brcmnand.c
index e0eb51d8c012..dd56a671ea42 100644
--- a/drivers/mtd/nand/brcmnand/brcmnand.c
+++ b/drivers/mtd/nand/brcmnand/brcmnand.c
@@ -1763,7 +1763,7 @@ try_dmaread:
 			err =3D brcmstb_nand_verify_erased_page(mtd, chip, buf,
 							      addr);
 			/* erased page bitflips corrected */
-			if (err > 0)
+			if (err >=3D 0)
 				return err;
 		}
=20
--=20
2.11.0
