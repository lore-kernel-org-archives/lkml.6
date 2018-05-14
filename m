Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752077AbeENUBB (ORCPT <rfc822;w@1wt.eu>);
        Mon, 14 May 2018 16:01:01 -0400
Received: from mail-dm3nam03on0045.outbound.protection.outlook.com ([104.47.41.45]:55723
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751422AbeENUA6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 May 2018 16:00:58 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Gary.Hook@amd.com;
Subject: Re: [PATCH v7 2/2] iommu/amd: Add basic debugfs infrastructure for
 AMD IOMMU
To: Randy Dunlap <rdunlap@infradead.org>, iommu@lists.linux-foundation.org
Cc: joro@8bytes.org, linux-kernel@vger.kernel.org
References: <152631818082.18929.13970142119193316487.stgit@sosxen2.amd.com>
 <152631842907.18929.8819955271544326298.stgit@sosxen2.amd.com>
 <ba2bb6f7-77ea-4431-af0f-d20c19820d5d@infradead.org>
From: Gary R Hook <gary.hook@amd.com>
Message-ID: <5e45f38e-cb45-d4a1-f351-30543f787290@amd.com>
Date: Mon, 14 May 2018 15:00:50 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <ba2bb6f7-77ea-4431-af0f-d20c19820d5d@infradead.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [165.204.78.1]
X-ClientProxiedBy: SN4PR0201CA0053.namprd02.prod.outlook.com
 (2603:10b6:803:20::15) To MWHPR12MB1453.namprd12.prod.outlook.com
 (2603:10b6:301:e::22)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:MWHPR12MB1453;
X-Microsoft-Exchange-Diagnostics: 1;MWHPR12MB1453;3:w4mdgpRFVifPuJCFSIoBtun4lUXM7Dx3pcCWeksgojP5MHzBGfTwPcOQUO9rzNH9QIVH1UgRvgHlykXUGe2duGA+qon+2ZVpbN16x8X+pDTXpUUXNOpO4NBvEUIa6eTFRb3IbWxB3DPBxHqHIvrobQ3etWxqbYDVJL8EK/7TPcn/JK3eQ9nbg109Omi+I8X/0PrBi0hHWX14TMu2ibI0hlLdF+iTX3bfft3iQ12ZOHSOR4RMtssUB0LENuDVPXlz;25:PWHFdJjrjzgS/0ZjHKW4JgmZpwkDHdymS3BFve/QLBu4cx/WJ+RT3owr5tG/Ic74H3Q7ywNgp/5sA2s16ln8B96nJrLwLd+imTa1/tdBurgXoeeqGloCUrzt7xlJ4uhA183H3t9AkaNvtXCdOWmLrswL4qv58BUWfSQ8B+vvm1KywO1mZMTg37F09UhvzbpKkbvxN22aoEINWXZjLJLUqldicQLQzafF1EZV7Ywj2BzK6txFz+jKCDYrzxbSYrgum2/o2qmFhmfmzHjQd6pkoWoRYaFTUQE4vD0WWvX1XpRp5BjHaSPTU1ptngCEE6LJCg7KEkXlFc35855T7Wf2nA==;31:073pdVdOeHHQY6Y13uunvwFLrxTm/OlL6GtLwBfFEUwvAcOtWQ4gSYyonTEd14XoJ3PxcKvxxXWEnBynaSSmyoKICfriVVk+1Bu6PiLUz+wKmjhK8gEiYlF1Fe7jez37uGpQUq6g3xkpBQCF78IY3UdkxpPOId/8UK3myQlTUUmjjNUQG6uAW5qvGXVczeI8MDEODlPwlnfOqkYVwfpxdf3zCEe3vHPnEWhcW/HupJ8=
X-MS-TrafficTypeDiagnostic: MWHPR12MB1453:
X-Microsoft-Exchange-Diagnostics: 1;MWHPR12MB1453;20:HG8o/UCoX0wkahKXGEQ/uvFdETooiIPNvwfqS99m0L0Gf2I43Zm9buWMspxKHXJWLXrmdrXjEJS1f6bpvD9DsuVcgWk+ViXfS0jd/0kuS/FIJILb35NEAKNKaWdvwToMzitVqpT/RsEISADlBusfrQtMEuhF8lgEB3UjRfoO3golJE22G/T4q5/pobjsjVFEmuRmPkyJgUcTNX5CHOmPt68eCvGFxIR4Mm7bL2qCm1iNeIY1DXBuHx789YhSaf6tA6ZHvwdRLucm/MrU3MWx6IXp2UTfcXy9AzBkZl3uGlF3HEV4s+HGo2jmAQQc50xS7HjB0SBWjB286T1hmgIRHwVajyzVjC3E7CinQWw9ehVr5ckZ7dzB6jLeNAb5YqmUD/hmVyxZRB3vkgxVCjNd/pRs7U3SB1SNRIx9KtRT0T8eBSyWubhqlXsEL4mqScRVXbqLOrK0kpNw2XSQV4N3sgDAZ09/A8TJr+pTFNPciJ8AbVr1ibhwr57/2HQX+TAa;4:n3q8ObKHIpUH1awGjuHXprpP3XwaKzFYs/yU3+9kuPhoxo11B/+Z8LWzXWiM7BLMNyM2zyzQHq32CVsV5CQSEHRb78yvx4xWJOmlc70UkPr28XMLXmUukwzic9cFJ0tFhymEyQ8AdSn+YhpeNKINMG5r5Qp5kpFO7E3tiSEuppJNnfszTkzqvQpUVbB8PJ5uVB6v89wb3oa68RTKOsjQ6gPltx2F8Icm+Ufdg49YFPptCTcESGF8XN4lytOC82PPhx5DZNxwHWhBHQdcJDrBF5vQPSq32Kj/gZ7xnhldtd5de85LjG+ejzsCt83puIIq
X-Microsoft-Antispam-PRVS: <MWHPR12MB14535B6DC7220E2FE05BD46DFD9C0@MWHPR12MB1453.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(767451399110);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3002001)(10201501046)(3231254)(944501410)(52105095)(6055026)(149027)(150027)(6041310)(20161123562045)(20161123560045)(20161123564045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:MWHPR12MB1453;BCL:0;PCL:0;RULEID:;SRVR:MWHPR12MB1453;
X-Forefront-PRVS: 067270ECAF
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6049001)(346002)(366004)(376002)(396003)(39860400002)(39380400002)(199004)(189003)(97736004)(6116002)(31696002)(186003)(230700001)(53936002)(316002)(47776003)(6246003)(67846002)(3846002)(77096007)(23676004)(2486003)(52146003)(52116002)(72206003)(26005)(11346002)(446003)(956004)(478600001)(2616005)(476003)(86362001)(16526019)(76176011)(486006)(53546011)(386003)(229853002)(36756003)(81156014)(7736002)(81166006)(8676002)(8936002)(6666003)(106356001)(58126008)(105586002)(31686004)(6486002)(25786009)(5660300001)(65826007)(64126003)(16576012)(4326008)(2906002)(50466002)(68736007)(66066001)(65806001)(65956001)(305945005);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHPR12MB1453;H:[10.236.109.62];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtNV0hQUjEyTUIxNDUzOzIzOjErb3BFZlRBZFhOdXNKdWxucmNqODU0NkIy?=
 =?utf-8?B?WFJzT3F1cHVKc2dLd28xbnVPYmltQXNWRVk5akN5VjB5dU8zR05td29rMng5?=
 =?utf-8?B?SDJURXkvZENQbTR1M085Y3VCMjJBMGZHTFdXRUttNjJWM3ZFTC9RYldFY3JF?=
 =?utf-8?B?ZkVnSy9lVjcwUzNmYk1HN0pRbXNsZitoKzFBbzlGbXhwcGR0dXoyKzRVcmhh?=
 =?utf-8?B?WUlJSkl3WmpyemlvbmZpQXV3MmI1bkhUNGExSS9oWXgvaUduQkgrTnVoSi9t?=
 =?utf-8?B?ODBzNU1pSzJRd0lQUHByMnphMENvelFsV2h3aGQwdE1rMVVnVk9SaXpLMzlU?=
 =?utf-8?B?ZFcxVGJCSmduWmh6ZUlVemQ0d3piUGliT3FOWlIvUFVFZ1c1MDdoeiswK0pz?=
 =?utf-8?B?OEszM1F1SmRDOTRiM3BTdVEzbWF0RjFiWVhBa2s3RkoxV1lGZDJXSDVLU3Rz?=
 =?utf-8?B?RWVpT1Y0VklkZXdwMVBLa0RvWFBKQjlqRFdQRi9OSThVSy9HRzZFR1lodldK?=
 =?utf-8?B?RjhURHpneW83R1ZLMm9aOEZjVVhCUjRWbThBaWZpRUhWdHloZTUzT1hXU01w?=
 =?utf-8?B?anhtcThYSjlMVE1NaHYvM1NCSjNZYlFzZnF6cUUyYzQ1N3RIUlNRMzdEcGNx?=
 =?utf-8?B?MXpKSDRZd0svY1pVNDN3TS9vaWxCWGFtaE4wZWFmdUhRZmoxVytjZ21lYXkz?=
 =?utf-8?B?Q2NNYm44blhESnFCb1hoMllwTXQ0WUdSa2ErS2RnNC85N0ROVEFJSlhYMnlk?=
 =?utf-8?B?cjB5UWFKU3hPR3YzSHdGcERRNVpHODkwelVtRjFzZzZUTnZ6Uzc0a3dOcElR?=
 =?utf-8?B?Q3BmeTdiaTZDejcwcFdlSkpzRzY0Q21YdWZlQ2hXd2tDUWo3YWtUcXQwaTMy?=
 =?utf-8?B?RUhITmFLTEh3bHM4dlk0M0xwZUNISjhiSXRvSVBwQmFwckZpcVRBVm8xWGpE?=
 =?utf-8?B?cms2elNiTUx5YTVaS05GTEtrWWg5endSY0E4dUtKSGlabUw5WXVPZWVnd3lY?=
 =?utf-8?B?eFFaVEttMmFhY08vcTFZclNheFMyZXM4TUY5Q21LeHBLUERRTWhIMkdoMTMx?=
 =?utf-8?B?OEdyNkgzU0FsWVdNNGVtVit5Tys3RHdacUxMSTlGdXhZS2tEUTFSQStHT3Vo?=
 =?utf-8?B?eW5aalFxTFVPeFFaY3JLYWtsQmwxTkVqM1pQSEVkb1J5amdaTmkwVnFBNlpP?=
 =?utf-8?B?NENja0EzdDVhUGhDN2hVUUhlT0lsa3ltWTAwWXhTOE53VlNvUEhndEwzTDZz?=
 =?utf-8?B?cVJZQ2FZMm9PU1R3QUFmUFpPSFRic3h6RVZvWW4yd21NcHhOMnFFRHNIT2Iw?=
 =?utf-8?B?aG5Qdll1R0wrU3hiRUkrbElRaldaOVZLc0JuSllGNkVrclhSazFab3BYczVp?=
 =?utf-8?B?bjU4aHo4SEwvcFZkWEV3TTJNcXFHVzBCTEtlUkpsc2hWeFNxTFUvMXAyNVZK?=
 =?utf-8?B?TCsrejFjY2IvY2RiTjBtSktHbk91ODArL21mVE5RY1Q0QlZXYXFscHhNRldZ?=
 =?utf-8?B?NSsvMVI1QVRBbENVb2tzSk5ZV3lxWnNZdTdybUNpZ2dsZktPRWFVNWVnVHRC?=
 =?utf-8?B?aTZKTVU0SXJLM0U2N2tzWFYvUng0YUdVQkJWUlI4V29hVWRrMDR3ZFdoOFF2?=
 =?utf-8?B?MG56K0lRN0hEenFIUWF2VkF4M3BCcWRXYVV5QU1RcEluWnA0cWFMNGlHL3lJ?=
 =?utf-8?B?TG84ZzdYSGp3ZEN5NDFiZmRQUVAxcXhZeXF6am5wclBpNmNRT21hRHRMKyt4?=
 =?utf-8?B?TVN1M0VmU1Rnb3l5Z01RTk5LakJUN1V0bFkrNkZBQXh1bnNWWHBaOGI4VVBP?=
 =?utf-8?B?OWhZSjQrTFN5dVhINVRvczYySFhBcFIrcjNiWUk5V254T1RWZ00xZXdiSGpX?=
 =?utf-8?B?WDBYdVB5SjNmL3BrbW80OTJiQlN2WFVJYkJwMjJDVmM1bmJwV3JHZ0RFaW51?=
 =?utf-8?Q?pu2vK20LBCpPt6aNlFKmKQWEkdG1Io=3D?=
