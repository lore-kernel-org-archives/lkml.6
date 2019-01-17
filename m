Return-Path: <SRS0=R5eS=PZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BC3FC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 07:03:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 16F6C20855
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 07:03:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="N5cUW2Lp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730303AbfAQHDI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Jan 2019 02:03:08 -0500
Received: from mail-eopbgr800073.outbound.protection.outlook.com ([40.107.80.73]:14816
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725980AbfAQHCq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jan 2019 02:02:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Nh4Pz1CClXYFEFe8SNMcBd3WxUTUJRdw9z78Q//Rs+I=;
 b=N5cUW2Lpm1pUAwp82122veRK4pscj8UBrwEW+zMeTqEA8uGvthg5KgpEOYIdt0yAJ30g7yeV2QyX5lMkofJKpaHEk6liVF+p/q1A0hY+D/c0SLt6er2568Yar9rHEpfYG3cBeWfa+ayFqv7/HpGbFKZcszHAiJz15zWMHs8u4yo=
Received: from CY4PR02CA0009.namprd02.prod.outlook.com (2603:10b6:903:18::19)
 by MWHPR0201MB3513.namprd02.prod.outlook.com (2603:10b6:301:77::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1537.27; Thu, 17 Jan
 2019 07:02:41 +0000
Received: from CY1NAM02FT042.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e45::206) by CY4PR02CA0009.outlook.office365.com
 (2603:10b6:903:18::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1537.24 via Frontend
 Transport; Thu, 17 Jan 2019 07:02:41 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 CY1NAM02FT042.mail.protection.outlook.com (10.152.75.136) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1471.13
 via Frontend Transport; Thu, 17 Jan 2019 07:02:41 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66] helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.63)
        (envelope-from <kalyani.akula@xilinx.com>)
        id 1gk1hI-0005kE-VJ; Wed, 16 Jan 2019 23:02:40 -0800
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <kalyani.akula@xilinx.com>)
        id 1gk1hD-0007Rm-Rr; Wed, 16 Jan 2019 23:02:35 -0800
Received: from xsj-pvapsmtp01 (mail.xilinx.com [149.199.38.66] (may be forged))
        by xsj-smtp-dlp2.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id x0H72P48022372;
        Wed, 16 Jan 2019 23:02:25 -0800
Received: from [172.23.155.90] (helo=xhdengvm155090.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <kalyania@xilinx.com>)
        id 1gk1h3-0007MK-3w; Wed, 16 Jan 2019 23:02:25 -0800
Received: by xhdengvm155090.xilinx.com (Postfix, from userid 23151)
        id 5782B800CA; Thu, 17 Jan 2019 12:32:24 +0530 (IST)
From:   Kalyani Akula <kalyani.akula@xilinx.com>
To:     <herbert@gondor.apana.org.au>, <davem@davemloft.net>,
        <linux-crypto@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     Kalyani Akula <kalyania@xilinx.com>,
        Sarat Chand Savitala <saratcha@xilinx.com>,
        Kalyani Akula <kalyani.akula@xilinx.com>
