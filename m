Return-Path: <SRS0=Pvhj=LO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3082C433F5
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 09:05:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8EE6E2083B
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 09:05:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="hvMTBjvu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8EE6E2083B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727833AbeHaNLa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Aug 2018 09:11:30 -0400
Received: from mail-eopbgr40051.outbound.protection.outlook.com ([40.107.4.51]:53088
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727334AbeHaNLa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Aug 2018 09:11:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Vn9q/nFhBobgbe0QBdNlauvTWWK1unTUFaHZyi/W+kk=;
 b=hvMTBjvulel8rpXbPPdv/dCD0wkJuGxrwghD7+VdNl6lqeAbSeRBKez7JXphfblrpWePWkSCTbxDxdEyPuqBC3m1tdpR+SPB5Eovw2dEZkrnlBOeUrmNCXmo0eBdPEBuMezm3R9gW8sVbq1f9duCGqRPUln67WrCUTEkciTtfeU=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=yogeshnarayan.gaur@nxp.com; 
Received: from idcbfarm.ap.freescale.net (14.143.30.134) by
 DB5PR04MB1032.eurprd04.prod.outlook.com (2a01:111:e400:510c::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1080.17; Fri, 31 Aug
 2018 09:04:50 +0000
From:   Yogesh Gaur <yogeshnarayan.gaur@nxp.com>
To:     linux-mtd@lists.infradead.org, boris.brezillon@bootlin.com,
        linux-spi@vger.kernel.org, marek.vasut@gmail.com
Cc:     computersforpeace@gmail.com, frieder.schrempf@exceet.de,
        linux-kernel@vger.kernel.org, david.wolfe@nxp.com,
        Yogesh Gaur <yogeshnarayan.gaur@nxp.com>
Subject: [PATCH 0/2] mtd: spi-nor: add entry for mt35xu512aba flash
Date:   Fri, 31 Aug 2018 14:33:00 +0530
Message-Id: <1535706182-26804-1-git-send-email-yogeshnarayan.gaur@nxp.com>
X-Mailer: git-send-email 1.9.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [14.143.30.134]
X-ClientProxiedBy: SG2PR06CA0128.apcprd06.prod.outlook.com
 (2603:1096:1:1d::30) To DB5PR04MB1032.eurprd04.prod.outlook.com
 (2a01:111:e400:510c::18)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c82191f2-c7fe-4ed4-bd81-08d60f20d10c
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(7168020)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:DB5PR04MB1032;
X-Microsoft-Exchange-Diagnostics: 1;DB5PR04MB1032;3:YWZUlLmtk0ZvXWfWcs3RuA6j0bltcoyly+iwWdiYplxU4Et/JiK0ML63WuWhCE3k53XVlH6NQTiGN5RDhyN05nl0tadohnfVXwN/wO/WeUytxLZNjiYrWgDYw1YQ+GnerosV9eGGWbRgXRZRqll3+TkFu238J3nXypF8U39Y1op8nPRZiPQB8wCvOV/+I5CIaK46BSiX8Kq9ymtW1UETELR4zAqEMFWnU5JqZioHeAmyjsBD5KTVx4JZ8FSdNSlN;25:LEOXK3tvM1VQqGSV/YqoLsmPfZpDnLg9eC30p7NMmdK2ZoDykOuR1KLOcQnk4u723ZMB81dOjAR4LhhYjmF//q2gCXEncIPwxUpi7+JY89ul2kw0GoZAfS6lsEyjjUQbm637WbPYZ+ld9TGssdHck+2CVtcrjLRZbDv292Rr+I/RtcHyahxiSPAvL8O2bq81W9HYXiv9m+cIj97hKkyr3ABDWNzi/gBMnEmrQw11tElammudp+DcCgvvafiz5QeOJXg+VCMwTe6deL3qNIBYKM1YJRXBiqIlS9mKDfC8ebIJjt2RWtWAWEm8X7fiujaP7NnKIct/032DHDtD2fURCw==;31:8/4PPCMokrdbSaLglQmGhIr1+YAFtZbxX4fkgHCOUAVdSHidEk3ZlB+m7FNJtRBeRLhFGRQMnKAKz58i0bZwCCKsJzoTL1Pre7hOU2D/VaGnQBUD1n0IfcZXfC2T+aqFNWzZgDYLS0RChIJ37Rl1Olf1254rWHhDTMsKc8XDaceyQTINCn88gKp61T46ku17JMEpGsDlmsolQCZ1CjTURTAFtdws2YZ5ghUu+5bn6Fo=
X-MS-TrafficTypeDiagnostic: DB5PR04MB1032:
X-Microsoft-Exchange-Diagnostics: 1;DB5PR04MB1032;20:KQ6tx8dFDY/h41a5XJwmCkK91Y+TLhSkhxORTZoujYAw5GHF8GH/NHnua1h14Bi8lPtvOYOaYiL5BRlfDLFlbSYTKIb7oIqk+rjyeJXBymWN4Ucwb4/FeHJB7MMKudvm/wUxo5Mx3NZ2sPHppid2rzJtmWZFrl/wRNGUWgh27MZraUCG0IJh8fa4A1NDHTvseWlWyL99SXm6tXT2tTYncpI2wpsQ07kBAkg/L6zYER951CjmSCPPpi6KYbG16yh7bHPboM5HOK+RLrBr/NL5iraf1OKY2BnsmZ1qSepdWfFOylOQapdCYwbOxeuYINLUaN//RRS87Hcw7e32CY2tC0jK73WL7AhFOAOvE+WT6KO6ojowRH5H2X3++elrJbkNIi4FfmpwcESjeaq23ykPzHWIk+4GVmdP0gSbGXZ84380CF8k9BK2WiiWAZmt8iCyRn8ddLiBbwDITblUjdnCvzmK1p3LPmcHoLnsaFFgzpXb8Bi8mHaqRn8YzURmmmEX;4:I4qrtJlC4mv3XLEs111uBhzUYfjesbYNJXIeCGOIF/bCFwJ0601ccS5rPs8cqrAzGbTO+2JrhQQ9zF8PbxQncbRheQegU1FOQ02T8MS9o3FP5JZZKQxU1aw8bRep+qVH1e5kW7/vmvs1+tEIBRaWoljD+c0qRCV6SWqQZstX1bll6DqQpP2YlFID23JEE7XDHsT7bUOqHA/0/YH68Jj3bUUUvyRfH9Lm153tj54/ryoTV/ogvXrqAjjqwT56MnelRd53+GAurCUvyDs9D8RsBg==
X-Microsoft-Antispam-PRVS: <DB5PR04MB103252AB5D6CA401627F897B990F0@DB5PR04MB1032.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(823301075)(10201501046)(3002001)(3231311)(944501410)(52105095)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(20161123558120)(20161123560045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(201708071742011)(7699016);SRVR:DB5PR04MB1032;BCL:0;PCL:0;RULEID:;SRVR:DB5PR04MB1032;
X-Forefront-PRVS: 07817FCC2D
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(39860400002)(136003)(376002)(346002)(396003)(366004)(199004)(189003)(316002)(6512007)(6116002)(55236004)(8936002)(52116002)(5660300001)(26005)(51416003)(6506007)(386003)(6666003)(50466002)(305945005)(7736002)(3846002)(2906002)(53936002)(81166006)(81156014)(5009440100003)(106356001)(8676002)(105586002)(48376002)(68736007)(478600001)(4326008)(47776003)(486006)(6486002)(476003)(86362001)(50226002)(66066001)(16586007)(16526019)(36756003)(39060400002)(956004)(186003)(2616005)(97736004)(25786009)(110426005);DIR:OUT;SFP:1101;SCL:1;SRVR:DB5PR04MB1032;H:idcbfarm.ap.freescale.net;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DB5PR04MB1032;23:Ay33CV3Q3oaLD4tJDLmW4Do+CbPgr4WHWkM4AaCgI?=
 =?us-ascii?Q?JmqQ2BurO3BfSMFfIWwnwDZJNJOkZ6HGgsQdVmGSHvFszCpsZWNkjZ0/dQEP?=
 =?us-ascii?Q?nsT29BbvOKi93nlE7h7lP6MdvTvGDTXKVmGyrTahdwG9IHcyhnqZwiuzZIEt?=
 =?us-ascii?Q?A4MThfmr/0jp0ejAEfL/1cBOAQ/gQ2Ed1D5x6/Qi0ImfO2CWFyQ2sY+XlqVZ?=
 =?us-ascii?Q?swqbY0ga71sqx8jXeDN5m3Kn4BSboTKy005Oe0+G+8d756pKAQfa1/s/Q5MW?=
 =?us-ascii?Q?5cSQZMf247rni0wXFKv+eIuANReubgeSpcEN3pj9lm9Z3lVLN1uCLWC405Ll?=
 =?us-ascii?Q?z8+G4MQKu0cKAm3vn36RHrZxeFihCu9NC69bm8IFEWrMPK9zPLhLItvqvCdx?=
 =?us-ascii?Q?K4UvcK/9rjpoyJAZ8Ik53bMrFGgcqaU3b9dFA3mPuI4hCCAG3mRH59oilIP8?=
 =?us-ascii?Q?CKeF30fKGJZ3wov7H02HRTLTv5qR2ZL5vI10Z9a8NfgN4No+MX8jf1cJEkga?=
 =?us-ascii?Q?IJ6JTonkLiorGPK0f5BKuDEzrzkrXgFThEcy28BbAgONoQplhDlMoqhstpUA?=
 =?us-ascii?Q?qMdHEOKwZnsmk6qtY5WkylfKqlHi0lSTR7/Q/sLwHqykfBbGXA7cUP4Hje+M?=
 =?us-ascii?Q?Pju7ro2mnJvTF/sWkLa++fObGzFPZiwWHC2Z7/DfPup+/rn1teqvPEFYTB+Z?=
 =?us-ascii?Q?JBDT4NHES7mSvdH3Mvx1CouLi4ydB73l0wYw78VCjWwYOI3MonbSO/4UtcBU?=
 =?us-ascii?Q?8H6oUoLp7+3Bzfq9SKWFsjo6ZuAkXrl5HkbJUg7CaHjJgM3u9IPF4zY6Od6F?=
 =?us-ascii?Q?dmL/QSArDc7yph0obXazO79jWCd/DDKhtWR/Exwtk1Qz98LMgutlO5Jcn8rD?=
 =?us-ascii?Q?nUhcQOODIZFEKhDy8lLP0RPOkcKUBnHcjMlrKH/SyrWLVuFGagaPcNWOTYlA?=
 =?us-ascii?Q?nc/277AJF6ZK+4RwNrBzRyS1xnqTvqxlyOV6mTEgJWqSFtl0tFzNRFaQMZnV?=
 =?us-ascii?Q?L/mJh7Mju+u4UABMS8JnqxA1kMzAFGaGZViyhPi9fnYfCeIaxA+nqtymKM97?=
 =?us-ascii?Q?hftvKPvma/k8vWWNi07p2gxZyy7EDdwMYsEpxfr62w3vgI0yxAFUM27nAP9c?=
 =?us-ascii?Q?VWUUQ5IwNoOqRWzuJw9aKlOrjC2j2jn/lSNad6+ZZ4LsVuFGcnL1kvtpdWlt?=
 =?us-ascii?Q?L/LtRZVPmU7liDPGWzwJeoPxANTQqRa1ySa?=
X-Microsoft-Antispam-Message-Info: vfPFb8SUPI6WE7Hq7o4T/zhE48MREtLMD/0pRV0vkgbVkWkmAWXGPqEDQtbStO8aJZHOX78S0LBxKDScGG2PW/V4XrOUW7FKMQEvwksRYJ1E+lsgdr10+9HK4KfsUZb2w3i8a8YTNISbgdf04bW0jXNRQmHzrfj5ax+OQAoVP4VBTLUvYPGDK4455YbquCnEvU81rMQX4k3Ej5uFQbwh+zypVl1Zm9E7tOXLEAJ90xeAqFQislxRn5PJewi5vbBBoB3jXwL2oaySAXrSugzHriE0GEv/SDvDPai6fzTZSZlxTSN128K2m7gWY6uyizsvxs5R4ih0FbIgiu82BTXK2nvmRARmpEwzyMHRgYaqngU=
X-Microsoft-Exchange-Diagnostics: 1;DB5PR04MB1032;6:YjK9J2PHDoQjVfUxUYrxqVLI9naYTtFeiI83Q2/6YcGC7rr/zOO7nNU8dhW/j2MFRRw3/E9ktjN8Givb46OtL30xCWQuLpmqzNpREYnXxzVTBhBDpSo1j0WqBhHOn35MKVn9D3jYxpPM9XoiTa5OI77OTDd11UrQgwKTo6hQrf+6nsWJyW8RYyjF7z1DQGFDCoX9A9ZwWOFI89X8MxMjHbew4G0mRx+GL/TRuzvZt+Hj6ijCldocGBfc3kiKbiti3NwEIxdBuGnff+xIW7v2fqGaCDO+pyxOtQzIMNNgRaVZbiUwxeFq0P/04a5QM/RL4xyXm3+o8jRu4lDVng60O3UUERPD7xN2fXUxwgviSdhuye1GvmrVFFZmtAvXymgKnIyrqOY48QUMPAloGM8ZtOkH9aUHhwMx1ZPnBUILNZyYP1dfOnb3i30rS1zUNcgXdm3dOWmvQstXV6lNkCAm9w==;5:f+1HmyGQtVGosNg7ccOzNhvgA2FYR9yYhHo0a4SNlk9i5tsdrJOTCBqyHacP+meCiUK5p9q/tbGn1uHzkrTXMqD4FL4mytSjy5OU3H0VCrdNAIdPeq5Vyo+0+SbwexOd0ZIfoJe2qyg0Nbjbpt5JS2UN2Mpa4sP13ZQm7OYC/6o=;7:6Cxgc7NCvx+Abt9UXwuiEZrLF10F861hSxljLehgSQl3uyLQYE+QzLXjnE+zcXIHeM5IjrRjpWMbTl3l0wYUdzxmTT/rhzZyIoQorxefau0hT0jgsQMzHjlSEJxotWHu/ZWC73LEag8FTti6GX2dbUzz8l2ng66OPZYeKuJ/MpC4wOJRaxWOis+qXTOcx5XG/d8Cc1gFqo6nDwBP0ek4n0wGKAb/ss9h+xVed3WR/DFpuC7u5fV+l4Frk5pOOVhN
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2018 09:04:50.7451
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c82191f2-c7fe-4ed4-bd81-08d60f20d10c
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB5PR04MB1032
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add MFR_ID information, 0x002C, related to the Micron flash.
Currently, MFR_ID 0x0020 is being specified as Micron flash ID but
these are actually CFI ID of STMicro flashes.

Rename SNOR_MFR_MICRON to SNOR_MFR_ST and add entry for
SNOR_MFR_MICRON having CFI ID value of Micron flash.
Add entry of mt35xu512aba flash in spi_nor_ids table.

Yogesh Gaur (2):
  mtd: spi-nor: add macros related to MICRON flash
  mtd: spi-nor: add entry for mt35xu512aba flash

 drivers/mtd/spi-nor/spi-nor.c | 12 +++++++++---
 include/linux/mtd/cfi.h       |  1 +
 include/linux/mtd/spi-nor.h   |  3 ++-
 3 files changed, 12 insertions(+), 4 deletions(-)

-- 
1.9.1

