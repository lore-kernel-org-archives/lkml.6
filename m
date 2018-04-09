Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-4102378-1523246629-2-10027806800970347462
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
    1523246628; b=epZafX4i9Het5mAqT0WotUjHUuoBlBgUPaDK5ur1t7iTlEOJIu
    UNICGNLUZszCyyySUpECuhwFPoT3Rd0IfFBDs08QRbF5U+d2uJISnz/wcRZpcwVa
    bxwKgw9xuKxlJ4bZInYUNjeOVKaFX9WN2eHH8Mc06f7rFhTN2uWz0pbxskVSLrDa
    Rbs8Lm8MFs+12xTqPfv1WRfPmEnqSmST+UTouuPMblz4T5029lFjnu5AUc+ug4wx
    J7TM21DZcv1akQnNMaSs5QJpi0atWVYg7m2HCokO6Zkt1Bhm7iMW2jznYBgeNuaO
    tq637N2Bz8/DOvBT8mqoiSAZSnQRlP1imyhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523246628; bh=R4MdejiZNH
    SL1FbodDQpE2Vh8PFudmvBD9mOCW9nOxI=; b=e0ahOvQeQiq43eB8pBw+ftZwPg
    eZz6EsY3HeaRYUtXffpsfjx1KSo0kxLprtKDJDfT9RuoobezqA3dSgsLOdtjU5rQ
    g9DeewYkjYfKejSl8WB0cetY/gSQaTD8B3L1CCKiTAGSDOhTac/A47yBIQaJXY9P
    aV9SOhtR4VSBcrYKnnqHcHqyI38LZLFykKGh+9HhOPKOBLOneSHJoNPPCTin5cQk
    ukzhxNBobe5W/vDlWk1H97A55uL8JSTNPDVSj3KpDCHJ9HGAFSGVhf2DJC23UD8b
    nhi6/RAuF1/T7nuYww+Dwi0jbnTui5JZ2NAw2+QpiuwX4MeyHBOf+dgsDsyA==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=gKWE9RMc x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=gKWE9RMc x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfJbToimeZ7ehAZvXdHApoI+YYzS9PP/99MtnILLDe5SJMTjuoep4AcBjR5pouMFJHHla5JayulHwdQqhVHJUuJVh7IJ9QA6aHdXyYcCmml7eky3J3ckr
    YZn4bJ1RLM/uokOjbFnkoNZxGiDLTS9MKQHiOAfVCmZ4fXQVmvuRdcARYNuCeq9gkBUgVwE94L8+yvvXHg+Yxx7oBkunf+HaoohMq9VmgIOau0o5pGIL43NM
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=3-RhneuVAAAA:8 a=1XWaLZrsAAAA:8 a=7CQSdrXTAAAA:8
    a=yMhMjlubAAAA:8 a=XLRw2IhVxHYyqli0-ksA:9 a=wPNLvfGTeEIA:10
    a=VLVLkjT_5ZicWzSuYqSo:22 a=a-qgeE7W1pNrGK8U0ZQC:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750877AbeDIEDU (ORCPT <rfc822;greg@kroah.com>);
        Mon, 9 Apr 2018 00:03:20 -0400
