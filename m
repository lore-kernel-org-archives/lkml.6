Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1131037-1520491318-2-5352357949595101931
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
    t=1520491317; b=R3K3E6UE1GsAkapFtj98YRQsPZrvUMp6zTocXWayQwy8sPQ
    uN4XGF8rvOr7woALUFGdtMws688fw/CKeWutiSFOUvi2CnpRnpi9NisZLSqK+jhx
    X2HqGEbjC8UXiEZdn4bgBdQQPZaYl7oGz9U6NpO9lOw5/NAgYL/Wp5RZdasqlEX0
    RGPvm0/iZJuq2tLYCox3Eb0ixfct7QUURe3fwHN+Kg/mvD95Mt//AFbV0anJvRJv
    FXc/nmTMDe3fEb3eyThbcjIrSvv2AZ18yk0QuKELZbwMVWAOi3mgtUHvuHxnr7EG
    1jDzeGd5NYAhniD2qNGAHUqh5Hg7twWqJISG8+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520491317; bh=kV56e1
    pNxGQRU0/0NhRpBxorcQb3BCoyXTZ1LLE6M2w=; b=NiuPbESrKOCxdny8g4U8JM
    XfhJSsWNkciiSkqVqAa7jM0alGoeNn4nBEYx4CHQelJK/hptVlTFNzasXsFyLpUq
    QCHcVtR56r3w5MLOXam6PV6JNv+hoTQSgmsnuidj8wK3Vsi7ofwSQUmwakNiQtPd
    mD2ktar8Tf6jI7ZPdpYmYF6yRc9n0RLGVHHivfghGQltHPOBKGbXfMXTkMgyVw4t
    AsNuRn2O7ZFSiRkoudj1rRkTIphX9JNBQsuGR0aVpC1OL0hYC4+xmGtKcSb0djpZ
    MfwxqWXdVujr0oYK6GqBVyapav8rt1bRp93JUZAF3Gl2mFfi7LDDuYOaCVT6T7lw
    ==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=LkWQr8AQ x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=LkWQr8AQ x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934966AbeCHE7E (ORCPT <rfc822;greg@kroah.com>);
        Wed, 7 Mar 2018 23:59:04 -0500
Received: from mail-sn1nam01on0102.outbound.protection.outlook.com ([104.47.32.102]:61147
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S935349AbeCHE66 (ORCPT <rfc822;stable@vger.kernel.org>);
        Wed, 7 Mar 2018 23:58:58 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Alexandre Belloni <alexandre.belloni@free-electrons.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.14 35/67] rtc: ac100: Fix multiple race
 conditions
Thread-Topic: [PATCH AUTOSEL for 4.14 35/67] rtc: ac100: Fix multiple race
 conditions
