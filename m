Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1153505-1520117680-2-1552780171478617035
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
    t=1520117679; b=YGEVHda1GGAN1/GTXHI3PZBqNE0E2L7s2KiEDruKdQqegGE
    qKn5Cncahb6iP87fPGmMSNrfakRC3N5TJ9YJQDcIqTDljQE4tAZAAz3Nz8t/Qxsu
    xfxJjuz6H77BTt24ir6wI6h8ONiWPtfjG/t4BfPVcLujKbB9otsjjO3zZvG18UNp
    21o57eNpivKCTmNRIohS+f8+bHHQWYRKUSIEhofLcq5uhyOcgqzydQepYExLx38R
    ZWMKdLXDLl/bgwa3pjOqOWFlIEsnxhLdo/GaltBr+FERviIOn/UGZ6lanu5HoTC0
    nd7ojYLYs3tgDBIULscglEmjCOOL+n4kdM/bmLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520117679; bh=9WBEYO
    FvPJ/tU8dhpMcTEYEKRO2hNP7DwtjwXiRXTmg=; b=mK6+QluQKryJ/K5UEghR5D
    KIZbZJGFXqoQoaZcqmMIPVWOFVh1kTFKwW0n8fri8SwRvdv4hplhL5TXZ1NU4RJ2
    cqljKJHJe76ufpMzTRqseZiVPhCip5QlQkeMbq5GHYoSV1ADJSooX05Cxchdt12U
    bDLhvLvFVp+ZSjysy5DYEbgcnKBG1RDba1XN885L+CusOp4uo6AS9VFz/E9dTIsy
    VzyBMd50+RtjyvsYs/VH6YgSINxNrW3j2jQ7kEDR+nkTinxgWtx/WBFXUfGo2sY8
    gGs9hEfAyou6b37R0GrVM1QQI+0F8E7XPmzsKDm6Q0+EhpmiDn0bBWlVV80FboHg
    ==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=hjuq9DXf x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=hjuq9DXf x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934186AbeCCWyY (ORCPT <rfc822;greg@kroah.com>);
        Sat, 3 Mar 2018 17:54:24 -0500
Received: from mail-by2nam01on0095.outbound.protection.outlook.com ([104.47.34.95]:48488
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S934409AbeCCWlD (ORCPT <rfc822;stable@vger.kernel.org>);
        Sat, 3 Mar 2018 17:41:03 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Rob Herring <robh@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 3.18 14/63] of: fix of_device_get_modalias
 returned length when truncating buffers
Thread-Topic: [PATCH AUTOSEL for 3.18 14/63] of: fix of_device_get_modalias
 returned length when truncating buffers
Thread-Index: AQHTsz+fzAgnDqwc0USYiZtYz0Dmgg==
Date: Sat, 3 Mar 2018 22:33:17 +0000
Message-ID: <20180303223228.27323-14-alexander.levin@microsoft.com>
References: <20180303223228.27323-1-alexander.levin@microsoft.com>
In-Reply-To: <20180303223228.27323-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MW2PR2101MB0940;7:1QzGh44WxJsaaaSloeKNzp6QXHaf1/L4KHU4Mw+rKvOwHaqtG6AllZbGOxJ8RpeFpgSG/LqIuql9RM9a27RxQGXt+3NSJRb+0MmgbA4XWx6/9cIX3cTbkdr7l11qtTMtm7MHF5tS686NH0Vtg0eqKpTNYIcYE4zodew8O1k2GgsZ77UXlK0MmpXRtgFT8+adDXqqze/F+LqLYNFTWyuFzXvyMtOmOg91EKQrsEWpAZK6reDPIW9QJRL5tEKk9tdr
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 76d297b3-13bb-4579-16cc-08d58157d6fc
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603307)(7193020);SRVR:MW2PR2101MB0940;
x-ms-traffictypediagnostic: MW2PR2101MB0940:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <MW2PR2101MB0940F23AA9FD76F99BC80160FBC40@MW2PR2101MB0940.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(85827821059158);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(5005006)(8121501046)(93006095)(93001095)(3002001)(10201501046)(3231220)(944501244)(52105095)(6055026)(61426038)(61427038)(6041288)(20161123558120)(20161123564045)(20161123560045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:MW2PR2101MB0940;BCL:0;PCL:0;RULEID:;SRVR:MW2PR2101MB0940;
x-forefront-prvs: 0600F93FE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(39380400002)(346002)(366004)(39860400002)(396003)(199004)(189003)(106356001)(68736007)(6486002)(25786009)(22452003)(6436002)(186003)(2906002)(81156014)(81166006)(10090500001)(66066001)(8676002)(36756003)(6512007)(39060400002)(2900100001)(316002)(97736004)(59450400001)(102836004)(53936002)(6506007)(3280700002)(26005)(4326008)(5250100002)(305945005)(2501003)(76176011)(2950100002)(86362001)(99286004)(3846002)(72206003)(14454004)(3660700001)(478600001)(1076002)(5660300001)(10290500003)(6666003)(6116002)(7736002)(86612001)(107886003)(110136005)(54906003)(105586002)(8936002)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:MW2PR2101MB0940;H:MW2PR2101MB1034.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
x-microsoft-antispam-message-info: jD+XL4aQ8rS1xgoMcBg0QI/1uUfF4PsU/5MfCvRnCp3QJQ5ri9GTGBRww3mNCWsiuZd9aN0NB5YHQLEAG+MGC0Qnc5D4i2NZrc5pYnPvP1OPQBkvlqcgNfWtGxC6uEjAJ/xtRCLgDXBJLC+BgBBuUVPsJA7jv+h3KyLcmGDG3dw=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 76d297b3-13bb-4579-16cc-08d58157d6fc
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2018 22:33:17.0909
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB0940
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Rob Herring <robh@kernel.org>

[ Upstream commit bcf54d5385abaea9c8026aae6f4eeb348671a52d ]

If the length of the modalias is greater than the buffer size, then the
modalias is truncated. However the untruncated length is returned which
will cause an error. Fix this to return the truncated length. If an error
in the case was desired, then then we should just return -ENOMEM.

The reality is no device will ever have 4KB of compatible strings to hit
this case.

Signed-off-by: Rob Herring <robh@kernel.org>
Cc: Frank Rowand <frowand.list@gmail.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/of/device.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/of/device.c b/drivers/of/device.c
index de20165bad48..2ef5ca45a136 100644
--- a/drivers/of/device.c
+++ b/drivers/of/device.c
@@ -126,7 +126,7 @@ ssize_t of_device_get_modalias(struct device *dev, char=
 *str, ssize_t len)
 			str[i] =3D '_';
 	}
=20
-	return tsize;
+	return repend;
 }
 EXPORT_SYMBOL_GPL(of_device_get_modalias);
=20
--=20
2.14.1
