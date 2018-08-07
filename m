Return-Path: <SRS0=n5k7=KW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3CDDC46470
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 05:18:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 41563208A3
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 05:18:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="UGC7JK30"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 41563208A3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731498AbeHGHbL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Aug 2018 03:31:11 -0400
Received: from mail-sn1nam02on0051.outbound.protection.outlook.com ([104.47.36.51]:20730
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727224AbeHGHbK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Aug 2018 03:31:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mhCAEhg1C3pXD08eV7I3G8PEpxN0We1RBOwXVX7FanY=;
 b=UGC7JK30lT4QwSMombbU7UYgevPgiQAMvIm/E+dqEb4WAwRIaPyF9B9BJDQaxOoWPTODlDp4woHncf06vMZSuHdd4Ly+gsZ1qHrRF/ztlGUaV12kU4ooP9jDG7W/v0CBIZwFHeQFxElvGN0qUWlqzSSGu+RKr95jRLoEIAvs+xc=
Received: from DM3PR12CA0052.namprd12.prod.outlook.com (2603:10b6:0:56::20) by
 SN1PR12MB0255.namprd12.prod.outlook.com (2a01:111:e400:5143::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1017.15; Tue, 7 Aug
 2018 05:18:34 +0000
Received: from BY2NAM03FT041.eop-NAM03.prod.protection.outlook.com
 (2a01:111:f400:7e4a::209) by DM3PR12CA0052.outlook.office365.com
 (2603:10b6:0:56::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1017.15 via Frontend
 Transport; Tue, 7 Aug 2018 05:18:33 +0000
Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXCHOV01.amd.com (165.204.84.17) by
 BY2NAM03FT041.mail.protection.outlook.com (10.152.85.246) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id
 15.20.1038.3 via Frontend Transport; Tue, 7 Aug 2018 05:18:33 +0000
Received: from hr-amur2 (10.34.1.3) by SATLEXCHOV01.amd.com (10.181.40.71)
 with Microsoft SMTP Server (TLS) id 14.3.389.1; Tue, 7 Aug 2018 00:18:31
 -0500
Date:   Tue, 7 Aug 2018 13:30:08 +0800
From:   Huang Rui <ray.huang@amd.com>
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Felix Kuehling <felix.kuehling@amd.com>
CC:     Oded Gabbay <oded.gabbay@gmail.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Christian =?utf-8?B?S++/vW5pZw==?= <christian.koenig@amd.com>,
        "David (ChunMing) Zhou" <David1.Zhou@amd.com>,
        David Airlie <airlied@linux.ie>,
        <amd-gfx@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] drm/amd/amdkfd/kfd_int_process_v9: Use true and false
 for boolean values
Message-ID: <20180807053005.GB913@hr-amur2>
References: <20180805003045.GA28643@embeddedor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20180805003045.GA28643@embeddedor.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(136003)(39860400002)(376002)(396003)(346002)(2980300002)(428003)(199004)(189003)(23726003)(72206003)(81166006)(8676002)(81156014)(97756001)(1076002)(426003)(446003)(8936002)(55016002)(11346002)(6306002)(9686003)(966005)(316002)(50466002)(478600001)(356003)(33656002)(305945005)(68736007)(104016004)(2906002)(47776003)(86362001)(5660300001)(486006)(33896004)(53936002)(106466001)(4326008)(336012)(6636002)(6666003)(126002)(476003)(6246003)(97736004)(105586002)(186003)(229853002)(77096007)(54906003)(26005)(76176011)(46406003)(110136005)(16586007)(33716001)(39060400002)(58126008)(18370500001)(107986001);DIR:OUT;SFP:1101;SCL:1;SRVR:SN1PR12MB0255;H:SATLEXCHOV01.amd.com;FPR:;SPF:None;LANG:en;PTR:InfoDomainNonexistent;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: 1;BY2NAM03FT041;1:QA+r1LMfHXCC4QykEC8KeGOb6tIKn+i/lXbClUUO34nHcFONHQFVD2gbeCufzJr4vYGYzk1C7f+nxbCR7PBcBd5H+eLlqymlRM+hVODZjZT8PElufVJJZp/ZrM2pUBGM
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d6477363-596e-426c-29d9-08d5fc253891
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600074)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060);SRVR:SN1PR12MB0255;
X-Microsoft-Exchange-Diagnostics: 1;SN1PR12MB0255;3:7QqZqJ+P6C9pidIyES/wLbC2t2rOEDRjSoDzFdBGHstBM1hPEqjxtZ15yb6SeaykavTU9vSdorXEx4cegvenxXAWRdzk83cTGvUPPxnOb5JJP9ISUL75OLrHVE3Gm78He77TgHJi5X8vYJtYtx3sXf+uQEReWJqnE2irvbaum/CjrkKqA+D5Q5LiMHqNs2ppyYcPmf8/zQNZVwC5ysXjjLMOeLyPNXtbY5VNyYbbTXvXtN0u8LdRgMNHfUrhKaZFZbt9FFUI0Mm5PJb9nmgBX7jy6rT/3PiJbS1EE5vJJV2x96bn7FX98daBFGhOHDgzCjKwkU1v+iIrBdmwCY1li4eacyY18bjh8eW6M0QTc4U=;25:aM28VaqgSTBOrJkvXQRZvUiCdsrlLpxaLyLmHMC2UfsVvIClWGOG4oMFmiiGrMmDk1f7fHnF+RY2P0/xvE+W/gyf85iOYjpAuC1iKGhbdoKkS8n7eNuZh1jP8BHQAzpsNBBNuG4MM8/LC0jtHCVRMMR/1A2sTyml3LVpmjk7P0Rmg3CqPSEOYRVxPR9rkze0GDDux7QbaecNcXycniqtm4I+yhLMp9AXpPAOcL33saSLPp3AFcVzYe38MU4lxu1mOM/gnFcXbImKGvGuVCayRPPL3QUDNtGBbHfIXwyqvN7jYNc0/sJWc1kV3kpyiVIIAIT//bAjbcEILbZMXRbkrw==
X-MS-TrafficTypeDiagnostic: SN1PR12MB0255:
X-Microsoft-Exchange-Diagnostics: 1;SN1PR12MB0255;31:Ksreu3IkoxqwOHroMW44uUCAWS1IRsRpf8CG8FVpXmjLV1lVBAIj9qHJRBRumgFmSSN2UHeFroQBm5ZFxN4zyW38Ec0ZccMh2y+jjPPi1AVjGgexlleNXLHUuUvxwKXtNynSYvHWMkGCh9SQumKZgknyvDIvEHKwx+z5GB/RnvqCHYEUYEnrdizK9y/bOL562I46tvuEJhXamqfuXtcCc8EiB/OIfQOYkwSqpDm6aYk=;20:YY0bTLmkZYCgDWrqlpiw9Ulx+EgGQ4HKZK/dHc+vhiWgKzcQ1RNvpEedjEvfCRFj+15B106yYN6KtcfWyNsL74HFZDqYz8GZFJIn4+GsgvJcKk8RZdKJ6g+M1M1WXCsTEE3cZECCXIwtQTHIut0xp1pY1xEde/aWPNR773ExwgZ71Tpgad+wQq9pZkX6MjWt20koO531vZyLnJ6a7opvN35+5Zf+DMdhyn0HrKalvKSwIdMq0HOJPkIVieunp6l2Jh4tUzhwuPANcT6d4LAOQdEOpxpOIqEtLpTpFH3/p3m9pZKDmIKGFesIYRFxXOHptBoAhoq5kN0eHaa3BLyUZjOFj4/c5j+7JGGdK94W+94LO7QP3CMFB/rsZSuCCTuVlRot53UYO9zFe93FfnrtyXf/vLnLOpRhFXH5YV5oiIKwon+D7Q5uRDgP0Vgw37nmOkAdmastEijB+/4CwXI4QOflM70CNfqo/X8PKL1srK683ZJu1NlbyONNQJtwvcKn
X-Microsoft-Antispam-PRVS: <SN1PR12MB0255B4FC8CE337CBFEC54A9CEC270@SN1PR12MB0255.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(767451399110)(217544274631240);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93003095)(3231311)(944501410)(52105095)(3002001)(10201501046)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123558120)(20161123562045)(6072148)(201708071742011)(7699016);SRVR:SN1PR12MB0255;BCL:0;PCL:0;RULEID:;SRVR:SN1PR12MB0255;
X-Microsoft-Exchange-Diagnostics: 1;SN1PR12MB0255;4:xXeM6bC7ZiaDp/DXr0NNe0MEVXzgVwAxPR3H5AsQjhwCQWp/qDCMDHhq65VE4TKFS9oW3LKkE+kywwydD/NkdJdZwKfDccSQRmDq57ME07RTv+O960ZmsEdtMB/yUIF5/k+9GqBPQnzxnaPfJIaLypIdBZCsUHGvLnkU9+Ko9U/08JubBW1YPDslzGRAma+MfI+Mbmjgyh693LK888r1SV7EEbCeS9oGeNFp14yJ0K/UdwDCcKmg0i0zHTwtZ5muAoHkgMw9cQcFgPljbR/EJZWwMG5eN1uj2hDMQ8XkhaMM3MljgHsRwPX6LONNDbm4rBcubTJ5Bw6zQha/90ZSWzovMI4+Nmoojk+tIDzJ8HY=
X-Forefront-PRVS: 0757EEBDCA
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;SN1PR12MB0255;23:49byqTK8Zhm7a13yDRuB7NTP2FDIxHyS3RadOPWbn?=
 =?us-ascii?Q?Wy5JMq01GTcBo1RDW57GXUf9wmFZzxRi4098kXuBdXlpblx6oLyYVAUoZXNa?=
 =?us-ascii?Q?iUc+vjFZZuzG+mpGgtvobK+bjiHL1CScIB3Gmo+8QVWqVeJNGQUMqibb3Ov/?=
 =?us-ascii?Q?0S4JQmrrOG3lW4B17Je1DyS7VlBqFuq389UYzRxd8EXHv3riLgZGLB2ZwJuN?=
 =?us-ascii?Q?BAIjMFiVXPdE+0XgKt/2PDFDzKHCVImypVa3/Uogpj8dFZ7UGbjQwavW+0GA?=
 =?us-ascii?Q?3gjMQgVfxQSLrypBU5KKtUCnt/YureWlCVNclFP3j99g/RyUSGq7Q2Ri+YyY?=
 =?us-ascii?Q?CSumuT2ul/HPVhAwCoIqZbiDfLN9mJv9iR8Gr7qa9Yyx2KWrglU6ayw1M5cn?=
 =?us-ascii?Q?yvUPRQ0/W95q/4nTdvkNAThVE33kEdM3I/Lv/G2ztoEBkgYX+B9xFmtWEEUF?=
 =?us-ascii?Q?Gz2G7shKCN+Mqa3AkQxbNGo9wThuTzODlnMoSfoMGD4yxgNkK/kEAcOmT7xF?=
 =?us-ascii?Q?aUnrhTND6FbM7ea9w3L+xVP3vJqJ5b2QhJ7nkopH6BXmyalpxLItXZrC3CUi?=
 =?us-ascii?Q?lEtLkWW71BsLN7KqqBJesDoNHcH/SgyxSB15H1c/q9KG5TrCsWg3WLuTjHZq?=
 =?us-ascii?Q?2QAX5uuzDWu1QiMv8A+/aJoC+6MsvjYfAcuSNtBKn6LLpj28Mew6iCAPTmwi?=
 =?us-ascii?Q?9qFxN5HhYOLFOh1NebpPpgiH20nIBr+oLy1Jp7u9o0mbSbSfAFMFUiAfMUXn?=
 =?us-ascii?Q?9f0d4cR1ouR7E0Uy/FZ7xlSZoMXB+ymWFMerIjk8QYEQo8Ne2ug6MH4eUHIg?=
 =?us-ascii?Q?P6fOxcJQGidyBY6KPRhUHfozr4O8terEUCDpJq8BN+9QWxybZBPVoJaW3u8V?=
 =?us-ascii?Q?KV66iazruj8+DLQnDmZgPgVry+pQypRNiKA7QTgCzTJh6jRm0D+wKR6PUPVl?=
 =?us-ascii?Q?TVeBe8sE4FcHfT/1K+6m3MjaA6F+IUlUeDchT4HFFR8Jppnh5i5UGQ3XdhW+?=
 =?us-ascii?Q?D0s/ACcV2RFbKNMsA2YuSELSWzW7rP9qA6eDiAOCDCgQ2tUxWwqFJCr8Pigs?=
 =?us-ascii?Q?+f1iFv3G4k7zmPPFPeKYAHW6MpLFQv29meJBycP7fOX8ukuOfyYKwXw0V3zL?=
 =?us-ascii?Q?DPF9hWG/SxvVnFSZ9bcvHx6gaxVfDQ+76TmNk2V4uN9BpVsyU9t6QOOxkk2c?=
 =?us-ascii?Q?/9cRJ1kuEDUXUfJ3tFXR5MrQnb++bzthMCeP8+BrzwEzJDn+lMRsb3fr02lS?=
 =?us-ascii?Q?3DyyI+SWunwSTM+mJutDcV6iin8WVgJWSFP2W2670m1EAb4PMJY7Ff1J1aIm?=
 =?us-ascii?Q?N6RDGLhp8EYCHDlYwk9McHqXycTPvy2hGV0SURAzjtGHXjxqTFvtjqJIsrQy?=
 =?us-ascii?Q?7VfMHL4b8XTsS01I5lUCPeFXHgbmMdSxIcORbMRq2DEOo0N?=
