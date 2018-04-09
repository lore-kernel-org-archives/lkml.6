Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3828464-1523239078-5-9625994907094202369
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
    1523239077; b=LmFASHQXNVs2/2R5gjRP8GPLssK2W96PbvDgAaubNYkmBAKg/E
    esj0pKm4A3/PeGDpDFVNZJARJFUkh4wNSg8EBGZYmHMeJiZ6GqxFYnzntXeqQ3IF
    FsyvaFAISv4T4ADdfPRHZJpi1qOJxb4R72IrITPNvWORcN5kWpYAvOhaS8BMoUV7
    Yy+pY1oZCPT00sfd1TlPrr4clxsuYLkAVdC9Vj63ksw1BUI2djTa3aSKwJ6x9S9x
    3USXOZGDVEIMgiQGd/cijiEwIQXFMSVmBrUbXhaTxHBB1bkIM3RYylOw5au723q9
    0rewKIJu4cESXzLW0eBP52lOWhnxD7PVlE1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523239077; bh=JvgdkM92wf
    ljQl/an9br1kUzLrfaOpM43NHU7AE2KxQ=; b=ntY3PKwGenZfbJ1IeoJ2YTu4d3
    XWGKArVNAYfrngBS6VDjH8qdS3dwfcwChdEFxhHeeAc8F9+nJR2X47GURAAkZ/hC
    2jQxvDE14QOwWjJRJYFd/54/uf7q3nQtEZXNh/rA7KE351xtVmoe2DPpORh6XGmi
    +K4UdJNn1BiZqO0Iri55Qpxt8uM+3Z9v9HRv7Ic42UBOGQB15zCT8GZ8r7yayDZz
    9dJixuJiYcSEddzUvTBEcncqYbhPmDpIbsIelNyqwn2n4hb776CaTKmadtalZpAm
    fjk0b6FfYAFbpPGmzgpeCLiODWdYwKkXLapiLWFe2Hzg+XOMN17cYlcP4DqQ==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=Dv7KAl9E x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=Dv7KAl9E x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfB8UlrAgP28pspqMMu1XJWz3g6pb8u1ETF+X8H+YaloNb0uF/XmH3ifk/BPY+blVpBuWeKfH6BA8DqDU7ACZhGInRjwQFg28DcD4ftHECRdxHHcwBqMc
    JFwtYHiwcMnFzhhn6XmKXOxeaCU5lAuw3ombS6MaeEXY4/ruD9l/baP/sKkpnRLf+dOo83wHgo/+JMhF5OPu6VURMlHxt94OXcuf4/VazidKkwtBZT8f0Lex
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=20KFwNOVAAAA:8 a=VwQbUJbxAAAA:8 a=OLL_FvSJAAAA:8
    a=1XWaLZrsAAAA:8 a=yMhMjlubAAAA:8 a=xZ-MdF6L0uY4eguhJAMA:9 a=wPNLvfGTeEIA:10
    a=w64Ph-BE0T8A:10 a=iAXQAx-9ccsA:10 a=AjGcO6oz07-iQ99wixmX:22
    a=oIrB72frpwYPwTMnlWqB:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755746AbeDIB5h (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 21:57:37 -0400
Received: from mail-by2nam01on0100.outbound.protection.outlook.com ([104.47.34.100]:61248
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1755585AbeDIAcw (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:32:52 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Alex Williamson <alex.williamson@redhat.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 218/293] PCI: Add function 1 DMA alias quirk
 for Marvell 9128
Thread-Topic: [PATCH AUTOSEL for 4.9 218/293] PCI: Add function 1 DMA alias
 quirk for Marvell 9128
Thread-Index: AQHTz5lMGr+o4BjfVECUFdAuALCRLg==
Date: Mon, 9 Apr 2018 00:25:44 +0000
Message-ID: <20180409002239.163177-218-alexander.levin@microsoft.com>
References: <20180409002239.163177-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409002239.163177-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0998;7:Hl68y2NtjrlYnsfLJgsN+26PRIPqBNyoksk1cR+znco27dT/6mbU2mt1mMHUKGaByKhCH6MvuX9jb7C4FCqPddEgag9oBgBSbUsEfsx2Fn4ywjBUobUXZ6egRnwfcfC9IfrtZ8JcTZk8gvV3+DfMMF4PECC+2tlISnOUUbYYgbVzYPs2MmWopkEE7Ye+ZAigNDBGpgor/RkZCTltuKlQA7+P6gp4lMKB7Pt4xkFhH6SC7bknDoyCTmg5MQkNWja3;20:8MN8jI+KJZKReyWnlqL6At8dFxxI1jHNDYpFJPDMAgYjCLuItz3Y/L3QDyazIU6N8UF/f5Tvr5TKeB/Hcq4Vc+oWv9oiE1P0In1QT+rGBcYgckbqLHvZDMdvxQFTa+bYFoyxJ5kiDjMEGGcWP8h0DUbO89jrfZurcYukw+vp1cc=
x-ms-office365-filtering-ht: Tenant
X-MS-Office365-Filtering-Correlation-Id: 4f577d09-7eb3-46ee-d3a5-08d59db16d07
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0998;
x-ms-traffictypediagnostic: DM5PR2101MB0998:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB0998488F55D82CAE9F632C6BFBBF0@DM5PR2101MB0998.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(211936372134217)(153496737603132);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3231221)(944501327)(52105095)(3002001)(10201501046)(6055026)(61426038)(61427038)(6041310)(20161123558120)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(6072148)(201708071742011);SRVR:DM5PR2101MB0998;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0998;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(39380400002)(376002)(396003)(366004)(39860400002)(189003)(199004)(25786009)(59450400001)(105586002)(14454004)(76176011)(68736007)(2906002)(316002)(97736004)(8676002)(966005)(86612001)(3660700001)(3280700002)(102836004)(6116002)(4326008)(8936002)(36756003)(22452003)(81166006)(81156014)(54906003)(6506007)(10090500001)(2501003)(6512007)(186003)(6666003)(3846002)(486006)(5660300001)(6306002)(26005)(7736002)(5250100002)(305945005)(99286004)(2900100001)(110136005)(1076002)(6436002)(53936002)(106356001)(107886003)(72206003)(86362001)(476003)(446003)(66066001)(11346002)(478600001)(10290500003)(2616005)(6486002)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0998;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: dibtZy6tDbmuwPbUGqlislxox/LkcCgzzea/5Rm3MrXo4WYN2zksusR+sHa9B6b13WkDdNuRPRe8mEk/QGXE1icUVoZ6OIFjY34nVY+COgGU8Q3fk3D5kirQlMGtQPpUMyqeO1qMNG0k0HGWloVs5WUEDVRqR40IDja91lnBhazVVgzRqs01jTJ8bui4z7ayqPi3BLtwA5qRgi7XZc5eifiH/1V1sbCO8SXwOw3uA8d0I5aosd262TS5XZz8X7wmYyLr81yfXl2n3xMCEq89Eyt4aQ/o+uBgVCcbmsTV4seB6FCFXujOC3tDi1ezIq6nOu9Dczn3dsE3OzLY4DxOPXjBTHctZCOY9lQswUxthyxG2113tKlORakMwci6K+2Di0lCcY6XgEn8ovWzz9wpo3hQ6IoFIfAO/yNWbj5OScI=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f577d09-7eb3-46ee-d3a5-08d59db16d07
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:25:44.5191
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0998
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Alex Williamson <alex.williamson@redhat.com>

[ Upstream commit aa008206634363ef800fbd5f0262016c9ff81dea ]

The Marvell 9128 is the original device generating bug 42679, from which
many other Marvell DMA alias quirks have been sourced, but we didn't have
positive confirmation of the fix on 9128 until now.

Link: https://bugzilla.kernel.org/show_bug.cgi?id=3D42679
Link: https://www.spinics.net/lists/kvm/msg161459.html
Reported-by: Binarus <lists@binarus.de>
Tested-by: Binarus <lists@binarus.de>
Signed-off-by: Alex Williamson <alex.williamson@redhat.com>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/pci/quirks.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index 0fc4843e8589..b3f49f9f640c 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -3857,6 +3857,8 @@ DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_MARVELL_EXT, 0=
x9120,
 			 quirk_dma_func1_alias);
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_MARVELL_EXT, 0x9123,
 			 quirk_dma_func1_alias);
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_MARVELL_EXT, 0x9128,
+			 quirk_dma_func1_alias);
 /* https://bugzilla.kernel.org/show_bug.cgi?id=3D42679#c14 */
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_MARVELL_EXT, 0x9130,
 			 quirk_dma_func1_alias);
--=20
2.15.1
