Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1131037-1520492332-2-1320174980850873330
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520492331; b=h4oFyAB6DfkdjgvQIX6HNazMfnkwRbI2V/P2SP24mRc5yGr
    BVCZgZwBpsyLKCSQq2nyMOm1dsqhFl4WONvEXqKlh2BYXCPAEO7zdC6k7Am8FluS
    Wd6kEv9uSusfvzO29sQmOGQChpXlzDFds8V/BeAT/xjEzAglBg8zKY6N50oatCYX
    IOOJegsqfJHPImCANiaJjX+j3rfsPPDKg+4TEFR9sm8exwvzSlvHbK+qUWOmgJD8
    5dvZ+5XTXb+Z/mBUO6SWi/XWUeqKEfSi4ZvD5H83PHUbSt8tfG5pQknnqLgq5dkE
    xVYwDzqPoyYmBv3EovbUbkiqDciS7x/1fGcRbiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520492331; bh=kpogfa
    18O4a/S+c/0beFmTuWrT2+Rj4JRIRvswx6vZ0=; b=jMiEGO4anu4rKo9eVjYCEW
    1GZF3OMvKU7vNLVEKRYDZClYxnZz+lSsPANlArT/mk7Rc201lYtQzLOgg2iPcEpv
    +6LSFeP9d6up2CXpgDP/bkhbC/KOpefu6W5y+ZG3ldJF8cdbEC4pR2Ud/eMLJemb
    d4b4eD5/m4dfJKiQlOH+2BB235pAILJYylirnRwoRVglrfQWtQ8GQhmYwtZN/I66
    6PKmfIeDDDUT3IM/4PufxITFD3NsP8vjBBrWSU03rW8Albv4V7MvoNqQnYcy0i70
    4hT4KcDrkrVILBQ57aXLBuy9+RUyvel5d+7Gj/YYbC/LivAfdwawKeYqqkiSk6mA
    ==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=MrX7hBdt x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=MrX7hBdt x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935050AbeCHG6W (ORCPT <rfc822;greg@kroah.com>);
        Thu, 8 Mar 2018 01:58:22 -0500
Received: from mail-bn3nam01on0119.outbound.protection.outlook.com ([104.47.33.119]:51237
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S935037AbeCHE5Y (ORCPT <rfc822;stable@vger.kernel.org>);
        Wed, 7 Mar 2018 23:57:24 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Bjorn Helgaas <bhelgaas@google.com>,
        Kenji Chen <kenji.chen@intel.com>,
        Patrick Georgi <pgeorgi@google.com>,
        Rajat Jain <rajatja@google.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.15 46/78] PCI/ASPM: Calculate LTR_L1.2_THRESHOLD
 from device characteristics
Thread-Topic: [PATCH AUTOSEL for 4.15 46/78] PCI/ASPM: Calculate
 LTR_L1.2_THRESHOLD from device characteristics
