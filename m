Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753122AbeDEUAY (ORCPT <rfc822;w@1wt.eu>);
        Thu, 5 Apr 2018 16:00:24 -0400
Received: from mail-cys01nam02on0060.outbound.protection.outlook.com ([104.47.37.60]:39348
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753105AbeDEUAV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Apr 2018 16:00:21 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Thomas.Lendacky@amd.com;
Subject: Re: [PATCH v2 2/2] iommu/amd: Add basic debugfs infrastructure for
 AMD IOMMU
To: Gary R Hook <gary.hook@amd.com>, iommu@lists.linux-foundation.org
Cc: joro@8bytes.org, linux-kernel@vger.kernel.org
References: <152286703837.3286.11286329185822795742.stgit@taos>
 <152286810663.3286.1200646003836116320.stgit@taos>
From: Tom Lendacky <thomas.lendacky@amd.com>
Openpgp: preference=signencrypt
Autocrypt: addr=thomas.lendacky@amd.com; prefer-encrypt=mutual; keydata=
 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
 zSNqP+QUNp6BotWI
Message-ID: <e0f5258f-f69d-d5bd-3d48-8cf0676d354a@amd.com>
Date: Thu, 5 Apr 2018 15:00:13 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <152286810663.3286.1200646003836116320.stgit@taos>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [165.204.78.1]
X-ClientProxiedBy: CO2PR05CA0062.namprd05.prod.outlook.com
 (2603:10b6:102:2::30) To DM2PR12MB0169.namprd12.prod.outlook.com
 (2a01:111:e400:50ce::20)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3bda49fc-ebe1-4902-0b33-08d59b2fdb7a
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4604075)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:DM2PR12MB0169;
X-Microsoft-Exchange-Diagnostics: 1;DM2PR12MB0169;3:xzHAKa4DvYJ6Y7gd2Bk0Q7y4thA4XvDJs/a3ZQdjGcYeb0AlSrPhCMy9l/cDX6KwNPjr7Oim78soQ0qimPwSyJZUAXU+67/Wg8cki1xKzoze87M3wEfIfhQsREfI2Oa399gnEuoHLM+HfogbIEaHbj9ot+0TqWuSJSK6aBMVibWN+1GmVvpuRo7o9h53VM6co0IVhMeQBOEmLk9ZHNUFMj2E/tlN/0XCtKLOFkKVku2AaJYyCJ2auqquETomQ2Wk;25:Uisugy9K0o7Ypf/8aCVo/G2EE0Hgp4QQhvIfMgIi5l6/63q5/Y8mAhqIPMpEhS13u6xMMS0MR0x5zYEw7Z4rtyq6MEpA/FYxygFYVM4WgftvNYgPijrg6SypI1sxtEq/c8VhHpMxbGERkpb3kHweKJ8l+h3/Kask6+9ak4O+3DE9IRcOVDkg94/c8twGvCSITRPBrgvPtGA62ZSRQBmJIwEuhpQwR5jnzyqXJLDP9JauT3zsmRTVVNZ4Ny7rrjxCQThnu2e007lxfDz0KCXSKBDQ4d7VgP9eJw1B4j1BNHIgH8O5hFgmifjXwc3drT8ZEPXJAOcj0LWK3lO8Pc1JDQ==;31:Q1yVA1ow5uV3Ltz1KJScfB6J+MCTQrMWYUMHQYGOnqz9rf2OwAoWcHxguzQFnRHoLo3T4S1zAw6VIK0PlU8OACyXasKeHmTd642O3oIjxUeMs7PhkvepPgNZvbkq07BqeW41uq0QPmZyk6vnkf1Ars+HOhk9MrySyLL45j/YgrW42RYjeHXd6IUpynynfc6nCa/cqy1a2KaUWFq7LmA5vDSE8W3oEVIYXDk/EfeLP7M=
X-MS-TrafficTypeDiagnostic: DM2PR12MB0169:
X-Microsoft-Exchange-Diagnostics: 1;DM2PR12MB0169;20:QQ4xrzok9ErcvQIPYaT6a9s9uL5zYZxAa/DCRxOv6tQ6/RA7xTEXD7Y//T3MIK33vebcT7I5QJoSSiN5OkHouW1P9jN4HYTBglV4eRDTgLNpnbz7dUrZOvuI9o88sSonZhiW48sef9381hfeumxtI5EmDDURn29rwgmyNsHbphPlSgfupdQCw8mSsWF+A0OqlLJpQl4R632v3g1Zo7nkTAYMyru+P72aOfON3fX8I1yQvs7lvoZDguhM935l7xfZpL55HIONyQhd/WhAOUWTkOjQTkZwu1Sc8jSmQHSbC71MlpQY4DIXf+bTVRn3IwdS2U2AUPQcx8KkRRJ0PZqveSov4OWVEN+AyxxudOBN6rB+oUMADsGAXXf+ZTEiZ2XsG2edC9X+/T4tzI+7V18TSkVY4TT/h6T4kaPOThHPkEzI2dksskz1SpmCC7AnpuQTjfgJI7poiFoDxS/ptUoT+94oLXM81uf+/St0iHX41ncfChsd4YbIUFnzmGE5mAYt;4:QHcHog37h3HtM3HJy3S98Wacu30XTJie3L3JK/I2qcLKO1FMMQiarknQtC/j5GGUfl6NJ6R8H6IfO74WERycslxCelnSMfD/XIrym3lQGdQv1jpD4xHBI2DKbv10V5Gmu11YZt7xt4ihWL1vY68s89fKfJskUJR/KkeUMN7WOFuME8xZ10ocWkwke2Bcr+aV1TEUEB07w6ciDivs8GUIi+qLAIGSqW7gkst93sHMM0SghOJeAPoywc0CrK9J8Wg7bLTUO5uiRBHbsvs/WRAq16Dm5zd8gdBO+y9rQOgHAmz5jgtKgJhQVsv+gEMk/dx7
X-Microsoft-Antispam-PRVS: <DM2PR12MB01695AD315057124C9F4AE14ECBB0@DM2PR12MB0169.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(767451399110);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3002001)(10201501046)(3231221)(944501327)(52105095)(6055026)(6041310)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123558120)(20161123562045)(6072148)(201708071742011);SRVR:DM2PR12MB0169;BCL:0;PCL:0;RULEID:;SRVR:DM2PR12MB0169;
X-Forefront-PRVS: 06339BAE63
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6049001)(39860400002)(39380400002)(396003)(346002)(366004)(376002)(199004)(189003)(52146003)(47776003)(36756003)(6246003)(230700001)(72206003)(6666003)(6116002)(3846002)(16576012)(65956001)(65806001)(31686004)(105586002)(66066001)(97736004)(316002)(53936002)(305945005)(81156014)(25786009)(186003)(486006)(386003)(68736007)(26005)(11346002)(7736002)(575784001)(77096007)(86362001)(6486002)(31696002)(106356001)(229853002)(478600001)(58126008)(8676002)(81166006)(16526019)(3260700006)(59450400001)(956004)(446003)(2486003)(53546011)(52116002)(65826007)(5660300001)(64126003)(76176011)(2616005)(8936002)(476003)(2906002)(23676004)(4326008)(50466002);DIR:OUT;SFP:1101;SCL:1;SRVR:DM2PR12MB0169;H:[10.236.65.235];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtETTJQUjEyTUIwMTY5OzIzOm56bFVSNklDVWlNMEZGUmIwWmVrZVdKZGsy?=
 =?utf-8?B?VnJpclBvUUVici9WMGRpMWh6c1Rja2dIZ2V5N21vUWJTUnJNS3dUZmdoYVl2?=
 =?utf-8?B?K1l4Mkc4enFXbFpKdElYZzhLNitKRkhVK3RYVEQxeW9CSi9qWUh3SU5zVktW?=
 =?utf-8?B?K1NZdm1YYmVCOGpML0dsOU81Wm5xeFpVZFlJTWZ2dlh6QlhjNXFSMm1Cdm04?=
 =?utf-8?B?aHhMblpOUGJIU2I4R0lSVXJsZHB3RXVUMnZ6TzhtY0dmRUZmMWpUaHk5T25i?=
 =?utf-8?B?d1h3aE4wR2NhazBDV3piUzdnYndDbVJrbFBCMk45ZTRIT0gyVnNqYm5nYWM1?=
 =?utf-8?B?MDdJMWt2NVdrTVlNVURsNHBEQmplVnB1YzlaTjYrMGM0eTRDNDZUZ1VuZ05h?=
 =?utf-8?B?M2dRenM3TXVBM3QzSHlLdDN4ZEpEZVNsRjZKbzRwcXh3QWtUa2NVK08wUUpx?=
 =?utf-8?B?bXpxTXVTQkIyY2phUk83T3M4M21HT0dheUhYYkFhZUFlcTI3VUFVRkROTnNq?=
 =?utf-8?B?a0FQTUJuV25tTXJEVzZYNDlNbmtSS0pOVWNvcTNGS0Y4VDNVeUFQTExUN1Jh?=
 =?utf-8?B?ZW9FSEIwcmpYeGsxZzFJSUE4Z25SVFVsMkRLZVpRL3QzVlJmU2dDUSt1NmhR?=
 =?utf-8?B?d2FMMmFxdVBtc25BV3c1NGllK3kwdjRza2xVLzVDRk5TbFJqRHd4T0lOaHFO?=
 =?utf-8?B?YTVqaHBtd3ljSndTWHVYS0RjTDZ4NEo1cU1Ld1ByRlpZc2tjSVRjZXhVV0ZM?=
 =?utf-8?B?YnlkVHpvSW1yZGo0MmREMHhZT29POFpzSmpVVFREWU9VTHV6QSt6dENwRlAw?=
 =?utf-8?B?R21PeTlIWVZzY3lXUzAwd3RML1ZocEZDejJhekdmK1lqS3JMZWhtbjhYZE1S?=
 =?utf-8?B?SFBaYWU5ZktHbjF2T0FBdEliQmQxeFZaamwrUU9yMGh6Zzhnc1J0ckZzSVl2?=
 =?utf-8?B?RGd4N2w2MmhCQjMwYldtYzlnQjJhNzJPNm5lYWdnVG1YTk9Fd1JjcTd2NzJR?=
 =?utf-8?B?WVZIMjMvWitMVWVRbFBlZytPb3IyY2o5ZjFFMGFTaXFmMHdWSm1MbVlvQU5w?=
 =?utf-8?B?a01PeTZmRmgva1l5dnRUWGxnbldRUWdkMzVRS2ZaMVdyb1pQdzQwTXkwYjQw?=
 =?utf-8?B?UjdzTEtEL0wvNnhPYUxnemhqdStCUkRLR2dTczVqL2NZZFRGVUZpbmY3dkZU?=
 =?utf-8?B?Q3FxYzlBeXBGdjJuMWJJSTV2bnVTRUlIUFQ5Rm1PdVN1SFhLem5mRHVGRzNR?=
 =?utf-8?B?R1pweUhVUlZRZUhoWEpkYXFvdEtNc2RuRTliQXl3TXozdVUzeTBhem1sV2JK?=
 =?utf-8?B?Z2E1cWoxaktITHpWRVpzS2t3MkZoWWpTNTFQOVd3dkNYYUV2aUw0dTBxU2R3?=
 =?utf-8?B?NWl1bDJTcjdrYTY0WUYrQUdMUStkN3hKYW9SQVl0NGMzUjRZMHpBdjM4Q0FH?=
 =?utf-8?B?QnlCSk5wR0c4ZkFkdGlPaVlaUGlkVlNLWjhleHBoaWozTlBlVWFtcURHcnZr?=
 =?utf-8?B?ZW50UnpMa21WRFQ4QmpIcXdHOFg1WWdRUEVDYXRZMkJUc2VwNEU0cHRsQVZz?=
 =?utf-8?B?a3FNRmM0dS9RWjJsVG1hU0hKT1NRTWQxTTFGMTUxQ3lMZ0xDdmVBOXhjRXJJ?=
 =?utf-8?B?VkRwV0E4Q2JmM3I4QWhVZGxESW9xOG5RUXVPa1NzTVh4bEZQWjBKYnhZbDJj?=
 =?utf-8?B?SWtpNDZNUkluQkhsdWhHanlNcDB0MDhVVWV6dlh2SEFVanpVRVNyY2x2djdy?=
 =?utf-8?B?N0VKMGMyY1loK3RTZWEzL0hVSUVkUjBMU0JjRlBIWlhtNitFTXArNUpNUm9I?=
 =?utf-8?B?aG1iQ3JKM0ZNazBDQXFUTUxQOW5NUEUway9oZHYySlFpVFN3Q3ZnSDRmUDJH?=
 =?utf-8?B?WWtaRTMzZStRZllLNHE2L2djV2NHQ3lNak1rY3JCSGNNZEg4Syt2T2svRWIy?=
 =?utf-8?B?Z0UrcEV3b1l5TjhHUW5YRi9xSllSRnc0WUwzV202ZU5CZUFvdkhxR2wwdFVw?=
 =?utf-8?B?VHI5TXQ4L1FRT1ZYQzY1bnVXWmIyaFIzYkFIQT09?=
