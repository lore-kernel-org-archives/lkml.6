Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-4147991-1523246959-2-1422578986880677664
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
    1523246958; b=iw5yrZHRbqXfldymCJs1dD54P9Knu4yhj+ADN7oRmnSY6U3RgY
    emupOqNLh7/53DIIvA7hyJ/BUinqtxIwbdDNyYFQ43lD5ofqbOoRAsTeUud++C5q
    dP5wQQtuFs/iAeb4rOJAObWab1tyexNX5zfSErcjjV/L0Dyw4GEA7XdocVIIH1i2
    GKHcjlU/hNOfMooq9EqhMLyoAKtZ/sVwvyN1I1160qTlsRLibauzJ+oq8ABmMVJ1
    w5GLD9peve7kE8kpUHyqH916oAw/jKBMWCrvvCWse8YYDhk1vI7kRkUbCo1IKAOV
    3Gle3Ym+bvqmCAXX7LGyLXbxMHCmaImJwDJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523246958; bh=DpYyTn4Y5c
    vGuXDoCC95NVFWbUDsxa0Wx6swlL+CDw0=; b=biMGovLzxcjAUUDzJrCu+M8cYX
    h/hD4gM7c0ed9qLSLOTX9pz5T9hYxHJE6eggVlEoxWO17bqZDqIsQNSzmPdY0k6E
    WhRoYbpEh3K34o5v8eewhueMjzAIJsGSDTCWRrTBr6N5jUGSyaeRZS0Np7U1q+qJ
    vomHQKBOyvzCc3So7N9np3m6KXzAHuHqS2EtdHHVXWQ/oIglXJSB8tf8OkCxUdg3
    MZAm0Of4KumE1HVInzIl9AGGSo722ou32cgBWWtBwyeMKXMhUK92/dq0OK54flGu
    Tk/jUvkTgj8gESoAB05JVGZi2htY9SeEvSjra5I71/nT4wNRV/zABCvWtyow==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=R7RtWj2Z x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
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
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=R7RtWj2Z x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfOyWB/xwf9lL8j1Ak3HBSIGOkz1ENe5i72qyR06prz7BMJf1wceNyzqT9zZOs7guYBtoZz2rJiuONBI7jAnF5+WrJnF1FX3KRMIcO6fO7821CkURAWZW
    a5Y+5a0welJKbQ9GRSLTQNOgC0IW5qQyn0axJS2AaBRxFHn2Ab6d9SAzoZJKNNaupBZaSTjlkI0Rtf05KODosu0KHpx8kbqqXNwI/wIN0//InTq6XG04rio7
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=20KFwNOVAAAA:8 a=VwQbUJbxAAAA:8 a=OLL_FvSJAAAA:8
    a=1XWaLZrsAAAA:8 a=yMhMjlubAAAA:8 a=xZ-MdF6L0uY4eguhJAMA:9 a=wPNLvfGTeEIA:10
    a=w64Ph-BE0T8A:10 a=iAXQAx-9ccsA:10 a=AjGcO6oz07-iQ99wixmX:22
    a=oIrB72frpwYPwTMnlWqB:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753069AbeDIEIf (ORCPT <rfc822;greg@kroah.com>);
        Mon, 9 Apr 2018 00:08:35 -0400
Received: from mail-co1nam03on0128.outbound.protection.outlook.com ([104.47.40.128]:49080
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752955AbeDIARH (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:17:07 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Alex Williamson <alex.williamson@redhat.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.15 021/189] PCI: Add function 1 DMA alias quirk
 for Marvell 9128
Thread-Topic: [PATCH AUTOSEL for 4.15 021/189] PCI: Add function 1 DMA alias
 quirk for Marvell 9128
Thread-Index: AQHTz5gUyG4U+1U120GqdZ/8raRLFQ==
Date: Mon, 9 Apr 2018 00:17:02 +0000
Message-ID: <20180409001637.162453-21-alexander.levin@microsoft.com>
References: <20180409001637.162453-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409001637.162453-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1127;7:pCahgFHTOai/0h3sSKuLR2bmVYQzOPhRFJLeuDl0fQoxrql2dUli2nbppxnJCCgTCQocOs/yP4ZBRBKsBYTSTsVhrlJ1DD1l1Bc13OJKZ02zy/DjkIoDQnPcpfFKf6CYwImDYUozIAQRVWvymD6JGxOkvVhp+h8NydulMMXqIYw0vDtG3xSJ+uLCeE0bfHu9ZgvBIHOfRPod5cH4V5R340dckQuPMvjPQ7WwCogmTVOFjMbQRCq31DgobElIbo5u;20:oJssFpAQXgDwskbZLeIHYMHsTraMBZH1L7xn6s7MO7pNjenPkymZTOW7M6CsFvMlE28Jh/XKueFmDczYBAEeb8CcwdkaQISkEzZqzbO0sXjQSsYZKijoU/AHATTqzGN/3VnBXU2PnnzwoK4FbKaiSlozjLhNLICP9qU1+qNt1ww=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-ht: Tenant
X-MS-Office365-Filtering-Correlation-Id: 529d3ad6-fa0e-4dc2-2a22-08d59daf3807
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1127;
x-ms-traffictypediagnostic: DM5PR2101MB1127:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB11271FD5FB1EE4B7A95DB74AFBBF0@DM5PR2101MB1127.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(211936372134217)(153496737603132);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(3231221)(944501327)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(61426038)(61427038)(6041310)(20161123560045)(20161123564045)(20161123558120)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:DM5PR2101MB1127;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1127;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(39380400002)(39860400002)(376002)(346002)(366004)(189003)(199004)(105586002)(186003)(66066001)(6486002)(54906003)(7736002)(26005)(86362001)(316002)(305945005)(110136005)(478600001)(3280700002)(86612001)(10290500003)(25786009)(5250100002)(2616005)(99286004)(22452003)(5660300001)(966005)(3660700001)(2900100001)(81166006)(3846002)(2906002)(106356001)(6506007)(59450400001)(107886003)(486006)(8676002)(81156014)(14454004)(10090500001)(68736007)(4326008)(6116002)(1076002)(72206003)(102836004)(6306002)(97736004)(11346002)(8936002)(476003)(2501003)(6436002)(6512007)(446003)(76176011)(36756003)(53936002)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1127;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: WJ0IWmm38NB2g7mwCHf8PTmKRBGtfCxJzTw72SBjR7GckFojTn7SvaMAhYonPHPTBToX6qeVn1OWsbDzoI2DN3bVHs0a1fy+SzqV05h+wA76FMaeh5ZVvmltvUlG8iPo0anGgTy/tcbv544DKCEDqPobXhfTKxPzMB6NO9QqUc4o+gh68I3nuuJJTZd7IDDM4RRNWrGOXc9g7bRfQm0XMBISS24wy2PVPS6k3ZuzNZ7nDgYzhg8O9JKlB7WU8pQ94Ew51xwTh6N9vaWLiBjNHoOtPqAl8yw7lnu4Tr3B25sAZnXqq1cJgWtHa4xUH0NEzWijjOOMYqIhcEYswXajCc0mEjW+MDxxuGA1lTxrHF5KvgpqW3OrOutAZODp6AJ0aNDGI0d1sTYwp4YAQ/+Dg0B2F3qSFQkY1WdFSbAjeu8=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 529d3ad6-fa0e-4dc2-2a22-08d59daf3807
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:17:02.2781
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1127
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
index a2f18c4a0346..9481c153d675 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -3886,6 +3886,8 @@ DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_MARVELL_EXT, 0=
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
