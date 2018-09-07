Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94094C4321E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 00:45:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 418222083D
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 00:45:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="L9KqUwOC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 418222083D
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728829AbeIGFXL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 01:23:11 -0400
Received: from mail-by2nam01on0120.outbound.protection.outlook.com ([104.47.34.120]:44004
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731174AbeIGFUT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 01:20:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aIclNX57bRjHAM9wMxoQ70UrlkQ/TJaLUwMbFQjfLZo=;
 b=L9KqUwOCIpaZHg0VZp9MmImTo+eRNx878EYXVBCF1SCOrsUWOzip6JN4lt5hQl/ZQsrAHCGevLz4IHIDyLfw99OQ8GJUIz9rPM2V7EC4ZMZuWfuqAVtxE2fKgPM9D0Wygnu46Oa+XQgnhZbEVLfEuhgA3xA9Rht+ZWp6Jngm9SE=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0822.namprd21.prod.outlook.com (10.173.192.8) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1143.6; Fri, 7 Sep 2018 00:42:04 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611%7]) with mapi id 15.20.1143.008; Fri, 7 Sep 2018
 00:42:04 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Paul Cercueil <paul@crapouillou.net>,
        Paul Burton <paul.burton@mips.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        James Hogan <jhogan@kernel.org>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.4 23/30] MIPS: jz4740: Bump zload address
Thread-Topic: [PATCH AUTOSEL 4.4 23/30] MIPS: jz4740: Bump zload address
Thread-Index: AQHURkMzhOl45rcEekCCYSVn6rP/Jw==
Date:   Fri, 7 Sep 2018 00:39:14 +0000
Message-ID: <20180907003853.57942-23-alexander.levin@microsoft.com>
References: <20180907003853.57942-1-alexander.levin@microsoft.com>
In-Reply-To: <20180907003853.57942-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0822;6:oe8r4vSFED/CbPUqtVduPKqfej6XcerIX/2LVLytEl/FW3QO8aE6LVBBqIBYh+DmqtnSwTShhcrBaPRkRzOpxHVQOfdcN/oFllxZatuIUwQj7TJ6cytNYoepMI34FneMwqo2Jqj34UaEPNkYeLEPJ2ZL4JdU0ewCK243YTo7tEEBuvUt3C+r2DcpfsHeTicS7ahGOI8OmE2nplUClBPoES5YtLY75p3YnJHbPMCBuWga0yktpUAxjZwd+OiIk5brylDRkTU8ssLKn9cE3QvIbMV4LR9NGSUSC3fYSAWxpzK11rz+uvwsUgzs40lCP3HrPWnIRbudg36ZX0KgD91fICujFpD1sphqOlsGnbbPFKG48tx/UXA2Y2MO2AdacxjFIxtbeJWOB2ic/Ez1uLEauYgDc/uRxqoIOW7teVpQM92V7ZgfHH/Uc5cSnhao9AV0pY2BaTELoqDma8GDM6bq6Q==;5:Yg4Yka+x6ewu8uyq1GFqF9b90TjrDFkirErP//5xc2/yFbR/9kKZUnojgJlVYNzW6d3e5NqyUN6637lglkY8KPE9bF+mSJ6e3Zzy9MDnmPjrGwVzZnKAlYcRoQfg5stnyiBYeZCFdyzKg6Smo0RmHiIQpSCnfpSyxJvKa/JrPKY=;7:/EK92hPlgADk/DGoZN8ncL+2Nccj9KhTn4OzPPJ+0UX6eDBN+5A/Iq1LxUlNBtU5Ozb4ioUHDlkNB5bX7o3+jxWnbKUBYS+IASd+KeXCcQJIcVXZr1nHiy0xmgQxWMuGKvmaksFOVR2iSu6p0X1e+xABSyjDHiBCN/MnHej7m3lYzju+Ea/sumXZTi3h8jtAl9TAmnvWcueyR7FMrcFStt42Y53l/WqE3WsjgLVkRSi2xE+9zPcDNYvthpl/rTIS
x-ms-office365-filtering-correlation-id: 2dbf5b06-c2ee-4146-d65e-08d6145abb89
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0822;
x-ms-traffictypediagnostic: CY4PR21MB0822:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-prvs: <CY4PR21MB082237BD4ADB6215D8EEB06AFB000@CY4PR21MB0822.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(9452136761055);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3002001)(3231344)(944501410)(52105095)(2018427008)(6055026)(149027)(150027)(6041310)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123558120)(20161123562045)(201708071742011)(7699049)(76991033);SRVR:CY4PR21MB0822;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0822;
x-forefront-prvs: 07880C4932
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(39860400002)(376002)(396003)(136003)(366004)(199004)(189003)(6506007)(10290500003)(478600001)(102836004)(81166006)(14454004)(22452003)(6486002)(26005)(53936002)(966005)(186003)(6436002)(72206003)(2501003)(5250100002)(110136005)(6666003)(54906003)(3846002)(316002)(6512007)(36756003)(1076002)(97736004)(6306002)(8676002)(81156014)(6116002)(5660300001)(10090500001)(76176011)(14444005)(2906002)(256004)(8936002)(2900100001)(99286004)(66066001)(305945005)(7736002)(486006)(217873002)(68736007)(4326008)(25786009)(476003)(106356001)(11346002)(107886003)(575784001)(446003)(105586002)(86362001)(86612001)(2616005);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0822;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: rxCFHaoGIQfZJrrkI2KfutXd4Kj8me22GC4J7AJ3pQPUNjQqXSP6SkBVQ3PvDeXhAjNYboETteLhL4Tv/zxr3jdnmGmK9UgIlvirtLSWreWGM72PL2NRMNXqhB7GeMW9icDYR56nyY1a+Epxca9C3l8hke5o335ocNyLnSiZauvwqnRCkPkAlbqr0td6q4E2DBY/p5qoEvVSZiXr/DnNXsQKh1j+8TtdW5IsiDciMD6jREWqV57j+uuucSRNTRDM/tqXlFugWBJZ43imTVBqRKtwoFGnP+K4SHe3Pet+vAxBrgsXvHpkFxyrTH8FK5nDJ3P3GjJbpFNlUlPJ0melLcb6FB34tnhYwtAkzGZHXl4=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2dbf5b06-c2ee-4146-d65e-08d6145abb89
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Sep 2018 00:39:14.2491
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0822
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Paul Cercueil <paul@crapouillou.net>

