Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756135AbeD3T6N (ORCPT <rfc822;w@1wt.eu>);
        Mon, 30 Apr 2018 15:58:13 -0400
Received: from mail-sn1nam01on0042.outbound.protection.outlook.com ([104.47.32.42]:65344
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1756082AbeD3T6J (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Apr 2018 15:58:09 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Gary.Hook@amd.com;
Subject: Re: [PATCH v3 2/2] iommu/amd: Add basic debugfs infrastructure for
 AMD IOMMU
To: "Hook, Gary" <ghook@amd.com>, "Mehta, Sohil" <sohil.mehta@intel.com>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <152302042701.47565.17954813724758433858.stgit@sosxen2.amd.com>
 <152302067362.47565.628887796165116844.stgit@sosxen2.amd.com>
 <1523664612.2747.13.camel@intel.com>
 <efa2b7a3-04a7-20b1-3651-89ebafa85c27@amd.com>
From: Gary R Hook <gary.hook@amd.com>
Message-ID: <d4534417-0fc0-5e38-ab80-2ffc9cfee2fa@amd.com>
Date: Mon, 30 Apr 2018 14:57:58 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <efa2b7a3-04a7-20b1-3651-89ebafa85c27@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [165.204.78.1]
X-ClientProxiedBy: SN2PR01CA0037.prod.exchangelabs.com (2603:10b6:804:2::47)
 To BLUPR12MB0689.namprd12.prod.outlook.com (2a01:111:e400:5950::14)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:BLUPR12MB0689;
X-Microsoft-Exchange-Diagnostics: 1;BLUPR12MB0689;3:M3OFSMLgd5kUIFZiMbTQVHT2Q9vj7xbwu/qagTKe13kvX3ZSUlJ735slvg8CNtsyAIEEcym9gzn6BlbEPcqhq1GLGC2ICmxhqdWLO4SOCimTFvv89ktWKh1TihqQy/p4rrvspCQuHnIXsfGg5sRaWV63PYTTfywTkcFgIuiXh5gk0hEh9BWMqZlbiV+wgf5ihAM1CnAVa5sN2Eis1NWHK5APnjY6fidIkLjZq3dyqvaB5qJcXQRyPsVm/zc0v7UK;25:KcSBHuaiMuYpTMDSt13H7z+PALMqUL1oyapRLTsg1QO/5X/tOfDnLzbMWnzphHIstH8EgAk38soja6+xATwUS0lN9Ciixn8gO1qPKSrO0Bms0GdRGgGRsZ/iSDitW9iHdlHRNaXl/Humiuhdgp3G0iznxmUY/K+KhkJSbMAjxKONlq25O/StuA8jfPNz3ohF7LPWllsbRXK9j+7oPFfRUdWy0FPIwBNd9oVoPvS5OCr6EiBW8IQgMnVw3wyNkmypNu321NoUya5ji6n5iJ/naS1WGa254f/FS0fw3e+0X/2KYE7fTZeB+tyk2Lcxh1xEykRyA20ohjU22kppo8rV+Q==;31:GSkl0/V1svONcP7iPfoLtKf8HlL47gHUBTYbdsgpKCIXW2ywLvVpPEcNObSWPtOnMq6i9fGUgmsI/WLRSvXGu9XUG7ZhmBgPPVhSP04uDp2BuINRuBNTUySLZ6S5HOQqT6NytpopLf110YG5rPnsZtgDxqDgDB4JcGaEVj83MPnRwt/2CrQgc3nDL3tGOXcK6A2jk0l7OVBOjEefMh4uLlf29AavZ4bbD3AFGkY9SBI=
X-MS-TrafficTypeDiagnostic: BLUPR12MB0689:
X-Microsoft-Exchange-Diagnostics: 1;BLUPR12MB0689;20:sdLH7yDVOcBewGaDKHTqkqQaLDdA0dyIxE/8WA/V7CPuMCc/U+bYz222HBG9bsLJHoCaDb5EUIQVvqCS0M35vr7WUZYLZdtppIRrA3T4Pb+KU/XkOeNbVHs6yIa5PLz+wSIf54MxbG4QnnCbFsBD0WX2DHI1NIex57fTF8eCgDwMavpqzxX0c/5DA8HPIlRmErtpFL/5DpcAWXGw1r8i97q1eDi6HjeW1dqZRHrvtER1CZldrcRPXc27Bm/W0SGgQzSjf+iZ9rjJIVcNUBst+jDuEuYda8vMx3nSQWOW6y8/jx7b4828ykQnz/5P+rVroa2GHO2fup2jKoPaoQcnOZ3YMEzs4np+83iuqwXm5m3jBzAHANTbN7fOGCF43+eunt5WvnTebOMSj9pOksJs9FjCykZe4zHTpT5mCuy3gT7Jjg0JbThSPEo7CuJKEVjsKNIbgoeucVGo0YVrTDvNPOKAVxSG3MRM/ngw8OtL8Z+uSXL8qv5KB0afeexolYE/;4:qGINyahNpNqs8J0JOhO01OAsfFJS4rNYYCnBH3wQ0HcX4uM6Q4aL6HPC5qD4i85bo9nmQY6EB3ZUTLSVur9BjRgBHAU7Fb5qeA0ZwekR8L+8dTDmo2hectSAe6775ccUFuOV2qYP3GbIPanv1xmUOKIrfS0XRJ8hoN7hiCPVVpLve78rL6la5AnqUGa58PansxFGSjhpklw4AEepUb2ptXTZ0lSRVDrdP8oAbQD/h6QZXIJ6MjLYDmT+zUWKXz7YnaL/0j7BGaIG0TGPchrfBA==
X-Microsoft-Antispam-PRVS: <BLUPR12MB0689DD0037007E9B64BA6D2AFD820@BLUPR12MB0689.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3002001)(3231254)(944501410)(52105095)(10201501046)(6055026)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123558120)(20161123564045)(20161123562045)(6072148)(201708071742011);SRVR:BLUPR12MB0689;BCL:0;PCL:0;RULEID:;SRVR:BLUPR12MB0689;
X-Forefront-PRVS: 0658BAF71F
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6049001)(376002)(346002)(366004)(39860400002)(39380400002)(396003)(377424004)(199004)(189003)(36756003)(67846002)(76176011)(2616005)(53546011)(59450400001)(110136005)(72206003)(65826007)(956004)(23676004)(52116002)(2501003)(2486003)(52146003)(16526019)(26005)(86362001)(186003)(446003)(58126008)(476003)(11346002)(5660300001)(478600001)(16576012)(6246003)(31696002)(486006)(386003)(53936002)(77096007)(4326008)(316002)(25786009)(2870700001)(305945005)(2906002)(64126003)(50466002)(31686004)(6116002)(105586002)(106356001)(3846002)(6666003)(229853002)(65956001)(6486002)(68736007)(8676002)(8936002)(97736004)(93886005)(65806001)(81156014)(66066001)(7736002)(81166006)(47776003);DIR:OUT;SFP:1101;SCL:1;SRVR:BLUPR12MB0689;H:[10.236.109.62];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtCTFVQUjEyTUIwNjg5OzIzOlhxUTRmWkFRbnVwSjIycENkbXptUWF6MFN3?=
 =?utf-8?B?RnZmUlRqYkczdXkxa2daS2k3NjdIdFovZXRKSUhyM3psNWtGRVZ0eDI5Q3Bo?=
 =?utf-8?B?TkhtbkRtUVV3QUVESjdoZ1VBaGY3UmovMU4xbWhCSU5CNUhaOGdKdWlPZDFh?=
 =?utf-8?B?SFRzOU1LYmY1VkdOZ1BaMXQzY25xdHpOTndkdTNJWTR5cGxRR0VXNFdWRFg1?=
 =?utf-8?B?WS9QbWNJNC9acjl4bTBESnVlMHZFcjhJcGk4S3UxN0xUSmh6WWZjSkQ0NXhN?=
 =?utf-8?B?Um1tbTJjemtnYS9yODhVSnZrWGtnZm5nYk9UWmNqYUo3Y3pCQS80M21KWnhO?=
 =?utf-8?B?cGhkaE03MWdMMkFZQ1d5OWZ1QnZsVFBQbnFVWlo4RHVhdmFrK0tMNnRmRFQy?=
 =?utf-8?B?SWFkalBWSUVSazh4dXZiUUQwQjlhODI0N0pRSTRLajhMeTFLZ0kyZkdXb0o1?=
 =?utf-8?B?RFhHejY5eDVjRXU1SHNUMy9xTzhobGd0ME1YS2o1bmtvSGxBZzJORklNWTRa?=
 =?utf-8?B?TDlRQ3c2aENRazdBaWdaQWhJZFhRVHBiQ24rL3dtY0ppTC9NdlYxaVZ5U0hD?=
 =?utf-8?B?VHN4UXNDcWJsSmc3aDl5a3RKczJIaVJqZWdPWkMyaWxSOHBqZDhCcFhLVFV6?=
 =?utf-8?B?YklvS014TmhuVmhWZVpxTE9hMVpjbnZlUDFqUUtTRytOSHJXYTVrWEpvVGdT?=
 =?utf-8?B?NDFRTnZYSnhUdXNIUUVTWDRFSkp3SXEzQ2R1Si9QSDUvRUZtcGQvMFdoQWYy?=
 =?utf-8?B?ZlpGUkxQTWNHUUZVWnRMZE5rTDJQc3IvVWpUcEtFOVJrZTFoTjZORmpNZzZH?=
 =?utf-8?B?RzNsOXJrVCtKTzJrYjR1UTArcnc0N2lSU2tRcnFSMm1YSjFtS1N2bElrTXBh?=
 =?utf-8?B?cGFUZlFkK0ovcS9oeS9FNDVCdEJUTUsvYjFDUndKZU5hL0NBcnFURTRmQlpl?=
 =?utf-8?B?NmdybEJFRFh0UlRpK3dSY1Qrd1lEelR0b21aMDRISTZ0aHROV1g2a3FYMFRq?=
 =?utf-8?B?dW9WMnZtb2d0N1UwREhETG5DWnNLUzIwL2NtcUk4WndjRWd5ekcwS3lnZktr?=
 =?utf-8?B?QUtleWZlb1Z2MU9WS2FvSEVVU1NNbEZvQ0sxTmI0aFBiSU1qY1FOdHpXSnBi?=
 =?utf-8?B?VWV4TWtYekg2ZjMwVE02YkYyb2dFb0E4VnM1Y21oQ1ZGWTMyZmNCenFMVmVa?=
 =?utf-8?B?Z0hwQWtZclhCL3B4WmtHRzAvQ2pzZFhINGhFcXpJME04T210cHlJQmUveXlv?=
 =?utf-8?B?dnZsU0ZRRkhFVXUyeU9lUFZWZDQ5Y3RQQnNHNlZwSlNrNVFsU1FjeUo0Um5Z?=
 =?utf-8?B?bUx1eXA4a2tyUGJzRFo2USs3Nk5IaDZNTzNzWjdiZEZ3M2lENWd3a0tTeDBY?=
 =?utf-8?B?WFVOU05KaTdIa21Jd2xtZlFPYUVBb0N1MjRDV2w0dm1CZ3dwZWdvd0MybU5S?=
 =?utf-8?B?aFpRT0ZPVWU1MlRVR1E3TkFpVlFKaFlNMXcvdHFsaEc0a0ZwL0p0SnZWQzJE?=
 =?utf-8?B?YUlPWnV4NkN1UmwwZEltVk5aMTl3UmhSbXg2MU1PWEplZjdvZEN4VFRuQWlq?=
 =?utf-8?B?ejBuYS9qQUhiVTZvOVNFOUVmcGtSbFZhanhJS3JkU0lZdjU2MDltVTR1cWhu?=
 =?utf-8?B?dFg1cXM0WDV4MXJiN0daQVZoajB2NTBVSUFhZThMSURGVHFqVnR5NGNqOUJG?=
 =?utf-8?B?a0VteGdOdXV0eDM0UmNvWXBwWVlqdGtUTk9LbjFTNnFjd1Ftem9teGIzbGxm?=
 =?utf-8?B?eG52YUZUMHBPU3ZBbEtIbWwzWjM0Q3hlcnFIR3ZaTUJFUkFsb3lhYklwTE9P?=
 =?utf-8?B?ZlNaSDl3K1dmNHhUM1JNMmlIMGxCcmVHOEt1T1J0SEM5OURWTkxlRXArMWFV?=
 =?utf-8?B?ZlB1UzcxYm5tSG44SElIQnNZOFJ2eTA2aTFCN0NZc3Ftb3B1NDVtQ3o3clN3?=
 =?utf-8?B?T1Ntd2dKOEZJVEdSZmRnRnQ2MXlNV244cFI2YmpOZ1N6M0VWT3lDUjh3RDlK?=
 =?utf-8?B?cXpWUE1rQ3B0ZklKWEE1UDhEMTBoK0JWbDh6UHRhbG9DNHk3VktJSFZmYXFS?=
 =?utf-8?B?MlM5ZTRLN1dVOTdiSTB4TzQ3cWNtU3pIYW9tL2Z0azFoNENXOFdnemUxdVYr?=
 =?utf-8?B?cUE9PQ==?=