X-Microsoft-Antispam-Message-Info: pDOD/6gXUL8E7gSeX9jQmGcVYfRzd9zPfLt+Vn7aiThjA5CEYf3h1NUo6dsD75clNZbYQDkXnqxrV/xz/inB6AktsoIcDGg6zovSub7n3NXQ+EDVntm+9Oe3vh18pApvTkMPNeOxf9i6/53RN4dHNrbIJzCuQfxE4gl4AW+AaN0XjLBS77m8YFqfVbn+jWR3Sv/TyMWunBLmMV6uNfxQE71Sai7mBLjPhVIgrRQYt075zQm0v/8oWPksZeHiKokCKtiCF5SLuX3gUuJXSjVHaZzZvdQBVn3hvGpZmQeI+yUJRj/tME6hB1KWxWWH0oRbH6XloaRKdND2YhlbjbQz94jh6gXsz6PBRtwlmBXRZu0=
X-Microsoft-Exchange-Diagnostics: 1;SN1PR12MB0255;6:6USlJGoMMF3S4WkDT6GDv4NC0FCfNtpp0c/Uk78Fsz8NAC6c/RkRAJgYcVN+tcprjZuIOmjJjLMZuboga1QyjXpJqn0u0vDyWyk3MZGQBuRMRT14pNkNYnNTXRt8X80uBFtHSg1letIOtUl76Bv2WJ+JxV+GNxke+ShYqE2243P7NWDpWkBLabchnEfeO4wWgXEzvI7VzhqKIXAU1iSotv2ptSVOQPc6HouG0BeBZVsaVypA9nAtx82gi+rUZ21+UG8E4w4nT3YFATKby/Amtu9sLLUQJcP0L8UjyJnB8lJQLZldYJkECqSvFwmH84Ti5sQLdUNDiYEke80l6PwQ7RlyuyL6ttJ0+T6grUdfzWk5A1dmlXtzbDr8wcO55E2g8w5zVQVwlrPqnYT2cVfVsGIBrY7rRxWgboMzudPEQxW/SJrtnfzIaSsBJ5GCkG8Q4LCUPm/PieNaonNJjItOcA==;5:uhSdbmJONFV7OU7qE1Oe+mc82d5jGI6TZ1echLv75CqXA/d+ikXj1qc8YHakrYFpyyaT/mksbPhEHKrfMTvYOv9MFcjzCtaGy49qNiUxVwJzSbNLconLUaFJ4aOFz9xGvOceyllvDw5BwukoxBQgQtcV/Ldy2JMBuPhuWnPKQQg=;7:FJHeDeoR9E32nb7EfP0x+C6Nv8YQSlVYfOV1Njhz+MTNXphu3v1E7a1yL0GQLRnqcWn9SNvn7Gb/2iDLFYiaLjjDwWFToIm2r+RsR7oKHXq2CTZ+hjvEdE0AdFZJ5ELN4i3+Re4hfodL8bdtCxUIoj8l3rHHSbDtdyTxbzI9OxWWxXksYjLOxc3tzxf/yHFKPLa9daVtSgZFYXrtdQOng5f1CG2ylT8qWyLBH2j0Gd7qVVZIc3+a+OEWAObJBDTp
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;SN1PR12MB0255;20:E4VL9ayN3N4SLPU4K/70iqgLEJo50y+naVYbTi5WDv6bWcPHt+ssWwWFP5TMImzU5GWizKHiCmMPcJylsOw+r3ijBzfYzDd+HgIA6XgWR4Zlf+Mxhy5X9n0i6MAFBjnS37bzJvrY+ix3jTYFOMIvUEzL0wp4XPlwAeaJaefwhgA0qp/51TRQp7JZ29LJrWiUK42Hevek53YjtjVTLYG3azEY8EXYDMe1yWAGFdQ5XR+OKea1YFr8UrSU7yxlupGN
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2018 05:18:33.3632
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d6477363-596e-426c-29d9-08d5fc253891
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXCHOV01.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR12MB0255
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 04, 2018 at 07:30:45PM -0500, Gustavo A. R. Silva wrote:
> Return statements in functions returning bool should use true or false
> instead of an integer value.
> 
> This code was detected with the help of Coccinelle.
> 
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>

Reviewed-by: Huang Rui <ray.huang@amd.com>

Also add Felix for his awareness.

Thanks,
Ray

> ---
>  drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c b/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c
> index f836897..42e92e3 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c
> @@ -37,12 +37,12 @@ static bool event_interrupt_isr_v9(struct kfd_dev *dev,
>  	vmid = SOC15_VMID_FROM_IH_ENTRY(ih_ring_entry);
>  	if (vmid < dev->vm_info.first_vmid_kfd ||
>  	    vmid > dev->vm_info.last_vmid_kfd)
> -		return 0;
> +		return false;
>  
>  	/* If there is no valid PASID, it's likely a firmware bug */
>  	pasid = SOC15_PASID_FROM_IH_ENTRY(ih_ring_entry);
>  	if (WARN_ONCE(pasid == 0, "FW bug: No PASID in KFD interrupt"))
> -		return 0;
> +		return false;
>  
>  	source_id = SOC15_SOURCE_ID_FROM_IH_ENTRY(ih_ring_entry);
>  	client_id = SOC15_CLIENT_ID_FROM_IH_ENTRY(ih_ring_entry);
> -- 
> 2.7.4
> 
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
