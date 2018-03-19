Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3891247-1521498490-2-7275827804475722150
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
    t=1521498489; b=airN/f2zC4siHHgHeP92bGFm9DidBc7XKK7HOif1pJISmM2
    0+PSLjc2+T8apVxXBviFjFYI7xO72gVjn8Alj5I3Xmje6BOiJIevgYxYZLVetxVS
    RJdK0ohXzWmpoMo2r9jI4+a6MTSuaNDb9OlYahvOvQamFMHBqEKx0RdNLiH6G1pv
    pJkSlBuDLvvuECYKMUC9SovHIpIr81MwUpLRzmaUVbxRukUbHIZE09UeGLisNIcF
    huGBZyB1FqIJohZ0Cu2o+o4Pk0mBJNN4G0EqJII3GcnPkJjeVMsp33Ye7RnPw+1w
    kFAHMWhadTjpRAcfvfNvEPn1c8GvKqNhqM835RA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1521498489; bh=jN2IHt
    24fCR6So++eEIb2dkZYm0FQ63T2qh6TiVs6OU=; b=AmkjaU7alJOyvCWuusG0es
    52VSJgsa4qfBeLt8kmHVvu1DPU//MYLNmwbIRbqbf9c5BiYVPU6OQjkrWhohURTg
    8OEdixHVuRVYHLQtFAhe5j0BEIkNWHrGxjOPiFpH1Bq7bZTReqQlT/tTtaXnxVDK
    xZhWfFHSLojLKZ4bd4dUqXIKDHuop/Ke8AbNmgw2xsu/799dILYRAU7XrneIPele
    +XyXqTzQPAkhifiCWCscFCRaHG07so84DYUjqZDjte9adIIC1oC9zIRrNcS9h3zS
    Vlyzt6r2GOfJRUzqPBE8cZGO38gW8WTJ7V3mmz+isxwz8kZMs1onvTLstpE8BTXQ
    ==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=gPYncI+n x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdduiedvucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeduuddujeehnecuvehluhhsthgvrhfuihiivgepkeef;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=gPYncI+n x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdduiedvucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeduuddujeehnecuvehluhhsthgvrhfuihiivgepkeef;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933866AbeCSW1R (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 18:27:17 -0400
Received: from mail-sn1nam02on0103.outbound.protection.outlook.com ([104.47.36.103]:38940
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S933848AbeCSPs4 (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 19 Mar 2018 11:48:56 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Javier Martinez Canillas <javierm@redhat.com>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.15 064/124] tpm: return a TPM_RC_COMMAND_CODE
 response if command is not implemented
Thread-Topic: [PATCH AUTOSEL for 4.15 064/124] tpm: return a
 TPM_RC_COMMAND_CODE response if command is not implemented
Thread-Index: AQHTv5mtSq9yOIO9yk+agjT/FcuLlQ==
Date: Mon, 19 Mar 2018 15:48:09 +0000
Message-ID: <20180319154645.11350-64-alexander.levin@microsoft.com>
References: <20180319154645.11350-1-alexander.levin@microsoft.com>
In-Reply-To: <20180319154645.11350-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0936;7:HmAl0M5pDJytsTHszQ4dA554iOtbauGEmbIgT8t53GcJk7kYTAivWt2OI5la5DteWg0wmwnznaOkce36gqzcopww5vpnHbVVaNjkOvg3E2lnMecEDDOpJHEn+ZowELw0ZO+mo/RO3KF+qvkJxdQz9K1e5dTJdBlM/QaPNPQK/KyMVe/UoikKgXjyckf3wiiYPc4UyGy7pG8GFBmJnW15I7xOTju/NSJNXJI9gM3Lsgi4+V2mdphw4o0UIFciLzpO;20:IiNUsiTvZxc5XrdVzrnCrWUrtnRBzafocwuFphv4//QH708RosQ7zdasH8UodV+0Vy0CJpj6NpHKJMZ4qPu9X5/sh878Qf+LTCpVPP7gjn+y2+bZ/Na0aAK6iPgs5I2V1/aBaAR6YUHZ/wIyL04PNFpGFNPwFtQnB16FOQW4eHE=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 8b3ac393-3e1c-4ca6-ec9d-08d58db0e934
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0936;
x-ms-traffictypediagnostic: DM5PR2101MB0936:
x-microsoft-antispam-prvs: <DM5PR2101MB093691D32F72FB8428E6898BFBD40@DM5PR2101MB0936.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(228905959029699);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(10201501046)(3002001)(93006095)(93001095)(3231221)(944501300)(52105095)(6055026)(61426038)(61427038)(6041310)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123560045)(20161123562045)(6072148)(201708071742011);SRVR:DM5PR2101MB0936;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0936;
x-forefront-prvs: 06167FAD59
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39380400002)(346002)(39860400002)(366004)(376002)(396003)(199004)(189003)(2900100001)(3280700002)(2950100002)(10290500003)(66066001)(106356001)(76176011)(86612001)(6666003)(478600001)(5250100002)(6512007)(6486002)(107886003)(36756003)(97736004)(72206003)(25786009)(6436002)(53936002)(7736002)(2501003)(54906003)(110136005)(105586002)(10090500001)(2906002)(86362001)(305945005)(5660300001)(316002)(8676002)(6346003)(1076002)(3846002)(3660700001)(81156014)(4326008)(14454004)(26005)(6116002)(102836004)(8936002)(81166006)(6506007)(186003)(22452003)(59450400001)(99286004)(68736007)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0936;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-message-info: 5UjPaNt+tmpnCWfrS72lde6RZLEALGPlVs7zP+gzjsg+N4McpdAf31KVMMlbs+CWMT8QcklaAUabgcd9jTer32DN83HzhJC/u1/2FnYZw3plGVPbSYW1nYPOxmX9e7FWGVq/RBO92EDt6A/+4ax2CaN3Rw/4cZC7oyjgXcR0HKBfUs68+RTZIy+yfM8KzYpFGVCMqunStVsIZ18nOOx2HG/jXXupavj5uekPZEA/Hw7vwG1SjlmQlKJbPOcjyfgz9460lguM1vFCEWE1G/iAPoUF8FCzBB76fEqFRkuwERPFZUW5Sl04MKK7aI3dZ4dYXZlGHFVT/p+eKHry2n3tKw==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b3ac393-3e1c-4ca6-ec9d-08d58db0e934
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2018 15:48:09.3142
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0936
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Javier Martinez Canillas <javierm@redhat.com>

