Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1086562-1520490130-2-10149650961399227768
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES unknown, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520490129; b=JWkoVuxuJA0lr7mi6LHprToQfH/SWqJBB3meEO72PaMAg6S
    /9FJpPiEZPHY4BLpX/zHBiPnopw3DOlfVWGGBHNudJnz5y9DxDpPMfRm9LzAgWhb
    tFJBxtWxuBdzn9duKO/MhY+3tzBtGnBa4V9dE0XfXPygOfJCV3o/Lcvm+j0/ucNo
    4AEczavQL4iKGn3Dt4J+SuQ0FNkYKdb1402+BXZPgDEZlH5NGlcSOzNyVCO2dWoB
    Rj/n5YiRqwU+l9oFKhrXBWgOnqJNO4iSoFxRJjRf9eBIH5uvEp2RNRON81qhiKTd
    Wyv18RTelhToycvTE1ddI+fSfEdEYNOWrfTuArQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520490129; bh=aSF6R+
    tTEIEgf2wq1pB9AkFTGd7JEVy8c8NAFn+X29U=; b=SbCvgPArgtMua5mnG6W/3n
    PCWET8/VloXDWwsb3XvDYOJAd892Dy+9RxJ4IXbh4GPzqrtOqZL3PqLY0VMoSraa
    WqkoHQOHprfkf8y+ZyjcPaN2iWEyKgcWobpfgneC/GvwtNYC/MgaEv2co9kJK+5S
    B9GYj4FyEzXUxkMxB27eT7HbTun8W5BnmRYPE/5rGKUPu3UezmMWAV23LqBs7qpM
    k7NdRWpl46Z5yk9FHvoyVWwQ9FxX3S3pktIirmC/XADdCPnE5GuUyYsWKfzLZ2hU
    yB7qKPGU+FUXw2004rL/G252rl5D3YDVT7vTa5kzvXfIpKNbHv5m2Aqso4Z0avEQ
    ==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=d2ilVgyx x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=d2ilVgyx x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935464AbeCHGVx (ORCPT <rfc822;greg@kroah.com>);
        Thu, 8 Mar 2018 01:21:53 -0500
Received: from mail-bl2nam02on0102.outbound.protection.outlook.com ([104.47.38.102]:47872
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S935418AbeCHFAy (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 8 Mar 2018 00:00:54 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Dan Williams <dan.j.williams@intel.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 042/190] tools/testing/nvdimm: fix nfit_test
 shutdown crash
Thread-Topic: [PATCH AUTOSEL for 4.9 042/190] tools/testing/nvdimm: fix
 nfit_test shutdown crash
Thread-Index: AQHTtpoxZdikEIv4u0aF7PYGs69Ntw==
Date: Thu, 8 Mar 2018 04:59:10 +0000
Message-ID: <20180308045810.8041-42-alexander.levin@microsoft.com>
References: <20180308045810.8041-1-alexander.levin@microsoft.com>
In-Reply-To: <20180308045810.8041-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1112;20:C5hi2A6K3OvNEYjk/KUHxK2B9rPNjgpJOoyRUwtG60UHyfOQsbLBbF8nBTp/HIFJkiCBgw2CZsofWViu58SyYCGmu8FttK5tu1yI1sG0RtwrJKNwzFIhHV0H6InBoZUCWjNqgTSQxYylnpJLwsfmZ7LkkawppLmAP4gaGg9FiCA=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 6f0b9e76-faf4-43e0-0f8d-08d584b18aa9
x-microsoft-antispam: UriScan:(222181515654134);BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1112;
x-ms-traffictypediagnostic: DM5PR2101MB1112:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB111214736C945FA315B82CF0FBDF0@DM5PR2101MB1112.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(227479698468861)(89211679590171)(222181515654134)(228905959029699);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231220)(944501244)(52105095)(10201501046)(3002001)(6055026)(61426038)(61427038)(6041288)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123560045)(6072148)(201708071742011);SRVR:DM5PR2101MB1112;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1112;
x-forefront-prvs: 060503E79B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(346002)(376002)(39380400002)(366004)(396003)(189003)(199004)(54906003)(81156014)(7736002)(86612001)(25786009)(81166006)(6512007)(6486002)(4326008)(3846002)(1076002)(6436002)(36756003)(305945005)(6116002)(8936002)(2900100001)(6666003)(97736004)(66066001)(2950100002)(105586002)(68736007)(14454004)(72206003)(3660700001)(478600001)(10290500003)(3280700002)(53936002)(106356001)(10090500001)(5660300001)(102836004)(107886003)(316002)(59450400001)(110136005)(22452003)(86362001)(2501003)(5250100002)(6506007)(76176011)(99286004)(2906002)(26005)(186003)(8676002)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1112;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
x-microsoft-antispam-message-info: qqNwPlTfh7Vjbsd5SIAR12HATUqMtVYt1GAOe/ASGi3igBg20ZkuOqxbQCXqre836A1NZV7xmSYZRpDImEA9xZOLCDFwh7kVF2bBBPv2dcn2Zd+eQiMM59Zc4b7dI6shgWj0hbSMKA1n384U5f3T/9w7NS7mIZC/q4b391OtMl8O+LjcZV05qyxFCW7Y27upv1FW0LtOIFgDsR6ke56cV3fwXec+hWjCqk+Lhr6X5xpXKqR0MB11ugCRG7Bz7IfOs8El3xxDbs9vKB7r28ZgYIpMhQnm7w/DDp02ggD/56r+vvbz7o6KS+iObN+TdAUm/yC4QtgDFMiYfrOyS/Xqkw==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f0b9e76-faf4-43e0-0f8d-08d584b18aa9
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Mar 2018 04:59:10.2251
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1112
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Dan Williams <dan.j.williams@intel.com>

