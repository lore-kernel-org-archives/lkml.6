Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1145125-1520116445-3-8507834770466043895
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
    t=1520116445; b=qNLDPL/5TM5WHr4rzgICAMkyj5D5wKybezgAzCnpU3v83wU
    TLdq/4WghH8g54qg68H3ClG39Nj0eI6TnVJXdkl1KaaEoC1XipPR3D8PzfcWmahw
    fF3M+FlCf8f5bjcHyiSATFn2OhVkVL/+geVTCgoGeb02aC9vA8HI7M+g99P9jaxB
    dVgYS7U4kYyq+jJf7QIR/Csbv9m4eWNbHZxUROsB0q9EAeuNgGgKDbEhnRr4uBpx
    CbBFViVO8iyk1Ll5bAiAM1lx4jzUvflg0Ow6X7N//SNiRBqfeHOrmn+zKDcRabkz
    rskE5AVeOtHjhnUDz8kio2QEJsiK+M28/ZK8xeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520116445; bh=u3MJoo
    jFRNSxISnbCFH4vMlBAMHlZ6s607Sp89BB4/Q=; b=dR/EUbphfwQOB6oWygalyV
    7OWyDX9gyU1ZiFdfy1YiDDv0Ay2cG9NX3FD3M8ZhYf7JJjPJ9oZpW17H00rl9PeQ
    z7B37GAZ9OPGa79cXJjUB5Wvewxb9whBGMPNeeJIv9/oO2C0rkpFafhYWMQ82vri
    0+fItK2ac3DGXcNINAVN+oe8vAR01ZHM4rEk1QwYH7qHNYwXKY9iRLrsRllCgDD2
    bK833XWKwPYMIp8Z5+Xe//KsPwOTbmTyjU8U5/qViL5Lyf0AypYfXsVBHBnmU9TF
    +NRqC499l6rqRlpDS2xJk9Ythn8bwUPJxiM7CwOeq9dnRolxth3k5kw3qcqXOO5g
    ==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=dFVoiYZU x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=dFVoiYZU x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933840AbeCCWc1 (ORCPT <rfc822;greg@kroah.com>);
        Sat, 3 Mar 2018 17:32:27 -0500
Received: from mail-by2nam03on0115.outbound.protection.outlook.com ([104.47.42.115]:54496
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S933530AbeCCWcU (ORCPT <rfc822;stable@vger.kernel.org>);
        Sat, 3 Mar 2018 17:32:20 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Rob Herring <robh@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 052/219] of: fix of_device_get_modalias
 returned length when truncating buffers
Thread-Topic: [PATCH AUTOSEL for 4.9 052/219] of: fix of_device_get_modalias
 returned length when truncating buffers
Thread-Index: AQHTsz7yDl+fguDQEUiZ14/9GkO3Ug==
Date: Sat, 3 Mar 2018 22:28:26 +0000
Message-ID: <20180303222716.26640-52-alexander.levin@microsoft.com>
References: <20180303222716.26640-1-alexander.levin@microsoft.com>
In-Reply-To: <20180303222716.26640-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MW2PR2101MB1036;7:gSIXnslNnPbzRTS3JkoHol/I608jm9JCl1PRO2ahIi0Y5otyCcIweMTet3Z5NrH82kdwfy0G8+CxejNWY/CtmA1xMeAVLOzUog56uZlbtISU5P36UZjBfXfZj81qMB21oi3OcVsjDnuC4chdbt3CMwfr7nkrFRhWCJcBQ0RzoJoDOxSXBukArGzMPMj5WaVndRO2CaBjgSM0TIJbZtw84eytf8iD/ZXZnKztzTPd4kW1gP39g2hlnm0za23ykLmN
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: f952dd97-e1ee-47d7-1253-08d581569ccc
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(48565401081)(5600026)(4604075)(3008032)(2017052603307)(7193020);SRVR:MW2PR2101MB1036;
x-ms-traffictypediagnostic: MW2PR2101MB1036:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <MW2PR2101MB1036FAEFC428C8E3C7085A59FBC40@MW2PR2101MB1036.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(85827821059158);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231220)(944501244)(52105095)(3002001)(10201501046)(6055026)(61426038)(61427038)(6041288)(20161123562045)(20161123564045)(20161123558120)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:MW2PR2101MB1036;BCL:0;PCL:0;RULEID:;SRVR:MW2PR2101MB1036;
x-forefront-prvs: 0600F93FE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(366004)(39380400002)(346002)(376002)(39860400002)(199004)(189003)(10290500003)(81166006)(5660300001)(107886003)(8936002)(39060400002)(81156014)(3846002)(6506007)(2906002)(8676002)(3280700002)(59450400001)(72206003)(76176011)(4326008)(478600001)(6116002)(6486002)(53936002)(1076002)(68736007)(6512007)(102836004)(2501003)(66066001)(3660700001)(5250100002)(6436002)(105586002)(86612001)(36756003)(316002)(7736002)(97736004)(26005)(186003)(110136005)(305945005)(22452003)(86362001)(99286004)(6666003)(25786009)(106356001)(2900100001)(14454004)(54906003)(10090500001)(2950100002)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:MW2PR2101MB1036;H:MW2PR2101MB1034.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
x-microsoft-antispam-message-info: pcI/hE23mn8e+NABc0ReUHsiojkDHrbtuHgJ+8GFmgoBLeAueFn8DQJe3dvrs7+AIGL/cs1ZijBUcgtPxNct/Fvi6jSjPBRFX1/FhPdW5tnxGUnlenYPg2aG9qkmsRxJXmUciZANOLWch1ercvXwvoQAA1iZdXDQQxxJPJdR4m8=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f952dd97-e1ee-47d7-1253-08d581569ccc
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2018 22:28:26.1350
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB1036
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
index f7a970120055..3cda60c036f9 100644
--- a/drivers/of/device.c
+++ b/drivers/of/device.c
@@ -223,7 +223,7 @@ ssize_t of_device_get_modalias(struct device *dev, char=
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
