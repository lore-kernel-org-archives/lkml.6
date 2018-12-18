Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF729C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 16:11:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8160F218A1
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 16:11:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b="f5jY6NOA";
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="dBH+WSlq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727127AbeLRQLP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 11:11:15 -0500
Received: from mx0a-0014ca01.pphosted.com ([208.84.65.235]:40044 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726652AbeLRQLO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 11:11:14 -0500
Received: from pps.filterd (m0042385.ppops.net [127.0.0.1])
        by mx0a-0014ca01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id wBIG4Yqc019444;
        Tue, 18 Dec 2018 08:11:07 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=proofpoint;
 bh=FT+obcoA5gXAMtZljP8LeROtciWD5tUwAILGhwKHqoI=;
 b=f5jY6NOAc9CimAf9rmHnIyh8An2qJUr++hb4kFaTjwUcLq5l4RKcd5NTEb9QfizC2ZpP
 JlaVZiJ90bi89LtObjopkakpQIsl6PgrjRFFb8AZfN57qCdLCLh0/eK9nPg8eV6sIiVm
 779Q00zKiUFrkzobnecsHHjC8qmuUaumKsj0HewLbgewEEXO09mBk1nCkjVoDug1E/xm
 yfFV2WbcBOzQgPKhWa72Ds7Hsli182UzChNZ0AcuuH7zXS2WmrNi1uGAs0ZQ+NfKB8ra
 ArX6k81Yv5No+5L+FATdgzJgdqZluXYzAUSxFoUNOfTNprxSaifqBEFRTM4EfmLhICKu fg== 
Authentication-Results: cadence.com;
        spf=pass smtp.mailfrom=jank@cadence.com
Received: from nam03-dm3-obe.outbound.protection.outlook.com (mail-dm3nam03lp2058.outbound.protection.outlook.com [104.47.41.58])
        by mx0a-0014ca01.pphosted.com with ESMTP id 2pdbx6nacd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Tue, 18 Dec 2018 08:11:04 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FT+obcoA5gXAMtZljP8LeROtciWD5tUwAILGhwKHqoI=;
 b=dBH+WSlq3wQO9rvIaTqWuP/mawJ60Qsql+7FCaENzr8JHyjj316JF8iEsRnp5hS5vzS1td6iCp0s9Mgm6m034b7DXHfI0TxRj/lyT52V6VpPryGJeSTu1u8IlyQQp6JFU4INfVxzMYjjN+Y7MVA3Ns8ZECIMPZMk5fLJ45rZPOM=
Received: from DM5PR07CA0092.namprd07.prod.outlook.com (2603:10b6:4:ae::21) by
 SN4PR0701MB3726.namprd07.prod.outlook.com (2603:10b6:803:4d::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1425.20; Tue, 18 Dec
 2018 16:11:01 +0000
Received: from DM3NAM05FT035.eop-nam05.prod.protection.outlook.com
 (2a01:111:f400:7e51::206) by DM5PR07CA0092.outlook.office365.com
 (2603:10b6:4:ae::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1446.17 via Frontend
 Transport; Tue, 18 Dec 2018 16:11:01 +0000
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 cadence.com discourages use of 199.43.4.28 as permitted sender)
Received: from rmmaillnx1.cadence.com (199.43.4.28) by
 DM3NAM05FT035.mail.protection.outlook.com (10.152.98.148) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1446.5 via Frontend Transport; Tue, 18 Dec 2018 16:11:00 +0000
Received: from maileu3.global.cadence.com (maileu3.cadence.com [10.160.88.99])
        by rmmaillnx1.cadence.com (8.14.4/8.14.4) with ESMTP id wBIGAt4B031456
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Tue, 18 Dec 2018 11:10:59 -0500
X-CrossPremisesHeadersFilteredBySendConnector: maileu3.global.cadence.com
Received: from maileu3.global.cadence.com (10.160.88.99) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3; Tue, 18 Dec 2018 17:10:57 +0100
Received: from lvloginb.cadence.com (10.165.177.11) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Tue, 18 Dec 2018 17:10:56 +0100
Received: from lvloginb.cadence.com (localhost [127.0.0.1])
        by lvloginb.cadence.com (8.14.4/8.14.4) with ESMTP id wBIGAsjV016805;
        Tue, 18 Dec 2018 16:10:54 GMT
Received: (from jank@localhost)
        by lvloginb.cadence.com (8.14.4/8.14.4/Submit) id wBIGAntF016663;
        Tue, 18 Dec 2018 16:10:49 GMT
From:   Jan Kotas <jank@cadence.com>
To:     <linus.walleij@linaro.org>, <bgolaszewski@baylibre.com>,
        <robh+dt@kernel.org>, <mark.rutland@arm.com>
CC:     <linux-gpio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Jan Kotas <jank@cadence.com>
Subject: [PATCH v3 0/2] gpio: Add a driver for Cadence GPIO controller
Date:   Tue, 18 Dec 2018 16:10:40 +0000
Message-ID: <20181218161042.16366-1-jank@cadence.com>
X-Mailer: git-send-email 2.15.0
MIME-Version: 1.0
Content-Type: text/plain
X-OrganizationHeadersPreserved: maileu3.global.cadence.com
X-EOPAttributedMessage: 0
X-Forefront-Antispam-Report: CIP:199.43.4.28;IPV:CAL;SCL:-1;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(396003)(346002)(376002)(136003)(39860400002)(2980300002)(189003)(199004)(36092001)(42186006)(110136005)(316002)(126002)(486006)(54906003)(16586007)(69596002)(426003)(2616005)(14444005)(476003)(5660300001)(2906002)(36756003)(47776003)(4326008)(305945005)(106466001)(105596002)(107886003)(97736004)(68736007)(53936002)(81156014)(86362001)(50466002)(186003)(356004)(6666004)(8676002)(26826003)(50226002)(87636003)(81166006)(26005)(1076003)(336012)(51416003)(478600001)(48376002)(8936002);DIR:OUT;SFP:1101;SCL:1;SRVR:SN4PR0701MB3726;H:rmmaillnx1.cadence.com;FPR:;SPF:SoftFail;LANG:en;PTR:InfoDomainNonexistent;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: 1;DM3NAM05FT035;1:2Yl7WTCrb4BIunEn+cSPGuQ31dOcxiD+cpHZKoq7hMMEDB9HfUz9oXZWUX4bAfyCKmeV6O5ciyW+1Zj49QASqWm+sz+GP/jSai0z0R79IgQqqnpTl+Eu5V40KtK93n2C
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bc7425d3-9efe-4406-4137-08d66503673f
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(2017052603328)(7153060);SRVR:SN4PR0701MB3726;
X-Microsoft-Exchange-Diagnostics: 1;SN4PR0701MB3726;3:b/rVkitX9Nj+QLoBXW6i/w2oA2bI2LegLvK7WAWUjTqrme9FsKJbHYvMzwZoJ4KjrOWF9+VT410l8oaX/yAtgYMiGP0y8IFnftaDvUCuGWPp5t6J7bqUG/2Gin1NJB6U6sD9FtS1jZcKnoeHMCj9+d8ChxZBOEjFL/zG0yj2JUfRrm+u7ok18o6lHakYefvknBoWWRgQahTr1+5tNOndpwjuOA2luluSAwJQEMx/bapwHA10tihG6SWX2QIMLRJ82IKx6FVwUOwsVClR+M6SJW7FV253F9LZm+3uDT/URg/D7c1HQIitf9ntP/Dlq3sseSjBLbLaAMGDA+dwL0/UvA==;25:1E4c9Ci3wm1UP7A2GMYbYJ8uXgnAUrSaM/sqTJIpAbA7lkXzoduAkui8YzeyBXh/m05x7Qsx3tEMbjNSn5OpTW1pkHKD3O8PA17Rvmc+ewh9o0GdwY+To7E8i5siN8QA8LI4qUyLagphYhi0zMa0/dGbU3T4HuFfWqfv09vg8aJ+O0v5eiCafhLUM21i9vupqcjaejSmN9+GEI29G92ddWtUkoR4ZC5sfTqJB/iRZ13op+Xs+lVb7EXB6lclBRTqrMLw0G8TfcFH2jCrKEWZnh4jBPBeBHUO3nK8X+Oece40pGHcHHHefmFY/y3CXiKCcGdgVLb2ozxj716GiQm4xQ==;31:aCLZoxxP5/F6Y9DAjzzdfZNnRgMO5GtTG3yxvBLq4nXYxo8iqxB0MvlwK5Hyw4O+Jo0tHKbiXpVh4ceilr5rOFwr2VU3Pk1N/qwxunXxe4wkxKoDufdoU2pqRCkjXdEQIKObr4PSeypAf0uSXFLSCkjALyZb8jR+stryBDH8a9LOiZGXvsv1dGoEvBktcirWhX8gsO/134kf6bqsBgl/plZXwmRdLvcv2oZiqZlON20=
X-MS-TrafficTypeDiagnostic: SN4PR0701MB3726:
X-Microsoft-Exchange-Diagnostics: 1;SN4PR0701MB3726;20:SkhQQURUfpv37Li05T+ZrXSCaD0ShB7nR2atrtNHA+JWcuKZCEYqOajcdxJ9NAFcWqvm47FMJ97ANxbGq+w139Hdeq5OC8+Y6GINdceliXUBPFIQuP2ZGIOAkUvTofAZ90MJ5Gpw6MegSLExP+V44F6uzA2q08p7FGnrbxC1TtbWQ+aYZ4zl6ZLhceWL25Ib0vKMtySbyl52IWu/jOlg+3SN6Lrz1LKVC2JviPb86LvH+Co3oo4+hn+eiRXlibk0Xs2L16R9ynf1fNzbwRWm2YIaZRhyNsqtaM52T/Jrc8EHWdZH89APITqIpPspt8nvSWnzvN5Mk/ELMZWjxqjCsbQmMnsVosWRd7MMsS1aL3vLo3TMPWkMGzg/d1GDsgoL01nOJnG2RJTMNSkFqF2q6IzouE5SWu1Xp8HoDL/c+lXTFR7LpGA/6wq5/h4VhMfraAV7N4EIE9FEOSzl4J8hWspEyEKuXwNvUREnytg6luwAzBLfO/FtjeQmoYMsL0yh;4:HIM5nJhKNHBU6GGc5uX9xTznEo2ouMRkBa6BxErSPNZ5U34utoJ6d8yBY1GmjcxWTNqtkvzxzAXEXAkSyd8V5HeSGLSj0wEqwXiaSLbiCBmKE3MnAjWXkhG83uwasPOCKyXwelxfkctXdDMgvklYJeVp+ShsBmNLZZSTzgQhVwoOVxULS+cqdykFdxMs0aWq4vvs5ga5iB0YBnvxhUgx9p5jIo/X0UayRECksk7ipc8RZrO4+QjMpNiYGE06TiOIVqACQd7+ekcSx++OLZzeFQ==
X-Microsoft-Antispam-PRVS: <SN4PR0701MB3726157D28D6D6A5DFCCD73CD0BD0@SN4PR0701MB3726.namprd07.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(3230021)(999002)(5005020)(6040522)(2401047)(8121501046)(3231475)(944501520)(52105112)(93006095)(93003095)(10201501046)(3002001)(148016)(149066)(150057)(6041310)(20161123562045)(20161123560045)(20161123564045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991095);SRVR:SN4PR0701MB3726;BCL:0;PCL:0;RULEID:;SRVR:SN4PR0701MB3726;
X-Forefront-PRVS: 08902E536D
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;SN4PR0701MB3726;23:zxbl/LGk0Bx9E4hgC17Gl/Vlh2PAqiJQWMF9WE5?=
 =?us-ascii?Q?MEmv0/toqJXFDVohB5n2VdrD1h82+YbysHPBTuBRlcPUkuTh8onh4Ro1OXss?=
 =?us-ascii?Q?eas+kmhgl22Ixp8gpDZbeaowuD4VzXI/mxj0GLTZiQ6iUuLFFkCy2QtayK7c?=
 =?us-ascii?Q?6GyB6FhzFDmjpUV0LIydrOypllPiodLAxPJPpvulrAF4aiSNBr04mSEhKkSa?=
 =?us-ascii?Q?WVu1QvBozcSl2EAS00a4iaHSUYvZH+hJ43TxKqrKqfUE4nd2BZbgq07EHikW?=
 =?us-ascii?Q?OP+pbbQG4kEwKpHydx3cmibnzXDlEbGytJZj/cmgiwQyRqnnTi3xNp8z9stL?=
 =?us-ascii?Q?+U6tjalhrY1HySP9GT7UXYIitk8Kj0mbJl8GdB/Ia+CnG1hj/12R1dm/gF//?=
 =?us-ascii?Q?uzpyFw4RkKb9DJTqPKSTZg9PEYIthf9AMH92hEapNcus1BDIUr3hYx9jAPeb?=
 =?us-ascii?Q?QvAB/yRrqmEm+6H70Gx0tYenkhnma3AF0AWGDIuqBgC6UGrItl7/c+Yc7kTA?=
 =?us-ascii?Q?5dUpMneX68YGdSmqxNBcdFruMSDofyPQQ9ZupLdJjS5Svy49BYOfQWFsNfpO?=
 =?us-ascii?Q?igeNTioKC6+A45YD3ggj0CSVYji7OrmeZWvKIStQVypb5ZOkzVUbSZ0aS3Mu?=
 =?us-ascii?Q?wOPXufojh9V6gwvPj+emcy7ec1oOL+WBZny4qGgmCU6xo4ivUhcLl84Na960?=
 =?us-ascii?Q?TNJ4qDoRf7eeeMnzCZfhBQOomUkvPP+5+5ifRTWoycVv3hOppbMInvdhWaMD?=
 =?us-ascii?Q?hcjqUKquK45zHJi4iZR6IE0zKYYrSWF4OA8AlVwTTvlKIRjKt4y6lFEwY5kw?=
 =?us-ascii?Q?D5fJLQTwIiwPywfYMONpJBd9/w7C7GlV1kbx/QVg40xLAH9ObumSqfDEpPoP?=
 =?us-ascii?Q?51xlG15JGmXwozvMR6cslz5GwENVfei7TfrnP6DTL97g920yad/HPrmAdX2Q?=
 =?us-ascii?Q?44kmMEOIeaofNyyhrDEaaZGvtor6cNhNJqwLCrRP4Y50kyvUNEjTvN3JX2WQ?=
 =?us-ascii?Q?AfC+pf5iI7g9q8wcL5lEu2ITsRaLwRryMGymvPCziejprOlykLbmBEI0JQ7k?=
 =?us-ascii?Q?dHoYtanXuhKjzEBshAsOzjE3bRc9IUnEysv048/8J35D2Uc8mh5nIaLavaWu?=
 =?us-ascii?Q?9B/R3VHt4uO41mpoya4kjFnV2+dR4qJvi?=
X-Microsoft-Antispam-Message-Info: WIwLoxft6f7hrdmFg/gf66jqsMpMHqQGo+0rSwRmX46LKchSfKAOpCsZNCaEzFuOLivf7rpPns3yRxrFr5+fh7rFIxLAlN3pS5XS+dBw9/AzpCWpoiJK5STv2C2FzVQ8k7nLWKRlNWMV3M+OH/kQqpD1i0cuQfiNeipjgnwAnuEDEUHJZNxAH5JXE50yfVpp7BxFTGAZxSsUp5V0zIA9UINx6MmDKuljhLU6fBPco767EZ5QC+9nJt+miYYu/UfwlSA5H0a6C4McLTJl7Dkqj/GSNjZUN7PRpfiSGL0OhsOVuC5+hqQifF7Era2CMFy0
X-Microsoft-Exchange-Diagnostics: 1;SN4PR0701MB3726;6:zJJzrUB6AP61AFAVvyxemNm4FU68LolKWaHIGTBckrw9GMk+er+v6VrSrnG0toHV3QF+lY0eoRLFPfP1DR1EahhsoU9K8dEVepLwM4KdU1Wm8GyArNl9UMubhpK9sJGDzI0TD75I0iWSzP8DBou8hMYq7nkRy4ntfG7YMFxVeixAdPpZQoU0K0t1KEE7JmQjbZbiy2ETIs2hCIpwVK6/4y7zOY2OgXBswnZY4r74xwYPkvhkh432slK1E64hayC54MKbrS/WBNP3ZnTdZJ+aPJXZZPDOJzJL4SDqf5IuGnH0OvoeTw2wapOnowevJOMtEiWW2MLsjAn5HS7TA427ZLVPPjyXjaV1KrX3+kLTxqWAk/OTg5A2bmgAVqbD40iTKhEjzoIoVgbU0MyNtC/GeGEvEKryMrJE0q3fW+Ssv+yHlRq0rrwZKEd7/JxPsKGI2vsHZW4KOXmoubKv0BqYnA==;5:HLHXxrdIPXpLDZpBhUXmab4ImueXznhzcq/QyxOkDjINzLDkXpcYIL/UBDLsbJsisu0CXdF9geTSJJnRPWoAtAn4g4CBbbrCoxiJa/10Fgsz+tb+C9yBjdv5objhsFsl3ythnDOsIQShonyAOGvA7TrpWbXihTJzM0Cn7TvoNOY=;7:29klmrjpdFHUAsuptWZdfd61xppK1HKyf2xRmYJuTM2nmSBN+Xc7jYzx/PYNwNEumFmHIaOt9MjBWweusRipLRMKL/9uHGid/tKgQoxwu8eL7nl8WeTHehvbbC1VjxLlWfqi4Mq1qTtBON0RsWzzGg==
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;SN4PR0701MB3726;20:mAGKQ/wy9kV3zU/GwPbF6Q9U8xNB8w1q01MLuxF9G6me8gputwAQNmJ2cd6gfL+Tn0GIlS9Da4MdhEXiL8rHrTM1SivkaHUXz6W0wZ27Xns8OPNEVRDHUEGzV2Xyp7/bSnHepH8MWVFn2XlRB9Qyhf4MNCzWxS1T8TuorsXrBAIciH0HSA3wms5XHzU19U1Xqh3HA9DaqP0lHMt+vqINwmjItY1GhomXZN2l4BBNeP1B0G7Wbc8xB5CZJEOztwyE
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Dec 2018 16:11:00.6790
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bc7425d3-9efe-4406-4137-08d66503673f
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[199.43.4.28];Helo=[rmmaillnx1.cadence.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR0701MB3726
X-Proofpoint-SPF-Result: pass
X-Proofpoint-SPF-Record: v=spf1 include:_spf.salesforce.com include:mktomail.com
 include:spf-0014ca01.pphosted.com include:spf.protection.outlook.com
 include:auth.msgapp.com include:spf.mandrillapp.com ~all
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-12-18_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0
 priorityscore=1501 malwarescore=0 suspectscore=2 phishscore=0 bulkscore=0
 spamscore=0 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=655 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1812180135
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset adds a driver support for Cadence GPIO controller.

Number of supported lines is configurable.
The driver initializes all pins as inputs in probe().
Currently it only supports level-sensitive interrupts.

The interrupts controller was tested with I2C and SPI IPs
acting as interrupt sources.

Changes since V2:
	Added spinlocks in request, free and irq_set_type functions.

Changes since V1:
	Switched to generic GPIO infrastructure.
	Redesigned interrupts, now uses chained irqchip.
	Drop support for edge-sensitive interrupts.
	Restore bypass settings at unexport/remove.

Jan Kotas (2):
  dt-bindings: gpio: Add bindings for Cadence GPIO
  gpio: Add Cadence GPIO driver

 .../devicetree/bindings/gpio/cdns,gpio.txt         |  44 ++++
 drivers/gpio/Kconfig                               |   8 +
 drivers/gpio/Makefile                              |   1 +
 drivers/gpio/gpio-cadence.c                        | 291 +++++++++++++++++++++
 4 files changed, 344 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/gpio/cdns,gpio.txt
 create mode 100644 drivers/gpio/gpio-cadence.c

-- 
2.15.0

