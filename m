Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3607359-1523233313-2-6409935053672607505
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523233313; b=jCu/Bm2QuJ1CpRlZEGsuRKoEXo41bOrcxeJW7jcZvMA/79Wlfs
    93ZkYVJJ0TMvxMqgE9/4EnGR1jR85pmLQGtyYYghU1mXefQJ1Wkk+CbbXu+HN/m3
    Ozi7ZZu0yaMnJ5joeMnd4dKFxnWILdIte3TmGfvxLwX9TfXnRAwsd4Y6GyjalKT5
    YkMZWif45Sp9NeqRNHbDIg/dbeMVAiCAjymipbA6puSorIm4MToQn3qA+5BgqO8Z
    MraMTSvXFEM9Nl3z///fnnCTMENOpP+Tqw4EsK4jNnP9m5cI5Rp5o0bc8BC3AbsB
    Bwu5hKcFeZY7qjWiYQofq4GRSrNvI5YDbudw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523233313; bh=5ZT+2xRqeO
    I4DGJVTtfGyt+6ypj5gkYGPFvEEnttplo=; b=C8m/1iap1b6dIVdkfmFnPHoiMq
    mIEbWegh9x5X7B2oSbinXZGbjVvQebfvXIOrgm1FxHaf9zwR+yrRTtx2KgGnYyYt
    yqg4ruHUpH7gpsjl+8j+kq7Jb6Mxj0IvKbGkJXeCRSqdL9CiNgvIOP+TXvF49gyf
    C2+QyzwJ0Jmf22OMZkYxVB6d1KrZVH+9g8Vydt3jbMwXCN+xfA02Sjv4vavZzBoZ
    6ifUbZ+sxzRH1Yg8pQKIWemC7YgKI4hi4rjta3XrLii5C4dN5XUUL+0J3oEFJ+FV
    vWkiUgK9i6OCRnaKiNlYZ3l0ujjHHsLlvmuZMLuCCQqgIVziGzPH6n2P1Jcg==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=UgF1EtPP x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=UgF1EtPP x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfGqewQnWlNY+CDIjirCoBHbWZpAqWwsZWIN4f2xX5EwUWEK+OU7/jfAqiOG/hvflIfzMcrrXx61X9sbWw1cm+Dc0SF7kvKnBy+PG1sJgqkOKgfXdBTZ7
    lN8fJ3+6g24vQOZI7a/BNge5uv+p49b5bGcPAfb2Qbx5/qkD08hJz1u2gOZ9cXyERvzPZTubfGPRV5rbX7YnOYNKXkd3WdD8slBqBmNPXSfQHpD0OfpPSLpc
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=2KMo9-giAAAA:8 a=QyXUC8HyAAAA:8 a=yMhMjlubAAAA:8
    a=1Sb6eR7sUUNz6WnTfPcA:9 a=wPNLvfGTeEIA:10 a=UeCTMeHK7YUBiLmz_SX7:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752959AbeDIAVg (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 20:21:36 -0400
Received: from mail-bl2nam02on0107.outbound.protection.outlook.com ([104.47.38.107]:21664
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754473AbeDIAVY (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:21:24 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Tony Lindgren <tony@atomide.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.15 180/189] PM / wakeirq: Fix unbalanced IRQ
 enable for wakeirq
Thread-Topic: [PATCH AUTOSEL for 4.15 180/189] PM / wakeirq: Fix unbalanced
 IRQ enable for wakeirq
Thread-Index: AQHTz5hhfinYRxjnp0CyW2ogxr6J/Q==
Date: Mon, 9 Apr 2018 00:19:10 +0000
Message-ID: <20180409001637.162453-180-alexander.levin@microsoft.com>
References: <20180409001637.162453-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409001637.162453-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1125;7:VtNEZl8jJmcEF7wtNMGqr/MeSJNtjCbyXF0wRH1PXEQj0yn3L2O3r5YTZr48CrTKluVLJunVxWwfTDteuZ/Bx61BwIGY33cPOu9YDi5eYe74qq7jEoOqb8IK4eok/x/wD31dM9l/J+vmYcjncb5McDtp7Mif3gQjKkyEhcOpZn8QO2Bfa3OK7VbKwDbMRtiAynY970aQT2aS1iJWYH/6gCjrHQm4W8nHb6jUuqc45EjbHUAydJTwnIfDQ4J1stB0;20:2Vi2R79eoecGZbNiDzeH62B+FMYb8WOqfV9byZwwphM/2HzX7VE++SZaIaihe2ogknteOseSw1N+9QgMNVv6T1RcSUHefxAbwvnoncIqGtGGJYA1yTDS90pPv7I4XjavqvrZz//cHCJhC5H5ZPebZEIy6snu4GI1ArVW6jMwhbI=
X-MS-Office365-Filtering-Correlation-Id: ea38f4c9-dc38-4f83-0468-08d59dafcefb
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(4604075)(3008032)(48565401081)(2017052603328)(7193020);SRVR:DM5PR2101MB1125;
x-ms-traffictypediagnostic: DM5PR2101MB1125:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB11255CB05D618D0BEB69B1C8FBBF0@DM5PR2101MB1125.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(228905959029699);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(3231221)(944501327)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(61426038)(61427038)(6041310)(20161123560045)(20161123564045)(20161123558120)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:DM5PR2101MB1125;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1125;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(376002)(396003)(39380400002)(39860400002)(346002)(199004)(189003)(105586002)(7736002)(8676002)(97736004)(81166006)(59450400001)(106356001)(81156014)(305945005)(14454004)(66066001)(1076002)(102836004)(5250100002)(478600001)(2501003)(2900100001)(22452003)(72206003)(68736007)(26005)(86362001)(8936002)(76176011)(6506007)(6116002)(6486002)(186003)(5660300001)(3660700001)(316002)(54906003)(110136005)(25786009)(2906002)(10090500001)(6512007)(3280700002)(6666003)(10290500003)(53936002)(99286004)(86612001)(3846002)(6436002)(486006)(4326008)(2616005)(11346002)(107886003)(36756003)(476003)(446003)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1125;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: uIMb9Ez8M7KqBkLN0gO7txeBn6PYpGDACV46yYe5Dzl4K5p2RrTBishTFIgV6W9+8Bpu5sZF3e4F+zbY6OCv2SU2HhMrZWg/8XRQJ71Iw71B1Cs5Df10mwX8Sb6wYoBJ5oT/Z6nC9BAKZ5sFXKggslukG/KfSx0tAimOgPrb4wovvus4VPNScj8qplj33APu0aTmE0ydOVGXmYneSqswdqjZXpkpoFAANgokgkmt6MsR38YrfIt3K2Z8kstTkpKExciYVAaIOBaKo7WowjppexRpeD5IFT91t6P6w9Zqch5l2l+2NMdfsPJppSEvz87G7K+lKbCmDZw9h1xrJBPDDdt6rbtbLPeDKYd8alR/1hC0Z85AEXlDq7mlbms4RD5So8vtQQuRgNaRnnpPt3TsSlf8SUrYN0DqJiP/nOP1hag=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ea38f4c9-dc38-4f83-0468-08d59dafcefb
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:19:10.8457
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1125
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Tony Lindgren <tony@atomide.com>

[ Upstream commit 69728051f5bf15efaf6edfbcfe1b5a49a2437918 ]

If a device is runtime PM suspended when we enter suspend and has
a dedicated wake IRQ, we can get the following warning:

WARNING: CPU: 0 PID: 108 at kernel/irq/manage.c:526 enable_irq+0x40/0x94
[  102.087860] Unbalanced enable for IRQ 147
...
(enable_irq) from [<c06117a8>] (dev_pm_arm_wake_irq+0x4c/0x60)
(dev_pm_arm_wake_irq) from [<c0618360>]
 (device_wakeup_arm_wake_irqs+0x58/0x9c)
(device_wakeup_arm_wake_irqs) from [<c0615948>]
(dpm_suspend_noirq+0x10/0x48)
(dpm_suspend_noirq) from [<c01ac7ac>]
(suspend_devices_and_enter+0x30c/0xf14)
(suspend_devices_and_enter) from [<c01adf20>]
(enter_state+0xad4/0xbd8)
(enter_state) from [<c01ad3ec>] (pm_suspend+0x38/0x98)
(pm_suspend) from [<c01ab3e8>] (state_store+0x68/0xc8)

This is because the dedicated wake IRQ for the device may have been
already enabled earlier by dev_pm_enable_wake_irq_check().  Fix the
issue by checking for runtime PM suspended status.

This issue can be easily reproduced by setting serial console log level
to zero, letting the serial console idle, and suspend the system from
an ssh terminal.  On resume, dmesg will have the warning above.

The reason why I have not run into this issue earlier has been that I
typically run my PM test cases from on a serial console instead over ssh.

Fixes: c84345597558 (PM / wakeirq: Enable dedicated wakeirq for suspend)
Signed-off-by: Tony Lindgren <tony@atomide.com>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/base/power/wakeirq.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/base/power/wakeirq.c b/drivers/base/power/wakeirq.c
index ae0429827f31..67c50738834b 100644
--- a/drivers/base/power/wakeirq.c
+++ b/drivers/base/power/wakeirq.c
@@ -323,7 +323,8 @@ void dev_pm_arm_wake_irq(struct wake_irq *wirq)
 		return;
=20
 	if (device_may_wakeup(wirq->dev)) {
-		if (wirq->status & WAKE_IRQ_DEDICATED_ALLOCATED)
+		if (wirq->status & WAKE_IRQ_DEDICATED_ALLOCATED &&
+		    !pm_runtime_status_suspended(wirq->dev))
 			enable_irq(wirq->irq);
=20
 		enable_irq_wake(wirq->irq);
@@ -345,7 +346,8 @@ void dev_pm_disarm_wake_irq(struct wake_irq *wirq)
 	if (device_may_wakeup(wirq->dev)) {
 		disable_irq_wake(wirq->irq);
=20
-		if (wirq->status & WAKE_IRQ_DEDICATED_ALLOCATED)
+		if (wirq->status & WAKE_IRQ_DEDICATED_ALLOCATED &&
+		    !pm_runtime_status_suspended(wirq->dev))
 			disable_irq_nosync(wirq->irq);
 	}
 }
--=20
2.15.1
