Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3836577-1523239624-2-12105371468219319903
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
    1523239624; b=XWUTP2fGhDdOt5eWJC4y2XDPv3GXxsUEOBoI/IPRAfo2SDUWGI
    6ODDl1ik9ETTlrwBcgXxvztR7zpULCWGa6sylyQuwX7W0kkYASKr1NZwBf8NB7yY
    fY1Z62+s8C/rjjzu5Bld4g8WUYwwBQYqXYdbiKpXSGPGvIxv/aHOuazK6si9aXwm
    YMaFXN+BsNOPjiwHNhm2Bl3X74kyAuc93Cy+794aU32/DeBMHgoRYJ4mU9J4tEb1
    //FQ+/8Yh9IsUj9esdcyOAmvHAHVDfM6Oc/m8VzE6K3Av+uH3y5s4ctmb+JYilL8
    LKTyJRJ97HNltUHlA6F1JOvNE5xYE8zKdLlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523239624; bh=PCdGPG+0eC
    zUOLRlSSzCQHtvS8f6BBYf/4ENiDG/+DU=; b=TfcWWDNj3/eku1QTmOot36+UQE
    Y1uTp0PNcJpbil1SKRkJHbnNRg/U0FQ1klIeRs8CqCAW08axsL/ZGYFq6h04sBSV
    v+xkokv8ZTX/SdLb0DKHRJh3s2usXpqOGCZLpgj/yYIZyOuhVdPp6s1CsNymK/vV
    0RuJA7IqIwWu74xNjxfMJrdO9uYfvNSn7DLGMTEEBDQKQQ9Y179cBKWx0OBSJ8Ap
    gAoU3NOkq+F5hXXPn8KyaCWISL7Dn9nIWE63VxM/6HD6awzkYFRIn4kWxbGEx4/F
    FzZ63E7Y5DGVdSetAwiwh3PNoMP+itIRpVICT49a+2DfwsihJP1q1+DNJbnQ==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=CZ4C78oC x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
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
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=CZ4C78oC x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfMi7L5l4725EjYYOlyv8F1gQODJyxFmtgcSuFpb8QaP7G5VdvRdZT/B1G/PVhBmcuuzx36SRvfwMEU+o2Kgcq8aNFOEV1HB4ejqvC5CfZlAcDwOVroIB
    Kl+gAeqV+CzH2RznBj0xxyR0gumoXCej9KrHme1u7bUODsyuIFGnmEoIBmAsFMQh18Bx2/cpJLMakiq7wdoWEdvIItNAjJtOGGaErhwQsVCOWBUnoPMSZv99
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=20KFwNOVAAAA:8 a=Dei6p5SHAAAA:8 a=yMhMjlubAAAA:8
    a=jG7yEaiCxqQw3SgKuqcA:9 a=wPNLvfGTeEIA:10 a=M-Yerj1wOn-OpK7r_3ei:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756516AbeDICGs (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 22:06:48 -0400
Received: from mail-cys01nam02on0107.outbound.protection.outlook.com ([104.47.37.107]:40886
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1756279AbeDIAb0 (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:31:26 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Hans de Goede <hdegoede@redhat.com>,
        Marcel Holtmann <marcel@holtmann.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 178/293] Bluetooth: hci_bcm: Add active_low
 irq polarity quirk for Asus T100CHI
Thread-Topic: [PATCH AUTOSEL for 4.9 178/293] Bluetooth: hci_bcm: Add
 active_low irq polarity quirk for Asus T100CHI
Thread-Index: AQHTz5k6bgIl/AaEQUG3ItwbErs64A==
Date: Mon, 9 Apr 2018 00:25:14 +0000
Message-ID: <20180409002239.163177-178-alexander.levin@microsoft.com>
References: <20180409002239.163177-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409002239.163177-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1126;7:ZQWkGBOcvtQ04UsW6sv/9Y9FFo4rny5jEbGmNkx/QL3XFf8joFhpYq3U3XqD41jnb+8W+n0ZU+2I5A2/jEqIYAMrQck3YCaroiB/inKyh3Lzq0jspVQsk0xl+RP8cjkhuzpkhY4WVFdu/d/EiOWm6AZKGfpcM/SZz8RTRDGl8g3Dyz9e+LtX1s0x7xremr70qgo1jWR1D1uZlFjQi0+ttoh0dwKYw8lxG4oS2wqHzZ3S3sk53cwTNlQqkfzNkj8X;20:2n/2My1LdBkVpdUVSHf8P9d2zOb6MvzOovEWSYDMPFCtQcOEXgD+Jw5pG484nAdYX0p0YZYUO2Qy6MTmhAC/qWZnHzIfso7kWI9wfzwmQmmDRcYr00Sfbeuhy7FpAHhsFgeTcGwPZeIVQYjhyzRC2TTsX6ibMJs9xEtdOtYxzbw=
X-MS-Office365-Filtering-Correlation-Id: 61850852-7d72-4121-6aa1-08d59db138c8
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(4604075)(3008032)(48565401081)(2017052603328)(7193020);SRVR:DM5PR2101MB1126;
x-ms-traffictypediagnostic: DM5PR2101MB1126:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB11265B8DB500858BF795656CFBBF0@DM5PR2101MB1126.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(3231221)(944501327)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(61426038)(61427038)(6041310)(20161123560045)(20161123564045)(20161123558120)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:DM5PR2101MB1126;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1126;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(39380400002)(396003)(39860400002)(346002)(376002)(189003)(199004)(2616005)(476003)(81156014)(8676002)(81166006)(3846002)(486006)(2900100001)(6436002)(186003)(478600001)(72206003)(110136005)(54906003)(2906002)(86612001)(6666003)(2501003)(26005)(10090500001)(102836004)(6512007)(6116002)(14454004)(5250100002)(10290500003)(1076002)(446003)(3280700002)(3660700001)(11346002)(8936002)(25786009)(59450400001)(6506007)(106356001)(4326008)(107886003)(36756003)(105586002)(53936002)(86362001)(66066001)(6486002)(99286004)(5660300001)(316002)(22452003)(305945005)(76176011)(97736004)(68736007)(7736002)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1126;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: lovlnFF4At7qaVxGM9xoFJrTh00/LjUNXZ7ABjZraTeqkDvaqN+4Tu6J311+ZkqjpSVXsh+XTs4QlNOFoKJWLq3u97itphTagOd5n1d9WymzMxLJ6Js7u2vJvFqxBTFah268aOcRg9EWQ1y7vYVAAi0pF0mCW9GPT/nS00S1ZjQGyTPU12erIFhvVVUDSG5IV9RLmFDIqUtGO+IidoJ+/ufKKButZ4hwLHjya7CWoHVf9UuwoD/7wnmwnu4V8MXaioFlMOz4Bje0YVd01N1Nb92tPKBV4UcqypNOvY0VRJiKqYJPx2dsjWAPlErzRbufS11Ag5ktcfJEgBpjdm960h51/LD3DNavbO6DqAZCpCitV2EYQgSNnKubQinB31Xxmk0i9Ml2x+QJe2nxM0LtV+bRZiv/K6G83ABofYeX5go=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 61850852-7d72-4121-6aa1-08d59db138c8
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:25:14.0501
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1126
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Hans de Goede <hdegoede@redhat.com>

[ Upstream commit c4c285da1ee18582ace366f07e56e355c20ebc49 ]

Just like the T100TA the host-wake irq on the Asus T100CHI is
active low. Having a quirk for this is actually extra important on the
T100CHI as it ships with a bluetooth keyboard dock, which does not
work properly without this quirk.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/bluetooth/hci_bcm.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/bluetooth/hci_bcm.c b/drivers/bluetooth/hci_bcm.c
index deed58013555..38daa2dc39e0 100644
--- a/drivers/bluetooth/hci_bcm.c
+++ b/drivers/bluetooth/hci_bcm.c
@@ -646,6 +646,15 @@ static const struct dmi_system_id bcm_wrong_irq_dmi_ta=
ble[] =3D {
 		},
 		.driver_data =3D &acpi_active_low,
 	},
+	{
+		.ident =3D "Asus T100CHI",
+		.matches =3D {
+			DMI_EXACT_MATCH(DMI_SYS_VENDOR,
+					"ASUSTeK COMPUTER INC."),
+			DMI_EXACT_MATCH(DMI_PRODUCT_NAME, "T100CHI"),
+		},
+		.driver_data =3D &acpi_active_low,
+	},
 	{	/* Handle ThinkPad 8 tablets with BCM2E55 chipset ACPI ID */
 		.ident =3D "Lenovo ThinkPad 8",
 		.matches =3D {
--=20
2.15.1
