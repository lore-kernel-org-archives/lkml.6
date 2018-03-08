Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1025811-1520489156-2-18272840443011341452
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
    t=1520489156; b=CZe8W3arJcTEp7UkVqC8MfcTLhK5DXQETjw5ZHz0JIxElJo
    hy4qq2HVsctnVMoNG+lIkrK9UUMnyHcuQtSaSB4wMGh3NjQGEP5vw3ZYMK7VwANC
    pt58jvFpOcPwHHeAolup3DpKMHG4FJ1zLLG2JhP349ZuXFyfsmgfnpAM5bhB6z/Q
    4c2QxmaiMa81/s805aqP5GgtPNf3IO7JcRpwqPoQy0Ggg3TfuXtWdzj8TFeIuRD0
    IH6o/jJsrgoy3BkdtWNqFPMmf9zzNvld8B4076+4ADe0ZQDq5a4pGIIYHADaz90i
    M/JItuEx1L5mO/5ucO3MN/lvA775RyDtW31BmTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520489156; bh=7V6lCv
    06tRTEhR0bj/v5a+WcXCcRd6yJHMxgd/frC8U=; b=O3v8/iF42X1A5xtC9tuElN
    M5u0ne0YyO8a6rMB9TAZB740EEDuk/67i6FFpTm2bvcD3pLU2NLuTG7zCedcIEE+
    +YjFDwfpLQ1qUeKQMgetpUSN5lLmXXiG0Ya/1e9C2AMpe2FUNH2tE8JLGMMY381/
    /b4J+eIGYolQ8g3kqBNbjcHYp82H3NHsPi0HAyLT3TjHT5mPgl2JOXQ7pgg6XdE4
    4M+cXCioD701i3XGU5Cxmk7a1ZUGYiiVDsicAV7vtp+2TmcNMoKUgeHb813fjtBv
    GB6k2v68A790VSX2BnHbcwxDviHHRhjokT/eN9Y2OkyXy7s0PCUgtxePyGN8vwkA
    ==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=MJ6I2sKa x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=MJ6I2sKa x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935385AbeCHGFy (ORCPT <rfc822;greg@kroah.com>);
        Thu, 8 Mar 2018 01:05:54 -0500
