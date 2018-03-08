Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1025811-1520487725-2-11620911344528453387
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
    t=1520487724; b=wdoxn+Qs1ZyXUajzJpiHA2kb5fbJXrVTSP6C4QrfCH1qpcO
    IbRRSOkyifObT0vWlvOdFthFAuQhRlzMli4Q2gCUmR64hBSQJeWMLBaVh2h/KM7V
    UJoU9m823wjH5g2hvuXM0B0DMCi0/SwBxdw5zAMLRq0lBwWhNN8ql/KpbE5onj8V
    L2fdwB8WzFHyimV/19KxrGXMWdtQqnlUYwXyUbH12gL7pD30TZo8eNfPExQ5hpt3
    2ihgVQb/UFQ57cyYWlvcG1c1sLluY41B6Kp4dGEBxojmBap9SVVK+95qFfFp4Qwq
    ygzfFGje+3cMf08R2tEFJLQugmDH2rdTc9MLajw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520487724; bh=aZYKrR
    brHrpHr+6ENDD98Oy5HQDikxHd1xTS+WoUM4k=; b=Eqm/b4Nku5Crh4Js7CcWqj
    866UV2Q+P/68FTEgHJ6rbqIIkcv5SgYwf2xBnWSd/XP1OoQ/fb1B9wvnYPAg+nta
    zkda8RGwk4k/jgIYAMtsaBBHuC+JbFfIKR+MLn+5h4xMyrB35MTomV4iMC21ZFBr
    IVuQfJUxWvOkEmV53uX/5FGph0J11Inke2SUP0aXwDwZBACfjtZRS3qOKZxrYG1G
    oI3ZtLbUhXal/zUYazKzbWOOBeoZhmoPPzk3XTmJFc9f+Evo7h8+Fnn6qwt4W3PN
    WI2zRON7V+VTXGm4uq3+ngBbBEovcznUrtqFbdhtVFsdok1ne37SWHndyGOya6IA
    ==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=bSLb0o6K x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=bSLb0o6K x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966227AbeCHFlE (ORCPT <rfc822;greg@kroah.com>);
        Thu, 8 Mar 2018 00:41:04 -0500
Received: from mail-bl2nam02on0126.outbound.protection.outlook.com ([104.47.38.126]:13526
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S966219AbeCHFFW (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 8 Mar 2018 00:05:22 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Edgar Cherkasov <echerkasov@dev.rtsoft.ru>,
        Michael Brunner <Michael.Brunner@kontron.com>,
        Wolfram Sang <wsa@the-dreams.de>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.4 021/101] i2c: i2c-scmi: add a MS HID
Thread-Topic: [PATCH AUTOSEL for 4.4 021/101] i2c: i2c-scmi: add a MS HID
Thread-Index: AQHTtpqGcsbCWJ/fOkGrag9EEt+0uw==
Date: Thu, 8 Mar 2018 05:01:32 +0000
Message-ID: <20180308050023.8548-21-alexander.levin@microsoft.com>
References: <20180308050023.8548-1-alexander.levin@microsoft.com>
In-Reply-To: <20180308050023.8548-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0727;7:FvAbNJlHLo94yWpJDuJ0mGJAg3F2g4kxznpSzX3gxQMUn7gG1jGfjxIdOW/aspuiFTUO4/PhavWRBGgN+ukz4mmROrnQ91bGrG86G88A5NOQ+PVBddAl0HntjW75uvuybGMva/Vp1kkDR53oc8HVCTLcnL/QQSXsgv3jojXd6DW7a79KrpGG5BB84lspfKAzPzAkcikQYvBA0bCfr2LjtypagDALckjjhdFuecqBNFtDrOExMKvp3eot/qN+ZCE9;20:DOx2yhLHNzY2cHjO1E1LBEc0+tslMTO6U+dYgEDa/inyoTu6qgVQ/kSrTxNQXKusmYKpEAXCb+zZB2BpQmfWvR0j7jDCx/5tj5wqNNbzddYfce022qO286S9Y+Wvjwv4kDX3GKkEG6W02SMDelvRucwE9Rn47zvAGwVGD5BOc1w=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 9735a68a-e1cb-42ef-3e07-08d584b22cd8
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0727;
x-ms-traffictypediagnostic: DM5PR2101MB0727:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB0727CE6424A4E37988CB378BFBDF0@DM5PR2101MB0727.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(228905959029699);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(5005006)(8121501046)(3002001)(10201501046)(3231220)(944501244)(52105095)(93006095)(93001095)(6055026)(61426038)(61427038)(6041288)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123558120)(20161123564045)(6072148)(201708071742011);SRVR:DM5PR2101MB0727;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0727;
x-forefront-prvs: 060503E79B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(39380400002)(396003)(366004)(376002)(346002)(199004)(189003)(81156014)(4326008)(97736004)(105586002)(2906002)(6666003)(8676002)(26005)(10290500003)(76176011)(186003)(110136005)(22452003)(7736002)(54906003)(25786009)(2950100002)(4477795004)(3280700002)(305945005)(81166006)(2900100001)(8936002)(102836004)(6506007)(68736007)(106356001)(10090500001)(1076002)(6512007)(86362001)(3846002)(2501003)(14454004)(478600001)(99286004)(72206003)(6116002)(3660700001)(5250100002)(53936002)(107886003)(6436002)(5660300001)(316002)(6486002)(36756003)(86612001)(66066001)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0727;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
x-microsoft-antispam-message-info: oirpSb/919PbsOAOWrTArrhNg76HrL3IhNw+bndmJmOkCD/o5Zzzp8V6PIYbLoCrA649nIOFOS9jep4PQG3t2aOxg/iQOvNiIViQ2wkGzE7b8sR3ut13E4htHoynfArmKJEQ8rlbg2qHDcjZaKLJ9EQAnM1M5c584XN0AdjbFgf+KuKC7eq7mqnhYnsYcs8nV4znNg41y3uAuGGwglVb0pLlDxUq6sQi8nVUtijKeY2T37Pa0Me59LTXJLp2wyowp5KMsDkFo5j2B5dMdPreqpWf33cI97y+s8Mv/5mZPsKd4Om2B+UgBbrYc7ZHT7Sebj+IAYXbuMcDPHZV4xLhcg==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9735a68a-e1cb-42ef-3e07-08d584b22cd8
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Mar 2018 05:01:32.8871
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0727
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