X-Microsoft-Antispam-Message-Info: ddztJkcnF6uk4usVWHxMKQ6i0mHcGMXR5tyFxijG1+1nB9ybdFc56OOJKY5bDCCZkHcQebchCfajNdCIJ5YXkqZSSdk/MO/AN4owlgQcbs3aNG1swFTMVGYOBK3YkVK3hSEos6alVyr5gX0IoGJQvJLPxmwHy87/ayiAscoMTPeJ/Thy3uC90xbVwx0+WTse
X-Microsoft-Exchange-Diagnostics: 1;DM2PR12MB0169;6:Wf4rAbBx9g+B6B6FB2R1CoNDOyT0j9qasUwGB9qjklW1B/yH2x//1A0bz3UTlqGfHUIEIvuAhhq86DlTddPYoYXSk+96NaCs/REJb1r2s87+NRLFcBcUZacJqFLTizbrjcFz93P9l3z7Im9OH6B1keNRaDeIPFw0kJYyj6w4Ut4w44nuY2r4W4knwHWvPsdCrKuJxpKhbQiKbwY/foPJ6hPWexyus+wTHmB2N2g6Z9AGRaF9DZDNw6AD1w1NK1Z3UBiTz1myUDD+7/xYOjJBHXe8BLn2z2e73zhJXxFBw9gDlgNcMVccvR+G2bqyAiDCpfNKEWv5XjOVhEFgztXCzWwTZ98PF8XrFxKRMW0aLZDlqJdXdCcL8qN2PG5r4SmMbAeb6Jw/L76NLqJm+jd0RK5irCpl9v7NbbNrvTTZ+ZvUrg8nNV2AR93i0cse9saMLDxsxiImXvVf4n8xVC0C7Q==;5:VTXWCJD1XigpwXnwsW3sb20cF8ZqgJIinYqJyXhr28X/eWTPOUgMvgVki2wQAEdcS+ONe6vY/OvZwH/jXy/xfQpXs5He/pxlRJ/8a88MxnLYdF91c4fDnMwDDGANxD+MBdfSCtpny4JyNB/YgRq0kUdFPQPmuTDrc8ACIFsrDK8=;24:mkQtwX6qsSFZDiNNcgYk54wpYDIF2XYqSnsslF0hNEXdvNHhEJEwemB/fJcpypmecxS0e2eL2+DLkUG8LXfC9sMjFiKxVrFrpFN8jvGU1mE=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DM2PR12MB0169;7:m5ol73op5BKbgEl33snlq3We8Hm1shJfguuCyz6TGcIe9neywwuWKYI4zQIUBSApElW+5WuHjl3XUVlmZ1niMBZZbweVL9VIWmQSOy5Z7YTAUSR9Rc9qgnfGu87ONAXYGXJCJ7L1D881r5oMzIe6CnOUiESgtZ0X74YyXuLqqor/gLEj5UhpBZysgVa8hW7rQvUIVUhZYYc06agobDeJgXt0wS/wand4FZkx2p/jgaSJRqE6fCvE4NX4OTjfjZha;20:ONxS9oaUSWsvIl/WnWXO+jKwQUaQdkN9LggY1OMl40FdTlBHAyQfGpxjhUCooMRpiOQB7hcSRzZc8eF0zuZZmdm+IQlO1bHEvw+j5dZ6wmJgOd38eQBlWFGcImkN2BfczBEjGVnnHISfxRLR/a9R/s7A6Bq4J20VHncUi79sMoOoHKLvSMsAl1pNdCkEoc55mppCodtBOGtMWmUO3QKsT0wj15kXmKg1VoYWblQKG2sGTusbzuxW2JYe11jTRV9K
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Apr 2018 20:00:18.4207 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3bda49fc-ebe1-4902-0b33-08d59b2fdb7a
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM2PR12MB0169
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/4/2018 1:55 PM, Gary R Hook wrote:
> Implement a skeleton framework for debugfs support in the
> AMD IOMMU.
> 
> 
> Signed-off-by: Gary R Hook <gary.hook@amd.com>
> ---
>  drivers/iommu/Makefile            |    1 +
>  drivers/iommu/amd_iommu_debugfs.c |   45 +++++++++++++++++++++++++++++++++++++
>  drivers/iommu/amd_iommu_init.c    |    7 ++++--
>  drivers/iommu/amd_iommu_proto.h   |    8 ++++++-
>  drivers/iommu/amd_iommu_types.h   |    3 ++
>  5 files changed, 61 insertions(+), 3 deletions(-)
>  create mode 100644 drivers/iommu/amd_iommu_debugfs.c
> 
> diff --git a/drivers/iommu/Makefile b/drivers/iommu/Makefile
> index 5eb1121d54b9..0ca250f626d9 100644
> --- a/drivers/iommu/Makefile
> +++ b/drivers/iommu/Makefile
> @@ -11,6 +11,7 @@ obj-$(CONFIG_IOMMU_IOVA) += iova.o
>  obj-$(CONFIG_OF_IOMMU)	+= of_iommu.o
>  obj-$(CONFIG_MSM_IOMMU) += msm_iommu.o
>  obj-$(CONFIG_AMD_IOMMU) += amd_iommu.o amd_iommu_init.o
> +obj-$(CONFIG_IOMMU_DEBUG) += amd_iommu_debugfs.o
>  obj-$(CONFIG_AMD_IOMMU_V2) += amd_iommu_v2.o
>  obj-$(CONFIG_ARM_SMMU) += arm-smmu.o
>  obj-$(CONFIG_ARM_SMMU_V3) += arm-smmu-v3.o
> diff --git a/drivers/iommu/amd_iommu_debugfs.c b/drivers/iommu/amd_iommu_debugfs.c
> new file mode 100644
> index 000000000000..282100a655b3
> --- /dev/null
> +++ b/drivers/iommu/amd_iommu_debugfs.c
> @@ -0,0 +1,45 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * AMD IOMMU driver
> + *
> + * Copyright (C) 2018 Advanced Micro Devices, Inc.
> + *
> + * Author: Gary R Hook <gary.hook@amd.com>
> + */
> +
> +#include <linux/debugfs.h>
> +#include <linux/iommu.h>
> +#include <linux/pci.h>
> +#include "amd_iommu_proto.h"
> +#include "amd_iommu_types.h"
> +
> +static struct dentry *amd_iommu_debugfs;
> +static DEFINE_MUTEX(amd_iommu_debugfs_lock);
> +
> +#define	MAX_NAME_LEN	20
> +
> +void amd_iommu_debugfs_setup(struct amd_iommu *iommu)
> +{
> +	char name[MAX_NAME_LEN + 1];
> +	struct dentry *d_top;
> +
> +	if (!debugfs_initialized())
> +		return;
> +
> +	mutex_lock(&amd_iommu_debugfs_lock);
> +	if (!amd_iommu_debugfs) {
> +		d_top = iommu_debugfs_setup();
> +		if (d_top)
> +			amd_iommu_debugfs = debugfs_create_dir("amd", d_top);
> +	}
> +	mutex_unlock(&amd_iommu_debugfs_lock);
> +	if (amd_iommu_debugfs) {
> +		snprintf(name, MAX_NAME_LEN, "iommu%02d", iommu->index);
> +		iommu->debugfs = debugfs_create_dir(name,
> +						    amd_iommu_debugfs);
> +		if (!iommu->debugfs) {
> +			debugfs_remove_recursive(amd_iommu_debugfs);
> +			amd_iommu_debugfs = NULL;
> +		}
> +	}
> +}
> diff --git a/drivers/iommu/amd_iommu_init.c b/drivers/iommu/amd_iommu_init.c
> index 6fe2d0346073..43856c7f4ea1 100644
> --- a/drivers/iommu/amd_iommu_init.c
> +++ b/drivers/iommu/amd_iommu_init.c
> @@ -89,6 +89,7 @@
>  #define ACPI_DEVFLAG_ATSDIS             0x10000000
>  
>  #define LOOP_TIMEOUT	100000
> +