Received: from mail-bl2nam02on0103.outbound.protection.outlook.com ([104.47.38.103]:23927
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750705AbeCHFCT (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 8 Mar 2018 00:02:19 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Rask Ingemann Lambertsen <rask@formelder.dk>,
        Lee Jones <lee.jones@linaro.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 100/190] dt-bindings: mfd: axp20x: Add
 "xpowers,master-mode" property for AXP806 PMICs
Thread-Topic: [PATCH AUTOSEL for 4.9 100/190] dt-bindings: mfd: axp20x: Add
 "xpowers,master-mode" property for AXP806 PMICs
Thread-Index: AQHTtppApcpfKVUjTUyMpuhRQzO0ng==
Date: Thu, 8 Mar 2018 04:59:35 +0000
Message-ID: <20180308045810.8041-100-alexander.levin@microsoft.com>
References: <20180308045810.8041-1-alexander.levin@microsoft.com>
In-Reply-To: <20180308045810.8041-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1063;7:CPueq8EfOxCZ/g8wPBbxI2mwlD+VxT19En2KrFc+5F+3x9jvt9UcFSacgQ4MS9E/GK0ZEb/eTtgl8hIAPAXG1JvZzqFlrSqk+UIU76TO5Yvm4g9wMxC/gt/53+oyBQRO38HEUGUF7YCgbz8CwarQ3LApkZV/DUWlj8GoLXwb0bcD06eVC7rsXIAlPZgshRZqgeQzp0X1aMS1qyC++GjThgZknD8qH9SR/Wbj9CqTA/2WKpY/MetD1oMDr9jDZVHL;20:bgj7x6Cd1MGAjPPa1G5MM3xs+OwikzstiUb0deu6Xzw1fn66Zw1e+8XQt1sTegk+Mni33PjvTb9i4mKjhS2uujGgeB8N7n5nViC0h/7CI3MVzhoEnrJPut+RhzbR+tGhAUkRlo0KW5CNg+D7TAYGRGBuIav0YXNmX7VX34ycDLw=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 5e7c2044-b9dd-480d-9462-08d584b1bff6
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1063;
x-ms-traffictypediagnostic: DM5PR2101MB1063:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB10631D7C5A9935C91337DDEEFBDF0@DM5PR2101MB1063.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231220)(944501244)(52105095)(3002001)(10201501046)(6055026)(61426038)(61427038)(6041288)(20161123560045)(20161123564045)(20161123558120)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:DM5PR2101MB1063;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1063;
x-forefront-prvs: 060503E79B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(39860400002)(396003)(39380400002)(346002)(376002)(199004)(189003)(36756003)(186003)(2900100001)(6512007)(3280700002)(6436002)(110136005)(102836004)(5250100002)(99286004)(54906003)(2501003)(25786009)(26005)(4326008)(2906002)(10290500003)(86362001)(76176011)(6116002)(3846002)(6486002)(68736007)(106356001)(1076002)(22452003)(2950100002)(72206003)(6666003)(14454004)(478600001)(3660700001)(107886003)(59450400001)(81166006)(105586002)(316002)(66066001)(10090500001)(305945005)(6506007)(8936002)(7736002)(53936002)(81156014)(8676002)(97736004)(86612001)(5660300001)(22906009)(142933001)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1063;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
x-microsoft-antispam-message-info: sWFTSShFErNzk70Rt8ePo7Ua7rTkP6I8J94gM40sKq+PS+Xa6bsYSEkJj3ObMt0cxACOeIa6uLp4njMxmJBz7+j4MejV924qRUb+nAvfSgcC3AvlXQbidrL7pb4jyAvh8peYbmf4gb7ksVMZhX+kATGJ4MELLTO2LohntWV4nk6aYB7siK6UloQbVcUOCnwbePdgVsALL08ycvIvQnASO7epb2sQkVoG5NSJQRoNUKN8S7nOcYDA7L3faDgr6CA5A6bOR5UrtoxbTXO3e9QdIxoxb80dgOpRfOf5k3X1D3cplk4DoMjlmkufjzIAxeosk1q6JCLzksTH1Xa26/Tr3g==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e7c2044-b9dd-480d-9462-08d584b1bff6
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Mar 2018 04:59:35.4770
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1063
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Rask Ingemann Lambertsen <rask@formelder.dk>

[ Upstream commit 8461cf20d17e0090e9236b73d25b31be4f7fadc5 ]

commit b101829a029a ("mfd: axp20x: Fix AXP806 access errors on cold boot")
was intended to fix the case where a board uses an AXP806 in slave mode,
but the boot loader leaves it in master mode for lack of AXP806 support.
But now the driver breaks on boards where the PMIC is operating in master
mode. To let the device tree describe which mode of operation is needed,
this patch introduces a new property "xpowers,master-mode".

Fixes: 204ae2963e10 ("mfd: axp20x: Add bindings for AXP806 PMIC")
Signed-off-by: Rask Ingemann Lambertsen <rask@formelder.dk>
Acked-by: Chen-Yu Tsai <wens@csie.org>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 Documentation/devicetree/bindings/mfd/axp20x.txt | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/mfd/axp20x.txt b/Documentati=
on/devicetree/bindings/mfd/axp20x.txt
index 8f3ad9ab4637..b41d2601c6ba 100644
--- a/Documentation/devicetree/bindings/mfd/axp20x.txt
+++ b/Documentation/devicetree/bindings/mfd/axp20x.txt
@@ -28,6 +28,9 @@ Optional properties:
 		  regulator to drive the OTG VBus, rather then as an input pin
 		  which signals whether the board is driving OTG VBus or not.
=20
+- x-powers,master-mode: Boolean (axp806 only). Set this when the PMIC is
+			wired for master mode. The default is slave mode.
+
 - <input>-supply: a phandle to the regulator supply node. May be omitted i=
f
 		  inputs are unregulated, such as using the IPSOUT output
 		  from the PMIC.
--=20
2.14.1
