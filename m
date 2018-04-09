Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3607359-1523233330-2-10569494523013597466
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523233330; b=BroxGq+k8hhkt8Bv3cnqh4Wz/va/qwhrYHbKk0EDDqOtkwWD44
    0l8ZCa09u6t221zFrQr6mJY1WkDsT2SRZgS8l0UTdZBSHE56y3e1wVhXvP6LwZyx
    9fgW5kEGHWoUnRK1rnlYczJX8P/7S802CvlYks7KIL5cYTjZlf/w4TNOUZpHnjjF
    XLdAy27nq6459OKuJA7Tpb5/nmQt+3YvFPFC52kvvZ3xLK9pSGk9d0NIZGnvT9rn
    A9LC20jQwwTI1A0aBMphM4+QJTp54gk1ohRh9735CyJOz9Y0EQPMGQXU9+q/3nFF
    qZQ4H/egBqmrl0qOzM8fckxsijhIgRdcAuWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523233330; bh=jL66kT/QIl
    dYPGb0LFH0VEwd3aMvnDphNWVlBld5Ft8=; b=igh7e9NF3DGLq94woJ9tspsv7y
    aJnIxZNbDZ1LsSnZ37w8tJ7RCXvHreFIXn4Dni7xmflyVq8hVcr0r8mSig1HpeCj
    pLDFBCWn3tp4cUrWRU3+TM/tsMtkd00QRUVq913aOXd//uxLcK49GH8A3IpgMxxy
    EGclSeT0cTEff0ccLnIFlfA9BeSd47WpxjdjJjudlFBSz+G7nph3oy3rwzdqgZou
    Xs5ADTxnvOtohqtV7ss8HHSJWNMakPjWj2dq9gpoJ2Xw0hAIqCX5vuBLHen1S11u
    CNt7zlX20fSKO2W7ve+rqaTLeOmY7niZsvCFxJ6vtVgW1paJkxQifpjwwhbA==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=LYx5guNH x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
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
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=LYx5guNH x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfOlB215HWGlv5+6MBMESY0smzAIT4ivwrxsJLTADA1BWAdfNxKoC+qH4BnGaHs6tBscY3OyrNz1hbVxLz4qvH8FgchzfbJshvAC8L7Unk9H1dvOs+oUm
    fJ4v2gkWAIRQeoIueDumxJbroNB0KX3QFTUAJdPT7wdPkmrEGbej7HCIwg5OJkSmKthb7EplLgSZzrgbQT9rAANwql1g1tOuZgtmEd9JxcWMlChBo4IRa+lg
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=20KFwNOVAAAA:8 a=QyXUC8HyAAAA:8 a=yMhMjlubAAAA:8
    a=LJ-5F7uA5V6xs_NIBFAA:9 a=wPNLvfGTeEIA:10
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754538AbeDIAWE (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 20:22:04 -0400
Received: from mail-sn1nam02on0111.outbound.protection.outlook.com ([104.47.36.111]:52845
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754574AbeDIAWA (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:22:00 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Hans de Goede <hdegoede@redhat.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.14 004/161] ACPI / LPSS: Do not instiate
 platform_dev for devs without MMIO resources
Thread-Topic: [PATCH AUTOSEL for 4.14 004/161] ACPI / LPSS: Do not instiate
 platform_dev for devs without MMIO resources
Thread-Index: AQHTz5h1iQ7tlLju5U6g9VhV3gXhUQ==
Date: Mon, 9 Apr 2018 00:19:44 +0000
Message-ID: <20180409001936.162706-4-alexander.levin@microsoft.com>
References: <20180409001936.162706-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409001936.162706-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0936;7:Uej0pgu4nsKxdiQD0qj0JmNAjj6xge9lph0e/Nw37radF4BuXeqW7fX/fIdn02TC+zLm3jI+Z5l6LoVRu+DIpB0WH9n0/cT66vTHmWd4kimpJ8ZpFbn0CF/kuBataX3z7as58JqT+VDsFDTApxSP3dSRJ697jzSBNd0R/OSHJcLxxpDZ7vJm4mnOod8/pO08RlQYMShWwrrrCm/z6PxsWaEhQ3PtYrZsdBREi92jWQKMGQXM+a0JBRM7Ajrwp3IK;20:c9yc+1KyA8CdiXFGUa/Ew51tsYgVMU3z6TvKVwKKZ99RpsPnfMDYV0FBVHRPUVWE75/Evu2UWr+OGqGjugzejASBY9oUpUhB59OJmEG1BvhiDE7nsSqM6LPPStGHqJVU39wLYzfZIN9X1NXAQ8gyYLcDdHDdKR3moPTh4s5b0PQ=
x-ms-office365-filtering-ht: Tenant
X-MS-Office365-Filtering-Correlation-Id: f8784348-c4ed-4678-a759-08d59dafe6d9
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0936;
x-ms-traffictypediagnostic: DM5PR2101MB0936:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB0936E281053F5B43066FE66EFBBF0@DM5PR2101MB0936.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(228905959029699);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3231221)(944501327)(52105095)(3002001)(10201501046)(6055026)(61426038)(61427038)(6041310)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:DM5PR2101MB0936;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0936;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(39380400002)(39860400002)(396003)(376002)(366004)(199004)(189003)(3660700001)(36756003)(2501003)(76176011)(5890100001)(10290500003)(2616005)(5250100002)(3280700002)(478600001)(1076002)(72206003)(6436002)(53936002)(486006)(476003)(4326008)(6486002)(107886003)(5660300001)(54906003)(110136005)(102836004)(2906002)(6116002)(3846002)(86612001)(81156014)(81166006)(6666003)(8936002)(305945005)(8676002)(2900100001)(6506007)(68736007)(14454004)(106356001)(105586002)(25786009)(6512007)(86362001)(99286004)(446003)(59450400001)(10090500001)(11346002)(316002)(26005)(7736002)(66066001)(186003)(22452003)(97736004)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0936;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: Oy85mG/GRPX5v8m9TsCP8DuljM1EnpBLeuv1ZLe7bsJPfjCXhv/Cny9xOjxjHrPXjzFmjoXXYeEkqpNQC0hjb7EYOw5QdSECumtLsThqSva5TBN103GMh+dp1c74kXeTAqW/dlp3w1biEAyqjqHiqztR0gR6o1xj8LAlean0B6YXV9aryMR7ib4hqRjZjxg5cOR7SOL+n0BUPWQa67emAYv8SsLXU2XEcSL1BDwFiZTou2VPTpJmVpqCR38bTGBs1L6GwXe+zWWXINR1nrgYJTaNK/66SyLPCc1OlJxGEIrzslCIxksbeRbxusFwMYOAxKt4HYWM7NVTWN+Ksf26Ns7rTuhOXkdBQHCdKbZE5AMENjTrt7OXyBCfe9GgvPIna4mQ5yjDjSluO4AY6CQVxBDf5Y+aNbq3UalSLpzgxq8=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f8784348-c4ed-4678-a759-08d59dafe6d9
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:19:44.1076
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0936
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Hans de Goede <hdegoede@redhat.com>

[ Upstream commit e1681599345b8466786b6e54a2db2a00a068a3f3 ]

acpi_lpss_create_device() skips handling LPSS devices which do not have
a mmio resources in their resource list (typically these devices are
disabled by the firmware). But since the LPSS code does not bind to the
device, acpi_bus_attach() ends up still creating a platform device for
it and the regular platform_driver for the ACPI HID still tries to bind
to it.

This happens e.g. on some boards which do not use the pwm-controller
and have an empty or invalid resource-table for it. Currently this causes
these error messages to get logged:

[    3.281966] pwm-lpss 80862288:00: invalid resource
[    3.287098] pwm-lpss: probe of 80862288:00 failed with error -22

This commit stops the undesirable creation of a platform_device for
disabled LPSS devices by setting pnp.type.platform_id to 0. Note that
acpi_scan_attach_handler() also sets pnp.type.platform_id to 0 when there
is a matching handler for the device and that handler has no attach
callback, so we simply behave as a handler without an attach function
in this case.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Acked-by: Mika Westerberg <mika.westerberg@linux.intel.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/acpi/acpi_lpss.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/acpi/acpi_lpss.c b/drivers/acpi/acpi_lpss.c
index 032ae44710e5..a2be3fd2c72b 100644
--- a/drivers/acpi/acpi_lpss.c
+++ b/drivers/acpi/acpi_lpss.c
@@ -465,6 +465,8 @@ static int acpi_lpss_create_device(struct acpi_device *=
adev,
 	acpi_dev_free_resource_list(&resource_list);
=20
 	if (!pdata->mmio_base) {
+		/* Avoid acpi_bus_attach() instantiating a pdev for this dev. */
+		adev->pnp.type.platform_id =3D 0;
 		/* Skip the device, but continue the namespace scan. */
 		ret =3D 0;
 		goto err_out;
--=20
2.15.1