[ Upstream commit 095531f891e627e408606f2da4008d3d53e6748a ]

According to the TPM Library Specification, a TPM device must do a command
header validation before processing and return a TPM_RC_COMMAND_CODE code
if the command is not implemented.

So user-space will expect to handle that response as an error. But if the
in-kernel resource manager is used (/dev/tpmrm?), an -EINVAL errno code is
returned instead if the command isn't implemented. This confuses userspace
since it doesn't expect that error value.

This also isn't consistent with the behavior when not using TPM spaces and
accessing the TPM directly (/dev/tpm?). In this case, the command is sent
to the TPM even when not implemented and the TPM responds with an error.

Instead of returning an -EINVAL errno code when the tpm_validate_command()
function fails, synthesize a TPM command response so user-space can get a
TPM_RC_COMMAND_CODE as expected when a chip doesn't implement the command.

The TPM only sets 12 of the 32 bits in the TPM_RC response, so the TSS and
TAB specifications define that higher layers in the stack should use some
of the unused 20 bits to specify from which level of the stack the error
is coming from.

Since the TPM_RC_COMMAND_CODE response code is sent by the kernel resource
manager, set the error level to the TAB/RM layer so user-space is aware of
this.

Suggested-by: Jason Gunthorpe <jgg@ziepe.ca>
Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
Reviewed-by: William Roberts <william.c.roberts@intel.com>
Reviewed-by: Philip Tricca <philip.b.tricca@intel.com>
Reviewed-by: Jarkko Sakkinen  <jarkko.sakkinen@linux.intel.com>
Tested-by: Jarkko Sakkinen  <jarkko.sakkinen@linux.intel.com>
Signed-off-by: Jarkko Sakkinen  <jarkko.sakkinen@linux.intel.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/char/tpm/tpm-interface.c | 28 ++++++++++++++++++++--------
 drivers/char/tpm/tpm.h           |  5 +++++
 2 files changed, 25 insertions(+), 8 deletions(-)

