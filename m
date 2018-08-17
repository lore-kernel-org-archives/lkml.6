Return-Path: <SRS0=dgVt=LA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10DA3C4321D
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 13:38:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 69722208E6
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 13:38:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="HSJxJ4bk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 69722208E6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727420AbeHQQlg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Aug 2018 12:41:36 -0400
Received: from mail-sn1nam02on0079.outbound.protection.outlook.com ([104.47.36.79]:1106
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725879AbeHQQlg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Aug 2018 12:41:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n4K+TGLA9qmWS2rxDd+DU3QSGOSbbY4Bo7DZVRWgqvg=;
 b=HSJxJ4bkGy9MhnwjC2h9zoP/t0Zbw3tLZF5bCYAXaNhKBLPLMIvSheZgZ+m2w2pTZQZOM6tT7p9PM6GRr+KJ9ebxza7V8sebVDYASZr6s8tuhxeqa745EftaLjk5hzGyedFgAacjFNPZYculi4FTVHghXnzkhxWXFRna/veFwfg=
Received: from BYAPR02CA0056.namprd02.prod.outlook.com (2603:10b6:a03:54::33)
 by BYAPR02MB4453.namprd02.prod.outlook.com (2603:10b6:a03:57::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1038.25; Fri, 17 Aug
 2018 13:19:56 +0000
Received: from BL2NAM02FT041.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e46::206) by BYAPR02CA0056.outlook.office365.com
 (2603:10b6:a03:54::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1059.20 via Frontend
 Transport; Fri, 17 Aug 2018 13:19:56 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 BL2NAM02FT041.mail.protection.outlook.com (10.152.77.122) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1059.14
 via Frontend Transport; Fri, 17 Aug 2018 13:19:55 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66] helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.63)
        (envelope-from <naga.sureshkumar.relli@xilinx.com>)
        id 1fqefT-0004h1-4I; Fri, 17 Aug 2018 06:19:55 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <naga.sureshkumar.relli@xilinx.com>)
        id 1fqefO-00064B-4B; Fri, 17 Aug 2018 06:19:50 -0700
Received: from xsj-pvapsmtp01 (smtp3.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp1.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id w7HDJgnj005739;
        Fri, 17 Aug 2018 06:19:42 -0700
Received: from [172.23.37.108] (helo=xhdnagasure40.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <naga.sureshkumar.relli@xilinx.com>)
        id 1fqefE-00060p-UQ; Fri, 17 Aug 2018 06:19:41 -0700
From:   Naga Sureshkumar Relli <naga.sureshkumar.relli@xilinx.com>
To:     <boris.brezillon@bootlin.com>, <miquel.raynal@bootlin.com>,
        <richard@nod.at>, <dwmw2@infradead.org>,
        <computersforpeace@gmail.com>, <marek.vasut@gmail.com>,
        <kyungmin.park@samsung.com>, <absahu@codeaurora.org>,
        <peterpandong@micron.com>, <frieder.schrempf@exceet.de>
CC:     <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <michals@xilinx.com>, <nagasureshkumarrelli@gmail.com>,
        Naga Sureshkumar Relli <naga.sureshkumar.relli@xilinx.com>
Subject: [LINUX PATCH v10 2/2] mtd: rawnand: arasan: Add support for Arasan NAND Flash Controller
Date:   Fri, 17 Aug 2018 18:49:24 +0530
Message-ID: <1534511964-20342-3-git-send-email-naga.sureshkumar.relli@xilinx.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1534511964-20342-1-git-send-email-naga.sureshkumar.relli@xilinx.com>
References: <1534511964-20342-1-git-send-email-naga.sureshkumar.relli@xilinx.com>
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(39860400002)(136003)(396003)(376002)(346002)(2980300002)(438002)(199004)(189003)(305945005)(48376002)(107886003)(478600001)(5660300001)(53946003)(63266004)(81156014)(81166006)(50466002)(110136005)(54906003)(316002)(16586007)(106002)(51416003)(7696005)(76176011)(2906002)(106466001)(36756003)(7416002)(2201001)(426003)(6666003)(356003)(575784001)(77096007)(186003)(14444005)(8936002)(217873002)(26005)(50226002)(486006)(336012)(5024004)(446003)(8676002)(39060400002)(476003)(126002)(4326008)(2616005)(47776003)(9786002)(11346002)(36386004)(921003)(107986001)(1121003)(579004);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR02MB4453;H:xsj-pvapsmtpgw01;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-83.xilinx.com;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: 1;BL2NAM02FT041;1:KvrqKWEnx2YfA7CVvP8hITZuqDQPxeTtZdVaWNCkgzxeAHTmrU6aA3mkY9EGtL2dte1yA6gOAqs1WFTTAhg0zsYpnnx4xo9qbZYPoy85+eIfEubT6/ziqf1jL5mZXSok
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5f576191-0632-4014-78e1-08d604442008
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4608076)(2017052603328)(7153060);SRVR:BYAPR02MB4453;
X-Microsoft-Exchange-Diagnostics: 1;BYAPR02MB4453;3:Unl3Rggs7IfiQQ9c1cxqoiGJjAfXb1aBqKmeIIt8dNVnk5kU3U1IwryNNPBtDOV6A00UIFIWnQ03KKNwYUbiflPtbTTF7V1IPMh1H/FlwXWefXPFSX7//lmtrrWC4vXnf6dtk14k/jinrsxq2+ngy4lRhlMxMfyjPB8LcDUzZtQCNQ4MxQKaxPmb3Fknfw6aZBYCKNXnPfw98dbOmJgUJdW97dnxGSHLx3k+AokJDLRWXeZxexDNZATFAdioolJf3rQi0nYD64CU1RMUtfgWe2JTbo2+igPYZteC7phoxAuNXXhgnHzw97zLimnclgnKQnHIsL/47c9yQ+DNKMaf3mxVCrM7M3uwK7tEUNR2i9k=;25:0ZbAjsep/brwKUZXNLTWxiaQkch7HxsBu9jdL0zcOcmkylAQc9XcC6ESVZBMPOQ1S2ZUwzVLJl89iKgx9kmUKO66L6RnhOAk8Nrl9vaAM3wLSYxzyh63+KWhQQN841yDjjoDp3lDkGLoJKSqTOyYg9Q4Gy1KQ3uYCxCc+wm+NWpPl/bOQ5KS0nzac5XB637kJ2Y5mnp9rBRV7p8QcgSoDpKaWueq8SA8zZugopFU1DGYQY8BFdkvPptTWElJbkBpEiRnJlCk5tu0la1gBBJYRd5mpag1k0FF7fSbIgIxi0rTaksj0+ntiagHrjF3HatHonaA/r0aW2WQJBZeWXP1vQ==
X-MS-TrafficTypeDiagnostic: BYAPR02MB4453:
X-Microsoft-Exchange-Diagnostics: 1;BYAPR02MB4453;31:aeJUslT/49cyZpjr6iHtMA5kRpr5d7SnLLaGxPLW6JvFJC5dA2aCpFl7VXswR1NDux3sCnhIY6agQkj4deUC+pv9yHdPBeLlQ5fPesGqVcRvxp8ybE+sFeo0tELqoD0PdGISf5A9MkVVoMjLC7TKYQE+Kl6V6oUKW60Lz6zJfbsEytDS9AW70zmeNefbhE2scI0yxBZLE0dJEsjJW/5AUYAIeOvkqi/j4zG5f/kuqV8=;20:IgK2ka1ERhwQZv+qSFaFmlPGdk1Ec00Z3fBppL4S+B448NoXgkKMrhuIA/SLJijaTGAgoqdvbj9wqF2nsNEz3XvFjBQqfGqqrHTNx0HQhipY/6OlB/wDeup5zngTe0OxQd/2clXd+FAF3hNCe9zfdwBPrjVlHeEXtKFCbnMzrdEWJ8+P1oO1yHyo47M3g/FeTcIeYvfi0xpdPhBEA0UgJ2QgrlxnfThXb6xlZaLphc8jORvzMRMdC5Y5kdAfhUaizOBcnJ/5q4MRFcCl2TecDh5HhHnGY9KM1fKcKkaBHE+79zE2jpBdoF7f8siZUgGmKC7ohGu/E/pZ5NAMaZkgjjz4OlWF8BYetlbfyKiBMCl6a2prmoDRhOCgz95ornUCZpOhk70Rt+nz+JG8ubDuoBBAlNXMJF6kRYiL4y8h+sfjV9hq7zNb2E7nHepADdxSYuwwQrXKLHPMagUy9Da1+inN8CGU6AOrczX4XwwM5CU3Yf3hi+tB11WcbeAYdfte
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <BYAPR02MB44536C9A210C20545CCF57F4AF3D0@BYAPR02MB4453.namprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(192813158149592)(211171220733660);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93004095)(10201501046)(3231311)(944501410)(52105095)(3002001)(6055026)(149027)(150027)(6041310)(20161123558120)(20161123562045)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699016);SRVR:BYAPR02MB4453;BCL:0;PCL:0;RULEID:;SRVR:BYAPR02MB4453;
X-Microsoft-Exchange-Diagnostics: 1;BYAPR02MB4453;4:QqF4QW3ZyPad0MjxLEf1C/4CS2JH0yoF74m1ks1JNJpXwzlDfkfPHCdnGZ7OZ2/p9uFuW71/23dNHwDIWxcgJ4R8IR93WQ7g5GAfLDzxoJjKTF5mGqXuzr3l6N+qQSyxKqpmgokFOQbQl8YbM1WegPO8ZCypFhg2FoL8qsEdnEQkA65RrmS+REkOBremA8j226mxTtlTOgWsqPoFzQHSgL9P/KblSTc2o0I8EInvlsyQWRK6vHnYrq90WmMDbTlAxe5yL77Zf5aHEJFq5iYouhr6rx2OHPK40EYKiViyz4ed28NP6aRFze+3W6WKBO7Fp6litZ9vggVP4UBMQLuCLGVXZbmC307ykWSm9xRf11E=
X-Forefront-PRVS: 076777155F
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BYAPR02MB4453;23:+2KG5VGJpAvvVnwKKJiM+CiT5vyHsM6TVBEPfieX0?=
 =?us-ascii?Q?7o/+NSQsdMXQc4Jf69CuY93GAWEm/QnX1bK2ohTlThZlGbuYy7M2NcraTlfU?=
 =?us-ascii?Q?L8huL/wJ17OXL/k1b45boytGJCKUVs0vfPMp4BdSKkLkjPbSnu6KBc9r7GCe?=
 =?us-ascii?Q?88Q6cuDJ1DVkPqo+bwHz2y4Sv4bwY/bMm2H/VhnYEcGSJ5lbn3+ofv7PSMAm?=
 =?us-ascii?Q?AoMXL3IA9x2fnnAdpBkg6ldhkwl37PpEXKjFlmaN9w9bi9sYGQa/+DqAjDlX?=
 =?us-ascii?Q?i2gR7AwR9IAOiNnFc3C0APvu62ufvJ/yUpeTN46e4DsMg01dnqpZzI5EQQj6?=
 =?us-ascii?Q?sb6tTdV//OQydz8NkuEjTuwsvmDmy6s2BdKUvUyxqSnJ4r9eDTCR8qU5rWxV?=
 =?us-ascii?Q?LwyQ0Tnp0CVOTx0VIqaZqKaEdS4JqZE2BPM+0VUevbj4xAZKMzAyu/p1EBIh?=
 =?us-ascii?Q?VK0dFOSU+Q/VWAkaYQJUqCIL2wmDSGgQgw1q4pj7BNykoj8sN2y1uykYJlIr?=
 =?us-ascii?Q?S5C8HOoBTVtDBPd+6bApXEHk5b458654B87Hrtzm9PpOT1/t49ZfFOZ7XH2U?=
 =?us-ascii?Q?vP7rzuyvaMRmVgp8doeL7FMB0hwkrHPsQBIL89mRBSgK9G21CwnY+b1R81e5?=
 =?us-ascii?Q?a28KiMIZ7eLHKvF7xsIt+K8CTGnLngyY0Q1bsM8IGG1PY+1RJFDLmnIxmBi9?=
 =?us-ascii?Q?ZjaQR5PyvvmkAH0jjh8wX2iT5yzmMtrHpTiX2WcGhMooYqm6kc2JfEgTJNnD?=
 =?us-ascii?Q?0uXCLgtx/lXTMDQ06L69/sZmFzfECnb8CvIXT78cur+Z6NlQOCqtrGQfFJSu?=
 =?us-ascii?Q?3l6WWZY4jp/HNs7koxloMa0P2MDhjxTzu4UK1XG1TfX/j+RL9ID2054n3BBS?=
 =?us-ascii?Q?KQ6rlLjrzD6UtWc7kQG/mP3j/NkERtTtUpkSkYJK9lJidF1Cfc6Zs3y1UKTN?=
 =?us-ascii?Q?6wacRxI9FrV14Li9YcH+42Ikcn7OUMpYxBediYLz1/yMb6V8guTckMFEC/XQ?=
 =?us-ascii?Q?6w02/7cA2WDLeMWjZHcbkZtFtAmFYqvXkBhTeq95r0DzZpBAAdlmzPsADjQO?=
 =?us-ascii?Q?BaON7fCaUmluXxB4Al3ypUsiK/jEPSqFR0fa3T0n0NDsSbiefUTmKoE5JD3f?=
 =?us-ascii?Q?o9kXLF5kDCOOQq5tDWDgY96LBxHlSgO5ssAOuZ9uEX40YkINKVUuUS3kjSLF?=
 =?us-ascii?Q?r3kmN3LfkGzlcUk8ImecNcTpXF9uAyeVPi52ExrBfo6lBlxz7E20S0/wDjsS?=
 =?us-ascii?Q?naft9CODGuuKaDQiphiDMvRGPEz0duEroD8N2epsYmJ3FJ1UST9kwLPInaR6?=
 =?us-ascii?Q?IH+LUVPdPuc9sReA0PTKS8YMXfbdVEG3CIPmpQqqCIx?=
