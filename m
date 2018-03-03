Return-Path: <Alexander.Levin@microsoft.com>
X-Google-Smtp-Source: AG47ELuYyOMEL6JsnkbG5gK3f4ByIqevWcwYxe/EW0peCi5/F+aWyeHMg46i49A1DEAod1viyVPf
ARC-Seal: i=1; a=rsa-sha256; t=1520116501; cv=none;
        d=google.com; s=arc-20160816;
        b=olgxb8Nt1cgOoYSKGn0YHdLSsFYKij2l0P2gj5vLLsMJdq8vtNhKFXXwd1qlsQeiD2
         SZPvalZ1P1yZPxt/IivetqfGMPwwYjlayoN1vpunbwRZmlvMzpkE0EjGgLZydI6DtuJs
         s5k6HGJbnw7vADY2bgSIEitZGzwS827/t1FnEFUTUdcAkLo/g766wAc4hXrPf6rZFBYJ
         3viXV6GE2ZoHcgkFLnnWQpPILJzJBotsW91zscC6SQsyFJ01vdjYjKlCU77Lp9ITuswg
         pfy4ZwgEYwUv9QB3k5eLc1PdZ2kjY2oGLsut/UNhC0N0kMWh8/YBZfkEJcjlYjRjkA/y
         MjOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:content-transfer-encoding:content-language
         :accept-language:in-reply-to:references:message-id:date:thread-index
         :thread-topic:subject:cc:to:from:dkim-signature
         :arc-authentication-results;
        bh=XJU/E32zlocmkdVhzkk94pZPQnVtlkr93X7XwpfNpKQ=;
        b=GAns788yvRC7VEcfwRFqW3E/rK5QStD1U8/Npczvg35QvwtfxMBJLhnrJLf1jWMMDi
         AjviI4FqjRhGIZLBZDwehnX+tdllYYSCfMsZMKUyJofN3JofscefgMDIk4ewEbtCxlO+
         rR03F7dN4baMKoVnortboe6sjaZcm+B214iyn0Yr0zMa5WsCethUJCwlsypmteY6bzrb
         0mo1i7fjAbLqavk6jDNC/Em+BeFecDWq1JqF+GQmHerLSMEFi2GRneE3pU4YHzCXFEuF
         Cu+HSFPKciCCSxsJHMZcfRMUBIziZ4s+s6fw2IxbyCBntU9OuuH8kmcTQm5QFA/ZXOKY
         IBHg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@microsoft.com header.s=selector1 header.b=XKrMMK7p;
       spf=pass (google.com: domain of alexander.levin@microsoft.com designates 104.47.36.115 as permitted sender) smtp.mailfrom=Alexander.Levin@microsoft.com;
       dmarc=pass (p=REJECT sp=REJECT dis=NONE) header.from=microsoft.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@microsoft.com header.s=selector1 header.b=XKrMMK7p;
       spf=pass (google.com: domain of alexander.levin@microsoft.com designates 104.47.36.115 as permitted sender) smtp.mailfrom=Alexander.Levin@microsoft.com;
       dmarc=pass (p=REJECT sp=REJECT dis=NONE) header.from=microsoft.com
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>, Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 133/219] lkdtm: turn off kcov for
 lkdtm_rodata_do_nothing:
Thread-Topic: [PATCH AUTOSEL for 4.9 133/219] lkdtm: turn off kcov for
 lkdtm_rodata_do_nothing:
Thread-Index: AQHTsz8OcZTSQPHXtUGh5S7jhkIfwQ==
Date: Sat, 3 Mar 2018 22:29:13 +0000
Message-ID: <20180303222716.26640-133-alexander.levin@microsoft.com>
References: <20180303222716.26640-1-alexander.levin@microsoft.com>
In-Reply-To: <20180303222716.26640-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MW2PR2101MB0924;6:du//MVzszYj8MmJgauwkJV655YJyWZNrt7GmO8UNpDyy2Eydk2VYam5mf68L0MtxbrtK9mfBW5GkHQXxalD8cceJYMAPAaKKEqZm2RMH51yv3fYwR0/hnMoO71SeWW3e+XXGPkjlFc5eHzBgFg59R7flaic1y7vtCDau2wUhFIgq4VFHOB0WmB0N0s/RrXNU3Az3JnhpsDvHuxoMzMl8Aj1E8VqcxzAk+sqjDiCtkhhUtObrP2x81XkKPHXl89xcSG1O2XZUkNlI6D6tihe9KspC8aJns6ygOk8v9aAc9+pbsOW/eJq0Id4HH13VBFVNDKFTSyGRvKlyzLVkNDWtpzYT8Sv9hTtKnlXVS4k7snU=;5:87lWZLx9r1othLQiH4YyWshJShsQyLXKJpCQl6yxFYbTMnGsNUYPOaetK5nklDeo0/6U4bWDUbCTiayRGVNLSEUIqaG5yTemBprh9r/ao+gVyXDfQs9wyj+RBAIbU4QxBsS8r4vhlgdGV+zkD2B/H4kw1iHjzl8NHB6mfRS+pus=;24:p5i8/HQw+b3gfAFyh/abzQK3dLrb9coO0gQSqFH936dLQ3teqREyL4KGLpyxeV2/TH20jQRprcqIuejUpglQ4wp4FLAKXi+rnCP5SiNXGBQ=;7:viRB9yx0d5IrxCeU8fOIx4g/Pn12/0txMK8B5ACHfB0vzoMsKThCqpYtklp5d4bHkR3W2+T9M7F91GFYbKo9BfC6LDzP54pRkJPajjZsHBpC4j6UOHeSH8zglrNSNwqvDKqcyi3V151rBQYlXhAivUQpv99hTKyKeogk9nGPogrN4Ze+2bIoBogENNUUZ3e4FWIGBDV7yj72hc9cL9I+xw5uZcCzqXciphrl1Z1zbumZWenxyzWjaZJWergaugt0
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 211e2953-e4a6-4acc-effb-08d58156fa6c
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603307)(7193020);SRVR:MW2PR2101MB0924;
x-ms-traffictypediagnostic: MW2PR2101MB0924:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <MW2PR2101MB09244382FD61D39156DE9A42FBC40@MW2PR2101MB0924.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(211936372134217)(153496737603132);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3231220)(944501244)(52105095)(3002001)(6055026)(61426038)(61427038)(6041288)(20161123562045)(20161123558120)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:MW2PR2101MB0924;BCL:0;PCL:0;RULEID:;SRVR:MW2PR2101MB0924;
x-forefront-prvs: 0600F93FE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(376002)(39860400002)(396003)(366004)(39380400002)(189003)(199004)(102836004)(2950100002)(10090500001)(6666003)(316002)(26005)(186003)(25786009)(2900100001)(2906002)(54906003)(22452003)(110136005)(97736004)(6506007)(59450400001)(7736002)(4326008)(305945005)(5250100002)(86362001)(2501003)(99286004)(68736007)(72206003)(53936002)(6436002)(6116002)(3846002)(5660300001)(66066001)(1076002)(76176011)(14454004)(36756003)(3660700001)(6486002)(86612001)(81156014)(8676002)(81166006)(10290500003)(6512007)(8936002)(3280700002)(478600001)(107886003)(106356001)(105586002)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:MW2PR2101MB0924;H:MW2PR2101MB1034.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 211e2953-e4a6-4acc-effb-08d58156fa6c
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2018 22:29:13.4319
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB0924
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593957680878502984?=
X-GMAIL-MSGID: =?utf-8?q?1593957680878502984?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Arnd Bergmann <arnd@arndb.de>

[ Upstream commit 7064dc7fc13b2994d33ae540ffb7a3a05ac463bf ]

I ran into a link error on ARM64 for lkdtm_rodata_do_nothing:

drivers/misc/built-in.o: In function `lkdtm_rodata_do_nothing':
:(.rodata+0x68c8): relocation truncated to fit: R_AARCH64_CALL26 against sy=
mbol `__sanitizer_cov_trace_pc' defined in .text section in kernel/built-in=
.o

I did not analyze this further, but my theory is that we would need a tramp=
oline
to call __sanitizer_cov_trace_pc(), but the linker (correctly) only adds tr=
ampolines
for callers in executable sections.

Disabling KCOV for this one file avoids the build failure with no
other practical downsides I can think of.

The problem can only happen on kernels that contain both kcov and
lkdtm, so if we want to backport this, it should be in the earliest
version that has both (v4.8).

Fixes: 5c9a8750a640 ("kernel: add kcov code coverage")
Fixes: 9a49a528dcf3 ("lkdtm: add function for testing .rodata section")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Acked-by: Dmitry Vyukov <dvyukov@google.com>
Acked-by: Kees Cook <keescook@chromium.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/misc/Makefile | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/misc/Makefile b/drivers/misc/Makefile
index 31983366090a..2bf79ba4a39e 100644
--- a/drivers/misc/Makefile
+++ b/drivers/misc/Makefile
@@ -61,6 +61,8 @@ lkdtm-$(CONFIG_LKDTM)		+=3D lkdtm_perms.o
 lkdtm-$(CONFIG_LKDTM)		+=3D lkdtm_rodata_objcopy.o
 lkdtm-$(CONFIG_LKDTM)		+=3D lkdtm_usercopy.o
=20
+KCOV_INSTRUMENT_lkdtm_rodata.o	:=3D n
+
 OBJCOPYFLAGS :=3D
 OBJCOPYFLAGS_lkdtm_rodata_objcopy.o :=3D \
 			--set-section-flags .text=3Dalloc,readonly \
--=20
2.14.1