Received: from mail-bl2nam02on0136.outbound.protection.outlook.com ([104.47.38.136]:51875
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753239AbeDIAR6 (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:17:58 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Niklas Cassel <niklas.cassel@axis.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.15 050/189] PCI: Add dummy pci_irqd_intx_xlate()
 for CONFIG_PCI=n build
Thread-Topic: [PATCH AUTOSEL for 4.15 050/189] PCI: Add dummy
 pci_irqd_intx_xlate() for CONFIG_PCI=n build
Thread-Index: AQHTz5gjWLeRjxDN3UqqqcrGMFGoMw==
Date: Mon, 9 Apr 2018 00:17:25 +0000
Message-ID: <20180409001637.162453-50-alexander.levin@microsoft.com>
References: <20180409001637.162453-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409001637.162453-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1048;7:WFguYYt2dvVAh7e6lJbdLJIPeyQTSm9hH0xhLkzftp6pFgh0W95SaAbcX2/nFmV/+8n5dlr+9zm0aHLvZ3W69pVstU3U3nfIEMALoe4DA+CPrUaobvuKspN65QpkhAcgN3Jdo5dQFetDH1NMeNujxQaFlKGzsZ7o918cJ4irk532P6WPMpirQOjvFj6+DOMwSPn6/v7uzmBZEF3LQ2sTOgnvKRijeKUAndPwv9sZN1W6hIHoi0lhwSWtrupCAT8b;20:dSBdeamUVS2a4+li5uB/8hCEmcdBK99Rj5pw1p2j5fnWUDXzG8yYG1nB6PXRA9k0cysgNNxAEbGyJd1jZaJ/Uq0H3eBsAvXh3nJXjmey+mOl48zo4aQvvGNYofkCvTQHRZTRfvytwl/GyhICPylM1L8hM/ZKheM4+CymUk+v27M=
x-ms-office365-filtering-ht: Tenant
X-MS-Office365-Filtering-Correlation-Id: 2cdca266-e026-4955-1088-08d59daf5572
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1048;
x-ms-traffictypediagnostic: DM5PR2101MB1048:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB10484DA2F48ED0C036F0C740FBBF0@DM5PR2101MB1048.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(180628864354917)(89211679590171)(211936372134217)(153496737603132);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3231221)(944501327)(52105095)(3002001)(10201501046)(6055026)(61426038)(61427038)(6041310)(20161123558120)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(6072148)(201708071742011);SRVR:DM5PR2101MB1048;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1048;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(39380400002)(376002)(39860400002)(346002)(396003)(189003)(199004)(54534003)(86362001)(1076002)(99286004)(6116002)(110136005)(3846002)(54906003)(22452003)(3280700002)(105586002)(2906002)(76176011)(4326008)(6512007)(6436002)(6486002)(3660700001)(6666003)(7736002)(86612001)(25786009)(2900100001)(14454004)(97736004)(53936002)(107886003)(68736007)(102836004)(36756003)(6506007)(26005)(186003)(106356001)(305945005)(5250100002)(72206003)(478600001)(2501003)(10290500003)(81166006)(5660300001)(8676002)(66066001)(316002)(81156014)(2616005)(10090500001)(11346002)(446003)(476003)(8936002)(486006)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1048;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: V2XGh4lQiiEQRdhrmZ14AAQKVk3OFJr34uGCSUngWe3bT14ei36AQ7uKC+KqCcmDaI41FcNScHoqZGxOSZB/UbxkKM9ep+QFLUS9vWaVGzkYicTZ25HJMpDsT/dnp6ghSAfjqot0W9LBvnOMqInb1qFPiSvFWagtz8tQa2/QHJn+SZGqB8mIoi+OzxU40XZr+iee9YM3zo8cUC/bKPR7rrLoUCI7XM4h4jeSvCUO8EKuaT95JdwiXlVKLwry4RxxNSTyiWMLqVqzLEAEv5N55C0abhAsze0JB29Fhux0SBCAGwoPbIDJO40TF81W7YuhEK41yFWbD6GWQOBEa6TdavX08YHnwv27ds7yLzoKTFogtsS+XWITGJfg05wRsf/6n9a9Q14KpBDRdJ+XiwAvW6Z1554rI2RPyouuayr5Flk=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2cdca266-e026-4955-1088-08d59daf5572
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:17:25.6661
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1048
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Niklas Cassel <niklas.cassel@axis.com>

[ Upstream commit 80db6f08b7af93eddc9487535e6150b220262637 ]

Some hardware can operate in either "host" or "endpoint" mode, which means
there can be both a host bridge driver and an endpoint driver for the same
device.  Those drivers share a lot of code, so sometimes they live in the
same source file.

The host bridge driver requires CONFIG_PCI=3Dy because it enumerates PCI
devices below the bridge using the PCI core.  The endpoint driver does not
require CONFIG_PCI=3Dy because it runs in an embedded kernel on the other
side of the device, e.g., on an adapter card.

pci-dra7xx.c contains both host and endpoint drivers.  If we select only
the endpoint driver (CONFIG_PCI=3Dn and CONFIG_PCI_DRA7XX_EP=3Dy), the unne=
eded
host driver is still compiled.  It references pci_irqd_intx_xlate(), which
is not present when CONFIG_PCI=3Dn, which causes this error:

  drivers/pci/dwc/pci-dra7xx.c:229:11: error: 'pci_irqd_intx_xlate' undecla=
red here (not in a function)

Add a dummy pci_irqd_intx_xlate() for the CONFIG_PCI=3Dn case.

[bhelgaas: changelog]
Signed-off-by: Niklas Cassel <niklas.cassel@axis.com>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Acked-by: Arnd Bergmann <arnd@arndb.de>
Acked-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 include/linux/pci.h | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/include/linux/pci.h b/include/linux/pci.h
index c170c9250c8b..f69944699317 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -1686,6 +1686,13 @@ static inline int pci_get_new_domain_nr(void) { retu=
rn -ENOSYS; }
 #define dev_is_pf(d) (false)
 static inline bool pci_acs_enabled(struct pci_dev *pdev, u16 acs_flags)
 { return false; }
+static inline int pci_irqd_intx_xlate(struct irq_domain *d,
+				      struct device_node *node,
+				      const u32 *intspec,
+				      unsigned int intsize,
+				      unsigned long *out_hwirq,
+				      unsigned int *out_type)
+{ return -EINVAL; }
 #endif /* CONFIG_PCI */
=20
 /* Include architecture-dependent settings and functions */
--=20
2.15.1