[ Upstream commit 8b06b884cd98f7ec8b5028680b99fabfb7b3e192 ]

Keep the nfit_test instances alive until after nfit_test_teardown(), as
we may be doing resource lookups until the final un-registrations have
completed. This fixes crashes of the form.

 BUG: unable to handle kernel NULL pointer dereference at 0000000000000038
 IP: __release_resource+0x12/0x90
 Call Trace:
  remove_resource+0x23/0x40
  __wrap_remove_resource+0x29/0x30 [nfit_test_iomap]
  acpi_nfit_remove_resource+0xe/0x10 [nfit]
  devm_action_release+0xf/0x20
  release_nodes+0x16d/0x2b0
  devres_release_all+0x3c/0x60
  device_release+0x21/0x90
  kobject_release+0x6a/0x170
  kobject_put+0x2f/0x60
  put_device+0x17/0x20
  platform_device_unregister+0x20/0x30
  nfit_test_exit+0x36/0x960 [nfit_test]

Reported-by: Linda Knippers <linda.knippers@hpe.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 tools/testing/nvdimm/test/nfit.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/tools/testing/nvdimm/test/nfit.c b/tools/testing/nvdimm/test/n=
fit.c
index 71620fa95953..d025eafc09c2 100644
--- a/tools/testing/nvdimm/test/nfit.c
+++ b/tools/testing/nvdimm/test/nfit.c
@@ -1908,6 +1908,7 @@ static __init int nfit_test_init(void)
 			put_device(&pdev->dev);
 			goto err_register;
 		}
+		get_device(&pdev->dev);
=20
 		rc =3D dma_coerce_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(64));
 		if (rc)
@@ -1926,6 +1927,10 @@ static __init int nfit_test_init(void)
 		if (instances[i])
 			platform_device_unregister(&instances[i]->pdev);
 	nfit_test_teardown();
+	for (i =3D 0; i < NUM_NFITS; i++)
+		if (instances[i])
+			put_device(&instances[i]->pdev.dev);
+
 	return rc;
 }
=20
@@ -1933,10 +1938,13 @@ static __exit void nfit_test_exit(void)
 {
 	int i;
=20
-	platform_driver_unregister(&nfit_test_driver);
 	for (i =3D 0; i < NUM_NFITS; i++)
 		platform_device_unregister(&instances[i]->pdev);
+	platform_driver_unregister(&nfit_test_driver);
 	nfit_test_teardown();
+
+	for (i =3D 0; i < NUM_NFITS; i++)
+		put_device(&instances[i]->pdev.dev);
 	class_destroy(nfit_test_dimm);
 }
=20
--=20
2.14.1
