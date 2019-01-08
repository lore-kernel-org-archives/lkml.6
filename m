Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70C3CC43387
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 21:20:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 305422176F
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 21:20:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="kc8V9oA2";
	dkim=pass (1024-bit key) header.d=marvell.onmicrosoft.com header.i=@marvell.onmicrosoft.com header.b="uRQtxn0q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730079AbfAHVUB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 16:20:01 -0500
Received: from mx0b-0016f401.pphosted.com ([67.231.156.173]:45280 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729320AbfAHVUB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 16:20:01 -0500
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
        by mx0b-0016f401.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x08LCjHU007335;
        Tue, 8 Jan 2019 13:19:07 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=pfpt0818;
 bh=tQ4x20xoEiE5ygFuZZ2JZKkrLdWBilpFonpx9ZWad3I=;
 b=kc8V9oA2dLaaktwFgtPoqB+wX8jNuZfQWZJ40c2rLqbDH4BSmroqeLmna4RTksbhSmdZ
 zoFvRxb3SC96ub7W+oF50ZuJRm1ZfrMgIwmPS7FnynlBv5L6GZ7YdnL1xKcLVL0SnBrc
 iNCDSnbiwn1mUNcppbX7FBAF5NcyuJ0o00Xnxlh0dpCuIrsLJZJcBxIhgRdku3TyoV3P
 B7mUHP4sz7jD7N85zsyEPGJkVGcr2c+mFj1FrFOhw/vAAdHCC/kmaWOABgjRVkrvyg2E
 FMkWSxfyCaeeNugo/JzUNDBzGGyQ1Oge4pEqZndAx60XZ3Tph/RLzhhvQQok+qXtCLpz rQ== 
Received: from sc-exch01.marvell.com ([199.233.58.181])
        by mx0b-0016f401.pphosted.com with ESMTP id 2pw18f8kcx-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Tue, 08 Jan 2019 13:19:07 -0800
Received: from SC-EXCH02.marvell.com (10.93.176.82) by SC-EXCH01.marvell.com
 (10.93.176.81) with Microsoft SMTP Server (TLS) id 15.0.1367.3; Tue, 8 Jan
 2019 13:19:06 -0800
Received: from NAM04-BN3-obe.outbound.protection.outlook.com (104.47.46.53) by
 SC-EXCH02.marvell.com (10.93.176.82) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Tue, 8 Jan 2019 13:19:05 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector1-marvell-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tQ4x20xoEiE5ygFuZZ2JZKkrLdWBilpFonpx9ZWad3I=;
 b=uRQtxn0qaV7j7iAXy9QxygbtImEA/JifcZLhHjkp5oRglA4NUBtIB8tkvNd4nZWuwk2OV+Sd4ueRNUhtT5heUHwe8QSHTJ782JoZphFBxnlYpyzyhDzvwE7oBjWogYRn8ymgtbQWY3gAGzKqG1h+qEBzeENcgO4tVkA2jcse7NI=
Received: from BYAPR18MB2888.namprd18.prod.outlook.com (20.179.58.203) by
 BYAPR18MB2824.namprd18.prod.outlook.com (20.179.57.216) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1516.14; Tue, 8 Jan 2019 21:18:56 +0000
Received: from BYAPR18MB2888.namprd18.prod.outlook.com
 ([fe80::b8d1:8b50:2bc8:2b0c]) by BYAPR18MB2888.namprd18.prod.outlook.com
 ([fe80::b8d1:8b50:2bc8:2b0c%3]) with mapi id 15.20.1516.010; Tue, 8 Jan 2019
 21:18:56 +0000
From:   Yuri Norov <ynorov@marvell.com>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        Adam Borowski <kilobyte@angband.pl>,
        "Alexander Graf" <agraf@suse.de>,
        Alexey Klimov <klimov.linux@gmail.com>,
        Andreas Schwab <schwab@suse.de>,
        Andrew Pinski <pinskia@gmail.com>,
        Bamvor Zhangjian <bamv2005@gmail.com>,
        Chris Metcalf <cmetcalf@mellanox.com>,
        "Christoph Muellner" <christoph.muellner@theobroma-systems.com>,
        Dave Martin <Dave.Martin@arm.com>,
        "David S . Miller" <davem@davemloft.net>,
        "Florian Weimer" <fweimer@redhat.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        "Heiko Carstens" <heiko.carstens@de.ibm.com>,
        James Hogan <james.hogan@imgtec.com>,
        James Morse <james.morse@arm.com>,
        Joseph Myers <joseph@codesourcery.com>,
        Lin Yongting <linyongting@huawei.com>,
        Manuel Montezelo <manuel.montezelo@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        "Martin Schwidefsky" <schwidefsky@de.ibm.com>,
        Maxim Kuvyrkov <maxim.kuvyrkov@linaro.org>,
        Nathan_Lynch <Nathan_Lynch@mentor.com>,
        "Philipp Tomsich" <philipp.tomsich@theobroma-systems.com>,
        Prasun Kapoor <Prasun.Kapoor@caviumnetworks.com>,
        Ramana Radhakrishnan <ramana.gcc@googlemail.com>,
        Steve Ellcey <sellcey@caviumnetworks.com>,
        Szabolcs Nagy <szabolcs.nagy@arm.com>,
        "yury.norov@gmail.com" <yury.norov@gmail.com>
CC:     Andy Lutomirski <luto@amacapital.net>
Subject: [PATCH] arm64: introduce AUDIT_ARCH_AARCH64ILP32 for ilp32
Thread-Topic: [PATCH] arm64: introduce AUDIT_ARCH_AARCH64ILP32 for ilp32
Thread-Index: AQHUp5fD/ajdYeOKIUylrBlkcke37A==
Date:   Tue, 8 Jan 2019 21:18:56 +0000
Message-ID: <20190108211840.GA13838@yury-thinkpad>
References: <20180516081910.10067-1-ynorov@caviumnetworks.com>
 <20190107155028.GA25178@yury-thinkpad>
In-Reply-To: <20190107155028.GA25178@yury-thinkpad>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1P189CA0014.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:802:2a::27) To BYAPR18MB2888.namprd18.prod.outlook.com
 (2603:10b6:a03:10d::11)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [212.58.114.230]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BYAPR18MB2824;20:GVgADaVc10pzMa3PZXpifDUtqQsqXyJ+u7RZD0QkIXklkPqRAw/nFXl4IWe6k7LTodSR1DaqcR23DM6CN7E/uytGeRq/am2JooHL2pSBQvFj2SF8bQDF2KazF0y/Flzv9ozNaT/HtXUOO1oq3DkJPVuMyifT5W3kz7wjVOFf9BM=
