Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752624AbeDQRiN (ORCPT <rfc822;w@1wt.eu>);
        Tue, 17 Apr 2018 13:38:13 -0400
Received: from mail-bn3nam01on0062.outbound.protection.outlook.com ([104.47.33.62]:19424
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752043AbeDQRiL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Apr 2018 13:38:11 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Gary.Hook@amd.com;
Subject: Re: [PATCH v3 2/2] iommu/amd: Add basic debugfs infrastructure for
 AMD IOMMU
To: "Mehta, Sohil" <sohil.mehta@intel.com>,
        "gary.hook@amd.com" <gary.hook@amd.com>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <152302042701.47565.17954813724758433858.stgit@sosxen2.amd.com>
 <152302067362.47565.628887796165116844.stgit@sosxen2.amd.com>
 <1523664612.2747.13.camel@intel.com>
From: "Hook, Gary" <ghook@amd.com>
Message-ID: <efa2b7a3-04a7-20b1-3651-89ebafa85c27@amd.com>
Date: Tue, 17 Apr 2018 13:38:04 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <1523664612.2747.13.camel@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [165.204.77.1]
X-ClientProxiedBy: CY4PR1801CA0034.namprd18.prod.outlook.com
 (2603:10b6:910:74::47) To SN1PR12MB0702.namprd12.prod.outlook.com
 (2a01:111:e400:c42a::16)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(48565401081)(2017052603328)(7153060)(7193020);SRVR:SN1PR12MB0702;
X-Microsoft-Exchange-Diagnostics: 1;SN1PR12MB0702;3:XvWRomorwNwpfC4bKSackQm7iQm12y5PqUd+zZMaFRIoVx4bpvkbDOG2nXgcVqv9RcCguUUs9Uva1d7QUcJNVhsXbSmBMo38ltEiXvUcnVI1qUnJUsIm6wL0Knj5KxZz+njYIduWKwMTgxnNqbykp4RkzRL1TmAKAXYST/TknnzV8lvMesDB2c5CKdL1bqUVASbB5P+PXbOMrMVq2X175B8KS0DG9ym/k4rgrct1L8YA6oD8U1e0G6PrpKjgYOP3;25:c1kx4XTSqEVKV8nR3sfEAmKfj/KxT5pdapoVMh6Eoy3krJ1zVq7SvQBDmU39e73zkZ5HjBKUd3GNSt/rwMe8CBTVqVGD2OTixE74zmKrkLbx+xEBNLj68poSu3bCYINSkJEzE++cNi5DCIrbCV6XmHkgdyY21K5Lul09wR55dR9DnnNSUbO21TZLeShmIIWLFf+v5xfMjeNvPiqJ3hvW3THZ1Gr8FqhV62FrMn238hJbFQNWEarTrGCHN3OPVHA1Sfmo2HMggKJcgFwdRbcVp/cI8BhooM487ZYfiBSpIU16lI9NSgglHId3haarjZ7N+xilAPCKPFg8uSfbSmQICQ==;31:9daKBEjpfGTFjeqWJ3MhtMiccBjwUePg+ZEBtYrFHa43BB2zXr53xF3Ec8osgYzxHpod75DG3odEshDwSgZTA4/q7Q5kqCg0a75c1fj1o7Qa3fEPwARQ6KgBsjZXol4M2vPrpr+GQ1y8EE4e7v/xLcLgz+m9B+IV5CAXghk7/Iatx+e5dS8E4HXx9U5hjALIjjX24YxSmxOscYBzkOUa5X5DQ0hMuTMDiz+vwwMnIbc=
X-MS-TrafficTypeDiagnostic: SN1PR12MB0702:
X-Microsoft-Exchange-Diagnostics: 1;SN1PR12MB0702;20:gEdZKA8Tq2AFfwQOPacZsKcmBfrP3A8MJDqpzhkCs6PUYmQhuKNew9k97mrh5k7yq4J4TgmMq6HHUE4FUGN7sUhJYi0dBEJ9aN/5paHVcZoz9xHl/EOLxF7gEwSEga9fjGViTN5DfLwtrS2K0r7ZHtvR/ERcHDBH0EbA6KuEFFE9kVKAaxG4PKG9rNZGq7WOtuETGqLfzyqtLQ7PvAcXs/fWXsOegrgkmiS12CmBw/zDmdl4/hCpm3uCCrYbWvh/c24wi7CRGiCHk1FWR+rADpvGfGTm5y0TWkBvxEr+ga03TE7nw+Nv/fiU2n3n7It593TSJBwm5yH1F6XF1rB7kthrZaKgPGQfsTp+lJFivPbBBOi6iIhRapB40m4Cp30XcMe5JO1vXCLe0uCkH3itu5+uBr0NIAyMaIjdo6aJSGlyLMvmi/SdFR5f7437Zipz27bpdhJk7ll9vib+2D8yKZrjCdp+/AgI8GoCOypsPpugKf1IxWI9C8i++nkvCJXR;4:hqmkxdXGDQ+8YSQaAMD0D3Ug79To0WSAG8m2c73lDdoRtpPB5KYMZFNHlVFo5Ae7JmPt1hjT4eNP8HowTl1j8z5wjzdlaTC4vac0iq+WHCGBK8ictbA2QBjgYs+nxBv1Cncbg4Vq8av9zF/4navotRcpuuWP+LTpqWhad5xdXi6UuMoQIqsBZGD2tbHkcI9gXRAieJniqTf1ab0Wwlt8V7PJSqbrl06Mpu5W/X4+IoHvYXxAdf5/938DwNALnTlF1HuI4yAXbGvIsqfgvc9pCQ==
X-Microsoft-Antispam-PRVS: <SN1PR12MB07024A716B2BC46D32FFE2AAFDB70@SN1PR12MB0702.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(3231232)(944501327)(52105095)(10201501046)(93006095)(93001095)(6055026)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123560045)(20161123564045)(20161123562045)(6072148)(201708071742011);SRVR:SN1PR12MB0702;BCL:0;PCL:0;RULEID:;SRVR:SN1PR12MB0702;
X-Forefront-PRVS: 0645BEB7AA
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6049001)(366004)(39380400002)(376002)(39860400002)(396003)(346002)(377424004)(189003)(199004)(16526019)(64126003)(106356001)(105586002)(8936002)(6246003)(53936002)(31696002)(25786009)(65826007)(81166006)(81156014)(3260700006)(8676002)(72206003)(58126008)(50466002)(16576012)(316002)(65956001)(97736004)(68736007)(6666003)(47776003)(65806001)(31686004)(66066001)(110136005)(2201001)(6486002)(5660300001)(229853002)(2501003)(52146003)(23676004)(2486003)(2906002)(53546011)(7736002)(476003)(67846002)(478600001)(3846002)(956004)(386003)(26005)(2616005)(52116002)(446003)(486006)(11346002)(77096007)(6116002)(4326008)(76176011)(305945005)(59450400001)(36756003)(2870700001)(186003);DIR:OUT;SFP:1101;SCL:1;SRVR:SN1PR12MB0702;H:[10.224.10.182];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtTTjFQUjEyTUIwNzAyOzIzOk9wMDJaTlJwY0pBMG1mUTdjNkRKNk9DTkh3?=
 =?utf-8?B?amJBcEdGdmhEY2NMLzZub21BeEV0RU9DcG1yM1J4amJWTnozQXZvSzlscFdv?=
 =?utf-8?B?MnUwNzlKbUJObHpmU1E3eDRyUHMwUXpHbVMwbVVQRjJoaEl6TjlqWlBEWjBZ?=
 =?utf-8?B?dTV0ZFRKdzRYWmFGOTlxVitNWHZUY2tBZ1BrUkJOdkFIcVN2Vm5FQ1g4Q3Aw?=
 =?utf-8?B?K2ZhSkhsTnIzY3ZYN0J4Vzhsa3d0RlN5Z0RXU001b0hLYzRLa1pRZGNzU3BQ?=
 =?utf-8?B?dzFSZlNWc21BOUJuR1B0aUxQenVWNko5a2RTQlNtUFpmRmU0amllQUd5ZjNj?=
 =?utf-8?B?Z3NBc2EyTXpudkhXWFVVNHRqcXI3NkwzOU93QTYzN3h5emsxVjBZVllkSVMv?=
 =?utf-8?B?Q3lKZ3NiOXVORjYwa3J3SXREZEhsZlFieVR2VTV0MjlpbGw2R0l1UmRxUlUy?=
 =?utf-8?B?QlBzekl2TzNGR3NVaEV0bUVQOFRnN2oyOGMyV0creG1ZTWxmTzZOb3Yza0lS?=
 =?utf-8?B?OXRqNWpnYWtKaitZUnRBQmJJQ3FvRllUUHRueE5PSnhmd0lNS1lDdmlVWUFs?=
 =?utf-8?B?dy9jQUZYVGdjUisvSWE3cEVIRDdPWldiL0pNdkNxS1V0VkMwZlVCK2Rkc3Zm?=
 =?utf-8?B?Ry96TmpQYm1wUWluZkJvc2dndG5uTlNBcE5BSmlqWUtzVEcybFNYNmIvTjFm?=
 =?utf-8?B?OGdoSzFkUmUyNFA0R1NpdmZGR09hWFM2eURya2xwUnVDUzZ2M1U0VnpUQlkr?=
 =?utf-8?B?dUcvQW1xdEFTNXB2bzhaUWx1a0lCMHlxaGRIQVlQUFFoTTgwWUQzZDZmYzNR?=
 =?utf-8?B?cm41d2NlenplV1k5aG9sUVdQaHRKS2krUHB0aFd3VjhBM2pJNmpBZ2xRYnlj?=
 =?utf-8?B?L2RQSzd5K0hqaU50NjczaitYbVIyREhiZHY5VmRKcHEvcC9xOUNidjdEN0Vi?=
 =?utf-8?B?TzFISmJXMGVsU1pWbTVSN05ieWlwd1JDUVBGSkhBT05RUURvLzRIOEEwWUx0?=
 =?utf-8?B?YkVUT3A2alBJUHhhaEFXcWVTYyt2bzlmcHVCSjhmZnFlamliL1lBaXFuWlpw?=
 =?utf-8?B?b0svYXBHdDR4Q0JDWHRhUEhmODlYTlJyMUllK2p0T01WRmVYK3ZUZ2NuT0d3?=
 =?utf-8?B?Rm5RVkk1WXhJVmh0UkFSK0cwbjhUM3hSUE56Wk1LOC9jZG9wMEliOHQ4OUQv?=
 =?utf-8?B?YVc2NVNvU1lMK21xM2hUNjk4RmN0VWZNSGE5NXVHWTF4bXQxSStJcFpncGlE?=
 =?utf-8?B?MUs5bTcxaC8wcUkvUWQwYktTZTlyYm0zcmY1cCtuM2preFhlcTA5OWFMSUEr?=
 =?utf-8?B?blRGVnA2WWNFL3cyeFZnVkQzVGoybHBHR01QcTh0cm80cnNQNWtnendYVENk?=
 =?utf-8?B?NXdlbzNabHRhL0dleGhvV0doMjQ2elJEcm00bTBOYjVIMlk5TWxmci9qRU5P?=
 =?utf-8?B?Wm8wMXZHbDhINVU3eExjdUU2NTYrOFNyREczUHZEVHdKWUtRYzdnYXI5RjhE?=
 =?utf-8?B?ZFVPNkQwaW5MNWxlek5vVkxEc3B4RUkzVXFlOVpoT1ZCYVFQbklIQnZPUTNX?=
 =?utf-8?B?ZWNqVUQwV1BsQXE2NUFTb1oycm91MzhvNlFGUkRHWlg5QjVqNFJ5ZlR3dWk4?=
 =?utf-8?B?SFgwOTJPQ2VyaytmYkJiNGFRa2JmT1JMK0laa3JOeVdZczEvVnhqaEpiRWdB?=
 =?utf-8?B?Z0xRQjVudVhSVS9Pbm9nU0dsczY1OC91QkdDbUYwS2RCZG54T3JWY0xBaGpG?=
 =?utf-8?B?MjQvbmlGdzhRdkVyek1LVDNickVuY2FCeTlNY0xlZEJsM3hpd0Fwa0cvYmZM?=
 =?utf-8?B?ckNyTlNhV0NJVi8wRURKRHdubzJDNkNhODRCYmhVa2Z1ckNSL0Fia3VpdzYv?=
 =?utf-8?B?Tk1WMElMZ2xkZnA4dVhHM3d1eGdOUnV6RXhkZ3dPR0Q4VFIzM21EdHR4OUpP?=
 =?utf-8?B?Q1k0UVVUd1A5anJqWUkwZWJsdlJhd1ZCaXpRV0c5UHlXaVlzQlJXM3ViQktj?=
 =?utf-8?B?cGhWT0FrRjRtOWpHYXVSNjVjU0JMbkJMQTZsZm1nUkN3Y2NhM3VMTWlLaTM1?=
 =?utf-8?B?QXNYUUFtUk4wVjJRWWl0R1cwZnpQaU1tZUdKVnpNVkJzL2RqVVp5MjRlZmxD?=
 =?utf-8?B?K2c9PQ==?=
