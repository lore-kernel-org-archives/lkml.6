Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1759298AbeD0VIh (ORCPT <rfc822;w@1wt.eu>);
        Fri, 27 Apr 2018 17:08:37 -0400
Received: from mail-dm3nam03on0089.outbound.protection.outlook.com ([104.47.41.89]:15670
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1759235AbeD0VIe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Apr 2018 17:08:34 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Suravee.Suthikulpanit@amd.com;
Subject: Re: [PATCH 4/4] x86/CPU/AMD: Calculate LLC ID from number of sharing
 threads
To: Borislav Petkov <bp@suse.de>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org, tglx@linutronix.de,
        mingo@redhat.com, hpa@zytor.com
References: <1522046116-22578-1-git-send-email-suravee.suthikulpanit@amd.com>
 <1522046116-22578-5-git-send-email-suravee.suthikulpanit@amd.com>
 <20180417082814.GB18808@pd.tnic>
From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Message-ID: <960fe314-699b-535b-37dd-5325a6d8d443@amd.com>
Date: Fri, 27 Apr 2018 16:08:29 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:52.0)
 Gecko/20100101 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180417082814.GB18808@pd.tnic>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [165.204.78.1]
X-ClientProxiedBy: DM5PR1101CA0020.namprd11.prod.outlook.com
 (2603:10b6:4:4c::30) To DM2PR12MB0140.namprd12.prod.outlook.com
 (2a01:111:e400:50cf::28)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:DM2PR12MB0140;
