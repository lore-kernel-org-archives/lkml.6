Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5BCCECE562
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 08:03:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 62AA8214AB
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 08:03:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Synaptics.onmicrosoft.com header.i=@Synaptics.onmicrosoft.com header.b="bjdkP41y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 62AA8214AB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=synaptics.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727691AbeIQNaJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 09:30:09 -0400
Received: from mail-co1nam03on0073.outbound.protection.outlook.com ([104.47.40.73]:14356
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726865AbeIQNaI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 09:30:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Synaptics.onmicrosoft.com; s=selector1-synaptics-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XvRxgT+BfLW2DfEXPIsqBy/CBVJT8fzU4KzyIBvZX+g=;
 b=bjdkP41yjf2fv+A3jhiQEWabkAJnp0aYebnLjflZfWiaCd5qJg/lLP6rbRavsrtGAIB85Itlnr1/HkIOojJPr3gxNIvysq3mbW0lDexBKaAN/kRlVo9HvNIi5Q3SZ26cDmWFF6UBLG0Z+O0HeavAyAzO1gsIBRae33UgcT5Iswk=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Jisheng.Zhang@synaptics.com; 
Received: from xhacker.debian (124.74.246.114) by
 CY1PR0301MB1578.namprd03.prod.outlook.com (2a01:111:e400:529c::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1143.18; Mon, 17 Sep
 2018 08:03:48 +0000
Date:   Mon, 17 Sep 2018 16:00:15 +0800
From:   Jisheng Zhang <Jisheng.Zhang@synaptics.com>
To:     Rob Herring <robh@kernel.org>, Mark Rutland <mark.rutland@arm.com>
Cc:     <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
Subject: [PATCH v2 0/3] arm64: dts: add Synaptics AS370 SoC support
Message-ID: <20180917160015.05a1fc5b@xhacker.debian>
X-Mailer: Claws Mail 3.17.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Originating-IP: [124.74.246.114]
X-ClientProxiedBy: OSBPR01CA0031.jpnprd01.prod.outlook.com
 (2603:1096:603:1e::19) To CY1PR0301MB1578.namprd03.prod.outlook.com
 (2a01:111:e400:529c::16)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 855bf703-5bf5-45b6-5deb-08d61c741a36
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:CY1PR0301MB1578;
X-Microsoft-Exchange-Diagnostics: 1;CY1PR0301MB1578;3:zvX/0nvvSv7hnsGeBeGn+ahewxMRuL/8D9dlC++pihUuQ79KciARbWkfMAgjwmerANQn1coUXPMcNQmmvzTn1MvQAgDpAxsMvPfhBwCMY58am/TM4hCTp2YedVhafo0aANz6X0/Lp4KW0wShoPA9m9g9I4H63x5mqGU6d9vMS56yQ1JsG/uCPFUaUtmdrobmJCKjlkemuSh6sqoXrQF09ApG4KF/l7KjHBqdcx41fSNPMC8KqPm4GpPRYAGMpFpq;25:su5A0IfSE0aZVM21/RQJLg2IRapXankSTJPmYH+x3MzatEvYvEQP3k4JZ2xpuGrLmPO4QNghZ0GZgqVIoxXcpGCq/uu9zZHAhvag1laD88g8YkTdkDQqNjJSIwsOk/vdWzHN2PbjuJiKCk0YCl9FeSbVIf8aLEQhfuaPneJVU9Rq9CfvoTyM3GRAZSfRLSmDxVtY3aGPitxfHLwWii77STMb0/U8KakV/U4e4NKhTEF1GY8pRIKyafPg6J1NiLl60mF2GEoHm6GuTg4Tx6xkiLwC5abkNeCnHm4j3Bsn3u2HYgw4d0QgD2eUznWLANgnwVKvRqoaE96Eeyq8vYtpAQ==;31:49Ot+0HShj/cpQYJMqKahTRdsfg9FBmoijbt2emkkDtz6zo7txblVpEZlzWBsZ5wowigpKD7W978Hf72aze4IfoFa9pwsiZh33NDoxzoBHMesgIR2M2HhfPRwam71rgsUiklb66J8si7rRmDdNbVUTguBEcjKqwE6CTRZFHOCLFX3hQlJD1AcCYU2bW/6Ol7wmSkFTuM4AHhwus/pQRuO/vzN1KRV8A+8W96HLB3Nw0=
X-MS-TrafficTypeDiagnostic: CY1PR0301MB1578:
X-Microsoft-Exchange-Diagnostics: 1;CY1PR0301MB1578;20:ZDscmzSHD5qNyNMpDQmQV+AaX4WsYiM2vVdiB+Uh2TYN0EKr59oBlqU0iFSENaY60xj4onHovAoccRc+py8ip5vXZ75y9WMAgQsYh7rmEN0xuO1RnYX6yvGe6e84LONUgb0++hsmgZiOFGyhAG/sgeVJyvaB6IZOi5VnFQvt2cfutCN7UEaxLKK7GILfnzD5Y1p8IqA+kegxkxqMxR0JjHdBnAF/Y902PLXAy4WwvY2R09hfbN1u0XceKwbNPbvsCY0BxnAlJVebMwItar0qD7NnKRUTYIuzpkUVEJMTaZPMteDRx6HRpPRrekk0BkYLk6fZ2dlzJAHXw6UVLN1XMt1uXZJY6qtuIgI7SU7/MAi5Gplz59RM70MYDLLG5yZzb0LsSzQFhA8q5P/dOyyQcBxPpBZKBijEUikSAYzgVUXlz941S67pY11B4PiBMLOtxecZ6jFFq8K2Hirk2h5EiyuwH/1+ZC2JQ6/WFaFG7w8/uU3OYVoXZOssVmiRWbSX;4:h/lNt3fDRJ5sXXqZdywy0dZnCM+Gk3GE+JXGFgq4Uk0iji+cfPZYOlLRtzksYETtBk+VNYh/skOEcs0tVND3z5VaQ3t5pdfyimcC1nO8l+UjHJk0yAdwS3v1jsIgdMTmp7aLscVWXkjCdXjnG43A04pFeDn6IXN8HaW+0gKvcTRscIEQnR9fbWe5+J9tgKVgaJ8gG4k+SF+aPXxGQeMFWv2AWFgKFD8jZ/Ls1VrkB13JWMjhLOivOZ3+SNdK5Usm7jzOaUZaEPpdrkyPLTbxTw==
X-Microsoft-Antispam-PRVS: <CY1PR0301MB1578A1DD7FE38E62173C49E3ED1E0@CY1PR0301MB1578.namprd03.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(3231355)(944501410)(52105095)(3002001)(93006095)(93001095)(10201501046)(149027)(150027)(6041310)(20161123564045)(20161123558120)(20161123560045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699050);SRVR:CY1PR0301MB1578;BCL:0;PCL:0;RULEID:;SRVR:CY1PR0301MB1578;
X-Forefront-PRVS: 0798146F16
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(346002)(376002)(136003)(39850400004)(396003)(366004)(199004)(189003)(230700001)(33896004)(68736007)(7696005)(55016002)(52116002)(81166006)(54906003)(8936002)(50226002)(8676002)(110136005)(81156014)(316002)(39060400002)(4326008)(86362001)(7736002)(305945005)(25786009)(1076002)(6116002)(3846002)(23726003)(956004)(476003)(47776003)(50466002)(14444005)(6666003)(26005)(386003)(186003)(6506007)(5660300001)(2906002)(66066001)(106356001)(9686003)(105586002)(97736004)(478600001)(72206003)(486006)(53936002)(16526019)(39210200001);DIR:OUT;SFP:1101;SCL:1;SRVR:CY1PR0301MB1578;H:xhacker.debian;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: synaptics.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;CY1PR0301MB1578;23:5UarIm2/YuH4eufBntw894IUUY2ALHqik4F7SW0?=
 =?us-ascii?Q?Y07+u/TGzS7XF6E6IKTItRTMgDCQxqKSFHAu7YpAkFYGXTfU0hI9yiiUhzZ2?=
 =?us-ascii?Q?0qcbPkDJkKIPCYCH5Ej//3iIMw3Z1OX1vQfaNTaM+ZOS9Usd8GjZjGe7fXem?=
 =?us-ascii?Q?gvlNl5KJyc75f1x3EEcYfPNTdG/5EROBFxxW7U62tocg0+b4lubhkgxGGiKp?=
 =?us-ascii?Q?XtZQguJhCiHf6f+pgR7QMy4Eq6qqWu7myWnv/N0BXCkcCQoPbDcHUGbU/wd2?=
 =?us-ascii?Q?z6W+hzMdL8PqTe5cfB48eSxviAjMVCsEjPRZDddhj3K6OFR9PA00WfHe9V7v?=
 =?us-ascii?Q?ftf+Agh9m4jpzc7Le2stKek46vIIP17zflZIWL7ellyPYEc3jFWnqxeXrfbs?=
 =?us-ascii?Q?k/L8l5M6QB1QbxXBs8eHsRFpiFKrCu9mphEO6s187slcOMPfjV3GO2yOjbqy?=
 =?us-ascii?Q?svElCoMsccf0rEEaTKwtKe5bWP/U0z8+8MBWJ9IT13GwQf/lGCt9v4ggAC5m?=
 =?us-ascii?Q?/txQIxN947AlzhuZm3NR18Hmssrrhu4BJ9a2BurbhyrfI7FJVAF1E5Lbq/e8?=
 =?us-ascii?Q?TDqK/VggVOwpxAk5c8D+k790wo3GgDS4VIZVCf+CRG9ty8FaePeK28ZO3LIh?=
 =?us-ascii?Q?xtDxiNeMk3fVzGSgtqhpPIn2YoUjuyF/pb9dZFFMdJVpFRuoQaWCkcrkEFd+?=
 =?us-ascii?Q?gPDZrst55VJqG/hT+HP2k7H2f1dxkYesV+nkI7QBHt7+sPrZFVaAkjnitrQe?=
 =?us-ascii?Q?0nX0+BPo7gszDCwBtj/QKcnk9gwuam9T4RfXUBaW2hoIdikvxiLga2yLS/tV?=
 =?us-ascii?Q?xUbBd+BaS5ReODqPFZ0WQtpJ9wUeiV6C5ZZSRe9XeKuS/8dCG4SUH3epklH7?=
 =?us-ascii?Q?mB5DVJtiTdgKzyaPIWyxx0PA7e4nYPOpHT+Gm8tCVBYX3R7iA36/y+tT/kMS?=
 =?us-ascii?Q?83FklQEVueHr0dKRp38SEN0rXbCzNZtwVf/UYLYVawx7V5A6yqHlIP9VxCyZ?=
 =?us-ascii?Q?EIfb3ifvy26aqcxxEb8P+TkLo079o0vKR3MVn8/CxyKWVS3FERrdIBIfAzG/?=
 =?us-ascii?Q?hBGcVVlNgecga2lE5p1lO056oSHgNhF09KUrzn1QOtBQiJexbX+HAfeHCSvb?=
 =?us-ascii?Q?GgT0QGGtwgxohqIPoDQRXOlA819EdvtS55FghVjxzmtU96Y2MpbDObu04FU6?=
 =?us-ascii?Q?NSmJYvbg5yMJ4vzw5AX0bUHDK0LjD2eu1cmwWqp/gL1qln5lrQHEfF/P0qg?=
 =?us-ascii?Q?=3D=3D?=
X-Microsoft-Antispam-Message-Info: GWXS0MZ2l2VaNdEgy+pnQ/jCveO0qxjH2StG9bemrNtU/XeqZWrUz7DNAamrFyUJiZs/ukmoZvvQDR2C8TI8u/9pEALtCT1HmudGatRWFpgzswDEO8FRrXxIlQYbdilxSLUGOmIA3+IBAE/clwBaw5BypqQIIiNSjUTwkXx6Gpcgl2FnEnVfPI7QJGD/XC7tCfFz6igVKcsygbBw58Lht9CeT5tBzjXkg9cNX6HegGiY2rJrZaGquyuJfVpp4O3qTUS5PBSl6V7vk0KFmCFsBnqzmBiy5N68YPDCFDqPwSHr1jXOayKe5QCx60YliITWNmj2pBWLUdbg0kGwZxUJ4N6TfeYAuXQXnqkAp95VVgA=
X-Microsoft-Exchange-Diagnostics: 1;CY1PR0301MB1578;6:ePcPQak+2Ied7iUYAh82vGkMTaIalNGfv8S7OqxvB9Sq5TiLLyNwDQI3qI7Z9zucejXs22+c5N/gbXfo0NuBSzvRfA7heX/O5cCTA2aF3R8KqKeQfv1iVGjaH6SLF1RjCx+wNLY3BVkd842K9JlRs9G4PBDs+HYfHfWfhcc1Eu1ucwE7JhjLuE3Sot83V8aXbVgmpyQg7pfKu5ASGBWBCjvw1+1VoWcah23tpMFX/wE9G5XhZctHoZnW8C+Ah9iEuV7LMwTf4HIMrlHZuAjuEpDgFjpgdlvnkysoxRFxjZgq+9V7eFjH4G0hNbzMynk3Sk5F4F5SQvZhOXZl1yXS9JE9trSs+b22i1ew+mNVXElyxt7+r7qPMOe/xONT7EtwNM/3rX2nVZfxTDis/bC9gHaQPaJjVx8+IEVT3OaadCEGhucxFeGNPEF1dBFgykv4/rHfYFFPJgAVfAF9Kxqnrw==;5:Nyb3yEJp5UBmNgk+pnSBDLEf7TWLfhacEX6ORZIvelAJQfUk41pGlOQILzGZD7loCpUFFdxzCel4Z4g5GdykaioIdxN3OMnekcODN5XLGH2Z54wm7c/Unfvkl+TwiaAPpMaTLLG6k53WhGqGD5xO9auJexeHP/KfcVL5Lz4jSAo=;7:cdMwQR46Kk821N/yi+CVgWLDs/fb1YhARNnORYTIK7PRJuPgdZQtRk0Bw+nSXGN/O1tBs7qt1jSWSYVp40YYRYNrxou0q8zjyRuVPCv+Zi5yQD5AHgE5YfIErAGYKLbX6qI0hYrnw9ZlWYMPc8oXUabFmIknbnnROAwN+aTVXZC0qMMlSRlUbVyGSNYdVIUjXhjTa6ogpk1Ildv1dD7h6K2dlW9pknBaOis8PNxgc2Ds8ECDsR6fe2N1Kx5q82ti
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: synaptics.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2018 08:03:48.3533 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 855bf703-5bf5-45b6-5deb-08d61c741a36
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 335d1fbc-2124-4173-9863-17e7051a2a0e
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR0301MB1578
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add initial dtsi file for Synaptics AS370 SoC.

patch1 moves berlin binding to syna.txt.
patch2 add dt-binding for the AS370 SoC.
patch3 add the initial dtsi file for the SoC.

since v1:
 - add Rob's ACK to patch1
 - add note about the transition from Marvell berlin to Synaptics SoC
 - remove aliases
 - uart@0c00 => serial@c00

Jisheng Zhang (3):
  dt-bindings: arm: move berlin binding documentation to syna.txt
  dt-bindings: arm: syna: add support for the AS370 SoC
  arm64: dts: synaptics: add dtsi file for Synaptics AS370 SoC

 .../{marvell/marvell,berlin.txt => syna.txt}  |  11 +-
 arch/arm64/boot/dts/synaptics/as370.dtsi      | 173 ++++++++++++++++++
 2 files changed, 183 insertions(+), 1 deletion(-)
 rename Documentation/devicetree/bindings/arm/{marvell/marvell,berlin.txt => syna.txt} (89%)
 create mode 100644 arch/arm64/boot/dts/synaptics/as370.dtsi

-- 
2.19.0

