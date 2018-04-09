Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3689844-1523235511-2-11469013902032195359
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES enro, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523235510; b=TNIwT/yYHvEQFDL52Vzzv7W72doAJb3rwHNl+AjM/29iRBNe+8
    +YfSoyDEwQuBj824f/O0izhV1e0g7ahz2B+QdeJZN1zaidjEslmUCdVQ06ncI9RW
    qrbvkdO0fupRvM7J4c2Nw8f6OXUm4EI1yYL4LG1NiBGEuNG4heTtO6jLY+Zv99IL
    ZWKHOcw1xtKzkhSkCxx8uDEN7GWVUtAM6t4FcQwDboTIyVoMdySZ1PWpvF/b0KtJ
    sugFQOwt3otyu+uVYgAZAKMUayiCoCXa+fNXbwZH+ViNtSPWgI+g1f+NONji2jrv
    CiqpHoymBWuVboTAVtOBGRU+BtcEBrU5G8Hg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523235510; bh=205HQ0FQch
    Mdns0AhrQqLQe2YDHD+3OO4m+dqgIzIuA=; b=PdGMzRYiYDVeWSHdtYOE5ElFM6
    +XDY9cQ1TmuhJ6zQ8bPQejSmN6byFWKlywgZec5q68NGrD+7xWLdbMNdlpnihOdD
    4AbdkQcQ/Cl0NITH8KHQXoQzEXRuFMd4f3M3jM/kKKJDATb6OqkdBngB/0U0JfYg
    E4+GYQdgBFLj9ZC/RIc1rpIOkFU9RtFDp1KAVOfV3AM/L6FUrHc/2/BoIbZ2tip5
    +XVHEAhCyDLnCuaNzitccceqoWQ/b6EF89JEuDGqzVpTXI5fSvTsJZ4LZokPg3j8
    ZrHQPWov9hW+ndAWgYEwBQABXcShJMAJN7oKKtgIC2uhXtV4q1XMyrPSkdWQ==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=N4wtGsnD x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
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
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=N4wtGsnD x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfHxuBqxq615A9giOFHUNVEn3i24HISPmUNadrmURvs99B5W0lAL4wBBP7diN0zv5lnGv9wEbvZ2nIL6azr7AINYeEBdaQ97VN4WPjy33yKdXNKnn588j
    3aqCkhO2ZQdqc1I/YMDP+MtaBK4cLBuGNOTJTSqdIFlLbogpIZyqQTn0hO7aod1WNKjDrKx98ykBkM5Tx+NqAUrja2Rg9qXr5h2VGoWjBSoIYxCbK8ys4v6E
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
        id S932415AbeDIA6O (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 20:58:14 -0400
Received: from mail-bn3nam01on0094.outbound.protection.outlook.com ([104.47.33.94]:21055
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S933222AbeDIAjs (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:39:48 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Sujith Pandel <sujithpshankar@gmail.com>,
        Narendra K <Narendra_K@Dell.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 3.18 025/101] PCI: Add domain number check to
 find_smbios_instance_string()
Thread-Topic: [PATCH AUTOSEL for 3.18 025/101] PCI: Add domain number check to
 find_smbios_instance_string()
Thread-Index: AQHTz5qpcDw1qabhvUWw6qo4fMOmMQ==
Date: Mon, 9 Apr 2018 00:35:35 +0000
Message-ID: <20180409003505.164715-25-alexander.levin@microsoft.com>
References: <20180409003505.164715-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409003505.164715-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0966;7:JJ50EoJAkuy7TGlyEuftVtrW9Um4LmXG9/SutXkSOrTEdzbAJExAo1SB4xosE4iME0cGTZD6Jrn7WWWoFoo3iw/dlwuioT5T0EgX5w5fBnmtb2/2nMKiZp7DRVdyQjkiZqL5nXRvBTmCvkVU1cxkVWvcIHHFW0/940kpaBh/NzwWodoHnGBKp9/xLRjiXN2W0DvjZ7dk9pQS3yXGnEl6WfxKFXjxPw69LSBxgpE4t8c5tAv9+HsI2RVio/2d4YiK;20:1DanuCwunypJtm0nmN2YdNfil9clD0xgl7n5UO2XJY8gx5/8c8qeQXBcAQtNzQCDqXgHlCArQhX8Q/oo/tZwYKIe96jGql7jzxKZINIz0MnIMC0c7kMgjfVcmFBvsW3oCZ5KxqRBTs3+0F/v7ImBRIcjQ0sDLXpVkjkt5pBVBJE=
x-ms-office365-filtering-ht: Tenant
X-MS-Office365-Filtering-Correlation-Id: 6ef858ad-a25a-4679-4584-08d59db261f2
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0966;
x-ms-traffictypediagnostic: DM5PR2101MB0966:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB0966511ECB7E24725BA33209FBBF0@DM5PR2101MB0966.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(85827821059158)(211936372134217)(153496737603132)(56004941905204);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3231221)(944501327)(52105095)(3002001)(10201501046)(6055026)(61426038)(61427038)(6041310)(20161123558120)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(6072148)(201708071742011);SRVR:DM5PR2101MB0966;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0966;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(396003)(39380400002)(376002)(346002)(39860400002)(189003)(199004)(5660300001)(26005)(6116002)(305945005)(3846002)(2616005)(68736007)(72206003)(86612001)(476003)(446003)(36756003)(66066001)(2501003)(575784001)(99286004)(86362001)(478600001)(11346002)(7736002)(105586002)(3280700002)(97736004)(14454004)(110136005)(2906002)(54906003)(4326008)(3660700001)(8666007)(6486002)(8936002)(486006)(22452003)(10290500003)(6506007)(81166006)(6436002)(316002)(6512007)(6666003)(2900100001)(186003)(76176011)(8676002)(10090500001)(39060400002)(107886003)(5250100002)(81156014)(1076002)(25786009)(106356001)(53936002)(102836004)(22906009)(37363001)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0966;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: m//9Z1izB+kdVAbr9cFJ8MfNtchZfc5n01aIvwEUPgf6LqnN6NmnOZRT0cyEbUQt0E4TBOlDVW5eZb9pWnXwvYeEMWX6rii1YOuQbXIujFVB5wsunfmZdzZDoE7ZFiSoCJtOr13DAw6RkizZBSbpGeDAMEZJpLj1JV6VJ4k1u9Su2UWHYiSINjk9zN3MCa+U40urLzHrH0vbmeH86Odi2IcicPWtx3HiYKAQm7XDAtcFZL1nz7BtNOjkfR6IzEsD51UlFh2r/GRFhzNo02V9M15HQsshVJtrzirC92cJSM6Vkmhp12GtLjnweWPOFJg2z939ntWjiGJm0+ipuwFNlZ2yxSKcJpL/9uSAPgBQo/4aJIbFDEiQSv/nRrgn/WD7oEZoTCWJYxCDZHmvmruyWafKlGthsDRxiWWeMUdHLS4=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ef858ad-a25a-4679-4584-08d59db261f2
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:35:35.2985
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0966
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
index 2ab1b47c7651..2ded1394b51e 100644
--- a/drivers/pci/pci-label.c
+++ b/drivers/pci/pci-label.c
@@ -45,9 +45,11 @@ static size_t find_smbios_instance_string(struct pci_dev=
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
@@ -55,8 +57,9 @@ static size_t find_smbios_instance_string(struct pci_dev =
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
