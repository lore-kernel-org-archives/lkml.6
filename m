Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71954C64EB0
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 00:39:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F2A72083C
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 00:39:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="bMS2dV43"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2F2A72083C
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729434AbeJAHOu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Oct 2018 03:14:50 -0400
Received: from mail-by2nam03on0120.outbound.protection.outlook.com ([104.47.42.120]:46043
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729415AbeJAHOu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Oct 2018 03:14:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FOb0YCdDEteUP25g/NhVJslHSVPgh9T8M9QOqldpAXw=;
 b=bMS2dV43+nvfw7pLocE4Z8iDbVPkLEHZmXEEfrP1KA9qfaV6xnBqDeme0VYTbO28qgqwlKq0fMb4KmEANRUKJ3BM0czW5wBrZigFfnboL/qlxqlfVM/W4ci3V0SsRlVa9fUUtXPZwioJts7rIOQWe4raaimSVxcpSY+oFxBapCI=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0696.namprd21.prod.outlook.com (10.175.121.150) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1228.6; Mon, 1 Oct 2018 00:39:37 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1228.006; Mon, 1 Oct 2018
 00:39:37 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Randy Dunlap <rdunlap@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jiri Kosina <jikos@kernel.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.18 65/65] x86/APM: Fix build warning when PROC_FS is
 not enabled
Thread-Topic: [PATCH AUTOSEL 4.18 65/65] x86/APM: Fix build warning when
 PROC_FS is not enabled
