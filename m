Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1021398-1520488859-2-2047807275556152613
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520488858; b=Jb12TvftwcYSQZquupxAa9uyj7n8xYjnfcIp/lBU7wynELy
    vR687CVIeWRF39F9i7z/PiimAeucAZbTfwXy5gAYT+N9BciRPPumfsUTwcJ/X4VF
    u6FQSonGR83cc5YhbKHr/cMKoi3nq0UhvFJbqPJmHlCCsLgadO0q916KiMIkgUx5
    vHlOILGB9fSy1rnF+arjJoEaYsRcoFH0pj6S6zEewNwBJWMNEtvbtAGUWzXfP6WU
    uwJp32sRut8NVVJ+b610MVoL1Jcyg37RgtJONTi0pkUCyiZHfyOSjkYBMFvTEz3h
    EYbg7LzO929oM7EnegsCkMyaz6EKMoqTNJRi3Rw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520488858; bh=mSNu/2
    YQv8UCmKjpdTCOqAzM4VTMxcjHkCokKdOJAEg=; b=S8zclQEje+Mf/FsItiAdX+
    wL41J0qVFlQDIRBUCkTphfMekILHgIXrRtJUZnBod7DmTEMfH7imU12egGzdVR+M
    CXmnPga0WTv0ckGVSJ2ujMrboDbruC/dNwwPoM2v82Kz0XQwsr91ISs/x5HBjZ1/
    v84kC4nBsK3OTgZrmwweAjtxbq5l+w2KhtCpFEvLJ22GQPfBba9Md/CoMim9gG5n
    UPvVNgYhoCa1DHeDINf/wxPnsk0AQ6uz0xd2JfSPXVirkE8IKoYTTQS7iLGU6Qw7
    89nI7CyWyDf9Pe+snZdPykpI701NkoRsPpjeDcio0qQ7WrlDS8Kbh23+nZ6lMUsA
    ==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=QeEqYAvf x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=QeEqYAvf x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965335AbeCHGA3 (ORCPT <rfc822;greg@kroah.com>);
        Thu, 8 Mar 2018 01:00:29 -0500
Received: from mail-sn1nam01on0117.outbound.protection.outlook.com ([104.47.32.117]:16747
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S965684AbeCHFDQ (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 8 Mar 2018 00:03:16 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Sebastian Reichel <sebastian.reichel@collabora.co.uk>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 131/190] Input: twl4030-pwrbutton - use
 correct device for irq request
Thread-Topic: [PATCH AUTOSEL for 4.9 131/190] Input: twl4030-pwrbutton - use
 correct device for irq request
Thread-Index: AQHTtppJjDzGCaqEPUmriSPENveCFg==
Date: Thu, 8 Mar 2018 04:59:49 +0000
Message-ID: <20180308045810.8041-131-alexander.levin@microsoft.com>
References: <20180308045810.8041-1-alexander.levin@microsoft.com>
In-Reply-To: <20180308045810.8041-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1013;7:HfnuAe3m6A+yMZvKDEJ8X3S+GSAQh3wlMJE6jgnbgUBs2mGG31miq8bz7JXjDDMTpbxcqTf6bbOlt0ckdko2j5hTLTjXvZ/kckDFLvIKpHv9PV9HdvO7r8+JNde29FDtaLQDU6xdk7BTgx9luJP4B5ya2g1V4SjnReJGWX3hSZxDmlLbZKGOsh/eRzdOya5NT+paBk1ZUXSV7klf05BHDUZUSp+/V6IkrksadXWmXcgeG35sw3Uz7gzskLDE7eja;20:OSz2YRxiMVP+9LzVc15EyV2TwVmPw+sYBrt/MJIJALNt2Ihy9JcXhoF6yMVhbElFdCFIn524kCMo+7nDOjjTbqs0om6VJs/qrZkcQHk0fNrWZDsfMy5Luv6kSGzUT49JX/eJQsFvof0QDkmxa5jz4BwJWSy8cIHX5s8bUDjvyxs=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 7b785287-1000-4a33-0114-08d584b1e595
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1013;
x-ms-traffictypediagnostic: DM5PR2101MB1013:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB1013E6180CB5AE01BE4BC2EAFBDF0@DM5PR2101MB1013.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(85827821059158);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(5005006)(8121501046)(3002001)(10201501046)(3231220)(944501244)(52105095)(93006095)(93001095)(6055026)(61426038)(61427038)(6041288)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123558120)(20161123564045)(6072148)(201708071742011);SRVR:DM5PR2101MB1013;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1013;
x-forefront-prvs: 060503E79B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(396003)(39380400002)(366004)(39860400002)(346002)(189003)(199004)(76176011)(6506007)(107886003)(6486002)(22452003)(105586002)(2950100002)(6436002)(26005)(99286004)(53936002)(6666003)(97736004)(36756003)(3280700002)(102836004)(5660300001)(2501003)(68736007)(6512007)(186003)(2900100001)(59450400001)(106356001)(3660700001)(4326008)(2906002)(25786009)(5250100002)(14454004)(7736002)(10090500001)(66066001)(3846002)(305945005)(6116002)(316002)(10290500003)(478600001)(86612001)(8936002)(39060400002)(54906003)(72206003)(8676002)(86362001)(81166006)(110136005)(1076002)(81156014)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1013;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
x-microsoft-antispam-message-info: ixuTS96uMUWI2c5uDjsMLM+VdiF1ajIPczm7N6ud67qCLJKqXEvrKjta1526/9gTOS1Vcbnc+2W4ANf3JNsdGxyHvVX1P8MzEo7ljzAVIx69ryMNUszApLZO80vSa3xbQSB9L9VOeBBu67blFfN06mr8mu6UoG5l2P2bmOMK6Ru8z68IhqAFPAaRJ3FrJhqsH3tk68cMOW+7HSt+uz+nlPE3YRH71X7XdTqbRqek1YbnaJk9oFM5wymNlH/svPvCI40nvvyS/IC8xU2nJ3nnpB2W32JG8sV6uFw5AhbKSwxdFTCkFr1hAvfXpdzlIFwDx8uZtC8gUygpSkSq378pvw==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b785287-1000-4a33-0114-08d584b1e595
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Mar 2018 04:59:49.2898
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1013
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Sebastian Reichel <sebastian.reichel@collabora.co.uk>

[ Upstream commit 3071e9dd6cd3f2290d770117330f2c8b2e9a97e4 ]

The interrupt should be requested for the platform device
and not for the input device.

Fixes: 7f9ce649d267 ("Input: twl4030-pwrbutton - simplify driver using devm=
_*")
Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/input/misc/twl4030-pwrbutton.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/input/misc/twl4030-pwrbutton.c b/drivers/input/misc/tw=
l4030-pwrbutton.c
index 603fc2fadf05..12b20840fb74 100644
--- a/drivers/input/misc/twl4030-pwrbutton.c
+++ b/drivers/input/misc/twl4030-pwrbutton.c
@@ -70,7 +70,7 @@ static int twl4030_pwrbutton_probe(struct platform_device=
 *pdev)
 	pwr->phys =3D "twl4030_pwrbutton/input0";
 	pwr->dev.parent =3D &pdev->dev;
=20
-	err =3D devm_request_threaded_irq(&pwr->dev, irq, NULL, powerbutton_irq,
+	err =3D devm_request_threaded_irq(&pdev->dev, irq, NULL, powerbutton_irq,
 			IRQF_TRIGGER_FALLING | IRQF_TRIGGER_RISING |
 			IRQF_ONESHOT,
 			"twl4030_pwrbutton", pwr);
--=20
2.14.1
