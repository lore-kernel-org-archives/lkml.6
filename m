Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3828464-1523239744-5-10886442615335902209
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
    1523239744; b=T7jb+JxLcsYRpNbSvf2ENfOI5jWJniAYfVpxVuDyOYWM1pYQhs
    kWEzFaONA46ypIOaoB41LZujysrn2iYTqUyc15na0mYFEU0SmnTW0Wfz+LtBTS/S
    wOUJeJrt4OfkcLo/4TfopGFlYYSGD8sYZ6Fa+nR0JWpHfDbPhYzXSEmWnSrgdhzs
    0Y0KkJ6RaXY44vKCc6VZbNslp4EXwvsMQ6FtyTIT4coFiSuaaPmEuVbDmiDNl8yT
    sUrfI0kdqabsdVVba11elft/0UT5+HOs8Z0zU48ls+ClGrBoQqcDoqgdJllltt1s
    geN/roW4agvv2+nWqo1Fh7hgGFUQycFEcNlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523239744; bh=b0YiT2T+Ft
    Lxzj6FY8UY5BYfCR7ObNbbB0WGW14ZOaE=; b=a6IjtvQzG0fblv3JD/yzUdlx3o
    OThiNZYaj9moYCxm4rB/jd5PWi8A2HYRQ8Delmh3jsxCWyyh7Nbz4DkIZrsVn03E
    DZTdq4/48UjiRLGjAbZRBeoEqdOURwYUvFIKkVDrINWVAjxkwqCsqeMytsz94E6x
    ukKGs/OECgVKHSBjz4+IP6+vO9K06M9lwQB6JGVIoZm1pN6JTh7yHmBn294VA7/h
    CkIWmO0aZPBZKWiL/7D8HgHVSovdaernc5+DN+ko8ad3GFJGzrwM1g52cb/wFGhD
    rH04GfkfdX3mF05pykkEp1nvBI5r/NEep/w7mMhBOl4iiKfl7Q6t9gsZxQ2g==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=IngJYxMV x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
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
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=IngJYxMV x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfJ9lXodxr6qpCLtRI02nGZC45hgxzWwGygIonq7DEHxqlhWB0TGCHzOQgtXyLeBCji5Twva1V1baZzRMaunGojz7Dg8Dsp08g8aWKmSB3oHvrjCQowyn
    qKpsthri+nfoS1OVaWJ32t9DRpmpwBRi25osXqesmXXcWMsgpCfko0+gVLxHdPftSoQKIJka8g97i5vALvmx1Z+xVpZGPh85xaPCosePjKvOAyHeOM1EzsPR
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=QyXUC8HyAAAA:8 a=VwQbUJbxAAAA:8 a=EqdPLkY1AAAA:8
    a=yMhMjlubAAAA:8 a=_dgP1hYIn76or_26-AoA:9 a=wPNLvfGTeEIA:10
    a=AjGcO6oz07-iQ99wixmX:22 a=dfeKg4RqpEhWThG6bP4-:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757529AbeDICIo (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 22:08:44 -0400
Received: from mail-by2nam03on0126.outbound.protection.outlook.com ([104.47.42.126]:54752
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1756255AbeDIAbW (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:31:22 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Lv Zheng <lv.zheng@intel.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 168/293] ACPI / EC: Add support to skip boot
 stage DSDT probe
Thread-Topic: [PATCH AUTOSEL for 4.9 168/293] ACPI / EC: Add support to skip
 boot stage DSDT probe
Thread-Index: AQHTz5k1HZKcGNrwkUGRd2s7f/GyaA==
Date: Mon, 9 Apr 2018 00:25:05 +0000
Message-ID: <20180409002239.163177-168-alexander.levin@microsoft.com>
References: <20180409002239.163177-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409002239.163177-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0917;7:Tdlq+MMmKcoyP1lLgd1cdApH+/TkrgDzAM2OkWpaQpGahQ5jUiO1XgRDng8iPQW8/O6VckK799j4RXjLFlFm4jRK6kjLGNAOL2n2hVGcGJvfyW6XTN/ktntuaFEj3RHJYJIkzcWWKZXUudrFDtDvXfmf6S3pJLjEMlwlU8B0s6bmIMj8eE/jslim3xPvfKDaN3EHjjQBHjg8XEKKAafDRgXkTgRdrAbMs0YF5s20TehtgWNXbjvQ8Utc//4Lk4sC;20:dttpZsJ68jKIRDTwN+tdYJy6lHdouD8Wh2sHxQ+rkatraBaNypSWHfQTm8yOnbS8XSm4GdYZHxp2fcW5SsXISTBOD0QhF+5wb4ZJmkq/h80TSDrgkPyOTkBAQPr7kjXxy1kS3UIc7FVcuci5CmIzAMZ9m65iAwbRefuJGJnkv2g=
X-MS-Office365-Filtering-Correlation-Id: 73702c25-0e69-4897-e40c-08d59db134f6
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(4604075)(3008032)(48565401081)(2017052603328)(7193020);SRVR:DM5PR2101MB0917;
x-ms-traffictypediagnostic: DM5PR2101MB0917:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB0917BE0F3BB206FE2F074D05FBBF0@DM5PR2101MB0917.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(228905959029699);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231221)(944501327)(52105095)(3002001)(10201501046)(6055026)(61426038)(61427038)(6041310)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(20161123560045)(6072148)(201708071742011);SRVR:DM5PR2101MB0917;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0917;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39380400002)(39860400002)(366004)(396003)(346002)(376002)(189003)(199004)(54534003)(99286004)(22452003)(106356001)(26005)(110136005)(478600001)(54906003)(10290500003)(316002)(1076002)(72206003)(186003)(4326008)(97736004)(66066001)(11346002)(25786009)(86362001)(575784001)(476003)(446003)(2906002)(6666003)(6486002)(105586002)(86612001)(3280700002)(3660700001)(6512007)(3846002)(6306002)(6116002)(6436002)(2616005)(486006)(53936002)(7736002)(8676002)(81166006)(81156014)(8936002)(68736007)(305945005)(10090500001)(76176011)(6506007)(102836004)(36756003)(107886003)(59450400001)(2900100001)(2501003)(14454004)(966005)(5660300001)(5250100002)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0917;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: yAXZt8AGtduX0HYRDtj1hFPCA35Z2r2aGKKeyniXooMG0mCljO4k/EKbN3DLE5+qFVNwnqKl4SmCjPwR2UPcT6muI93Ur6VHKOmVFX3AYKJmKVM8GGDv48Cw7AkREx+qG3eBBXlG6cvXNVUNwljxNDM/MKdbmYbnh7fb12X3D0UdKVYbtuOqJdCPWW+4345SS9Z/06ml58pIceMuq4omBbSmLXUhEuypxzHqANQrcDQxfgQ9YzeUGQHtKEJv4tIgeIhsG3OMCXmpxy7OLSCbDjQ/zRGh0janNHXybbspauz/hK/VRl6UOqIvXP8JVoDFL47L9HRoJ787EG3MXbi+LuwLG/sv8Q+ytijSbgmfTGl1NwH1rJQMm59Th3YPQ9xfRPI+x8VlCEdQO9uDWqlNtvRQA9ixtaC94KnMy2MgNXg=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 73702c25-0e69-4897-e40c-08d59db134f6
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:25:05.8626
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0917
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Lv Zheng <lv.zheng@intel.com>