Spurious new line.

>  /*
>   * ACPI table definitions
>   *
> @@ -2720,6 +2721,7 @@ int __init amd_iommu_enable_faulting(void)
>   */
>  static int __init amd_iommu_init(void)
>  {
> +	struct amd_iommu *iommu;
>  	int ret;
>  
>  	ret = iommu_go_to_state(IOMMU_INITIALIZED);
> @@ -2729,14 +2731,15 @@ static int __init amd_iommu_init(void)
>  			disable_iommus();
>  			free_iommu_resources();
>  		} else {
> -			struct amd_iommu *iommu;
> -
>  			uninit_device_table_dma();
>  			for_each_iommu(iommu)
>  				iommu_flush_all_caches(iommu);
>  		}
>  	}
>  
> +	for_each_iommu(iommu)
> +		amd_iommu_debugfs_setup(iommu);
> +
>  	return ret;
>  }
>  
> diff --git a/drivers/iommu/amd_iommu_proto.h b/drivers/iommu/amd_iommu_proto.h
> index 640c286a0ab9..1cfaae28c2cd 100644
> --- a/drivers/iommu/amd_iommu_proto.h
> +++ b/drivers/iommu/amd_iommu_proto.h
> @@ -33,6 +33,12 @@ extern void amd_iommu_uninit_devices(void);
>  extern void amd_iommu_init_notifier(void);
>  extern int amd_iommu_init_api(void);
>  
> +#ifdef CONFIG_IOMMU_DEBUG
> +void amd_iommu_debugfs_setup(struct amd_iommu *iommu);
> +#else
> +static inline void amd_iommu_debugfs_setup(struct amd_iommu *iommu) {}
> +#endif
> +
>  /* Needed for interrupt remapping */
>  extern int amd_iommu_prepare(void);
>  extern int amd_iommu_enable(void);
> @@ -58,7 +64,7 @@ extern int amd_iommu_domain_clear_gcr3(struct iommu_domain *dom, int pasid);
>  extern struct iommu_domain *amd_iommu_get_v2_domain(struct pci_dev *pdev);
>  
>  #ifdef CONFIG_IRQ_REMAP
> -extern int amd_iommu_create_irq_domain(struct amd_iommu *iommu);
> +int amd_iommu_create_irq_domain(struct amd_iommu *iommu);

I don't think this change is required for the debugfs support.

Thanks,
Tom

>  #else
>  static inline int amd_iommu_create_irq_domain(struct amd_iommu *iommu)
>  {
> diff --git a/drivers/iommu/amd_iommu_types.h b/drivers/iommu/amd_iommu_types.h
> index f6b24c7d8b70..43c52797810e 100644
> --- a/drivers/iommu/amd_iommu_types.h
> +++ b/drivers/iommu/amd_iommu_types.h
> @@ -591,6 +591,9 @@ struct amd_iommu {
>  
>  	u32 flags;
>  	volatile u64 __aligned(8) cmd_sem;
> +
> +	/* DebugFS Info */
> +	struct dentry *debugfs;
>  };
>  
>  static inline struct amd_iommu *dev_to_amd_iommu(struct device *dev)
> 