X-Microsoft-Antispam-Message-Info: J6Lq6x5e0UV1LgrZq7uSuZTwxSWs2WOCziwxAUDiJREHINj8QtGRblAsQ4FSTAW1JB8Jy5zNhIqE5axC+VgAE2kkkwXnqWH56i66t0Dn5aRSGeBsuD1zE19W5cc+wllogBYaKHuJFnuOQ7xf8IPsYBjlVJ0h6EDqi3oQWuV+222I1+NRCib5A4LEgzgnoHn/yB/hf3iD+MHNH1LATlxav+Nocp5RVfxJfGdsbtS7R1+IonGxytTEr8nQWbqBs4p3UBZ6tKKO4/FC8Pd1Y3tHaMj07pBEgmeagEAFCwv6icvI+dgWsy4QgJagM1H9zMRHBsSp4OyCGEC1MISOao/1vozuitCEajAQTzOhOnLwDgk=
X-Microsoft-Exchange-Diagnostics: 1;BYAPR02MB4453;6:+0tQLz+8Q3nPd6e0JvP9ddsqOW7eefBQq0rnQcTaW7BovGeInvvOyclDXn9c8vJyTAH+ofuTyID0Qlj/B/ARtVFDpe4r8fXt7+dpt1i9aFozNhMuk2MuLLEDHHMhaE6PozPJhDg5QG7ze1/zu0PHk0Xuyg8EnlUTqHzfco0KeSvTCWwcRzXBsiwCRwfzYmHeF4Up55U/OKK8D1aMJkeIIRmuLwL1ZQUsQM1btmmXKZ25PHQnvTuxRpHw8OUtcw5P7S72n4vbe2Vtf+UvO04gmQJbNxplOZTmJRE7BZJkvn5oXupqplLiT1vAfx6ay+fY4gQmeHMlK3cnVciuPI3hlsC7cKmuOx7GSGgsu5+/IvrBoPfDkeI4dVqjEKW0U8QhTTrloSYkDcWVeLqzje7L+nUfuYoFcIeZ+kzgW4FdrN8ueMkeky5rK4vxbe+OKvemeq8BKHRCd7mXy1OUy75qyg==;5:HyVpWx9zk1P5EzLQlgjzib3W0y848Du+qJ9u/1WzJVrE1+maL+2+sxIkonQN09CyTGiOvX7FEbOM+AVuTaC/4BqZYtrrUVoJf7XhcP31CBcxW2tAUvLPm4a5rrmcSDOHuZyj2VMT8dNx84hJs/ppUqoovSNQ2Ov3eAiroWaBNe4=;7:ASSuL6cVe9cMJuUHQ3D49/fgA1widqRpkRnI7fyfDUBGrO5GIg1Ieky7fR0gHSw8+DW+Qu8JRbijYlAC6+jEv4TLFpawLak5J7rpBfEysNg0pQKeuuNu9EUSHCXq+BE6CjdSIslFVyCPulkXlVafmRXQ+POLsZNquQ2lq2lRH4uwwv9VNVHDbQq90hpvYNlvttZ1bFrXqGNyqCK5DmLTNBGfqQLj8lQm1phHlydJaLZXwXwMvXsUDTXHevE95Fbm
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Aug 2018 13:19:55.7310
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f576191-0632-4014-78e1-08d604442008
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR02MB4453
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the basic driver for Arasan NAND Flash Controller used in
Zynq UltraScale+ MPSoC. It supports HW ECC and upto 24bit
correction.

Signed-off-by: Naga Sureshkumar Relli <naga.sureshkumar.relli@xilinx.com>
---
Changes in v10:
 - Implemented ->exec_op() interface.
 - Converted the driver to nand_scan().
Changes in v9:
 - Added the SPDX tags
Changes in v8:
 - Implemented setup_data_interface hook
 - fixed checkpatch --strict warnings
 - Added anfc_config_ecc in read_page_hwecc
 - Fixed returning status value by reading flash status in read_byte()
   instead of reading previous value.
Changes in v7:
- Implemented Marek suggestions and comments
- Corrected the acronyms those should be in caps
- Modified kconfig/Make file to keep arasan entry in sorted order
- Added is_vmlloc_addr check
- Used ioread/write32_rep variants to avoid compilation error for intel
  platforms
- separated PIO and DMA mode read/write functions
- Minor cleanup
Chnages in v6:
- Addressed most of the Brian and Boris comments
- Separated the nandchip from the nand controller
- Removed the ecc lookup table from driver
- Now use framework nand waitfunction and readoob
- Fixed the compiler warning
- Adapted the new frameowrk changes related to ecc and ooblayout
- Disabled the clocks after the nand_reelase
- Now using only one completion object
- Boris suggessions like adapting cmd_ctrl and rework on read/write byte
  are not implemented and i will patch them later
- Also check_erased_ecc_chunk for erase and check for is_vmalloc_addr will
  implement later once the basic driver is mainlined.
