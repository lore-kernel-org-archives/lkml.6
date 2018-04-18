Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752334AbeDRUvo (ORCPT <rfc822;w@1wt.eu>);
        Wed, 18 Apr 2018 16:51:44 -0400
Received: from mail-bl2nam02on0085.outbound.protection.outlook.com ([104.47.38.85]:30752
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751692AbeDRUvm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Apr 2018 16:51:42 -0400
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=amd.com;
Subject: Re: [PATCH v3 2/2] iommu/amd: Add basic debugfs infrastructure for
 AMD IOMMU
To: "Mehta, Sohil" <sohil.mehta@intel.com>,
        "shunyong.yang@hxt-semitech.com" <shunyong.yang@hxt-semitech.com>,
        "gary.hook@amd.com" <gary.hook@amd.com>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <152302042701.47565.17954813724758433858.stgit@sosxen2.amd.com>
 <152302067362.47565.628887796165116844.stgit@sosxen2.amd.com>
 <1523664612.2747.13.camel@intel.com>
 <efa2b7a3-04a7-20b1-3651-89ebafa85c27@amd.com>
 <1524031122.4031.5.camel@hxt-semitech.com>
 <1524036520.2747.31.camel@intel.com>
 <1524040290.4031.25.camel@hxt-semitech.com>
 <1524082659.2747.37.camel@intel.com>
From: "Hook, Gary" <ghook@amd.com>
Message-ID: <151f3396-959b-86f6-e056-58d38682d858@amd.com>
Date: Wed, 18 Apr 2018 16:51:26 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <1524082659.2747.37.camel@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [66.187.232.66]
X-ClientProxiedBy: CY4PR22CA0064.namprd22.prod.outlook.com
 (2603:10b6:903:ae::26) To BY2PR12MB0696.namprd12.prod.outlook.com
 (2a01:111:e400:52df::18)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(48565401081)(2017052603328)(7153060)(7193020);SRVR:BY2PR12MB0696;
X-Microsoft-Exchange-Diagnostics: 1;BY2PR12MB0696;3:mO/Yugq2Fg6YUIB361Umfcz7VCmdLfILlH/opmvdNBDA+LhgW89l7v48+JshHm2oBHlBSsH/Ozh5ZYtuVjICURrpo7rfYufVYXBJJgyknPJqT9q644lEgCJI+OEJ4lA92YUciU1gSfCunz0aY8gr0SjS+1BBHOYAPzT3G/51mgIKbPhMMl5LD+LxRnf3L1HtGmPNZPhLTCxo1WNRv7WJpMXEOySBp7+erLBxI56MS3nyHSwFWjT2J4OivzxbXgKH;25:AKcBNzJcT9nrac+xG9l3QFi15r93bk8wHBMHG49Vg4ivAIR79qat1dG+1yJXkJsX1QVirZ7aVg6sT1rfYb8v48riH/WOpsVAI9t4QyK0EoPGJ40n0RCzv8OfncmUYTpHGb2bWJjeTy2akKibfu5q4CVNqUrwAdy0KFmG32PyXMSmMv9mtBbQPn6KFzYoVmG9KxuzjwJnyBvFQWtd4EHWrkEJGxFNuWtZY4CFFC/QPZO5ta6wE7pLpzAsInV90nkLUNPy0DqPjsfbWGFSe7bsuGeYeyqEjfxiTgf1gAoZmJ/rpTZh4acxhxpOmFf4f6fr6uC/QWt5GAbLKa0dQ4p/GA==;31:uuJhlyo3JNtNnmerPq4g/SbwJsumrNZ5gALp23HfzSpB76tgExlED0WHpfrXqIuaJ4IkNPH1x1h8apQZyLE4hQYMmODg1/WBu0+K3Uqv6frsT4wejzOMBdvycOcCwb0llAb5G+tA72zEEfXzWVKiOcqY+DbkInKwfL6rYr0ZWUQt2fsHGSZU65nDdy+/xbEHM2xRgDVtFQV522HL2a+o+ztyXd4R60CpBWk6KlmqOLQ=
X-MS-TrafficTypeDiagnostic: BY2PR12MB0696:
X-Microsoft-Exchange-Diagnostics: 1;BY2PR12MB0696;20:mkiGzisubHU56gOMIW82E0IXlPnusjlM0dleR14UQ8aQZ5pvTn/kHvvH8y6c4WqDaf79RvAcyuUJ6wvRoAP9/dL/2EeynQpAXzSaUy2kRJeR3W3MR199eB3F1RnIlTUWO4Ozl9xaen2ZADl4XfUjBSWNqRLnLWUkzjvyLmilIcJGvNwwzF1jHcuPYH9hQt2rAx3UqJP1bozZ3Ol2oLDwrAQyQYMRrWp484Pq+CRtcPTjHyboBOJ96bzI16NUsx+UAKwDQlFTuG6d+oKPW1IYRvghAjbsHtuusjOsv2pM4ZghOX6f2KBOLyAqsauaHYBUBC5ps4BWOnm5JV9lhCkAjGVFnzR9oxlefMiKJB73aBWWpNn1HvNFfj0lZfpNh6QxCTYqI+XIq+9GMLorddo+XRCEJ9GaiwEYXm1Ld3kSQayFKRaXkA99QBGT5Y+sd2P4SkpaERei07CdoautHXK5PxnoNnDOY4iv5mf5yeLE5bwlUIT4bgcVLdjY6DNWBlh8;4:SvUV4bfKJ+tFOZtIkpbs13MKGfQhJH8BUw8WHox9jnM9HKkmDXwkcXmE7eIue4P3+o4c+mzYDdPpCYpdG3llzfNMM/FaCJbGUM+gf+h+xQ+vChG/mp9EZi2uSxEVhgsEZ3mlBORTQh/5vAWxIQy/1fZPl5pJvuT4y9c4fCMnWp9vjdbcvLouyej7SzKcrBA/yec6v5psyUPYX6+vLPF9tpscMAfy9DY5bxq2XGrwt8xel7EYzmjrBrA23FVV28Zl3ho8+aZkpPNKI2BKXqviFg==
X-Microsoft-Antispam-PRVS: <BY2PR12MB0696B6564DEFAD0363C9ABC4FDB60@BY2PR12MB0696.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(93006095)(93001095)(3231232)(944501327)(52105095)(10201501046)(6055026)(6041310)(20161123564045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123558120)(6072148)(201708071742011);SRVR:BY2PR12MB0696;BCL:0;PCL:0;RULEID:;SRVR:BY2PR12MB0696;
X-Forefront-PRVS: 06469BCC91
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6049001)(376002)(39380400002)(396003)(39860400002)(366004)(377424004)(2616005)(446003)(11346002)(66066001)(52146003)(76176011)(23676004)(476003)(52116002)(67846002)(72206003)(36756003)(8936002)(47776003)(50466002)(478600001)(956004)(2201001)(31686004)(5660300001)(65826007)(575784001)(16576012)(316002)(2870700001)(2501003)(2906002)(3846002)(6246003)(4326008)(6116002)(16526019)(305945005)(7736002)(26005)(53936002)(8676002)(77096007)(186003)(81166006)(93886005)(6486002)(25786009)(110136005)(229853002)(6666003)(53546011)(3260700006)(31696002)(21314002);DIR:OUT;SFP:1101;SCL:1;SRVR:BY2PR12MB0696;H:[10.193.21.233];FPR:;SPF:None;LANG:en;MLV:sfv;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtCWTJQUjEyTUIwNjk2OzIzOnBvcy9Lc1FrOXlOZlhldzVwOW4wMEpKaGN4?=
 =?utf-8?B?NXV6YjBDNDk0ckNRTDUrY0FPQm80am1tb2o3b2VkYUlTOXJYZDlCc0VESVBa?=
 =?utf-8?B?cUV2QmphOW5EaXJzTFIzTmF1bDBQWS8zODhjdUZDSlpIZ0tQbEhVUFdVQm5o?=
 =?utf-8?B?MXNJamNRSkZvQmU4am15L2RQY3AxNWVORER3S0ZiZGtJWTZTbldVbmZJQ1Ay?=
 =?utf-8?B?KzRqNDN0aGRXbDFyaHR1TUJsdzFiNzhzbCtvYnJRR2h3aldPSGd0MlZEMlNL?=
 =?utf-8?B?cVBEOHJqMUluYzdOMWdEdzNEdHV0Slc3NVhsOG5vTjZ1eEVXZ1RvMFltUHpI?=
 =?utf-8?B?eGxJWDh2MU1LU3RWTlV3T0NDblJMRkNKREgxUzVZMU1EZlNrSmREVXh2NDdi?=
 =?utf-8?B?NElOMWFIVHpaRFdLait5d05iWFdyZTVPWGt5djdVNXdvR3V4QzRjQWttK0xE?=
 =?utf-8?B?OEsxTnh0MGV0T2RLMStOZVFyU0FMWkM1a3NaamJ1a0NkSjVzZmdJSlFFUWg2?=
 =?utf-8?B?anlNVnNlNGR6NlpRVTJSSThMaEc4V3RDQ1Z0UWtnK1p3RmxSbVlJZXhMRW94?=
 =?utf-8?B?OUxKaVBndnJJV0xkRlRvUVVlQnZhbCt4YlJOUkFzeU9vL1ZNbEZoelhYVjQ4?=
 =?utf-8?B?aENrMkZBMDY0ZjhKcDVHU2U0NTk1NkZCVEE5TURmZmtBZFJybjZwZUMzWHdI?=
 =?utf-8?B?ZTMzL1M0RjlURlZNNDBZdzhlWGJOTkoyRHcvMnR6Q3U4RDFHeGVINS9KdERq?=
 =?utf-8?B?TnMreHpMWnJjMlNqQ1VIWnhTWnFva0dGS0V2RitwZTVnUjF0Ymw3SmdFSitP?=
 =?utf-8?B?SXpmTGc0QmsxbjR5RzJsdi9RdVU1U3NoTDA4K2FoSFZwaXEwRWtSSVZ5bE0y?=
 =?utf-8?B?cWJ1bEJ2QXkweEJEUHBYZjAyK0Z6dnJSWWUzVjBoTmRrOGFudDZCQ0ZQY0V0?=
 =?utf-8?B?WE93SFJlVTFDWEcramlMdjZxVWR2bDIwV1VHTDB5MEdQUDAwTVFrdytYNlNK?=
 =?utf-8?B?V2xYczlncDhUTFdsSzJBbTM3Z3VnUW1NcTRNYnVLL0dkRnJsRGFlekJZTmEx?=
 =?utf-8?B?RWpmdkxCQXpBL044eXJyam80SXpLZDVGTlJacG5OcnhucTFVaVNEbGhld01p?=
 =?utf-8?B?Tld3MWJWOXhyRCtqMHRHR0k1TG1oR0hXZmRKWUlNcGcwNklYN1pqU3ZiMTZF?=
 =?utf-8?B?Z0JHZmVLR2FPMmlQU0VTbkhSK0hLSEo2cFRYRkFMZTFHcllKZ21Ja0N6L0ZX?=
 =?utf-8?B?bFZzNm5QSWRSZEdjZHhZQ3U1bWw1dS9FdzFFemdIMGdoT0FPMkdqVXNRVXhF?=
 =?utf-8?B?WGJYK0dYRkIxbERyMCtObkx1UDM1VU9Gbk90WmhXN1JJMW8zSWZJQU5BWDht?=
 =?utf-8?B?TzRlOVpiZFFSOUliNklUc2E5cHJ6NyswbWNTWkNKdnNiUFEzTUhzMlhETy9R?=
 =?utf-8?B?Ri9za01vZjR4OG1RelZIKzNaRTF5RTFQbCtocXZ0NU5Dd0UwcmdYd3dDcTk1?=
 =?utf-8?B?MFA5dmJNUmpINllBRExHaGZHbzNKcVdBSTBROW1McmRSSjMyc051Nm1OT1lJ?=
 =?utf-8?B?VWEzbnQxQTVSemIwMTdzdld3ckVhcEMwUUVubUFTdFNsNFBGZ3JkMWVPdElq?=
 =?utf-8?B?SXVHdmRvT08rWDh4bVlkeURLYzdiY0xlOWZBRWZsSUVMMTJSQTV3d3FHMysx?=
 =?utf-8?B?RlpkeURWaTVXbkEyd1JXZ2NsMVE4Ujdod3M1UW9WcVF6VXEvZGladkZiRmx4?=
 =?utf-8?B?ZEFuOVZVcmxnRTdIVDcvUT09?=
