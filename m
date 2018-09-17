Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F90FECE561
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 03:02:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B6F52147A
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 03:02:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="bFh0JjtF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1B6F52147A
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729544AbeIQI17 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 04:27:59 -0400
Received: from mail-by2nam03on0117.outbound.protection.outlook.com ([104.47.42.117]:22121
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729493AbeIQI16 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 04:27:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=40EZXziYlPlrJFV7rMzAsBF/USvmDzs+gAtcNDr2CKM=;
 b=bFh0JjtFyxS8itQbDsyWl6VOYmOve6sBFk1vHNgS2zVmZPzJlaoIAE7ZVngHrJcWJYw+5W9Ic1D3xhDCEjTGTXvqRahZ2UgIi6/AVjwcRgwtpD2SiMRVGWpony9Hlot98zK1OYQo4sFNGzYg1M211l6D5m2PcGGYVzin8qq9N3A=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0168.namprd21.prod.outlook.com (10.173.192.150) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1164.12; Mon, 17 Sep 2018 03:02:40 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1185.003; Mon, 17 Sep 2018
 03:02:40 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        Paul Burton <paul.burton@mips.com>,
        Kees Cook <keescook@chromium.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.18 104/136] MIPS: boot: fix build rule of
 vmlinux.its.S
Thread-Topic: [PATCH AUTOSEL 4.18 104/136] MIPS: boot: fix build rule of
 vmlinux.its.S
Thread-Index: AQHUTjK0cLS3e4wxGEGLVeIkhuESDQ==
Date:   Mon, 17 Sep 2018 03:01:17 +0000
Message-ID: <20180917030006.245495-104-alexander.levin@microsoft.com>
References: <20180917030006.245495-1-alexander.levin@microsoft.com>
In-Reply-To: <20180917030006.245495-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0168;6:dlsAe/dPzq4A6WkIFs/Bsy5bEz5zHk/MUWsrQ4d/8l3wzRNewzptOZM20UVyIfCiaDuf0omHrs1OSG3nrIVa3cWUjp00PczXvBi1Kj8ejz/eiw5DMXPzNH78oF5drIK9yAlgnaXf/bUNJNiE3fESjQlsrg/1LGosl1pY1WDIzU18A6BptiXCQBqxy9GjvJcqpDTU2VkVdOCNb3S2P42llizDuXMjPrHnM6ixFYrlWUgLpHt3JRk45HjOfhLC6ZW6iKZ9jb9oAzCeRUoEE98HWRPM5i3qbjXXFZ7sm+XsDK1XugGcLGJz4HvnaF8ylFVwHkJxUVNLBcnBPBiVdGv0ZboWRqefqNQ9AdzetR5SjLJ9zON1is802oe6nPKsJtEuoqLCQMtKjWCUnng0SCWD1Kj7F+Z4R9kyKkX6FDMXEegX/5RIpaTfMdX2TF03eTq3rdwPYgcHYcAIZ5UVGCmX/w==;5:2PrAWWrL87ZN3P7qvVkhmVAYVRTUwxjC1y8zV7MYwBvsp+l5fjvCJ1vV5+4/bh8VXeECncaMK5IZEl9fM9PcZACD5/N2Cue1ndQ5qsS3jp5mEYFtxZK2tPUXCiS81Z3AEdx/gMPeDuITCOm1WwIZwZv5T0jNzJh1qNTnAP/n+wY=;7:PHeVdf7vqx+0iPhtlnGTLiRlCUGwsVlvW8sQpZWYyzFTRyuwzcwPZDF3Btx4UyWtKj4lEQMa2G0iNE6/lrYgLRtY101GjD9cNnrDl6B7XLxEh2AbarALjgxaY/OiH/vbFX24yKVU21jYbgN3lyjjpVJghCZh5iI1zYYdnggjatg6w3gzuYsiUyrZmjzb67dXyDkNvXpaW5LefQf4WIbO97Adv/ljSh/n6UI0NBwKaN6pVXOkw0LMM4nyETIlvbBV
x-ms-office365-filtering-correlation-id: 118095b9-e590-45e8-78cc-08d61c4a0798
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0168;
x-ms-traffictypediagnostic: CY4PR21MB0168:
x-microsoft-antispam-prvs: <CY4PR21MB0168CECE6939ED3A5B7D2AF1FB1E0@CY4PR21MB0168.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(9452136761055)(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3231355)(944501410)(52105095)(2018427008)(3002001)(10201501046)(6055026)(149027)(150027)(6041310)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123558120)(20161123560045)(201708071742011)(7699050)(76991041);SRVR:CY4PR21MB0168;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0168;
x-forefront-prvs: 0798146F16
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(396003)(366004)(39860400002)(346002)(136003)(199004)(189003)(11346002)(4326008)(105586002)(106356001)(486006)(446003)(6436002)(2616005)(22452003)(966005)(107886003)(10090500001)(25786009)(476003)(14454004)(110136005)(54906003)(316002)(2906002)(76176011)(99286004)(36756003)(186003)(26005)(6346003)(5660300001)(7736002)(305945005)(10290500003)(8676002)(81156014)(81166006)(6486002)(68736007)(6666003)(102836004)(6116002)(3846002)(1076002)(53936002)(217873002)(72206003)(97736004)(6506007)(8936002)(86362001)(256004)(6306002)(6512007)(2501003)(5250100002)(2900100001)(478600001)(66066001)(86612001);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0168;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: BUD1wzWl4hBq65wV2FiEYf2zB9slsjPjm3nUoZO8aSpKhhOXFnIO+i2fIUcBPAKLXQzYgbTsNPID5MXdO5FGLq2os7P1JGRfk6C90qduh8xnL4s9Lqfho4yjzacqV5M87JtDKARKoTIWbFLXup5EVZjvBhKf1BcAyEQq0N6NXEmwWDcI6wXdHNK6Aq909OqMjXYbgOEEETN7TIF1xUZJQiDMPwSoE/pUPQW4VjDH3y9cawwq8hTx/PK4U0gLflBJX7XvzQWjXEz4ZLeUUZnz9potRKbS7wOmupRe98aUIbB7CTV1vaRpooNmyrEDZVDSzxe8ALLP8G+hwCEzIYfcOXusVmGyF2YnzLdB/z/HRiY=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 118095b9-e590-45e8-78cc-08d61c4a0798
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Sep 2018 03:01:17.9947
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0168
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Masahiro Yamada <yamada.masahiro@socionext.com>

