Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3891247-1521496956-2-11932514649140996189
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
    t=1521496955; b=givkaAHcHmC2C6vaCxdVsxFRhLsuJCSs7LyiufjuYFiQETo
    CAjEfWXCCUsmcvDvw8yAgNGYDCMeoeCu9JuulnlLbUCBgc5P5xzV+PG1m3tqUL9z
    TOgFLKDgwcerOpRx6JWl+BoR7mnYjevQTUcxfFiU9PVH+Gf0/B2TLi+N5UQpQzew
    lqYdgfmB5MVuBJBEZWar/ZdoL0Tg4ipE5I5l+NrePTi0AVzeyo+PqpQq96gz974d
    fe7z+b4vCbhGaoA+SvAZagKdiLPDoDUW9IJJ/L22C7oE/R5CS89TtJfHrtn7rxjI
    wMqNvqPe6UuMDVZN79b7MHc4qtBqv4ZLuxPQDaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1521496955; bh=jHQmje
    VbdrjehkaV/DzKhGke+5WScOa4m/vBaqOwdDY=; b=H4ZElg+SEEJbZeA4UPIVyw
    9WkQ+j2VWYWTQ6ccNocpGnQdR/sDcXvbBsX6GnIqiwBCdvuruh5WoEUC8/7MQZTG
    SlGYiTkyqKxy2xw8NrQl4VhoWscKDZVY9feUxkJIi9BhBkFc7tV23fcsivJ05/bY
    Y/aOB9Inu4veJoXwmkgxJ9w6YME2WbGSAFgjOZIr93p3mp7YHB1YmxWKZnF1HZBs
    p0PDBG2mbpWQuqdWehFyYh+zqbHNMgmtHHejVseMxOwYpZnRUszhmNScNHJ0kqvp
    5HRIPlQt5JBEscQ89AUcd3pgQsrBm8gjd9N88cziwX6IONEs32W8PJswDsYi99Cw
    ==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=astgtvSs x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdduheejucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeduudduiedtnecuvehluhhsthgvrhfuihiivgepfeel;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=astgtvSs x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdduheejucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeduudduiedtnecuvehluhhsthgvrhfuihiivgepfeel;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935987AbeCSWBr (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 18:01:47 -0400
Received: from mail-by2nam03on0092.outbound.protection.outlook.com ([104.47.42.92]:42976
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S934437AbeCSPz6 (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 19 Mar 2018 11:55:58 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Javier Martinez Canillas <javierm@redhat.com>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.14 49/97] tpm: return a TPM_RC_COMMAND_CODE
 response if command is not implemented
Thread-Topic: [PATCH AUTOSEL for 4.14 49/97] tpm: return a TPM_RC_COMMAND_CODE
 response if command is not implemented
Thread-Index: AQHTv5qzWW1Ev4C710SFgaP7F0yPHQ==
Date: Mon, 19 Mar 2018 15:55:28 +0000
Message-ID: <20180319155411.12348-49-alexander.levin@microsoft.com>
References: <20180319155411.12348-1-alexander.levin@microsoft.com>
In-Reply-To: <20180319155411.12348-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0967;7:0jgBPmcjWsQ79EPdZQdzyjomx7ahcIN4iGFMjI8arwYkXXRI2Gr7lAtNLtKs8/QLjxpevhy/qNp+fZ+dudzzdEbL28VUMDMCv3ZyGuSvi4z34q2fjOdJDHYFCovayxerV8aBDecwGdVM7ZyoHcN2iayj/nGnSPcAcKoc+PoTM+Mi6i4xw7PJKaolKMb5lqoSTfrE1VQwgkY9vcY9GeADf4ONVh6BnPS2IcPaN33uTq0wy76ka7qAwmK3Of8GiMqW;20:qQwSUo8aTB3wF6AkvJw0t56VT0/OyWOZI1Hc0z6oXxqkkr1lt1IqvNac2eL0c9tNneiQiN3x66EafN04OJRzXkQN1dPB2ACQkwugZxFoqtaHnvFnRMqIFGvSdsgk1fZVfFfiePRi3fhOK0Yo/9Gr6FW2lmpN7rb0t9Ekhegkmc0=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: dd8f2718-a002-4726-bd17-08d58db1e291
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0967;
x-ms-traffictypediagnostic: DM5PR2101MB0967:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB0967AB53CE7AEB37EF1F68FEFBD40@DM5PR2101MB0967.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(228905959029699);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(3231221)(944501300)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(6072148)(201708071742011);SRVR:DM5PR2101MB0967;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0967;
x-forefront-prvs: 06167FAD59
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(39380400002)(376002)(39860400002)(366004)(346002)(189003)(199004)(54906003)(59450400001)(10090500001)(110136005)(5250100002)(2501003)(1076002)(6116002)(3846002)(2900100001)(99286004)(22452003)(3280700002)(186003)(2906002)(76176011)(86612001)(26005)(6486002)(10290500003)(102836004)(14454004)(36756003)(68736007)(3660700001)(72206003)(478600001)(107886003)(106356001)(53936002)(6506007)(6512007)(6436002)(86362001)(105586002)(316002)(7736002)(4326008)(305945005)(66066001)(81156014)(81166006)(5660300001)(97736004)(8936002)(25786009)(8676002)(2950100002)(6666003)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0967;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: C53A8dDU6daxWeLunowYKMfzbvcvuKCH5Iqr4ivDLIqASMZ1e69D0VQ91VplAPZl7k555Oab2oTWkECl3zDZw5Z7Kiw00nnVvwHFCo1H2mYI9MaTRVVCcjwRUJjxAbg/PVrI1ecQjgOS+WFReTJ0YOOeAsUIvCI9q6nyz0X4lAeKbMg+Lwvqx5BNIMN9tnleCasqDvoT9gDZDc1+kQoR1stCMIDSnh4iX/pvazC83aSDiF71UP3GFYScPewh9Bwd2sc/ukmcdRjGWbXZWUpJ3JguomtGZr9DYilVQBNy3bd528Pm6CXEtbIgnt6hgW7Idm4VDm4aLuwROXrRB9Sb0A==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dd8f2718-a002-4726-bd17-08d58db1e291
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2018 15:55:28.6913
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0967
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
index 2d5466a72e40..0b5b499f726a 100644
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
