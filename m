Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3643807-1523235140-2-1089632681831428486
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
    1523235140; b=oG/zePhzjJDdI3VW/ACYFQNw2ujZ+bAPpvPK4vBm8HF6wY9E3S
    J2mCHcMmlFJQSqauQYO2su2zYFbh0xefNcv1bkHA7IP7oq1mMxgtXhIQmYxS/Ka2
    sEj0RqoogDGYK2MnLTjCcmYf9JP0IhBOSYZVjOofx/24xoEfjMycRJOXPoNj1yRx
    249W9Mk3CiViQ+nemMcKj2x+52OgqTgAy6+c80ykQAUNqvi/SifsK9T0d3PV07An
    jxIirdkH9aj6tSh9v/2INo8G0mSLEx1nvlVd+6uDJL74G7BEWZBxcjtKC8DoVtiO
    Dzi7DbuA3fX8jpqHWbQkmVvhMdfoHnV4K3+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523235140; bh=oqKQ9hPGyw
    wQfvi7lsjE/TvgH7Hd37WuQ7FeicrUecs=; b=TEr5ougGMvUwKRq5qSFTFNvfyN
    UZ8ASnYUNLv95fwpkht1eq2UNZ0a31NGxGbbGN1zFfUHBENb99duVx2wpz69kh4t
    P9SIcbW339/fgihZTj2u94P8KBVS/8RdpOkMX/lXnJlDGoSMSkYmBPOHuLutVLvd
    r7nWMOJSu+DR3pLzCmo7GJ3NjbV4+oIzFGWeq5BKSD95CJhGEqLVRkH9tJKYti1D
    Ua3mlNQ676URiBeXivcgPY/Jm6I4Tsn8sBqW4SbiB8s64Dd/VD2iRCnbSPgF0A8H
    SSiiu63O/NSLa0FfBchMPw3+ULwQXik1BmlJ9Sfo855JzkO5Uj962mEyDdBA==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=G15+fzFF x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
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
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=G15+fzFF x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfBQb6038kM7Vz0THl2+VZQIPe+2+/CMXnReGv0USHud30cTQBJm78mkDjlrRr9G+QyM4xZSeH9zgqWqXXI4s4qqZQkbY02ju79PzheR3NAG7W1o+7qU7
    10SyE1uVZN4/+gUXm7WKdqHPVo+pKvuWH9dsDFzVXhs4snfiNZla5fj5ptlf7PHl7kSLj0BqNS+oj7XpzxgM8A/py8kdgHfpf0vpgsAQf95VVgrph2hGp/qA
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=1XWaLZrsAAAA:8 a=danhDmx_AAAA:8 a=iLNU1ar6AAAA:8
    a=yMhMjlubAAAA:8 a=3rJYTu5vq8WR5-vljKYA:9 a=wPNLvfGTeEIA:10
    a=P4VdviVPEcjfz_PVVggX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933423AbeDIAlZ (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 20:41:25 -0400
Received: from mail-sn1nam02on0125.outbound.protection.outlook.com ([104.47.36.125]:29344
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S933414AbeDIAlX (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:41:23 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Bjorn Helgaas <bhelgaas@google.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 3.18 054/101] PCI: Enable ECRC only if device
 supports it
Thread-Topic: [PATCH AUTOSEL for 3.18 054/101] PCI: Enable ECRC only if device
 supports it
Thread-Index: AQHTz5t51TOvv2Nogku6Ab7rIXbTPw==
Date: Mon, 9 Apr 2018 00:41:19 +0000
Message-ID: <20180409004042.164920-4-alexander.levin@microsoft.com>
References: <20180409004042.164920-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409004042.164920-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0870;7:lELPga8Hh4ANbUwuI2ezXhXXksSOXvBthf9XlHDBitRVb6HzUI/kRTYGtCP4N/QY7rdPJK1v9u9/DwrVI+r7xwdCerMQI/e1kceXoc4y86QCSvb9YbSJt3XN6M9HUHl5PrrBfdVe55FSOH/R077nsMLU1/1QHe+zEhKBjkpH/SbdniIq5dLM+JvQ+L08B2X2d8RUVSyfEJefmrv2EFjdje3a+XthLZrZ8bQz3/AueSFEq2Euvykt0jojtek5HK0r;20:TEISnEUY7Brf+CGezKy8v8uSbLvur0X1Yq5mZ8sPBMw5+WGt7HE0HZBDv+YWEZbJgC7ulyMfXEauXyszy1Gk+/kpMGnA9BOpWz9+F5JHucS4C1YqZOLx1o7nA8K+yYBSNF+FzEu+4p4I7qSIXXsjOmqu+FAH70zz9sHPcpUrE8w=
x-ms-office365-filtering-ht: Tenant
X-MS-Office365-Filtering-Correlation-Id: 9368a6a4-2b9a-4b53-5ae1-08d59db29d0c
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0870;
x-ms-traffictypediagnostic: DM5PR2101MB0870:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB0870F0C0FB7A7310D15BDB9FFBBF0@DM5PR2101MB0870.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(211254476889703)(211936372134217)(153496737603132)(24339691489775)(211171220733660)(56004941905204);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(3002001)(10201501046)(3231221)(944501327)(52105095)(93006095)(93001095)(6055026)(61426038)(61427038)(6041310)(20161123558120)(20161123560045)(20161123564045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:DM5PR2101MB0870;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0870;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39380400002)(396003)(366004)(376002)(39860400002)(346002)(199004)(189003)(5250100002)(5660300001)(26005)(10290500003)(2501003)(478600001)(68736007)(8676002)(8936002)(81156014)(81166006)(22452003)(3846002)(86362001)(36756003)(575784001)(1076002)(305945005)(54906003)(72206003)(186003)(316002)(4326008)(25786009)(6486002)(110136005)(7736002)(446003)(10090500001)(76176011)(14454004)(11346002)(476003)(2900100001)(97736004)(107886003)(486006)(2906002)(6512007)(6306002)(53936002)(102836004)(2616005)(86612001)(6116002)(3280700002)(966005)(6506007)(66066001)(6436002)(3660700001)(105586002)(99286004)(106356001)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0870;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: 6aiMFqk68FSPX+92pMsJRrggqalI4DfNsVHoP5jiO/LoswiSY9RYUduIffZ3KUlx8K/50GK/WnHvMyYt6rA+PrFP2cnik5lQ9WQTht6ClEFOAOd2Bu24N4NPWXmyGYD4cvAi0J1AeerXLuzeXR4ku2Irzu8sOscVBqDfR4fV8N/oGcwhGJG49NhCrydBdclYtakcMsy3H2dHUlL2bD4tZg7pY68gvTR8qglSAecOVhCtihUuDDLYb7VYHq7rv75690lvVIop6RYL36L5WkPN/lzpXG6LOxoLc5IW2QUV/Csk0rd8TGzPjDfn3HKlvILYyT1FKO8Bmh43CE+pFqEd/yyVOTpl+As1EK1YxBPD9pcA+7daou4E8iReunIf8C1a0iJvliblmCBSMAhvU+IGi3eeQ6kvmb5f06VgtBIZC30=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9368a6a4-2b9a-4b53-5ae1-08d59db29d0c
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:41:19.0334
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0870
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Bjorn Helgaas <bhelgaas@google.com>

[ Upstream commit 675734baa361cf044033bb60594dea33d8d8da36 ]

John reported that an Intel QuickAssist crypto accelerator didn't work in a
Dell PowerEdge R730.  The problem seems to be that we enabled ECRC when the
device doesn't support it:

  85:00.0 Co-processor [0b40]: Intel Corporation DH895XCC Series QAT [8086:=
0435]
    Capabilities: [100 v1] Advanced Error Reporting
      AERCap: First Error Pointer: 00, GenCap- CGenEn+ ChkCap- ChkEn+

1302fcf0d03e ("PCI: Configure *all* devices, not just hot-added ones")
exposed the problem because it applies settings from the _HPX method to all
devices, not just hot-added ones.  The R730 supplies an _HPX method that
allows the kernel to enable ECRC.

Only enable ECRC if the device advertises support for it.

Link: https://bugs.launchpad.net/ubuntu/+source/linux/+bug/1571798
Fixes: 1302fcf0d03e ("PCI: Configure *all* devices, not just hot-added ones=
")
Reported-by: John Mazzie <john_mazzie@dell.com>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/pci/probe.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index c43300ced57d..b9e843a30692 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -1400,6 +1400,11 @@ static void program_hpp_type2(struct pci_dev *dev, s=
truct hpp_type2 *hpp)
 	/* Initialize Advanced Error Capabilities and Control Register */
 	pci_read_config_dword(dev, pos + PCI_ERR_CAP, &reg32);
 	reg32 =3D (reg32 & hpp->adv_err_cap_and) | hpp->adv_err_cap_or;
+	/* Don't enable ECRC generation or checking if unsupported */
+	if (!(reg32 & PCI_ERR_CAP_ECRC_GENC))
+		reg32 &=3D ~PCI_ERR_CAP_ECRC_GENE;
+	if (!(reg32 & PCI_ERR_CAP_ECRC_CHKC))
+		reg32 &=3D ~PCI_ERR_CAP_ECRC_CHKE;
 	pci_write_config_dword(dev, pos + PCI_ERR_CAP, reg32);
=20
 	/*
--=20
2.15.1
