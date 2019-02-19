Return-Path: <SRS0=K7k5=Q2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78BF4C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 16:06:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C56A2147A
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 16:06:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b="ptpbq+YM";
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="VgwTeztc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728661AbfBSQF6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Feb 2019 11:05:58 -0500
Received: from mx0a-0014ca01.pphosted.com ([208.84.65.235]:54434 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725885AbfBSQF5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Feb 2019 11:05:57 -0500
Received: from pps.filterd (m0042385.ppops.net [127.0.0.1])
        by mx0a-0014ca01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x1JG2St6006447;
        Tue, 19 Feb 2019 08:05:45 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=proofpoint;
 bh=4svhW4rCTFtXt3Xg6wR4rUMZ5Hv9s8vJuQd8Dt7FQOw=;
 b=ptpbq+YM5HHJkJ7HPD6W85zayXTuUApX9w+InVLbT9FpSKEycqMB5faybD999Hhsf10Z
 ArLFJ8cmpsN6NCNaPQqNpyBzPh6c54ewtcKSYDWnlUF19MJvB8t5WDrkAp5z9UQkRPQB
 Cq6Hpz3+c4jRcBwNU3dTqVQS2ZMKYlkjFSA9w4gTj57npo5q7g9fnz3fomL1OABMu7i2
 h2VioN1aSRKGPKM14xYAN6ISR8plzjVdenhPEV96eQcFmkHqXfAQwI8LLx9hrYN9YHqn
 HYQTXN2ch78uocEuSbGD0qPnssLw8XY+NLBofVZ8IhfCBiHf/alf1d96V5rxNjh7lYmF Pw== 
Authentication-Results: cadence.com;
        spf=pass smtp.mailfrom=tjoseph@cadence.com
Received: from nam04-sn1-obe.outbound.protection.outlook.com (mail-sn1nam04lp2054.outbound.protection.outlook.com [104.47.44.54])
        by mx0a-0014ca01.pphosted.com with ESMTP id 2qqt6q5jcn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Tue, 19 Feb 2019 08:05:45 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4svhW4rCTFtXt3Xg6wR4rUMZ5Hv9s8vJuQd8Dt7FQOw=;
 b=VgwTeztcTaufJPLxAgbTjueZ3JjGBFsU4KJo1JiLMIhs5euHaVUIhN4W7nMqtLklLPsLutgYPK90dPf3RYU25YJSBn/2MSZldV3f4NTrRg0HcOSY6rbqm+3TkPuoAQPKkDfREOAlcowjQ5B1f5cP+isVDSYB/+mRsSRSZsywo38=
Received: from CY1PR07CA0020.namprd07.prod.outlook.com
 (2a01:111:e400:c60a::30) by MW2PR07MB3978.namprd07.prod.outlook.com
 (2603:10b6:907:5::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1622.18; Tue, 19 Feb
 2019 16:05:42 +0000
Received: from CO1NAM05FT007.eop-nam05.prod.protection.outlook.com
 (2a01:111:f400:7e50::208) by CY1PR07CA0020.outlook.office365.com
 (2a01:111:e400:c60a::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1622.16 via Frontend
 Transport; Tue, 19 Feb 2019 16:05:41 +0000
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 cadence.com discourages use of 199.43.4.28 as permitted sender)
Received: from rmmaillnx1.cadence.com (199.43.4.28) by
 CO1NAM05FT007.mail.protection.outlook.com (10.152.96.113) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1643.11 via Frontend Transport; Tue, 19 Feb 2019 16:05:40 +0000
Received: from maileu3.global.cadence.com (maileu3.cadence.com [10.160.88.99])
        by rmmaillnx1.cadence.com (8.14.4/8.14.4) with ESMTP id x1JG5ZSo010015
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Tue, 19 Feb 2019 11:05:37 -0500
X-CrossPremisesHeadersFilteredBySendConnector: maileu3.global.cadence.com
Received: from maileu3.global.cadence.com (10.160.88.99) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3; Tue, 19 Feb 2019 17:05:34 +0100
Received: from lvlogina.cadence.com (10.165.176.102) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Tue, 19 Feb 2019 17:05:34 +0100
Received: from lvlogina.cadence.com (localhost.localdomain [127.0.0.1])
        by lvlogina.cadence.com (8.14.4/8.14.4) with ESMTP id x1JG5YgF003958;
        Tue, 19 Feb 2019 16:05:34 GMT
Received: (from tjoseph@localhost)
        by lvlogina.cadence.com (8.14.4/8.14.4/Submit) id x1JG5Vb1003763;
        Tue, 19 Feb 2019 16:05:31 GMT
From:   Tom Joseph <tjoseph@cadence.com>
To:     <mchehab+samsung@kernel.org>
CC:     <davem@davemloft.net>, <gregkh@linuxfoundation.org>,
        <nicolas.ferre@microchip.com>, <arnd@arndb.de>,
        <lorenzo.pieralisi@arm.com>, <linux-kernel@vger.kernel.org>,
        Tom Joseph <tjoseph@cadence.com>
Subject: [PATCH] MAINTAINERS: pci/cadence: Updating maintainer information
Date:   Tue, 19 Feb 2019 16:04:53 +0000
Message-ID: <1550592294-1768-1-git-send-email-tjoseph@cadence.com>
X-Mailer: git-send-email 2.2.2
MIME-Version: 1.0
Content-Type: text/plain
X-OrganizationHeadersPreserved: maileu3.global.cadence.com
X-EOPAttributedMessage: 0
X-Forefront-Antispam-Report: CIP:199.43.4.28;IPV:CAL;SCL:-1;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(396003)(136003)(346002)(39860400002)(376002)(2980300002)(199004)(189003)(36092001)(16586007)(54906003)(36756003)(86362001)(486006)(4326008)(26826003)(186003)(42186006)(316002)(26005)(336012)(426003)(53936002)(305945005)(107886003)(5660300002)(51416003)(69596002)(126002)(2616005)(476003)(50466002)(47776003)(6666004)(81166006)(356004)(558084003)(14444005)(106466001)(81156014)(50226002)(2906002)(8676002)(2351001)(87636003)(478600001)(97736004)(48376002)(105596002)(8936002);DIR:OUT;SFP:1101;SCL:1;SRVR:MW2PR07MB3978;H:rmmaillnx1.cadence.com;FPR:;SPF:SoftFail;LANG:en;PTR:ErrorRetry;A:1;MX:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c6f86f0c-a068-462c-a556-08d69684182d
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600110)(711020)(4605104)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060);SRVR:MW2PR07MB3978;
X-MS-TrafficTypeDiagnostic: MW2PR07MB3978:
X-Microsoft-Exchange-Diagnostics: 1;MW2PR07MB3978;20:ERGTgwYs6cB4+rUiYdFDKq9RX1hSQyqN6s3ZQV6IKHgXXds824c6OAAScQZyrlY82qBOgSx6qeybjA/RY/ss6lU5oKl9AWYhJxP2YlZl+RXu7lNed8kHi05OAhk6cPA+wCwH7ZJdR811wD5NjcqpeIkVMDwepmmHKLx0gLG9bh2fOKX2dmAjaG5k2INrWrhYRwasHeivSntAZeZV3TTKxOLPA0Z/GA21bQgLQIhCFHAVe02ASyJ+PmcCraV+57G8e88FMFDBDqdAOALHxPX374AR3QMMaXQBFtN5myoyNFCWGwfOjxM1eRI/g3JkfiNFjnBsyeRB4n0swKDeeiy8o87XcAYih/vnUemYgyySsECMst660XqEvePhiS9BF0Bp3DJZTwCl0tg4+4IqcKibavubWNR/PZqTzpe7DHu+gFCkzqRQC88Mex+o8IbI1RqVJ+ACrS+9AZlmu2poahVp9Mkg59/aZUxUhmx7qoasZBOky5KgIZwOIYqeKplE25gN
X-Microsoft-Antispam-PRVS: <MW2PR07MB3978FDD190F2E2961614CC30A17C0@MW2PR07MB3978.namprd07.prod.outlook.com>
X-Forefront-PRVS: 09538D3531
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;MW2PR07MB3978;23:QzkfjEk0tDsAq5YKsDHwEgI8zjOE+KPKzOr3qgPvm?=
 =?us-ascii?Q?0Id2mkeU3SguooMk/l4reCzUI65pgpvEH8xOcijXGU3/IJ5lI0oHcTQSfzol?=
 =?us-ascii?Q?PW/UcE9kmRMwlVwjbhNapFRn6rf7uV2XKV0kGUokCgEMEcE2KSVirf86M0vG?=
 =?us-ascii?Q?IUsAJnxbo7BWHyY2WiiwHY6PhilkF1RNNRvybH3Hexr5ZiZIHSbrwTSlU545?=
 =?us-ascii?Q?RcIT3xwGtl2Abi/T7xATfZ60kTUTI5KAUmB71srBg6mMypEunN7jnm+N25N7?=
 =?us-ascii?Q?6H321ksQs2fnG7VHKtb/1u1PmcC1eSarLm+J623tRCoBP0xVRBbWB+D4phrQ?=
 =?us-ascii?Q?NnxIHaUw7A3qeo5tguwSuORTcwZYPlJT/Em+/NVhPL+H7sg//XAoL7cEdJAE?=
 =?us-ascii?Q?sSzdKpWnjy5UYmSzhoKp95l2y5ebEeJU7CCyXddy6nIvJ0oYX2QkEkCBwazi?=
 =?us-ascii?Q?B+DOVIXeG7VSI7bqFd5jR0aoBe00yAYeqwD018UmRXyP54uG01WQofpYNDkQ?=
 =?us-ascii?Q?7T4A29oSNkhnA31cQW0NCsqekyE6LyDCq8qWXATfvQ1LRtTp6Wuwt3k5JZ5C?=
 =?us-ascii?Q?NofsSNUwD2aTU6VVfmTIfblhNZsl+reAehlv7s2bQ/wTN3fa17MwiejB+hZj?=
 =?us-ascii?Q?CP4sJbRBA6XgmYfcHfyQK6QmH/PVKNTAR3/4FbFM8bAFtWByGOcMa61fIbSc?=
 =?us-ascii?Q?W7IAStq9SOwk6whZpE1oL46h3pxa0ThbF56KY/guPVOSeIRpEVzO4IYhZ5C0?=
 =?us-ascii?Q?/ZBlf3FtwwKL9xenOOSfxHq0Qdpv1eQNqlASErTPx1yo0FQ/CObYwu1t6v0e?=
 =?us-ascii?Q?2SMEuPFiUHl/ghpcccB9RCtcXhHyF10+Qw3E6s6i1bhOQAQdodg2eD2KVzoN?=
 =?us-ascii?Q?JSLuVfK9cXmZtr6JFTag3xxotpuJzAsuBSepPEYxB1crpi/34vtKSemfbKG4?=
 =?us-ascii?Q?bjSWt9Lx5kWX/Xe6S3quG/tRNCnX++vml68pQnnq+fM+81Ry0zfDhw0eAZaJ?=
 =?us-ascii?Q?XA4+gdS2Gsb0mENmkavaf1Gqg5GzYZpFY54lbjGMWwCsLImMrHoGjyY1/8FW?=
 =?us-ascii?Q?xJ/gV34YBLcfLLoeK/bZ7knQlkuv+tS+7mqCaU2/a7INVhAWRSSlgCSOX5ir?=
 =?us-ascii?Q?9mPK0RRPxyxUBEK+XTlgHi4MX5T2Csu?=
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: 42hXW2bsIPyPKftmX/5ESo46upbA90kkIEQzujR/nDPfyCwOis7RT4LaINAMJRlGcYd3pm18Rh+Icu3b+VwCcZNWKQDuQS5yG9CvIYm/yYyEQu6w2RRTqoo+XOsNZi/Y7RhLY5Qaf3XhUKY9GQxW6Bs3osPhxcHwuPQ+MpTpJTJGoTtk1hFhZ28/Pq0saJdYKbL+Lo6c81DFifOTCB94j60tQSyrn+chNfFW61aoEfk5Z9A4bOhO0zsW8bLw2Y0q8jturfg8CTKEiR36J8/a7yEF2PChTd7WFknPgRmP/OLHvPFEsAfEkNsqd88XqHWjmBoCvMHDsrYf4VAF2kJNYugpQlPPIJ40LV39gCKuvy1B5n52yOE9SPLrstM0Lkj6ecmhTG35u2f8VvWwNdqiJgrXkufrw+zsO7wXSOjRkfU=
X-Microsoft-Exchange-Diagnostics: 1;MW2PR07MB3978;20:eQSJSKB9yDbWeKvrk8oWkAUG3wqYv4r141hG2zRzj2rwyjlMDCHuiuFG0VUXsiVgEQft5v3+xdC1Ybk1gfH2410+CDm1TyR0sTWxNU1+MFZi9LMCwHPvPf/VpnOYszjm2Hr6eiycy5QEYE2n/5TymNEDzNA/SfIVNv6BTNcdNUtXXHbFZx6F4MmtfnAvCeFxQFnRM+NfY+UM0Er8qU/VVjwIPFK22qaI0alcUZG9fsSXWoxzihI5nqEdy/y/enwv
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2019 16:05:40.1264
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c6f86f0c-a068-462c-a556-08d69684182d
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[199.43.4.28];Helo=[rmmaillnx1.cadence.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR07MB3978
X-Proofpoint-SPF-Result: pass
X-Proofpoint-SPF-Record: v=spf1 include:_spf.salesforce.com include:mktomail.com
 include:spf-0014ca01.pphosted.com include:spf.protection.outlook.com
 include:auth.msgapp.com include:spf.mandrillapp.com ~all
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-02-19_10:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0
 priorityscore=1501 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0
 spamscore=0 clxscore=1011 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=554 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1902190119
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Removing Alan Douglas and adding Tom Joseph as the current maintainer. 

Tom Joseph (1):
  MAINTAINERS: pci/cadence: Updating maintainer information.     
    Removing Alan and adding myself(tjoseph@cadence.com) as the
    maintainer.

 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

-- 
2.2.2

