Return-Path: <SRS0=/Ixz=KV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30691C46472
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 09:18:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C62AE219EC
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 09:18:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nio365.onmicrosoft.com header.i=@nio365.onmicrosoft.com header.b="FJOuue9y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C62AE219EC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ni.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729690AbeHFL0X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Aug 2018 07:26:23 -0400
Received: from mx0a-00010702.pphosted.com ([148.163.156.75]:48028 "EHLO
        mx0b-00010702.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726572AbeHFL0W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Aug 2018 07:26:22 -0400
Received: from pps.filterd (m0098781.ppops.net [127.0.0.1])
        by mx0a-00010702.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w769BErJ009106;
        Mon, 6 Aug 2018 04:17:47 -0500
Authentication-Results: ppops.net;
        dkim=pass header.d=nio365.onmicrosoft.com header.s=selector1-ni-com
Received: from nam04-bn3-obe.outbound.protection.outlook.com (mail-bn3nam04lp0111.outbound.protection.outlook.com [216.32.180.111])
        by mx0a-00010702.pphosted.com with ESMTP id 2kn85wc4uh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Mon, 06 Aug 2018 04:17:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=nio365.onmicrosoft.com; s=selector1-ni-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LU3+MX0sg0TCo8gs2G/Att2PneJ/ThMbql8jMx8h+7s=;
 b=FJOuue9ycLKDOOggBdgiiE0GHpPn7U8LpOUU9E1Xtl6Xw8m3SmQQ59OCbShGJv0V9AjsI7cUUC3RqIj0AGQqFcYph9McRbNkxGeKTqma8BU5gSWKtYlkptzbCormxJ0GT/rek5KHQb6Nqt2F7Up3F1/yupK80PTuJLKHZleRA5k=
Received: from jcartwri.amer.corp.natinst.com (130.164.62.116) by
 BN6PR04MB0964.namprd04.prod.outlook.com (2603:10b6:405:43::36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1017.15; Mon, 6 Aug 2018 09:17:44 +0000
Received: by jcartwri.amer.corp.natinst.com (Postfix, from userid 1000)
        id 057C6302F5E; Mon,  6 Aug 2018 04:17:39 -0500 (CDT)
From:   Julia Cartwright <julia@ni.com>
To:     linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        Carsten Emde <C.Emde@osadl.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        John Kacur <jkacur@redhat.com>,
        Paul Gortmaker <paul.gortmaker@windriver.com>,
        Daniel Wagner <daniel.wagner@siemens.com>,
        tom.zanussi@linux.intel.com, stable-rt@vger.kernel.org
Subject: [PATCH RT 12/22] locking: add types.h
Date:   Mon,  6 Aug 2018 04:17:28 -0500
Message-Id: <c1dafe11673fe140e4155fc3fb2e480c073d22d7.1533540554.git.julia@ni.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <cover.1533540554.git.julia@ni.com>
References: <cover.1533540554.git.julia@ni.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [130.164.62.116]
X-ClientProxiedBy: BN6PR04CA0052.namprd04.prod.outlook.com
 (2603:10b6:405:3b::41) To BN6PR04MB0964.namprd04.prod.outlook.com
 (2603:10b6:405:43::36)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9b083d3a-3326-4dc1-2058-08d5fb7d780e
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:BN6PR04MB0964;
X-Microsoft-Exchange-Diagnostics: 1;BN6PR04MB0964;3:CSOWrb/KMqHgFwqPfs8Y/JuSM8IlPw+XepJ6lG320fDgdRgzhZf9HUvtMHVSpRmNzdHizqdsyB6B38yxQuwk0almJuK3V168lwPT6/P47mmL69tsjpnmWza5dOEzlp4CHCriKCHnHX2XGFOzGIYLboDObzP+VQcPT7SZr63LOLokEQHLnZ/ORKBONtaa9LHtYGIg+EZhHUNSGlJNRJ56+uoFhDouvTuZNXNhHAhox2humqUs7cBdNP5cRYjJHDRO;25:GHKiWMRgGEPlUmKZN1DKqNJSM8BGc6JHqyR41f7V3wgkLpWLEZaGHQQQK/gAlfSV/X2v6V12vIxAulr4c3n7zioF0kVMdIXLJbeA1LtlUhAG8ah6xFbT1wjGkr6x9ryQRFTUsvcVeeJO1kLrw6E/VZ8CZIti/I9iCSfJ0H5qFL9oXvpprd7F5b03k/7iCusF8IezJxkhqb03+AKLC+XVjGZUD3hszQdU+MpCioPSvT161lRiGkKfs8TWWT3anpjrTYBdbG+HsXo/hNGTZlchRwysR2ioQy50pBGAs8nwfPAnnTnRchH8xVT9OQ4gqQLOeDSYW59OuCrB9oLE6D2nTw==;31:JEE2JNPHdAazEFZY4oQOudhWMS7EDlMTkVlhqbtBb0YeTgkmS6TZqiZKC1iY6FE9lHM4CSFJD6grofbfldEzdM80SYfeTJSy1ZwFnCW5akerOz5xdH68EQYRBcem2VosTEw3vRAtHP8lOCyTJd5idg0WjPg8s2oSApRJHOyJL40UtRnQ6PbCBQ5nXoLKa5q5WvR3OUR2owO3jvyLyHHt+vNpzflRtDjJpK19k2p/EC0=
X-MS-TrafficTypeDiagnostic: BN6PR04MB0964:
X-Microsoft-Exchange-Diagnostics: 1;BN6PR04MB0964;20:kpqdEskxUQGdx69dTjM+kDzh/BzUwrGicVr/Rm7OVo2yCuJwKFO0aPZRyt8sQKz9SDtq3mHC74n9ZRN4nGKzH81XpXWCtrUNPupTFhtexPG6PMfnu1HAtb9UPI2oUwQ0dae7LqaedEAimrdcOlRVH6lwNzC4R8sgcdhXtYqO9+kykxzj3ewi1KBpKOCwpDqX5s13ImlsNigs35a6Wv5TiL8liWQtkP+JU3FXbOFJHOtchbYBAF3xtaBoSe+QX6Y0fMXYvycMjEoMgodFB4D8e/a/mz9bgFffCFE3HnEpNse3ykbcGbrUO5HSJkfNvqmMeFj2pvtqqHshopSfFRBrSSZitML8a/6SDEJDkXFH75ZWY9ny7LJYBGYELTHAeacd0WCe6CtyaYEy7EL3ETXvwF6jrk7u4yhcXoSzrIgQKOBWpCLpBIN+f2B8nSb2hhJCCKnsc1of5T9K4wXO3/JJYQxNqwJLKc1sFrxU82vz3KDXmqpoZfVVE59DZesmtMYRLc1gr9UVGDmR56p6eKKP0TCiD9ARU15ELh9pBW4g5YgXBdQT549SQdgn3s2Hfa0cL47lie/JEY3tfArzz43gOZcJrHM8j9yYwOxxpXXwwO0=
X-Microsoft-Antispam-PRVS: <BN6PR04MB09649ED256B6E492EAC4BA18F4200@BN6PR04MB0964.namprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(9452136761055)(145744241990776);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(93006095)(93001095)(3231311)(944501410)(52105095)(3002001)(149027)(150027)(6041310)(20161123562045)(20161123558120)(20161123560045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:BN6PR04MB0964;BCL:0;PCL:0;RULEID:;SRVR:BN6PR04MB0964;
X-Microsoft-Exchange-Diagnostics: 1;BN6PR04MB0964;4:eSHLJifCgV54lKTH9cntjjBhDuQfGnOHInodF515QC55Fs5uE3PPuxLcwWLN8zjW/T+5SXDhpEIUaY1TMlYr9kOGugPlMMnC4EP/OLuhZsODQ1e1hDSNfssvd/aN+J969Fwnhmgt0ad2nD0SmcdV61dee3x4lw6+j3aNk7LUryTuVqCl94Zsi5PH+yrqgQl8xS7czWhHM4kAVhoos5DHY5prpqxaxa4egcGyjvCS7HtdZdnIwj0KyspfDlNEcvvL6TKOetgqupdEMpTUcBV0VWNZfHpEuRvYGTKG1XbaHuBF6wG2B66dTdaLPb4Vo6KdWrF3TnfXQFCMBTfbm8Hs4BmfOamV4G4o2lE8/wYSN/g=
X-Forefront-PRVS: 07562C22DA
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(136003)(366004)(39850400004)(346002)(376002)(396003)(199004)(189003)(118296001)(76176011)(81166006)(446003)(6116002)(305945005)(7736002)(8936002)(54906003)(386003)(316002)(53936002)(52116002)(97736004)(50226002)(51416003)(81156014)(105586002)(8676002)(66066001)(47776003)(16586007)(106356001)(42186006)(6666003)(36756003)(6266002)(11346002)(90966002)(4326008)(5660300001)(14444005)(3846002)(122856001)(476003)(2616005)(7416002)(68736007)(50466002)(48376002)(26005)(2906002)(186003)(486006)(52956003)(478600001);DIR:OUT;SFP:1102;SCL:1;SRVR:BN6PR04MB0964;H:jcartwri.amer.corp.natinst.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: ni.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BN6PR04MB0964;23:+QMpAwDtNgQE/7nsaZnqi9r/7KDvGE+6pQq8Idj5D?=
 =?us-ascii?Q?Wit9Nu7ykoVY0ryEKycK61VQ5L8dMlUtxGSSXZIeM9Lzp35NdYa6Nk6szEzS?=
 =?us-ascii?Q?XaGose2LtEbPFCl7DHd58jbICTaKHPhj2Jd62jIPp41s76eod5UdkE41V4+T?=
 =?us-ascii?Q?kfeMGTuo4CxKLPr32a1GIayApLCmTTLU0oSTfLnSEItCehO9r/2VU/iPeLln?=
 =?us-ascii?Q?QJFSEyiruHGrbkARsTU9laI99ybjQ7Dnwd3GFZf085vE5TDMLOVxYyY1iabe?=
 =?us-ascii?Q?Kt6buS3X0t6U0U7e2WX1cd4p+Ror3UKeoJX5/zPyPQviiyvFXhaUr0yb+6ed?=
 =?us-ascii?Q?sYv8tqUAypd3mfRvE8Z9pGmEFXPs6emfdJAbcgOmjV2D1ezvmw5X/0A1iyqi?=
 =?us-ascii?Q?tREFEYIfY4QeFWDQItv6R0q5f3EKp7+2LRrRXE1eTtucbYFxpxe2bzzRIIOx?=
 =?us-ascii?Q?a2KRnwEMcSB2L4kCriJnEzlA9sPxkyJgoKirYqcjjIDbYE/2tfo4j0RA64gt?=
 =?us-ascii?Q?iLJXytwXv6zyAEufKze8lYEWUtpS7cuB9/pBR0xxj3HNFQuJLAbwoHLQwvxg?=
 =?us-ascii?Q?CCur5jM6qt/IeF3k9iaVdpIcbpusBM5FvwjE1rC94lQC44wb6mcnLKuT0Mi+?=
 =?us-ascii?Q?CT5asz/iiXwshg1ZoIfguwAUbJMiZnJjEgJpnk9cpk4UbIcEnhbEDsWxha/P?=
 =?us-ascii?Q?+6YeJXFl4Si3iJ4/6SnSUqQFVofPtEvsV+3DrfXgqS6xYbJHbClPP68wb33i?=
 =?us-ascii?Q?8w9Q3KiP9T4chxQvygJx4rE55qG7831SjiI4rU3GLYNQV6c79ME8QF59rBYN?=
 =?us-ascii?Q?hwEwMLRY12KJ91zgKArblWKLsFg43OIWyXUAXkVWmmrvZjdWEtYtt4v64QS/?=
 =?us-ascii?Q?cY65wU+pBhJj5hDGY0Dflv9OLc84LeQM2gebItxSgCU3oxkLn0B7YK7yF5N2?=
 =?us-ascii?Q?6NEeXNwfDmbCtEgQavmiLKFaF62//46ohafA5IAISbqhFdZJFqRiuZ1l8R4V?=
 =?us-ascii?Q?iU7bGP4nOFCARPSJQdR9hZs6MwuLYj292awD9sAmlDMTdyQnpjOzix8YYRSy?=
 =?us-ascii?Q?DVwBHdYvmbZcwoFGw8vod15LZ1aH32jaEuJFOGpFmywcCi2TGt90pEF4GJ9g?=
 =?us-ascii?Q?szIYHkmMrs0jI3sVcbPm1pyw26qdA7H8dsa1iPM/Uupwbzs+AHNUezOrE+YZ?=
 =?us-ascii?Q?3A5AC8O2gtaabdHGd/O7SK87YBcMej4qHr2?=
X-Microsoft-Antispam-Message-Info: TdD+zq7F5D8sSQTCXJZkuHqHcwLnW8Z9YQmS17CYyRhMYMACl+jYLIgxZlpWHVQiXsWoGv9TI0AjIvaNToBim73FdWBRoUmezQPpF6hVB3nC+jaXre5eDvTNi+LVsoKrAjGoMwyUL1u5EBiVdvhaLshFJ1ulv+OvpWCM9Nbl+YsX/cj0Jej0hpnRpo055CqVWbifKNddIjV4HkOYPNCbZotPr2/NJo5Z6ONjJsg6OqxlCI0iyRkK4T7hTma2u66HpDY941zoAPilssQvaQwFy8X8xAy7LP5HBXVxiasvv+9dYdsloYCnqrku7qrL58gyCVwYcygOka/Job9KY0UYxMYrTPFcOhpB6znd+U73I1Y=
X-Microsoft-Exchange-Diagnostics: 1;BN6PR04MB0964;6:owF1hWLHPr+58y2EAvCPDgZEjOI7nEPfLjiiiSBoIpmwwxj5H1wg1Q4WTiKdAAPTFaEajck/4priOAxZYG92amOGTMmD5o6my822rQxwJb24xnTxQYe8pxVAeUqbldd+aHBLUgRtykSsqRWXFENEBmiQP64UaYSylSeMowzhSWF2DC8WPl7nPuuZwYyLnAkD+Q90vIUJTzjfq6XmfzkdA3lty7l2hBkr/9KeCDRnILZRI5pAxlOV0Jaqk62kOzDe94vc5w2FCZQCwVb+ieoguYWdfUTdu2gjWPN1U2b4Ymu2GriAtIxO8rciqbCOy96gfR6NrvB4P+Omi0mILMOSGkMrTfQW2hvLpx9sH7VArf6Ax80apDoQohrVKbbHQ7bZ3SSU8gAIvQPx1Y2J0CpitmqMdSQjme/z/tX1LhhPRSoi+Y/c0KiBObuUTqLefrOGDejMV7UYhlX8QozSRrSJyw==;5:24hJZ9FdR2pWCo5V5k7Xp5YOim6e9uIUnY5MreEIjNmOlap9aG4M+tlhiETdZET28hbQh09D6eV14d/LAIKVaFx/pjTFWD6OXWtKn/dRznDRmVp3rFM/cKMbZzaaA3jJPswIiibACsuUhnXSfCJ88v5C9FpaBOzOKUdkeM+SXlU=;7:DxRZOh7NIc5pk3MfnSBxMwwvpmN0I2YHi3teZt4K1b0jgyrgRgy/8cAvMapz/fY6wXV+qyaGN1WpPWPmtxRcIll8yBtXC9oaWOz8om1cYONIc2k+Y19hFXDetk6w/Cvip8WPtoplelKrCmyfKbb4sWe7suHWu0MtExFqqG2X0B9NvP/WQU33PFOhodEmcYLnxujTtu2mffTfQXKRPnoAKcxoFGU3pepZF6HGDb/RkcuAr8AVv1LyiPhwJNsZw2S8
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: ni.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Aug 2018 09:17:44.6156 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b083d3a-3326-4dc1-2058-08d5fb7d780e
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 87ba1f9a-44cd-43a6-b008-6fdb45a5204e
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR04MB0964
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-08-06_05:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=inbound_policy_notspam policy=inbound_policy score=30
 priorityscore=1501 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0
 spamscore=0 clxscore=1011 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=968 adultscore=0 classifier=spam adjust=30 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1808060100
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

4.9.115-rt94-rc1 stable review patch.
If you have any objection to the inclusion of this patch, let me know.

--- 8< --- 8< --- 8< ---
During the stable update the arm architecture did not compile anymore
due to missing definition of u16/32.

Cc: stable-rt@vger.kernel.org
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
(cherry picked from commit 1289b06974d64f244a26455fab699c6a1332f4bc)
Signed-off-by: Julia Cartwright <julia@ni.com>
---
 include/linux/spinlock_types_raw.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/linux/spinlock_types_raw.h b/include/linux/spinlock_types_raw.h
index edffc4d53fc9..03235b475b77 100644
--- a/include/linux/spinlock_types_raw.h
+++ b/include/linux/spinlock_types_raw.h
@@ -1,6 +1,8 @@
 #ifndef __LINUX_SPINLOCK_TYPES_RAW_H
 #define __LINUX_SPINLOCK_TYPES_RAW_H
 
+#include <linux/types.h>
+
 #if defined(CONFIG_SMP)
 # include <asm/spinlock_types.h>
 #else
-- 
2.18.0