Thread-Index: AQHTtpoAPaMm9JHUoEyrk+Hr3yY26Q==
Date: Thu, 8 Mar 2018 04:57:46 +0000
Message-ID: <20180308045641.7814-35-alexander.levin@microsoft.com>
References: <20180308045641.7814-1-alexander.levin@microsoft.com>
In-Reply-To: <20180308045641.7814-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1015;7:e7HMGuQGe9Ht4Ys1xgqkj3I3jor4Y4vqmojLkJPOZS1FpIoMJS5PDYlzu3Yrk0aL5a4JbjTsbFdmYno25UFJbqaCU1AmJT7E3AQ+XxeSkhaRfOeV0FVRoCs5ajQIWtXc+TFhyqnfZKvu/S1Wu9ytJvQWNZxeGik/kGFSwJZog9sNhShkqspQFKUw8Zwv3ol0EmWlFgqwem1KuPj0kuaLJsF+KjqlM9P7PsaAld/GcsW1eNBopfvFZzi3/zFrvmfR;20:3Dhv8M3WEfmYR8xHMUORSkXSJjM/zeWaquqIOEYGw1AAKVaD0OHfW3TT6zfkCYPZmHK3bE8JS47A3IhCWjLF2HLdTKcbHA6yrCaGgSI+VA268X4rMdPU1go9kSMB62sC/Z920uA/aAX7XUib2w6lQd3hG0gqVAwJc2WpBwxyS5w=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 37093c68-977c-4fd6-8992-08d584b14b44
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1015;
x-ms-traffictypediagnostic: DM5PR2101MB1015:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB10156B45747923C3E4E1FAF4FBDF0@DM5PR2101MB1015.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(58145275503218);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231220)(944501244)(52105095)(10201501046)(3002001)(6055026)(61426038)(61427038)(6041288)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123564045)(20161123558120)(6072148)(201708071742011);SRVR:DM5PR2101MB1015;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1015;
x-forefront-prvs: 060503E79B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(396003)(366004)(39860400002)(39380400002)(346002)(189003)(199004)(6116002)(53936002)(1076002)(107886003)(3846002)(3660700001)(10090500001)(6666003)(2950100002)(2906002)(6512007)(99286004)(8936002)(6486002)(76176011)(6506007)(68736007)(59450400001)(316002)(110136005)(81156014)(81166006)(8676002)(54906003)(3280700002)(2900100001)(6436002)(97736004)(72206003)(25786009)(10290500003)(86612001)(4326008)(305945005)(7736002)(66066001)(22452003)(478600001)(5660300001)(86362001)(575784001)(14454004)(106356001)(36756003)(102836004)(5250100002)(105586002)(26005)(2501003)(186003)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1015;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
x-microsoft-antispam-message-info: gCQ9BsKra/lztqRFvGTWeCjknespYKKkUJW2sI0KGIqUPmBd+tNpXeXq5TM9nrtoyGVjBlqiAWa94GnI7FOi7OjGAljy442atg+uFgX9vWpqMwbVRxXZ/y2RiNTfDtmjj2oC+I0wCq3fSdq7tvlPuhcMolCqqXOqhqGyVlKbeVJOrvtoiZsczelat9h23RDAXtC6jwXiHC2gNlaKo3S03B7ixsSaIKsM2ycUudOWNoi8F8DLubbUo1hk76EfdjYH0Di4EWxCWfVho9UZhAQPTJAPr0YMf+kqUuPi63TbGgao6+G3jNbxtanCPBDLdbeguOTYghwVwuNp/VU+NyPoLw==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 37093c68-977c-4fd6-8992-08d584b14b44
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Mar 2018 04:57:46.8545
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1015
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Alexandre Belloni <alexandre.belloni@free-electrons.com>

[ Upstream commit 994ec64c0a193940be7a6fd074668b9446d3b6c3 ]

The probe function is not allowed to fail after registering the RTC because
the following may happen:

CPU0:                                CPU1:
sys_load_module()
 do_init_module()
  do_one_initcall()
   cmos_do_probe()
    rtc_device_register()
     __register_chrdev()
     cdev->owner =3D struct module*
                                     open("/dev/rtc0")
    rtc_device_unregister()
  module_put()
  free_module()
   module_free(mod->module_core)
   /* struct module *module is now
      freed */
                                      chrdev_open()
                                       spin_lock(cdev_lock)
                                       cdev_get()
                                        try_module_get()
                                         module_is_live()
                                         /* dereferences already
                                            freed struct module* */

