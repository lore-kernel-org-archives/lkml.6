Return-Path: <Alexander.Levin@microsoft.com>
X-Google-Smtp-Source: AG47ELsqyAYGVwnzXxoZnqR9FqVKQ2n4YfuiREegy2V5K+3ZJOtNnhBhKZwqAQOHUr/SPweN+GU7
ARC-Seal: i=1; a=rsa-sha256; t=1520116871; cv=none;
        d=google.com; s=arc-20160816;
        b=LEHIM1CH34H4KuDMY/OuNgtK6/ea5t2y7ExIyY4D779bWAEr33ae731rv/kKrAhGjX
         RmVp6baCsRN60mqAH4DQ9TNWS8dyQ4NtTNxZ5fZ3/2leWTdOFnw93U0Hr/Bl+Nwwet3b
         ZSt5M64+Te69NGqmS8F/DVO87P/s9PgZCBsSRvS0KCsosQ8WKZKi7HTSaUJrfEmblz06
         CSDKHqaMULo0FvDALm5S4J4+a0kWG4QwIwAyrzLDnHhYuE9w9UCnZB41qWzudXBS+LvZ
         OVkg+5XID49/0KHHgmgcjEKykrAMnfOh02PIU9SuP3a6D/Hz2TdSAWdibTbQ+qTXOL7m
         7ykw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:content-transfer-encoding:spamdiagnosticmetadata
         :spamdiagnosticoutput:content-language:accept-language:in-reply-to
         :references:message-id:date:thread-index:thread-topic:subject:cc:to
         :from:dkim-signature:arc-authentication-results;
        bh=fIIUz1NYq4r6NyQcJovNm1m/2j1Ph9eRdXIXe/s0Fjk=;
        b=vzlzkSOTdiLZs+azFA5uMbz6WHCSr75d2pikzXzTKOfZ9VKKDzX/RsFAumndCiaW6r
         OguPeKxJTwABKVr1nAIZuBdNQ9hWXzm443sKhmZTB7Y9UIcWZoQoiAd+SuQMYz1oTxA5
         G9XyLCIX9wchJAMEzeSe5GAKa2l1OuOkZXi0Y3fSCv+HzTKls0a4e8x/BJ1VrgBSn2Rz
         SF6nRPHcC3ZN+bEKZqVyHLHyQQVLXc3zxFs1lJZD/ee6FZtepjuS2hvIhjaz/ZrZnxQq
         IDOf9aKGAvqMS6OUnKMFWWOqR8jfJ9F0erQim+bwMeRKH29bWIHukJNoYeQfBVf8Kekw
         o7qg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@microsoft.com header.s=selector1 header.b=X2bhWOjQ;
       spf=pass (google.com: domain of alexander.levin@microsoft.com designates 104.47.38.91 as permitted sender) smtp.mailfrom=Alexander.Levin@microsoft.com;
       dmarc=pass (p=REJECT sp=REJECT dis=NONE) header.from=microsoft.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@microsoft.com header.s=selector1 header.b=X2bhWOjQ;
       spf=pass (google.com: domain of alexander.levin@microsoft.com designates 104.47.38.91 as permitted sender) smtp.mailfrom=Alexander.Levin@microsoft.com;
       dmarc=pass (p=REJECT sp=REJECT dis=NONE) header.from=microsoft.com
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Samuel Thibault <samuel.thibault@ens-lyon.org>, Aleksey Makarov
	<aleksey.makarov@linaro.org>, Joe Perches <joe@perches.com>, Ming Lei
	<ming.lei@canonical.com>, Steven Rostedt <rostedt@goodmis.org>, Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>, Sasha Levin
	<Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 3.18 25/63] braille-console: Fix value returned by
 _braille_console_setup
Thread-Topic: [PATCH AUTOSEL for 3.18 25/63] braille-console: Fix value
 returned by _braille_console_setup
Thread-Index: AQHTsz+kv5QPdoNVDUuCoyUn8eB9lA==
Date: Sat, 3 Mar 2018 22:33:24 +0000
Message-ID: <20180303223228.27323-25-alexander.levin@microsoft.com>
References: <20180303223228.27323-1-alexander.levin@microsoft.com>
In-Reply-To: <20180303223228.27323-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MW2PR2101MB0940;7:bnwMEjOQ8LpgfL+BNuSB0xOw+tEUnkh7NdbanIcMMWALXey3i5a8L+HLKYMrr09+c/A9WEP6rj7/XB/GBOWdrPlpZ9zuv6k5S387duQ9gaSzsRZLnWEFw9RwZzbLottOgP0w+tjXMeEz1pvfBA7YmHfErgphyj7GX0+g6/mOAqCqqIrPrB+MyqVIGFPuEboZI6c4vA0Db+9c9nveIxZHwhdLHABSPLFUEZZxrrKT8IC8vWAilyhbzjFlhhoUzErZ
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 0e1c5160-936a-4163-fa0d-08d58157db4b
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603307)(7193020);SRVR:MW2PR2101MB0940;
x-ms-traffictypediagnostic: MW2PR2101MB0940:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <MW2PR2101MB0940A84D9E4E211DCABA03DEFBC40@MW2PR2101MB0940.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(198206253151910);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(5005006)(8121501046)(93006095)(93001095)(3002001)(10201501046)(3231220)(944501244)(52105095)(6055026)(61426038)(61427038)(6041288)(20161123558120)(20161123564045)(20161123560045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:MW2PR2101MB0940;BCL:0;PCL:0;RULEID:;SRVR:MW2PR2101MB0940;
x-forefront-prvs: 0600F93FE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(39380400002)(346002)(366004)(39860400002)(396003)(199004)(189003)(106356001)(68736007)(6486002)(25786009)(22452003)(6436002)(186003)(2906002)(81156014)(81166006)(10090500001)(66066001)(8676002)(36756003)(6512007)(2900100001)(316002)(97736004)(102836004)(53936002)(6506007)(3280700002)(26005)(4326008)(5250100002)(305945005)(2501003)(76176011)(2950100002)(86362001)(99286004)(3846002)(72206003)(14454004)(3660700001)(478600001)(1076002)(5660300001)(10290500003)(6666003)(6116002)(7736002)(86612001)(107886003)(110136005)(54906003)(105586002)(8936002)(575784001)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:MW2PR2101MB0940;H:MW2PR2101MB1034.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
x-microsoft-antispam-message-info: 80URDTFrcyxJQDb722hTkmRJxXqgGZty+26yDm1U1BYtBpbITBB6WeHP1snPmOn0EH8rZT8DawXd173GWZ1BPekI3wvzp9dnWlBy+IO2SC3JlQIVVm3Tdr3FPSYSO/FxAqxsNniea18eOFOWLRfhB5bVOxgvgIHwHlDvjrPr4Qk=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e1c5160-936a-4163-fa0d-08d58157db4b
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2018 22:33:24.9036
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB0940
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593957576003422792?=
X-GMAIL-MSGID: =?utf-8?q?1593958068504388615?=
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
index 276762f3a460..e035876af5e2 100644
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
 	if (!memcmp(*str, "brl,", 4)) {
 		*brl_options =3D "";
@@ -15,14 +16,14 @@ char *_braille_console_setup(char **str, char **brl_opt=
ions)
 	} else if (!memcmp(str, "brl=3D", 4)) {
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
