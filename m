Return-Path: <SRS0=Pvhj=LO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51F3DC433F5
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 13:28:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E9F242077C
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 13:28:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="SYl85kVp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E9F242077C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728089AbeHaRgP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Aug 2018 13:36:15 -0400
Received: from mail-eopbgr720060.outbound.protection.outlook.com ([40.107.72.60]:53440
        "EHLO NAM05-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727326AbeHaRgB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Aug 2018 13:36:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JVvMPY5F/KXoqyjC22+jM8jJZHttNUht7ykvCkd9NgM=;
 b=SYl85kVpzSbbVIgsSlqOMd4OyPkWuImM6fR5lBk77L1ySTvAWhSvEqyamp6K54IWWvVYbeFe0HwL42EZrLhBhHwi7GXjIXC0RL3KXaeIQmndpBIrdOf4oHvjOcFvtu3mnGIOQKC5ZDTlc6mL9W3L3RVGDgaOula1DSWjci7NJuU=
Received: from BYAPR02CA0072.namprd02.prod.outlook.com (2603:10b6:a03:54::49)
 by DM2PR02MB511.namprd02.prod.outlook.com (2a01:111:e400:2422::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1101.14; Fri, 31 Aug
 2018 13:28:24 +0000
Received: from BL2NAM02FT032.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e46::203) by BYAPR02CA0072.outlook.office365.com
 (2603:10b6:a03:54::49) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1080.15 via Frontend
 Transport; Fri, 31 Aug 2018 13:28:24 +0000
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 BL2NAM02FT032.mail.protection.outlook.com (10.152.77.169) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1101.10
 via Frontend Transport; Fri, 31 Aug 2018 13:28:23 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66] helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.63)
        (envelope-from <manish.narani@xilinx.com>)
        id 1fvjTK-0001Hm-WE; Fri, 31 Aug 2018 06:28:23 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <manish.narani@xilinx.com>)
        id 1fvjTF-0000Ak-Se; Fri, 31 Aug 2018 06:28:17 -0700
