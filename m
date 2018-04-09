Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3828464-1523239625-2-10746906146801673256
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
    1523239625; b=iW3lY2jZCJ2/ANW0ILGlX37IqkhcQIn2h0lpoLYdCwyqd/tsoA
    khxa0O1jpTp7SKod4OLc21yf/3XmY8jw8dJN9WFOxoHFK1UfAhVRXv5KtRZV7umS
    Y4558qqjczeFeFmI+bHclTpr40KvBBFZKwjHXusMQaihJUzqq0GySA0H2KU+zl3d
    jF4gtagBOQ7k3uI5rgy12TB95O8yZzPUa58UbLXa4FF8ZWOcdd7zfJ7Qs0mEsyZS
    4VjQq2ZAC6t45keY8DPoYTUvJ9CTqw0C8u2MbufJQrNlVEDIDZ6UmQnWCCQz+1ye
    B750KP+KtRyQpkelOObAFhgUZiSa0hR7Bvow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523239625; bh=i74QuB/baB
    ah8EhUf/8zfE5JSDlEl0W4495P8hvN6Ds=; b=OIWM97PBUH1vT4VVn4iFk83BVX
    kJr86R8zTbI+ETl8M9m7TkO9FyZbCBrLgccK3Bcf5wEl4ykfLH1ob2smpZ4LjXln
    ZT7NGLkr8EEgbRuzyePze5po2QxCAwoTEZmgNy27//yKAzXXj3uWPv5lCIQXal+W
    54Mz802Pumt1D/CJSOlgpNH9+el58qaS/JOMtbcSiZgLS9aH/J1bIls/vTfeDP0F
    KlK2buKkV7uLpPZkOGoP5egPM/uB5XHwR0xRAl/V4Cs+rclLEDTwZPIy72wl29KN
    PmHLTTm3en4SoLR9ZyTLIRrgvfNRfPdKybFMip5UfaFFJ2RLhJYLBqs883KA==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=BsAh6DUa x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
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
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=BsAh6DUa x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfGhvjC8qEflLiKRmABKRQIPjF539fVmNAkqihK1l8KT/Zre6uAaZXmC4zIn1eb9UohGYojfch7lv49j0t8XZX9b4mDnHbJ80NsLRTeg6BjyZzvXSBy47
    8xouoqQlkRwB7V88p8LhaHf0Y9oNcOdfmwLSVWPCuli52CFVbowSJ+lBglOiZG+R2deOLRRs1zgpQyG9jc1pDvxEv2ivRvhaeGcgwCQV48A8qzL+klrrBYYq
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=1XWaLZrsAAAA:8 a=danhDmx_AAAA:8 a=iLNU1ar6AAAA:8
    a=yMhMjlubAAAA:8 a=3rJYTu5vq8WR5-vljKYA:9 a=wPNLvfGTeEIA:10
    a=P4VdviVPEcjfz_PVVggX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756271AbeDIAbY (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 20:31:24 -0400
Received: from mail-by2nam03on0126.outbound.protection.outlook.com ([104.47.42.126]:54752
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754839AbeDIAbV (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:31:21 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Bjorn Helgaas <bhelgaas@google.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 167/293] PCI: Enable ECRC only if device
 supports it
Thread-Topic: [PATCH AUTOSEL for 4.9 167/293] PCI: Enable ECRC only if device
 supports it
Thread-Index: AQHTz5k1l51dP4XOK0KQtNTkA5ebew==
Date: Mon, 9 Apr 2018 00:25:05 +0000
Message-ID: <20180409002239.163177-167-alexander.levin@microsoft.com>
References: <20180409002239.163177-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409002239.163177-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0917;7:XOUqUUJrm00bJVeJH+dBafdtlkRhASiVMnJPzetyR5HWB7E/09FXvM38NttC6B54di1yUenMs3COlg8UZe+Nnf7TKDFyFD5spJlIqTm2jQvyioSFqjcILv6eIZ5mrurQl3M2LQvmAlvPDaeKaFpW+EN/bR7kmwMGz+YjuEfRTAY2s1eRDmPo+YKsYFr0lS+QqSzQgr7rhcq34cbPTs/cYr1WMLIkttE0oYg0S6uDvTv8V8hGSB5QRfVS2tOme7G3;20:XwS9wbcO7A9veUfB5AvnRibu6WI8adbQmCwbGuIRMlSMXCAgIVyJGdIXS2VLy1uK2zFbpTmOr7gQcpzF0qYGi11fSvr6NhFTRxMwjvfaF9YjznARIyWgBCw/p3G10qcBWSi9pwFgsEWPEHn2Sy/qoVXNtorVmE7Z7HHWbSoXt6I=
X-MS-Office365-Filtering-Correlation-Id: 02a20fea-6215-49d1-d3dd-08d59db134a5
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(4604075)(3008032)(48565401081)(2017052603328)(7193020);SRVR:DM5PR2101MB0917;
x-ms-traffictypediagnostic: DM5PR2101MB0917:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB09170B4F7975A89D5A8690FBFBBF0@DM5PR2101MB0917.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(211254476889703)(211936372134217)(153496737603132)(24339691489775)(211171220733660)(56004941905204);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231221)(944501327)(52105095)(3002001)(10201501046)(6055026)(61426038)(61427038)(6041310)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(20161123560045)(6072148)(201708071742011);SRVR:DM5PR2101MB0917;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0917;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39380400002)(39860400002)(366004)(396003)(346002)(376002)(189003)(199004)(99286004)(22452003)(106356001)(26005)(110136005)(478600001)(54906003)(10290500003)(316002)(1076002)(72206003)(186003)(4326008)(97736004)(66066001)(11346002)(25786009)(86362001)(575784001)(476003)(446003)(2906002)(6666003)(6486002)(105586002)(86612001)(3280700002)(3660700001)(6512007)(3846002)(6306002)(6116002)(6436002)(2616005)(486006)(53936002)(7736002)(8676002)(81166006)(81156014)(8936002)(68736007)(305945005)(10090500001)(76176011)(6506007)(102836004)(36756003)(107886003)(2900100001)(2501003)(14454004)(966005)(5660300001)(5250100002)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0917;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: oZs1AM2wbJdsfHCQyNHDgyLZBB3D4gai5mgXKl6Cy3CLXYa6rif7XBPHM1YElFSysFGsXUd8W9Vc6ybvJSNlBEefTZMcMNlgQ0RA4bIlHeLidFJ7fkCamaO3nG4r5rubXjG099HY1Fl2BCwgus0hYo9Wly9HbZDK8bU3dwVYpah76fRXymNE28ty4SS12Tlm5gZUlruMkNVFMHP7t+USCNKFZsydsAYp642gZzrGlgjISAyitpFyWYRqn/xK9RGauRaEpHO4zMLjWQOQHnTY5HqN/mZdfh71E6HFK3rEyAoz1+oFLF/+mkHSdXmuWT19rrmrDpyHD5lj/ppQsAlcaheMGmlS6LLI1m1o+9U5ryYQrgbaipsDDi4FMoZDXaQns0wxgsOw+GC+UAQoRHZTh0UwyJ995XUIABcwDePOwYI=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 02a20fea-6215-49d1-d3dd-08d59db134a5
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:25:05.2064
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0917
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
index a98be6db7e93..7f5178cb3415 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -1536,6 +1536,11 @@ static void program_hpp_type2(struct pci_dev *dev, s=
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