X-Microsoft-Antispam-Message-Info: 9i5rTcK6pzv/hd2FEI1BfM34jCy0TdfWglM7ms+cfGzbo98L8lWchonLSrlb9NsM1d0x9OKO8F0pQKYXPWuBjNr8qNiUxKWEq1I1dw9mPJ3D47xMnO9y0kf/GJAqOCsikvYMn9ldPDQ9Ard/TDc+Z5fjW6a/x1wUVKbUOgD/4y7lG0Ci6eWz9GA9UvrdMrUs
X-Microsoft-Exchange-Diagnostics: 1;SN1PR12MB0702;6:stsrapJ8xuF3E3pk6vh/RibyDZYqiKVrBu65djSjoVa+cl998Wof2D00n3f3kW3lAI0MpRfD1IiFRD/AEWi1sLX/uFiXzK/GNKEuXssmx3FeihQvc690xVXBxNHIM2Yh7Hcg/NsDVGFDDYWY1I9A5UlRvOJWU2YyZcpdmn1tbi0T5iwElDJOVMUwxGTbYn1rjT7cYkrwsPCAxaIMGr4x+cpkfnPvwIVB29+odkMlEPr+xI5Un9QZwyKcMVJd8f/mwZRuLyThT2gYGw1Phdzjhzg932HvfQ2O/pKdguYEqWDliNdjemu7TboRFn//SiLXNthFYxFzhjYr9vGCEhH5QH/wUTs2eEhYb6gT7xLhfgMBDdByFZUZ71+vKPUOI2WM3BrplTqhYxZDXJztG2QeM+nVuGoIIigSPx3V2ORGXTIWsdnoj9noXoAIABwzQjA9AJvRfYz1ZhMv0y1PdYRQdw==;5:kynBfBxaNnInh8g9nqRYKlLFZb53kN9aJQVhmeAf3nCWlD2ZdjsLV/g41ZaBP/KqCPdwft+8WuNzk6QlRcpeeJYqKT4s38XKQdKcNQNHC/KL4dN6oLClcLeHNXf6oEWWl79XBOMogKynia69vrxVo5j5rcRL/lX04zQr+vX730E=;24:4Q/mkdnbksn1WiQnnjm16y4iSQrYIfF3J2Skcd2EREbHzbCJrk3lcwoecwLuX0Dc893W7A8rZWDk5AtNj6WhhT0v5dIQRgRxuqnIuAhsy2k=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;SN1PR12MB0702;7:0h5qoz6HZJi3F1Nkz6ttL+WtFv+gA4ni5eA9HDsJD4kn0cjPur88lpVgcQGLb3qNy+KSP5+/E8Eh/g2ai2TX1Sosnj816vC7DU1mraLy/f5mVU/sUAi1/tgszg8frnmqGEH2t7Oj3u+0GeZE8Pk4S5LEGASgaJxCqpbDHjTHP/9UJAgbNroTDZRP8CAI0L019RZJrsxfFJDPxBxflvUuNJIkuB7GDcFDjB/dukWnDwKleD3invyX+sL9whYY6Bo2;20:2ypqIyonzIoBpIQgQ2KIo0pHnbJs5uiF65rnsPRXAJNq9Cimetb/mDvWDLMiS4pBFud837iHX8m8tXimKkK61iTDcyfK80gAk6P8XScClgOtIR5Ls7/8bBSfPwc3pNO/fEpZEr1A59BtRPQr+4GzjCz050tSCXBwz3/13h/JjnnSqTwNRAIduU2uIZUH2Db0+nH1q7H2/nUQQWGaAhcYAGohl4ADhZfOxFLPeUzk38EYFyeUmNEgQS4XDv0mgRzq
X-MS-Office365-Filtering-Correlation-Id: 6b94e719-9bc4-4f30-5581-08d5a489fc49
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Apr 2018 17:38:08.4963 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b94e719-9bc4-4f30-5581-08d5a489fc49
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR12MB0702
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/13/2018 8:08 PM, Mehta, Sohil wrote:
> On Fri, 2018-04-06 at 08:17 -0500, Gary R Hook wrote:
>>   
>> +
>> +void amd_iommu_debugfs_setup(struct amd_iommu *iommu)
>> +{
>> +	char name[MAX_NAME_LEN + 1];
>> +	struct dentry *d_top;
>> +
>> +	if (!debugfs_initialized())
> 
> Probably not needed.

Right.

> 
>> +		return;
>> +
>> +	mutex_lock(&amd_iommu_debugfs_lock);
>> +	if (!amd_iommu_debugfs) {
>> +		d_top = iommu_debugfs_setup();
>> +		if (d_top)
>> +			amd_iommu_debugfs =
>> debugfs_create_dir("amd", d_top);
>> +	}
>> +	mutex_unlock(&amd_iommu_debugfs_lock);
> 
> 
> You can do the above only once if you iterate over the IOMMUs here
>   instead of doing it in amd_iommu_init.

I'm not sure it matters, given the finite number of IOMMUs in a system, 
and the fact that this work is done exactly once. However, removal of a 
lock is fine thing, so I'll move this around.

> 
>> +	if (amd_iommu_debugfs) {
>> +		snprintf(name, MAX_NAME_LEN, "iommu%02d", iommu-
>>> index);
>> +		iommu->debugfs = debugfs_create_dir(name,
>> +						    amd_iommu_debugf
>> s);
>> +		if (!iommu->debugfs) {
>> +			debugfs_remove_recursive(amd_iommu_debugfs);
>> +			amd_iommu_debugfs = NULL;
>> +		}
>> +	}
>> +}
> 
> -Sohil
> 