[ Upstream commit c6ea7e9747318e5a6774995f4f8e3e0f7c0fa8ba ]

Having the zload address at 0x8060.0000 means the size of the
uncompressed kernel cannot be bigger than around 6 MiB, as it is
deflated at address 0x8001.0000.

This limit is too small; a kernel with some built-in drivers and things
like debugfs enabled will already be over 6 MiB in size, and so will
fail to extract properly.

To fix this, we bump the zload address from 0x8060.0000 to 0x8100.0000.

This is fine, as all the boards featuring Ingenic JZ SoCs have at least
32 MiB of RAM, and use u-boot or compatible bootloaders which won't
hardcode the load address but read it from the uImage's header.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
Signed-off-by: Paul Burton <paul.burton@mips.com>
Patchwork: https://patchwork.linux-mips.org/patch/19787/
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: James Hogan <jhogan@kernel.org>
Cc: linux-mips@linux-mips.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 arch/mips/jz4740/Platform | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/mips/jz4740/Platform b/arch/mips/jz4740/Platform
index 28448d358c10..a2a5a85ea1f9 100644
--- a/arch/mips/jz4740/Platform
+++ b/arch/mips/jz4740/Platform
@@ -1,4 +1,4 @@
 platform-$(CONFIG_MACH_INGENIC)	+=3D jz4740/
 cflags-$(CONFIG_MACH_INGENIC)	+=3D -I$(srctree)/arch/mips/include/asm/mach=
-jz4740
 load-$(CONFIG_MACH_INGENIC)	+=3D 0xffffffff80010000
-zload-$(CONFIG_MACH_INGENIC)	+=3D 0xffffffff80600000
+zload-$(CONFIG_MACH_INGENIC)	+=3D 0xffffffff81000000
--=20
2.17.1
