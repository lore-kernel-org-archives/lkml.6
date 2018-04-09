Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3878504-1523241382-2-7815858460805667312
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
    1523241382; b=KedMjk5faLx/f3XiHuMDuUb7R3NbPNTTzMSm9GEPZsBG+SPv48
    1ePWpVcE/uCDAKS7yd8bfRvOx/9Y86Iopk1h6REoFtJ2FqktjKdlgexZCXxXF9up
    WpyybaiPuvvu1y5EJTyKU5lsJJXRPYHjOZinbF+2hwlQQ0BXXSfqLuOAX55HZ8zC
    BErYMOohyYK4QhSr1Q02KW8l+z6gT60uaR6Up5/cl/vIrHrbN6kWJ5OhBY3ymw5F
    ONSubhkPyeSTUBK55kXrcxXm043NscIceXdLj99nZUoN/Wprict4Id9hpo4gt//7
    co2X2ja+VlFLhYqmQIUOX4EPSefzpIAg+QWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523241382; bh=i75ut42TJV
    IMSLxDosWmOXTTdXS6D2iYhSbn+V8bz5o=; b=BqXH6sImjYsK4Cs66Rr75eZnXE
    IjJcQVzsvxBWgkGGuf/PFiaIgcqtW4fzPSX6t/JxtrY55VqInebLNlXAO0S+cX7W
    2wKAq8iLMHlRB0ApQHAD+M2Ywgb3KlkNMda57dB2oiH3qrnaA8VitTmenUTQea5D
    2+lC6EJ03D4SgGQgtrL+oDJCnfQMEHkfBi+ByIKd/agF4U0DbQrm2fcxB64LS5Hp
    56pKezRMXwFWnVJGU4OoSs1Y8ai2TV3HocNwZhEXuq1Y0iq0x6QZKdQlJCBGZIVV
    E3MVsRt33hSXQ1pLZcZwtpNAE1qv6KHf3cN4IIspas0vq0f3V9ZiU1uWq4XQ==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=UA2naM7B x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=UA2naM7B x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfPZfvYj0HR83rJcnwUCx/qbPV43ZVY+NH/VPqhI0jaq8ClrYhCWjGQ85oR2lguKU/M8A41Lw9huiCs5dHwQLxTOErl5cM1o/8GYhOBzIyIUlrY2TkLs3
    EWPN6aqRuKMpzK6c2RHxFa3RvCZXHCpRa/8/l0Brt7/EpKWGvb01vVkuP893IZHpbxL6qoiHDcxOFA94SRpT0gnzscpqXJBKwH+HcF+4w86DuIkfnCyLMJxs
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=1XWaLZrsAAAA:8 a=yMhMjlubAAAA:8 a=nGl-eU2EPsOtBl4Cr7MA:9
    a=wPNLvfGTeEIA:10
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757943AbeDICfd (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 22:35:33 -0400
Received: from mail-sn1nam02on0101.outbound.protection.outlook.com ([104.47.36.101]:16522
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1755638AbeDIA1h (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:27:37 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Bjorn Helgaas <bhelgaas@google.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 055/293] efi/fb: Correct PCI_STD_RESOURCE_END
 usage
Thread-Topic: [PATCH AUTOSEL for 4.9 055/293] efi/fb: Correct
 PCI_STD_RESOURCE_END usage
Thread-Index: AQHTz5j+Dbj0nrvKWkm9X434TlRs/g==
Date: Mon, 9 Apr 2018 00:23:32 +0000
Message-ID: <20180409002239.163177-55-alexander.levin@microsoft.com>
References: <20180409002239.163177-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409002239.163177-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0871;7:aZUgbJ1Pwi5theUf2ZXpEF/nnBB8udTmUh/9P90FOpTL3Nr8k+NDbWIHo9tv0vuilby+rqSgXEqQhlJELKaDFMPMCU6BVqYrll9nuB5XodB9vHXWY1epa8hueY0eV8TkRG4L/OgSsS2ymHB60bksilj04mGv5TjeWY7MkRKMm0efRfVv+9xbAJrmvaFcF42N+izHdeXJjoVrVzNjReGi4LmnkEp74HBwdg6UDMKVSCwOmNmh5OE0+JKalkVqRuTp;20:UMNG0N7n2sr8yHZrQGIaRXyi/IVKPJy/seNjiokqN0H6czWcBShKL/V6h3QiAAwVpnB/YIjGQKCwQYyngDOteH6f0S6BhO+hlYj2Npb2BHNvocTzfS7vz95AD5Rjjl6OO6woJIOJ0t5imXqiSLAuTqvhco7ax2jgXgn7oAqZeiw=
X-MS-Office365-Filtering-Correlation-Id: 4f8fc30e-0ac5-423b-a3a8-08d59db0af96
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(4604075)(3008032)(48565401081)(2017052603328)(7193020);SRVR:DM5PR2101MB0871;
x-ms-traffictypediagnostic: DM5PR2101MB0871:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB0871C0CD2A641CA1C3419E17FBBF0@DM5PR2101MB0871.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(211936372134217)(153496737603132);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(3231221)(944501327)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(61426038)(61427038)(6041310)(20161123560045)(20161123564045)(20161123558120)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:DM5PR2101MB0871;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0871;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(366004)(396003)(39380400002)(376002)(39860400002)(199004)(189003)(105586002)(8676002)(59450400001)(3660700001)(3280700002)(6506007)(81156014)(81166006)(14454004)(99286004)(72206003)(110136005)(8936002)(54906003)(305945005)(2906002)(316002)(10290500003)(478600001)(7736002)(53936002)(6512007)(486006)(11346002)(4326008)(86362001)(446003)(3846002)(102836004)(76176011)(476003)(25786009)(22452003)(36756003)(107886003)(10090500001)(5660300001)(6486002)(86612001)(6436002)(2616005)(68736007)(26005)(1076002)(186003)(2501003)(5250100002)(2900100001)(106356001)(66066001)(6116002)(97736004)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0871;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: 0K+NAZutomCaxLm+JDgiAIL1bzjSaUwqEHaqdKQx5kJIr/63KkjU38r5DFbWTdapV8qK7t0uz5K9N9uiLCMh/tdhiX4yajvL7D+5rnzH/nKCjsH+Zx2LAuUFQAhDk1xEaunXez4aeuKpRCp3nv6jNSpm55fpXBitN2D6+oHTiWkkhdB2K4qIGxaNuYw1sWN3g2F9mM31NVYG+pJH7VaCVduBchAEbwy1Jiuj1hM8M7VqYiINC/guqZJ9O/vjtGjJmB20PworEz0MjILw3nwtfLS6E0N29t8SP+FQV0J47k7GhxE9rQK3B/WdS/AuSYiFKvYAwGYEJULyeF+PactsV0hyJ/YpvN4v8KSGrpMPTMU2gV3NnwW7mv/nFWBvq/9rvLBtU/aKv3N3l67AKZJVxr+9Awv7RW0VdinIw1a3Bbo=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f8fc30e-0ac5-423b-a3a8-08d59db0af96
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:23:32.8311
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0871
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Bjorn Helgaas <bhelgaas@google.com>

[ Upstream commit 92a16c86299c64f58f320e491977408ba31b8c3c ]

PCI_STD_RESOURCE_END is (confusingly) the index of the last valid BAR, not
the *number* of BARs.  To iterate through all possible BARs, we need to
include PCI_STD_RESOURCE_END.

Fixes: 55d728a40d36 ("efi/fb: Avoid reconfiguration of BAR that covers the =
framebuffer")
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/video/fbdev/efifb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/video/fbdev/efifb.c b/drivers/video/fbdev/efifb.c
index 6f2e729a308f..f4b6d063a4b7 100644
--- a/drivers/video/fbdev/efifb.c
+++ b/drivers/video/fbdev/efifb.c
@@ -375,7 +375,7 @@ static void efifb_fixup_resources(struct pci_dev *dev)
 	if (!base)
 		return;
=20
-	for (i =3D 0; i < PCI_STD_RESOURCE_END; i++) {
+	for (i =3D 0; i <=3D PCI_STD_RESOURCE_END; i++) {
 		struct resource *res =3D &dev->resource[i];
=20
 		if (!(res->flags & IORESOURCE_MEM))
--=20
2.15.1