Changes in v5:
- Renamed the driver filei as arasan_nand.c
- Fixed all comments relaqted coding style
- Fixed comments related to propagating the errors
- Modified the anfc_write_page_hwecc as per the write_page
  prototype
Changes in v4:
- Added support for onfi timing mode configuration
- Added clock supppport
- Added support for multiple chipselects
Changes in v3:
- Removed unused variables
- Avoided busy loop and used jifies based implementation
- Fixed compiler warnings "right shift count >= width of type"
- Removed unneeded codei and improved error reporting
- Added onfi version check to ensure reading the valid address cycles
Changes in v2:
- Added missing of.h to avoid kbuild system report erro
---
 drivers/mtd/nand/raw/Kconfig       |    8 +
 drivers/mtd/nand/raw/Makefile      |    1 +
 drivers/mtd/nand/raw/arasan_nand.c | 1350 ++++++++++++++++++++++++++++++++++++
 3 files changed, 1359 insertions(+)
 create mode 100644 drivers/mtd/nand/raw/arasan_nand.c

diff --git a/drivers/mtd/nand/raw/Kconfig b/drivers/mtd/nand/raw/Kconfig
index b6738ec..1e66f51 100644
--- a/drivers/mtd/nand/raw/Kconfig
+++ b/drivers/mtd/nand/raw/Kconfig
@@ -560,4 +560,12 @@ config MTD_NAND_TEGRA
 	  is supported. Extra OOB bytes when using HW ECC are currently
 	  not supported.
 
+config MTD_NAND_ARASAN
+	tristate "Support for Arasan Nand Flash controller"
+	depends on HAS_IOMEM
+	depends on HAS_DMA
+	help
+	  Enables the driver for the Arasan Nand Flash controller on
+	  Zynq Ultrascale+ MPSoC.
+
 endif # MTD_NAND
diff --git a/drivers/mtd/nand/raw/Makefile b/drivers/mtd/nand/raw/Makefile
index d5a5f98..ccb8d56 100644
--- a/drivers/mtd/nand/raw/Makefile
+++ b/drivers/mtd/nand/raw/Makefile
@@ -57,6 +57,7 @@ obj-$(CONFIG_MTD_NAND_BRCMNAND)		+= brcmnand/
 obj-$(CONFIG_MTD_NAND_QCOM)		+= qcom_nandc.o
 obj-$(CONFIG_MTD_NAND_MTK)		+= mtk_ecc.o mtk_nand.o
 obj-$(CONFIG_MTD_NAND_TEGRA)		+= tegra_nand.o
+obj-$(CONFIG_MTD_NAND_ARASAN)		+= arasan_nand.o
 
 nand-objs := nand_base.o nand_bbt.o nand_timings.o nand_ids.o
 nand-objs += nand_amd.o
