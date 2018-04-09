Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3913452-1523241273-2-12377149687321764053
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES enro,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523241272; b=F5ycJ7gcGvxPCG00z+NS041a1c1KtsLbgd9iFkZ/DXlPtTt1+f
    ZCXiwdErpW/tP1wW7qpCJg5Q8iL+ZOX9Y50DDO9Iji0i4XDLjr1ngIDfWZCkc9kc
    vvqIv21FrAMtAK6Hp0RsV5+zc2MuwE6BGxXn46+gJxtScQjOQnPulEW/fFPlIU1n
    pIo8PQKP4NMX6R6zjq/TNytzv7ATyhD2ADL5m2cOLuI1/coLWxaGTpVplOVKsQrl
    yBA4U8241aMx2GWRdz+tTxrqoD5VJvOQMA89jS6Ql2Dvdmqow6jHxqEsXgG6C8zU
    IQC5KZvqb0tmUBNRKByYnzuBLUF2k1kdBRBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523241272; bh=laXjHp24mm
    PMyeahN0VQhdaG5P2j2qEK/aUcayUvLp8=; b=XvBYL9FJAi4KXItDwIoAFY2ZRE
    QzGL8/BTaPrNiX2Q3yf9YQQiS9Cwih5i3rRfzu57n8ryrs9HF3ht24LRJpT+nD/n
    BItqrirY5i6AX2/HTUKs/+K+SRyHmcZhmUwlqRqTi+FzWsFwk3X9j4YPY0h8Bm/W
    hole3Nf2QmNZRXyqd0QT6/RqCqpzvJIjfH+HiFOuXjQdHOQFOLOfFVXlaLvwG+l5
    1W76XnOnETNHbkOcle5yz9CwU4oLPtPiGxZpZ1wBVEa4UbFVinJspu2TmG7FVDif
    NCKWhtsDzaehuLgH6B6wxawbKSXzbXxcO/dds833ZUhyBPqPuW9aB3V8ah4A==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=DVlehfBH x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
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
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=DVlehfBH x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfEIQJKqYF8syg7kxiBD4CSBQMv0LH0DlTHx8Sn10Sczzk66bFEKFg8csnB+1AnrWEX/TdGxXK/XlGrGrwPKhIdSR37a1H+QV45gHaeQ/q/aQilMTH+Yd
    lDmHfai7qzUHoHublO37UAKtAXAuRIKbWZCSMkjxoVI2DvAsIvEPPIDeMFmsMlsxLpSXpyF9+vz/Bu8hRNIXkeU2d2R2ixQdYKsXUJhNHSAXLSi4XDA9NCbF
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=pGLkceISAAAA:8 a=sg3g4v5sAAAA:8 a=iLNU1ar6AAAA:8
    a=1XWaLZrsAAAA:8 a=yMhMjlubAAAA:8 a=Gy4E4SSkQu8Ixn8RlssA:9
    a=x_lDFeQQAfHRFK2f:21 a=o9OOlKVKKvP5aoV6:21 a=wPNLvfGTeEIA:10
    a=iu1f2MN_e5UA4oevRmHL:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755675AbeDIA1m (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 20:27:42 -0400
Received: from mail-sn1nam02on0101.outbound.protection.outlook.com ([104.47.36.101]:56960
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1755652AbeDIA1j (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:27:39 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Sujith Pandel <sujithpshankar@gmail.com>,
        Narendra K <Narendra_K@Dell.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 057/293] PCI: Add domain number check to
 find_smbios_instance_string()
Thread-Topic: [PATCH AUTOSEL for 4.9 057/293] PCI: Add domain number check to
 find_smbios_instance_string()
Thread-Index: AQHTz5j+QIG6keEwgU+A+7dOb3KC2w==
Date: Mon, 9 Apr 2018 00:23:35 +0000
Message-ID: <20180409002239.163177-57-alexander.levin@microsoft.com>
References: <20180409002239.163177-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409002239.163177-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0871;7:87ZtNKV80SyhZFg9btoMNqwhaOzMUEcgugn4Rc7REQWrSWdKtB1D0AmDVQK4DxESb9SYolEoR3gnuaMeDohv6Jnutt0PudNg7+erj+LI6aXMbGcS8xX9g49fj9cfSYhv7PVe/VzDE81kcrwUi84qgJf0Fhv4+ADavVaqOJXJsLevkZHk4iQBqD6z01w8ZdViqXMkFArD32OADV/ZJui+7IzGR3A9CXwYHXaybK/BxuxP75wrYlReS2EUm1oKGFGl;20:cFhWKSNJV+5r3yGcbD55rS6sZUqVQePWv5eSxbMo5lViLoM5i5/++Uz5tcV2JMH+536gQvVkVHx8szRw/+cFyvOz9OpXnIndjcdI0h7meyMMCnUHTVD/vObSWz677wS8g8nEgtg5lWuQmPx8rqc/jMv7kCy0J2cFcR75dItONvI=
X-MS-Office365-Filtering-Correlation-Id: 9227bfb4-9ff3-45cf-3a81-08d59db0b02f
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(4604075)(3008032)(48565401081)(2017052603328)(7193020);SRVR:DM5PR2101MB0871;
x-ms-traffictypediagnostic: DM5PR2101MB0871:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB087145385BFE42FD35FFC954FBBF0@DM5PR2101MB0871.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(85827821059158)(211936372134217)(153496737603132)(56004941905204);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(3231221)(944501327)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(61426038)(61427038)(6041310)(20161123560045)(20161123564045)(20161123558120)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:DM5PR2101MB0871;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0871;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(366004)(396003)(39380400002)(376002)(39860400002)(199004)(189003)(105586002)(8676002)(3660700001)(3280700002)(6506007)(81156014)(81166006)(14454004)(99286004)(72206003)(110136005)(8936002)(54906003)(305945005)(2906002)(316002)(10290500003)(478600001)(7736002)(53936002)(6512007)(486006)(11346002)(39060400002)(4326008)(86362001)(575784001)(446003)(3846002)(102836004)(76176011)(476003)(25786009)(22452003)(36756003)(107886003)(10090500001)(5660300001)(6486002)(86612001)(6436002)(2616005)(68736007)(8666007)(26005)(1076002)(186003)(2501003)(5250100002)(2900100001)(106356001)(66066001)(6116002)(97736004)(22906009)(37363001)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0871;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: zbOVAvWIjgS8vII+Y21yw2hv6W8hL3aNoCukuh2/w7y8bfv6YN+MXFsMhp0FRTFUJ3Y2+vRPIIk7ZU2ED9+DXqt/a7b349eNEP63MO7pMUwZy73F6vmYFxESMBpO0H9MRISLt2tdkZdCrdZK+GsgQpco85GgpyaTSfRSLoG+SVRN1ZFrMq14VrkZLXo3phCVTMOYCECcM3QDc4UBMkUzoiuUoaQNY1U3PbIcSdcwi2jMzKOYDtfCrKnOgL7MczOuFMI3FZaiQF6lON60nQjZj9amHdWqvXRd5J/3kJmx0wQRNFQc9Rnzq2KvFFMwVkYsH+1XCInF/kdlZS1DAGB9036jNUjBqJKOLGZNbUrl1rZgg5aFyggFGd+ozoRH21iZEA0Dw6xI/8eIyqfdDUx3DRQPMonU/QLjIE/TM4xFr1M=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9227bfb4-9ff3-45cf-3a81-08d59db0b02f
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:23:35.0655
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0871
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Sujith Pandel <sujithpshankar@gmail.com>

[ Upstream commit 6c51c82c60991bdbfb937f3bf0cdbe68d042073d ]

The function find_smbios_instance_string() does not consider the
PCI domain number.  As a result, SMBIOS type 41 device type instance
would be exported to sysfs for all the PCI domains which have a
PCI device with same bus/device/function, though PCI bus/device/func
from a specific PCI domain has SMBIOS type 41 device type instance
defined.

Address the issue by making find_smbios_instance_string() check PCI domain
number as well.

Reported-by: Shai Fultheim <Shai@ScaleMP.com>
Suggested-by: Shai Fultheim <Shai@ScaleMP.com>
Tested-by: Shai Fultheim <Shai@ScaleMP.com>
Signed-off-by: Sujith Pandel <sujithpshankar@gmail.com>
Signed-off-by: Narendra K <Narendra_K@Dell.com>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/pci/pci-label.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/pci-label.c b/drivers/pci/pci-label.c
index 51357377efbc..1d828a614ac0 100644
--- a/drivers/pci/pci-label.c
+++ b/drivers/pci/pci-label.c
@@ -43,9 +43,11 @@ static size_t find_smbios_instance_string(struct pci_dev=
 *pdev, char *buf,
 {
 	const struct dmi_device *dmi;
 	struct dmi_dev_onboard *donboard;
+	int domain_nr;
 	int bus;
 	int devfn;
=20
+	domain_nr =3D pci_domain_nr(pdev->bus);
 	bus =3D pdev->bus->number;
 	devfn =3D pdev->devfn;
=20
@@ -53,8 +55,9 @@ static size_t find_smbios_instance_string(struct pci_dev =
*pdev, char *buf,
 	while ((dmi =3D dmi_find_device(DMI_DEV_TYPE_DEV_ONBOARD,
 				      NULL, dmi)) !=3D NULL) {
 		donboard =3D dmi->device_data;
-		if (donboard && donboard->bus =3D=3D bus &&
-					donboard->devfn =3D=3D devfn) {
+		if (donboard && donboard->segment =3D=3D domain_nr &&
+				donboard->bus =3D=3D bus &&
+				donboard->devfn =3D=3D devfn) {
 			if (buf) {
 				if (attribute =3D=3D SMBIOS_ATTR_INSTANCE_SHOW)
 					return scnprintf(buf, PAGE_SIZE,
--=20
2.15.1