X-Microsoft-Antispam-Message-Info: nhb6q8j0fPDeoEizqsut0ogZu+I7uunBimEr7DF8f8H46Hpdlzc5qSXN1f9lECDzBV4125kPvWNNfa0XAfrTz0O+WGH6EKAR+AknO1XvPX9iVWb3llSM/c2XwVoh8PCNjBPceVEiTgh7N4fiEpEiMtNCem7qe+l71Dn/SOSi3LiTTfszAGvoA2CKxN+fpE5r
X-Microsoft-Exchange-Diagnostics: 1;BY2PR12MB0696;6:r9BHIJ/JLH87YTZrBEmxQqb/8k3E/eKyohAcJHOYCW1Y23hRnVqLhOEbMCWC7B2UkHczvrEUQj1+iBwsFUZw5pp/JzgiFkaxzBP7Dl0slWEKGIfD4UaEGREv2Hacc4PaFnG5yDxk/Q65tJPQlDRiyU3IXvoWESXMYJlTz5NZSc6e3Jm6aCKhhU+28AQwovgMN9+5iby1CW8l1e/FTQIC0xTk8uXjBUw0fYg+UNsc5vnmXDYkOWmSPmbozpby3I/UtJqxVRQREMU/vNW4pYRLwt8FU8PRklYLgQtfhjgGU3ftmn60J6zvbv6FOfSnegd/WYPzQwPSoK6et1/jG3Ci8zsxf78PnrhfxughEkL4PkF9wo541G4K+zkko4lbqnFSoc2cRN/mPrM7/SyWvMAi6owmV+Y4DVDtWB6wAKSGyoYqEJGBLn0fbKZDwayY6zylwTd9Ay/lqndlfEk/zGxc/g==;5:17jOAF0W3QSod/4onHaRGAO0owukSovHvBc7sHg30VH3DBAfQsQa5wO71c/aNhTGEwmX5iVDV8g4j/7vqd6wYw4zNNpJ8oW+scMLX6OiRtzYxwlYtaxfXS9ShgT1fYgv3eLU0V0rV1834Db0yb5iEs3wwUWIhRQ51FJDY04LxUE=;24:Jnxy4++TRZ/+8NEYqwBAzgrscos6iXaUPgduaSXz0k59/ut42Knr+hecM3HoqBTP3O/J2rpNL51Yg0Pz+n0ypzn29eZVoLf1hkMgtNJACCg=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BY2PR12MB0696;7:iFYm0iKUTdz5Q0ymvzd08zca1PoDOZi/GFiX04IMXedaiwKq8a7x9jA6UZNNsysmj+wJgLaVAR1wh4Pj1MqLfu0t1yLbK4/Qt7YxO337KhmqokmbuvLRZ1/NbMWkmVHtp0W4jXf7gJ75TBlaZsWNOzOezyKjTJIeLTEnbID9Yo+8CmuEKAQc4dWF8XwedQ2w5MORdG5P5qUtbepc0Rwi0H9CB0UlIvlI+y8MuRJLMmcHYKVT4NQbIlGFSRUajGMN;20:26XK/HtVUoBgoSAKhU+NO9oKP5RFNoS3lwTOIXy9SVFCKv/2sdF3JAWyp1mEnkvV48uescyTN5+S10DJkuvCCa1pfZ6mc981rea+6lXFeOsGSS4ZaZtxIy/RoKwQnwB2JP1ylCenIs9/kfWN+byvlFNTkuWjB32lntxLoYcPiiDq1JIhgFNXeXXH481fWwVYkCTB94TsmwUWZGF3SQj1W7cTlpUCY6oE7eontGWBVHT1XBn535GY/9rE7EaCiZvf
X-MS-Office365-Filtering-Correlation-Id: be30bb93-16a1-402d-2850-08d5a56e2ee6
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Apr 2018 20:51:38.6176 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: be30bb93-16a1-402d-2850-08d5a56e2ee6
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY2PR12MB0696
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/18/2018 4:16 PM, Mehta, Sohil wrote:
> On Wed, 2018-04-18 at 08:31 +0000, Yang, Shunyong wrote:
>> Maybe the original design is to call debugfs_initialized() before
>> calling debugfs_create_xxx()?
> 
> I am unaware of the original design. Someone else would probably have
> more context. However, looking at other places in the kernel where
> debugfs_create_xx() is used, the common convention seems to be to avoid
> calling debugfs_initialized().
> 
>   Sohil
> 

debugfs_initialized() was introduced in commit c0f92ba99 back in 
2.6.30-rc1. It was intended as a helper, not as a gatekeeper, which is 
why one doesn't see it used. Given that my use in this proposed patch is 
straightforward, I'm not seeing the need here. I had just seen some 
other code that used it, and copied the model.

Unless someone comes along to say, yes, use it, I'll not.

Gary
