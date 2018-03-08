Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-912290-1520485749-2-1401515460283234319
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
    t=1520485748; b=SU70iGiXXsMSuEQ3Lv6P72ThstW0++eznXM5Ts3q/6HfptI
    PzTLJhcgR9mKyEM17SJ9gOypGjcRQ2w4Ej/NfGEwuAdXuI2aEVvt4rfyxAYRbLp3
    lV1r0nPA5SCfctL6dSFEbUN5Qtp+0GEP9KW+wXmHW8DHGyRYG8uJGXOQdr/Eemrs
    fdCTB0IucWrIot13uJ/LMC7aJz7uiqmJ3FvImCNsjTbOAa7QMWZW7g/Ao+mDQr12
    GHjKsXCwt14aGZji5hA3v4dKkc9y/zb9jGRJoHAwaMKnj7C3xJQA0fEaNo2hKBo6
    7OvVTssNKW304SIZ63i4IeiO7cebR+SwLraHX2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520485748; bh=MZ2C9b
    ueT+7ztQmHtAJFfdhAE3Qnmtr9oSi0kf/EKko=; b=BSQspenz6lsow9vcLBE1es
    J7nRl/56HsHTuQcBatGWO+Pn/ZhKjetbYsyzGT3EJYjMdgmeWRvDWE6Zs93e5yY+
    12HVQ5h3ABovOOUZ3xAYsTNUY6B9wfRk4DBJfPG7tVZKpBCSfdG8yTPSUodRnavy
    q7HfPksAo6iawldB6CU/HdgOoJnIoKc9VdRMq945Be8Yk0/dVuelAYR3z1oPGQOR
    tdcMV/g9j8QQlqbGobFGapzOMj4u84TYJRrjEEvUU5nhrC5zP19r3gyL4SX1/mUq
    UKYNwcjUxqUPww3t5VdVWqcrDOo6ZT/iuq5eSlDxoURf7eU03ffZ0oDPTZhuRSTw
    ==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=Nyl3CnXN x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=Nyl3CnXN x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755390AbeCHFJF (ORCPT <rfc822;greg@kroah.com>);
        Thu, 8 Mar 2018 00:09:05 -0500
Received: from mail-cys01nam02on0106.outbound.protection.outlook.com ([104.47.37.106]:61856
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751419AbeCHFJD (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 8 Mar 2018 00:09:03 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Pan Bian <bianpan2016@163.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 3.18 28/53] wan: pc300too: abort path on failure
Thread-Topic: [PATCH AUTOSEL for 3.18 28/53] wan: pc300too: abort path on
 failure
Thread-Index: AQHTtprGUwKZgh44MUO4de+4yqc13g==
Date: Thu, 8 Mar 2018 05:03:19 +0000
Message-ID: <20180308050230.8876-28-alexander.levin@microsoft.com>
References: <20180308050230.8876-1-alexander.levin@microsoft.com>
In-Reply-To: <20180308050230.8876-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1030;7:xBl10tSDhVfJ+2DQPW9jfUK1uMvJMZvfShHjHo28s/hBlXQsgfpGwBjzDKZ7KFfFdE4j+iNFcKCrCrmVvhmf8pSQTA97RcvgzqRAaszM4sEN1+7QMYaQ8EVtxHeQ9IiFxqAPlfYKXubXsYkGA/r4PBoH8l4kTtuFO7owOWwfwFlGfUM9LmZG3mEazeGl/zQdh2CuoaN1kg9vMlJqeZAQS670Nd9LB+q0Ll4fbzddq0i6xQ9fZYmoOrU1s1vlBOKW;20:lNZjalTLqatsvuiX/FBqUeJGwq1KLURZSSV2jO7LjwHzx283vGX8kdWEN2ewRT+MTwbqxt/v22G9UPJI/dzF3+s8F3Rqo2ONleBFLL7k4b7qpl9SxIZiOUFNgBD491r/yXFUt9k7/6Sa71JgWyaWKXE3ejqtVXy4OaoNWO/cO2M=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 1ce40613-177e-4305-29a1-08d584b2b3e2
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1030;
x-ms-traffictypediagnostic: DM5PR2101MB1030:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB1030A18911C7FCB430597954FBDF0@DM5PR2101MB1030.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(130843839470238);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(5005006)(8121501046)(3002001)(10201501046)(3231220)(944501244)(52105095)(93006095)(93001095)(6055026)(61426038)(61427038)(6041288)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123558120)(20161123564045)(6072148)(201708071742011);SRVR:DM5PR2101MB1030;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1030;
x-forefront-prvs: 060503E79B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39380400002)(366004)(396003)(39860400002)(346002)(376002)(199004)(189003)(5250100002)(316002)(6666003)(6506007)(2950100002)(26005)(76176011)(68736007)(53936002)(6512007)(2900100001)(86612001)(3660700001)(106356001)(10090500001)(99286004)(2501003)(4326008)(14454004)(102836004)(575784001)(25786009)(97736004)(6486002)(86362001)(36756003)(7736002)(6116002)(2906002)(478600001)(6436002)(107886003)(72206003)(186003)(3846002)(66066001)(81156014)(10290500003)(1076002)(22452003)(305945005)(110136005)(81166006)(105586002)(3280700002)(54906003)(8936002)(5660300001)(8676002)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1030;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
x-microsoft-antispam-message-info: kegIrEIjgeoKLD3MgGcsB9nWgYoalVAcWZB2cySx1VZWIij8J9TVM40uFOxLrs6+4KGTlSYSzdtDQrfXFf2aH3+xeq0OTlFk3SS89N84c7VJV+buFR1x9L1zsJvDyYSmSZhO2mPOkRWIXoAhrWZt3daaUR3f9liaycesT9C7YkXVShIjDHnEgxGPmlUPWfvxIBF0FEwEGlwrDs8T57ZADzmn3kLQ/IOFj44Afo5H+722/dQwEjSJ2v4cW3T3eOju+enpJn2aZMypYYkUmWhWIjgU4a3O3e9xPU3eraPeHR3npr3krBp+ZLMwJmwozq74wrfXtPxt30QFe1S3RniufA==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ce40613-177e-4305-29a1-08d584b2b3e2
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Mar 2018 05:03:19.2037
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1030
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
