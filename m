Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-4029176-1523244145-2-16458427079011172406
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
    1523244144; b=YVXXH06gvktct9gsFSiCjJ4hsf6IUzbJmp4XUUu8iM/taszTQc
    XhZBitO9H9BdSx+2Xp+ECefbrTnWyDwm2/BiIbXm915BYNa34wCGe4L4rgIQk+gv
    KrtORA3aoYvhTj1BLWOYqlIzIlDfAvBghgRlBWdIGUUFTA5lc0iptAAj4yhaNmkz
    DVpjpwg6m6qDLwuybRZRvE1njkeGrmrRwJ9NE9H7gwB/w7GFj5KJMHNIUzRrvtaF
    dYjBPEAbVkTP8oZTdlX4T74vM0HP/h7+4ohyxGdPYlNR6lEtittAOWRpWRAHQAEx
    Nt2LzTIUFjnNvf1JhviQ26LD2pm4xDrSwqVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523244144; bh=7YEAe+S4oX
    WNy4OHhJzoi2K7GJBwouPpTo7Jjgs66mM=; b=aRMifpjPWCjfOK3uiXVy2V62Mr
    2IjIeAOR+I+hnQNhKXnVHEOSD9y/gdB3fqkLE5ry2GawcLKsgxmqyRblGsPqoE1f
    bbbbn41BokSlGRSxViEn4EEQE8zLc5wFuLxTnU9MM4utxM0BC3WbqFXSwpBLGyE/
    VX/xF1iibSSI1UqXiAWMLeeZJT/Tx/jcG9w/cJBhJA9B5LMv5G+WiAXEPizdcyI6
    mDe0oqePtFSRHwZiL2ZGXaJ3i5sHk8jDuGZv3qK1vYyfiqWnE82RAxb2UM9w4NvK
    kdAijRfa0QEPj/8hjfru/0FuXEgA9ay6I7m0clyhJ5tzBIzmNlrdAtwadNVg==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=WI5+lHPM x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
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
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=WI5+lHPM x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfMZczbXj3fb5quE964kERg1dsEPA8Rgc1G/0ZQinFRp2MMbhzQ94561blf9f6cnUw+RAh7seKYK4c0c297CMlHM0M5NxR0pp1yWIaF4ROhrJQ4V5jXpl
    5K89QsyojkaKWSRAT9E3hVYYEiRpWJYS+a426Nr1uZ9JCG7YOgRy5jCDqhTlDsFBbaO3wCyUpvTtQ/r4p9C8OTx4TuaXvBkleW4RwP+jQAybDQDCkzB+F592
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=3-RhneuVAAAA:8 a=1XWaLZrsAAAA:8 a=7CQSdrXTAAAA:8
    a=yMhMjlubAAAA:8 a=XLRw2IhVxHYyqli0-ksA:9 a=wPNLvfGTeEIA:10
    a=VLVLkjT_5ZicWzSuYqSo:22 a=a-qgeE7W1pNrGK8U0ZQC:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752061AbeDIDVu (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 23:21:50 -0400
Received: from mail-sn1nam01on0134.outbound.protection.outlook.com ([104.47.32.134]:37792
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754760AbeDIAW4 (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:22:56 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Niklas Cassel <niklas.cassel@axis.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.14 044/161] PCI: Add dummy pci_irqd_intx_xlate()
 for CONFIG_PCI=n build
Thread-Topic: [PATCH AUTOSEL for 4.14 044/161] PCI: Add dummy
 pci_irqd_intx_xlate() for CONFIG_PCI=n build
Thread-Index: AQHTz5iL8bLALvogkU2CTVeGQr+wOA==
Date: Mon, 9 Apr 2018 00:20:21 +0000
Message-ID: <20180409001936.162706-44-alexander.levin@microsoft.com>
References: <20180409001936.162706-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409001936.162706-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1014;7:t4KvWMzuuzp+HsNsFMfA2D/ZJ90vgdxHnE6PzeobplTXUeV+D02nfUa8Jqdii3H9A8s6BzWumJLvzKMYBu3C2ya1V7s+c8U+0gO+1+Fk6r7ZCNsBhwNZqxBUPFiNtHhTq4WdjrB18YzssFGegEwD7Gzqylc513rJRN4sYjaC0+aZ9VUG8kB/9fUq4fQgXn+BMOCVjfECpi4mgitGtzQVj21i74RYwoafIamV84C5vCxYPCI18ELgNAaZo26ImCgq;20:gG+3ugy5bhf15bDUJ6HSz+JUHbjJNco7fw8MNgTPjkoOEQIz55ZmIejsTPhi7dnFjNJdXyCyJ1oU4n8dqM54LFiwYIuSzUi0CzNlEhzvy7oVZfwZRuse/hrqdI8UoXqOVbg+al+ZyYg3j8qFrBL/3+mPC2Qoi4C0hUWRPfJkbOU=
x-ms-office365-filtering-ht: Tenant
X-MS-Office365-Filtering-Correlation-Id: f3cd3059-7b65-4439-d8d5-08d59db008e3
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1014;
x-ms-traffictypediagnostic: DM5PR2101MB1014:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB10140EAE3487627A5B922160FBBF0@DM5PR2101MB1014.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(180628864354917)(89211679590171)(211936372134217)(153496737603132);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(3231221)(944501327)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(61426038)(61427038)(6041310)(20161123560045)(20161123564045)(20161123558120)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:DM5PR2101MB1014;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1014;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(366004)(39860400002)(39380400002)(396003)(376002)(189003)(199004)(54534003)(81166006)(81156014)(478600001)(6436002)(72206003)(8936002)(10290500003)(106356001)(99286004)(86362001)(2616005)(7736002)(2501003)(6666003)(446003)(476003)(8676002)(11346002)(105586002)(305945005)(5250100002)(6512007)(53936002)(68736007)(107886003)(66066001)(86612001)(2906002)(14454004)(186003)(22452003)(25786009)(4326008)(2900100001)(486006)(36756003)(6486002)(3660700001)(54906003)(26005)(3280700002)(110136005)(1076002)(10090500001)(76176011)(6506007)(97736004)(316002)(3846002)(6116002)(102836004)(5660300001)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1014;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: nMTO8D8Fuo6489kb9IR1nTKx+CME0oQtPhafKAUNmsv5K5GgRNtMlgshSVfytqQWDWO89eyg1boQpKSQrtZY08MOy8VVaiz6vU9gOvgc2pw2Rv7ug6ByZY7R5+PtqcHmNnrumrDiteW4lDHMBRw3GHDOO5cfmEKhQR955XtQiccqHZ5a9r3WCY71hAnhIEc0qfoo4iABayX+oAxlG6WoLunCa47b9m2EO2/mY9MWtyIpSLEgPvys6teRjo3e2VyGTVXH820MG2qJZBNO/k3s09+MCJyD/oTVRK7JOoN0RL1PueGucRn7cIBMck3ehzfR0M7NhKflHGm6hIxKqCjTpMc7cG3wDAICDzAm84hkXu1Gyy2rpRq4P6/NOnVBcQqiiPE5D9MkUCr+h6fj+qvoYgzMXqmw1dCrombGDTC3gl0=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f3cd3059-7b65-4439-d8d5-08d59db008e3
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:20:21.0195
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1014
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
index d16a7c037ec0..727e309baa5e 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -1688,6 +1688,13 @@ static inline int pci_get_new_domain_nr(void) { retu=
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
