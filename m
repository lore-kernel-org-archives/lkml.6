Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3992186-1523244008-2-7684001670459186443
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523244007; b=gaAQnFw6oydQ3ZQGUWgqQppqwh3H0vOAkD2ZOogO7eQ/YuSNfK
    cG9jqkBsvJDfEU+zOUqn/4s7y+uLt1MiRxxCpSZo06uv6EWDiFRrXr4Pt0BVH2tC
    H03pdFt/FBV+kSLgJ50EKB/jLTEoi6mRKciPmQo1xngL24tMWmGrl/mddRv2IIAo
    O4woa8UeaM4rxD4pCmtUtd7D8vGlb5UXrtbfFgjX9rRMTAwl3GaNJFrBKTHjrN1v
    Lz97o7lDKI1vZ/ZHRAMfInSXovCcFB2T/MvfDI4+EanoAVSoyrlPKTvHtZEubdKI
    bMB0DBqGAWcJqEpvO99pvT3hOtkfXPMqNktQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523244007; bh=gm4C/MWDp6
    rBSLYwG3Wq5coBTPdNxmjmILiiVK8o/hc=; b=v6r40njpKE+wV8pdMWmSZ61Ewj
    cIuy4pLNMT3qJbtn4ZjXXZQsWeTJKXIF+jWs5neSJXtB0Vn+xb7tlp00TviIJbZ6
    p6aFH/ZU5PWWbkx/o4CzjhipTHLM+mRZgI9OdymimNXI7itmAB3grDEPyKQhSysb
    XR4lSYldNT4+OFicCpQjxUTk5PUcY2JJd7W4u/qeyj32A7WeRCuJ4FaI55dFGUDj
    w92RmWfpsUEW9fasT25lXy3UCFCPYRBlyUY2RsiqnbtTVW5xp2jdivUb5B0IQ14W
    UUxUXmmO2eJ1ksJjiwlcSxPQaOgAlbkN3Z5slFDQCoEFA6MKOE8d6riT7qeg==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=EzjMOHEb x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=EzjMOHEb x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfM4b5eiRm9/23qUFyTVwPvYWBxLTTMRzzdSRU+yz4E3CDevqmPT8gWHBCzZEDkmDNvskXpmgfV7yNRllm8jfIyY/SzIGIbbBHss0Yb3W7s+w9jtZZXMS
    70A9Cj2WkK+7U92FVkmEpenVb0ia0hEcEIvYLmSMoVdHKGZbXoON/dbO7zbRNz3Lou1nMiwz1S/ufr3mzyi9OGzDsQuG9Lpzpt4GB7W7np1EzhFQGfMCoED/
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=i0EeH86SAAAA:8 a=EGYj-OwPAAAA:8 a=fk1lIlRQAAAA:8
    a=yMhMjlubAAAA:8 a=q7ZBISJrZ0O5DTBrg2AA:9 a=wPNLvfGTeEIA:10
    a=xQyHFheebwQZ3wMG2Lhb:22 a=U75ogvRika4pmaD_UPO0:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753028AbeDIDTy (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 23:19:54 -0400
Received: from mail-sn1nam01on0134.outbound.protection.outlook.com ([104.47.32.134]:37792
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753064AbeDIAXC (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:23:02 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Wei Yongjun <weiyongjun1@huawei.com>,
        Corey Minyard <cminyard@mvista.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.14 050/161] ipmi/powernv: Fix error return code
 in ipmi_powernv_probe()
Thread-Topic: [PATCH AUTOSEL for 4.14 050/161] ipmi/powernv: Fix error return
 code in ipmi_powernv_probe()
Thread-Index: AQHTz5iPdjDcmnUi6ki9a7REQKfxxw==
Date: Mon, 9 Apr 2018 00:20:27 +0000
Message-ID: <20180409001936.162706-50-alexander.levin@microsoft.com>
References: <20180409001936.162706-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409001936.162706-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1014;7:ZaNPRybYTeDZXsG9OVSArphgmxYVeaJTZRMROg+PkQDGYiJ/dbtgPoRMWHRkJ/bC6nZ2akycIRFjO0J3ahStodxBtiL79LnLrQTGaElJpKpIiRNLT0Bfy7AQHOiHlCAT+TRyFn1MOabApyfI8MhShoywKuZogxn2YaMKGtZkUI9B2Xk7Axcttkjheh1Peyewna0nmWT87c4JhpvNw8xJROXtd809o79Mb2e5wTpCjIagsjz56iS+ofErQFp6CdXK;20:3ZPUpjgT5FSVLBWoy7oTpafqtGWa1if4jkXqfXiJ4lK2arCE5OxMM0vhKdas8oPwLCRxlMoQyofZkqoHvBgdgSMLFwVP49T390Htq/fN3O+5q/ukN4+khrTypL7kGW/FRFE1YlOdUY3OjwL5jjI1f7KZVfhlj3Ak8NbZeDSjGyY=
x-ms-office365-filtering-ht: Tenant
X-MS-Office365-Filtering-Correlation-Id: b50ba66d-2d86-4e2e-ce0d-08d59db00b81
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1014;
x-ms-traffictypediagnostic: DM5PR2101MB1014:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB10146F6FEB8057A8F2A8D28AFBBF0@DM5PR2101MB1014.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(50582790962513);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(3231221)(944501327)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(61426038)(61427038)(6041310)(20161123560045)(20161123564045)(20161123558120)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:DM5PR2101MB1014;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1014;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(366004)(39860400002)(39380400002)(396003)(376002)(189003)(199004)(81166006)(81156014)(478600001)(6436002)(72206003)(575784001)(8936002)(10290500003)(106356001)(99286004)(86362001)(2616005)(7736002)(2501003)(6666003)(446003)(4477795004)(476003)(8676002)(11346002)(105586002)(305945005)(5250100002)(6512007)(53936002)(68736007)(107886003)(66066001)(86612001)(2906002)(14454004)(186003)(22452003)(25786009)(4326008)(2900100001)(486006)(36756003)(6486002)(3660700001)(59450400001)(54906003)(26005)(3280700002)(110136005)(1076002)(10090500001)(76176011)(6506007)(97736004)(316002)(3846002)(6116002)(102836004)(5660300001)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1014;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: UYxTRFyuS4vtWXEJtNB1uNYfyW5ZYFsyfNHauij73zV7/T5XkwNiW1KGd18nMbBMYeygage5BBXhLoddAbvcKtpfYWdKrWGPxlnOFnDIgpoCm6scA56YtVnwuQCjL2xgQOMqhaWf1E7IpGJz2gyxW3gUEsX9Tl5DSLUPZ/qLhsy+PfB8C/upvqsbxJ++Ye+TkqR6BaxPKGNrz/kRBOUGQAtcknV9rJBrmptKPami4Maq6dgcarNP7VZAjObycivInv3sPXrDLSE5hWDLwV4VzAW0toMj8TdH19kqbWjE79IZIzxwEHXrc80vfhf8i2qxXR3gKj6NZ/fUck83COCAayggVYnHFuI9UWGnmeg7sEszUdudCSPWCXfqcrEdltdt0oNxNdJg/Ezjy2ishIa82Oy/5PR2LlhWca5EluQ1DvI=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b50ba66d-2d86-4e2e-ce0d-08d59db00b81
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:20:27.0194
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1014
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Wei Yongjun <weiyongjun1@huawei.com>

[ Upstream commit e749d328b0b450aa78d562fa26a0cd8872325dd9 ]

Fix to return a negative error code from the request_irq() error
handling case instead of 0, as done elsewhere in this function.

Fixes: dce143c3381c ("ipmi/powernv: Convert to irq event interface")
Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
Reviewed-by: Alexey Kardashevskiy <aik@ozlabs.ru>
Signed-off-by: Corey Minyard <cminyard@mvista.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/char/ipmi/ipmi_powernv.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/char/ipmi/ipmi_powernv.c b/drivers/char/ipmi/ipmi_powe=
rnv.c
index b338a4becbf8..845efa0f724f 100644
--- a/drivers/char/ipmi/ipmi_powernv.c
+++ b/drivers/char/ipmi/ipmi_powernv.c
@@ -251,8 +251,9 @@ static int ipmi_powernv_probe(struct platform_device *p=
dev)
 		ipmi->irq =3D opal_event_request(prop);
 	}
=20
-	if (request_irq(ipmi->irq, ipmi_opal_event, IRQ_TYPE_LEVEL_HIGH,
-				"opal-ipmi", ipmi)) {
+	rc =3D request_irq(ipmi->irq, ipmi_opal_event, IRQ_TYPE_LEVEL_HIGH,
+			 "opal-ipmi", ipmi);
+	if (rc) {
 		dev_warn(dev, "Unable to request irq\n");
 		goto err_dispose;
 	}
--=20
2.15.1
