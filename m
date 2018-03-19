Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3372889-1521480454-2-14016739511168644977
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
    t=1521480454; b=vlR8uJQh/Cs5dETmYfJr2lPb/4GVKcLwJ4uigoduU+VK7qM
    JMdNBic8OrwmufEwVSVzC0EoelzFfTWcTRt/MZSVU4kWXg8/10vMwCf+YT6ZqGFZ
    l2T2SJI3VBCmPUmeQUnP6t6AfCUPbiJfGEdbN7phOxe6QDpyrgNHCFJFIM69kRIv
    We7AKAsr+rG+vM+igJZogVqrca3uxSFZM1+XQfDLd89/rFE6gRpozPmVZpCpfj4W
    eKSYkLR4+4rfylFdty8jTNPM9mGiO2hwn1yCYaxrq+aTUsVp7Z6s82iBm3OFDniC
    q+MfGvFhLhyMFprVjJm4vFKXItj2UACit0aPP/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1521480454; bh=OFkya1
    foFaeoSTvw5HgQbXwuPngvZymtX82qWlMlnts=; b=gjUxR7+7++IL0ce6EjkgtU
    3bK8v64JYYk1jE13GBcb1HELJ9l8KzFFA4ZCR/ZRGmszN9zthm3YPg4eQX0paoPB
    p/zvSYq6rS7l7bvQGblk2ErovkU9o5qwR2hHU9z8t19E06NCf9ErxTMsuLbXTtsD
    j83sHaQFNT8p3XOYt2OCzmKFZ4ubttwimwYmid0ArJBZXibspmZ69huEFrQNOBLc
    KQMMDLSW/Yu9pEmE3JDr5LdRVwHQQew+ghkDf6yZLe/LEeIMr95DJoXpaDN+7F0f
    81daZ0AiKvQNXlJ0BQbWj/RTMTPbby3F9YnsGJXlg1G1H6C85GOOXXb2/a3tIF3g
    ==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=HLWNzLKC x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgddutdduucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeejheejgeenucevlhhushhtvghrufhiiigvpeefie;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=HLWNzLKC x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgddutdduucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeejheejgeenucevlhhushhtvghrufhiiigvpeefie;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966269AbeCSQIR (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 12:08:17 -0400
Received: from mail-dm3nam03on0098.outbound.protection.outlook.com ([104.47.41.98]:60247
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S965886AbeCSQIL (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 19 Mar 2018 12:08:11 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
        Tejun Heo <tj@kernel.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.4 041/167] ata: libahci: properly propagate
 return value of platform_get_irq()
Thread-Topic: [PATCH AUTOSEL for 4.4 041/167] ata: libahci: properly propagate
 return value of platform_get_irq()
Thread-Index: AQHTv5wz+7MPNN2jXEqzIUjgIqsb/w==
Date: Mon, 19 Mar 2018 16:06:12 +0000
Message-ID: <20180319160513.16384-41-alexander.levin@microsoft.com>
References: <20180319160513.16384-1-alexander.levin@microsoft.com>
In-Reply-To: <20180319160513.16384-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0805;7:CxlYQBxGMCquKAmb4f9oLiykkmiUU8uyIoTyQ5iirFx+582IHbKSBCx1W12v/m1BHhZ2bl900EubTh9I9WMRfmkfWr/VuKRiUCp4qlqP7kKh5P63+NjjEOVJ/+dFyoi00nzgBx+/iOxHh28DQL/j/Pwk252d43MR8513AEVhVDe9rfc67oKYxW2z9EjMdY9ILcHN5ytVStvFVRIgA24vDR76FPdvwjG70ZJwWYPIL85JlAkxRE291bNHQ2qH6M24;20:YV9FPTn92Tb0EPxKU0Mn8IqvN9ZDFCrWNYgcl8V+PX4wu2haOexaCLJPi9VZHz42qpfMbQ2E7nsvcDxiuh9TAveTX6li7DYXWvWTBvFTJysGMoKGpjUDQcfVQPA2hemVM84ktypx6D0KBM8AtqAuufIk+roIOz1GxD6Rw1bNr58=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: ced1932c-876a-4fb2-2740-08d58db389c5
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0805;
x-ms-traffictypediagnostic: DM5PR2101MB0805:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB0805EF080E2EFC961EF3C4BDFBD40@DM5PR2101MB0805.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(58145275503218);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3231221)(944501300)(52105095)(3002001)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123558120)(20161123560045)(6072148)(201708071742011);SRVR:DM5PR2101MB0805;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0805;
x-forefront-prvs: 06167FAD59
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39380400002)(376002)(346002)(366004)(396003)(39860400002)(199004)(189003)(2950100002)(305945005)(186003)(86362001)(6506007)(3660700001)(6666003)(5660300001)(6116002)(8936002)(3846002)(1076002)(26005)(7736002)(6486002)(2900100001)(6436002)(2906002)(86612001)(68736007)(81166006)(81156014)(10090500001)(102836004)(8676002)(14454004)(105586002)(107886003)(25786009)(478600001)(2501003)(5250100002)(53936002)(3280700002)(316002)(54906003)(4326008)(6512007)(72206003)(66066001)(22452003)(10290500003)(99286004)(76176011)(36756003)(97736004)(106356001)(110136005)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0805;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: 4BHWJqTKAXg8GvjfLaKH1go0XDaPNSEpefv7kyF/VrqJ0oQSorN3kiPAWrADNa+Mj0LP6yTbieRfqdUe/WxYx373SQGee91UNTEtTxqjISglBJopql2zS4eKrDOcdFKj/E52yX9oaeN1Bug8uShtUujXIlyp/5dDK7srfuAnIB/GZH252jvvDw2OvkCzS0T5iFeUdyHJE20kIKOpTJNL47vWaPw0azoCuh55HvKXQLu2kYBa1ssZWjcGXJO8wYGnyUUq73SXkRYxYBMsEvHJIxc5IaFMbvzq3nbSbyK65eCsxkzAtRMk5yJQcIlwLoMUH8mYipwTu+CJWFdQPPYCvg==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ced1932c-876a-4fb2-2740-08d58db389c5
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2018 16:06:12.4979
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0805
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>

[ Upstream commit c034640a32f8456018d9c8c83799ead683046b95 ]

When platform_get_irq() fails, it returns an error code, which
libahci_platform and replaces it by -EINVAL. This commit fixes that by
propagating the error code. It fixes the situation where
platform_get_irq() returns -EPROBE_DEFER because the interrupt
controller is not available yet, and generally looks like the right
thing to do.

We pay attention to not show the "no irq" message when we are in an
EPROBE_DEFER situation, because the driver probing will be retried
later on, once the interrupt controller becomes available to provide
the interrupt.

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Reviewed-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Tejun Heo <tj@kernel.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/ata/libahci_platform.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/ata/libahci_platform.c b/drivers/ata/libahci_platform.=
c
index aaa761b9081c..cd2eab6aa92e 100644
--- a/drivers/ata/libahci_platform.c
+++ b/drivers/ata/libahci_platform.c
@@ -514,8 +514,9 @@ int ahci_platform_init_host(struct platform_device *pde=
v,
=20
 	irq =3D platform_get_irq(pdev, 0);
 	if (irq <=3D 0) {
-		dev_err(dev, "no irq\n");
-		return -EINVAL;
+		if (irq !=3D -EPROBE_DEFER)
+			dev_err(dev, "no irq\n");
+		return irq;
 	}
=20
 	hpriv->irq =3D irq;
--=20
2.14.1