Subject: [RFC PATCH 0/5] Add Xilinx's ZynqMP AES driver support
Date:   Thu, 17 Jan 2019 12:32:16 +0530
Message-ID: <1547708541-23730-1-git-send-email-kalyani.akula@xilinx.com>
X-Mailer: git-send-email 1.9.5
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(376002)(136003)(396003)(346002)(39860400002)(2980300002)(189003)(199004)(103686004)(47776003)(44832011)(36756003)(90966002)(107886003)(50466002)(48376002)(356004)(51416003)(6666004)(4326008)(36386004)(52956003)(2201001)(106466001)(110136005)(106002)(305945005)(478600001)(336012)(6266002)(426003)(26005)(42186006)(16586007)(186003)(54906003)(316002)(63266004)(476003)(126002)(217873002)(2616005)(81156014)(5660300001)(50226002)(8936002)(81166006)(8676002)(2906002)(486006)(107986001)(42866002);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHPR0201MB3513;H:xsj-pvapsmtpgw01;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-83.xilinx.com;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: 1;CY1NAM02FT042;1:MSOY+tu++VB30lyLvIdGlq/kLCXdMEyJhYQZsDGNVK2GzfBMY8u0cMftwjKoe2QUZR395jWBhGQylBDC/VYJzLkfDaC+r0GOAJp7HJfxrJY9SBkmbRSrYPtDLfwDOdZ5
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7ff6f7c9-d9b1-4398-6e81-08d67c49c604
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600109)(711020)(4608076)(4709027)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060);SRVR:MWHPR0201MB3513;
X-Microsoft-Exchange-Diagnostics: 1;MWHPR0201MB3513;3:O3vnbzTdLQ0iFgf38N2r58CTMu5CXotb8LyaiAVavciN9PJJjqs2jQtO67VBU+SE3ZEgyrIj/CSHGgaVLzwam/8a5xMoE7KGQl+mc7ipkNTcJw5/ZE8Z3jciwv1WTB5ZizP1+RHiRQdkmFEwrzi8RmIwyDFQ58so3T73NWubp7vOhnPXfPOU3j6Ntmi43/+OX0g6El+v/VCF4COqqkuVuV1HaYYoTE83GJW8QqvHV2GjvP9wjCi3ScU44iS8g2pYGC+Jw6vTKItfW/JPZJkiwHhgCGOIFF2sYA+c+xWgTfc/kgnTTWw99Zu1Zl8E1591wpMEDF5IPJflYi6HL99/uyKgoAQu08gxPl1zCJaw4D07Yc7k3m+Qs57+yeWwhBqw;25:mBGKpKWzn1QNKVzXweNp9Tvo6hcC/v2GXMpsZq2qARwSnqQoTzf6SsMf9La/AzF6HVv/bCxPxQfGHhujiwTNvuYrr/yuNOvAvBLKn6e5SuJvt3mfTWcMkgYbfJ+fqotX9qBCuYsykfCNRMZKUXK5K35m52/NYJ2v4U5AEX1MxRDGYKoA5MQZTef3NHPeIf+1EReHiCj9XMhjXr7OjpFc+TrxnzULR+bw0BDgf3+wBL/gXWbQYAkOpw93mf14JiZ/zdnJAmMVqXyEgHUwIvhbwIpvPADg4BxHE09Cv/7CpetYzTSan2tqZzOsD3Rx2sUaopFIEH0hrMEB7RJiP+LXCg==
X-MS-TrafficTypeDiagnostic: MWHPR0201MB3513:
X-Microsoft-Exchange-Diagnostics: 1;MWHPR0201MB3513;31:NqYKHX2E/3HoLxFHE2DL8i3SZCGduCCwmKJymIEPGPhkm8BjGdVupXZgqba+k98ZgzELOMPyeEqRBlXFLiJ59/PAUi7pjW/L0QS564hJgOEO7hpJQ2cmrLSLz50bN3Kto7P9tthG8fohfRToKhjHQ5DOIwdFw7gRZGJfiLDxcXMW9xZE5DxRA5Vrt0/Us7/Uf8kEBn6M5RJ7x4eFy8pS4T8LHgfU2RlDBxA9MOj40AE=;20:mMKVg6Z1rtS5N+Kp6wlCkJyWYOGUomV7U4yp93S5xSyr5wPbBoDeSd5vVpLvWsUISYsy9I6qMuG4W79rZOeMu5D7Y6LrlCfhEWzOhmfTVGOfaQrRtpeUkpooDt5CtwhteOdFizpgFcsbCgwaJsWzcxUelUuSiw4f9Uk8gECrzNLrQHjhdJp66KSsFXhbUKEzIrDkjYSlwv3BibPJ55aqgnReyE+NM1A/cijGxzgyV9J887/WtH7JulAtE6ah+uzX/LR6A6pgkxVuB2zcevBpqVFCD9I+hhI2aEgHByYhIcVrmiGsQG15daXN3nWu7HlYRpZT+LwFB+zsWpGxibaHkTKgvLCbSbiiaMCe6cVJjTB+aH5gaura5NKcU8CvZHb9dPK8RutaU75E2BvvHCOhmJs1VGReh5FfRhxqcBgD5tXU5kXzLfiJr6YuLA3nxZtN+UdL2oelhsGclJCU3rE7FioTrrz3+c3YiS2cgd3aUGNEGqE5E/SDUCILGGPlV2qG
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <MWHPR0201MB3513388C7A7EBDDA9AD9E4E0AF830@MWHPR0201MB3513.namprd02.prod.outlook.com>
X-Microsoft-Exchange-Diagnostics: 1;MWHPR0201MB3513;4:d1wz23CspnjtrRT9Q9akB3smlUpw0k0kxUg3caPt3oy7SzTDJV5x89nArcjau5Q3piua4LItFArOgYmowxzrUk2J9S+R6GilsXfMqF7S7tH2urJDwKzH8aSTT9RpoQSh3rKBsIENgHdUGoUE9BAyRUGdg3Bs1BqkXze3v9CAyi557WsYyUB4mviKYwd/4QQFqyUfPySncDTC9zPcqcj7QALlSDlSC1LH7hyUr2Hro5amrj/1VYvtr5NmLySWpugJNDEg56xyD/hTzfsBg5V22q/kpPvdfjTKmxXHmzZeH07ItGYIo4iKfilLOIAV5+WQ
X-Forefront-PRVS: 0920602B08
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;MWHPR0201MB3513;23:q1ci4lDeNZf5NQNTufsf1cqDNc6uhmFNtRetCjn?=
 =?us-ascii?Q?QSsXjJAMYgAnY9RU7MWCogfwQrClpLLuPZN/ftLJ/4kM/i8tYLQDzon7/toO?=
 =?us-ascii?Q?Qb0JtOncUm684mlON2L3fkv+v5sItjDFC8EyXplRJOfu7OZ+8/AA+QLEpov7?=
 =?us-ascii?Q?3UDxVedxRYlpjNAfA0Oo23g5LcyHGHLh6kdTeea8cvE0ynonyES9kjBEvr6i?=
 =?us-ascii?Q?4AEibWS/qswwseJRlk6B06CTgZb2LbX0kOVoy/xuBYbaGK6RMZd2nLVhiU2W?=
 =?us-ascii?Q?abZhxsIkHNPKmUs1KKPTMaYWfG9FfTWpjEKu/OXo3adPEPatgBWTlig2sIuR?=
 =?us-ascii?Q?V14SKV17P5NnsR3Ji0EDOV7XDimslE4rtgDZVhoCAJ/1h3QRWw0rg1e5QkvH?=
 =?us-ascii?Q?9agPTLYxgwUGVrMOTliWwNkQQkCPTjCFSuNiw4t/sPCs7ogeoxRDJW+ruh7F?=
 =?us-ascii?Q?mwf/YkSXnC/NX4WrsRcm5+6K/pYMzeWZpq3HTFEZXt0GSPgZC1NO0Vd4HPEY?=
 =?us-ascii?Q?ssga6YFzvGyiI7O9eSejnnmpSGRsgnYKvcIr9XUxFd288emSMLGaUJzQXJ7K?=
 =?us-ascii?Q?Jv7S8DLVToXgglCu2D/qfILWxnkYW6t6J+XiI2L0M9DlP/JHO/qRJEyXTE/P?=
 =?us-ascii?Q?7Rjl5w3S6XStMEdfuSgzOqOiSz/DHqlzJkFWdWm+iGWR08vp8RZBxReNrflx?=
 =?us-ascii?Q?reddjgKx3DBv2fISIdkQuz/LYpZcrH4O43CwjYcowFxK9NC+xc6QDSmA4MKH?=
 =?us-ascii?Q?8XRxuxkWwC/kvKysAldsuJhPLcm+eAsT4ZcWLpH2qBOwtr4zDNQeBwhbjA8d?=
 =?us-ascii?Q?JYDvc/ziHBSGi3a9QOQIFfXxxBm97eUr9s0wxX8Uo7G8g8tKerNsd6oXP+en?=
 =?us-ascii?Q?8/ELTBk+/+XyL3HoS1u8pD+eTBF3QkTC6+2VQxCi09OSc+PGNJ0pPkAnIBo/?=
 =?us-ascii?Q?Zgr+wBDNMn4STc70tZlplfU3DYeyY+uO6vAFPdu1Nyh33yXeu1epdi5TLi3v?=
 =?us-ascii?Q?EW0EfUC+4wAHIJXPTHsphEgGBsTsxBiaiuLSPMGFhG+q4gQlmBaHbyPpT4kg?=
 =?us-ascii?Q?FaC4jA6TdoijQ2DCfRSlSvJey7CjrPV10x9xPb2NuzQVNG3BW29MUPaI9jaX?=
 =?us-ascii?Q?IX6IRC19wj2nD1PGfO3m2mwSVOdp2K5xOTjjJmcwV3unTNbkub1jFLQ=3D?=
 =?us-ascii?Q?=3D?=
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: 2BSi0qeeGG0V0J5oWtgiMI2d/UwyvEc6QSbC1WGMcWgHQOltCYzsfnakBto9nGpBcb6OqjqRzrR9MlN1B/HMqyr1C48osJakW9+0fETSeqOPjciX33+xPhuX8IX8Yhiz82Yhq7rNxl2/ve+THmuQiyxbLe0F4712HZTVGWd5w+55u0tSaY0WldsyUEEpLHUi6eT1Kt+2HgdzJLjPE2v2ZZ+LA1u6gS9vR8TlP/2OSzHcSVFuUkFSNJd0xWG9hVdCgriN6y7WguWnbpJ2x47MNzcaVDY0gISe6sOjPXkVV4sFnQ95fq0PcdCkbXt95R1HvZs73y3wmgmOYfWZBjNrIjDuVvJLueWmCfY3NuqnAxpl3qg8fEdBzKM/8xEdsAa7v6hQBm6d4C7pP04wD2UDRY8hFjl3ezEHjlbwI7UszCY=
X-Microsoft-Exchange-Diagnostics: 1;MWHPR0201MB3513;6:7v4U4lHFfZaVUkxbdz9dacAuXiGzqZgyhPB7HkMKkQREmHBZYzt+MfaDs9WNOsd1nVDRpCqL2/A6nrFcnENbYjt9Mkt+KrKWVvYef8f+YiKcO62a+Dcj0qYqGkLyT6Rnhyo91kfhJheke/z01hgpXXtvGxO34XQD+YqiIUFzSXRJVKy0B8gK40gWYB2dia7ZtatPWOGXWeuLXz6m7VnFHdmzqmD+6b5UVT5VpIV9Y0PxFq0DOIRBBvbqw7zhXbrM9b6zwUBtwmbUgzAkIlHMaMCdhQjJPv2hVOn8CmX4EHNtyVIpf8ipT3oebgVzGt9GVhMR/SsOIE0w629ZVN84bvCxq07PGw9qd9lMci/QXvFF9a3sfavkqo868tSNWdb3SVpqKK2Qz+Wos02Tp8mmXloetKMsr1WoIwrd87nNaYzJVZ+lqhxvOELHTbf14nqZ4L28f6j/qu1PhqZM+MnQ/w==;5:7I3Fy8wZWcfw8No3JqTnz5wwmzxa7pW0wvlp6Y4lqf4wLM/cZMzFmpn4RE4Hdiq8FTY+4UKWJMNoqVM+cRgXTXKqTlLUZjLSfdpN7psEBVTM+IsTpJVdIvpnMhizJLETQ9eaQbNjicpdC5J26n0Huy91+52Zcc3/0tDzGmaFdlzqlH3f9tAf6S5ayD1wv3p8ETU4n9JxGcz/ckqjwxJG+A==;7:kPN8AuiKc26n/eonIIi20ndTxw2J8Coljni6D+7m65o2JBUgjE6TES67yVDUTz3a1aa6x3HTPi4GsEpou0P4eaobZa1n5UVJ/HBIWewBjV5AyoCFIRxcEq3NSRkh5JrlCBCyu3Yx1ejMXcZNfsUx6g==
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jan 2019 07:02:41.3639
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ff6f7c9-d9b1-4398-6e81-08d67c49c604
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR0201MB3513
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch set adds support for
- dt-binding docs for Xilinx ZynqMP AES driver
- Adds device tree node for ZynqMP SHA3 driver
- Adds communication layer support for aes in zynqmp.c
- Adds user space interface for ALG_SET_KEY_TYPE
- Adds Xilinx ZynqMP driver for AES Algorithm

