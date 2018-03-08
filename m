Return-Path: <Alexander.Levin@microsoft.com>
X-Google-Smtp-Source: AG47ELtUwR+NqYntgIQLSxQCho1RyjyLV9uHZ9+KWVFAwpkndabUQH/bvISFboO/sW7j4muVJbPT
ARC-Seal: i=1; a=rsa-sha256; t=1520485026; cv=none;
        d=google.com; s=arc-20160816;
        b=qXI96xc7p+/EQBctihoUulPei1QWxTXlWaZNxmGBBVEQoUexJscd+T9KMsEe7O6K38
         AoZf8BT7OAEhGsqpoGXaRvWmITrlB5YP5r75k3ZRrtMF42qMJTHiEbGzd1Y+nTTXMPvM
         NDvH1IFpv+zOnqvhWma8gOWN3njFjw4UClh2p4V3BI8ldmmSIMcXhzFnTtsVogNqzf0R
         PYf542TgwNp5hHIldwc1GJEksvNBHyPtksMhlMsU3R6cDr2UzYqq7EPyfNBrZ8bhUzBT
         QLYBpSYdoi+yKmew4l3ViQk5Z1tq58Rt4mUin5f5tXxipBj+22yz1PM6EJe5kUdQQIp+
         YG2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:content-transfer-encoding:spamdiagnosticmetadata
         :spamdiagnosticoutput:content-language:accept-language:in-reply-to
         :references:message-id:date:thread-index:thread-topic:subject:cc:to
         :from:dkim-signature:arc-authentication-results;
        bh=A7ZP/x/dtCP8fLrwoEWr7tmDoRHkol//T3wfwHIkgfk=;
        b=04Io4Wl+YJQA4a8kpWqIaZ46EZrpFYR6qJZdPojRR+H0I+u3LYYYBEeJ6qU6HFWozZ
         FUGz/yVIsA450Bj44LOHAwvyN7qeYqgBIKkTNsLLGJBn9LzzkfP9yhV88cUkDlRZcv4x
         1VYwfh/SANRjNYxvXIxu2AOHnRU9Fh/pxOm22PxO7nGAqIr+alnR1wM84KTgH2sbMf8f
         JNgsLwMVzv24dTiCrfaUPhA49Kn2ffKJ0X5BwHijVrIQDpUzd4JhlhmnxPZqg4wL71db
         1XldpdWxfUb6PUb8cId7GRow9UD9u9/D9XjlULIzVfM/KrR+uWnkaDEe1cQe3v16LJ9i
         4ScQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@microsoft.com header.s=selector1 header.b=ZesLrO95;
       spf=pass (google.com: domain of alexander.levin@microsoft.com designates 104.47.33.103 as permitted sender) smtp.mailfrom=Alexander.Levin@microsoft.com;
       dmarc=pass (p=REJECT sp=REJECT dis=NONE) header.from=microsoft.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@microsoft.com header.s=selector1 header.b=ZesLrO95;
       spf=pass (google.com: domain of alexander.levin@microsoft.com designates 104.47.33.103 as permitted sender) smtp.mailfrom=Alexander.Levin@microsoft.com;
       dmarc=pass (p=REJECT sp=REJECT dis=NONE) header.from=microsoft.com
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Kees Cook <keescook@chromium.org>, Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>, Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.15 35/78] /dev/mem: Add bounce buffer for
 copy-out
Thread-Topic: [PATCH AUTOSEL for 4.15 35/78] /dev/mem: Add bounce buffer for
 copy-out
Thread-Index: AQHTtpnKo4jyvrmam0ODCl0vfbR++w==
Date: Thu, 8 Mar 2018 04:56:16 +0000
Message-ID: <20180308045525.7662-35-alexander.levin@microsoft.com>
References: <20180308045525.7662-1-alexander.levin@microsoft.com>
In-Reply-To: <20180308045525.7662-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1079;20:dFJaqT1FGIfzL5LIjSopkERn9JF7OXaCUyjBPCw9YBq5GQHwCM+E0ixbPiK1WRoAomCu+deieOUN93hZGsFln9kRAk1+gasiTkla9aD+7oIBvswiUlNK00l95UKLmSD+WcZscIqVPHZrjhv6/ut0EUHrnwnJZ/Kv2beeZIrurI4=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 1cea0f95-a084-403a-d650-08d584b10908
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1079;
x-ms-traffictypediagnostic: DM5PR2101MB1079:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB10799626B11834DC613BF7D5FBDF0@DM5PR2101MB1079.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(192374486261705)(104084551191319);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(8121501046)(5005006)(3231220)(944501244)(52105095)(93006095)(93001095)(10201501046)(3002001)(6055026)(61426038)(61427038)(6041288)(20161123564045)(20161123560045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(6072148)(201708071742011);SRVR:DM5PR2101MB1079;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1079;
x-forefront-prvs: 060503E79B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(39860400002)(39380400002)(396003)(346002)(366004)(189003)(199004)(36756003)(107886003)(4326008)(97736004)(2906002)(2950100002)(1076002)(6666003)(105586002)(7736002)(186003)(3660700001)(5660300001)(106356001)(305945005)(6512007)(3280700002)(25786009)(14454004)(575784001)(86362001)(86612001)(81156014)(10090500001)(76176011)(26005)(99286004)(66066001)(102836004)(110136005)(81166006)(72206003)(54906003)(5250100002)(478600001)(59450400001)(10290500003)(6116002)(2501003)(8936002)(68736007)(53936002)(6506007)(6486002)(8676002)(6436002)(3846002)(22452003)(316002)(2900100001)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1079;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
x-microsoft-antispam-message-info: UTfORqCKLahkc0AeBvOYu03rVTefti5Y8YwvPbbnSDlNseA9XGKjB3bpTWp3N6OPWTCw/0heCUFt07wfGtGNi1fdg2ZkhLIRkdFkxxz6QxMAdxNQlQLVCmOis1r+sgY+pZvLCpkdPRXl/l5LIAjyS8XB/Ig1FFoL2rs6V6z82bPAictvUXKacpb5WBSFqvIBv+wKRyIoQDuMLd/DKh7ycPJkRaMJcyh+Whjm5PaMhODLlg98H+NTB8ViZqczEZb+bm3BSXTBM8S/497VUtz9D1t37QVIGxouf7q7NaERmOOAI0A85Mvq04z2Gf3Q8fpXu7leCLRK3tywL1kPMRX3lQ==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1cea0f95-a084-403a-d650-08d584b10908
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Mar 2018 04:56:16.9037
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1079
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594344106875288352?=
X-GMAIL-MSGID: =?utf-8?q?1594344106875288352?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Kees Cook <keescook@chromium.org>

[ Upstream commit 22ec1a2aea73b9dfe340dff7945bd85af4cc6280 ]

As done for /proc/kcore in

  commit df04abfd181a ("fs/proc/kcore.c: Add bounce buffer for ktext data")

this adds a bounce buffer when reading memory via /dev/mem. This
is needed to allow kernel text memory to be read out when built with
CONFIG_HARDENED_USERCOPY (which refuses to read out kernel text) and
without CONFIG_STRICT_DEVMEM (which would have refused to read any RAM
contents at all).

Since this build configuration isn't common (most systems with
CONFIG_HARDENED_USERCOPY also have CONFIG_STRICT_DEVMEM), this also tries
to inform Kconfig about the recommended settings.

