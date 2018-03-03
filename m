Return-Path: <Alexander.Levin@microsoft.com>
X-Google-Smtp-Source: AG47ELtL0Pue9P0KoVbM4vW/F3D0LbxIqwR/blTWMqnfhH5K5EeR4FffzWqsKwrOkZqx6nGMzEq4
ARC-Seal: i=1; a=rsa-sha256; t=1520116749; cv=none;
        d=google.com; s=arc-20160816;
        b=MIw/6yxrhwrG+sN1fIDkaV5xH90xA7lcGjqAmdyjhH5VO/mWBzsCUFRIktPRz2cSyh
         ikm9UBgAEyBSwBkzXyKDj8FUk1OASesybWsqcbDXENNVRijl9ZbPXot1uSdDHM/g8rH7
         2YkhaB7ZEKcZTQKzZoRDHxvFb+g7dvXq7ioW2k4FwBWK79sHQ3HuvaaerT85lHyv8obF
         jw4l/OqmMBHUGN1NKiNUH+dnhxEE6U9fbTgCsSOSs8edjkmX+FYzJD/rBttWepoFk2EO
         jV1IBL4tlLr2oPIA3FWKE6NpcyXP7eukvdCpEMyY+Cx52mBhZnsPOO1es+2safXbRjyn
         VzAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:content-transfer-encoding:spamdiagnosticmetadata
         :spamdiagnosticoutput:content-language:accept-language:in-reply-to
         :references:message-id:date:thread-index:thread-topic:subject:cc:to
         :from:dkim-signature:arc-authentication-results;
        bh=BhoYImRqYhFl1eqUobWgtV4n17EJ2erollfwnasFnRU=;
        b=Ad1n9ugI5oymQH+Xy4iUZihdB3B+4APYVanYxUvWvCF+RRNXLsM+fqcD4NIHYIqYTP
         fVSiK7w5oCMUWMCSwKvYoNFGLA9C8nUhZicPq2C0aneZKN0zkPBJkA2USVjwIsa1KwQZ
         FPfeERaDyfTTaWOt7l7cTI2Y3J2nJedaMmKsPUfgVIcAin0RaXiudqIoc5WTwHHrBIPt
         XO+4lfR9QJgOm5pRYMulYlI1Y9Qy+//WkQ5tV8bn7NnYV7mnqpkh/uJEgtNCgzY3QTWi
         IP3uWxbDppnuCSrhTcICQGa3L/I6IFCUV4L6yPBjB+SPboP1vwibSSPbVG/Gq/hTx/mS
         0w/A==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@microsoft.com header.s=selector1 header.b=F9BrTWH+;
       spf=pass (google.com: domain of alexander.levin@microsoft.com designates 104.47.34.119 as permitted sender) smtp.mailfrom=Alexander.Levin@microsoft.com;
       dmarc=pass (p=REJECT sp=REJECT dis=NONE) header.from=microsoft.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@microsoft.com header.s=selector1 header.b=F9BrTWH+;
       spf=pass (google.com: domain of alexander.levin@microsoft.com designates 104.47.34.119 as permitted sender) smtp.mailfrom=Alexander.Levin@microsoft.com;
       dmarc=pass (p=REJECT sp=REJECT dis=NONE) header.from=microsoft.com
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Samuel Thibault <samuel.thibault@ens-lyon.org>, Aleksey Makarov
	<aleksey.makarov@linaro.org>, Joe Perches <joe@perches.com>, Ming Lei
	<ming.lei@canonical.com>, Steven Rostedt <rostedt@goodmis.org>, Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>, Sasha Levin
	<Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.4 043/115] braille-console: Fix value returned
 by _braille_console_setup
Thread-Topic: [PATCH AUTOSEL for 4.4 043/115] braille-console: Fix value
 returned by _braille_console_setup
