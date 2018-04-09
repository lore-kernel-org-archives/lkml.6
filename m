Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3752604-1523238861-2-1253713001019212101
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
    1523238860; b=LHiL+b5C3zdkA1VE5Nk9wcDPVdTOSxevfyNn7IYnqKmeh4581x
    lznG4hgvy6IxFhVxU3fyxWrRfbXRkdB1sVu8RAsdQd37xblc4ENjhT4ZGf7J3RQ0
    XIUl/85ZhAW6i2xgnTOGidDeJSLrfGWSH4yxrTLT/ReqBoH6AeAp7m9G/GMAwJ3x
    0kUz4YXVKI6+8ys+u0kA5CR4Cx62KUaUGOp/DycZIF/TzkFqYzcgWk4f+20Ig7+a
    NkGnqBj2ojjAAb1qWc9OiOoK91mbNqR5Me1jyTsqthsY1hy31p7cn7v9HjRqhSQO
    SO7jrRLwYvgNlHG4sw0kECmK9AehFN6u+j9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523238860; bh=FFIP7HPrtv
    Ir10thkKgbCTJuAevq0xb9esmBYQsfYKM=; b=kVolE4+TRV5y1iHvZzSuUmthEF
    Ry+KQfEDv4GVRYsN0HNV0O6oAVhEzldN2pG85E3xlxfAAGFqyFZL3rFWDSRe6utT
    oHl7Ury9aLZRNgA6AC5UYgUDVXbNRnK6SMhdYPDAKeGX/Goa7Ng8JGP+uij77/QU
    ZTP9znb5P9UjBKXnK/ksciAThfhhtL4FUSF5xq/f0CEqGZRz7ydcvH/cWY0MwX1z
    0ggy4UJ4Q1jL7JiEB691io2osGSHAGuBYffGZsKG3WcXpO7KmRUJ5VMaGvhY6eqW
    OU+epS08cZ0199glswwd4T4QHAxXvGzyiJ+pM7AL2xSr+68a2vt5tLOR5k7g==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=lT1GY+Yx x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
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
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=lT1GY+Yx x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfDJnq6pBpkAd3ahIZUKEzQbQnvDv6f9DkOC2/R0EpGwr3fsFGr/d+KjJ2k+qZr2hSYNqEMGMjszEHUq7JoElqu5eIqT/2kzEiH00/WHJS3evr9idUYEv
    KFZeyjqjvZo8d/W2ni0ckyvzprqHVPPGLuPi/yy+iZjKWReUhTJeK34Crabr8TWlshZrotOF5PfIbg7CIQwhKhJluqZFRZdgBYanRBR+UuC42XqTEvzkFu1U
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=i0EeH86SAAAA:8 a=EGYj-OwPAAAA:8 a=fk1lIlRQAAAA:8
    a=yMhMjlubAAAA:8 a=q7ZBISJrZ0O5DTBrg2AA:9 a=wPNLvfGTeEIA:10
    a=xQyHFheebwQZ3wMG2Lhb:22 a=U75ogvRika4pmaD_UPO0:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757526AbeDIByE (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 21:54:04 -0400
Received: from mail-sn1nam01on0094.outbound.protection.outlook.com ([104.47.32.94]:49836
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932278AbeDIAdN (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:33:13 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Wei Yongjun <weiyongjun1@huawei.com>,
        Corey Minyard <cminyard@mvista.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 236/293] ipmi/powernv: Fix error return code
 in ipmi_powernv_probe()
Thread-Topic: [PATCH AUTOSEL for 4.9 236/293] ipmi/powernv: Fix error return
 code in ipmi_powernv_probe()
Thread-Index: AQHTz5lUp6OFI8JOGEic0GeFSxpz+g==
Date: Mon, 9 Apr 2018 00:25:57 +0000
Message-ID: <20180409002239.163177-236-alexander.levin@microsoft.com>
References: <20180409002239.163177-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409002239.163177-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0902;7:yb+f1/SZynMzYo2j8leGRw4S+Lsm9rCtCXndsI4fzh0LEFba0/zoNNoVUEDLJd4WV0CJFHhLTqM8+LeATYqir0cm3iCvGjZ+K+IsxZEt4fq2MIkC+58jDVZiGVP06LhYB64k9NmGVZ68YrrIQje1BemQMq4Fv+Z+7Iz4biwApyFuQ6AhW8OVnzz+Lo4aTjH495IFXTuloJF7cTWxl3/lM1Fi3JQgFpXw6PRVkf5D08iIO7sQKBGX191Usgw7tDsr;20:qFzaAvbfHr63gCzCcthsobNdlEdTPBGMXJo5U3so5g+srtkzdWu6pOuY625ld/A277jJ9zC8NKBykUQKXD4e/jdpwq1XISJ3pw6DX66/iX8Fs9QfWUOKb9EZlF84o5MWra+WfSMrPCf3EsG07dDQ4KgZNxtPpH4ooMxUR1IbKLw=
x-ms-office365-filtering-ht: Tenant
X-MS-Office365-Filtering-Correlation-Id: 92d87e3e-e9cd-41b6-d9ec-08d59db1770a
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0902;
x-ms-traffictypediagnostic: DM5PR2101MB0902:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB0902EE620C5BBDB1DFB7E03BFBBF0@DM5PR2101MB0902.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(50582790962513);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231221)(944501327)(52105095)(3002001)(10201501046)(6055026)(61426038)(61427038)(6041310)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(20161123560045)(6072148)(201708071742011);SRVR:DM5PR2101MB0902;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0902;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(376002)(396003)(39860400002)(39380400002)(346002)(199004)(189003)(5660300001)(478600001)(86612001)(3846002)(6116002)(106356001)(25786009)(6486002)(72206003)(10290500003)(8936002)(6436002)(76176011)(2616005)(6506007)(2900100001)(97736004)(26005)(486006)(10090500001)(36756003)(81166006)(8676002)(81156014)(59450400001)(102836004)(2906002)(99286004)(11346002)(476003)(3660700001)(66066001)(6512007)(575784001)(86362001)(53936002)(105586002)(186003)(5250100002)(14454004)(22452003)(6666003)(2501003)(446003)(7736002)(316002)(4477795004)(1076002)(110136005)(3280700002)(68736007)(54906003)(107886003)(4326008)(305945005)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0902;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: UlvCKaS+1kJF0sZkTu+fkWVrmienmO+vSThCMGYz4us8K/Jc2YahopLzN/ItQ2nHk8lFHOCC95625GKSZBqdGskvbqeCGnhlKkbAAInv4fuUIQp8/rfy74dlRbA5hUZnH7GfITP9dIIvHRZ2fir1svk1ydk6DtZce+GpkilqlF+KN9TA9JjFJxgnKLGHiOwgfs9AP61zWObHWWwmpgRkgZUP+qpHvGTftxHXqg0KawEP61nhZNB5yGdQ/+a398S6Ksd/0KYGhQ/ihy81+n1W1bGlcR0TfqTjoB0g+fXBvHsaPcyEqUdzIuB3rUPFKa4CoFmXgSfdkPRIZ0H/uHPC10MPiUI/35adJdLmTj2SKKHxAWg7YgDYaxRRyZWwAJLbUcxXEQoCd50HgdH0bYwyxvfGZ9CM5+mc5MOEYp1jq7g=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 92d87e3e-e9cd-41b6-d9ec-08d59db1770a
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:25:57.4880
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0902
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
index 6e658aa114f1..a70518a4fcec 100644
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