Thread-Index: AQHUWR8aXMfeshifkE6PlImrGGYcug==
Date:   Mon, 1 Oct 2018 00:38:43 +0000
Message-ID: <20181001003754.146961-65-alexander.levin@microsoft.com>
References: <20181001003754.146961-1-alexander.levin@microsoft.com>
In-Reply-To: <20181001003754.146961-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0696;6:ceSFIEZRld96ug5RoAzHWRTwbUzv6L3aaDVg7d/iH0bdVFejkGMsJXu8+DTMds+e0KdFFV9N18Ks/UwGXvaL8enrYm/5/CiqpfyFzTDNwIFVaaliMwXAoas9VssmPr4llxCxL0GMQLO0Nf7B47QxJVbm5Z2LBdu2iqu7wYZv8svHRtrzFWHXN+T//UGhRo2LSYcovlZPgyow0Vg9ifUfb1jh/jau11aga7QBvpD7nqO81/E1civeGAtiUSeraS5wcnV37CLb9X/BlvoSs2SwWegVg9vUEOPZV02TtCVy8tmAyHi+yey/OU/9d6iJuSttN7KsyPbFegwLiHFa+M9sCL8/pTfzMU9HtNqWz8d4EwmQQ1+XbSs0JNVDRvCZoZkhqGPFZPa0mmq42f1vCY+tYhEqwNRKQOvgKftA5A2tyj9IW4codvrcU4FLuktJvEgVSZnTW757SDGZYjdrEcKxDg==;5:Sqj3AXAl5ezkBTUDuTmbtzQ0xP4V6Lsy2lPwYIAbBHcREwO22j1IDDkg0tQfG97E9Fiwt8nrxQBVt4CFZ6lb3Fg5lQrPjEa8VyDpFtD2SxVykfJrwJdQF7z4UXLb3+7zsWBZspF4QppvlNIwwSa/udRKvTlnYDkeoW/Kza7NUuE=;7:WXctBYuhdDAr10r+gBcAyhDlV8W/RJ8Azai/VoZfrcLbH+j3Y93uhsYeLPNW5AABjJ7Bp1kTEKHr1ba84jgQmKbMTJDF/r4A61/p6x/Q0Jv30cn4NhkT8vYJ7+tLFZ7kStYjrrcSp7irNfmW2tvc7HhNXRp7s0eFmLsyV0ak5ATLy90MK7E7ySqbNC9AAZxnVYYHnMm6thdkummDMt4BVQfbk+dr+G8j124mae5dQY+m2VOxTjyPGXLrTMjvhr2h
x-ms-office365-filtering-correlation-id: 83ce6812-c4f9-4632-e490-08d627365deb
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0696;
x-ms-traffictypediagnostic: CY4PR21MB0696:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-prvs: <CY4PR21MB0696B9A5B4F550E018CB339BFBEF0@CY4PR21MB0696.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(42068640409301)(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(3231355)(944501410)(52105095)(2018427008)(93006095)(93001095)(10201501046)(6055026)(149066)(150057)(6041310)(20161123558120)(20161123560045)(20161123562045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991041);SRVR:CY4PR21MB0696;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0696;
x-forefront-prvs: 0812095267
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(39860400002)(396003)(346002)(136003)(366004)(189003)(199004)(3846002)(6116002)(5250100002)(71200400001)(97736004)(217873002)(71190400001)(1076002)(76176011)(6506007)(966005)(99286004)(11346002)(26005)(86362001)(36756003)(2501003)(446003)(2906002)(86612001)(102836004)(2616005)(476003)(14454004)(107886003)(10090500001)(14444005)(4326008)(34290500001)(316002)(486006)(22452003)(256004)(186003)(66066001)(53936002)(305945005)(25786009)(2900100001)(106356001)(6486002)(105586002)(7736002)(6512007)(6306002)(81156014)(81166006)(6666003)(8936002)(8676002)(5660300001)(68736007)(54906003)(110136005)(6436002)(10290500003)(72206003)(478600001);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0696;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: F8uDjhDnyVyrMlBFGAHVX9SPCj3EKA2OL8VF+3xA5AxP09yZg1avS9KdYhBYAcYpcsOeHxIe5f8h/Q4tAF8RCc9P6s7IyaA0POcVNyE/kigJ1jLdnHDWgghgxAxseJGH0OTKWYjFbTTduOJGtApw3mEVONX9M62/Sg2TmS0q3LSBYpXh+v9UcE6vjFM3RkWyVkJdFi2etMUTDh/Y50NzOKJYbKdd0exHZtUhk2a1rQhGH+/opWsfrVmc6zryu9rOGVVyfK7XhW2NqVMS4GNQ+VGBQg6r46tssTbuEWTPC2p/LPcMLBtIU75k950RHI41nqbMfbRPDG8YJScfV8OWku60/VzivAFqDy59YstL3X0=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 83ce6812-c4f9-4632-e490-08d627365deb
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Oct 2018 00:38:43.2420
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0696
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Randy Dunlap <rdunlap@infradead.org>

[ Upstream commit 002b87d2aace62b4f3841c3aa43309d2380092be ]

Fix build warning in apm_32.c when CONFIG_PROC_FS is not enabled:

../arch/x86/kernel/apm_32.c:1643:12: warning: 'proc_apm_show' defined but n=
ot used [-Wunused-function]
 static int proc_apm_show(struct seq_file *m, void *v)

Fixes: 3f3942aca6da ("proc: introduce proc_create_single{,_data}")
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Cc: Jiri Kosina <jikos@kernel.org>
Link: https://lkml.kernel.org/r/be39ac12-44c2-4715-247f-4dcc3c525b8b@infrad=
ead.org
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 arch/x86/kernel/apm_32.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/x86/kernel/apm_32.c b/arch/x86/kernel/apm_32.c
index ec00d1ff5098..f7151cd03cb0 100644
--- a/arch/x86/kernel/apm_32.c
+++ b/arch/x86/kernel/apm_32.c
@@ -1640,6 +1640,7 @@ static int do_open(struct inode *inode, struct file *=
filp)
 	return 0;
 }
=20
+#ifdef CONFIG_PROC_FS
 static int proc_apm_show(struct seq_file *m, void *v)
 {
 	unsigned short	bx;
@@ -1719,6 +1720,7 @@ static int proc_apm_show(struct seq_file *m, void *v)
 		   units);
 	return 0;
 }
+#endif
=20
 static int apm(void *unused)
 {
--=20
2.17.1
