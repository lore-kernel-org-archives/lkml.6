Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752667AbeDQRnD (ORCPT <rfc822;w@1wt.eu>);
        Tue, 17 Apr 2018 13:43:03 -0400
Received: from mail-by2nam01on0050.outbound.protection.outlook.com ([104.47.34.50]:38373
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751232AbeDQRnA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Apr 2018 13:43:00 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Gary.Hook@amd.com;
Subject: Re: [PATCH v3 2/2] iommu/amd: Add basic debugfs infrastructure for
 AMD IOMMU
To: "Mehta, Sohil" <sohil.mehta@intel.com>,
        "gary.hook@amd.com" <gary.hook@amd.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>
References: <152302042701.47565.17954813724758433858.stgit@sosxen2.amd.com>
 <152302067362.47565.628887796165116844.stgit@sosxen2.amd.com>
 <1523926423.2747.19.camel@intel.com>
From: "Hook, Gary" <ghook@amd.com>
Message-ID: <823c10d2-e9ab-0f17-22c7-c2eea312bef8@amd.com>
Date: Tue, 17 Apr 2018 13:42:53 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <1523926423.2747.19.camel@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [165.204.77.1]
X-ClientProxiedBy: CY4PR0601CA0102.namprd06.prod.outlook.com
 (2603:10b6:910:88::43) To SN1PR12MB0702.namprd12.prod.outlook.com
 (2a01:111:e400:c42a::16)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(48565401081)(2017052603328)(7153060)(7193020);SRVR:SN1PR12MB0702;
X-Microsoft-Exchange-Diagnostics: 1;SN1PR12MB0702;3:xr9GVMgWVDTJgI3zooybUaXYVlxxvu4yonyWGp+fl9AF5JJEEpHbvul0MMR+I6wNTifO/3YdXiYQpFH+iLgHXGpiOHP2kLb2IE5bq1muutCV/RJbpA+MWYPfiH5Z6cCIpBRmFl8JYKWZ/cgVXvyxYaEM3MnGSEyQuwsr8cNP6tn+RvzThslzRisBllMFV/KwxTf4a3Vbg/NOWKm3mNvB/azmKDXUU1aiBn+h92ppaqEAtma13qWTkWAdt0SyWnzp;25:6MLjPy/U+J25j4ibo7Qcn93asb0wuIpIjhacqiW0kN8xJumm4xWkjMAes/bHKTi+Xt74WQYFmT5JgNNDDqCEP2Wx1Pp3u9kMcqUpte/9pWw8rSOWJprmr1BJT31IIKEGJu8fc4c7QAI5g92Etq+oSfH5aeh3W+s+BBriHN/lE0flDSb18DAgknANRiwSu2WSVwIntlzRr6HvTtLN3sMzLVxRQx3QIrfX0x4Wq76DWZpRa4o9Vaw/BAqUhJWVRQNQ+8eYviX37QHwf/yBhwioK7Td+mxwQZSraWzWwFWXvssSQegrB/DTslHBRTL3cCRhASwBUOKqMCRSpFueM5YLWQ==;31:aD1pqMrcFJgRuJUti4z3PFzUV5xJk9O+LzVWdeBJ0neyNXTdDA3vXaK586gv+wUaI12LUd66KSqg0zBzF3H3AG8c92LWZCiuO/9JuUqSsZu9C10/ZF2ndChDcocSAPSxetMmmDWTvgkN/Nk5hoDTtA3jCjCA30hRoO1jJchGiSgpvTjF3KtxeZRg+J+4ZxSYoPt+tOSwNbzyTBnQTYnVrQXA/C915DdGa+Dgi80uufc=
X-MS-TrafficTypeDiagnostic: SN1PR12MB0702:
X-Microsoft-Exchange-Diagnostics: 1;SN1PR12MB0702;20:iwdXC/edBQXpYkVWZn+urlbTk+DSXkEZRiO458Hba1Pk9aPQskqJJAZMprjBxZDJ9io+4feue16/ORT+8/p7Q6vDS/TaIe7WQN70sr+Q4zf9DTsmRDu6g/dv7wiBb0gDXy0ZBREBfQ2DBeS7XkSJZ4DwgRDR6hXswy2IUg2vTJbMaDobMFkbulHi5IIYnRPs8u1COn1nw0x1d55Z/q0omVNpU0sgd4nNZ8sUZ6qrBp+AalBa/seYr606M10+L/dxfp9Jlu7g6fLoGO8KN/BkxnZassWX1T4VWYL1BS9i/xWbWOIY1r5/keGTvvqPmHJZUUjNJt+ys/P6szKyk0i78IEKiLbC9FhhrHTdiw6WD+6C4QcY1ByY3wtVq4q+qP8Zn6FQZZVB81Wio/1fKPSRZ6BOYezNKHblJP6/8GFspB471i48Kw6dE8Ph2pHBIx9cnpZXR1ZwXeCi0AKysxWyU3wJSdJBH19EKezJRZWv9F98Oc50mAUP5uGChctbntzX;4:zNOY5ghWdUUee8HHwNx5GVWwgvdkVVKxSK2zg7fNao/3XOYGTzAIlrzDMwKgWRLt//3vrK4qQzEpS6b1ydUW3tfuJD2jhGR4/1GG6P1tLSZRXkgo+vjFYDtWcQuhJUHoz9EttTMtzze0Ie9Yq7XcppS/32e0GS4wdlDQ+SqUGTUmtTqI+TGE44FvABlcx2sn52XGsPHWI5t60tqoA7mSBanIDnlpGF16ejnlLJWKPB/1xu5ZohRXSlhfrTLbpeI/lWzvvk7+SbTDJn5ZqkIh4g==
X-Microsoft-Antispam-PRVS: <SN1PR12MB070291FBD99C1F1921B76426FDB70@SN1PR12MB0702.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(3231232)(944501327)(52105095)(10201501046)(93006095)(93001095)(6055026)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123560045)(20161123564045)(20161123562045)(6072148)(201708071742011);SRVR:SN1PR12MB0702;BCL:0;PCL:0;RULEID:;SRVR:SN1PR12MB0702;
X-Forefront-PRVS: 0645BEB7AA
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6049001)(366004)(39380400002)(376002)(39860400002)(396003)(346002)(377424004)(189003)(199004)(16526019)(64126003)(106356001)(105586002)(8936002)(6246003)(53936002)(31696002)(25786009)(65826007)(81166006)(81156014)(3260700006)(8676002)(72206003)(58126008)(50466002)(16576012)(316002)(65956001)(54906003)(97736004)(68736007)(6666003)(47776003)(65806001)(31686004)(66066001)(6636002)(110136005)(6486002)(5660300001)(229853002)(2501003)(52146003)(23676004)(2486003)(2906002)(53546011)(7736002)(476003)(67846002)(478600001)(3846002)(956004)(386003)(26005)(2616005)(52116002)(446003)(486006)(11346002)(77096007)(6116002)(4326008)(76176011)(305945005)(59450400001)(36756003)(2870700001)(186003);DIR:OUT;SFP:1101;SCL:1;SRVR:SN1PR12MB0702;H:[10.224.10.182];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtTTjFQUjEyTUIwNzAyOzIzOmJna2p4cUwxZnVmdTZyODVDMDR1dFc1ZGJS?=
 =?utf-8?B?YkZtYVJwbmFFdnhNZy93SVVNY0gwZklCR3ZQUERNWDhGUkJRNS9zc0xUTHFQ?=
 =?utf-8?B?dHRnZERyT0QwVUorbHYwS1BQOHFTOUhIZnNpL0lmeGtmK2pBSnVZU1ZYUWVa?=
 =?utf-8?B?bDRxQ1RsNTlYRUV4SUwzRlc3emhyU0RSVEcvZUJZYTNJMDV3YWtmUmppZ05s?=
 =?utf-8?B?VU44MFd1Wk16cjlZc3RubGRLUTI5bVZoMWFldVMzb2ROQmhvZGFHSzNaV0FP?=
 =?utf-8?B?dHQ2ODFERWNXLzdzdUNhcDVNdUlsWVYvMjJ1RTNrSHEvakp3OE14UVBRRU01?=
 =?utf-8?B?WU9EelJmYmY4NkRnRjBQSCtyQVM0eVZJTWM2WEZCbktkZ1BNaFplL2VIbUN4?=
 =?utf-8?B?anl3ckhlS3Y2VG1EUkZiK1lBQ3R4ZThpeDdRSVgzZWI3ejBOdnQxalNPeldJ?=
 =?utf-8?B?WHRyQy9xSWFXT0ZiaENHRk1GMWdSWDZ1ajhEVGVwVTlrNGxmSjc5VFBZbndl?=
 =?utf-8?B?RzVtcjNmcG56ZjBHY0xUYlpFMnNLWS8zaVE5SUsvcndON09TZ1NzZjh2Z1ZW?=
 =?utf-8?B?OGhwMTVVY0RaUlNjdHBnclpWNHNRbVZwb25rSHBHbU02ZTZxM2I5ZXlyYU9n?=
 =?utf-8?B?RURpV253am1BRWk2TWU2MFBDWGtldFRxbkdlajNVMkhibDhXbDV0VTZSVUx2?=
 =?utf-8?B?NUMwV094NXRuTjBFcGtKUTMvZU5rcThSNUZqaDdKZ1ZjRjg2VHNHdXovbG5Y?=
 =?utf-8?B?VkZ0cVVNMzlOTjNVYmwvbGxyaDZUVnYyYnkvQUN5L3YzRWswWTFQQlovOUVy?=
 =?utf-8?B?R1hwbDdWTVRPTTFkSnpJQWxzMlFMU2lmWnZQVUZKS3ZaVVI1K004SGVJV0sz?=
 =?utf-8?B?ZjFtUm5XN2VGc0NCU2dmazJ3MURUdVhOb2NzK0FNa2ZHdjBVU1JlUHdVVkgw?=
 =?utf-8?B?YWZRQlJaR2dXTmlBck1rZVMyT09GOW5WVFRyeWNZejMyb1k2MldSWHUwaWJ0?=
 =?utf-8?B?ejN5QURUdGdRN2o4RGJibEtpRjNUd0NjY2g0OTdpeEJqQWZIb1RUMXNTRXNy?=
 =?utf-8?B?M2ZUc0dFZUplemJzMFMvb2pOK3h5QkpVQm5VYU9mTTdJNHN5MXQ1NytDc1hD?=
 =?utf-8?B?Q1BQRUJsOVo2TUVMVTlqdnl6Z0U3QXNtd0ZnSkFteS8ydDlLc2thTU1RbnJ4?=
 =?utf-8?B?VXNGNC9CNThDc1JneElTN1cwTEVHSWVETm9CUVNacmNBVHZveEJFQlY1Y1U0?=
 =?utf-8?B?Y3dGdGhjRXh4WklqWW1GUmJtNTdwMnkxb0pVTDQzcWRNWU13K0NlNVA5amJE?=
 =?utf-8?B?Smtod3hIS1lYWmRNblphanBJQjBnUDV1M0N0bXhtcVZEd0pKNWd2dG9PYWR1?=
 =?utf-8?B?TzlNMjBiRnZwWk1wWFduV2d5Z0wwa3JGRldMVjJtZWVqWnhwS1E0bEtrcWdU?=
 =?utf-8?B?V0FGbHBYdXhtUTdJUlVKTGFaK0RGVTZhQU0ySmlxc3B0RGtiS1UrNGtMQXFa?=
 =?utf-8?B?MTMybVhCeWVhcXFtUnUrMVBpUHJ3ZDVQS1ZkVERhUFo3cWExTlRsZlpwSnFO?=
 =?utf-8?B?NUJLWWVXZ2tXZWJGSmRyK29mdlVsaTdLZ092amZVZHkvZitRWXZSVzJJZlpT?=
 =?utf-8?B?eDNyL0U2cXM2R2pjM1JMRkE0djhkaUtGTGxuWUZuSG1xTG5qM25KSDlSUUd3?=
 =?utf-8?B?Z20reGZYb0ltanNDOXNJQXRyNWVzaFJlVldVRmtJRGlDbklHdDlRUHFSUFhB?=
 =?utf-8?B?T0hwd2ViWXdMbDhiTnJUcXVweFQwU1lMM0pPaU1sVkw2d2tnSkxob01KK09S?=
 =?utf-8?B?bWVPbU4vY1VHeG5TRXhxTHRMZWVtUFNyak4xNjVUQS9mVkE0VDBqdmViSkww?=
 =?utf-8?B?M1pOckdOTVRGTEhKRFp0YTMrZlFRR3ZTRWVTcHVRWUJhR1o4dGJjdC9RdkFU?=
 =?utf-8?B?R0E5cmg2emNSYm04cmIxSjJMM0JPUjRQT2xNd1RGY2ZXZXJuc0c5K0FzK1FH?=
 =?utf-8?B?Q0tuY0JVTFBMTVBqZDFzbDBZTHRkUi9PYzFYTHZLZWZ6QlZoUTZ6VHN4eHZn?=
 =?utf-8?B?WThEQ0l4ak9lZmpaNUp6WWF0TG50d1VOejdXVE91Rjhzd3JLWGhhWXlWSFRG?=
 =?utf-8?Q?MLflINHwPz5hG60j/6ckd0U=3D?=