X-Microsoft-Antispam-Message-Info: kW3ZWY4ip/jYjH4MsBGn5sfiRWVkS2IQksErPmnHD8j+45iAXE6DrirB1lsNTJXVKAmKbbmWbx7t3DrNo5XodXyqLhFwrdsYXRkVylfAMTkvpotAgtl/PmnSOztgAqbwxjfEBv9S9LTA8fV4Iu2VFtWdT6gyj9IY6VbEPpwJxiNDKDOdYsKTKW3XNj6y3+yR
X-Microsoft-Exchange-Diagnostics: 1;BLUPR12MB0689;6:AnXmFko0kUFx8gGkmMEb5jBYq0mKT2tlkEaoWhfQ7XeMkKVbLYqtAuxbfRTPQH32HrSRc4TZhAdi2maxOOgG0L+CHrQ4ZbwQ5V3tQGZwy7zbVm3qBTbyIy0vyzAfFtlXuE7VztKZb9amz+QYmclxkzmVCkAgNv7w8hNssLLPxOL6/XUEtViOi7xcrymKwgqcpDm8EP8rtLWDRy0woCbYhoNnVNZ4f1jL7WRk4VgCw2EsGfy6mwg4uYN4KqdWIVyt8qyrPf7K6bnnHWjn5WtNnkmHET8eRTen7JP9diDG26N4+sZJtZuMxeNbFsgxoGS9GOOcaAoFnjaTCy415N5NAuuFR28VFzxecwZl9HhMytcM9m/irW96skW8fpVU1Efa6jd4A+bazJybSsbyww9q8KpnpfqSbty5J7nzyWaoc+4IOfWSppRtlSqQbyhSU04CsnePjIQBhW0WTN69cGdzuA==;5:NLrv4QGoaltAExlnWuKcmWP+TBqPIQJOs/lDzxD0YheJeiL2QcnON0113D33I3wu7yQi93FlmhF1MRmaEnWix6Q8bSY59Ra40A7ZlK+8lrHzmh4cJZ5g14fGU2u5KF+/sJtRyhwVsXJYjwxjGEkO69WgixuxFe27evEZNoz9vjQ=;24:vlg0OBSDaxg4QWLuk4Dq64neHDk8Y2FumarYqHT9UTAMNS+l8QJAvhJ/zhjkCaipmVmQ/4/yJCgRy+WIlFqTOorJe0UKiKo0Wk6wrrb7rK8=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BLUPR12MB0689;7:4wXI70lt42twS+6KX8T/UGNiNTKvTpVAtqrPVh8CT3XdbTrl9kikfZ3pSMb/WG4TUpyzhVw0yyT15kGN7viKsaqt75VLSN7ivoHnrdPOH1dXu611vBkNVAEg00krQPbqx88Rq5vvAEdq81kObAppedsKVt0wTeUc4z/7loda31+ri/GG3Z5rJi20t4YJ9pR2yuAqRxw3pyw05UnmLG6q6akx/ASmHZ5OJvKxDUKkUQAA0MSQ3X4WyAOlZxkJrF7t;20:8AFaqC6v4gV+jPad7iTEbeEQXZZjB+iIaxwIbdniz+gKAoVVNiKyzZjobEcekXj+d6De3Jw9FoKUSYdQVPShUNFSh6cL/JaW2+U5kMVOW8nlKaRxgFpRq0kEhpCw/aZjzgmckz5/3qIzh0mjHQvTYMSt/50qr4yDEw/T6iEQlq51aQ3DetVPPhn1daaz1aYSvbcf4B2NO/+o1uja+DX4rnY3du94tYBmROiyBjP+E8qpO1IJovcHCZSAajshGGnh
X-MS-Office365-Filtering-Correlation-Id: 8d6c1d0b-5fa5-49ae-1eda-08d5aed4b195
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2018 19:58:07.5230 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d6c1d0b-5fa5-49ae-1eda-08d5aed4b195
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLUPR12MB0689
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/17/2018 12:38 PM, Hook, Gary wrote:
> On 4/13/2018 8:08 PM, Mehta, Sohil wrote:
>> On Fri, 2018-04-06 at 08:17 -0500, Gary R Hook wrote:
>>> +
>>> +
>>> +    mutex_lock(&amd_iommu_debugfs_lock);
>>> +    if (!amd_iommu_debugfs) {
>>> +        d_top = iommu_debugfs_setup();
>>> +        if (d_top)
>>> +            amd_iommu_debugfs =
>>> debugfs_create_dir("amd", d_top);
>>> +    }
>>> +    mutex_unlock(&amd_iommu_debugfs_lock);
>>
>>
>> You can do the above only once if you iterate over the IOMMUs here
>>   instead of doing it in amd_iommu_init.
> 
> I'm not sure it matters, given the finite number of IOMMUs in a system, 
> and the fact that this work is done exactly once. However, removal of a 
> lock is fine thing, so I'll move this around.

After thinking about this, and looking at the code, I've decided to 
leave this alone.

v4 is on its way.
