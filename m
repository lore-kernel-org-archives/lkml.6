Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1254417-1520121028-2-14925966335370833818
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520121028; b=AN+LRYDZkjtIoVHomWJ/uuXzahk5n3tdUa1F8hBR5SGfkRi
    xKJoSby08DhR5NEBWDJzkOmwyvNV47AbNBxdIzwWeb3Tqz8tSdp+8S9R1QN8m9K4
    plgxrWuAJ1Tqks0nCMjLb8+gJp4j9ARweHoraBIITgeXCnX5MeQYpPcPvFL6O3AW
    LdI3mlEewAmE5foB9f7XR0I5pYaKzY6272gWNezExrawmJYp0PhKrKIq9zG1+wfg
    rwAr/PSOuPsgQ7fUMHRva6os0+OCjGkmHqr9b8hGSeWL4R+Q2DlHyFKAUIXNdhsH
    DqL028CFmRMPk3+BsLC4+Q6bAluyg/Xg2S1u9fw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520121028; bh=f3jN9q
    3zKjgnCeytot2E1XrLayRj4ts2irYuiwOA8a8=; b=VKzbwI70NRwGxXWwOHzKWf
    k+/qtg1JiVVUd9Kk2PpB89m2lF+wEdKt4UM56UexiQTNGwI/SI+aMfwYCkWlj3pN
    NH87ekEu4QpcK8nKy2GXsyAMIm5H5BcIJLXBpUJH5maZo3yTGLhOQfxHhbGfhNPe
    QkbPenDIXOtAyYP5lk/FotFaCxRzKXRNGbckjR74EahTvPfTo0xb6CpXmU7m+wf+
    rzB8yXnwAFMvqEJsJsYCKsoilr00Du6wrskXhoV65oWpUrbTklYgfqcHfXgKM+M9
    4vrCGgNiHhmVKkl76/ns2gCNR7PrgRtRwppfCRib/ydDZvxVvysBSelYtVffuMeA
    ==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=GM0nfsx5 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=GM0nfsx5 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933747AbeCCXuP (ORCPT <rfc822;greg@kroah.com>);
        Sat, 3 Mar 2018 18:50:15 -0500
Received: from mail-by2nam01on0118.outbound.protection.outlook.com ([104.47.34.118]:24760
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S934018AbeCCWdW (ORCPT <rfc822;stable@vger.kernel.org>);
        Sat, 3 Mar 2018 17:33:22 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Manish Jaggi <mjaggi@caviumnetworks.com>,
        Manish Jaggi <mjaggi@cavium.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 088/219] PCI: Apply Cavium ACS quirk only to
 CN81xx/CN83xx/CN88xx devices
Thread-Topic: [PATCH AUTOSEL for 4.9 088/219] PCI: Apply Cavium ACS quirk only
 to CN81xx/CN83xx/CN88xx devices
Thread-Index: AQHTsz7+4GBRJtVJmEOH4NmRdEyhbQ==
Date: Sat, 3 Mar 2018 22:28:46 +0000
Message-ID: <20180303222716.26640-88-alexander.levin@microsoft.com>
References: <20180303222716.26640-1-alexander.levin@microsoft.com>
In-Reply-To: <20180303222716.26640-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MW2PR2101MB1097;7:GP6oFgIfAeC2xRXgjE1hiMiaBHFt4CLdLt3A04AMwlD5sJHiSMXHWOG5/xIzi8IxTqWFcEvbyOzo77/bDkoNMNhdbHsPdETrAUsYYnPtIbaHPjCiwclS1ovzvfvgr2oDf+gtCTsKIFEEa70Rmaqxg9Gzdn/tSUafu3EtoDyFsdY2RGNZQY6suHrUxf+MCGubOpEyReZtcpYClX1a/28M+BN4Q/ne2f9RL/6meJZul/NI2r2KltduaqAGLYJTKHyf
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 157eacb1-4710-4182-9223-08d58156c39d
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(48565401081)(5600026)(4604075)(3008032)(2017052603307)(7193020);SRVR:MW2PR2101MB1097;
x-ms-traffictypediagnostic: MW2PR2101MB1097:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <MW2PR2101MB1097227AF377F42BBF7E32D2FBC40@MW2PR2101MB1097.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(5005006)(8121501046)(10201501046)(3002001)(3231220)(944501244)(52105095)(93006095)(93001095)(6055026)(61426038)(61427038)(6041288)(20161123560045)(20161123558120)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(6072148)(201708071742011);SRVR:MW2PR2101MB1097;BCL:0;PCL:0;RULEID:;SRVR:MW2PR2101MB1097;
x-forefront-prvs: 0600F93FE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(366004)(39380400002)(396003)(39860400002)(346002)(189003)(199004)(305945005)(105586002)(36756003)(3660700001)(86362001)(575784001)(6666003)(66066001)(2900100001)(5660300001)(8676002)(10090500001)(81166006)(81156014)(8936002)(22452003)(10290500003)(2950100002)(4326008)(25786009)(5250100002)(2501003)(68736007)(7736002)(72206003)(14454004)(478600001)(186003)(110136005)(26005)(316002)(2906002)(97736004)(6512007)(99286004)(107886003)(54906003)(1076002)(6506007)(106356001)(53936002)(6116002)(3846002)(102836004)(6486002)(86612001)(3280700002)(6436002)(76176011)(22906009)(217873001)(19627235001);DIR:OUT;SFP:1102;SCL:1;SRVR:MW2PR2101MB1097;H:MW2PR2101MB1034.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
x-microsoft-antispam-message-info: HuIgtCJH5IWeDlMxYNTTQ8ST9BNEqoTugpDDCPo79X3VWJbM1uRw2aPIQSSKY8yHglqzezf/dddYOtOn+L2EcBLgtIXJCsOawfR8tskU4YLq75NdTNPX+o06ygEja0Zky8fh8CvI7U5vBR9j5N5BtZNhBzFZ0bP2MwiEgR3oAm0=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 157eacb1-4710-4182-9223-08d58156c39d
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2018 22:28:46.9475
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB1097
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Manish Jaggi <mjaggi@caviumnetworks.com>

[ Upstream commit b77d537d00d08fcf0bf641cd3491dd7df0ad1475 ]

Only apply the Cavium ACS quirk to devices with ID in the range
0xa000-0xa0ff.  These are the on-chip PCI devices for CN81xx/CN83xx/CN88xx.

Fixes: b404bcfbf035 ("PCI: Add ACS quirk for all Cavium devices")
Reported-by: Alex Williamson <alex.williamson@redhat.com>
Signed-off-by: Manish Jaggi <mjaggi@cavium.com>
Acked-by: David Daney <david.daney@cavium.com>
Acked-by: Alex Williamson <alex.williamson@redhat.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/pci/quirks.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index 0c9edc9d7c44..4c9fb8b323e8 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -4104,6 +4104,9 @@ static int pci_quirk_cavium_acs(struct pci_dev *dev, =
u16 acs_flags)
 	 */
 	acs_flags &=3D ~(PCI_ACS_RR | PCI_ACS_CR | PCI_ACS_SV | PCI_ACS_UF);
=20
+	if (!((dev->device >=3D 0xa000) && (dev->device <=3D 0xa0ff)))
+		return -ENOTTY;
+
 	return acs_flags ? 0 : 1;
 }
=20
--=20
2.14.1