Thread-Index: AQHTtpnNpxG59MrCSkivck8Qz3OE8Q==
Date: Thu, 8 Mar 2018 04:56:21 +0000
Message-ID: <20180308045525.7662-46-alexander.levin@microsoft.com>
References: <20180308045525.7662-1-alexander.levin@microsoft.com>
In-Reply-To: <20180308045525.7662-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1079;7:0NK3cCcuF4sjfBCzugxmG1zC5sPu+Af3r8JSrCIE1VgaKIRJEfWCxV94Eo2+vY9IITSuaYYGF5ti+53+uh6RU/bSrhuMMGCYGsmHbvPBncieAZ5ojHWrLTXQ56JdrbBZM6RPfBzHf5tkXl49XaVQKg109zwqbjlsRcd0WEH9nV/ZCKDZ8KahQNJDXiPuLIcJyfANbLePtXLayi2fE/CxCd3Rn/qxNgKxC0KD5/I19ztmzFQNVnzG2xsgil1pCCbT;20:DJl8htOr6ximZF5BT39wYKFkBTZrbd8oI4aFBQMa5cbdFBbbt0K5F9QzHZSAEbhFOIVATYfq0skfGjLzYRjfrPI70w+ahEJRxuc/eeRyw+0AcIMr0G368bmmSfQcqZnsFS0WEHzYCQ1UjbfQh/yu7SAccqNd5RZeN6lPpNwo0JM=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 718ea80c-6b0c-4272-9a5d-08d584b10d4c
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1079;
x-ms-traffictypediagnostic: DM5PR2101MB1079:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB10790055CE023ACF61E3CF80FBDF0@DM5PR2101MB1079.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(18589796830644)(211936372134217)(153496737603132)(228905959029699);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(8121501046)(5005006)(3231220)(944501244)(52105095)(93006095)(93001095)(10201501046)(3002001)(6055026)(61426038)(61427038)(6041288)(20161123564045)(20161123560045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(6072148)(201708071742011);SRVR:DM5PR2101MB1079;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1079;
x-forefront-prvs: 060503E79B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(39860400002)(39380400002)(396003)(346002)(366004)(85664002)(189003)(199004)(36756003)(107886003)(4326008)(97736004)(2906002)(2950100002)(1076002)(6666003)(105586002)(7736002)(186003)(3660700001)(5660300001)(106356001)(305945005)(6512007)(3280700002)(25786009)(14454004)(575784001)(86362001)(6306002)(86612001)(81156014)(10090500001)(76176011)(26005)(99286004)(66066001)(102836004)(110136005)(81166006)(72206003)(54906003)(5250100002)(478600001)(59450400001)(10290500003)(6116002)(2501003)(8936002)(68736007)(53936002)(6506007)(6486002)(8676002)(6436002)(3846002)(22452003)(966005)(316002)(2900100001)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1079;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
x-microsoft-antispam-message-info: HkWrfWbT74EDPUC7IIcO9wXgItGdN27Vx9uVjdTOnW2PTr8oKd8+swqvopy2i7KbADZxS9WTl53WazssZJa+VQdSUDLMywlRMlczcby10OxWvynPJ/tF1/VxxaCSqyOqYykeEoVICfWTGNf9cln9cBqplyhHcBoIwrYYenzROW6idFmYzsOqF7lgV1tyO8zkwEg1UgmXDd1dVYZAbhNHW/Slj7TuR6/FMK2F/GvWItZjDF34LwJZA/zNeHDBa/BYA3Vka3mGcM1t7lY+54Xmi0Upd+dt0yj6/B+MWxwJJSEXKMGCjONdsxgfYbYitXJUGDJGmMPso8f/ONNQcvT1Xg==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 718ea80c-6b0c-4272-9a5d-08d584b10d4c
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Mar 2018 04:56:21.7411
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1079
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Bjorn Helgaas <bhelgaas@google.com>

[ Upstream commit 80d7d7a904fac3f8114448dbb8cc9fa253b10120 ]

Per PCIe r3.1, sec 5.5.1, LTR_L1.2_THRESHOLD determines whether we enter
the L1.2 Link state: if L1.2 is enabled and downstream devices have
reported that they can tolerate latency of at least LTR_L1.2_THRESHOLD, we
must enter L1.2 when CLKREQ# is de-asserted.

The implication is that LTR_L1.2_THRESHOLD is the time required to
transition the Link from L0 to L1.2 and back to L0, and per sec 5.5.3.3.1,
Figures 5-16 and 5-17, it appears that the absolute minimum time for those
transitions would be T(POWER_OFF) + T(L1.2) + T(POWER_ON) + T(COMMONMODE).

Therefore, compute LTR_L1.2_THRESHOLD as:

    2us T(POWER_OFF)
  + 4us T(L1.2)
  + T(POWER_ON)
  + T(COMMONMODE)
  =3D LTR_L1.2_THRESHOLD

Previously we set LTR_L1.2_THRESHOLD to a fixed value of 163840ns
(163.84us):

  #define LTR_L1_2_THRESHOLD_BITS     ((1 << 21) | (1 << 23) | (1 << 30))
  ((1 << 21) | (1 << 23) | (1 << 30)) =3D 0x40a00000
  LTR_L1.2_THRESHOLD_Value =3D (0x40a00000 & 0x03ff0000) >> 16 =3D 0xa0 =3D=
 160
  LTR_L1.2_THRESHOLD_Scale =3D (0x40a00000 & 0xe0000000) >> 29 =3D 0x2 (* 1=
024ns)
  LTR_L1.2_THRESHOLD =3D 160 * 1024ns =3D 163840ns

Obviously this doesn't account for the circuit characteristics of different
implementations.

Note that while firmware may enable LTR, Linux itself currently does not
enable LTR.  When L1.2 is enabled but LTR is not, LTR_L1.2_THRESHOLD is
ignored and we always enter L1.2 when it is enabled and CLKREQ# is
de-asserted.  So this patch should not have any effect unless firmware
enables LTR.

Fixes: f1f0366dd6be ("PCI/ASPM: Calculate and save the L1.2 timing paramete=
rs")
Link: https://www.coreboot.org/pipermail/coreboot-gerrit/2015-March/021134.=
html
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Reviewed-by: Vidya Sagar <vidyas@nvidia.com>
Cc: Kenji Chen <kenji.chen@intel.com>
Cc: Patrick Georgi <pgeorgi@google.com>
Cc: Rajat Jain <rajatja@google.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/pci/pcie/aspm.c | 71 ++++++++++++++++++++++++++++++++-------------=
----
 1 file changed, 47 insertions(+), 24 deletions(-)

diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
index 9783e10da3a9..3b9b4d50cd98 100644
--- a/drivers/pci/pcie/aspm.c
+++ b/drivers/pci/pcie/aspm.c
@@ -43,18 +43,6 @@
 #define ASPM_STATE_ALL		(ASPM_STATE_L0S | ASPM_STATE_L1 |	\
 				 ASPM_STATE_L1SS)
=20
-/*
- * When L1 substates are enabled, the LTR L1.2 threshold is a timing param=
eter
- * that decides whether L1.1 or L1.2 is entered (Refer PCIe spec for detai=
ls).
- * Not sure is there is a way to "calculate" this on the fly, but maybe we
- * could turn it into a parameter in future.  This value has been taken fr=
om
- * the following files from Intel's coreboot (which is the only code I fou=
nd
- * to have used this):
- * https://www.coreboot.org/pipermail/coreboot-gerrit/2015-March/021134.ht=
ml
- * https://review.coreboot.org/#/c/8832/
- */
-#define LTR_L1_2_THRESHOLD_BITS	((1 << 21) | (1 << 23) | (1 << 30))
-
 struct aspm_latency {
 	u32 l0s;			/* L0s latency (nsec) */
 	u32 l1;				/* L1 latency (nsec) */
@@ -333,6 +321,32 @@ static u32 calc_l1ss_pwron(struct pci_dev *pdev, u32 s=
cale, u32 val)
 	return 0;
 }
=20
+static void encode_l12_threshold(u32 threshold_us, u32 *scale, u32 *value)
+{
+	u64 threshold_ns =3D threshold_us * 1000;
+
+	/* See PCIe r3.1, sec 7.33.3 and sec 6.18 */
+	if (threshold_ns < 32) {
+		*scale =3D 0;
+		*value =3D threshold_ns;
+	} else if (threshold_ns < 1024) {
+		*scale =3D 1;
+		*value =3D threshold_ns >> 5;
+	} else if (threshold_ns < 32768) {
+		*scale =3D 2;
+		*value =3D threshold_ns >> 10;
+	} else if (threshold_ns < 1048576) {
+		*scale =3D 3;
+		*value =3D threshold_ns >> 15;
+	} else if (threshold_ns < 33554432) {
+		*scale =3D 4;
+		*value =3D threshold_ns >> 20;
+	} else {
+		*scale =3D 5;
+		*value =3D threshold_ns >> 25;
+	}
+}
+
 struct aspm_register_info {
 	u32 support:2;
 	u32 enabled:2;
@@ -443,6 +457,7 @@ static void aspm_calc_l1ss_info(struct pcie_link_state =
*link,
 				struct aspm_register_info *dwreg)
 {
 	u32 val1, val2, scale1, scale2;
+	u32 t_common_mode, t_power_on, l1_2_threshold, scale, value;
=20
 	link->l1ss.up_cap_ptr =3D upreg->l1ss_cap_ptr;
 	link->l1ss.dw_cap_ptr =3D dwreg->l1ss_cap_ptr;
@@ -454,16 +469,7 @@ static void aspm_calc_l1ss_info(struct pcie_link_state=
 *link,
 	/* Choose the greater of the two Port Common_Mode_Restore_Times */
 	val1 =3D (upreg->l1ss_cap & PCI_L1SS_CAP_CM_RESTORE_TIME) >> 8;
 	val2 =3D (dwreg->l1ss_cap & PCI_L1SS_CAP_CM_RESTORE_TIME) >> 8;
-	if (val1 > val2)
-		link->l1ss.ctl1 |=3D val1 << 8;
-	else
-		link->l1ss.ctl1 |=3D val2 << 8;
-
-	/*
-	 * We currently use LTR L1.2 threshold to be fixed constant picked from
-	 * Intel's coreboot.
-	 */
-	link->l1ss.ctl1 |=3D LTR_L1_2_THRESHOLD_BITS;
+	t_common_mode =3D max(val1, val2);
=20
 	/* Choose the greater of the two Port T_POWER_ON times */
 	val1   =3D (upreg->l1ss_cap & PCI_L1SS_CAP_P_PWR_ON_VALUE) >> 19;
@@ -472,10 +478,27 @@ static void aspm_calc_l1ss_info(struct pcie_link_stat=
e *link,
 	scale2 =3D (dwreg->l1ss_cap & PCI_L1SS_CAP_P_PWR_ON_SCALE) >> 16;
=20
 	if (calc_l1ss_pwron(link->pdev, scale1, val1) >
-	    calc_l1ss_pwron(link->downstream, scale2, val2))
+	    calc_l1ss_pwron(link->downstream, scale2, val2)) {
 		link->l1ss.ctl2 |=3D scale1 | (val1 << 3);
-	else
+		t_power_on =3D calc_l1ss_pwron(link->pdev, scale1, val1);
+	} else {
 		link->l1ss.ctl2 |=3D scale2 | (val2 << 3);
+		t_power_on =3D calc_l1ss_pwron(link->downstream, scale2, val2);
+	}
+
+	/*
+	 * Set LTR_L1.2_THRESHOLD to the time required to transition the
+	 * Link from L0 to L1.2 and back to L0 so we enter L1.2 only if
+	 * downstream devices report (via LTR) that they can tolerate at
+	 * least that much latency.
+	 *
+	 * Based on PCIe r3.1, sec 5.5.3.3.1, Figures 5-16 and 5-17, and
+	 * Table 5-11.  T(POWER_OFF) is at most 2us and T(L1.2) is at
+	 * least 4us.
+	 */
+	l1_2_threshold =3D 2 + 4 + t_common_mode + t_power_on;
+	encode_l12_threshold(l1_2_threshold, &scale, &value);
+	link->l1ss.ctl1 |=3D t_common_mode << 8 | scale << 29 | value << 16;
 }
=20
 static void pcie_aspm_cap_init(struct pcie_link_state *link, int blacklist=
)
--=20
2.14.1
