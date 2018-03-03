Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1204544-1520118694-2-15838936737251014082
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES daensv, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520118694; b=tJuMdEDJ2OH2vOKBkpvS+xJgsi6QmJghF4qmeQs1ZjbtRF6
    aaAWSqA1UYmPLQmmJj3cwfjzQOo+hC4IVOT3QlYf1BLOvpmFGL402/nqDs5twr4K
    lM9Ak0Z8pM61q6531qmIzJ+Nh5lkpchKljy6F/lM8BY9cuJ4GTwhr2QBHkO56Hwb
    GfSFlJWAdBB+/sH5A/+b+j9BSFauiPrYA/GuQecngtb918wLcGzwxgsxUil9GUQd
    p005NYusOA+OOBM4xl6zDivLESxjwk4Eup0vMbBVkkm9+lO9v8MKdtkvorKlnYGQ
    +nqkdMG2lYvAUGLLdrLsuMQFiefQrRV9ocgyvaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520118694; bh=Kw5JCm
    hEnxzWetvss0xQMP6+cLGTJOPYtNPxU0O9UrA=; b=CXhXb2Lcs6O2fQ5T9VaJO7
    sDQD56q3YLgRNRbZvJrK8yybmLKkAk31zHuYf3kKIR4MsTfuay4KQX+7MturyvgF
    jy+/vVNSFlw0fQyWl3KUTTjTJNm6HyZoAHmLGV9UqYzz6sAY0q+LSsM/QGlixEh/
    Bidhr3jiDknI+PcyOsRXGSuMGYvExfcWWW2KhaUj2vOBMoF+sFwIzHtUJaWNe9Xd
    AAPo1kKqrgd7CE9NgWJd8iAN2YtkhHrHgxOfWl8e6+GDccbqnI3oPzxY/wSD/gV3
    35ZjQDnyWcqNzGod8853gaiYiq/lXIFpVvwO53U6gt6wuKY9Ty5ANGp/UgH0kyLw
    ==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=WgUautjE x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=WgUautjE x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934571AbeCCXLF (ORCPT <rfc822;greg@kroah.com>);
        Sat, 3 Mar 2018 18:11:05 -0500
Received: from mail-dm3nam03on0102.outbound.protection.outlook.com ([104.47.41.102]:24173
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S934573AbeCCWjV (ORCPT <rfc822;stable@vger.kernel.org>);
        Sat, 3 Mar 2018 17:39:21 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Andrew Lunn <andrew@lunn.ch>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.4 051/115] net/faraday: Add missing include of
 of.h
Thread-Topic: [PATCH AUTOSEL for 4.4 051/115] net/faraday: Add missing include
 of of.h
