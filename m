Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1021398-1520487285-3-14371446796292296098
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
    t=1520487284; b=Pd1vgHuY03uqoR86pP4P51BgKSZCAHd1O7PCIiJMzsQIBz0
    GUKcSeyT9RIOUPHqItzlVVXehwkhRxJcz3BwX/odkBkrIevzVFZvi9gMirNngqAR
    eOuKerYWFaiAWGO2ivWsQq9krFKFgmGneAxK/uS7TMk0JnkzJfTfkCD08LX0W4n4
    LmzGHm88jG+7ybp9LpAVStspBetgBTS/68XKHNRbVqikaHOXE/Bo1wgrSIsUJZY6
    ORYbGEryjIeSrrzoSlWcUx+80sj/fVXq5L8VAPp4OuwPpZz1k9mDrzYNetjFqWX/
    XEygEx/zZUbpQw9uzz00E637Q9J2lWEoNl8Corw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520487284; bh=MZ2C9b
    ueT+7ztQmHtAJFfdhAE3Qnmtr9oSi0kf/EKko=; b=C0ygjQykaK0/0Eta3SEt5e
    mfAScYDSP8oEgyocL+A+3do/5y59F/oG8LHSLld35evlxEkcw1VQqLTSSwfffJ0E
    Xxn9PG66m96Gw1NuiCd5QamQ8N4VBEf4gTlKO75Ow4r9MPhszO0MxkTVu5eufjKY
    ovpZ0J3krwnwwRe4qZuW+/LZ63Zv8MJceeWRQRi4/YKryocxjZIFb9zaF6R+THBO
    FVLvermuXvPSoL+AhYGBu76THvp4ynfM4iRw9xgD0tTgO+UNns0ao0hJ5tDnFxVy
    512pgapsS10UUO+JkaYdHeUhsKyGmsA2jpjkVxPe8GY/48H5Itcitcn/7zKcrulA
    ==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=YGIA5/aU x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=YGIA5/aU x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965956AbeCHFGH (ORCPT <rfc822;greg@kroah.com>);
        Thu, 8 Mar 2018 00:06:07 -0500
Received: from mail-by2nam01on0123.outbound.protection.outlook.com ([104.47.34.123]:62833
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S966347AbeCHFGF (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 8 Mar 2018 00:06:05 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Pan Bian <bianpan2016@163.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.4 046/101] wan: pc300too: abort path on failure
Thread-Topic: [PATCH AUTOSEL for 4.4 046/101] wan: pc300too: abort path on
 failure
Thread-Index: AQHTtpqNxqauSp7fGU+/Vj5N2onFYQ==
Date: Thu, 8 Mar 2018 05:01:43 +0000
Message-ID: <20180308050023.8548-46-alexander.levin@microsoft.com>
References: <20180308050023.8548-1-alexander.levin@microsoft.com>
In-Reply-To: <20180308050023.8548-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0917;7:MdbR8sBVvZJ9NnbjcaozLHn8Fp2zxutx6mCaaFbBz45Qu19LifC30rcsezuXkG+f2ktGTc8419iInhzVCbWbL8mNkYNl7+DzfzhbW+Q6JuA1bUZ+kJPty385ZDZT1TuGR4tblkNburd22EE0uyqOTWuzQb6+9iT1wzuCf/F9AIalNFzvi13RD/dFm4oQiUu6Y1rlgNmBp4r7LsyUlbahTG+QDIEEypGIHAQQLk/JIZaUaxwenDfL/ddpL8fpHC2X;20:zb/fqmzR3E7x+YrLSDugyw/FqGcwHXoheor8Zse1+xmKi5qzOFQmYvP46JAVqfrmErnfyXtuUuWifi0hnBNExTYU3Fo2dXUzMs25UFDqgNrR+jScrDILrz92ok8qRD5FDAFC5wM8M6oK9yqxqqX0O29ACauJd77vNEay0b2Vxco=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: cd1bed28-571b-4bd1-e309-08d584b24a2a
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0917;
x-ms-traffictypediagnostic: DM5PR2101MB0917:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB0917EBD6D2EA409683450847FBDF0@DM5PR2101MB0917.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(130843839470238);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231220)(944501244)(52105095)(3002001)(10201501046)(6055026)(61426038)(61427038)(6041288)(20161123560045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123558120)(6072148)(201708071742011);SRVR:DM5PR2101MB0917;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0917;
x-forefront-prvs: 060503E79B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(396003)(376002)(346002)(39860400002)(39380400002)(189003)(199004)(478600001)(2906002)(6512007)(6116002)(1076002)(7736002)(3280700002)(5250100002)(2501003)(6436002)(3846002)(186003)(99286004)(86612001)(53936002)(26005)(36756003)(305945005)(22452003)(6486002)(102836004)(10290500003)(72206003)(76176011)(110136005)(4326008)(10090500001)(105586002)(316002)(25786009)(97736004)(107886003)(6506007)(81156014)(14454004)(81166006)(575784001)(54906003)(8936002)(68736007)(8676002)(106356001)(6666003)(3660700001)(5660300001)(66066001)(2900100001)(2950100002)(86362001)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0917;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
x-microsoft-antispam-message-info: HpfkGg6SJC3h2sxFm9Fmsw3Ny+1w7NTwhvFRrc8GYYGKiqcc0CZfnoHBr/FPdpR9/AZrIqd+VIEjWw1VtlhCKejsBG89VbmFxeZdcSIeU900JbnS9JEoDlM4KgYngmiYZshpgQFCnCwO6RHeg0LeT5rgy+je/8kYaspas9WKNToB8d4P8TTBsiiGqaEDucoBnp632nMsn4qDv1w+eeIYhi0cbJr0YXTk5wyFj0klQBOqv79iAIh+UPnIE4cpAfl8vtUtCOm/QOh4v/Mou8WTNa8mwb4oSM7Lgd6HQOC386rF74FezAUwTy0h7sKMl1yakLjCunvm1EASukI8RzhO+w==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cd1bed28-571b-4bd1-e309-08d584b24a2a
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Mar 2018 05:01:44.0099
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0917
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Pan Bian <bianpan2016@163.com>

[ Upstream commit 2a39e7aa8a98f777f0732ca7125b6c9668791760 ]

In function pc300_pci_init_one(), on the ioremap error path, function
pc300_pci_remove_one() is called to free the allocated memory. However,
the path is not terminated, and the freed memory will be used later,
resulting in use-after-free bugs. This path fixes the bug.

Signed-off-by: Pan Bian <bianpan2016@163.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/net/wan/pc300too.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/wan/pc300too.c b/drivers/net/wan/pc300too.c
index db363856e0b5..2b064998915f 100644
--- a/drivers/net/wan/pc300too.c
+++ b/drivers/net/wan/pc300too.c
@@ -347,6 +347,7 @@ static int pc300_pci_init_one(struct pci_dev *pdev,
 	    card->rambase =3D=3D NULL) {
 		pr_err("ioremap() failed\n");
 		pc300_pci_remove_one(pdev);
+		return -ENOMEM;
 	}
=20
 	/* PLX PCI 9050 workaround for local configuration register read bug */
--=20
2.14.1