This patch is modified from Brad Spengler/PaX Team's changes to /dev/mem
code in the last public patch of grsecurity/PaX based on my understanding
of the code. Changes or omissions from the original code are mine and
don't reflect the original grsecurity/PaX code.

Reported-by: Michael Holzheu <holzheu@linux.vnet.ibm.com>
Fixes: f5509cc18daa ("mm: Hardened usercopy")
Signed-off-by: Kees Cook <keescook@chromium.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/char/mem.c | 27 ++++++++++++++++++++++-----
 security/Kconfig   |  1 +
 2 files changed, 23 insertions(+), 5 deletions(-)

diff --git a/drivers/char/mem.c b/drivers/char/mem.c
index 6aefe5370e5b..052011bcf100 100644
--- a/drivers/char/mem.c
+++ b/drivers/char/mem.c
@@ -107,6 +107,8 @@ static ssize_t read_mem(struct file *file, char __user =
*buf,
 	phys_addr_t p =3D *ppos;
 	ssize_t read, sz;
 	void *ptr;
+	char *bounce;
+	int err;
=20
 	if (p !=3D *ppos)
 		return 0;
@@ -129,15 +131,22 @@ static ssize_t read_mem(struct file *file, char __use=
r *buf,
 	}
 #endif
=20
+	bounce =3D kmalloc(PAGE_SIZE, GFP_KERNEL);
+	if (!bounce)
+		return -ENOMEM;
+
 	while (count > 0) {
 		unsigned long remaining;
 		int allowed;
=20
 		sz =3D size_inside_page(p, count);
=20
+		err =3D -EPERM;
 		allowed =3D page_is_allowed(p >> PAGE_SHIFT);
 		if (!allowed)
-			return -EPERM;
+			goto failed;
+
+		err =3D -EFAULT;
 		if (allowed =3D=3D 2) {
 			/* Show zeros for restricted memory. */
 			remaining =3D clear_user(buf, sz);
@@ -149,24 +158,32 @@ static ssize_t read_mem(struct file *file, char __use=
r *buf,
 			 */
 			ptr =3D xlate_dev_mem_ptr(p);
 			if (!ptr)
-				return -EFAULT;
-
-			remaining =3D copy_to_user(buf, ptr, sz);
+				goto failed;
=20
+			err =3D probe_kernel_read(bounce, ptr, sz);
 			unxlate_dev_mem_ptr(p, ptr);
+			if (err)
+				goto failed;
+
+			remaining =3D copy_to_user(buf, bounce, sz);
 		}
=20
 		if (remaining)
-			return -EFAULT;
+			goto failed;
=20
 		buf +=3D sz;
 		p +=3D sz;
 		count -=3D sz;
 		read +=3D sz;
 	}
+	kfree(bounce);
=20
 	*ppos +=3D read;
 	return read;
+
+failed:
+	kfree(bounce);
+	return err;
 }
=20
 static ssize_t write_mem(struct file *file, const char __user *buf,
diff --git a/security/Kconfig b/security/Kconfig
index b0cb9a5f9448..3709db95027f 100644
--- a/security/Kconfig
+++ b/security/Kconfig
@@ -154,6 +154,7 @@ config HARDENED_USERCOPY
 	bool "Harden memory copies between kernel and userspace"
 	depends on HAVE_HARDENED_USERCOPY_ALLOCATOR
 	select BUG
+	imply STRICT_DEVMEM
 	help
 	  This option checks for obviously wrong memory regions when
 	  copying memory to/from the kernel (via copy_to_user() and
--=20
2.14.1