Thread-Index: AQHTsz9ZFsDLdEBrT0aw/Vx8nhFoDA==
Date: Sat, 3 Mar 2018 22:31:18 +0000
Message-ID: <20180303223010.27106-51-alexander.levin@microsoft.com>
References: <20180303223010.27106-1-alexander.levin@microsoft.com>
In-Reply-To: <20180303223010.27106-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MW2PR2101MB1113;6:S/Di7itf+0A2y4isHNi0T5OKAYOQtn6TEht9mdhH2dHf3rqp99qIAjZ+3hinwVMukk3bQRr3Srz88CgO5hFeYJH5fVfdoLK9HhG871coNit4r2Kgcy+6FGnPBppys98thbwesZV8qyRGXL/8w/Mgi0wkE4wq19klAoVwqU+0+MMSFCVou8pee6NdX5oH9gWkQbgZYLmZZoAD/45gVRk1fdEPqjNAm6YEo4PyTnW9CoUJAVSoi7KzIt6HzielcWRbspHpVYKMdI4n3YfBNp4YighdYpk8KZDKjr6B7EKJCc4mqP278nYR0zGJxdIysCibNmS0RyzgqJ6SNMfn6Wf/OOe4X7cJQLzy5GqjfkHEDif2vCDpORb+QxuI1Ee7OJLx;5:Bm/UWcy6p7hlEKe7Dd5gZkluQflbDYg/k9ZuWvhSKHZcVM5gWGMryuYkt7kcIEntDLJYNbk1CPnDo+WgpZgWMFaqxA6mulPdqU8k2T8ytmWgp1YRoJh1z72Re2/gFchib5caKsRrLaG29y4kf8jnNOjenGFQDr215oxG4H4iEUQ=;24:VOlvV7DgXdiWqkm/+0CLqCoVmTXVG2R5R1ruj0fmYpIpBcIFAQPtzS6k94obnbCeU4CVRhYNjp/bf6zfzQivpxEjsfJuum/Pk6yn+KkKWPM=;7:MBpohXCOmPHN9rQRvHdLZ9rVB6blhAjNv68yM7L09dHv0dsOp7iMfjZ3ZGikwRCvqp+bqMhuCH1hNP1/06/l/hQP/UGIWdxPZu5vZhgOjVVD+YcNoddoU+WljTMQ0SO/dacW8bLcrsrB3djoeMqke6iRr5864/zpmpt35I47+2f2kSocDUPG7y+H7xB1YTakhhLN2iTYoSmesljgVLXl/B4wzPzTWo+xAzUgnxtomK8q8Cex+9l+uJ9xWT+PfY+j
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 505dbb0d-289e-42bd-ce8a-08d5815798fe
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603307)(7193020);SRVR:MW2PR2101MB1113;
x-ms-traffictypediagnostic: MW2PR2101MB1113:
x-microsoft-antispam-prvs: <MW2PR2101MB111346F514E24E8EACD454E9FBC40@MW2PR2101MB1113.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(5005006)(8121501046)(3002001)(3231220)(944501244)(52105095)(10201501046)(93006095)(93001095)(6055026)(61426038)(61427038)(6041288)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123558120)(20161123562045)(6072148)(201708071742011);SRVR:MW2PR2101MB1113;BCL:0;PCL:0;RULEID:;SRVR:MW2PR2101MB1113;
x-forefront-prvs: 0600F93FE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39380400002)(366004)(346002)(39860400002)(396003)(376002)(199004)(189003)(68736007)(7736002)(10090500001)(6116002)(3846002)(1076002)(2906002)(5250100002)(6486002)(2501003)(6436002)(76176011)(575784001)(86362001)(22452003)(6512007)(53936002)(66066001)(86612001)(99286004)(2900100001)(316002)(36756003)(54906003)(106356001)(110136005)(6506007)(102836004)(186003)(97736004)(26005)(6346003)(14454004)(3660700001)(8936002)(107886003)(10290500003)(5660300001)(81166006)(478600001)(3280700002)(105586002)(8676002)(81156014)(4326008)(72206003)(2950100002)(305945005)(25786009)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:MW2PR2101MB1113;H:MW2PR2101MB1034.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-message-info: FlTeZJQ7r6lGJLp4dNsqc/LUVYBonDQ+qrJIxlVzFIqrHiZxvYpSlC1hVw2ztE2z9hOJnfLFDvtYixM4641PaeZ3VRukaMwiB7nFfEstkOF9C11SkF+sM/W77IS9cg/a7jAgAZWwdzK8gKD2gP5aidvQfVrW/sUVti/3jPgoKCw=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 505dbb0d-289e-42bd-ce8a-08d5815798fe
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2018 22:31:18.4478
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB1113
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Andrew Lunn <andrew@lunn.ch>

[ Upstream commit d39004ab136ebb6949a7dda9d24376f3d6209295 ]

Breaking the include loop netdevice.h, dsa.h, devlink.h broke this
driver, it depends on includes brought in by these headers. Adding
linux/of.h fixes it.

Fixes: ed0e39e97d34 ("net: break include loop netdevice.h, dsa.h, devlink.h=
")
Signed-off-by: Andrew Lunn <andrew@lunn.ch>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/net/ethernet/faraday/ftgmac100.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/faraday/ftgmac100.c b/drivers/net/etherne=
t/faraday/ftgmac100.c
index 6d0c5d5eea6d..58c0fccdd8cb 100644
--- a/drivers/net/ethernet/faraday/ftgmac100.c
+++ b/drivers/net/ethernet/faraday/ftgmac100.c
@@ -28,6 +28,7 @@
 #include <linux/io.h>
 #include <linux/module.h>
 #include <linux/netdevice.h>
+#include <linux/of.h>
 #include <linux/phy.h>
 #include <linux/platform_device.h>
 #include <net/ip.h>
--=20
2.14.1
