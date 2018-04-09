Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3643807-1523234247-2-8302545201337263184
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
    1523234246; b=HA3w+tjhCa9pZjSTwWGBnRC3mZFUElDaZ7wzlKUIyGpVYfghsm
    bMNts5KNQsCSGpQExy7t9z0FVvddx5NLbAYa9Vg7wkpw1jbYO12oc/5hoXrsQoHR
    TxpW/r2Q3dILju1b9hBVxXsO6Z5/U3ZgiMWj730zvrCseg1i8OnGzesLZYAN42op
    ulEXsIIJnK4rvVG7/RfCawqbd11fnTjjt6NLlHKiO+TQ1XM2H49POrM68XuS5sMO
    hLjSG7DsRztob4hxvIxMBDOElMWiYhui+qCRXa9qQs3RHBXVIUs5P+w4XLfTUYWh
    JzWpbvTT1UG+vK5B0JXySa2MzgKoB/35rJmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523234246; bh=uBdq7XSbbD
    Cv7oSpGP/Q2JYSD4d/ryD4v5L1d+8bfnQ=; b=dcBzB23ykdyW12MKTlVdC9NkT2
    mCQeFObR0aHSM24xCCHOhWSqtmiWiLsYr2cL1G6ZkrC2rMIjFUTnsVCno/Is20gJ
    5zBjdXv4fMOTcxzoA0Z7GrrqZzv4WwSuh704UR1vuQbF7WrhYTIieCkVYPqXghXK
    jl3cqtzA/G1aGV3A3U6WWZewuQe1S6bFfvwphvTcS63Wd3jYlsvmJ9Vz0/9Agqfj
    t7MVu9BM0XvZn5ZsOb3IL6nkbTbWSDGkJmwO+QEQnLrKCrVoM0JII6BwJ61NGRl8
    uTQNkNmGMgnHvtWbtvYtSW+3rAotncWwlVjSO8AwRacoKFoSKnqqW9Ro0L6w==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=L7LheH+L x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=L7LheH+L x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfGdnjwKKqfSBX+GEr4ACfganMBqwhVimGFOMoTPsorwRzB+fKP3Jgz26xMeIbE7+KL74Bda367eDL84+KgJqUbZBQr+LV6rVdSTuvIAUHIBIf2XonYSY
    BXLjeDM6t81TpxMfhtPv6mT2j8RYa4PUAnCtRXoHRXSTXLGkoSWNleNbpchEGfYsLXFnc2I93cvqNnvTS3wtga7Gv5q10euczjT8cm7Djc7It/mLaifvRIm1
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=1XWaLZrsAAAA:8 a=danhDmx_AAAA:8 a=iLNU1ar6AAAA:8
    a=yMhMjlubAAAA:8 a=3rJYTu5vq8WR5-vljKYA:9 a=wPNLvfGTeEIA:10
    a=P4VdviVPEcjfz_PVVggX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932769AbeDIAhL (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 20:37:11 -0400
Received: from mail-sn1nam02on0111.outbound.protection.outlook.com ([104.47.36.111]:14488
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754232AbeDIAhI (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:37:08 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Bjorn Helgaas <bhelgaas@google.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.4 084/162] PCI: Enable ECRC only if device
 supports it
Thread-Topic: [PATCH AUTOSEL for 4.4 084/162] PCI: Enable ECRC only if device
 supports it
Thread-Index: AQHTz5m3OneValn770mQSo2e1BHZkw==
Date: Mon, 9 Apr 2018 00:28:44 +0000
Message-ID: <20180409002738.163941-84-alexander.levin@microsoft.com>
References: <20180409002738.163941-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409002738.163941-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1031;7:s9PKY5udZ9Xoc/e2pYx8OiGaktj9fs+6w6mVQMlUIRNC8e0voQegKqcbUW4/DgR0mlcppF38ACSziH6QYoy7Bx+DTGckX8DhVZ2lhGWSclYXEsK8gOrwSVD3bEjaJsobd7t+nx4hUog9y6u9FFfVhHPIFL80RDqUET9sFpyDq+NdvOpacuYMyhX6gFNglAcUfevkYO1zZpmcdwVTd3AG/oTNHxiumKggzDNKpgT6IwyG2mNMxH7Hm7V5MI56XsJ1;20:mYLd1113bWhvYcTBRQk5W6DxXwlx5bBVNyES8rltqBFcaFhZcufdFnS+GYdct83LQ3UxlVa/DRAcbobGRwzyVeMXU2zb/hAKz23PTjWd3lK2WO2uo9aeXpY0hhBOZT0rjwvcbPmqF4SfQ7ykp0FNMPK2zwxgizF+IjH/FzvwO+8=
x-ms-office365-filtering-ht: Tenant
X-MS-Office365-Filtering-Correlation-Id: 119f9009-6e12-4909-e894-08d59db2045d
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1031;
x-ms-traffictypediagnostic: DM5PR2101MB1031:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB103150BEC5A53D79658652A1FBBF0@DM5PR2101MB1031.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(211254476889703)(211936372134217)(153496737603132)(24339691489775)(211171220733660)(56004941905204);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3231221)(944501327)(52105095)(3002001)(10201501046)(6055026)(61426038)(61427038)(6041310)(20161123558120)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(6072148)(201708071742011);SRVR:DM5PR2101MB1031;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1031;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(376002)(366004)(39380400002)(346002)(39860400002)(189003)(199004)(2900100001)(10290500003)(99286004)(76176011)(14454004)(966005)(7736002)(11346002)(26005)(6666003)(86612001)(72206003)(478600001)(36756003)(106356001)(66066001)(2616005)(186003)(575784001)(22452003)(86362001)(68736007)(305945005)(54906003)(102836004)(486006)(110136005)(316002)(6506007)(446003)(107886003)(53936002)(4326008)(105586002)(6306002)(6436002)(6486002)(476003)(6512007)(5660300001)(5250100002)(25786009)(3846002)(6116002)(1076002)(97736004)(3280700002)(2501003)(2906002)(81156014)(8676002)(10090500001)(81166006)(8936002)(3660700001)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1031;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: B1embu/QWL1lJGiLifsjtc5lbTXdGYg8ifUc9bWvOjU/VST6E8wSD1QjQPyVS6dQaRqnGse8KJvcnhiJjVaSv2K+LDSEHOLgN8ZXfk8i3MUoP8ZjD1ePyQb7fsHW4wpG42yKns3uMFUVLvdfGQcCewNupIjdmJzoFcF6T9ZTf0ZzdqMEYMARTAqoIo6KPAx483ZTUkNpGrnGX6ZMfE6RIgi3r1Z1Vo7R6aq7vgteqtWT5FPCw1zhAPY4tnmp9ScKXfWEUDLdumSy0qtobJej3Z38ZlS9NsNjYNRJwtNT5pgKYJ4mlJDYmD7JdjTRYEPRI+QOiDE1B0goW5ZhunJ5SATN4H1VJ1eI66XwJvtegnO+1kBK7GviQ09L0Fv/3ucb0n9OMIA3SZl2AFeU/QQF5xl3MAFL1K1xudY+zFGuUfU=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 119f9009-6e12-4909-e894-08d59db2045d
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:28:44.7396
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1031
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
index 193ac13de49b..dead38f99068 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -1511,6 +1511,11 @@ static void program_hpp_type2(struct pci_dev *dev, s=
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