X-Microsoft-Exchange-Diagnostics: 1;DM2PR12MB0140;3:A47/JthFFzxaBR+uWhxIb2Qj5TKV1gzEP5e/ptrxLczTqMzhzQQ9psZ3bPI6H3xzIEX8u4V/vvwa2hZ/uNEx3dsqqybO8KtJbaaL/hlYH13vsm9S/TrnMTtw8mOC4LF0ffYkO37KY9Qs2V3BGFglOhc0riR1omniRFgHIb5FNTQgYG19Hr0NnaqJQ/JgKRTsk2eHqZQm1E6ACnKVekRcroaiIDYSF1dyWQl5nbOqFrrLoZD5y7CPLA6diYe8Qm8N;25:5o5m8g+RuJzgT3nC6zaUYLvLXKG8gwIqqnSDcKiOVrEvGlR6EqHuwD0U5cVPKjDl4rZmXKIAYugyL6Fq995EdXYWdqxFsYvWVaWZbBAakVo63x+b+5kTOnKkbIYmfqE0/t8ACUyp6OmmJCRrRsqBXo5nt8CEL1oaZr+lz40LZp4eEgqn1Sa8+GQm5ZVBGv4oUmTSpmIV8y7ZPv3v4lk5hsX+IAXn12Qof6WCaWgqUKGqihqM6iCItWMPB0vXnqx3aJY3nGzVqp3G35YOfWidEcYe8UnG4uaUqd3N8dPw1gU1rlAF2TqD2BQmahonHSA5Pq/7MEyz6gMjCyXdOT8zhw==;31:wezuH0T7p/9oWXzqJeAIXBCErkjAfqf5E+sZML9/B/g52hI2gDGJv39WvqR/N9PjZeF1stor8/hHPD4OREKv1Hdi1kuBKClOqDuRz1kpBSnzyHXJ1H0UOFAnhnPbxLC0Ya7az4HNrfUEAdzEO8EmEqo0PITtsvSbuU34nRDoMKDueYy6y+EJkqaO1mSmUFqtiFi8Bwh3WTTql2f44b5qSu4x9GMBRBVjbP1wyNUYfUw=
X-MS-TrafficTypeDiagnostic: DM2PR12MB0140:
X-Microsoft-Exchange-Diagnostics: 1;DM2PR12MB0140;20:1E7C2rmEpkRRJx8rjUljAeIPwPpwXbNYDJMLSP0X7xUBg9TT4JRCMk/5snQT1Dcdt2FkxPGUbVUvR07N1MaQ4c7lJzfCM0fUWlyLf0WX8jB9HDE9gZ2IolFLEEr7lezAnsdy6PqwcN8W3v9YmDUeBGieapxUH5mkNBHwQcv0hWctJ2YWiXMEOcZEsybe3L9dNt6Z04VhuA7GwTfowXf+2xyKRdfy03khGOQIcTVeE3LqbF2uTvntBOR2odP7L2fC1AG7vT1GXAXL5Wt4EsVdM+px9qS/DVj8pX7UP6zyv97o2qzcxXV1WWI6FH1n4wU9vrIISCTHWd+rw14fMWfhqlAqXCe2eLVaKpnUHwKL2L1S4ugP+HDQwdkl7Mme+KXhvwfbLzhMHtrNBCEeJ79/xCDwp5SRimxuSrE33b5zyw0ougbhbbfZZLCY6SJk/R/WWHhGR7N5Kzt1q2ucHkwcklFE3x+vsZaVulmn0tNOVchw0sjfEUV0oa1WFiwaNa0/;4:S6cJyrHlm1XKbW5tGrbKWZ5MQFw4KEkHp8GQcRmlThkYCFaxLdzFD2pf/cl/kYS9NPrWrLx19oLGjpdZNRPSLguXYljTWcPUiOJtSllckABx7I0dbONTcKeMfmA2xV0JRh50DSoVkseQvCi2iGdLRNY25XPrt+lU+8CzDXVKrgG5PzxEHktg2H6WodKufqdwaWjXPe+I00lJuhTmX1uzO3SbDolEBMDaFgBTJpCS6OfUZGFXPyfiKzV2ny/OjIq2Qu6G99rbTre8K17rkW/WoA==
X-Microsoft-Antispam-PRVS: <DM2PR12MB01409354B9DAABE2C5464A8AF38D0@DM2PR12MB0140.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(3002001)(3231232)(944501410)(52105095)(93006095)(93001095)(6055026)(6041310)(20161123558120)(20161123560045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(6072148)(201708071742011);SRVR:DM2PR12MB0140;BCL:0;PCL:0;RULEID:;SRVR:DM2PR12MB0140;
X-Forefront-PRVS: 0655F9F006
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(39860400002)(396003)(346002)(376002)(39380400002)(366004)(199004)(189003)(186003)(7696005)(58126008)(6666003)(52146003)(72206003)(956004)(52116002)(2486003)(76176011)(2616005)(6246003)(23676004)(229853002)(36756003)(446003)(11346002)(26005)(65806001)(558084003)(486006)(53546011)(16526019)(68736007)(476003)(67846002)(2906002)(6916009)(6486002)(66066001)(44832011)(47776003)(316002)(65956001)(386003)(81156014)(53416004)(31686004)(31696002)(81166006)(64126003)(25786009)(6116002)(305945005)(3846002)(86362001)(105586002)(230700001)(8936002)(478600001)(65826007)(8676002)(50466002)(7736002)(53936002)(5660300001)(106356001)(97736004)(4326008);DIR:OUT;SFP:1101;SCL:1;SRVR:DM2PR12MB0140;H:Suravees-MBP-15.amd.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtETTJQUjEyTUIwMTQwOzIzOmM5NDRTNVFCbEEzSGRkeDNvSzJORFYvOFVs?=
 =?utf-8?B?bmo0eHo5alVWY1ExQzhZWW9tUnVhZU5qRHVNaFRRb3A5UTN3WjlxSWFQeFg1?=
 =?utf-8?B?MCtMOWhXakVWN1JudENSVW5KcUVzZWxZeWV5TEpwTElnaTJ1dEdKL21ZSDRy?=
 =?utf-8?B?c1pKWk1iYTdRQ240aEdHclZhUzNFbHZOWjBlQ0hIVHlZWmQrcXJyVk5LMC9Z?=
 =?utf-8?B?MG1DdSs4TnE5M2MvbFZqODRMWStBYnVadjFNUjlmNU1LbExoMjV4TDFPWTRI?=
 =?utf-8?B?bWlCNkowR1ZrZmRhUVZJSjBWMUV3aHBHMVhJYlNHYW55NTJzRlFCRzk3Zm1z?=
 =?utf-8?B?RUgwbkF1VVl0bElHS1ZxN0Q0RlZyOVZGZzlrY0ZEVElqSHNJdVVwZzljYnQ5?=
 =?utf-8?B?ZWFBa1Z1cmFTM0xjelhpR0xkVDZwSjhJSWowZFNxNjA5KzIzeHpaYlNsRits?=
 =?utf-8?B?S3Ewd2ttaVcwWW05K09XcU9Ucm5Bc1FJZ2hmcjE3NCtzVWhoaEd1UkxlaG1K?=
 =?utf-8?B?amNXRXZIeVZnL3NhbGZIbW5VUWZxU3FvRUZacGtKMmdydHpBcjNSL2FSeDlo?=
 =?utf-8?B?WlVTZzRtemx5VWI1TXJJaXRXZjQybEpwaGVDcXY5WVJQSEVYek1nd2xaQ2d4?=
 =?utf-8?B?bFdaN0ZZZ1BCdDQxSkRQMlJqL2x3ZnlKbDNOZ1NXNVg1d0FwSjRPdEtjNFZl?=
 =?utf-8?B?TDU5R0VxZWlZNlF4SVE1WnU3a3ZNbiswaWFMOVA2S1ZNNGNrSlVJK0NNSGxT?=
 =?utf-8?B?YnEveUhxQzFveC9HZkM2QjYwdWpHdUlGYndRNHZkN3Z0dlVDR0hvUkdjMlc3?=
 =?utf-8?B?anljdXJiejF3QWdObk9hRDNQMDR0QUZmajZ0RENwZC9ZTTBkcEhLd1U5YWdB?=
 =?utf-8?B?SVZoMHk1dk1kekhTQVBMblcvT25MZDN4UkZMSWVIWVJ6NWlLMm9yamhIWVg1?=
 =?utf-8?B?ZktwVmhtOWdmL0lvaFZMZ3FKSWI0eVVjNnB0bFpkU1AvbERpbkw0ZnBRUDI0?=
 =?utf-8?B?Nm9iWDZpb2QxSEtyMEk3eVBXUVNxWGdyRVJ3aTNiaHo0VGdZaGxickJnK2pE?=
 =?utf-8?B?NjR3TStUaU9DbmtrVllrbEwvQWNUY2xsNmFseTBOdFJYaEJBQzZWL2ZJKzM1?=
 =?utf-8?B?SlJnTGVuOTBSZ0lpbkIvZmhLaUJzQ0ZmRVVXWnMxbHB6S0RLNmR0am9QSUhP?=
 =?utf-8?B?Z0Qra1IvdzBZcGpNdFFESGpGTm9mdmNxc1hpcDU5RGswbTFPRzI3cXV2RHBX?=
 =?utf-8?B?dlFHT0ErY2VrNW8wYm1LRGhEaDJGaGRUbDdUd2diOCtob0h5SXJYZ0h4TUp0?=
 =?utf-8?B?VmpOa0FwQStmc2dtUGVSU0NpZjcrUUJXdHFOc1ZLMVVuUFcwdkozbDVZRncz?=
 =?utf-8?B?UEtmQW1wLzMwY24vOVBHelp3YjhDbWFOWTluckl5Y1VSakowVjdBMHlDTnBy?=
 =?utf-8?B?WHplS1dPenZRNjJ2emZkZlZzMGpkL3hsOENFemUvMFhGNDNjTjY2WnZxOVUy?=
 =?utf-8?B?WFpEalQ0WDFxSVluQy9iVVFsclF2QkVacU9TcTY1Q3FraDhzejJZbkFZdmo4?=
 =?utf-8?B?NE9OMmllOXFYSG1hOEV4TVp4MmcxY2prUUNxR2JMdTZ0c3ZkNzV2bnIvd1Vp?=
 =?utf-8?B?Z0Urclc0SnpxL2pVSUFxRENEL2I5SkNxUURqNVVNTmVnZ0JzblBCcnZUMXA3?=
 =?utf-8?B?R2k2UDVxZ3A3RGNJMThXZ2lYWG5hSjA5SFkyQU1jRHRzbDVLaHJWemhpdXZP?=
 =?utf-8?B?YkkwWjkrOXBXNTRsNjFINlRhNDJ1V0l2RWpGK1QxZ2RqYndiNVV0MEl2dHp4?=
 =?utf-8?B?QnQ3blZJTjdMemo5Y2FVcEdjVmVORG9wTUgvSXlwQlJvYmJFNWtRNUZ1U0E1?=
 =?utf-8?B?dGdiMWR3Z2trQVprY09PRmNQaWhBY3FJeUlETTdKeWZnZnJnODdmek1qbmJr?=
 =?utf-8?B?WkM4d2FoZ09uR3dhVDZWZ3FVNTlTQnYyTVVwZUhCa1o5RW8yR1lrMEZqcGdE?=
 =?utf-8?B?RHJKZjJ0Z0tkbXh0ektRZ2d6R2JWSnl6VGl3QT09?=
X-Microsoft-Antispam-Message-Info: cPleDU3Mx+erVKfv0etzZCNiEy8IvHcmxElG0qRneRUrZPLBNHQvxycLFl+wPIa8mXKckNb5JEEKBkcOrsCP5pjRmpJa+irEQZpBklkzeU+u58ua0KOmCrxSecRCqOteywJk0/4k9wxgNt6Z8Gubcq8sS3QVD4LtHwW0I1oVpwOHFlXgpmgPp91kaNJGWSUp
X-Microsoft-Exchange-Diagnostics: 1;DM2PR12MB0140;6:fKTguM2S4YKEJhyzdHQ9wjAynWZo9GAbJWEFCXQbpvN4IQPQ4AuMXYtbh64ibHYgNXrAnqQdXjhLza2c9r841NT8G/KvO/KO5JB7lh9WqQi18yyDI14JEOCrTO/3XVoZmdXyY9HyZfksOCqjciLpJ2HXFOtfjKJF/cH34EPopT4rgAzq0Lp8VTu8rj5mhEcLqLDCCoTCQ8Hz4rYCBwK1sZ6NQL5ZmUkjI6JQ5VkSgvqaUIr9mN39ktq7kGbvomw4N+iieDylVi+StrLAt1FM7WFQ576fXeJFzWDIlqKi0Cf7aw6qI0DVoNXr0sVsRZ8zxgf4LGhAjNJgYioiLNkECzf4+Gap7vtV+DCuO0MfBlKQs4hA+OvyfDEBlWgZhs97RloZk/xduajaUHQqKuCZAndnkuk8Fk4S2Cw9gLNYtpRIPOdxcrYxaSZTHV0Mq0ljRAHIb21RFtRMqTMUMJ7MQQ==;5:XUhXS5WpGfj85/KPvQmvJgA7pex+FW6OAEQ4bcgYUGQZdPIjIWqQucjt3udFR8w3W+S8cJkM8m0wfJGSL0rdaJtpe/z/quS47KvRea/IhzCxMqauDyc0hSZ5hogtutxRoYFjB7XO/dFQuO6vAvCFRKJP63kNhSbrcK07hWP4KZs=;24:Xfb6n6PEf1H/iCWry8pJ52Lf4q1R5eRmIx8eybFU5FeT6J64X/A0hm6+FQIr2SKn3KW2dwO7PHYK25Q2W58DaMXD+trF9lp/zdThi7fgdqk=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DM2PR12MB0140;7:hMhFJYpRXexuxXL9Mc8KF33UqJUhCDo1jGf7p04NodGmG0L1KV5DYhlhpw809Z36OCYRl+fe8U3/fHzd4F3uHBHr7U2Hg9mKuQeFjn+0p+t7xbhPb/MrU/pUFaYo87JhBLdUvDCqJHHBqxQKW+xucfsCmd6jDIqB/40o8UMbC/LBgwmrBZ+KorhZq9EopW6zOlSjZ7asxTvpfQ/Pkwt7mPA0Cg2DY5UNPF19dTGY+TZblm30vTH0r0KaSQwJwuzk;20:vyCGUpAB1vJ/YvqzH7QgTkzrJzJJmBlo7XyCfgytjYgawsxwuNhSTAipmGW4OtA6KHWtSeIDWHU12TU26Sqqn8rS9TQ1kGei30PduATat2HS3tcNdRWGYKDls3tvkss6Iav9K94FIGzkH2VnlQ+eQwECEZ3Jmxmrrr0niwvVQlUIwg3EwbrwRgVP6vALAkPoNU5XtVKSlEHOEZ6SzdGHBX1hpycVkYJiEOI84mLLoGJ/0PK2h/LoEDl9kU0M6pIa
X-MS-Office365-Filtering-Correlation-Id: f726bb1e-4198-4258-033d-08d5ac8308a3
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Apr 2018 21:08:32.5887 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f726bb1e-4198-4258-033d-08d5ac8308a3
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM2PR12MB0140
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Boris,

On 4/17/18 3:28 AM, Borislav Petkov wrote:
>> +EXPORT_SYMBOL_GPL(cacheinfo_amd_init_llc_id);
> That function needs to be exported to modules because...?

I missed this part. I'll send out V2.

Thanks,
Suravee
