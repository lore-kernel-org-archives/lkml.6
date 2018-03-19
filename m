Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3827995-1521495327-2-3953691826866795842
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
    t=1521495327; b=AnZQbI6f6Jm0lz3Pe0InEvNKq17pDB5Iyda8sp0FcSHu7ZH
    wtiGUmZM8uznJD78VqFm6Sid2OyGrLedICWNwehwITEBAtnVLYNINZLdjN/bL6/5
    mM4IhRgw6O2KxiEDZ2Fuxf7FdQJzo7aCdb9zvmCt1NUXD1SLDnJklYzLsLfwGKqf
    8eVEm5xSPLOyJh409/kdeMne1UT2eQZt76WGQpUgGduBu4Me7R0WrfH+Y8PDlsWR
    ZGXrTb2+7/KBh9DgxDisLgvCG5J1pCvdTiDObSYAW9+xvkT+59TNHNK3Op64EXXI
    nsxQCKKETPV0GqvNrfXHP31ciMmuuSrsVBe4RWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1521495327; bh=OFkya1
    foFaeoSTvw5HgQbXwuPngvZymtX82qWlMlnts=; b=MPOScm6p3aEAL4eKGaxhmw
    LN9W1/gS1rXO7ZRCiSREHySHkLBinTKCimfivMH3zUWiACmrJd9RAfY8CoSY1PJF
    jyVJlPQaK9wI5wpbS9scEz+QjyQZJLC5CcVRnsSrG9ZH7JgIkgvwIR9RkwVdYBYw
    tJvwMsoAKvmoZUwoPyTSFyz/YTBVGholexW1xEG1teD7lj0VQzrwOVQ0ZXWJ5Cv3
    rHbn5PMJYQ0/vW3BIVPFSc8w7Nf/UxE0Yi6L35Ek4288K+yoKJ471iweLpY3DN2G
    c0/F6dBWCf70TJeuwyYWxP3EXrZvUfLMja64ShUYGAusntPds0nycV7y4yFPu1LQ
    ==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=fhcY8DF9 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdduheduucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeejheejgeenucevlhhushhtvghrufhiiigvpedt;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=fhcY8DF9 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdduheduucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeejheejgeenucevlhhushhtvghrufhiiigvpedt;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933614AbeCSVe0 (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 17:34:26 -0400
Received: from mail-by2nam03on0129.outbound.protection.outlook.com ([104.47.42.129]:62208
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S965130AbeCSP7h (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 19 Mar 2018 11:59:37 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
        Tejun Heo <tj@kernel.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 060/281] ata: libahci: properly propagate
 return value of platform_get_irq()
Thread-Topic: [PATCH AUTOSEL for 4.9 060/281] ata: libahci: properly propagate
 return value of platform_get_irq()
Thread-Index: AQHTv5sxfAoI3nq7bkiTpOsGABmXsQ==
Date: Mon, 19 Mar 2018 15:59:00 +0000
Message-ID: <20180319155742.13731-60-alexander.levin@microsoft.com>
References: <20180319155742.13731-1-alexander.levin@microsoft.com>
In-Reply-To: <20180319155742.13731-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1109;7:LG8cmuijSXY3dTqCB/HB7m4M0w9zd2//F+PS2nNsG1K3OrOfZkHZ+oXpeWFCKPFWGUqZrQ6nSoOBm83vithOx5h90QdEiDfFO7w0oRmB+PAiCs32oUx6KFyIph5auAjoowQdMMoz3ImL6r2ADtC5cV+3d+ACRhtHzEYYLGxrAhClzinfxb1wTYuD1Ym5iFL4Y1WU6L7OrycpZKoaGm7o+8/lihS6ibvRCObXBxhh2bTqUxRUmgJenoTwsN1Ps7q1;20:AS4Sy7qkmfT/xwZevfnr4NZZtc8CyGAl6Ee7HbzCb4UxVPQSGvl9+ySxtKQhnrpQh1r5bFsFH41eMUHm7BOYt92WDqtHPy00X+ZOqlObEdRuWhM00v0X2GmbJ5z4MPTOf1fPF6vrmsgZZts0sfPBUJGy3ICPH4GjBpLN61JV0ec=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 74c8fdb3-6458-4923-057e-08d58db2627e
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1109;
x-ms-traffictypediagnostic: DM5PR2101MB1109:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB1109DBF0369F5C9FC04AF138FBD40@DM5PR2101MB1109.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(58145275503218);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(3231221)(944501300)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(6072148)(201708071742011);SRVR:DM5PR2101MB1109;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1109;
x-forefront-prvs: 06167FAD59
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(376002)(39380400002)(396003)(366004)(39860400002)(199004)(189003)(26005)(316002)(53936002)(6486002)(6436002)(7736002)(305945005)(22452003)(66066001)(76176011)(6512007)(5250100002)(10090500001)(2501003)(99286004)(105586002)(110136005)(54906003)(186003)(2900100001)(4326008)(25786009)(86612001)(5660300001)(86362001)(8936002)(6116002)(97736004)(3846002)(36756003)(102836004)(1076002)(10290500003)(81166006)(8676002)(6506007)(106356001)(107886003)(81156014)(478600001)(72206003)(14454004)(2906002)(6666003)(2950100002)(3280700002)(68736007)(3660700001)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1109;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: EZHHhrj07xbTQ22TtkREPLP4aQXkC23YEdRTsCVoudosdeXV6ncqBt1hIMjoiC3N/HWKuJgv1KX/5+IwSzNU0kBDyqRARAlIcfL+o9z649BUxNvPwZ8m/PRViXlk0/GCFniaKpiXfbFtRjwdTVat2wx1XEgyvAarM5Evcp58Ir2RKvjrCMcE+nIz60e5DxSwvNFUEdrOZuC+XhTpo4Pdu6qjxM+AKM/iRlDqZmmsaf4H2n0qyrpuTxebTYsLifz6/Snm7GSnuvA5JjVig4vh7bCUa7ertkx33j9K209fYOD0lGM3dprpBy/0WkaC9Rd1TwA+Ds89mdsifabIdJLUYA==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 74c8fdb3-6458-4923-057e-08d58db2627e
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2018 15:59:00.2283
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1109
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