Received: from xsj-pvapsmtp01 (maildrop.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp1.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id w7VDS9PO017373;
        Fri, 31 Aug 2018 06:28:09 -0700
Received: from [172.23.64.106] (helo=xhdvnc125.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <mnarani@xilinx.com>)
        id 1fvjT6-00008u-Sy; Fri, 31 Aug 2018 06:28:09 -0700
Received: by xhdvnc125.xilinx.com (Postfix, from userid 16987)
        id 11C72121458; Fri, 31 Aug 2018 18:58:08 +0530 (IST)
From:   Manish Narani <manish.narani@xilinx.com>
To:     <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <michal.simek@xilinx.com>, <bp@alien8.de>, <mchehab@kernel.org>,
        <manish.narani@xilinx.com>, <leoyang.li@nxp.com>,
        <amit.kucheria@linaro.org>, <olof@lixom.net>
CC:     <sgoud@xilinx.com>, <anirudh@xilinx.com>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-edac@vger.kernel.org>
Subject: [PATCH v5 2/4] dt: bindings: Document ZynqMP DDRC in Synopsys documentation
Date:   Fri, 31 Aug 2018 18:57:48 +0530
Message-ID: <1535722070-10394-3-git-send-email-manish.narani@xilinx.com>
X-Mailer: git-send-email 2.1.1
In-Reply-To: <1535722070-10394-1-git-send-email-manish.narani@xilinx.com>
References: <1535722070-10394-1-git-send-email-manish.narani@xilinx.com>
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(396003)(346002)(376002)(39860400002)(136003)(2980300002)(438002)(199004)(189003)(14444005)(8936002)(2906002)(72206003)(6346003)(110136005)(103686004)(316002)(4326008)(486006)(336012)(16586007)(81166006)(6266002)(52956003)(50226002)(42186006)(5660300001)(186003)(44832011)(47776003)(426003)(81156014)(2201001)(54906003)(7416002)(51416003)(26005)(478600001)(6666003)(476003)(76176011)(90966002)(36386004)(305945005)(36756003)(356003)(446003)(106002)(63266004)(106466001)(8676002)(11346002)(48376002)(50466002)(126002)(2616005)(107986001)(2101003);DIR:OUT;SFP:1101;SCL:1;SRVR:DM2PR02MB511;H:xsj-pvapsmtpgw01;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-83.xilinx.com;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: 1;BL2NAM02FT032;1:BKdFTzG+RzbMGIFsNZcgoipKMvfb7kFL1b/pbjmVxQVVKfiCUDHViTkLpMqtLZsQHDg7YmXpOWWkMuTTDhI6v22ucJe0R+UtLo8/R7p0qjoOfxkZJV/rhOZ1h7D0k5e8
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d477e966-42c9-47d3-bd36-08d60f45a06d
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4608076)(2017052603328)(7153060);SRVR:DM2PR02MB511;
X-Microsoft-Exchange-Diagnostics: 1;DM2PR02MB511;3:oEOuJJQjF9o70QR5P3Un9EczVIRRbae1JWRKkLh8TbX7pBsXGp0Tp65gDuEm4x+MV5/8vFaoDJfSx4+LDbdDH4Fbd5Qjcqy+gpRgX0bqTwg8Q9R5AyTHyTrhfI798lDOFuT3b+28Q8YZMzDPFK7/ITJzkRjbfjs2bPmLSMnk6i7JYN5NyjKEWim2EEhVHT3hJrQQzPq4HHhAbB8PDr394PiriTQry4JRi9jHztGMUbIZJCwXEbjmUanw1x6792iafcMpe1Rwp2CRccTcYg3mBGtCXQ9aQrOWMBZXP08iElyfThpG+9LV6hR7bP1QlbxgSCYsKD157HxSUO0I6WMzWU5GzSfR9b1qYpaL12aVzRM=;25:DQsgBYHVquJm159YdmMxTChM6LRilqKRrD7TakD1DvtFPiIJo+FIffdg0UBf97Sxv3XJFdL2lxoS6eVHvw+D1NRE5Oyo7dMlRVk0X9fkdyA4N3woVGNvmCUArMxiYql+ThMpbHvZ2EFPK/N+QJawC9tmVAxs2cH/LEk/W7Y7TtPf6lxo9Lx5ZoRYdpQaQeaFCPxfzbPP8LNwtYNF/nP2WBX/qVE2LYRbewkTezkcEdnEUoWP3MudeCmJRoZM9rRu3hR93/WtGtSnAIkK9fQiJhCxOdJArIrYiu15kNZ+zXEaOP3XxLixCi6vgZMBR7gWJP35brxPjEiPE23k+RsT1Q==
X-MS-TrafficTypeDiagnostic: DM2PR02MB511:
X-Microsoft-Exchange-Diagnostics: 1;DM2PR02MB511;31:2T2FSkbaxAsHy50XS8dtD0Ix1Kvpjkm13n2cxSw6YLHxqPtUCm8qIpqcB25LcyoklImCr6PPWsLpHJt35lsr8wVROaqP5HrjaNMA/KvONtRyvXqZk6KXTiHPdtfHpvF5y5kWHtvXs7IHJTnGetexxRZ8vf2zx32o7g3+z4iIV4HTw0E5e3if/a+qj3SDa96coDz3ORTADiQrnPnT7ysi7xvzYb/2KWT1dLh6DDntIm4=;20:318AlgQVnTUSuv3jraKpfYsQ+4eXACILcfa3/OlPqzzRq/hzlr3IITe+cjsUItdPBhPKBfV9AnT2tnaTWlXbBtt7Y4PA59O19wSjh74WeNad0+DdCpgIMwUeLvGpamXH1zMMazMIiFULsbf00y8veI1MPuFidNqFhvK+O61J0uRLeBlddg6nbgKmgpvNeoEXknnKDKdN7iPRLPNONwlz/SzpOdqSuQN2S+A4WDioQeMFqNaQYkJj7sRuTBaRHO7mo7P34SIcyLonFV6ZedScspR+3+MrNxh1b2E17Kz+Z+SmV1cN2du8XSZsxrC26mSMNPBtSy4rCJtghoHEHK270vbK1Pw7F0KhGQlmxJaMpqNigp1XvLUQA7Q4eLGMH45k/MKF3hc++zNiC6V8Dz5Fduzk1scE0cvkCidrGu+neNtRF8ROil/SI6aTkif66FNZtf/9s2JAIpURtkty1vAWWNXz94VWNPBZZLlTmcWsvtsPztEVNjDE02uY5CbtSnWR
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <DM2PR02MB51151A5BDBF17E01C9CF2D9C10F0@DM2PR02MB511.namprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(20558992708506)(192813158149592);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(3002001)(93006095)(93004095)(3231311)(944501410)(52105095)(6055026)(149027)(150027)(6041310)(20161123558120)(20161123560045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(201708071742011)(7699016);SRVR:DM2PR02MB511;BCL:0;PCL:0;RULEID:;SRVR:DM2PR02MB511;
X-Microsoft-Exchange-Diagnostics: 1;DM2PR02MB511;4:6f0QXirSpPH/kNUTrGT0MzaAowA0QD2bNeTzgRZxQ9SZ97xs55phcXrG+663sP+l9s2vxwWwXTIBGdidfDgE8UN7nPwM5SwWBJz5nkOcPeoeuj0aEGN8oLAKsJ/mvyoofAHPgIz11MdC2wi3knwvV7+Pkp9tKU0m//DSVnTAlRLdt/MkXLDXdzJFhIV/NcTp/4E2+5aC9bI7T+Y3qwJTeMT5zFnpm6GYBCzrirKlri2nMyCLz7w/v/iDgV7XNfE0jxl0SRrYGJ9EpBollDFtxocYapB7Fzo5GL24Hdo6VVYrk7BPMZ7LH7GtPCiRdAd/TnIoXTqbAdhArHLyjqFLWn/AdhUjwc+drFljBzkorlU=
X-Forefront-PRVS: 07817FCC2D
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DM2PR02MB511;23:IA0A7OCJiN5BH9S/QgoXh9DU+qRV2uXSSouCsxOdPv?=
 =?us-ascii?Q?xrQ+74Sfs9sZ8xldUGyAJRTldMEZA4lgl8GyMpcV6cYM0Ej8dH06sbqrXC+g?=
 =?us-ascii?Q?TC8awHFLJHVjbxqD0cJNCq93o1p/k+i+4j6nJRI3zUrJsrna+uUncdsryq8w?=
 =?us-ascii?Q?LsFzi8vDaoCF4TCwent8NTP3JnrRu5nNoGVUEuOnkoHsGSXULaGRpJVC6NIj?=
 =?us-ascii?Q?fwmS8HTwnsEZCJ4BqAReJ96YjF+jo2WfRXe+IN/KUWq1Imdz1KZV+bLZHrjh?=
 =?us-ascii?Q?kONcpv2B3fR0EVdFfXY4sVc5+lyDIRTk+nTQj0atjina5StfIeaD0Mv3sVXm?=
 =?us-ascii?Q?luvLaS+wPnI8Vh0QVZ1Ledk+tfGX4Qhul05w33SO5UKYXOa1hjU/ztYK0bFu?=
 =?us-ascii?Q?Gi7jBoLnuPS8mIYrePRZbs+tHJbUgpcWuQkQGvY9hGOmPDlvmSk3M5vhXcxh?=
 =?us-ascii?Q?jn3aUNkNl4UgtdyFTtMs/iWZxW3LoiRhh3RNS883mqeapgZjhXrMwJWQ90me?=
 =?us-ascii?Q?qTmVCIxNsP/SE5P/4AeAqiiCv1CfGKmO4jfy9HhEsAFj2DzoLki2UpHRxIsk?=
 =?us-ascii?Q?TZOuFeCAdp6mCDbFAJk7Nyq4qBttYD2t8F6RCx7NGMiJdcVYkIxW6t5XSXKx?=
 =?us-ascii?Q?qe2HWOEad9ju9tmosuJXrVoxA+35zdGqBhaIy0KMAG7dXoL9czgDZXQdRFZo?=
 =?us-ascii?Q?N3xRmVQJk8dERAMk4J0C9XXkToOEEtaxOb9Cg58XVOYXfY9iFjsxyqe/rswR?=
 =?us-ascii?Q?bhEQivRJG8hFFM4iDQxr9E8SD5b7WzwVM/24wYFPb70TUeikx9d5Lr5JvBuS?=
 =?us-ascii?Q?BrqYNqBj2SnDCWc3Nb9u52kA6LeLu0jQC54Qp3Fg0YoQuqFjz0nagCgMFZ1e?=
 =?us-ascii?Q?F1HLbrKpHcjyxw8ejol9BT2mpL/epudwKJU/qAA9JsVafdZ+cmaq1GoSi5xH?=
 =?us-ascii?Q?+zB2QOEVqQ3qmQaP+w8MKPdVJqiiFC/SB17dO1OnP/pMrnfczqhSCr+afFdF?=
 =?us-ascii?Q?a4E6rbpyAqfVe2Zj35pjQDlsIhsXEcL0E1ShaHWz3ljC59ARY0Egn7ePW/Vo?=
 =?us-ascii?Q?ekTZZK5pXPfR3rYNFIaKT31dHAj+Cn0pQH36Q8g433FBoJj9tpaVCU+kVNdx?=
 =?us-ascii?Q?ft5zUCRx0NGp8MHW4rwZHzGphZeVL7SUIfQ+ZkrkZirhCgPB7DzGZ3Gs2kV5?=
 =?us-ascii?Q?PfQ7wy9vR4tPPsTTIbidklt0PuWKGkTa+e4aJXQqtlpyCRIlth0f3spG7cFa?=
 =?us-ascii?Q?ZZxa84xg8hBsJh8YncSQSU0JsUHKec11nn3Lwl?=
X-Microsoft-Antispam-Message-Info: BnfvbO5ZXpXNwrrmRm/ubrDz39/UUtyzsOJ0iw4gk2A1uEY3PMdnf8QAtOUVqXWRJF/hPISm4hKgSL2tVKPnwxqtRrFjKoxJ65kcXCv42wsr4koFsyVJr+aQDC/ZFM0kz4umZ330LHE6GYLr/9YY9B6+QLg1tlbt+yjwZDNHlS7IJEpJDDw+0qrzXvfa6gm9wRssuI8BV+2KP6/K0LwIhF1dmyycu6bGBwHz5mCnH5llk97zPbZ65xJZZ5vc2AQrIhdtqXxicDtuH0B0Iv/1Zvbaf38gtla9rpmWEf0tOEPGFBg1X5fKDMHlmYMQ0uuRCsd89ytyzLNA/aZFOTh8JnD3mqx/ep6mpgqQ3x2zmo0=
X-Microsoft-Exchange-Diagnostics: 1;DM2PR02MB511;6:MlXisL2A+jhC/mra4IQrMvvH0SSNd+Sq+QfmZj81MxwDW1HIjxwiKamGRlD+k7Q1M+jILqz60Xx7ExkLXf/NIr0rZNQLDoWWWxIeg6woCIRm+nB92xFFMvzEZjlI22FwOiXclmpBnGjo3HafV9o/h5SEUf+m7PFuBzMVj0nE3VTTWs/RcwpQA7Mb+WjTGfCpipnL+xJ+eipWWCRwcVudOOrmPb0UMtYHco+p9+xH9MWTnwjsCWIwtDVRstz9qoCepve6uEali/OgweMg7QHcFQlFWTOLB/GgdQO+jc4vOIkfxmQnn6TEL1A2WqwNZGMeMwtSguWMUdpRd7Ixafzz/YaiV1k63aWR+L1ds7NGE7rMi4Tu197nk82Av1vlErftJ0pbtSpVb+aDenmrQwnBH6lu1nJZ4Q8IrnqR3rKMH5enWk1u8QDnEuZmpqpzjsM8sCbd2jTNyjWNofVFiFmGbA==;5:6tyD4gldAmYGrGR+v7EkXaB/FnOGvIGNcBPYZpmySoq6qasaZWKgvdjBdQfulQq4Qf3+x0M7wPSbvc4OiwXmhrvLAVNsaYpEjAewU4fEujaqabrpG8srVD6U8Lv4Ffemx4Yi3PCsnBAue1XRVjRT0TBJC/RB4Ne8Lk9KNK8QYwo=;7:16gc08q4TzX9cJYK31BHPDSuqBAvxf2kVn+IdDp4mSvJBwABzXi6915GtM4zvdv80ABN+DrT13rKVhFL4V4aY8IURG2kKzDszQhk4DlaizUc7E/BBkkyRT/vSCrc0dqRNdoMb2AL38MHU081aijxllWdPqq+7UDjVxTIgQyG5s6GWmmYz8bc3ez4TVLCqee54ErB84kFnEjKwblQC2zGP1CniesOfhTIfIcs1lyw0s3XQyhMZjjtXyQUol7FoOGw
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2018 13:28:23.6335
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d477e966-42c9-47d3-bd36-08d60f45a06d
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM2PR02MB511
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add information of ZynqMP DDRC which reports the single bit errors that
are corrected and the double bit errors that are detected.

Signed-off-by: Manish Narani <manish.narani@xilinx.com>
---
 .../bindings/memory-controllers/synopsys.txt       | 27 ++++++++++++++++++----
 1 file changed, 22 insertions(+), 5 deletions(-)

diff --git a/Documentation/devicetree/bindings/memory-controllers/synopsys.txt b/Documentation/devicetree/bindings/memory-controllers/synopsys.txt
index a43d26d..9d32762 100644
--- a/Documentation/devicetree/bindings/memory-controllers/synopsys.txt
+++ b/Documentation/devicetree/bindings/memory-controllers/synopsys.txt
@@ -1,15 +1,32 @@
 Binding for Synopsys IntelliDDR Multi Protocol Memory Controller
 
-This controller has an optional ECC support in half-bus width (16-bit)
-configuration. The ECC controller corrects one bit error and detects
-two bit errors.
+The ZynqMP DDR ECC controller has an optional ECC support in 64-bit and 32-bit
+bus width configurations.
+
+The Zynq DDR ECC controller has an optional ECC support in half-bus width
+(16-bit) configuration.
+
+These both ECC controllers correct single bit ECC errors and detect double bit
+ECC errors.
 
 Required properties:
- - compatible: Should be 'xlnx,zynq-ddrc-a05'
- - reg: Base address and size of the controllers memory area
+ - compatible: One of:
+	- 'xlnx,zynq-ddrc-a05' : Zynq DDR ECC controller
+	- 'xlnx,zynqmp-ddrc-2.40a' : ZynqMP DDR ECC controller
+ - reg: Should contain DDR controller registers location and length.
+
+Required properties for "xlnx,zynqmp-ddrc-2.40a":
+ - interrupts: Property with a value describing the interrupt number.
 
 Example:
 	memory-controller@f8006000 {
 		compatible = "xlnx,zynq-ddrc-a05";
 		reg = <0xf8006000 0x1000>;
 	};
+
+	mc: memory-controller@fd070000 {
+		compatible = "xlnx,zynqmp-ddrc-2.40a";
+		reg = <0x0 0xfd070000 0x0 0x30000>;
+		interrupt-parent = <&gic>;
+		interrupts = <0 112 4>;
+	};
-- 
2.1.1