Kalyani Akula (5):
  dt-bindings: crypto: Add bindings for ZynqMP AES driver
  ARM64: zynqmp: Add Xilinix AES node.
  firmware: xilinx: Add ZynqMP aes API for AES functionality
  crypto: Adds user space interface for ALG_SET_KEY_TYPE
  crypto: Add Xilinx AES driver

 .../devicetree/bindings/crypto/xlnx,zynqmp-aes.txt |  12 +
 arch/arm64/boot/dts/xilinx/zynqmp.dtsi             |   4 +
 crypto/af_alg.c                                    |   7 +
 crypto/algif_skcipher.c                            |   7 +
 crypto/blkcipher.c                                 |   9 +
 crypto/skcipher.c                                  |  18 ++
 drivers/crypto/Kconfig                             |  11 +
 drivers/crypto/Makefile                            |   1 +
 drivers/crypto/zynqmp-aes.c                        | 331 +++++++++++++++++++++
 drivers/firmware/xilinx/zynqmp.c                   |  24 ++
 include/crypto/if_alg.h                            |   2 +
 include/crypto/skcipher.h                          |  10 +
 include/linux/crypto.h                             |  12 +
 include/linux/firmware/xlnx-zynqmp.h               |   2 +
 include/uapi/linux/if_alg.h                        |   1 +
 15 files changed, 451 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/crypto/xlnx,zynqmp-aes.txt
 create mode 100644 drivers/crypto/zynqmp-aes.c

-- 
1.9.5

