Return-Path: <Alexander.Levin@microsoft.com>
X-Google-Smtp-Source: AG47ELuhVyKTQBMxb9hdau0syumwie2b0EMpz/labsHMDXzH8JKhc+2ey/1Yfr3MZWKDHXYOdIn3
ARC-Seal: i=1; a=rsa-sha256; t=1520116401; cv=none;
        d=google.com; s=arc-20160816;
        b=TuqiSpxPw66HehVbd2XQLLjnozK6G/oqYYJLAyYvIOGO93MxPBg9N3kZeo8UeNrsCh
         AXazFdFKvCEFHz4G8WBnR+Q+dmqvKBcJB1qiD7NFJwmVcZymkq18r3hstXiOBxuKks2I
         MzjKJ7YBI98o+SGChWYDPK4uZ9ekpJ3aUZIwvtXF5iPGuInoThGdVpkjFT8fLi+/RsDS
         I8vvSvZKZMRSIxyDaBuBl0bIN9/891nM5Zhi2Jli1ebFZ7imTxcCJoWJdTLtjV1YMQhT
         tC2AYuNdQM8TQswnzVMoIIVfFedjuRXi/fAnFiJpkTTwO9BrDSz5QhibMW8A5zl4psQS
         t3dA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:content-transfer-encoding:spamdiagnosticmetadata
         :spamdiagnosticoutput:content-language:accept-language:in-reply-to
         :references:message-id:date:thread-index:thread-topic:subject:cc:to
         :from:dkim-signature:arc-authentication-results;
        bh=BhoYImRqYhFl1eqUobWgtV4n17EJ2erollfwnasFnRU=;
        b=XEbMTm/Z513OxPb4c0+TpDhPwizpI1izbzv97wp3gIUkMzHVa4KuEDD3f/hRRLcasM
         q0IBtKc9CwJw63327h0M0Mqf6VDtZ2xF8rmrjMxCVNQeKdb3d++cCDEBiF1GXwqBRv19
         hkQNJLvBZ2GLPTG3n6Txjj3+yRiBffeCgb9JzQjjR9R15vZigR8Wu+CwfKs41c8N/te5
         dTa/pxxYBJa7hVmE977paHzQaHAsQKV7VfLQhtORg0JwJhkHn6De+kimMVTqdeqtZJR1
         mQ72y7SGAjGnBROWuT7itGffDv6hVO+98yTLcGQ5dj7QKBAGNHZvTaWrkPuGYSVn+rYr
         PPjQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@microsoft.com header.s=selector1 header.b=k2z7KtsW;
       spf=pass (google.com: domain of alexander.levin@microsoft.com designates 104.47.34.119 as permitted sender) smtp.mailfrom=Alexander.Levin@microsoft.com;
       dmarc=pass (p=REJECT sp=REJECT dis=NONE) header.from=microsoft.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@microsoft.com header.s=selector1 header.b=k2z7KtsW;
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
Subject: [PATCH AUTOSEL for 4.9 090/219] braille-console: Fix value returned
 by _braille_console_setup
Thread-Topic: [PATCH AUTOSEL for 4.9 090/219] braille-console: Fix value
 returned by _braille_console_setup
Thread-Index: AQHTsz7/yAj0hhtYFUSRqLs239JmzQ==
Date: Sat, 3 Mar 2018 22:28:48 +0000
Message-ID: <20180303222716.26640-90-alexander.levin@microsoft.com>
References: <20180303222716.26640-1-alexander.levin@microsoft.com>
In-Reply-To: <20180303222716.26640-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MW2PR2101MB1097;7:gbBHCI6rA6R71R6Z75166dGjakK171mijJbwFQOaOTqMC4LBQuvuFAf1OUfC0kjOMCe2qGIc8Z9aE/qZjqnhixLpolEgJH9+ef5TF6PVl8CwpVycwisxC+d7GBDDFxLJmGybBcU2dSMoztY7N0vYDxDMu2gsT0CGJIXvUnvbQclpGNdg28kTbruYojnAtO/Y212UMHO5jsQ1x82+YuBFfM6hA9Ggh5agQX18+oNLQK5Ruv2VUHjvGhOz4bP9kEH0
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 39a0f69e-58d4-4270-3e22-08d58156c42a
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(48565401081)(5600026)(4604075)(3008032)(2017052603307)(7193020);SRVR:MW2PR2101MB1097;
x-ms-traffictypediagnostic: MW2PR2101MB1097:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <MW2PR2101MB109723484C4235DAA9ACB7ECFBC40@MW2PR2101MB1097.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(198206253151910);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(5005006)(8121501046)(10201501046)(3002001)(3231220)(944501244)(52105095)(93006095)(93001095)(6055026)(61426038)(61427038)(6041288)(20161123560045)(20161123558120)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(6072148)(201708071742011);SRVR:MW2PR2101MB1097;BCL:0;PCL:0;RULEID:;SRVR:MW2PR2101MB1097;
x-forefront-prvs: 0600F93FE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(366004)(39380400002)(396003)(39860400002)(346002)(189003)(199004)(305945005)(105586002)(36756003)(3660700001)(86362001)(575784001)(6666003)(66066001)(2900100001)(5660300001)(8676002)(10090500001)(81166006)(81156014)(8936002)(22452003)(10290500003)(2950100002)(4326008)(25786009)(5250100002)(2501003)(68736007)(7736002)(72206003)(14454004)(478600001)(186003)(110136005)(26005)(316002)(2906002)(97736004)(6512007)(99286004)(107886003)(54906003)(1076002)(6506007)(106356001)(53936002)(6116002)(3846002)(102836004)(6486002)(86612001)(3280700002)(6436002)(76176011)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:MW2PR2101MB1097;H:MW2PR2101MB1034.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
x-microsoft-antispam-message-info: tKUZS9dwp3uMyynvsr6jZWGBAORSfsa39Q0jpiutISxs++HQ1eIntB391YD7gUTZ1cbYNpea/VHpLLOqYpLhLhm43qi682EqJiZFtZYz7hAA2WKNHvSv3js9ulWZ0f8hYOkBKHP+gCisElgdh0dya4OmXwTeFT4DbQjCne927gM=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 39a0f69e-58d4-4270-3e22-08d58156c42a
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2018 22:28:48.1038
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB1097
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593957576003422792?=
X-GMAIL-MSGID: =?utf-8?q?1593957576003422792?=
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