Thread-Index: AQHTsz9We8lZVv3QlkSHplGqUNnDWw==
Date: Sat, 3 Mar 2018 22:31:14 +0000
Message-ID: <20180303223010.27106-43-alexander.levin@microsoft.com>
References: <20180303223010.27106-1-alexander.levin@microsoft.com>
In-Reply-To: <20180303223010.27106-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MW2PR2101MB0938;7:RvcZa/EHJjKV6dRlzURtdlzpPYfZGyhAMm2kLYWlRqEaxRIFyxOus4eUhssNkwDxRifZl/Ux6jWJMnffhXYY5X08PU/JMFntQWZnYkjeMxZ2Ixpr5MEL3YrJpL0HyhWpuTb4o15aQ/a0JDKmpZVFmICJmapPsEFhL4QvrreecqYgskpSRUhgPmKeAwhm++9DbKov2D60uj9Ps/eMnlh3vry7/cxpRQ9Ofp/Eq9Qjp443Ry76Ksv4CDIW4mtDjj9A
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: fede722d-f827-4df7-fa2f-08d581579359
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(48565401081)(5600026)(4604075)(3008032)(2017052603307)(7193020);SRVR:MW2PR2101MB0938;
x-ms-traffictypediagnostic: MW2PR2101MB0938:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <MW2PR2101MB0938FB5B830998460222D3CBFBC40@MW2PR2101MB0938.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(198206253151910);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(5005006)(8121501046)(93006095)(93001095)(3002001)(10201501046)(3231220)(944501244)(6055026)(61426038)(61427038)(6041288)(20161123558120)(20161123564045)(20161123560045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:MW2PR2101MB0938;BCL:0;PCL:0;RULEID:;SRVR:MW2PR2101MB0938;
x-forefront-prvs: 0600F93FE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39380400002)(39860400002)(366004)(396003)(346002)(376002)(199004)(189003)(54906003)(4326008)(72206003)(22452003)(478600001)(25786009)(66066001)(6436002)(6512007)(14454004)(53936002)(2906002)(6486002)(105586002)(99286004)(10290500003)(3846002)(106356001)(6116002)(305945005)(5660300001)(110136005)(1076002)(36756003)(316002)(2900100001)(2501003)(5250100002)(10090500001)(102836004)(68736007)(2950100002)(26005)(97736004)(186003)(6506007)(8676002)(107886003)(3660700001)(6666003)(7736002)(575784001)(86362001)(81166006)(86612001)(81156014)(76176011)(8936002)(3280700002)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:MW2PR2101MB0938;H:MW2PR2101MB1034.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
x-microsoft-antispam-message-info: gtCzAqFM8+TlCcNO+LQ0KsVaNNcCCZFpv++rpFG8p7jY57aYRn9guBu76bsHUH4I66yewGHEdk0sufghGyCYRy1h5fEknvdgGIyqxC3NngCDBcynX4CKAJ8Cx+mXysxfnKa2bFh55mKbd+H7apQQ2bGe3UVf18g/3px07tNncQ4=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fede722d-f827-4df7-fa2f-08d581579359
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2018 22:31:14.0571
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB0938
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593957576003422792?=
X-GMAIL-MSGID: =?utf-8?q?1593957940967123203?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Samuel Thibault <samuel.thibault@ens-lyon.org>

[ Upstream commit 2ed2b8621be2708c0f6d61fe9841e9ad8b9753f0 ]

commit bbeddf52adc1 ("printk: move braille console support into
separate braille.[ch] files") introduced _braille_console_setup()
to outline the braille initialization code.  There was however some
confusion over the value it was supposed to return. commit 2cfe6c4ac7ee
("printk: Fix return of braille_register_console()") tried to fix it
but failed to.

This fixes and documents the returned value according to the use
in printk.c: non-zero return means a parsing error, and thus this
console configuration should be ignored.

Signed-off-by: Samuel Thibault <samuel.thibault@ens-lyon.org>
Cc: Aleksey Makarov <aleksey.makarov@linaro.org>
Cc: Joe Perches <joe@perches.com>
Cc: Ming Lei <ming.lei@canonical.com>
Cc: Steven Rostedt <rostedt@goodmis.org>
Acked-by: Petr Mladek <pmladek@suse.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 kernel/printk/braille.c | 15 ++++++++-------
 kernel/printk/braille.h | 13 ++++++++++---
 2 files changed, 18 insertions(+), 10 deletions(-)

diff --git a/kernel/printk/braille.c b/kernel/printk/braille.c
index d5760c42f042..61d41ca41844 100644
--- a/kernel/printk/braille.c
+++ b/kernel/printk/braille.c
@@ -2,12 +2,13 @@
=20
 #include <linux/kernel.h>
 #include <linux/console.h>
+#include <linux/errno.h>
 #include <linux/string.h>
=20
 #include "console_cmdline.h"
 #include "braille.h"
=20
-char *_braille_console_setup(char **str, char **brl_options)
+int _braille_console_setup(char **str, char **brl_options)
 {
 	if (!strncmp(*str, "brl,", 4)) {
 		*brl_options =3D "";
@@ -15,14 +16,14 @@ char *_braille_console_setup(char **str, char **brl_opt=
ions)
 	} else if (!strncmp(*str, "brl=3D", 4)) {
 		*brl_options =3D *str + 4;
 		*str =3D strchr(*brl_options, ',');
-		if (!*str)
+		if (!*str) {
 			pr_err("need port name after brl=3D\n");
-		else
-			*((*str)++) =3D 0;
-	} else
-		return NULL;
+			return -EINVAL;
+		}
+		*((*str)++) =3D 0;
+	}
=20
-	return *str;
+	return 0;
 }
=20
 int
diff --git a/kernel/printk/braille.h b/kernel/printk/braille.h
index 769d771145c8..749a6756843a 100644
--- a/kernel/printk/braille.h
+++ b/kernel/printk/braille.h
@@ -9,7 +9,14 @@ braille_set_options(struct console_cmdline *c, char *brl_o=
ptions)
 	c->brl_options =3D brl_options;
 }
=20
-char *
+/*
+ * Setup console according to braille options.
+ * Return -EINVAL on syntax error, 0 on success (or no braille option was
+ * actually given).
+ * Modifies str to point to the serial options
+ * Sets brl_options to the parsed braille options.
+ */
+int
 _braille_console_setup(char **str, char **brl_options);
=20
 int
@@ -25,10 +32,10 @@ braille_set_options(struct console_cmdline *c, char *br=
l_options)
 {
 }
=20
-static inline char *
+static inline int
 _braille_console_setup(char **str, char **brl_options)
 {
-	return NULL;
+	return 0;
 }
=20
 static inline int
--=20
2.14.1