Also, the interrupt handler: ac100_rtc_irq() is dereferencing chip->rtc but
this may still be NULL when it is called, resulting in:
Unable to handle kernel NULL pointer dereference at virtual address 0000019=
4
pgd =3D (ptrval)
[00000194] *pgd=3D00000000
Internal error: Oops: 5 [#1] SMP ARM
Modules linked in:
CPU: 0 PID: 72 Comm: irq/71-ac100-rt Not tainted 4.15.0-rc1-next-20171201-d=
irty #120
Hardware name: Allwinner sun8i Family
task: (ptrval) task.stack: (ptrval)
PC is at mutex_lock+0x14/0x3c
LR is at ac100_rtc_irq+0x38/0xc8
pc : [<c06543a4>]    lr : [<c04d9a2c>]    psr: 60000053
sp : ee9c9f28  ip : 00000000  fp : ee9adfdc
r10: 00000000  r9 : c0a04c48  r8 : c015ed18
r7 : ee9bd600  r6 : ee9c9f28  r5 : ee9af590  r4 : c0a04c48
r3 : ef3cb3c0  r2 : 00000000  r1 : ee9af590  r0 : 00000194
Flags: nZCv  IRQs on  FIQs off  Mode SVC_32  ISA ARM  Segment none
Control: 10c5387d  Table: 4000406a  DAC: 00000051
Process irq/71-ac100-rt (pid: 72, stack limit =3D 0x(ptrval))
Stack: (0xee9c9f28 to 0xee9ca000)
9f20:                   00000000 7c2fd1be c015ed18 ee9adf40 ee9c0400 ee9c04=
00
9f40: ee9adf40 c015ed34 ee9c8000 ee9adf64 ee9c0400 c015f040 ee9adf80 000000=
00
9f60: c015ee24 7c2fd1be ee9adfc0 ee9adf80 00000000 ee9c8000 ee9adf40 c015ee=
f4
9f80: ef1eba34 c0138f14 ee9c8000 ee9adf80 c0138df4 00000000 00000000 000000=
00
9fa0: 00000000 00000000 00000000 c01010e8 00000000 00000000 00000000 000000=
00
9fc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 000000=
00
9fe0: 00000000 00000000 00000000 00000000 00000013 00000000 ffffffff ffffff=
ff
[<c06543a4>] (mutex_lock) from [<c04d9a2c>] (ac100_rtc_irq+0x38/0xc8)
[<c04d9a2c>] (ac100_rtc_irq) from [<c015ed34>] (irq_thread_fn+0x1c/0x54)
[<c015ed34>] (irq_thread_fn) from [<c015f040>] (irq_thread+0x14c/0x214)
[<c015f040>] (irq_thread) from [<c0138f14>] (kthread+0x120/0x150)
[<c0138f14>] (kthread) from [<c01010e8>] (ret_from_fork+0x14/0x2c)

Solve both issues by moving to
devm_rtc_allocate_device()/rtc_register_device()

Reported-by: Quentin Schulz <quentin.schulz@free-electrons.com>
Tested-by: Quentin Schulz <quentin.schulz@free-electrons.com>
Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/rtc/rtc-ac100.c | 19 ++++++++++++-------
 1 file changed, 12 insertions(+), 7 deletions(-)

diff --git a/drivers/rtc/rtc-ac100.c b/drivers/rtc/rtc-ac100.c
index 9e336184491c..0e358d4b6738 100644
--- a/drivers/rtc/rtc-ac100.c
+++ b/drivers/rtc/rtc-ac100.c
@@ -567,6 +567,12 @@ static int ac100_rtc_probe(struct platform_device *pde=
v)
 		return chip->irq;
 	}
=20
+	chip->rtc =3D devm_rtc_allocate_device(&pdev->dev);
+	if (IS_ERR(chip->rtc))
+		return PTR_ERR(chip->rtc);
+
+	chip->rtc->ops =3D &ac100_rtc_ops;
+
 	ret =3D devm_request_threaded_irq(&pdev->dev, chip->irq, NULL,
 					ac100_rtc_irq,
 					IRQF_SHARED | IRQF_ONESHOT,
@@ -586,17 +592,16 @@ static int ac100_rtc_probe(struct platform_device *pd=
ev)
 	/* clear counter alarm pending interrupts */
 	regmap_write(chip->regmap, AC100_ALM_INT_STA, AC100_ALM_INT_ENABLE);
=20
-	chip->rtc =3D devm_rtc_device_register(&pdev->dev, "rtc-ac100",
-					     &ac100_rtc_ops, THIS_MODULE);
-	if (IS_ERR(chip->rtc)) {
-		dev_err(&pdev->dev, "unable to register device\n");
-		return PTR_ERR(chip->rtc);
-	}
-
 	ret =3D ac100_rtc_register_clks(chip);
 	if (ret)
 		return ret;
=20
+	ret =3D rtc_register_device(chip->rtc);
+	if (ret) {
+		dev_err(&pdev->dev, "unable to register device\n");
+		return ret;
+	}
+
 	dev_info(&pdev->dev, "RTC enabled\n");
=20
 	return 0;
--=20
2.14.1