[ Upstream commit 67e09db507db3e1642ddce512a4313d20addd6e5 ]

As Documentation/kbuild/makefile.txt says, it is a typical mistake
to forget the FORCE prerequisite for the rule invoked by if_changed.

Add the FORCE to the prerequisite, but it must be filtered-out from
the files passed to the 'cat' command.  Because this rule generates
.vmlinux.its.S.cmd, vmlinux.its.S must be specified as targets so
that the .cmd file is included.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
Patchwork: https://patchwork.linux-mips.org/patch/19097/
Signed-off-by: Paul Burton <paul.burton@mips.com>
Cc: Kees Cook <keescook@chromium.org>
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 arch/mips/boot/Makefile | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/mips/boot/Makefile b/arch/mips/boot/Makefile
index c22da16d67b8..5c7bfa8478e7 100644
--- a/arch/mips/boot/Makefile
+++ b/arch/mips/boot/Makefile
@@ -118,10 +118,12 @@ ifeq ($(ADDR_BITS),64)
 	itb_addr_cells =3D 2
 endif
=20
+targets +=3D vmlinux.its.S
+
 quiet_cmd_its_cat =3D CAT     $@
-      cmd_its_cat =3D cat $^ >$@
+      cmd_its_cat =3D cat $(filter-out $(PHONY), $^) >$@
=20
-$(obj)/vmlinux.its.S: $(addprefix $(srctree)/arch/mips/$(PLATFORM)/,$(ITS_=
INPUTS))
+$(obj)/vmlinux.its.S: $(addprefix $(srctree)/arch/mips/$(PLATFORM)/,$(ITS_=
INPUTS)) FORCE
 	$(call if_changed,its_cat)
=20
 quiet_cmd_cpp_its_S =3D ITS     $@
--=20
2.17.1
