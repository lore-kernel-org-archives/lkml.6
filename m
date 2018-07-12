Return-Path: <SRS0=HMm1=J4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B4F5C43A1D
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 05:51:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D2B4A21479
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 05:51:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="f5hQRcO3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D2B4A21479
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=cadence.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727175AbeGLFz6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Jul 2018 01:55:58 -0400
Received: from mail-eopbgr710084.outbound.protection.outlook.com ([40.107.71.84]:51372
        "EHLO NAM05-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726852AbeGLFz5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jul 2018 01:55:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ji1m4iG/sxD8Qkdr+hJrT4G43uhFY/Oa1Xi31q+aR1Q=;
 b=f5hQRcO3Q+3PmeMpR91ypME5UN8af5TcnmpwuuKewizOhoYzpf/ajM/PaYZXoVDDx9WeSwcbN462MhxAMvJXuOnMvA97irfyuucwkdZ5LGMWn+ah45Q/v/KnwnouFa9m+Hk8WoOCu51Ln5SPPfD/V+vd5dwlkjK0Y5CWtElZcZM=
Received: from BYAPR07CA0013.namprd07.prod.outlook.com (2603:10b6:a02:bc::26)
 by DM6PR07MB4714.namprd07.prod.outlook.com (2603:10b6:5:a1::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.930.21; Thu, 12 Jul
 2018 05:47:59 +0000
Received: from DM3NAM05FT036.eop-nam05.prod.protection.outlook.com
 (2a01:111:f400:7e51::200) by BYAPR07CA0013.outlook.office365.com
 (2603:10b6:a02:bc::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.952.17 via Frontend
 Transport; Thu, 12 Jul 2018 05:47:58 +0000
Authentication-Results: spf=softfail (sender IP is 158.140.1.28)
 smtp.mailfrom=cadence.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=fail action=none
 header.from=cadence.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 cadence.com discourages use of 158.140.1.28 as permitted sender)
Received: from sjmaillnx1.cadence.com (158.140.1.28) by
 DM3NAM05FT036.mail.protection.outlook.com (10.152.98.149) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id
 15.20.973.9 via Frontend Transport; Thu, 12 Jul 2018 05:47:58 +0000
Received: from maileu3.global.cadence.com (maileu3.cadence.com [10.160.88.99])
        by sjmaillnx1.cadence.com (8.14.4/8.14.4) with ESMTP id w6C5lkw7032054
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=FAIL);
        Wed, 11 Jul 2018 22:47:57 -0700
X-CrossPremisesHeadersFilteredBySendConnector: maileu3.global.cadence.com
Received: from maileu3.global.cadence.com (10.160.88.99) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3; Thu, 12 Jul 2018 07:48:05 +0200
Received: from lvlogina.cadence.com (10.165.176.102) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server id
 15.0.1367.3 via Frontend Transport; Thu, 12 Jul 2018 07:48:05 +0200
Received: from lvlogina.cadence.com (localhost.localdomain [127.0.0.1])
        by lvlogina.cadence.com (8.14.4/8.14.4) with ESMTP id w6C5lnv2029678;
        Thu, 12 Jul 2018 06:47:49 +0100
Received: (from pawell@localhost)
        by lvlogina.cadence.com (8.14.4/8.14.4/Submit) id w6C5lngY029669;
        Thu, 12 Jul 2018 06:47:49 +0100
From:   Pawel Laszczak <pawell@cadence.com>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <linux-usb@vger.kernel.org>, Felipe Balbi <balbi@kernel.org>,
        <linux-kernel@vger.kernel.org>, <ltyrala@cadence.com>,
        <adouglas@cadence.com>, <pawell@cadence.com>
Subject: [PATCH 14/31] usb: usbssp: added procedure handling command completion events.
Date:   Thu, 12 Jul 2018 06:47:11 +0100
Message-ID: <1531374448-26532-15-git-send-email-pawell@cadence.com>
X-Mailer: git-send-email 1.7.11.2
In-Reply-To: <1531374448-26532-1-git-send-email-pawell@cadence.com>
References: <1531374448-26532-1-git-send-email-pawell@cadence.com>
MIME-Version: 1.0
Content-Type: text/plain
X-OrganizationHeadersPreserved: maileu3.global.cadence.com
X-EOPAttributedMessage: 0
X-Forefront-Antispam-Report: CIP:158.140.1.28;IPV:CAL;SCL:-1;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(376002)(346002)(396003)(136003)(39860400002)(2980300002)(36092001)(199004)(189003)(126002)(7636002)(51416003)(47776003)(48376002)(478600001)(8936002)(305945005)(106466001)(86362001)(14444005)(356003)(1671002)(186003)(8676002)(36756003)(246002)(26826003)(5660300001)(76176011)(105596002)(87636003)(50466002)(4720700003)(446003)(54906003)(476003)(107886003)(2906002)(16586007)(575784001)(50226002)(42186006)(486006)(316002)(2616005)(336012)(11346002)(4326008)(109986005)(6666003)(426003)(26005)(266003)(21314002);DIR:OUT;SFP:1101;SCL:1;SRVR:DM6PR07MB4714;H:sjmaillnx1.cadence.com;FPR:;SPF:SoftFail;LANG:en;PTR:corp.cadence.com;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: 1;DM3NAM05FT036;1:+laktQhW1654GaBL6lledq5bZRwgf6/BmmfpHNpRMUuX9CPrLwjQWvbxAlG2YV2/CFBe6EfjCTqKQA+W/Jkg6Eth4ZkKP4cOFSj2LXguSx1kGwYU+02maASt/Qx0u0Z4
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 05c61b92-c52d-4969-bf77-08d5e7bb05e3
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600053)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060);SRVR:DM6PR07MB4714;
X-Microsoft-Exchange-Diagnostics: 1;DM6PR07MB4714;3:38gNrUvZPkr1xl+f6bBx9q0u6fFIoim2oWKAGxqlhKX+vP4tQQkixoy7nXwCDnYx3/waEb0SfI6WaoZjqey28diactQb+WlnZ+pis+oQ9rFlgXnVSg646HhW5bX2wlsiBS7EDT3sFdqjPOJryd35OCi4WmpFM+veFPk6J/eiMsFlH4750bCMY7yFpt8JPPMDRf2NxUHRGhcZuAY6ef1QW4dVOcdcsFewNwGf+hKWFjsAmDY5Pvh0t4HsvWy4e3XdvQqv6Cg01AShXnNNgySZ6gWMUe0e9eAmt3kICpVnqsuB45WiuVQjStavM6m1uACZb8Dl90PUwlmN6CmMSnOyE6wTpIGXd3PphNqNTusl6uk=;25:mgTVjeOxk+vpeZMeZJRlnW0xrIeHAPOr9WmhDuBePfBVmecMLeWmbthilfCfS13sv5cx0y71HhZzotqP35nDhctoZjKecFkrTa1YtVw9g5I10bAjZA3c4pP40Wn58QgPeEjKAHhcqxqs+aFIb4wwvK2BImUoPUTZX/IS4iS3eDmgSjEqDFAdtGC+hbrYF5IcMqjqe2iRPiUE4IUAEs7AwaRLgJzL720MNxDRbBf4adS0O8QomYtztsGXaxm8N8lcQPoSveVJGwALJ5yjFZecpfXx1LbsJKtb54Ri6oBa7SWKOxrJQnpDDe1oao54V6vJWvtJ24Anr/GrcFEygCh81g==
X-MS-TrafficTypeDiagnostic: DM6PR07MB4714:
X-Microsoft-Exchange-Diagnostics: 1;DM6PR07MB4714;31:Bv7Af7ikwEpQpZ/7zFzf8JrA+BHeJAxTaCXg7FFfl6ljLu/DajTZl+eF/yiJXhH+gUFhTLZ23XaLNRg7VXNggMlbBaIEmejXZALgapwvW5Y4S/GTn9EKSa9U2cBuPIQvJAXzWYVeUuRpR59rJm3aUx+4tUE2IzH3fd4EBZtyvcqzO4jOSeoJqUd4+2HFU0kK2QrLnGSnLgiVk0jOOxDwI2ZnIYd3LCkQ2xwfwz4qyDI=;20:87m+lYNa36N2gqTj1fINs3JfCjWC1S+XbGVrqr04zQwVcnURuMA6YhY3JC1gjNBqpkBQ75pP3vENZc0HtjEhdtO3XEwsfUm/VFO9QsZ9uLZMaLNg9Gwol0DMgTl3vJIAPtP0emr2Pgai6Xwv6/hEP4/irjucOzkRSWEFImy+YQBDQ5UTntukNv4RWvsgNAuLZwBuVyQJqTkastSb6ogh66j5BfTKvPsOqKdF23hsqNpiDJ8ZF68veW8Hrku+JEQEy5u4TGzXy6vMf6ZmAAvzRlsvRYTPTtkKkG+mk6VUJ672XLtlCzENmWsJ8zk/qSkXyxaGse7tjYEDX77DFiWT7KqzC53PEUaDsrlx391LlXbcxM/Wb5p/1MZNLoMGUtfdaRQ+eOPvcpBHdn/rVn6u3A09XlHUITIitINKC6gjAnaqejov772jq156F+vldWPU7WWl9p68nSNOFVxxlcdowuNi+z930m4A1WrZ1qEoyW2Qp3L9M9P9iniCln45PZYL
X-Microsoft-Antispam-PRVS: <DM6PR07MB4714180AF3508D4A345364CFDD590@DM6PR07MB4714.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(72806322054110);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(3231311)(944501410)(52105095)(3002001)(93006095)(93003095)(149027)(150027)(6041310)(20161123558120)(20161123562045)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:DM6PR07MB4714;BCL:0;PCL:0;RULEID:;SRVR:DM6PR07MB4714;
X-Microsoft-Exchange-Diagnostics: 1;DM6PR07MB4714;4:F4Iy5WX6k+fcklBY84HOl7Qn9cl7i/hOrQkHed0FN/tRy6lD9p29WsP5PClx3ZsqOev97aGHVEv1fLH2x0sc5nWIL5vidx/FH6RVJiIY0B8vEnmDhHG201UdJvJ/Nl5LjD5T4gYJBLU2Qc+0yEKH1ZdZsiC7gF0MWh0baeeVtPIrbeN/C/OtQDpJEb30fdu+CLLV8E0yLC+B652GNpYaIFI0FCqjpKWwcRq5X1m4HNl8DPGr51jFCjWnXZcjIMUys0W+jEUQfPmziQ5sWN/KriRbrKsjS2BUASk67vR72QYEvW8IB6iq1jvm9h8sYgIN
X-Forefront-PRVS: 0731AA2DE6
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DM6PR07MB4714;23:8QG94CdskVkGND8/WeTccbtF38brkLfsiVcK1vhbm?=
 =?us-ascii?Q?RO0jsTkfR4dCaVqA9ZtKFw9bfHd2GwNspJoVZXtiocAFWhHFKn7CmrkcpFfT?=
 =?us-ascii?Q?0GlE80tSt19pd047KOC09xgQe/y+ixlYKC/PWfgW7VOmoMywLk7iqOwDFUhe?=
 =?us-ascii?Q?hbgvwkXZaCLqpGV2BawKXj0qLRwUZ/VHlH6m6SsxoNmYJYNDO+Pq2VQkt5f2?=
 =?us-ascii?Q?3ZFrA8P5rqIgNjdfHWNvpevSMrc2ZwlNbkkBCmeHknJAGTYcIhddbxxS5mw0?=
 =?us-ascii?Q?C90u9GUZScKsb2hJdRYjzjmPrpMOjMEBxtxmjGMwvWGW7CX/jLxw8jq9wGiV?=
 =?us-ascii?Q?+Axy+FdHryDPUWT0qqKbN3PJfij3FW+W8RrNyrlYntxzZ8frkwEduLs9xbRw?=
 =?us-ascii?Q?tuw1brU6nvnIJlhfZsC8wI9RT3kOsKRLf4FXcpsd18kMSqaGRt6kpCddvnev?=
 =?us-ascii?Q?sFerlvWHJDoP+OhqGl2DZEK6QOlmaqg+sGuYg9PB7p/addIO6QCpSUrz4NVO?=
 =?us-ascii?Q?sjmUAkJqRpdL1UraII7K954irjVvN95Rkw0pppGcjiV1/9H5DAG2C3jRzbFZ?=
 =?us-ascii?Q?UAxUiLqH5UXPbc4d5OcZGdoLzQT3C+YB4DEETnqt01CohV0CISDtf/B+Riw0?=
 =?us-ascii?Q?QxEbusUQkZsy7vH7BDe8EeU5NlX/eXJ7i0J7JPCeFJjgLW+1I0wkUC6tN+/7?=
 =?us-ascii?Q?Dy0+sofiICs0Em3WdWRJb9WRPSrRDnOncHVqfd01+jM3PLeoUBY0V/f2DF67?=
 =?us-ascii?Q?sXscVY7BHy7Ul1Kza6146IIFr7A3T8mLMAvJ/s0HN871uTh2VZ+eQGx7r1wi?=
 =?us-ascii?Q?YrqxuR1jdQNX2jDTbMLzewBfEGYXRHHcYVp6okww2xE9HuiHMB6zDH9PPetu?=
 =?us-ascii?Q?X5i4cjjYcdy3LDlMQP/24U5OCuLsqtDVnEE6hBQ2X8L1wLKWv9P20Bd8gLf8?=
 =?us-ascii?Q?x4DqRxWXx4xeXaG0kc/PrQA4YN4jlyd15TSauh6LLPiD5pcGQlJMvJ0q2HCS?=
 =?us-ascii?Q?8KBqyWNBKHe0BGBTqRrCu4snLUWW9YwWY5kh34L8hLGSmHFk2B+ezCqjTpJ9?=
 =?us-ascii?Q?KfkNX+vPBSiP9gTVMqXCVWGu8rhLjZxfT1aTBCnh7WnKbWxfnlNUeEuqzW0s?=
 =?us-ascii?Q?n3WWzYbeI+8jnukzjw9W6xZEMAST2f4PvJYchtRnptVSd0sI4SHWXJ1t4a6g?=
 =?us-ascii?Q?gU7n3Chzm08YbAL5iWl6jz6Ii0K3910/lBp?=