X-Microsoft-Antispam-Message-Info: YP2rbKhgZE3cnwfKWYajRanDYXtqRpESdvyk9swsQorCzAsQvW9oY29I2EXuOsVHev6LUy3o0Ya9Eqol+X9SaY22EV544VHTxJuaJ3rpTNegA+xJLkvBSiLMs3BZ1G9E/vNlu00FQn2L+KQdXgNHjfmxiY7Kg8TFSQt9delifD9fadw1ragEW0UroVcwrmCC
X-Microsoft-Exchange-Diagnostics: 1;MWHPR12MB1453;6:m5HLkzmb8ZGF7d0bZAIAzNG3fkKUflhCTUl0nUUPx4ZCKc65eJth/HNzq+lcgK4Wv/5XJGcNaqKqU4CdvuNhmIYm7fIZNNPh6n5ZbCAt2qpvwLELJ7D8zlppLcyylZFkoLc013XhmM16sl43/kP6HwOqu+0GM8MnpXj7eeIxUC4fwqlox7lBF5OL2pv6Vr8D6lDFvPhw9zmGF506mKGDgoV///+AE7rM68UFGArMeXenqZiDcG8gPuRfsrqda5ist2qsayJMqqYT57hcKtNtMKR+LURjIBwORnap6n0b4yUO8E4LJWxs1Aco65pqxUJADaEOwe9LtnWSMpCRm90Iei4RsAPeW86N5F1U09WZwxL8KyM+cq1SUcqTzqI+PWB04ziO7DyGai4sTbmJVKWgQIcZjXdRq1jLQOgQg318dAECyDvtFIPYX2hvbUWy+6cdACC5Y/sFxA0vMXLl/ATwjA==;5:k2yC9HPdqib6fc5tky5N5PEiQlTwUJUV904HdQQhNnUCz0AlvDoXA+RwomSDRWTSBEDosD0ae6XAciOfZ8ISRvd6yPh8CB1VLIA0gd3pEtHed1xyunOtAizm+V9gpJb1bNKkIFb//8n96T7d4phz7elKoMAXIaa/DeXKUyu9Wc0=;24:C1b8DH5JOXW8YXF5s6VR6oUyZj39EYaNgD9kJaYq7hzXqUOKlTKG+M7OgsAWY7JBqUZjaJRJ1QwgHgOaHaNeAvsc8VglonTShTousSTmIEw=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;MWHPR12MB1453;7:MplqADNdB/ZUw7dpls0y5giDYNzU6wgq/aH/3mAxNycemSlViZS0rsa873JWjcRJn46DcbJJ4jY9Ti6sMXndO/cKvrJwtGduk+6Oti/i4eYmjFy7R72OSs+6Waedu3MGLAuhYhV0ZRNUInWh9G+NPnQLusxboE8C8OYVELauGBp62lPWKGutjPuJcH0mxg9gXuJqPWPUgHOd4HErmiJOxqpY77Ombmn6aFEOOOSkjILsxeDttcNzUA8i6iI9yDAK;20:RYH9V14rT6wuP1d6kcLWYqRTYR2bqcW6EQEVEKxXE6UgdQQBigmSDe0Zt42sDsOkgIoAbkzLeHs5ORwhUJDImQI7hgFsTLWGWMYT5agPfl1d0KpGFljw+x4pgcDTTjGdE0S1tOCHdMf3A06hAhqApj6IlRuOgeFjjoVU0MqThOL7EO6eoSop3K8pjmWZQqZHP6hcPAT9cMcj4IIiQDQMUJ2s5dkEl7VbWc6geWWTFKn2E6GMOOrVUdVAx6M04v2n
X-MS-Office365-Filtering-Correlation-Id: 3b9f8d75-5cb9-4b23-4115-08d5b9d567cd
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 May 2018 20:00:55.9564 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b9f8d75-5cb9-4b23-4115-08d5b9d567cd
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1453
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/14/2018 12:50 PM, Randy Dunlap wrote:
> On 05/14/2018 10:20 AM, Gary R Hook wrote:
>> Implement a skeleton framework for debugfs support in the
>> AMD IOMMU.
>>
>> Signed-off-by: Gary R Hook <gary.hook@amd.com>
>> ---
>>   drivers/iommu/Makefile            |    5 +++++
>>   drivers/iommu/amd_iommu_debugfs.c |   39 +++++++++++++++++++++++++++++++++++++
>>   drivers/iommu/amd_iommu_init.c    |    6 ++++--
>>   drivers/iommu/amd_iommu_proto.h   |    6 ++++++
>>   drivers/iommu/amd_iommu_types.h   |    3 +++
>>   5 files changed, 57 insertions(+), 2 deletions(-)
>>   create mode 100644 drivers/iommu/amd_iommu_debugfs.c
>>
>> diff --git a/drivers/iommu/Makefile b/drivers/iommu/Makefile
>> index 74cfbc392862..dd980f7dd8b6 100644
>> --- a/drivers/iommu/Makefile
>> +++ b/drivers/iommu/Makefile
>> @@ -30,3 +30,8 @@ obj-$(CONFIG_EXYNOS_IOMMU) += exynos-iommu.o
>>   obj-$(CONFIG_FSL_PAMU) += fsl_pamu.o fsl_pamu_domain.o
>>   obj-$(CONFIG_S390_IOMMU) += s390-iommu.o
>>   obj-$(CONFIG_QCOM_IOMMU) += qcom_iommu.o
>> +
>> +# This ensures that only the required files are compiled
>> +ifeq ($(CONFIG_IOMMU_DEBUGFS), y)
> 
> Most Makefiles don't use a space before the 'y', but since you tested it,
> I guess either way works.

Pretty sure whitespace isn't used as a delimiter in this construct. I 
could be mistaken. But yes, it's perfectly serviceable.

> But why do this in the Makefile at all?  Why not just add another Kconfig
> symbol and simplify the Makefile?
> 
>> +obj-$(CONFIG_AMD_IOMMU) += amd_iommu_debugfs.o
>> +endif


This was brought up a few weeks ago in, I believe, version 3 of this 
patch. That question was discussed (because that's what I did the first 
time out), and _someone_ _else_ asked about why I didn't just do it the 
way I've done it here.

Everyone has a preference.

I chose to simplify the choices and avoid multiple symbols, instead 
opting for two switches: choose your device, and decide on Debug FS 
enablement for it. IMO Very simple.

I can't fathom a scenario where this wouldn't work. Is there one?
