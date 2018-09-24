Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A46AC433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 14:49:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D78972098A
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 14:49:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="cgHLQOtL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D78972098A
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731222AbeIXUwO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 16:52:14 -0400
Received: from mail-eopbgr710104.outbound.protection.outlook.com ([40.107.71.104]:46976
        "EHLO NAM05-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730462AbeIXUwN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 16:52:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Zn8cFuGHmII9KEXobSF3DGG47Mr9+ypkX2PhfdX+/GE=;
 b=cgHLQOtLyJAZN5VKMEdU8XkJwzorhOWmzrBCbh0fvDoQYbP1ogNwLPELCT08OLOkCc7qoeFcgIvgVT6nFzk3+eYYdPd5M/vLrdZ9aM1jzr2VHlKXr/jzwaRpdW5dgKScppaj4w6fDN6+ldPw6C8BbcCaKl6r7gqwALkdJTTo0mo=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0471.namprd21.prod.outlook.com (10.172.121.149) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1207.3; Mon, 24 Sep 2018 14:49:35 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1207.003; Mon, 24 Sep 2018
 14:49:35 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Zong Li <zong@andestech.com>,
        Greentime Hu <greentime@andestech.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.18 68/76] nds32: Fix empty call trace
Thread-Topic: [PATCH AUTOSEL 4.18 68/76] nds32: Fix empty call trace
Thread-Index: AQHUVBWvVDQsWaMWkEK81jAzhxShPw==
Date:   Mon, 24 Sep 2018 14:48:41 +0000
Message-ID: <20180924144751.164410-67-alexander.levin@microsoft.com>
References: <20180924144751.164410-1-alexander.levin@microsoft.com>
In-Reply-To: <20180924144751.164410-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0471;6:eFDkv0x3EVaXZ2+JhhByw/KKenu6wo1SNAyuEt/AfNiuA8sAnNl/aQ/aS93gXZvxcgsA5ixYRBHyvGhDdqwSHIIhBcX9n+yOWn1CqLfz3CJbnN1DhDPpRk2kRfXCipUnwrLqNnPZD3oYfYtGQGuzkurGr26seHiWYPuclQMurAHvqY97bptEj3IYE9+zkKTZDaTvBXJZtCnxOb06QsL1pJRyeQDEomyxZK6VanniBgOLnfBqk2IyiKzZF0vcKxmeo6N+4l8mGUy/LI2OapmYTwMdWEwJBWFa20mBdagUZZE/WWZGa1OIT75ewnjh6Z18VUIudsBb57VA/uDYtKeB3xscciLep9evYhRol5UspXB3tWBudsoWFpnONKrsZoQevmSKLR9vJ9azulTHztE3UXjUPc8JFsNCD/ZaMbosXEx8LWKk15qklTgzIQHjf+ZusaHR9tO2cLxANT2ZM9Y3wA==;5:6GtA0QrooUe6RFpF+uvEeHAjZkDOkgBKCQMYzW/iuNzP22U0QZGuQLDdfDVgPR3GKKIEuaeMgJmIMTWlfqQ/I7BwgUNIIMoQ0ZJVWSyV63VbcLuyvlyn6LIMCMuAYwPnL6vJOcg1KBuYmiycsBEsdeamCUPobXMYTlfm3Mmq+CQ=;7:+vnv6nRh4VaTJPpr5ykTCi0WWCgAiGRcHanUsOwsFxXRo9CO735evvUvoPWmEYXA4plTT0AXqLZH+JI945Lbp6DDg3wnOEG7VfRXqn0p70mcRG9SJjfCSf6/nOvVcCcjQqeW/UiJwseweS2w7p68ndVwI91ja6X5gZ7QpPXgZNUtEVEq4qg/YyhiuvciJvZgRuuY6ZqpZes0bI5TgXXf5SpHyuBj5ufRYDyPW2FyqlZ0yrhVw+tDSw9wavzGBSPs
x-ms-office365-filtering-correlation-id: 174f9c5a-0e65-4ad3-5d48-08d6222cf250
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0471;
x-ms-traffictypediagnostic: CY4PR21MB0471:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-prvs: <CY4PR21MB0471AA53DE62DCE94685E758FB170@CY4PR21MB0471.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3002001)(10201501046)(3231355)(944501410)(52105095)(2018427008)(6055026)(149066)(150027)(6041310)(20161123564045)(20161123562045)(20161123560045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991041);SRVR:CY4PR21MB0471;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0471;
x-forefront-prvs: 0805EC9467
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(396003)(376002)(366004)(39860400002)(346002)(199004)(189003)(6512007)(105586002)(256004)(53936002)(14444005)(106356001)(10090500001)(6486002)(217873002)(1076002)(6436002)(71190400001)(97736004)(71200400001)(446003)(476003)(11346002)(54906003)(316002)(2616005)(86362001)(575784001)(2906002)(86612001)(8676002)(5250100002)(26005)(81166006)(81156014)(36756003)(10290500003)(4326008)(478600001)(2501003)(7736002)(110136005)(2900100001)(186003)(6666003)(22452003)(102836004)(25786009)(305945005)(68736007)(107886003)(76176011)(486006)(6116002)(6506007)(72206003)(3846002)(99286004)(66066001)(8936002)(5660300001)(14454004);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0471;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: AGA9zTlM42B7tQg3gga7vvHsoVKFs7tf8iayoZPZDCzDYhROHKk/6lTgScwyT4XcQc6F32c/J++ZbRz7zRSdbdlaC4cc6Vx+CaacGZyPAF0uvvJFa22Hp1qyZRc8vGLGy5Th8Hi7jb09VymY0aGrXHfNrFKVNGFh+xjLkbt9Klw8pVjkrnlE1QBioKw+JrHR+MnjetJKNxPfse4Q+XDaAScTBSdSa4smk5j26z2Qu4FVpGtgd+qfsMLx5tVS0T6zGgK07yXoux7GIE7ztW5+xr6r2lNWK0dHHmbsXovIj9guVbJCBcOtvYS8QHTtBTQg+vU7gPJS+yRzgr45Q5CLJxur+eYKpTp90vqp30iH5yA=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 174f9c5a-0e65-4ad3-5d48-08d6222cf250
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Sep 2018 14:48:41.7766
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0471
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zong Li <zong@andestech.com>

[ Upstream commit c17df7960534357fb74074c2f514c831d4a9cf5a ]

The compiler predefined macro 'NDS32_ABI_2' had been removed, it should
use the '__NDS32_ABI_2' here.

Signed-off-by: Zong Li <zong@andestech.com>
Acked-by: Greentime Hu <greentime@andestech.com>
Signed-off-by: Greentime Hu <greentime@andestech.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 arch/nds32/kernel/traps.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/nds32/kernel/traps.c b/arch/nds32/kernel/traps.c
index a6205fd4db52..f0e974347c26 100644
--- a/arch/nds32/kernel/traps.c
+++ b/arch/nds32/kernel/traps.c
@@ -137,7 +137,7 @@ static void __dump(struct task_struct *tsk, unsigned lo=
ng *base_reg)
 		       !((unsigned long)base_reg & 0x3) &&
 		       ((unsigned long)base_reg >=3D TASK_SIZE)) {
 			unsigned long next_fp;
-#if !defined(NDS32_ABI_2)
+#if !defined(__NDS32_ABI_2)
 			ret_addr =3D base_reg[0];
 			next_fp =3D base_reg[1];
 #else
--=20
2.17.1
