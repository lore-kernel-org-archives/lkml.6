Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1211789-1520119039-2-1374912386864945144
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
    t=1520119039; b=PVAlw7o9goE/9AoNHVKVkQ7SoaZQC1LZhedsd5QcaDfPNH/
    qXe7o9PON7immPcobNPER2zuNovoVaLK6TuUQm1dX2DKJiohYQ+bH4JHbvjTc8Aa
    KGLHXhnYDKN9OsRXFNAHCamirebmaop4mLtboaBA0nAV42iWlz4FRXq4L5qdXFzJ
    und0nZ2w/0Q4qEOBxuOo9P2hGbzdkfLnX62F1eVTGkGtzILAs2mSekpPJthBUNqL
    VM9J+5Xb/4hrIPmlVKlT6fcfPzVCADxugewCCCnklCyW0RYT2GPn/tqUNtR9tph5
    RUuvPcsNx2AHztrXUftPih8iP6BmdW54Ulk+Ymg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520119039; bh=2cfIqc
    ltUurXXgxbYMzQ1cCowP5IGCUA+eMgrMy3HyI=; b=a4VtbdnFExpg27C8DPzCNe
    /1Rwc8PFOCM6fJndks0gnMQzLLI+5S/JKFhT3XFMCzd5QatuXVoeazmwSLbneYvc
    jHTEAG/wkTjpEs92FgNNpg4PNx5k9o2kMkzOqUt6s9mysY3gIFsOMcF/EImdvrws
    No0IDGzg1CdTxZvlE4rls0PiapjsOrlFNjglL0shzOaZHyv/Ok9z50iuBxOuND4H
    gCQpGpt6eerguafmEHfmudzq4xYRjAPrB2JSnJLopdmHL/nlNyy4HKYs8RsrJrrd
    t0Asrr9oy91dKLY1nOLMCeCY9NkPu7Xv+cipVJcOIz4n1bCcvjmnPFS4sxbmlfiA
    ==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=a/p5DWqT x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=a/p5DWqT x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751752AbeCCXQp (ORCPT <rfc822;greg@kroah.com>);
        Sat, 3 Mar 2018 18:16:45 -0500
Received: from mail-cys01nam02on0114.outbound.protection.outlook.com ([104.47.37.114]:41081
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S934858AbeCCWiN (ORCPT <rfc822;stable@vger.kernel.org>);
        Sat, 3 Mar 2018 17:38:13 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Rob Herring <robh@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.4 023/115] of: fix of_device_get_modalias
 returned length when truncating buffers
Thread-Topic: [PATCH AUTOSEL for 4.4 023/115] of: fix of_device_get_modalias
 returned length when truncating buffers
Thread-Index: AQHTsz9OC/7TDueD2UiC/NEv98vMDQ==
Date: Sat, 3 Mar 2018 22:31:01 +0000
Message-ID: <20180303223010.27106-23-alexander.levin@microsoft.com>
References: <20180303223010.27106-1-alexander.levin@microsoft.com>
In-Reply-To: <20180303223010.27106-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MW2PR2101MB1067;7:XOL1Cx4sO6vWfshGNDUu5zQOjA7PShcKpOxzGBFJSB6IxpsBnfAmUop+TBd15qR4LAGsfMJII/0sQ3RFYpJdA1cGAeNCA7mhzAoMfL5C1YE2YcTbbNInLsjFE8juVnYC3rlWZyQaghU1TCq7zQJrsTd5aIllGpSKG3SXvkr31SCNo5TswN6LTlZ9c3+I81oDnMow1lj+PI4TWlUF1CEFLZEEA8ev+AFVFX1nKOz4vswJMIQ8gWAk5FyJo3eAKxUO
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 926837e2-19ea-475b-b63d-08d581576fdb
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(48565401081)(5600026)(4604075)(3008032)(2017052603307)(7193020);SRVR:MW2PR2101MB1067;
x-ms-traffictypediagnostic: MW2PR2101MB1067:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <MW2PR2101MB1067241D40197F6918CC59F1FBC40@MW2PR2101MB1067.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(85827821059158);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(5005006)(8121501046)(3231220)(944501244)(52105095)(3002001)(10201501046)(93006095)(93001095)(6055026)(61426038)(61427038)(6041288)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(20161123560045)(20161123562045)(6072148)(201708071742011);SRVR:MW2PR2101MB1067;BCL:0;PCL:0;RULEID:;SRVR:MW2PR2101MB1067;
x-forefront-prvs: 0600F93FE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(979002)(396003)(366004)(376002)(39860400002)(39380400002)(346002)(199004)(189003)(4326008)(5250100002)(86362001)(1076002)(2501003)(110136005)(6666003)(81156014)(2906002)(8936002)(305945005)(81166006)(2950100002)(7736002)(10290500003)(26005)(186003)(3660700001)(478600001)(72206003)(107886003)(8676002)(3280700002)(59450400001)(2900100001)(39060400002)(76176011)(6116002)(25786009)(3846002)(102836004)(6506007)(5660300001)(97736004)(10090500001)(86612001)(106356001)(99286004)(6512007)(66066001)(316002)(53936002)(14454004)(105586002)(36756003)(6486002)(54906003)(6436002)(68736007)(22452003)(22906009)(217873001)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1102;SCL:1;SRVR:MW2PR2101MB1067;H:MW2PR2101MB1034.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
x-microsoft-antispam-message-info: joedtj0HoufFTZ2otf1j/F2BGLvA+gyRQAPxYfVVRS2F9SVwT52l+0XOYa6U1sH0L/LaPS7JOQZLIlSLEzjshgkkK77OrDaW/jBlwMPfdg9+iK4qLZOSP5mHt4eoiQObhM32XJ+/WdsYmy3jiI7YkOwY4vSK2j9HwplYKTn8VeQ=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 926837e2-19ea-475b-b63d-08d581576fdb
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2018 22:31:01.9790
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB1067
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
index 97a280d50d6d..7c509bff9295 100644
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