[ Upstream commit c712bb58d8278465b1a91f362a08f5c79ad077e4 ]

We prepared _INI/_STA methods for \_SB, \_SB.PCI0, \_SB.LID0 and
\_SB.EC, _HID(PNP0C09)/_CRS/_GPE for \_SB.EC to poke Windows behavior
with qemu, we got the following execution sequence:

 \_SB._INI
 \_SB.PCI0._STA
 \_SB.LID0._STA
 \_SB.EC._STA
 \_SB.PCI0._INI
 \_SB.LID0._INI
 \_SB.EC._INI

There is no extra DSDT EC device enumeration process occurring before
the main ACPI device enumeration process. That means acpi_ec_dsdt_probe()
is not Windows-compatible.

Tracking back, it was added by the following commit:

  Commit: c5279dee26c0e8d7c4200993bfc4b540d2469598
  Subject: ACPI: EC: Add some basic check for ECDT data

but that commit was misguided.

Why we shouldn't enumerate DSDT EC before the main ACPI device
enumeration?

The only way to know if the DSDT EC is valid would be to evaluate its
_STA control method, but it's not safe to evaluate this control method
that early and out of the ACPI enumeration process, because _STA may
refer to entities (such as resources or ACPI device objects) that may
not have been initialized before OSPM starts to enumerate them via
the main ACPI device enumeration.

But after we had reverted back to the expected behavior, a regression
was reported.  On that platform, there is no ECDT, but the platform
control methods access EC operation region earlier than Linux expects
causing some ACPI method execution errors. For this reason, we just
go back to old behavior to still probe DSDT EC as the boot EC.

However, that turns out to lead to yet another functional breakage
and in order to work around all of the problems, we skip boot stage
DSDT probe when the ECDT exists so that a later quirk can always use
correct ECDT GPE setting.

Link: http://bugzilla.kernel.org/show_bug.cgi?id=3D11880
Link: http://bugzilla.kernel.org/show_bug.cgi?id=3D119261
Link: http://bugzilla.kernel.org/show_bug.cgi?id=3D195651
Tested-by: Daniel Drake <drake@endlessm.com>
Signed-off-by: Lv Zheng <lv.zheng@intel.com>
[ rjw: Changelog & comments massage ]
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/acpi/ec.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/acpi/ec.c b/drivers/acpi/ec.c
index 217b0bac33d9..d4e8a17d939a 100644
--- a/drivers/acpi/ec.c
+++ b/drivers/acpi/ec.c
@@ -1693,12 +1693,26 @@ static const struct acpi_device_id ec_device_ids[] =
=3D {
 	{"", 0},
 };
=20
+/*
+ * This function is not Windows-compatible as Windows never enumerates the
+ * namespace EC before the main ACPI device enumeration process. It is
+ * retained for historical reason and will be deprecated in the future.
+ */
 int __init acpi_ec_dsdt_probe(void)
 {
 	acpi_status status;
 	struct acpi_ec *ec;
 	int ret;
=20
+	/*
+	 * If a platform has ECDT, there is no need to proceed as the
+	 * following probe is not a part of the ACPI device enumeration,
+	 * executing _STA is not safe, and thus this probe may risk of
+	 * picking up an invalid EC device.
+	 */
+	if (boot_ec)
+		return -ENODEV;
+
 	ec =3D acpi_ec_alloc();
 	if (!ec)
 		return -ENOMEM;
--=20
2.15.1
