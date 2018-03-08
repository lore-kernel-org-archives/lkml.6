Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1084890-1520490340-2-3034419238482458945
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
    t=1520490339; b=QSy2sxlnyp3vmoCJPeTRvbNxTj85mt+abKtlH7klIkbura3
    knwWkv6v+Fjmdb3x9XHPVXhcXKZKc5ooe8crqES4xI9yy3W0HtuSKS47ZlcqwUKt
    X9oBtEm7FqQjaKz8b0Ytj/AkoVokzVfWfkQTrtCd8t9U5jF7ruz4enA2wjIVZBw2
    7ntyjKvtDwTnQGwgOJgdVcidqjwMzeCx26ydmeVlcXSn6NYF3nzdX0nrKqN7hjrS
    v/1m/VKFKFT8nhx1gyIGTVHmoZXd57yMdbUYAUv1cwfGQsxb7N9lJ0h8HSkjxsvf
    p8Uf9piVQgHPfFUKOTwmMGIHG18nI4HRoqLKdGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520490339; bh=aZYKrR
    brHrpHr+6ENDD98Oy5HQDikxHd1xTS+WoUM4k=; b=Ztwoh4CZgmEEY0amVnto2k
    uH1MYteY8ociJMz9hTdse0iqTlQ/PPxDS+vSDloQVbA0kJU1XpTg4caSvOJ3+NIn
    Cvi6/jhzcBsRWop91jncuDMMDvgxnte4xXjZBplAnu2SKIfh0hlvH5ae+aUno0dW
    OnmxJcrNsFPBF/wdYZHTKEDDkw2FLxIT8QqtQiidsyge9r7kjEBgxV+tlued0B/B
    H2sWOg8NUk8zvBm5k7QDklGeTPEFt0/+wTmGPRAImvA5a5ydQgB323yY5C/Ltv+f
    TB3mDK9WzJWwVndQRwuBiRlwnnFyW2QV6mUHpO3+/OzO99SWzsKkxv/4J8cMWv3Q
    ==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=hQVhIfwu x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=hQVhIfwu x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935361AbeCHGZf (ORCPT <rfc822;greg@kroah.com>);
        Thu, 8 Mar 2018 01:25:35 -0500
Received: from mail-sn1nam01on0111.outbound.protection.outlook.com ([104.47.32.111]:53598
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1755323AbeCHFAn (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 8 Mar 2018 00:00:43 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Edgar Cherkasov <echerkasov@dev.rtsoft.ru>,
        Michael Brunner <Michael.Brunner@kontron.com>,
        Wolfram Sang <wsa@the-dreams.de>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 037/190] i2c: i2c-scmi: add a MS HID
Thread-Topic: [PATCH AUTOSEL for 4.9 037/190] i2c: i2c-scmi: add a MS HID
Thread-Index: AQHTtpow0i+Q7vCb5UancXxlUeeOXw==
Date: Thu, 8 Mar 2018 04:59:07 +0000
Message-ID: <20180308045810.8041-37-alexander.levin@microsoft.com>
References: <20180308045810.8041-1-alexander.levin@microsoft.com>
In-Reply-To: <20180308045810.8041-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1112;7:hgySsOeGkI9jeDdRP0OB3Hn4N2s/gJgQDw6ebm+fOUrRvyHihZJ5h/JZ0Vvq1pSgMTmCrcDeOO5OM7vPUTR/TzVeokD43ZocyrFx5yXr9nRYHNuN1MroDM0hK88VgLPM+ZhSMh9qDrrhGvFzKykzT2WRqG/LiSzQSsmVEL5PyRLSB1WrNYeFoiSjQ/z6Vias1KYz16AvonDTUdt2aiI6WBCfFUuvoUmq1J3U0T6EKbNEEuxHvDxYYn1+o1pWhhsj;20:c3r0NPa8ektGl+UU3SyrQTu3x8l5EjtaG0j1bZRjU6XAFqNJz1L/VobvF2cFgm4FaZ0U8PSCMf5noGD7iGPddr4+XDuXm7j2DeLS/vaxpsAL1BZ8goC4kl4PUooL1ezrcRXFjZbTxpM1UjEYz0LVHz28UaJ4VDD66iBUAeB6rS8=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 7cb3a2b5-4435-4cf2-b8df-08d584b18947
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1112;
x-ms-traffictypediagnostic: DM5PR2101MB1112:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB1112568444D1F6ED2D999996FBDF0@DM5PR2101MB1112.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(228905959029699);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231220)(944501244)(52105095)(10201501046)(3002001)(6055026)(61426038)(61427038)(6041288)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123560045)(6072148)(201708071742011);SRVR:DM5PR2101MB1112;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1112;
x-forefront-prvs: 060503E79B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(346002)(376002)(39380400002)(366004)(396003)(189003)(199004)(54906003)(81156014)(7736002)(86612001)(25786009)(81166006)(6512007)(6486002)(4326008)(3846002)(1076002)(6436002)(36756003)(305945005)(6116002)(8936002)(2900100001)(6666003)(97736004)(66066001)(2950100002)(105586002)(68736007)(14454004)(72206003)(3660700001)(478600001)(10290500003)(4477795004)(3280700002)(53936002)(106356001)(10090500001)(5660300001)(102836004)(107886003)(316002)(110136005)(22452003)(86362001)(2501003)(5250100002)(6506007)(76176011)(99286004)(2906002)(26005)(186003)(8676002)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1112;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
x-microsoft-antispam-message-info: fny3yVzOl8gBjltV/0JbQ2FwDhyiXph05AdA9jRFQtZ936lsoKEOIESTPAcC2z2cN6Sr07A46tit8d0dyFNZQH+Bb7rnTnnKK65ECK/gcy+kIshuegM+qjKmiEtWN6xJcL1NdR/bDZiu+2YzseOvilxxW7yj6YRGycYBcqGvsvTp2PpcmVre/Dv38jSwiEkVr8EBOdz4UepK2zlsMVd22eRxr86Ob0NE2FOYLc8/7R3Wqof8jK1Ssk65kIvcVJsUod/OhciGXF6MHEiTjtbHqSuslUVDPWh/+ijehTXB7563DLToODsFAaC2ffAIUE+dHoJyJ8hh7+37gxvxvK7oAg==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7cb3a2b5-4435-4cf2-b8df-08d584b18947
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Mar 2018 04:59:07.7044
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1112
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Edgar Cherkasov <echerkasov@dev.rtsoft.ru>