x-ms-office365-filtering-correlation-id: bcae0289-84aa-450d-2664-08d675aee5cc
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600109)(711020)(2017052603328)(7153060)(7193020);SRVR:BYAPR18MB2824;
x-ms-traffictypediagnostic: BYAPR18MB2824:
x-microsoft-antispam-prvs: <BYAPR18MB2824065CA7A2C9948CB05B84CB8A0@BYAPR18MB2824.namprd18.prod.outlook.com>
x-forefront-prvs: 0911D5CE78
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(7916004)(39860400002)(136003)(366004)(376002)(396003)(346002)(199004)(189003)(386003)(6506007)(102836004)(486006)(66066001)(110136005)(3846002)(6116002)(6436002)(52116002)(76176011)(2201001)(86362001)(186003)(26005)(2501003)(6486002)(1076003)(7406005)(68736007)(33896004)(7416002)(316002)(11346002)(305945005)(446003)(7736002)(106356001)(105586002)(97736004)(2906002)(256004)(476003)(33716001)(81166006)(81156014)(8936002)(8676002)(99286004)(4326008)(33656002)(478600001)(5660300001)(14454004)(71200400001)(71190400001)(6512007)(53936002)(39060400002)(9686003)(25786009)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR18MB2824;H:BYAPR18MB2888.namprd18.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: marvell.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: Wrqhp8Q/sv5RRoNYcV5Cx2gQ4GrcYfO1+iT4p776KJrvZ2700+bdFH7B/jEnnBEPVMhItAaX5dCBmdLQ6X71mlSyavYohfDfwb6VvHvKmToxh0kwP6bZb6kAQDSJ5jjAAmQ//QhFBx0J+qD31mNF1iaf9tr5gHApeV+7qNwOPw8z6kvn1k1EXQLd2//0DM8JB9Y1D4PC2uINsqyBe2yettGRmkpLwA+nfJ+rTFWnJVNMfmKvLtA3EOSYLbNau06JIGzvBj3Gu14oLTdV77TaQFNDpZiVKHimq7jD0wC5dzgj2tn5Xp/J9poC0LVKFgFN
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-ID: <ECFB331D797AC1488D832907AB4C052F@namprd18.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: bcae0289-84aa-450d-2664-08d675aee5cc
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jan 2019 21:18:56.4937
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR18MB2824
X-OriginatorOrg: marvell.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-01-08_11:,,
 signatures=0
X-Proofpoint-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1901080162
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make syscall_get_arch() distinguish arm64 and arm64/ilp32 by adding
AUDIT_ARCH_AARCH64ILP32.

Sugested-by: Andy Lutomirski <luto@amacapital.net>
Signed-off-by: Yury Norov <ynorov@marvell.com>
---
 arch/arm64/include/asm/syscall.h | 3 +++
 include/uapi/linux/audit.h       | 1 +
 2 files changed, 4 insertions(+)

diff --git a/arch/arm64/include/asm/syscall.h b/arch/arm64/include/asm/sysc=
all.h
index 73fbe08763b0..77578d703cb1 100644
--- a/arch/arm64/include/asm/syscall.h
+++ b/arch/arm64/include/asm/syscall.h
@@ -126,6 +126,9 @@ static inline int syscall_get_arch(void)
 	if (is_a32_compat_task())
 		return AUDIT_ARCH_ARM;
=20
+	if (is_ilp32_compat_task())
+		return AUDIT_ARCH_AARCH64ILP32;
+
 	return AUDIT_ARCH_AARCH64;
 }
=20
diff --git a/include/uapi/linux/audit.h b/include/uapi/linux/audit.h
index 818ae690ab79..624127147404 100644
--- a/include/uapi/linux/audit.h
+++ b/include/uapi/linux/audit.h
@@ -374,6 +374,7 @@ enum {
 #define __AUDIT_ARCH_LE	   0x40000000
=20
 #define AUDIT_ARCH_AARCH64	(EM_AARCH64|__AUDIT_ARCH_64BIT|__AUDIT_ARCH_LE)
+#define AUDIT_ARCH_AARCH64ILP32	(EM_AARCH64|__AUDIT_ARCH_LE)
 #define AUDIT_ARCH_ALPHA	(EM_ALPHA|__AUDIT_ARCH_64BIT|__AUDIT_ARCH_LE)
 #define AUDIT_ARCH_ARM		(EM_ARM|__AUDIT_ARCH_LE)
 #define AUDIT_ARCH_ARMEB	(EM_ARM)
--=20
2.17.1

