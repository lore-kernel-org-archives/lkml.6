Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3643807-1523235045-5-4572540875151596071
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES unknown, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523235045; b=TReTwQXZOo1Vx/abvDWggQMyX1zo0xYnrIoNf7pJoUULdUGe0k
    TAF1HhMWllD/YREazCg7outQPnxR0nJCy7ib1OnejiSBpa4vC6v5JBWrqrt9N/50
    WNOqRrkMPOKWR1t0DyDc+3c8GhGPOUg5CnEmZmnHETjYLIJU8+N2eeqq4DknJ6ci
    b6gLIWcDUTh+IC/05bkUnYVJIjCbSOnHtmmj3hqv1e5NOyy2tP4jK7bdDZ0pPQvc
    EkOnvYJ/0TWEgatl5Ws9TT6sni3udrrLKEuM8Qb1ORhLV/iot8k5q+NSXkgCBDiA
    8XQRk9zmk3hbSg+vHVKJ6DXYygC59dUcMbIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523235045; bh=VPPcmu0rqo
    TRsZg8o56mmsM/hSvMovU/ukWOMo5bd90=; b=NG5RhUsyeICWyIimUuJanWg9I/
    wtAdsduqrads2GDZhudekxHN0cC7KcfmsHiDTx8GmtEbSgWJtvzSVMbyAqlwvffM
    Ih/krjX5NNge8KR2mshtwly0q/6yHkKhfm1wdIu0SaczL/lxbons7i6rgPFolQvQ
    2fkFpvBFDdRrxC/7x4Hoq+PYX4HMaZ+g+FxvoymtDDMnxqbkV6IeGUexiuOAeo2o
    x7NIuYJIyuKb+x72v2I91Str3GI9HkJu3oR2NTPonWV1HOjSd5eI7L+X393ahNMS
    +2DrL6c59adbBvSB2fJ9yAnkvxL4Hb2W8pmig00+ulTZyrMXnMVzkbs+/Apw==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=aFhy8ZJW x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
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
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=aFhy8ZJW x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfNOF7eGBUvCi2OzOo5Aqy8LoKIQVJufv7NqUaGt0o2mo04Y8X5+MYSpHdxj8RdQ3oB0fd09GgdWQOtgxHv1d7CWIIJFT+W4Y9ILVK9INBa6MYrbXslvW
    5/S4bJUAmYp8/M1F7XpuOfFI0mI36gkq4zkrEQkzDR7YowCMOK4uYZZTxAhcmFVr7saBTaQAn1BrvEFzJ10D1eCElXMNQKMm1/jMTH5l/beALMHcWNd5s7bB
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=20KFwNOVAAAA:8 a=VwQbUJbxAAAA:8 a=OLL_FvSJAAAA:8
    a=1XWaLZrsAAAA:8 a=yMhMjlubAAAA:8 a=xZ-MdF6L0uY4eguhJAMA:9 a=wPNLvfGTeEIA:10
    a=w64Ph-BE0T8A:10 a=iAXQAx-9ccsA:10 a=AjGcO6oz07-iQ99wixmX:22
    a=oIrB72frpwYPwTMnlWqB:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753772AbeDIAuK (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 20:50:10 -0400
Received: from mail-by2nam03on0126.outbound.protection.outlook.com ([104.47.42.126]:24363
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932920AbeDIAle (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:41:34 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Alex Williamson <alex.williamson@redhat.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 3.18 068/101] PCI: Add function 1 DMA alias quirk
 for Marvell 9128
Thread-Topic: [PATCH AUTOSEL for 3.18 068/101] PCI: Add function 1 DMA alias
 quirk for Marvell 9128
Thread-Index: AQHTz5t/YQF9YemOL0ieI5tyLnVn2A==
Date: Mon, 9 Apr 2018 00:41:30 +0000
Message-ID: <20180409004042.164920-18-alexander.levin@microsoft.com>
References: <20180409004042.164920-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409004042.164920-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0901;7:SV2WVHX71/+zI5bt/U6/mRnfk8OfZK5ry98qgzGh5FPORRpJSNxMymW/f/TfPKIqStku8AXOiVadZ7AQUfXJG/1EmCWZb7YKQb1vTU1aedZhJAw4Q48w6otjF/Xl1Y2HIF7PcOnBu7ZEhXlgflIgQL8vGWKqDwlJWyMEvYFRFMMXN9FauGDFG09tUEyAlxjCL6X0FTXBXnQcrAQHJSKFMQhN8VEc2QW42Z1qGndDwQqXR0EVpbUd87vRNHN/hUfS;20:BwmKGbKPLlP9NWbsmUio1llEzvrNeatHGPWpR+aTn6OOa/Hm65ThUXoDjBNefcQcFrxxhWlR9AxC5hBDP/CfBWzlLefobYqowwxFCciZKRC+F+YQ+eExiJomuwa3pi8UpW7QD7FDXIC/hnMjvd/7htzWbYtxkXwTMWYmo3isQyw=
x-ms-office365-filtering-ht: Tenant
X-MS-Office365-Filtering-Correlation-Id: 2d88d686-0e89-45cd-3fbb-08d59db2a2c4
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0901;
x-ms-traffictypediagnostic: DM5PR2101MB0901:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB09017E6474BD2CC342B64E0DFBBF0@DM5PR2101MB0901.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(211936372134217)(153496737603132);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231221)(944501327)(52105095)(3002001)(10201501046)(6055026)(61426038)(61427038)(6041310)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(20161123560045)(6072148)(201708071742011);SRVR:DM5PR2101MB0901;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0901;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(39380400002)(376002)(346002)(396003)(366004)(189003)(199004)(59450400001)(99286004)(68736007)(10290500003)(25786009)(86612001)(6116002)(66066001)(97736004)(3846002)(76176011)(6512007)(6306002)(54906003)(6436002)(4326008)(53936002)(105586002)(110136005)(6486002)(3280700002)(1076002)(107886003)(8676002)(10090500001)(2501003)(966005)(81156014)(81166006)(5660300001)(14454004)(186003)(3660700001)(102836004)(7736002)(2906002)(26005)(5250100002)(36756003)(478600001)(446003)(316002)(6506007)(2616005)(106356001)(8936002)(11346002)(22452003)(2900100001)(86362001)(486006)(476003)(305945005)(72206003)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0901;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: g/14eps9LxjhbQhagIcptKuODBk0P5gmDeKqOnGUKC4y3ewHNoStDxuTLO2wM2tuzM8//MyaydbLPMLWmnt/vwNMpUpt7sFZd3yFJ3o/pl4J36Sjsm6Jc+ZAmWQGmwe/fGUGIyf5mVGmGhw5igG/kEk4lMqZBKV0hopL3eXB/W0nIbKJO6u9VYj7zFjcwKRyNBJ4uid7b6tf88GVSRJEYg43vxwzySpkvYH2K1Q6J/UhznCnPhri23nt1Zec9tbs2YPS2EvwCG/GRRcMqHWYJr7T3ss/rXQHbtgM5EbEf2qLUdqTBTyscf6nJ6kXotA8Khx2APTH5PQIL+emouNJSGkqLuyDLrWmcWu0QH3WPbYmjF5TA/ehDuPh/y2d2FoSneEi8TFv62k1NewtEHiHc5dp1JSVfjRtxNa5jGvBAJI=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d88d686-0e89-45cd-3fbb-08d59db2a2c4
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:41:30.1271
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0901
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
index 71536c16de9f..fa180f1d318c 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -3559,6 +3559,8 @@ static void quirk_dma_func1_alias(struct pci_dev *dev=
)
  */
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_MARVELL_EXT, 0x9123,
 			 quirk_dma_func1_alias);
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_MARVELL_EXT, 0x9128,
+			 quirk_dma_func1_alias);
 /* https://bugzilla.kernel.org/show_bug.cgi?id=3D42679#c14 */
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_MARVELL_EXT, 0x9130,
 			 quirk_dma_func1_alias);
--=20
2.15.1