diff --git a/drivers/char/tpm/tpm-interface.c b/drivers/char/tpm/tpm-interf=
ace.c
index 5294442505cb..0f1dc35e7078 100644
--- a/drivers/char/tpm/tpm-interface.c
+++ b/drivers/char/tpm/tpm-interface.c
@@ -328,7 +328,7 @@ unsigned long tpm_calc_ordinal_duration(struct tpm_chip=
 *chip,
 }
 EXPORT_SYMBOL_GPL(tpm_calc_ordinal_duration);
=20
-static bool tpm_validate_command(struct tpm_chip *chip,
+static int tpm_validate_command(struct tpm_chip *chip,
 				 struct tpm_space *space,
 				 const u8 *cmd,
 				 size_t len)
@@ -340,10 +340,10 @@ static bool tpm_validate_command(struct tpm_chip *chi=
p,
 	unsigned int nr_handles;
=20
 	if (len < TPM_HEADER_SIZE)
-		return false;
+		return -EINVAL;
=20
 	if (!space)
-		return true;
+		return 0;
=20
 	if (chip->flags & TPM_CHIP_FLAG_TPM2 && chip->nr_commands) {
 		cc =3D be32_to_cpu(header->ordinal);
@@ -352,7 +352,7 @@ static bool tpm_validate_command(struct tpm_chip *chip,
 		if (i < 0) {
 			dev_dbg(&chip->dev, "0x%04X is an invalid command\n",
 				cc);
-			return false;
+			return -EOPNOTSUPP;
 		}
=20
 		attrs =3D chip->cc_attrs_tbl[i];
@@ -362,11 +362,11 @@ static bool tpm_validate_command(struct tpm_chip *chi=
p,
 			goto err_len;
 	}
=20
-	return true;
+	return 0;
 err_len:
 	dev_dbg(&chip->dev,
 		"%s: insufficient command length %zu", __func__, len);
-	return false;
+	return -EINVAL;
 }
=20
 /**
@@ -391,8 +391,20 @@ ssize_t tpm_transmit(struct tpm_chip *chip, struct tpm=
_space *space,
 	unsigned long stop;
 	bool need_locality;
=20
-	if (!tpm_validate_command(chip, space, buf, bufsiz))
-		return -EINVAL;
+	rc =3D tpm_validate_command(chip, space, buf, bufsiz);
+	if (rc =3D=3D -EINVAL)
+		return rc;
+	/*
+	 * If the command is not implemented by the TPM, synthesize a
+	 * response with a TPM2_RC_COMMAND_CODE return for user-space.
+	 */
+	if (rc =3D=3D -EOPNOTSUPP) {
+		header->length =3D cpu_to_be32(sizeof(*header));
+		header->tag =3D cpu_to_be16(TPM2_ST_NO_SESSIONS);
+		header->return_code =3D cpu_to_be32(TPM2_RC_COMMAND_CODE |
+						  TSS2_RESMGR_TPM_RC_LAYER);
+		return bufsiz;
+	}
=20
 	if (bufsiz > TPM_BUFSIZE)
 		bufsiz =3D TPM_BUFSIZE;
diff --git a/drivers/char/tpm/tpm.h b/drivers/char/tpm/tpm.h
index 528cffbd49d3..f6f56dfda6c7 100644
--- a/drivers/char/tpm/tpm.h
+++ b/drivers/char/tpm/tpm.h
@@ -93,12 +93,17 @@ enum tpm2_structures {
 	TPM2_ST_SESSIONS	=3D 0x8002,
 };
=20
+/* Indicates from what layer of the software stack the error comes from */
+#define TSS2_RC_LAYER_SHIFT	 16
+#define TSS2_RESMGR_TPM_RC_LAYER (11 << TSS2_RC_LAYER_SHIFT)
+
 enum tpm2_return_codes {
 	TPM2_RC_SUCCESS		=3D 0x0000,
 	TPM2_RC_HASH		=3D 0x0083, /* RC_FMT1 */
 	TPM2_RC_HANDLE		=3D 0x008B,
 	TPM2_RC_INITIALIZE	=3D 0x0100, /* RC_VER1 */
 	TPM2_RC_DISABLED	=3D 0x0120,
+	TPM2_RC_COMMAND_CODE    =3D 0x0143,
 	TPM2_RC_TESTING		=3D 0x090A, /* RC_WARN */
 	TPM2_RC_REFERENCE_H0	=3D 0x0910,
 };
--=20
2.14.1