X-Microsoft-Antispam-Message-Info: HFjdkqYH/tl9Ueqct4UNyPD4L6FW/T6uh59Z3+tw0JJejKj/Ix7GL3llGgNcK2wDHch7yQRxudAMm7R5RIuS1C3uzBriEfHA0gmelG/ZZe0/M86xSIwyuNOjueOQkRIVs6xKL6Fi0VvuCfaaSR26Q7KdDmngyOHQNaxbNnAApCB4EvnpDm0crIBiBpi24mNSwS+URH7SwDAlNNywNrv+QZROxJzPVf4NQh816jOUSa8Q9WKCCxfWu9BnznJQTsKHvmrT60ru5CUYGc2/PoV8YsYWhYDwnFJNMHZXqqb2pOVMbWBQ6PxKmq6nlw4dM2vU/WtOAaec9n3f/T86vQ5PZ5DpfEY1JfzGNlNTDaZ0H6t8runRwM542aiuQoCtuGs85Q4FYvzitCEh7AW6x9ctyQ==
X-Microsoft-Exchange-Diagnostics: 1;DM6PR07MB4714;6:HNts1HgEtD7ujKrlHSzNzMqTSo1TNMMyfeQXH/DInGP/Kb3t2y9VtHjdJbeptzC1mTjMH9otbdoDIaQ2LZlxTMD228UVYFiIn8nMF19ws8ALASl3C+y1wpOgi+W4p85RMKf7TZ5T1GZDSPs6uLcgAHDwKoyhSiZoiL4HXgfXVxgac5YXDYImRwuVqVZr4uwsJ/UJBrzLYJNWE944IknHIivQVIUrWFqVR6R/x+5+I3yojatROXBY8+3IQ4dOcrzCeOUbPW5UpJoAlaQ9cbni/hAJnqGuAfDNVVKl3CQ+535We/fqf8zsoVEX3M/PRLlSDRYmsKSvAmYYd4Yu6RTR5piprfh14SFSFORCTPNVcpQd+NDtNVa3k4ewyKAaEHZV+puYdqN4JeGnqtvTdLYpmi+8Q9Jk/odHvsd1IFNs56kK2qgF98FzAWQVvbqIcFE7FRCysULbe24sqiBPWcQQpQ==;5:D2bgANlYWgR0FArv1s9E2PjBp8vleS4GZ60IkE3mCuqSLXLGJh+6o4KJtA0LZTbHvmInYOTf/ZubS2QbFcFPuR4i52JFzPEjJ6XV1RseaZIgcf9YVLuZv1j9GM+siw2jQSibh16IXLSdOMUawt8yABoqrjWJ9f9P96DLmAKmAQA=;24:RrmVu3lheOlSYfsaf2XBVkf642rDmAa5bR8xlbkAFPX611u5xdJNtHV4vnFEP53VifvsPZYzvU/+rTv88dF+VVn3BlWZcB5KqgEmR4nW8Wo=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DM6PR07MB4714;7:fklBUuFOIgWYGBywGLRuIKV0l5TB01IkyTYoVvfQrY6r4C1Jw8tmmWueVAquYrSRGcG6ekQ9RNKl1NWszS3zv5YfUQTZrUDYH78f2vtlCO+wMJe72i1wJqC/3OKWTrXnruHGVciRj//lpRHP0n1Scdmxkfk+a+i344Nrjlf55jY1HtNbRdLnd+4KOCdH+4LrFvEjGEjA7YmA83awm+E1g9cWihMceYVhOPMZSumpm9JgFUPPQmwM4pJUsliLAuZt;20:I2HtNjheg/K9MNhqrcm3nmFB4Wivx3/p2gyTmci6OMCUJbrDcEjLZtbvh8EjZlzwjYjlEg8vNvOZ9Mkstl6izoBZeAcPLifea9UDw1Zbhx/Zc4p40sJhVuJRArX/bHHxoQctPNGPLIvye/Pk9/SUlLLaGpZzg3RzU9sIV6gUcDxQDjOiLHidNet33xyJIyVVA15panMy9lw02cOenFwwDd4eSOmyNJP0nRr0KwfssOeMxxiGCevKHT4FA6LWDSy0
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2018 05:47:58.3693
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 05c61b92-c52d-4969-bf77-08d5e7bb05e3
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[158.140.1.28];Helo=[sjmaillnx1.cadence.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR07MB4714
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch extends the usbssp_handle_event function with a new case,
that is responsible for servicing command completion events.

For this purpose, it adds handle_cmd_completion function which in turn
invokes some other functions depending of handling command type.

Signed-off-by: Pawel Laszczak <pawell@cadence.com>
---
 drivers/usb/usbssp/gadget-mem.c  |  50 +++
 drivers/usb/usbssp/gadget-ring.c | 501 +++++++++++++++++++++++++++++++
 drivers/usb/usbssp/gadget.c      |  11 +
 drivers/usb/usbssp/gadget.h      |  12 +
 4 files changed, 574 insertions(+)

diff --git a/drivers/usb/usbssp/gadget-mem.c b/drivers/usb/usbssp/gadget-mem.c
index e1ecb688eb0f..3e39db25f9ef 100644
--- a/drivers/usb/usbssp/gadget-mem.c
+++ b/drivers/usb/usbssp/gadget-mem.c
@@ -507,6 +507,38 @@ void usbssp_free_container_ctx(struct usbssp_udc *usbssp_data,
 	kfree(ctx);
 }
 
+struct usbssp_input_control_ctx *usbssp_get_input_control_ctx(
+					struct usbssp_container_ctx *ctx)
+{
+	if (ctx->type != USBSSP_CTX_TYPE_INPUT)
+		return NULL;
+
+	return (struct usbssp_input_control_ctx *)ctx->bytes;
+}
+
+struct usbssp_slot_ctx *usbssp_get_slot_ctx(struct usbssp_udc *usbssp_data,
+					    struct usbssp_container_ctx *ctx)
+{
+	if (ctx->type == USBSSP_CTX_TYPE_DEVICE)
+		return (struct usbssp_slot_ctx *)ctx->bytes;
+
+	return (struct usbssp_slot_ctx *) (ctx->bytes +
+		CTX_SIZE(usbssp_data->hcc_params));
+}
+
+struct usbssp_ep_ctx *usbssp_get_ep_ctx(struct usbssp_udc *usbssp_data,
+					struct usbssp_container_ctx *ctx,
+					unsigned int ep_index)
+{
+	/* increment ep index by offset of start of ep ctx array */
+	ep_index++;
+	if (ctx->type == USBSSP_CTX_TYPE_INPUT)
+		ep_index++;
+
+	return (struct usbssp_ep_ctx *) (ctx->bytes +
+		(ep_index * CTX_SIZE(usbssp_data->hcc_params)));
+}
+
 /***************** Streams structures manipulation *************************/
 static void usbssp_free_stream_ctx(struct usbssp_udc *usbssp_data,
 				   unsigned int num_stream_ctxs,
@@ -525,6 +557,24 @@ static void usbssp_free_stream_ctx(struct usbssp_udc *usbssp_data,
 		return dma_pool_free(usbssp_data->medium_streams_pool,
 				stream_ctx, dma);
 }
+
+struct usbssp_ring *usbssp_stream_id_to_ring(struct usbssp_device *dev,
+					     unsigned int ep_index,
+					     unsigned int stream_id)
+{
+	struct usbssp_ep *ep = &dev->eps[ep_index];
+
+	if (stream_id == 0)
+		return ep->ring;
+
+	if (!ep->stream_info)
+		return NULL;
+
+	if (stream_id > ep->stream_info->num_streams)
+		return NULL;
+	return ep->stream_info->stream_rings[stream_id];
+}
+
 /* Frees all stream contexts associated with the endpoint,
  *
  * Caller should fix the endpoint context streams fields.
diff --git a/drivers/usb/usbssp/gadget-ring.c b/drivers/usb/usbssp/gadget-ring.c
index 46d43f3933f7..399084963e3b 100644
--- a/drivers/usb/usbssp/gadget-ring.c
+++ b/drivers/usb/usbssp/gadget-ring.c
@@ -224,6 +224,104 @@ static bool usbssp_mod_cmd_timer(struct usbssp_udc *usbssp_data,
 	return 0;
 }
 
+void usbssp_ring_ep_doorbell(struct usbssp_udc *usbssp_data,
+		unsigned int ep_index,
+		unsigned int stream_id)
+{
+	__le32 __iomem *db_addr =
+			&usbssp_data->dba->doorbell[usbssp_data->slot_id];
+	struct usbssp_ep *ep = &usbssp_data->devs.eps[ep_index];
+	unsigned int ep_state = ep->ep_state;
+	unsigned int db_value;
+	/* Don't ring the doorbell for this endpoint if there are pending
+	 * cancellations because we don't want to interrupt processing.
+	 * We don't want to restart any stream rings if there's a set dequeue
+	 * pointer command pending because the device can choose to start any
+	 * stream once the endpoint is on the HW schedule.
+	 * Also we don't want restart any endpoint if endpoint is halted or
+	 * disabled and also if endpoint disabling is pending.
+	 */
+	if ((ep_state & EP_STOP_CMD_PENDING) ||
+	    (ep_state & SET_DEQ_PENDING) ||
+	    (ep_state & EP_HALTED) ||
+	    !(ep_state & USBSSP_EP_ENABLED) ||
+	    (ep_state & USBSSP_EP_DISABLE_PENDING))
+		return;
+
+	if (ep_index == 0 && !usbssp_data->ep0_expect_in &&
+	   usbssp_data->ep0state == USBSSP_EP0_DATA_PHASE)
+		db_value = DB_VALUE_EP0_OUT(ep_index, stream_id);
+	else
+		db_value = DB_VALUE(ep_index, stream_id);
+
+	usbssp_dbg(usbssp_data, "// Ding dong transfer ring for %s!"
+			" - [DB addr/DB val]: [%p/%08x]\n",
+			usbssp_data->devs.eps[ep_index].name, db_addr,
+			db_value);
+
+	writel(db_value, db_addr);
+	/* The CPU has better things to do at this point than wait for a
+	 * write-posting flush.  It'll get there soon enough.
+	 */
+}
+
+/* Ring the doorbell for any rings with pending USB requests */
+static void ring_doorbell_for_active_rings(struct usbssp_udc *usbssp_data,
+					   unsigned int ep_index)
+{
+	unsigned int stream_id;
+	struct usbssp_ep *ep;
+
+	ep = &usbssp_data->devs.eps[ep_index];
+
+	usbssp_dbg(usbssp_data, "Ring all active ring for %s\n",
+		ep->name);
+
+	/* A ring has pending Request if its TD list is not empty */
+	if (!(ep->ep_state & EP_HAS_STREAMS)) {
+		if (ep->ring && !(list_empty(&ep->ring->td_list)))
+			usbssp_ring_ep_doorbell(usbssp_data, ep_index, 0);
+		return;
+	}
+
+	for (stream_id = 1; stream_id < ep->stream_info->num_streams;
+			stream_id++) {
+		struct usbssp_stream_info *stream_info = ep->stream_info;
+
+		if (!list_empty(&stream_info->stream_rings[stream_id]->td_list))
+			usbssp_ring_ep_doorbell(usbssp_data,  ep_index,
+					stream_id);
+	}
+}
+
+/*
+ * When we get a command completion for a Stop Endpoint Command, we need to
+ * stop timer and clear EP_STOP_CMD_PENDING flag.
+ */
+static void usbssp_handle_cmd_stop_ep(struct usbssp_udc *usbssp_data,
+				      union usbssp_trb *trb,
+				      struct usbssp_event_cmd *event)
+{
+	unsigned int ep_index;
+	struct usbssp_ep *ep;
+	struct usbssp_ep_ctx *ep_ctx;
+	struct usbssp_device *priv_dev;
+
+	ep_index = TRB_TO_EP_INDEX(le32_to_cpu(trb->generic.field[3]));
+	ep = &usbssp_data->devs.eps[ep_index];
+
+	usbssp_dbg(usbssp_data,
+		"CMD stop endpoint completion for ep index: %d - %s\n",
+		ep_index, ep->name);
+
+
+	priv_dev = &usbssp_data->devs;
+	ep_ctx = usbssp_get_ep_ctx(usbssp_data, priv_dev->out_ctx, ep_index);
+	trace_usbssp_handle_cmd_stop_ep(ep_ctx);
+
+	ep->ep_state &= ~EP_STOP_CMD_PENDING;
+}
+
 static void usbssp_kill_ring_requests(struct usbssp_udc *usbssp_data,
 				      struct usbssp_ring *ring)
 {
@@ -300,6 +398,258 @@ void usbssp_udc_died(struct usbssp_udc *usbssp_data)
 		usbssp_kill_endpoint_request(usbssp_data, i);
 }
 
+static void update_ring_for_set_deq_completion(struct usbssp_udc *usbssp_data,
+					       struct usbssp_device *dev,
+					       struct usbssp_ring *ep_ring,
+					       unsigned int ep_index)
+{
+	union usbssp_trb *dequeue_temp;
+	int num_trbs_free_temp;
+	bool revert = false;
+
+	num_trbs_free_temp = ep_ring->num_trbs_free;
+	dequeue_temp = ep_ring->dequeue;
+
+	if (trb_is_link(ep_ring->dequeue)) {
+		ep_ring->deq_seg = ep_ring->deq_seg->next;
+		ep_ring->dequeue = ep_ring->deq_seg->trbs;
+	}
+
+	while (ep_ring->dequeue != dev->eps[ep_index].queued_deq_ptr) {
+		/* We have more usable TRBs */
+		ep_ring->num_trbs_free++;
+		ep_ring->dequeue++;
+		if (trb_is_link(ep_ring->dequeue)) {
+			if (ep_ring->dequeue ==
+					dev->eps[ep_index].queued_deq_ptr)
+				break;
+			ep_ring->deq_seg = ep_ring->deq_seg->next;
+			ep_ring->dequeue = ep_ring->deq_seg->trbs;
+		}
+		if (ep_ring->dequeue == dequeue_temp) {
+			revert = true;
+			break;
+		}
+	}
+
+	if (revert) {
+		usbssp_dbg(usbssp_data, "Unable to find new dequeue pointer\n");
+		ep_ring->num_trbs_free = num_trbs_free_temp;
+	}
+}
+
+/*
+ * When we get a completion for a Set Transfer Ring Dequeue Pointer command,
+ * we need to clear the set deq pending flag in the endpoint ring state, so that
+ * the TD queueing code can ring the doorbell again.  We also need to ring the
+ * endpoint doorbell to restart the ring
+ */
+static void usbssp_handle_cmd_set_deq(struct usbssp_udc *usbssp_data,
+		union usbssp_trb *trb, u32 cmd_comp_code)
+{
+	unsigned int ep_index;
+	unsigned int stream_id;
+	struct usbssp_ring *ep_ring;
+	struct usbssp_device *dev;
+	struct usbssp_ep *ep;
+	struct usbssp_ep_ctx *ep_ctx;
+	struct usbssp_slot_ctx *slot_ctx;
+
+	ep_index = TRB_TO_EP_INDEX(le32_to_cpu(trb->generic.field[3]));
+	stream_id = TRB_TO_STREAM_ID(le32_to_cpu(trb->generic.field[2]));
+	dev = &usbssp_data->devs;
+	ep = &dev->eps[ep_index];
+
+	ep_ring = usbssp_stream_id_to_ring(dev, ep_index, stream_id);
+	if (!ep_ring) {
+		usbssp_warn(usbssp_data,
+			"WARN Set TR deq ptr command for freed stream ID %u\n",
+			stream_id);
+		/* XXX: Harmless??? */
+		goto cleanup;
+	}
+
+	ep_ctx = usbssp_get_ep_ctx(usbssp_data, dev->out_ctx, ep_index);
+	slot_ctx = usbssp_get_slot_ctx(usbssp_data, dev->out_ctx);
+	trace_usbssp_handle_cmd_set_deq(slot_ctx);
+	trace_usbssp_handle_cmd_set_deq_ep(ep_ctx);
+
+	if (cmd_comp_code != COMP_SUCCESS) {
+		unsigned int ep_state;
+		unsigned int slot_state;
+
+		switch (cmd_comp_code) {
+		case COMP_TRB_ERROR:
+			usbssp_warn(usbssp_data,
+				"WARN Set TR Deq Ptr cmd invalid because of "
+				"stream ID configuration\n");
+			break;
+		case COMP_CONTEXT_STATE_ERROR:
+			usbssp_warn(usbssp_data, "WARN Set TR Deq Ptr cmd "
+				"failed due to incorrect slot or ep state.\n");
+			ep_state = GET_EP_CTX_STATE(ep_ctx);
+			slot_state = le32_to_cpu(slot_ctx->dev_state);
+			slot_state = GET_SLOT_STATE(slot_state);
+			usbssp_dbg_trace(usbssp_data,
+					trace_usbssp_dbg_cancel_request,
+					"Slot state = %u, EP state = %u",
+					slot_state, ep_state);
+			break;
+		case COMP_SLOT_NOT_ENABLED_ERROR:
+			usbssp_warn(usbssp_data,
+					"WARN Set TR Deq Ptr cmd failed because"
+					" slot %u was not enabled.\n",
+					usbssp_data->slot_id);
+			break;
+		default:
+			usbssp_warn(usbssp_data, "WARN Set TR Deq Ptr cmd with"
+					" unknown completion code of %u.\n",
+					cmd_comp_code);
+			break;
+		}
+
+	} else {
+		u64 deq;
+		/* deq ptr is written to the stream ctx for streams */
+		if (ep->ep_state & EP_HAS_STREAMS) {
+			struct usbssp_stream_ctx *ctx =
+				&ep->stream_info->stream_ctx_array[stream_id];
+			deq = le64_to_cpu(ctx->stream_ring) & SCTX_DEQ_MASK;
+		} else {
+			deq = le64_to_cpu(ep_ctx->deq) & ~EP_CTX_CYCLE_MASK;
+		}
+		usbssp_dbg_trace(usbssp_data, trace_usbssp_dbg_cancel_request,
+			"Successful Set TR Deq Ptr cmd, deq = @%08llx", deq);
+		if (usbssp_trb_virt_to_dma(ep->queued_deq_seg,
+		    ep->queued_deq_ptr) == deq) {
+			/* Update the ring's dequeue segment and dequeue pointer
+			 * to reflect the new position.
+			 */
+			update_ring_for_set_deq_completion(usbssp_data, dev,
+				ep_ring, ep_index);
+		} else {
+			usbssp_warn(usbssp_data,
+				"Mismatch between completed Set TR Deq "
+				"Ptr command & DC internal state.\n");
+			usbssp_warn(usbssp_data,
+				"ep deq seg = %p, deq ptr = %p\n",
+				ep->queued_deq_seg, ep->queued_deq_ptr);
+		}
+	}
+
+cleanup:
+	dev->eps[ep_index].ep_state &= ~SET_DEQ_PENDING;
+	dev->eps[ep_index].queued_deq_seg = NULL;
+	dev->eps[ep_index].queued_deq_ptr = NULL;
+	/* Restart any rings with pending requests */
+	ring_doorbell_for_active_rings(usbssp_data, ep_index);
+}
+
+
+static void usbssp_handle_cmd_reset_ep(struct usbssp_udc *usbssp_data,
+				       union usbssp_trb *trb,
+				       u32 cmd_comp_code)
+{
+	struct usbssp_ep *dep;
+	struct usbssp_ep_ctx *ep_ctx;
+	unsigned int ep_index;
+
+	ep_index = TRB_TO_EP_INDEX(le32_to_cpu(trb->generic.field[3]));
+	ep_ctx = usbssp_get_ep_ctx(usbssp_data, usbssp_data->devs.out_ctx,
+			ep_index);
+	trace_usbssp_handle_cmd_reset_ep(ep_ctx);
+
+	/* This command will only fail if the endpoint wasn't halted,
+	 * but we don't care.
+	 */
+	usbssp_dbg_trace(usbssp_data, trace_usbssp_dbg_reset_ep,
+		"Ignoring reset ep completion code of %u", cmd_comp_code);
+
+	dep = &usbssp_data->devs.eps[ep_index];
+
+	/* Clear our internal halted state */
+	dep->ep_state &= ~EP_HALTED;
+
+	ring_doorbell_for_active_rings(usbssp_data, ep_index);
+}
+
+static void usbssp_handle_cmd_enable_slot(struct usbssp_udc *usbssp_data,
+					  int slot_id,
+					  struct usbssp_command *command,
+					  u32 cmd_comp_code)
+{
+	if (cmd_comp_code == COMP_SUCCESS) {
+		usbssp_dbg(usbssp_data,
+			"CMD enable slot complition successfully "
+			"- slto id: %d\n", slot_id);
+		usbssp_data->slot_id = slot_id;
+	} else {
+		usbssp_dbg(usbssp_data, "CMD enable slot complition failed\n");
+		usbssp_data->slot_id = 0;
+	}
+}
+
+static void usbssp_handle_cmd_disable_slot(struct usbssp_udc *usbssp_data)
+{
+	struct usbssp_device *dev_priv;
+	struct usbssp_slot_ctx *slot_ctx;
+
+	usbssp_dbg(usbssp_data, "CMD disable slot complition\n");
+
+	dev_priv = &usbssp_data->devs;
+	if (!dev_priv)
+		return;
+
+	usbssp_data->slot_id = 0;
+	slot_ctx = usbssp_get_slot_ctx(usbssp_data, dev_priv->out_ctx);
+	trace_usbssp_handle_cmd_disable_slot(slot_ctx);
+}
+
+static void usbssp_handle_cmd_config_ep(struct usbssp_udc *usbssp_data,
+		struct usbssp_event_cmd *event, u32 cmd_comp_code)
+{
+	struct usbssp_device *priv_dev;
+	struct usbssp_input_control_ctx *ctrl_ctx;
+	struct usbssp_ep_ctx *ep_ctx;
+	unsigned int ep_index;
+	u32 add_flags, drop_flags;
+
+	/*
+	 * Configure endpoint commands can come, becaouse device
+	 * receive USB_SET_CONFIGURATION or SET_INTERFACE request,
+	 * or because the HW needed an extra configure endpoint
+	 * command after a reset or disconnect event.
+	 */
+	priv_dev = &usbssp_data->devs;
+	ctrl_ctx = usbssp_get_input_control_ctx(priv_dev->in_ctx);
+	if (!ctrl_ctx) {
+		usbssp_warn(usbssp_data,
+				"Could not get input context, bad type.\n");
+		return;
+	}
+
+	add_flags = le32_to_cpu(ctrl_ctx->add_flags);
+	drop_flags = le32_to_cpu(ctrl_ctx->drop_flags);
+	/* Input ctx add_flags are the endpoint index plus one */
+	ep_index = usbssp_last_valid_endpoint(add_flags) - 1;
+
+	ep_ctx = usbssp_get_ep_ctx(usbssp_data, priv_dev->out_ctx, ep_index);
+	trace_usbssp_handle_cmd_config_ep(ep_ctx);
+}
+
+static void usbssp_handle_cmd_reset_dev(struct usbssp_udc *usbssp_data,
+		struct usbssp_event_cmd *event)
+{
+	struct usbssp_device *dev_priv;
+	struct usbssp_slot_ctx *slot_ctx;
+
+	dev_priv = &usbssp_data->devs;
+	slot_ctx = usbssp_get_slot_ctx(usbssp_data, dev_priv->out_ctx);
+	trace_usbssp_handle_cmd_reset_dev(slot_ctx);
+	usbssp_dbg(usbssp_data, "Completed reset device command.\n");
+	if (!usbssp_data->devs.gadget)
+		usbssp_warn(usbssp_data, "Reset device command completion\n");
+}
 
 void usbssp_handle_command_timeout(struct work_struct *work)
 {
@@ -327,6 +677,154 @@ void usbssp_cleanup_command_queue(struct usbssp_udc *usbssp_data)
 		usbssp_complete_del_and_free_cmd(cur_cmd, COMP_COMMAND_ABORTED);
 }
 
+static void handle_cmd_completion(struct usbssp_udc *usbssp_data,
+		struct usbssp_event_cmd *event)
+{
+	int slot_id = TRB_TO_SLOT_ID(le32_to_cpu(event->flags));
+	u64 cmd_dma;
+	dma_addr_t cmd_dequeue_dma;
+	u32 cmd_comp_code;
+	union usbssp_trb *cmd_trb;
+	struct usbssp_command *cmd;
+	u32 cmd_type;
+
+	cmd_dma = le64_to_cpu(event->cmd_trb);
+	cmd_trb = usbssp_data->cmd_ring->dequeue;
+
+	trace_usbssp_handle_command(usbssp_data->cmd_ring, &cmd_trb->generic);
+
+	cmd_dequeue_dma = usbssp_trb_virt_to_dma(usbssp_data->cmd_ring->deq_seg,
+			cmd_trb);
+
+	/*
+	 * Check whether the completion event is for our internal kept
+	 * command.
+	 */
+	if (!cmd_dequeue_dma || cmd_dma != (u64)cmd_dequeue_dma) {
+		usbssp_warn(usbssp_data,
+			  "ERROR mismatched command completion event\n");
+		return;
+	}
+
+	cmd = list_entry(usbssp_data->cmd_list.next, struct usbssp_command,
+			cmd_list);
+
+	cancel_delayed_work(&usbssp_data->cmd_timer);
+
+	cmd_comp_code = GET_COMP_CODE(le32_to_cpu(event->status));
+
+	/* If CMD ring stopped we own the trbs between enqueue and dequeue */
+	if (cmd_comp_code ==  COMP_COMMAND_RING_STOPPED) {
+		complete_all(&usbssp_data->cmd_ring_stop_completion);
+		return;
+	}
+
+	if (cmd->command_trb != usbssp_data->cmd_ring->dequeue) {
+		usbssp_err(usbssp_data,
+			 "Command completion event does not match command\n");
+		return;
+	}
+
+	/*
+	 * device aborted the command ring, check if the current command was
+	 * supposed to be aborted, otherwise continue normally.
+	 * The command ring is stopped now, but the DC will issue a Command
+	 * Ring Stopped event which will cause us to restart it.
+	 */
+	if (cmd_comp_code == COMP_COMMAND_ABORTED) {
+		usbssp_data->cmd_ring_state = CMD_RING_STATE_STOPPED;
+
+		if (cmd->status == COMP_COMMAND_ABORTED) {
+			if (usbssp_data->current_cmd == cmd)
+				usbssp_data->current_cmd = NULL;
+			goto event_handled;
+		}
+	}
+
+	cmd_type = TRB_FIELD_TO_TYPE(le32_to_cpu(cmd_trb->generic.field[3]));
+	switch (cmd_type) {
+	case TRB_ENABLE_SLOT:
+		usbssp_handle_cmd_enable_slot(usbssp_data, slot_id,
+				cmd, cmd_comp_code);
+		break;
+	case TRB_DISABLE_SLOT:
+		usbssp_handle_cmd_disable_slot(usbssp_data);
+		break;
+	case TRB_CONFIG_EP:
+		if (!cmd->completion)
+			usbssp_handle_cmd_config_ep(usbssp_data, event,
+					cmd_comp_code);
+		break;
+	case TRB_EVAL_CONTEXT:
+		break;
+	case TRB_ADDR_DEV: {
+		struct usbssp_slot_ctx *slot_ctx;
+
+		slot_ctx = usbssp_get_slot_ctx(usbssp_data,
+				usbssp_data->devs.out_ctx);
+		trace_usbssp_handle_cmd_addr_dev(slot_ctx);
+		break;
+	}
+	case TRB_STOP_RING:
+		WARN_ON(slot_id != TRB_TO_SLOT_ID(
+				le32_to_cpu(cmd_trb->generic.field[3])));
+		usbssp_handle_cmd_stop_ep(usbssp_data, cmd_trb, event);
+		break;
+	case TRB_SET_DEQ:
+		WARN_ON(slot_id != TRB_TO_SLOT_ID(
+				le32_to_cpu(cmd_trb->generic.field[3])));
+		usbssp_handle_cmd_set_deq(usbssp_data, cmd_trb, cmd_comp_code);
+		break;
+	case TRB_CMD_NOOP:
+		/* Is this an aborted command turned to NO-OP? */
+		if (cmd->status == COMP_COMMAND_RING_STOPPED)
+			cmd_comp_code = COMP_COMMAND_RING_STOPPED;
+		break;
+	case TRB_HALT_ENDPOINT:
+		if (cmd->status == COMP_COMMAND_RING_STOPPED)
+			cmd_comp_code = COMP_COMMAND_RING_STOPPED;
+		break;
+	case TRB_FLUSH_ENDPOINT:
+		if (cmd->status == COMP_COMMAND_RING_STOPPED)
+			cmd_comp_code = COMP_COMMAND_RING_STOPPED;
+		break;
+	case TRB_RESET_EP:
+		WARN_ON(slot_id != TRB_TO_SLOT_ID(
+				le32_to_cpu(cmd_trb->generic.field[3])));
+		usbssp_handle_cmd_reset_ep(usbssp_data, cmd_trb, cmd_comp_code);
+		break;
+	case TRB_RESET_DEV:
+		/* SLOT_ID field in reset device cmd completion event TRB is 0.
+		 * Use the SLOT_ID from the command TRB instead.
+		 */
+		slot_id = TRB_TO_SLOT_ID(
+				le32_to_cpu(cmd_trb->generic.field[3]));
+
+		WARN_ON(slot_id != 0);
+		usbssp_handle_cmd_reset_dev(usbssp_data, event);
+		break;
+	case TRB_FORCE_HEADER:
+		break;
+	default:
+		/* Skip over unknown commands on the event ring */
+		usbssp_info(usbssp_data, "INFO unknown command type %d\n",
+				cmd_type);
+		break;
+	}
+
+	/* restart timer if this wasn't the last command */
+	if (!list_is_singular(&usbssp_data->cmd_list)) {
+		usbssp_data->current_cmd = list_first_entry(&cmd->cmd_list,
+					struct usbssp_command, cmd_list);
+		usbssp_mod_cmd_timer(usbssp_data, USBSSP_CMD_DEFAULT_TIMEOUT);
+	} else if (usbssp_data->current_cmd == cmd) {
+		usbssp_data->current_cmd = NULL;
+	}
+
+event_handled:
+	usbssp_complete_del_and_free_cmd(cmd, cmd_comp_code);
+	inc_deq(usbssp_data, usbssp_data->cmd_ring);
+}
 
 static void handle_vendor_event(struct usbssp_udc *usbssp_data,
 		union usbssp_trb *event)
@@ -604,6 +1102,9 @@ int usbssp_handle_event(struct usbssp_udc *usbssp_data)
 	rmb();
 
 	switch ((le32_to_cpu(event->event_cmd.flags) & TRB_TYPE_BITMASK)) {
+	case TRB_TYPE(TRB_COMPLETION):
+		handle_cmd_completion(usbssp_data, &event->event_cmd);
+		break;
 	case TRB_TYPE(TRB_PORT_STATUS):
 		handle_port_status(usbssp_data, event);
 		update_ptrs = 0;
diff --git a/drivers/usb/usbssp/gadget.c b/drivers/usb/usbssp/gadget.c
index e84821394e85..2ddb449765b6 100644
--- a/drivers/usb/usbssp/gadget.c
+++ b/drivers/usb/usbssp/gadget.c
@@ -266,6 +266,17 @@ int usbssp_resume(struct usbssp_udc *usbssp_data, bool hibernated)
 
 #endif	/* CONFIG_PM */
 
+/* Compute the last valid endpoint context index. Basically, this is the
+ * endpoint index plus one. For slot contexts with more than valid endpoint,
+ * we find the most significant bit set in the added contexts flags.
+ * e.g. ep 1 IN (with epnum 0x81) => added_ctxs = 0b1000
+ * fls(0b1000) = 4, but the endpoint context index is 3, so subtract one.
+ */
+unsigned int usbssp_last_valid_endpoint(u32 added_ctxs)
+{
+	return fls(added_ctxs) - 1;
+}
+
 int usbssp_gen_setup(struct usbssp_udc *usbssp_data)
 {
 	int	retval;
diff --git a/drivers/usb/usbssp/gadget.h b/drivers/usb/usbssp/gadget.h
index 2615eb151925..d0c9548a39ca 100644
--- a/drivers/usb/usbssp/gadget.h
+++ b/drivers/usb/usbssp/gadget.h
@@ -1679,8 +1679,13 @@ void usbssp_dbg_trace(struct usbssp_udc *usbssp_data,
 /* USBSSP memory management */
 void usbssp_mem_cleanup(struct usbssp_udc *usbssp_data);
 int usbssp_mem_init(struct usbssp_udc *usbssp_data, gfp_t flags);
+unsigned int usbssp_last_valid_endpoint(u32 added_ctxs);
 int usbssp_ring_expansion(struct usbssp_udc *usbssp_data,
 		struct usbssp_ring *ring, unsigned int num_trbs, gfp_t flags);
+struct usbssp_ring *usbssp_stream_id_to_ring(
+		struct usbssp_device *dev,
+		unsigned int ep_index,
+		unsigned int stream_id);
 
 struct usbssp_command *usbssp_alloc_command(struct usbssp_udc *usbssp_data,
 		bool allocate_completion, gfp_t mem_flags);
@@ -1723,6 +1728,13 @@ void usbssp_set_link_state(struct usbssp_udc *usbssp_data,
 void usbssp_test_and_clear_bit(struct usbssp_udc *usbssp_data,
 		__le32 __iomem *port_regs, u32 port_bit);
 
+/* USBSSP DC contexts */
+struct usbssp_input_control_ctx *usbssp_get_input_control_ctx(
+		struct usbssp_container_ctx *ctx);
+struct usbssp_slot_ctx *usbssp_get_slot_ctx(struct usbssp_udc *usbssp_data,
+		struct usbssp_container_ctx *ctx);
+struct usbssp_ep_ctx *usbssp_get_ep_ctx(struct usbssp_udc *usbssp_data,
+		struct usbssp_container_ctx *ctx, unsigned int ep_index);
 /* USBSSP gadget interface*/
 void usbssp_suspend_gadget(struct usbssp_udc *usbssp_data);
 void usbssp_resume_gadget(struct usbssp_udc *usbssp_data);
-- 
2.17.1