diff --git a/drivers/mtd/nand/raw/arasan_nand.c b/drivers/mtd/nand/raw/arasan_nand.c
new file mode 100644
index 0000000..e4f1f80
--- /dev/null
+++ b/drivers/mtd/nand/raw/arasan_nand.c
@@ -0,0 +1,1350 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Arasan NAND Flash Controller Driver
+ *
+ * Copyright (C) 2014 - 2017 Xilinx, Inc.
+ * Author: Punnaiah Choudary Kalluri <punnaia@xilinx.com>
+ * Author: Naga Sureshkumar Relli <nagasure@xilinx.com>
+ *
+ */
+#include <linux/clk.h>
+#include <linux/delay.h>
+#include <linux/dma-mapping.h>
+#include <linux/interrupt.h>
+#include <linux/io-64-nonatomic-lo-hi.h>
+#include <linux/module.h>
+#include <linux/mtd/mtd.h>
+#include <linux/mtd/rawnand.h>
+#include <linux/mtd/partitions.h>
+#include <linux/of.h>
+#include <linux/platform_device.h>
+#include <linux/slab.h>
+#define DRIVER_NAME			"arasan_nand"
+#define EVNT_TIMEOUT_MSEC		1000
+#define STATUS_TIMEOUT			2000
+
+#define PKT_OFST			0x00
+#define MEM_ADDR1_OFST			0x04
+#define MEM_ADDR2_OFST			0x08
+#define CMD_OFST			0x0C
+#define PROG_OFST			0x10
+#define INTR_STS_EN_OFST		0x14
+#define INTR_SIG_EN_OFST		0x18
+#define INTR_STS_OFST			0x1C
+#define READY_STS_OFST			0x20
+#define DMA_ADDR1_OFST			0x24
+#define FLASH_STS_OFST			0x28
+#define DATA_PORT_OFST			0x30
+#define ECC_OFST			0x34
+#define ECC_ERR_CNT_OFST		0x38
+#define ECC_SPR_CMD_OFST		0x3C
+#define ECC_ERR_CNT_1BIT_OFST		0x40
+#define ECC_ERR_CNT_2BIT_OFST		0x44
+#define DMA_ADDR0_OFST			0x50
+#define DATA_INTERFACE_OFST		0x6C
+
+#define PKT_CNT_SHIFT			12
+
+#define ECC_ENABLE			BIT(31)
+#define DMA_EN_MASK			GENMASK(27, 26)
+#define DMA_ENABLE			0x2
+#define DMA_EN_SHIFT			26
+#define REG_PAGE_SIZE_SHIFT		23
+#define REG_PAGE_SIZE_512		0
+#define REG_PAGE_SIZE_1K		5
+#define REG_PAGE_SIZE_2K		1
+#define REG_PAGE_SIZE_4K		2
+#define REG_PAGE_SIZE_8K		3
+#define REG_PAGE_SIZE_16K		4
+#define CMD2_SHIFT			8
+#define ADDR_CYCLES_SHIFT		28
+
+#define XFER_COMPLETE			BIT(2)
+#define READ_READY			BIT(1)
+#define WRITE_READY			BIT(0)
+#define MBIT_ERROR			BIT(3)
+
+#define PROG_PGRD			BIT(0)
+#define PROG_ERASE			BIT(2)
+#define PROG_STATUS			BIT(3)
+#define PROG_PGPROG			BIT(4)
+#define PROG_RDID			BIT(6)
+#define PROG_RDPARAM			BIT(7)
+#define PROG_RST			BIT(8)
+#define PROG_GET_FEATURE		BIT(9)
+#define PROG_SET_FEATURE		BIT(10)
+
+#define PG_ADDR_SHIFT			16
+#define BCH_MODE_SHIFT			25
+#define BCH_EN_SHIFT			27
+#define ECC_SIZE_SHIFT			16
+
+#define MEM_ADDR_MASK			GENMASK(7, 0)
+#define BCH_MODE_MASK			GENMASK(27, 25)
+
+#define CS_MASK				GENMASK(31, 30)
+#define CS_SHIFT			30
+
+#define PAGE_ERR_CNT_MASK		GENMASK(16, 8)
+#define PKT_ERR_CNT_MASK		GENMASK(7, 0)
+
+#define NVDDR_MODE			BIT(9)
+#define NVDDR_TIMING_MODE_SHIFT		3
+
+#define ONFI_ID_LEN			8
+#define TEMP_BUF_SIZE			1024
+#define NVDDR_MODE_PACKET_SIZE		8
+#define SDR_MODE_PACKET_SIZE		4
+
+#define ONFI_DATA_INTERFACE_NVDDR      BIT(4)
+#define EVENT_MASK	(XFER_COMPLETE | READ_READY | WRITE_READY | MBIT_ERROR)
+
+#define SDR_MODE_DEFLT_FREQ		80000000
+#define COL_ROW_ADDR(pos, val)			(((val) & 0xFF) << (8 * (pos)))
+
+struct anfc_op {
+	s32 cmnds[4];
+	u32 type;
+	u32 len;
+	u32 naddrs;
+	u32 col;
+	u32 row;
+	unsigned int data_instr_idx;
+	unsigned int rdy_timeout_ms;
+	unsigned int rdy_delay_ns;
+	const struct nand_op_instr *data_instr;
+};
+
+/**
+ * struct anfc_nand_chip - Defines the nand chip related information
+ * @node:		used to store NAND chips into a list.
+ * @chip:		NAND chip information structure.
+ * @bch:		Bch / Hamming mode enable/disable.
+ * @bchmode:		Bch mode.
+ * @eccval:		Ecc config value.
+ * @raddr_cycles:	Row address cycle information.
+ * @caddr_cycles:	Column address cycle information.
+ * @pktsize:		Packet size for read / write operation.
+ * @csnum:		chipselect number to be used.
+ * @spktsize:		Packet size in ddr mode for status operation.
+ * @inftimeval:		Data interface and timing mode information
+ */
+struct anfc_nand_chip {
+	struct list_head node;
+	struct nand_chip chip;
+	bool bch;
+	u32 bchmode;
+	u32 eccval;
+	u16 raddr_cycles;
+	u16 caddr_cycles;
+	u32 pktsize;
+	int csnum;
+	u32 spktsize;
+	u32 inftimeval;
+};
+
+/**
+ * struct anfc_nand_controller - Defines the Arasan NAND flash controller
+ *				 driver instance
+ * @controller:		base controller structure.
+ * @chips:		list of all nand chips attached to the ctrler.
+ * @dev:		Pointer to the device structure.
+ * @base:		Virtual address of the NAND flash device.
+ * @curr_cmd:		Current command issued.
+ * @clk_sys:		Pointer to the system clock.
+ * @clk_flash:		Pointer to the flash clock.
+ * @dma:		Dma enable/disable.
+ * @iswriteoob:		Identifies if oob write operation is required.
+ * @buf:		Buffer used for read/write byte operations.
+ * @irq:		irq number
+ * @bufshift:		Variable used for indexing buffer operation
+ * @csnum:		Chip select number currently inuse.
+ * @event:		Completion event for nand status events.
+ * @status:		Status of the flash device.
+ * @prog:		Used to initiate controller operations.
+ */
+struct anfc_nand_controller {
+	struct nand_controller controller;
+	struct list_head chips;
+	struct device *dev;
+	void __iomem *base;
+	int curr_cmd;
+	struct clk *clk_sys;
+	struct clk *clk_flash;
+	bool dma;
+	bool iswriteoob;
+	int irq;
+	int csnum;
+	struct completion event;
+	int status;
+	u32 prog;
+};
+
+static int anfc_ooblayout_ecc(struct mtd_info *mtd, int section,
+			      struct mtd_oob_region *oobregion)
+{
+	struct nand_chip *nand = mtd_to_nand(mtd);
+
+	if (section >= nand->ecc.steps)
+		return -ERANGE;
+
+	if (section)
+		return -ERANGE;
+
+	oobregion->length = nand->ecc.total;
+	oobregion->offset = mtd->oobsize - oobregion->length;
+
+	return 0;
+}
+
+static int anfc_ooblayout_free(struct mtd_info *mtd, int section,
+			       struct mtd_oob_region *oobregion)
+{
+	struct nand_chip *nand = mtd_to_nand(mtd);
+
+	if (section >= nand->ecc.steps)
+		return -ERANGE;
+
+	if (section)
+		return -ERANGE;
+
+	oobregion->offset = 2;
+	oobregion->length = mtd->oobsize - nand->ecc.total - 2;
+
+	return 0;
+}
+
+static const struct mtd_ooblayout_ops anfc_ooblayout_ops = {
+	.ecc = anfc_ooblayout_ecc,
+	.free = anfc_ooblayout_free,
+};
+
+static inline struct anfc_nand_chip *to_anfc_nand(struct nand_chip *nand)
+{
+	return container_of(nand, struct anfc_nand_chip, chip);
+}
+
+static inline struct anfc_nand_controller *to_anfc(struct nand_controller *ctrl)
+{
+	return container_of(ctrl, struct anfc_nand_controller, controller);
+}
+
+static u8 anfc_page(u32 pagesize)
+{
+	switch (pagesize) {
+	case 512:
+		return REG_PAGE_SIZE_512;
+	case 1024:
+		return REG_PAGE_SIZE_1K;
+	case 2048:
+		return REG_PAGE_SIZE_2K;
+	case 4096:
+		return REG_PAGE_SIZE_4K;
+	case 8192:
+		return REG_PAGE_SIZE_8K;
+	case 16384:
+		return REG_PAGE_SIZE_16K;
+	default:
+		break;
+	}
+
+	return 0;
+}
+
+static inline void anfc_enable_intrs(struct anfc_nand_controller *nfc, u32 val)
+{
+	writel(val, nfc->base + INTR_STS_EN_OFST);
+	writel(val, nfc->base + INTR_SIG_EN_OFST);
+}
+
+static inline void anfc_config_ecc(struct anfc_nand_controller *nfc, bool on)
+{
+	u32 val;
+
+	val = readl(nfc->base + CMD_OFST);
+	if (on)
+		val |= ECC_ENABLE;
+	else
+		val &= ~ECC_ENABLE;
+	writel(val, nfc->base + CMD_OFST);
+}
+
+static inline void anfc_config_dma(struct anfc_nand_controller *nfc, int on)
+{
+	u32 val;
+
+	val = readl(nfc->base + CMD_OFST);
+	val &= ~DMA_EN_MASK;
+	if (on)
+		val |= DMA_ENABLE << DMA_EN_SHIFT;
+	writel(val, nfc->base + CMD_OFST);
+}
+
+static inline int anfc_wait_for_event(struct anfc_nand_controller *nfc)
+{
+	return wait_for_completion_timeout(&nfc->event,
+					msecs_to_jiffies(EVNT_TIMEOUT_MSEC));
+}
+
+static inline void anfc_setpktszcnt(struct anfc_nand_controller *nfc,
+				    u32 pktsize, u32 pktcount)
+{
+	writel(pktsize | (pktcount << PKT_CNT_SHIFT), nfc->base + PKT_OFST);
+}
+
+static inline void anfc_set_eccsparecmd(struct anfc_nand_controller *nfc,
+					struct anfc_nand_chip *achip, u8 cmd1,
+					u8 cmd2)
+{
+	writel(cmd1 | (cmd2 << CMD2_SHIFT) |
+	       (achip->caddr_cycles << ADDR_CYCLES_SHIFT),
+	       nfc->base + ECC_SPR_CMD_OFST);
+}
+
+static void anfc_setpagecoladdr(struct anfc_nand_controller *nfc, u32 page,
+				u16 col)
+{
+	u32 val;
+
+	writel(col | (page << PG_ADDR_SHIFT), nfc->base + MEM_ADDR1_OFST);
+
+	val = readl(nfc->base + MEM_ADDR2_OFST);
+	val = (val & ~MEM_ADDR_MASK) |
+	      ((page >> PG_ADDR_SHIFT) & MEM_ADDR_MASK);
+	writel(val, nfc->base + MEM_ADDR2_OFST);
+}
+
+static void anfc_prepare_cmd(struct anfc_nand_controller *nfc, u8 cmd1,
+			     u8 cmd2, u8 dmamode,
+			     u32 pagesize, u8 addrcycles)
+{
+	u32 regval;
+
+	regval = cmd1 | (cmd2 << CMD2_SHIFT);
+	if (dmamode && nfc->dma)
+		regval |= DMA_ENABLE << DMA_EN_SHIFT;
+	regval |= addrcycles << ADDR_CYCLES_SHIFT;
+	regval |= anfc_page(pagesize) << REG_PAGE_SIZE_SHIFT;
+	writel(regval, nfc->base + CMD_OFST);
+}
+
+static void anfc_rw_dma_op(struct mtd_info *mtd, uint8_t *buf, int len,
+			    bool do_read, u32 prog)
+{
+	dma_addr_t paddr;
+	struct nand_chip *chip = mtd_to_nand(mtd);
+	struct anfc_nand_controller *nfc = to_anfc(chip->controller);
+	struct anfc_nand_chip *achip = to_anfc_nand(chip);
+	u32 eccintr = 0, dir;
+	u32 pktsize = len, pktcount = 1;
+
+	if (((nfc->curr_cmd == NAND_CMD_READ0)) ||
+	    (nfc->curr_cmd == NAND_CMD_SEQIN && !nfc->iswriteoob)) {
+		pktsize = achip->pktsize;
+		pktcount = DIV_ROUND_UP(mtd->writesize, pktsize);
+	}
+	anfc_setpktszcnt(nfc, pktsize, pktcount);
+
+	if (!achip->bch && nfc->curr_cmd == NAND_CMD_READ0)
+		eccintr = MBIT_ERROR;
+
+	if (do_read)
+		dir = DMA_FROM_DEVICE;
+	else
+		dir = DMA_TO_DEVICE;
+
+	paddr = dma_map_single(nfc->dev, buf, len, dir);
+	if (dma_mapping_error(nfc->dev, paddr)) {
+		dev_err(nfc->dev, "Read buffer mapping error");
+		return;
+	}
+	writel(paddr, nfc->base + DMA_ADDR0_OFST);
+	writel((paddr >> 32), nfc->base + DMA_ADDR1_OFST);
+	anfc_enable_intrs(nfc, (XFER_COMPLETE | eccintr));
+	writel(prog, nfc->base + PROG_OFST);
+	anfc_wait_for_event(nfc);
+	dma_unmap_single(nfc->dev, paddr, len, dir);
+}
+
+static void anfc_rw_pio_op(struct mtd_info *mtd, uint8_t *buf, int len,
+			    bool do_read, int prog)
+{
+	struct nand_chip *chip = mtd_to_nand(mtd);
+	struct anfc_nand_controller *nfc = to_anfc(chip->controller);
+	struct anfc_nand_chip *achip = to_anfc_nand(chip);
+	u32 *bufptr = (u32 *)buf;
+	u32 cnt = 0, intr = 0;
+	u32 pktsize = len, pktcount = 1;
+
+	anfc_config_dma(nfc, 0);
+
+	if (((nfc->curr_cmd == NAND_CMD_READ0)) ||
+	    (nfc->curr_cmd == NAND_CMD_SEQIN && !nfc->iswriteoob)) {
+		pktsize = achip->pktsize;
+		pktcount = DIV_ROUND_UP(mtd->writesize, pktsize);
+	}
+	anfc_setpktszcnt(nfc, pktsize, pktcount);
+
+	if (!achip->bch && nfc->curr_cmd == NAND_CMD_READ0)
+		intr = MBIT_ERROR;
+
+	if (do_read)
+		intr |= READ_READY;
+	else
+		intr |= WRITE_READY;
+
+	anfc_enable_intrs(nfc, intr);
+	writel(prog, nfc->base + PROG_OFST);
+	while (cnt < pktcount) {
+
+		anfc_wait_for_event(nfc);
+		cnt++;
+		if (cnt == pktcount)
+			anfc_enable_intrs(nfc, XFER_COMPLETE);
+		if (do_read)
+			ioread32_rep(nfc->base + DATA_PORT_OFST, bufptr,
+				     pktsize / 4);
+		else
+			iowrite32_rep(nfc->base + DATA_PORT_OFST, bufptr,
+				      pktsize / 4);
+		bufptr += (pktsize / 4);
+		if (cnt < pktcount)
+			anfc_enable_intrs(nfc, intr);
+	}
+	anfc_wait_for_event(nfc);
+}
+
+static void anfc_read_data_op(struct mtd_info *mtd, uint8_t *buf, int len)
+{
+	struct nand_chip *chip = mtd_to_nand(mtd);
+	struct anfc_nand_controller *nfc = to_anfc(chip->controller);
+
+	if (nfc->dma && !is_vmalloc_addr(buf))
+		anfc_rw_dma_op(mtd, buf, len, 1, PROG_PGRD);
+	else
+		anfc_rw_pio_op(mtd, buf, len, 1, PROG_PGRD);
+}
+
+static void anfc_write_data_op(struct mtd_info *mtd, const uint8_t *buf,
+			       int len)
+{
+	struct nand_chip *chip = mtd_to_nand(mtd);
+	struct anfc_nand_controller *nfc = to_anfc(chip->controller);
+
+	if (nfc->dma && !is_vmalloc_addr(buf))
+		anfc_rw_dma_op(mtd, (char *)buf, len, 0, PROG_PGPROG);
+	else
+		anfc_rw_pio_op(mtd, (char *)buf, len, 0, PROG_PGPROG);
+}
+
+static int anfc_prep_nand_instr(struct mtd_info *mtd, int cmd,
+				struct nand_chip *chip,  int col, int page)
+{
+	u8 addrs[5];
+
+	struct nand_op_instr instrs[] = {
+		NAND_OP_CMD(cmd, PSEC_TO_NSEC(1)),
+		NAND_OP_ADDR(3, addrs, 0),
+	};
+	struct nand_operation op = NAND_OPERATION(instrs);
+
+	if (mtd->writesize <= 512) {
+		addrs[0] = col;
+		if (page != -1) {
+			addrs[1] = page;
+			addrs[2] = page >> 8;
+			instrs[1].ctx.addr.naddrs = 3;
+			if (chip->options & NAND_ROW_ADDR_3) {
+				addrs[3] = page >> 16;
+				instrs[1].ctx.addr.naddrs += 1;
+			}
+		} else {
+			instrs[1].ctx.addr.naddrs = 1;
+		}
+	} else {
+		addrs[0] = col;
+		addrs[1] = col >> 8;
+		if (page != -1) {
+			addrs[2] = page;
+			addrs[3] = page >> 8;
+			instrs[1].ctx.addr.naddrs = 4;
+			if (chip->options & NAND_ROW_ADDR_3) {
+				addrs[4] = page >> 16;
+				instrs[1].ctx.addr.naddrs += 1;
+			}
+		} else {
+			instrs[1].ctx.addr.naddrs = 2;
+		}
+	}
+
+	return nand_exec_op(chip, &op);
+}
+
+static int anfc_nand_wait(struct mtd_info *mtd, struct nand_chip *chip)
+{
+	u8 status;
+	int ret;
+	unsigned long timeo;
+
+	/*
+	 * Apply this short delay always to ensure that we do wait tWB in any
+	 * case on any machine.
+	 */
+	ndelay(100);
+	timeo = jiffies + msecs_to_jiffies(STATUS_TIMEOUT);
+	do {
+		ret = nand_status_op(chip, &status);
+		if (ret)
+			return ret;
+
+		if (status & NAND_STATUS_READY)
+			break;
+		cond_resched();
+	} while (time_before(jiffies, timeo));
+
+
+	return status;
+}
+
+static int anfc_write_oob(struct mtd_info *mtd, struct nand_chip *chip,
+			  int page)
+{
+	struct anfc_nand_controller *nfc = to_anfc(chip->controller);
+
+	nfc->iswriteoob = true;
+	anfc_prep_nand_instr(mtd, NAND_CMD_SEQIN, chip, mtd->writesize, page);
+	anfc_write_data_op(mtd, chip->oob_poi, mtd->oobsize);
+	nfc->iswriteoob = false;
+
+	return 0;
+}
+
+static int anfc_read_oob(struct mtd_info *mtd, struct nand_chip *chip,
+			  int page)
+{
+	anfc_prep_nand_instr(mtd, NAND_CMD_READOOB, chip, 0, page);
+	anfc_read_data_op(mtd, chip->oob_poi, mtd->oobsize);
+
+	return 0;
+}
+
+
+static int anfc_read_page_hwecc(struct mtd_info *mtd,
+				struct nand_chip *chip, uint8_t *buf,
+				int oob_required, int page)
+{
+	u32 val;
+	struct anfc_nand_controller *nfc = to_anfc(chip->controller);
+	struct anfc_nand_chip *achip = to_anfc_nand(chip);
+	u8 *ecc_code = chip->ecc.code_buf;
+	u8 *p = buf;
+	int eccsize = chip->ecc.size;
+	int eccbytes = chip->ecc.bytes;
+	int stat = 0, i;
+	u32 ret;
+	unsigned int max_bitflips = 0;
+
+	ret = nand_read_page_op(chip, page, 0, NULL, 0);
+	if (ret)
+		return ret;
+
+	anfc_set_eccsparecmd(nfc, achip, NAND_CMD_RNDOUT, NAND_CMD_RNDOUTSTART);
+	anfc_config_ecc(nfc, true);
+	anfc_read_data_op(mtd, buf, mtd->writesize);
+
+	if (achip->bch) {
+		/*
+		 * Arasan NAND controller can correct ECC upto 24-bit
+		 * Beyond that, it can't detect errors, so no fail count
+		 * updated here.
+		 */
+		val = readl(nfc->base + ECC_ERR_CNT_OFST);
+		val = ((val & PAGE_ERR_CNT_MASK) >> 8);
+		mtd->ecc_stats.corrected += val;
+	} else {
+		val = readl(nfc->base + ECC_ERR_CNT_1BIT_OFST);
+		mtd->ecc_stats.corrected += val;
+		val = readl(nfc->base + ECC_ERR_CNT_2BIT_OFST);
+		mtd->ecc_stats.failed += val;
+		/* Clear ecc error count register 1Bit, 2Bit */
+		writel(0x0, nfc->base + ECC_ERR_CNT_1BIT_OFST);
+		writel(0x0, nfc->base + ECC_ERR_CNT_2BIT_OFST);
+	}
+
+	if (oob_required)
+		chip->ecc.read_oob(mtd, chip, page);
+
+	anfc_config_ecc(nfc, false);
+
+	if (val) {
+		if (!oob_required)
+			chip->ecc.read_oob(mtd, chip, page);
+
+		mtd_ooblayout_get_eccbytes(mtd, ecc_code, chip->oob_poi, 0,
+					   chip->ecc.total);
+		for (i = 0; i < chip->ecc.steps; ++i) {
+			stat = nand_check_erased_ecc_chunk(p,
+							   chip->ecc.size,
+							   &ecc_code[i],
+							   eccbytes,
+							   NULL, 0,
+							   chip->ecc.strength);
+			if (stat < 0) {
+				/*
+				 * No fail count updated here, because the data
+				 * is already corrected and ecc_stats.corrected
+				 * is updated and in case of haming,
+				 * ecc_stats.failed is updated.
+				 */
+				stat = 0;
+			} else {
+				mtd->ecc_stats.corrected += stat;
+			}
+			max_bitflips = max_t(unsigned int, max_bitflips, stat);
+			p += eccsize;
+		}
+	}
+
+	return max_bitflips;
+}
+
+
+static int anfc_write_page_hwecc(struct mtd_info *mtd,
+				 struct nand_chip *chip, const uint8_t *buf,
+				 int oob_required, int page)
+{
+	int ret;
+	struct anfc_nand_controller *nfc = to_anfc(chip->controller);
+	struct anfc_nand_chip *achip = to_anfc_nand(chip);
+	u8 status;
+	u8 *ecc_calc = chip->ecc.calc_buf;
+
+	ret = nand_prog_page_begin_op(chip, page, 0, NULL, 0);
+	if (ret)
+		return ret;
+
+	anfc_set_eccsparecmd(nfc, achip, NAND_CMD_RNDIN, 0);
+	anfc_config_ecc(nfc, true);
+	anfc_write_data_op(mtd, buf, mtd->writesize);
+
+	if (oob_required) {
+		status = anfc_nand_wait(mtd, chip);
+		if (status & NAND_STATUS_FAIL)
+			return -EIO;
+
+		anfc_prep_nand_instr(mtd, NAND_CMD_READOOB, chip, 0, page);
+		anfc_read_data_op(mtd, ecc_calc, mtd->oobsize);
+		ret = mtd_ooblayout_set_eccbytes(mtd, ecc_calc, chip->oob_poi,
+						 0, chip->ecc.total);
+		if (ret)
+			return ret;
+
+		chip->ecc.write_oob(mtd, chip, page);
+	}
+	status = anfc_nand_wait(mtd, chip);
+	if (status & NAND_STATUS_FAIL)
+		return -EIO;
+
+	anfc_config_ecc(nfc, false);
+
+	return 0;
+}
+
+/**
+ * anfc_get_mode_frm_timings - Converts sdr timing values to respective modes
+ * @sdr: SDR NAND chip timings structure
+ * Arasan NAND controller has Data Interface Register (0x6C)
+ * which has timing mode configurations and need to program only the modes but
+ * not timings. So this function returns SDR timing mode from SDR timing values
+ *
+ * Return: 	SDR timing mode on success, a negative error code otherwise.
+ */
+static int anfc_get_mode_frm_timings(const struct nand_sdr_timings *sdr)
+{
+	if (sdr->tRC_min <= 20000)
+		return 5;
+	else if (sdr->tRC_min <= 25000)
+		return 4;
+	else if (sdr->tRC_min <= 30000)
+		return 3;
+	else if (sdr->tRC_min <= 35000)
+		return 2;
+	else if (sdr->tRC_min <= 50000)
+		return 1;
+	else if (sdr->tRC_min <= 100000)
+		return 0;
+	else
+		return -1;
+}
+
+static int anfc_ecc_init(struct mtd_info *mtd,
+			 struct nand_ecc_ctrl *ecc, int ecc_mode)
+{
+	u32 ecc_addr;
+	unsigned int bchmode, steps;
+	struct nand_chip *chip = mtd_to_nand(mtd);
+	struct anfc_nand_chip *achip = to_anfc_nand(chip);
+
+	ecc->write_oob = anfc_write_oob;
+	ecc->read_oob = anfc_read_oob;
+	ecc->mode = NAND_ECC_HW;
+	ecc->read_page = anfc_read_page_hwecc;
+	ecc->write_page = anfc_write_page_hwecc;
+
+	mtd_set_ooblayout(mtd, &anfc_ooblayout_ops);
+
+	steps = mtd->writesize / chip->ecc_step_ds;
+
+	switch (chip->ecc_strength_ds) {
+	case 12:
+		bchmode = 0x1;
+		break;
+	case 8:
+		bchmode = 0x2;
+		break;
+	case 4:
+		bchmode = 0x3;
+		break;
+	case 24:
+		bchmode = 0x4;
+		break;
+	default:
+		bchmode = 0x0;
+	}
+	if (!bchmode)
+		ecc->total = 3 * steps;
+	else
+		ecc->total =
+		     DIV_ROUND_UP(fls(8 * chip->ecc_step_ds) *
+			 chip->ecc_strength_ds * steps, 8);
+
+	ecc->strength = chip->ecc_strength_ds;
+	ecc->size = chip->ecc_step_ds;
+	ecc->bytes = ecc->total / steps;
+	ecc->steps = steps;
+	achip->bchmode = bchmode;
+	achip->bch = achip->bchmode;
+	ecc_addr = mtd->writesize + (mtd->oobsize - ecc->total);
+
+	achip->eccval = ecc_addr | (ecc->total << ECC_SIZE_SHIFT) |
+			(achip->bch << BCH_EN_SHIFT);
+
+	if (chip->ecc_step_ds >= 1024)
+		achip->pktsize = 1024;
+	else
+		achip->pktsize = 512;
+
+	return 0;
+}
+
+/* NAND framework ->exec_op() hooks and related helpers */
+static void anfc_parse_instructions(struct nand_chip *chip,
+					 const struct nand_subop *subop,
+					 struct anfc_op *nfc_op)
+{
+	const struct nand_op_instr *instr = NULL;
+	struct anfc_nand_controller *nfc = to_anfc(chip->controller);
+	unsigned int op_id;
+	int i = 0;
+	const u8 *addrs;
+
+	memset(nfc_op, 0, sizeof(struct anfc_op));
+
+	/*
+	 * This is to keep track of status command. some times
+	 * core will just request status byte to read. so to make
+	 * sure that no command is issued, cmnds[0] is assigned to
+	 * NAND_CMD_NONE.
+	 */
+	nfc_op->cmnds[0] = NAND_CMD_NONE;
+	for (op_id = 0; op_id < subop->ninstrs; op_id++) {
+		instr = &subop->instrs[op_id];
+		switch (instr->type) {
+		case NAND_OP_CMD_INSTR:
+			nfc_op->type = NAND_OP_CMD_INSTR;
+			if (op_id)
+				nfc_op->cmnds[1] = instr->ctx.cmd.opcode;
+			else
+				nfc_op->cmnds[0] = instr->ctx.cmd.opcode;
+			nfc->curr_cmd = nfc_op->cmnds[0];
+			break;
+
+		case NAND_OP_ADDR_INSTR:
+			i = nand_subop_get_addr_start_off(subop, op_id);
+			nfc_op->naddrs = nand_subop_get_num_addr_cyc(subop,
+								     op_id);
+			addrs = &instr->ctx.addr.addrs[i];
+
+			for (; i < nfc_op->naddrs; i++) {
+				u8 val = instr->ctx.addr.addrs[i];
+
+				if (nfc_op->cmnds[0] == NAND_CMD_ERASE1)
+					nfc_op->row |= COL_ROW_ADDR(i, val);
+				else {
+					if (i < 2)
+						nfc_op->col |= COL_ROW_ADDR(
+								i, val);
+					else
+						nfc_op->row |= COL_ROW_ADDR(
+								i - 2, val);
+				}
+			}
+			break;
+		case NAND_OP_DATA_IN_INSTR:
+			nfc_op->data_instr = instr;
+			nfc_op->type = NAND_OP_DATA_IN_INSTR;
+			nfc_op->data_instr_idx = op_id;
+			break;
+		case NAND_OP_DATA_OUT_INSTR:
+			nfc_op->data_instr = instr;
+			nfc_op->type = NAND_OP_DATA_IN_INSTR;
+			nfc_op->data_instr_idx = op_id;
+			break;
+		case NAND_OP_WAITRDY_INSTR:
+			nfc_op->rdy_timeout_ms = instr->ctx.waitrdy.timeout_ms;
+			nfc_op->rdy_delay_ns = instr->delay_ns;
+			break;
+		}
+	}
+}
+
+/**
+ * anfc_data_cpy - Read data from the NAND
+ * @nfc: The Controller instance
+ * @mtd: mtd info structure
+ * @buf: buffer used to store the data
+ * @len: length of the buffer
+ * @operation: current command transfer,
+ *             that needs to be set in program_register
+ * @direction: Read/write transfer
+ * The Arasan NAND controller always read/write 4byte alinged
+ * lengths.If the length of the data is not 4byte aligned, then
+ * we need to make it as alinged.
+ *
+ * Returns 0 on success, a negative error code otherwise.
+ */
+static void anfc_data_cpy(struct anfc_nand_controller *nfc,
+			  struct mtd_info *mtd, u8 *buf,
+			  int len, int operation, bool direction)
+{
+	u32 Rem = 0, Div;
+
+	if (!buf)
+		return;
+
+	Rem = len % 4;
+	Div = len / 4;
+	if (len < 4) {
+		anfc_rw_pio_op(mtd, buf, 4, direction, operation);
+	} else {
+		anfc_rw_pio_op(mtd, buf, 4*Div, direction, operation);
+
+		if (Rem) {
+			buf += (4*Div);
+			anfc_rw_pio_op(mtd, buf, 4, direction, operation);
+		}
+	}
+}
+
+static int anfc_status_type_exec(struct nand_chip *chip,
+				   const struct nand_subop *subop)
+{
+	const struct nand_op_instr *instr;
+	struct anfc_op nfc_op = {};
+	unsigned int op_id, len;
+	struct anfc_nand_chip *achip = to_anfc_nand(chip);
+	struct anfc_nand_controller *nfc = to_anfc(chip->controller);
+
+	anfc_parse_instructions(chip, subop, &nfc_op);
+	instr = nfc_op.data_instr;
+	op_id = nfc_op.data_instr_idx;
+
+	anfc_prepare_cmd(nfc, nfc_op.cmnds[0], 0, 0, 0, 0);
+	anfc_setpktszcnt(nfc, achip->spktsize / 4, 1);
+	anfc_setpagecoladdr(nfc, nfc_op.row, nfc_op.col);
+	nfc->prog = PROG_STATUS;
+
+	anfc_enable_intrs(nfc, XFER_COMPLETE);
+	writel(nfc->prog, nfc->base + PROG_OFST);
+	anfc_wait_for_event(nfc);
+
+	if (!nfc_op.data_instr)
+		return 0;
+
+	len = nand_subop_get_data_len(subop, op_id);
+
+	/*
+	 * The Arasan NAND controller will update the status value
+	 * returned by the flash device in FLASH_STS register.
+	 */
+	nfc->status = readl(nfc->base + FLASH_STS_OFST);
+	memcpy(instr->ctx.data.buf.in, &nfc->status, len);
+	return 0;
+}
+
+static int anfc_erase_function(struct nand_chip *chip,
+				   struct anfc_op nfc_op)
+{
+
+	struct anfc_nand_chip *achip = to_anfc_nand(chip);
+	struct anfc_nand_controller *nfc = to_anfc(chip->controller);
+
+	nfc->prog = PROG_ERASE;
+	anfc_prepare_cmd(nfc, nfc_op.cmnds[0], NAND_CMD_ERASE2, 0, 0,
+			 achip->raddr_cycles);
+	nfc_op.col = nfc_op.row & 0xffff;
+	nfc_op.row = (nfc_op.row >> PG_ADDR_SHIFT) & 0xffff;
+	anfc_setpagecoladdr(nfc, nfc_op.row, nfc_op.col);
+
+	anfc_enable_intrs(nfc, XFER_COMPLETE);
+	writel(nfc->prog, nfc->base + PROG_OFST);
+	anfc_wait_for_event(nfc);
+
+	return 0;
+}
+
+
+static int anfc_exec_op_cmd(struct nand_chip *chip,
+				   const struct nand_subop *subop)
+{
+	const struct nand_op_instr *instr;
+	struct anfc_op nfc_op = {};
+	struct anfc_nand_chip *achip = to_anfc_nand(chip);
+	struct anfc_nand_controller *nfc = to_anfc(chip->controller);
+	struct mtd_info *mtd = nand_to_mtd(chip);
+	u32 addrcycles;
+	unsigned int op_id, len = 0;
+	bool reading;
+
+	anfc_parse_instructions(chip, subop, &nfc_op);
+	instr = nfc_op.data_instr;
+	op_id = nfc_op.data_instr_idx;
+	if (nfc_op.data_instr)
+		len = nand_subop_get_data_len(subop, op_id);
+
+	/*
+	 * The switch case is to prepare a command and to set page/column
+	 * address. Arasan NAND controller has program register(Off: 0x10)),
+	 * which needs to be set for every command.
+	 * Ex: When NAND_CMD_RESET is issued, then we need to set reset bit
+	 * in program_register. etc..
+	 */
+	switch (nfc_op.cmnds[0]) {
+	case NAND_CMD_SEQIN:
+		addrcycles = achip->raddr_cycles + achip->caddr_cycles;
+
+		anfc_prepare_cmd(nfc, nfc_op.cmnds[0], NAND_CMD_PAGEPROG, 1,
+				 mtd->writesize, addrcycles);
+		anfc_setpagecoladdr(nfc, nfc_op.row, nfc_op.col);
+		break;
+	case NAND_CMD_READOOB:
+		nfc_op.col += mtd->writesize;
+	case NAND_CMD_READ0:
+	case NAND_CMD_READ1:
+		addrcycles = achip->raddr_cycles + achip->caddr_cycles;
+		anfc_prepare_cmd(nfc, NAND_CMD_READ0, NAND_CMD_READSTART, 1,
+				 mtd->writesize, addrcycles);
+		anfc_setpagecoladdr(nfc, nfc_op.row, nfc_op.col);
+		if (!nfc_op.data_instr)
+			return 0;
+
+		anfc_read_data_op(mtd, instr->ctx.data.buf.in, len);
+		break;
+	case NAND_CMD_RNDOUT:
+		anfc_prepare_cmd(nfc, nfc_op.cmnds[0], NAND_CMD_RNDOUTSTART, 1,
+				 mtd->writesize, 2);
+		anfc_setpagecoladdr(nfc, nfc_op.row, nfc_op.col);
+		nfc->prog = PROG_PGRD;
+		break;
+	case NAND_CMD_PARAM:
+		anfc_prepare_cmd(nfc, nfc_op.cmnds[0], 0, 0, 0, 1);
+		anfc_setpagecoladdr(nfc, nfc_op.row, nfc_op.col);
+		nfc->prog = PROG_RDPARAM;
+		break;
+	case NAND_CMD_READID:
+		anfc_prepare_cmd(nfc, nfc_op.cmnds[0], 0, 0, 0, 1);
+		anfc_setpagecoladdr(nfc, nfc_op.row, nfc_op.col);
+		nfc->prog = PROG_RDID;
+		break;
+	case NAND_CMD_GET_FEATURES:
+		anfc_prepare_cmd(nfc, nfc_op.cmnds[0], 0, 0, 0, 1);
+		anfc_setpagecoladdr(nfc, nfc_op.row, nfc_op.col);
+		nfc->prog = PROG_GET_FEATURE;
+		break;
+	case NAND_CMD_SET_FEATURES:
+		anfc_prepare_cmd(nfc, nfc_op.cmnds[0], 0, 0, 0, 1);
+		anfc_setpagecoladdr(nfc, nfc_op.row, nfc_op.col);
+		nfc->prog = PROG_SET_FEATURE;
+		break;
+	case NAND_CMD_ERASE1:
+		anfc_erase_function(chip, nfc_op);
+		break;
+	default:
+		break;
+	}
+
+	if (!nfc_op.data_instr)
+		return 0;
+
+	reading = (nfc_op.data_instr->type == NAND_OP_DATA_IN_INSTR);
+	if (reading) {
+		if (nfc->curr_cmd == NAND_CMD_STATUS) {
+			nfc->status = readl(nfc->base + FLASH_STS_OFST);
+			memcpy(instr->ctx.data.buf.in, &nfc->status, len);
+		} else {
+			anfc_data_cpy(nfc, mtd, instr->ctx.data.buf.in, len,
+				      nfc->prog, 1);
+		}
+	} else {
+		anfc_data_cpy(nfc, mtd, (char *)instr->ctx.data.buf.out, len,
+			      nfc->prog, 0);
+	}
+
+	return 0;
+}
+
+static int anfc_reset_type_exec(struct nand_chip *chip,
+				   const struct nand_subop *subop)
+{
+	struct anfc_op nfc_op = {};
+	struct anfc_nand_controller *nfc = to_anfc(chip->controller);
+
+	anfc_parse_instructions(chip, subop, &nfc_op);
+	anfc_prepare_cmd(nfc, nfc_op.cmnds[0], 0, 0, 0, 0);
+	nfc->prog = PROG_RST;
+	anfc_enable_intrs(nfc, XFER_COMPLETE);
+	writel(nfc->prog, nfc->base + PROG_OFST);
+	anfc_wait_for_event(nfc);
+
+	return 0;
+}
+
+static const struct nand_op_parser anfc_op_parser = NAND_OP_PARSER
+	(NAND_OP_PARSER_PATTERN
+		(anfc_exec_op_cmd,
+		NAND_OP_PARSER_PAT_CMD_ELEM(false),
+		NAND_OP_PARSER_PAT_ADDR_ELEM(false, 7),
+		NAND_OP_PARSER_PAT_WAITRDY_ELEM(false),
+		NAND_OP_PARSER_PAT_DATA_IN_ELEM(true, 2048)),
+	NAND_OP_PARSER_PATTERN
+		(anfc_exec_op_cmd,
+		NAND_OP_PARSER_PAT_DATA_IN_ELEM(true, 2048)),
+	NAND_OP_PARSER_PATTERN
+		(anfc_exec_op_cmd,
+		NAND_OP_PARSER_PAT_CMD_ELEM(false),
+		NAND_OP_PARSER_PAT_ADDR_ELEM(false, 7),
+		NAND_OP_PARSER_PAT_CMD_ELEM(false),
+		NAND_OP_PARSER_PAT_WAITRDY_ELEM(false),
+		NAND_OP_PARSER_PAT_DATA_IN_ELEM(true, 2048)),
+	NAND_OP_PARSER_PATTERN
+		(anfc_exec_op_cmd,
+		NAND_OP_PARSER_PAT_CMD_ELEM(false),
+		NAND_OP_PARSER_PAT_ADDR_ELEM(false, 8),
+		NAND_OP_PARSER_PAT_DATA_OUT_ELEM(false, 2048),
+		//NAND_OP_PARSER_PAT_CMD_ELEM(true),
+		NAND_OP_PARSER_PAT_WAITRDY_ELEM(true)),
+	NAND_OP_PARSER_PATTERN
+		(anfc_exec_op_cmd,
+		NAND_OP_PARSER_PAT_CMD_ELEM(false),
+		NAND_OP_PARSER_PAT_ADDR_ELEM(false, 8),
+		NAND_OP_PARSER_PAT_CMD_ELEM(true),
+		NAND_OP_PARSER_PAT_DATA_IN_ELEM(true, 2048)),
+	NAND_OP_PARSER_PATTERN
+		(anfc_reset_type_exec,
+		NAND_OP_PARSER_PAT_CMD_ELEM(false),
+		NAND_OP_PARSER_PAT_WAITRDY_ELEM(false)),
+	NAND_OP_PARSER_PATTERN
+		(anfc_status_type_exec,
+		NAND_OP_PARSER_PAT_CMD_ELEM(false),
+		NAND_OP_PARSER_PAT_DATA_IN_ELEM(true, 1)),
+	);
+
+static int anfc_exec_op(struct nand_chip *chip,
+			     const struct nand_operation *op,
+			     bool check_only)
+{
+	return nand_op_parser_exec_op(chip, &anfc_op_parser,
+					      op, check_only);
+}
+
+static void anfc_select_chip(struct mtd_info *mtd, int num)
+{
+
+	u32 val;
+	struct nand_chip *chip = mtd_to_nand(mtd);
+	struct anfc_nand_chip *achip = to_anfc_nand(chip);
+	struct anfc_nand_controller *nfc = to_anfc(chip->controller);
+
+	if (num == -1)
+		return;
+
+	val = readl(nfc->base + MEM_ADDR2_OFST);
+	val &= (val & ~(CS_MASK | BCH_MODE_MASK));
+	val |= (achip->csnum << CS_SHIFT) | (achip->bchmode << BCH_MODE_SHIFT);
+	writel(val, nfc->base + MEM_ADDR2_OFST);
+	nfc->csnum = achip->csnum;
+	writel(achip->eccval, nfc->base + ECC_OFST);
+	writel(achip->inftimeval, nfc->base + DATA_INTERFACE_OFST);
+}
+
+static irqreturn_t anfc_irq_handler(int irq, void *ptr)
+{
+	struct anfc_nand_controller *nfc = ptr;
+	u32 status;
+
+	status = readl(nfc->base + INTR_STS_OFST);
+	if (status & EVENT_MASK) {
+		complete(&nfc->event);
+		writel((status & EVENT_MASK), nfc->base + INTR_STS_OFST);
+		writel(0, nfc->base + INTR_STS_EN_OFST);
+		writel(0, nfc->base + INTR_SIG_EN_OFST);
+		return IRQ_HANDLED;
+	}
+
+	return IRQ_NONE;
+}
+
+static int anfc_setup_data_interface(struct mtd_info *mtd, int csline,
+				     const struct nand_data_interface *conf)
+{
+
+	struct nand_chip *chip = mtd_to_nand(mtd);
+	struct anfc_nand_controller *nfc = to_anfc(chip->controller);
+	struct anfc_nand_chip *achip = to_anfc_nand(chip);
+
+	int mode, err;
+	void __iomem *nand_clk;
+	const struct nand_sdr_timings *sdr;
+	u32 inftimeval;
+	bool change_sdr_clk = false;
+
+	if (csline == NAND_DATA_IFACE_CHECK_ONLY)
+		return 0;
+
+	/*
+	 * If the controller is already in the same mode as flash device
+	 * then no need to change the timing mode again.
+	 */
+	sdr = nand_get_sdr_timings(conf);
+	if (IS_ERR(sdr))
+		return PTR_ERR(sdr);
+
+	mode = anfc_get_mode_frm_timings(sdr);
+
+	if (mode < 0)
+		return -ENOTSUPP;
+
+	inftimeval = mode & 7;
+	if (mode >= 2 && mode <= 5)
+		change_sdr_clk = true;
+	/*
+	 * SDR timing modes 2-5 will not work for the arasan nand when
+	 * freq > 90 MHz, so reduce the freq in SDR modes 2-5 to < 90Mhz
+	 */
+	if (change_sdr_clk) {
+		clk_disable_unprepare(nfc->clk_sys);
+		//err = clk_set_rate(nfc->clk_sys, SDR_MODE_DEFLT_FREQ);
+		nand_clk = ioremap(0xFF5E00B4, 50);
+		writel(0x01011200, nand_clk);
+		err = clk_prepare_enable(nfc->clk_sys);
+		if (err) {
+			dev_err(nfc->dev, "Unable to enable sys clock.\n");
+			clk_disable_unprepare(nfc->clk_sys);
+			return err;
+		}
+	}
+	achip->inftimeval = inftimeval;
+	if (mode & ONFI_DATA_INTERFACE_NVDDR)
+		achip->spktsize = NVDDR_MODE_PACKET_SIZE;
+
+	return 0;
+}
+
+static int anfc_nand_attach_chip(struct nand_chip *chip)
+{
+	struct mtd_info *mtd = nand_to_mtd(chip);
+	struct anfc_nand_chip *achip = to_anfc_nand(chip);
+	u32 ret;
+
+	if (mtd->writesize <= SZ_512)
+		achip->caddr_cycles = 1;
+	else
+		achip->caddr_cycles = 2;
+
+	if (chip->options & NAND_ROW_ADDR_3)
+		achip->raddr_cycles = 3;
+	else
+		achip->raddr_cycles = 2;
+
+	chip->ecc.calc_buf = kmalloc(mtd->oobsize, GFP_KERNEL);
+	chip->ecc.code_buf = kmalloc(mtd->oobsize, GFP_KERNEL);
+	ret = anfc_ecc_init(mtd, &chip->ecc, chip->ecc.mode);
+	if (ret)
+		return ret;
+
+	return 0;
+}
+
+static const struct nand_controller_ops anfc_nand_controller_ops = {
+	.attach_chip = anfc_nand_attach_chip,
+};
+
+static int anfc_nand_chip_init(struct anfc_nand_controller *nfc,
+			       struct anfc_nand_chip *anand_chip,
+			       struct device_node *np)
+{
+	struct nand_chip *chip = &anand_chip->chip;
+	struct mtd_info *mtd = nand_to_mtd(chip);
+	int ret;
+
+	ret = of_property_read_u32(np, "reg", &anand_chip->csnum);
+	if (ret) {
+		dev_err(nfc->dev, "can't get chip-select\n");
+		return -ENXIO;
+	}
+	mtd->name = devm_kasprintf(nfc->dev, GFP_KERNEL, "arasan_nand.%d",
+				   anand_chip->csnum);
+	mtd->dev.parent = nfc->dev;
+
+	chip->chip_delay = 30;
+	chip->controller = &nfc->controller;
+	chip->options = NAND_BUSWIDTH_AUTO | NAND_NO_SUBPAGE_WRITE;
+	chip->bbt_options = NAND_BBT_USE_FLASH;
+	chip->select_chip = anfc_select_chip;
+	chip->setup_data_interface = anfc_setup_data_interface;
+	chip->exec_op = anfc_exec_op;
+	nand_set_flash_node(chip, np);
+
+	anand_chip->spktsize = SDR_MODE_PACKET_SIZE;
+
+	ret = nand_scan(mtd, 1);
+	if (ret) {
+		dev_err(nfc->dev, "nand_scan_tail for NAND failed\n");
+		return ret;
+	}
+
+	return mtd_device_register(mtd, NULL, 0);
+}
+
+static int anfc_probe(struct platform_device *pdev)
+{
+	struct anfc_nand_controller *nfc;
+	struct anfc_nand_chip *anand_chip;
+	struct device_node *np = pdev->dev.of_node, *child;
+	struct resource *res;
+	int err;
+
+	nfc = devm_kzalloc(&pdev->dev, sizeof(*nfc), GFP_KERNEL);
+	if (!nfc)
+		return -ENOMEM;
+
+	init_waitqueue_head(&nfc->controller.wq);
+	INIT_LIST_HEAD(&nfc->chips);
+	init_completion(&nfc->event);
+	nfc->dev = &pdev->dev;
+	platform_set_drvdata(pdev, nfc);
+	nfc->csnum = -1;
+	nfc->controller.ops = &anfc_nand_controller_ops;
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	nfc->base = devm_ioremap_resource(&pdev->dev, res);
+	if (IS_ERR(nfc->base))
+		return PTR_ERR(nfc->base);
+	nfc->dma = of_property_read_bool(pdev->dev.of_node,
+					 "arasan,has-mdma");
+	nfc->irq = platform_get_irq(pdev, 0);
+	if (nfc->irq < 0) {
+		dev_err(&pdev->dev, "platform_get_irq failed\n");
+		return -ENXIO;
+	}
+	dma_set_mask(&pdev->dev, DMA_BIT_MASK(64));
+	err = devm_request_irq(&pdev->dev, nfc->irq, anfc_irq_handler,
+			       0, "arasannfc", nfc);
+	if (err)
+		return err;
+	nfc->clk_sys = devm_clk_get(&pdev->dev, "sys");
+	if (IS_ERR(nfc->clk_sys)) {
+		dev_err(&pdev->dev, "sys clock not found.\n");
+		return PTR_ERR(nfc->clk_sys);
+	}
+
+	nfc->clk_flash = devm_clk_get(&pdev->dev, "flash");
+	if (IS_ERR(nfc->clk_flash)) {
+		dev_err(&pdev->dev, "flash clock not found.\n");
+		return PTR_ERR(nfc->clk_flash);
+	}
+
+	err = clk_prepare_enable(nfc->clk_sys);
+	if (err) {
+		dev_err(&pdev->dev, "Unable to enable sys clock.\n");
+		return err;
+	}
+
+	err = clk_prepare_enable(nfc->clk_flash);
+	if (err) {
+		dev_err(&pdev->dev, "Unable to enable flash clock.\n");
+		goto clk_dis_sys;
+	}
+
+	for_each_available_child_of_node(np, child) {
+		anand_chip = devm_kzalloc(&pdev->dev, sizeof(*anand_chip),
+					  GFP_KERNEL);
+		if (!anand_chip) {
+			of_node_put(child);
+			err = -ENOMEM;
+			goto nandchip_clean_up;
+		}
+		err = anfc_nand_chip_init(nfc, anand_chip, child);
+		if (err) {
+			devm_kfree(&pdev->dev, anand_chip);
+			continue;
+		}
+
+		list_add_tail(&anand_chip->node, &nfc->chips);
+	}
+	return 0;
+
+nandchip_clean_up:
+	list_for_each_entry(anand_chip, &nfc->chips, node)
+		nand_release(nand_to_mtd(&anand_chip->chip));
+	clk_disable_unprepare(nfc->clk_flash);
+clk_dis_sys:
+	clk_disable_unprepare(nfc->clk_sys);
+
+	return err;
+}
+
+static int anfc_remove(struct platform_device *pdev)
+{
+	struct anfc_nand_controller *nfc = platform_get_drvdata(pdev);
+	struct anfc_nand_chip *anand_chip;
+
+	list_for_each_entry(anand_chip, &nfc->chips, node)
+		nand_release(nand_to_mtd(&anand_chip->chip));
+
+	clk_disable_unprepare(nfc->clk_sys);
+	clk_disable_unprepare(nfc->clk_flash);
+
+	return 0;
+}
+
+static const struct of_device_id anfc_ids[] = {
+	{ .compatible = "arasan,nfc-v3p10" },
+	{ .compatible = "xlnx,zynqmp-nand" },
+	{  }
+};
+MODULE_DEVICE_TABLE(of, anfc_ids);
+
+static struct platform_driver anfc_driver = {
+	.driver = {
+		.name = DRIVER_NAME,
+		.of_match_table = anfc_ids,
+	},
+	.probe = anfc_probe,
+	.remove = anfc_remove,
+};
+module_platform_driver(anfc_driver);
+
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Xilinx, Inc");
+MODULE_DESCRIPTION("Arasan NAND Flash Controller Driver");
+
-- 
2.7.4