X-Microsoft-Antispam-Message-Info: ZM7wXvcu6n6P7Cbu9z810SeCb65OOoBKqML7vYLJqvpxVMmknFtWyhSJHJNCwqva5VCkRGe7Oy9IhtM9cjN75RXU+ubEn2/chntoeR05IZxulOALJ2uF/UNpS68a1JV57rAh4qiKdK6RwGDvqGBL4L+4KXLUbm1T3R02nX6LGzWzS+TlEu+tSfJGMCFTZnqf
X-Microsoft-Exchange-Diagnostics: 1;SN1PR12MB0702;6:ytUEzTJ8OTL6OwWrSRgxjZfAF1C0WwUD1Synz5W6WkDODTNEJJwMjQWgnxLSyRxWV1Xc+gC5suglrB02Nh78Ck7ROcKw0lPmWNYLRTwASj0c29/+McuvXOCvluy+jVMf8LxIVkbpSEn8eCMGndWM5ajioz1Vct9YbLtQ84svN9VvlRN0dplBbrC3lp1rCz73UZELz+m9Y+2vy8VWMHG9Zxuyb3YT3Ko79o2tQSVzR4SomYO7AM5dLQikYnUHfONCWY7QvawrHxcJbnbqwJoKln28vCnxprp30p4o0ATqyo1lBNVnK7Fp4nYFwzCBDUT2ITTiU/NnsBy7DT33h7rs+8Rd+BUee9P7nDTQ8h/Xkj0+v0MC5HA8Yb1L3pfXKXeZcMjFMHDm2pyXrZdLtp2Dqg+6BinOQ8D7an3/rwCwwxtINyQ42vD/D8T98RUg3ElqdrqOcJWhY9GPZCeoiCddYQ==;5:oFQUKZ+btBXs4uND6m4BpOZqEFYK09WGYb5h6otxB7xoB1JqjVpylt5J6UU7/QCntpcGcqHII2yRZQkdbieihnp5+xzcDqC2s189FxziI5xqta5DLQ5rwUgN4eyQrMJD+hG6Fgv/PxZmL/7KGDdz8HGdpOgFdeeAHP5+OtZZGgA=;24:YrqPzQzoSWiumd9td5BN3CKQYqmpwVIn8THaQEFukB3uAiwD80wVRBr8oXwK8YieyuXL4HmQdy8O3oyXWdv2QUTekBTmhrLH+qGAwxFO70U=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;SN1PR12MB0702;7:m1JxUdYcoO8bvci/wf74vbIeZ9b4cp01az8okLLIb3cXWbGIpT9UbbXhf6fz7NqYQv3GNAngC8RtWCXw3oo1iNNj2u1MXUm+kn05CQ8l05+R7vVJwonJkxPZfVhu85BRcR/OK3GsmNDZzkmeJ7iasNtFdlUcaO2emOS8pWwDJ+orFOjZLITgnMemoH4mwdmAwrfX8yrN2sb2k2yx2UyytgFkN44iIShWri4POXBJjP1PmPMrqI8AbQiQcpppP/23;20:3IfUtLIJ3PFYHOabL6QQg+5m+pPhpsBZIvXWNQAgJ3ZPqKEESWOqzgtSslv69JyTiLaI2Pp+m7nF0rKc2kRJ3WHztW12Qyc1Z2E3OZ5rZSPDtWNtOFknkFWg3Tlb2+ehqfRWCrXC5Xl6XVsHYvsbSMeNT1UUe+ZYYHTGuPuWl4D/ZLj3VfLoNL/WxfwF2yVTLJ/bARkbbO6CUYoVzsN5Io/OIRuLCCUmg9iaBwwFZMnY2QzpZ/N8nb5XaC7aXkBs
X-MS-Office365-Filtering-Correlation-Id: e8fa18c2-cfba-4983-d05e-08d5a48aa90f
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Apr 2018 17:42:58.3964 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e8fa18c2-cfba-4983-d05e-08d5a48aa90f
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR12MB0702
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/16/2018 8:52 PM, Mehta, Sohil wrote:
> On Fri, 2018-04-06 at 08:17 -0500, Gary R Hook wrote:
>>
>> diff --git a/drivers/iommu/Makefile b/drivers/iommu/Makefile
>> index 5eb1121d54b9..0ca250f626d9 100644
>> --- a/drivers/iommu/Makefile
>> +++ b/drivers/iommu/Makefile
>> @@ -11,6 +11,7 @@ obj-$(CONFIG_IOMMU_IOVA) += iova.o
>>   obj-$(CONFIG_OF_IOMMU) += of_iommu.o
>>   obj-$(CONFIG_MSM_IOMMU) += msm_iommu.o
>>   obj-$(CONFIG_AMD_IOMMU) += amd_iommu.o amd_iommu_init.o
>> +obj-$(CONFIG_IOMMU_DEBUG) += amd_iommu_debugfs.o
> 
> Compiling amd_iommu_debugfs.c seems to depend only
> on CONFIG_IOMMU_DEBUG. Can we prevent the code within
> amd_iommu_debugfs.c from getting compiled when either CONFIG_AMD_IOMMU
> or CONFIG_IOMMU_DEBUG is disabled?

That's a good point. My intention was that only one switch was required 
to incorporate any DebugFS support, but I see now that I didn't consider 
all of the cases.

It appears that a per-device switch is also necessary. Unless someone 
has a better idea.

>>   obj-$(CONFIG_AMD_IOMMU_V2) += amd_iommu_v2.o
>>   obj-$(CONFIG_ARM_SMMU) += arm-smmu.o
>>   obj-$(CONFIG_ARM_SMMU_V3) += arm-smmu-v3.o