[ Upstream commit e058e7a4bc89104540a8a303682248614b5df6f1 ]

Description of the problem:
 - i2c-scmi driver contains only two identifiers "SMBUS01" and "SMBUSIBM";
 - the fist HID (SMBUS01) is clearly defined in "SMBus Control Method
   Interface Specification, version 1.0": "Each device must specify
   'SMBUS01' as its _HID and use a unique _UID value";
 - unfortunately, BIOS vendors (like AMI) seem to ignore this requirement
   and implement "SMB0001" HID instead of "SMBUS01";
 - I speculate that they do this because only "SMB0001" is hard coded in
   Windows SMBus driver produced by Microsoft.

This leads to following situation:
 - SMBus works out of box in Windows but not in Linux;
 - board vendors are forced to add correct "SMBUS01" HID to BIOS to make
   SMBus work in Linux. Moreover the same board vendors complain that
   tools (3-rd party ASL compiler) do not like the "SMBUS01" identifier
   and produce errors.  So they need to constantly patch the compiler for
   each new version of BIOS.

As it is very unlikely that BIOS vendors implement a correct HID in
future, I would propose to consider whether it is possible to work around
the problem by adding MS HID to the Linux i2c-scmi driver.

v2: move the definition of the new HID to the driver itself.

Signed-off-by: Edgar Cherkasov <echerkasov@dev.rtsoft.ru>
Signed-off-by: Michael Brunner <Michael.Brunner@kontron.com>
Acked-by: Viktor Krasnov <vkrasnov@dev.rtsoft.ru>
Reviewed-by: Jean Delvare <jdelvare@suse.de>
Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
Signed-off-by: Wolfram Sang <wsa@the-dreams.de>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/i2c/busses/i2c-scmi.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/i2c/busses/i2c-scmi.c b/drivers/i2c/busses/i2c-scmi.c
index dfc98df7b1b6..7aa7b9cb6203 100644
--- a/drivers/i2c/busses/i2c-scmi.c
+++ b/drivers/i2c/busses/i2c-scmi.c
@@ -18,6 +18,9 @@
 #define ACPI_SMBUS_HC_CLASS		"smbus"
 #define ACPI_SMBUS_HC_DEVICE_NAME	"cmi"
=20
+/* SMBUS HID definition as supported by Microsoft Windows */
+#define ACPI_SMBUS_MS_HID		"SMB0001"
+
 ACPI_MODULE_NAME("smbus_cmi");
=20
 struct smbus_methods_t {
@@ -51,6 +54,7 @@ static const struct smbus_methods_t ibm_smbus_methods =3D=
 {
 static const struct acpi_device_id acpi_smbus_cmi_ids[] =3D {
 	{"SMBUS01", (kernel_ulong_t)&smbus_methods},
 	{ACPI_SMBUS_IBM_HID, (kernel_ulong_t)&ibm_smbus_methods},
+	{ACPI_SMBUS_MS_HID, (kernel_ulong_t)&smbus_methods},
 	{"", 0}
 };
 MODULE_DEVICE_TABLE(acpi, acpi_smbus_cmi_ids);
--=20
2.14.1
