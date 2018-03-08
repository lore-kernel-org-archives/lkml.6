Return-Path: <Alexander.Levin@microsoft.com>
X-Google-Smtp-Source: AG47ELsoHLW+PgYZs9I2BOdryWFNJ1p+PybVvR2+q7OEXNqSxa/VppnedjURuctJqidnFgSpg9AW
ARC-Seal: i=1; a=rsa-sha256; t=1520485104; cv=none;
        d=google.com; s=arc-20160816;
        b=SUZe9A4CItM/iw43GrrFhqxBqVdssgGRmlrtljG9jsZJnbnt52Lb7d+xc8M5z3B7aV
         64Ds//i8zN13sTZ65w3loil4Jo2+2xyAvfwc3jUEELjf+Q6CQp/Nh3kNeZgc9P7BQPQD
         rxQREVMR0WgU5TOAGDVtxMDdHCQgzX8orR7Yr63NX8DlTvF/1A4Eg8BpbOg/rY6maOag
         XaBsRloZnsJKM/ZW1DglxdkoE/FJlvWIbPKlkTafMFZgFN1FhpYbXCFK4eedMHV8hFyj
         CmBlozSbbIQtFgATn9+Ef/v23EYUR7EbQ/qNFPduGbDEAI6OK+c4PyQx68ItnAMXUWXk
         t98A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:content-transfer-encoding:spamdiagnosticmetadata
         :spamdiagnosticoutput:content-language:accept-language:in-reply-to
         :references:message-id:date:thread-index:thread-topic:subject:cc:to
         :from:dkim-signature:arc-authentication-results;
        bh=2XdQnpZe3yIpXDGeVY6g4s0pKgUP+KAmsyrl5xQYAcs=;
        b=bZyRYcgqG66Jm0y3d4btSqJ82Qibu0+RkN9619Cj5Hqdy03TGiiozfcwKtjtYp1hZy
         UM/uT9QcHFGBbE9fkWF1fP1pMD2nTtFZraBgwTsP/5cTXMJL7BagcJWlV4qbEw+AhtKv
         1gGg6P6j+IjeIj3tWGaOoYtuwQMRHXgtcRCk+ugoeBWaCLDAJNNbzweoKQWJYNTIm6Jt
         zDD2w6cVfpQ6NKrPCK39UfAHM4vi2yH8tSEEjvnuFdx3l9hC9PnEjh46d+fGO+5tH4M8
         eBYtzoWZwe58ToKrlVPYdoDJSPXllxZROMmwN/RVb39/oraah3I4ZtQOdrMbTOKROG4o
         HtpQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@microsoft.com header.s=selector1 header.b=iGNGSmOB;
       spf=pass (google.com: domain of alexander.levin@microsoft.com designates 104.47.41.117 as permitted sender) smtp.mailfrom=Alexander.Levin@microsoft.com;
       dmarc=pass (p=REJECT sp=REJECT dis=NONE) header.from=microsoft.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@microsoft.com header.s=selector1 header.b=iGNGSmOB;
       spf=pass (google.com: domain of alexander.levin@microsoft.com designates 104.47.41.117 as permitted sender) smtp.mailfrom=Alexander.Levin@microsoft.com;
       dmarc=pass (p=REJECT sp=REJECT dis=NONE) header.from=microsoft.com
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Kees Cook <keescook@chromium.org>, Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>, Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.14 30/67] /dev/mem: Add bounce buffer for
 copy-out
Thread-Topic: [PATCH AUTOSEL for 4.14 30/67] /dev/mem: Add bounce buffer for
 copy-out
Thread-Index: AQHTtpn+M4lycXwz4U6ejCg7vjTWag==
Date: Thu, 8 Mar 2018 04:57:44 +0000
Message-ID: <20180308045641.7814-30-alexander.levin@microsoft.com>
References: <20180308045641.7814-1-alexander.levin@microsoft.com>
In-Reply-To: <20180308045641.7814-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0808;20:8T+6X2pc0X6Am5XacTYZR1wcYKw3xl2x76b4X4YSriPnjKDwgueZHA6LZOWG45yFQeFz+H21U0ByNk2vcT3ql/kKZr3DNq38C916FeqhzCE2AXyN4xSOG+Vrd1MpCV5/lPunt5YIkTFJfzam+ArS65EygFVlwjasjR150dSddE4=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 464ebb8b-fcc2-487c-92a9-08d584b1364f
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0808;
x-ms-traffictypediagnostic: DM5PR2101MB0808:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB0808D206DD0B02AA87D9E880FBDF0@DM5PR2101MB0808.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(192374486261705)(104084551191319);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231220)(944501244)(52105095)(10201501046)(3002001)(6055026)(61426038)(61427038)(6041288)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123560045)(20161123562045)(20161123558120)(6072148)(201708071742011);SRVR:DM5PR2101MB0808;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0808;
x-forefront-prvs: 060503E79B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39380400002)(396003)(39860400002)(366004)(376002)(346002)(199004)(189003)(22452003)(99286004)(76176011)(2906002)(105586002)(3846002)(86612001)(478600001)(72206003)(14454004)(2900100001)(8676002)(102836004)(68736007)(5660300001)(316002)(6116002)(54906003)(26005)(6506007)(575784001)(59450400001)(1076002)(86362001)(36756003)(186003)(10090500001)(110136005)(106356001)(4326008)(6512007)(6486002)(7736002)(5250100002)(3280700002)(3660700001)(2501003)(6666003)(81166006)(2950100002)(305945005)(53936002)(107886003)(8936002)(6436002)(81156014)(66066001)(25786009)(10290500003)(97736004)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0808;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
x-microsoft-antispam-message-info: MiIR6mS/H/kwBYzsNxKSAhOqI+JWLLJqPkvhvYvPwTX48dgOUTbLUM3lw04VWkwe+xEYL5wSYjOmWC8tnGPXQZJQIhD8aC1DuXjJtFpyjp6k3OEpBaZSazhffUGVDiGjc5pTjv9hlNZj5fXOlTPQTrMsUzgoO+9fOVBV/67iArqBv9JqMv0U/iCMFbOriADp9RlqR18YvPZ1lOUB3N45E9UirGv10vcJoLwyf64ETqdOpk5T9TBvO8CoESsQhrO4zsymkx31G5a02wo1S1Xm643C+mMvBPm2Pyuu8A7odz9f7JMKrsHR4O/vvNS+/KhRhHsqLDylZqa+wq+R4VabZw==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 464ebb8b-fcc2-487c-92a9-08d584b1364f
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Mar 2018 04:57:44.7020
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0808
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594344106875288352?=
X-GMAIL-MSGID: =?utf-8?q?1594344188969557609?=
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
index 970e1242a282..3a70dba2c645 100644
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
index b5c2b5d0c6c0..87f2a6f842fd 100644
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
