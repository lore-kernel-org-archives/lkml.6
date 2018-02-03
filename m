Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1483324-1517681214-2-16597528293900990418
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
    t=1517681213; b=Gshue/trVLtI45idpkblTehTzs/HFtfcNW1z2mAbvFLmbie
    PjoZYBn661k0rsJvO/7xmKGBiZQLl8Kt2pvXoFLJTPHTbWJ5xeURQtNf1ZC7LmdO
    jZpE7BFHPde0j1AFWZy3zl9/duFq3b+6DLr0b6ciDeW2NlkRozwR648dC4rqm/H6
    YWBlCFqAtjxnsFF2hqbsr3ISAub0YngyIYOGBVQPeo9vdnjLdkT1eLvtnz+XD42r
    6dvsWf2LtbTZCWhXOdgdHPFbw47S2v9pYOsDgzROZ4s8eAirxpzGJL6ay8PSgBMK
    hJckBgGY5USMma/fH3JQ/vPv1ffRIPrRjOgY7gg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1517681213; bh=A7RSqe
    1pqCkRBbLJ50mqBmDJJuO7ut9TPm+BI+ZzNFs=; b=c8gTQE7gKEmsyVjR7e/FQO
    LhG2d/3FpZa06LDw5fwrwsO+aG5hJCUmd/3a6Y8f+do35Ac/+rdEGeEmNjbJcMdH
    CdkmRfVZPZWL49TN82A5Nb+Vk/b6QtiERcG6LlAw5L0YXP+byohpuKxVsmn/Ymz3
    wCqOeWqXuRVb1lL5N1Dw7ulkLYOmHMzVK54tHE6yPdSLHsghsfiIPyaaV+drgvjj
    dO/raQ60YTP3trntoLiiAg4sORIXCCWL/ymNIOlLDKy2v2+Kf+VeG1L2xW1rqfw+
    N5i0gjebb0xFjksQchpNSnw0G7++9YsuJqmcIcaY9+jXf0589rUwM3hcQuIDHz7w
    ==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=o/LkQW1+ x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=o/LkQW1+ x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753499AbeBCSGu (ORCPT <rfc822;greg@kroah.com>);
        Sat, 3 Feb 2018 13:06:50 -0500
Received: from mail-bl2nam02on0113.outbound.protection.outlook.com ([104.47.38.113]:13185
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753394AbeBCSFh (ORCPT <rfc822;stable@vger.kernel.org>);
        Sat, 3 Feb 2018 13:05:37 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Albert Hsieh <wen.hsieh@broadcom.com>,
        Richard Weinberger <richard@nod.at>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 05/52] mtd: nand: brcmnand: Zero bitflip is
 not an error
Thread-Topic: [PATCH AUTOSEL for 4.9 05/52] mtd: nand: brcmnand: Zero bitflip
 is not an error
Thread-Index: AQHTnRlOM4y63tw5fUGULT/RIaTFcA==
Date: Sat, 3 Feb 2018 18:03:35 +0000
Message-ID: <20180203180303.8490-5-alexander.levin@microsoft.com>
References: <20180203180303.8490-1-alexander.levin@microsoft.com>
In-Reply-To: <20180203180303.8490-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BL0PR2101MB0993;6:992hErGHpBRWnP8fpqh6GKm4bqRgGMfenjJXUOSuj1Z04dgNMXiHXK9GAEAiPJb1vFB24VUpQwN4NQdZyeq6oTTrbbzTU4LStQF9yJooz7y4x3p5pPyALfSQAe656xRsLAHB9wHBbzuxc2FcGR6rsP8pKXDNVDvdaHFJYTqfMNtnVuSPJdV2ApKCTBEe79FdgVnZ3o55CR5ZlERoGCFM9scqRWwXMsnXiYpFjYPtDtDPtKa0Usx8hUfqPL59pvEeHNT84wORmHAG1+x7w+lwVMCTzXAqJNqQLYhV7NZMOYKYNOf7wh/yBT1qjv93NhL6iJ1XF/DGkWYAwfZ5sUunqxVnW9fdVWcZCgcMz/VnlC6LsWxZ0qpPQubymOLq7ZI1;5:yxMCUGgfNf4abz9cU61hZzk+IIGI/jEpccpVL8rWdqagDy2aIigGzpgx41+iQ9sQop09hMJVlMsHfSfUtbI/snzRCuu8Nj9XaNmFAAtNr8o6DFenMKVBhPEsHK07HJBaqX6It44897ctQQTG/NCnEBSPifaZKE8w077s3ecM7EU=;24:UG3iQBpkt9GwGT1KwZbsF5nj+X2c8B94IkapDXj7BMZgPUDUtL7ShdDIFM/+ut9ab30IUCwd3rQgOGfIwdw/bYiLpXfEZsjju63FseU7FFw=;7:vGw3hFopQfZpNi4925x9kXlcRPzrpcv+nMKsrRbQ6HmEM8A3BVPHf2WqwZh2i/+MEu7cFu+AHCqKLb0/gL3mbplEJw7dz8a3cKtiPQ29F4C7iKnyUC49Tpv6OEfQ/zMRFrPPpI0cDWCzb9EEeWSikmVdfuoRoktClzCt5UYFeFAC8IkU2ptmbXmhXtVdc8EqURnu7xwteY7KQP+QUX+x9VhwYPfF5ItHUA0gnBJLya3d/U+6jg52qT3w3fgEl6jl
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 9c377425-22aa-410d-9848-08d56b3071a0
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(4604075)(3008032)(2017052603307)(7193020);SRVR:BL0PR2101MB0993;
x-ms-traffictypediagnostic: BL0PR2101MB0993:
x-microsoft-antispam-prvs: <BL0PR2101MB099386B98C9573F930BC4093FBF80@BL0PR2101MB0993.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(58145275503218);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(61425038)(6040501)(2401047)(5005006)(8121501046)(3002001)(10201501046)(3231101)(2400082)(944501161)(93006095)(93001095)(6055026)(61426038)(61427038)(6041288)(20161123558120)(20161123560045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(6072148)(201708071742011);SRVR:BL0PR2101MB0993;BCL:0;PCL:0;RULEID:;SRVR:BL0PR2101MB0993;
x-forefront-prvs: 05724A8921
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(39380400002)(39860400002)(376002)(366004)(396003)(189003)(199004)(6436002)(186003)(3660700001)(8936002)(105586002)(2906002)(6346003)(6116002)(3280700002)(3846002)(97736004)(6486002)(1076002)(2950100002)(81156014)(86362001)(76176011)(102836004)(2501003)(5250100002)(26005)(68736007)(10090500001)(81166006)(8676002)(59450400001)(53936002)(5660300001)(22452003)(305945005)(107886003)(7736002)(4326008)(86612001)(36756003)(99286004)(316002)(6512007)(10290500003)(72206003)(6506007)(14454004)(478600001)(25786009)(106356001)(2900100001)(54906003)(110136005)(66066001)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:BL0PR2101MB0993;H:BL0PR2101MB1027.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-message-info: fWAXx3YHoQ/Tj46m3HtkhvOFmO/POYE2QP4RlFw5DDh8xLqM3pWPTiKDu/tSnla8IWgIUr/QMot7mu3NVO3UDw==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c377425-22aa-410d-9848-08d56b3071a0
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Feb 2018 18:03:35.0495
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR2101MB0993
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
index d9fab2222eb3..8bb2259550ae 100644
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
