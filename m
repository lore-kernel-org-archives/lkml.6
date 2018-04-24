Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751369AbeDXP6b (ORCPT <rfc822;w@1wt.eu>);
        Tue, 24 Apr 2018 11:58:31 -0400
Received: from mail-co1nam03on0079.outbound.protection.outlook.com ([104.47.40.79]:43161
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751033AbeDXP61 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Apr 2018 11:58:27 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Andrey.Grodzovsky@amd.com;
Subject: Re: [PATCH 3/3] drm/amdgpu: Switch to interrupted wait to recover
 from ring hang.
To: "Panariti, David" <David.Panariti@amd.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
        "Koenig, Christian" <Christian.Koenig@amd.com>,
        "oleg@redhat.com" <oleg@redhat.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "ebiederm@xmission.com" <ebiederm@xmission.com>
References: <1524583836-12130-1-git-send-email-andrey.grodzovsky@amd.com>
 <1524583836-12130-4-git-send-email-andrey.grodzovsky@amd.com>
 <DM5PR12MB244017F98FC732EB5DD86E0395880@DM5PR12MB2440.namprd12.prod.outlook.com>
From: Andrey Grodzovsky <Andrey.Grodzovsky@amd.com>
Message-ID: <b4309ea4-c1a0-5811-040b-4390ce6f297f@amd.com>
Date: Tue, 24 Apr 2018 11:58:19 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.4.0
MIME-Version: 1.0
In-Reply-To: <DM5PR12MB244017F98FC732EB5DD86E0395880@DM5PR12MB2440.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [2607:fea8:3ce0:41b::4]
X-ClientProxiedBy: YTXPR0101CA0026.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00::39) To MWHPR1201MB0126.namprd12.prod.outlook.com
 (2603:10b6:301:55::13)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:MWHPR1201MB0126;
X-Microsoft-Exchange-Diagnostics: 1;MWHPR1201MB0126;3:E66zJPsfreV+BU+0V6/iGrypX98KGMumyAgzunociYXGfuFmHbM42LAtBttBCyOBWENg6mqnuSsQxLY4Bxq+YQ22JbjISU7tPI6RZO1EpaiaRe4Cb0ZSCCZd5W2Zb6/w5xfxZ4RYCKuBEBtDMXdLPDvo1/bFz98+U3NFYdHhTmgJYOVMlD+VpnXlSrBLFHdU3Q5gn5Dn5f9GpgxYboCmZwslMyK6+/KSMnHBG+bjgnKcjb8tXFdIFNZVtESVFLmM;25:uJFJ/2YLFhTBudX6k3R0mOQOLFyJZYktbmm6s3FrBGFTfApQrKwqsfoqiS9sjczZaabXvEU/HoL/AlvDhxhUACGySu0+5dF1r9Dw03cDt6lC998BC1T1emtSu8bAMLflWJu7fpCVsHgSuF1ceI5366fzcJs7tcGhSFc8k9noYCGAs110Y9/qFi/EI5sfMen6AMqvVaNlBjc7Te8PEmnFaQfffpPOH6SyGOdJSW5rf0w8YiqdcAeZYyuCZuzaLg30vTX2U2cDe3oSc28fWM+hMUR6Eme/vnlUillqdWfsart7684pFShYdgDVwNPJG2O2QXMl+7K0O3asKptSvJBqkw==;31:yhaKC5xX7s4AtE5qWxhVcdzqMyPliesS+c/7BWQq0V+ROIrsIRFJGx9FSOZtaOESKl6W+nMa5d9lSTMz7nWrjVl8uTq7vPtOTKAmA3dOjx4geLOp37PP0Gee4Se9D3wNf/Z9p6VPaUjjEHOHyk6yfFYBo0MTBt2PuABq5B7JvNhI4ee71U0eWhoQ/zzJ+oPXhPisikcqCoqTq3Zwj31xQ4MZnj1Nx6NlJIcrjJkYHqw=
X-MS-TrafficTypeDiagnostic: MWHPR1201MB0126:
X-Microsoft-Exchange-Diagnostics: 1;MWHPR1201MB0126;20:r6HIvvOw3wGXsG3WoTZtP/QCS5A20gRpgPDdF6fwd6bBtxJljiwUVNx731SM7CX4R4U7FWWfgkT8gBn9oiD/JnRMNi6UzlHuxLxF+stqB9/viZlfi2gsPAql9CY3gl2zWsDE3EGyBe5S0crkulrUQo1GzJIcEc4eb/4OHVM/uKuyiHeNBGfhbK4Mb7tY4+KUHb9YOM9Rk1YiPRhv5FOlPmTeOIeESNv3dEpKqJDNiOm37C/pMNdPSMR0QmmedBZo83kGMf0GBAJ5K4I2URNsWJS7Ewe0r3iEmgMPZe0itgKbbWW7MK0GtoFyQUVgpsmWIbhx8321TCtYL7nc+r4zvCEFIU3yLk8XUUFryBxk2tLk4VDi1Q6vqnpFH4AfW8tujGikOzgJADSqFHfDOu2qTZ0QgKv1QVKam/XwFDE72Cur9SB4oJAGvLFjYjTPFVjHEvjO4ELZsNeawKNsHlJsN02Rb0DpvlMvUycr9r2NMQ5xYyE3dbzW90wGcTyrTW/U;4:uLrFxDmxcio/abg5hqlKeWXq0aB2ijgSQT/4BATgJh14DgW2Z8e888z99ZZLde55rAWYpApHPo9kNkNYtgD6PBgnV2eHqCqV0+RJ4HmtPEEyEzDCz8hT4x72S0+F8MGbPEZs03ev8jTElgjG4lZA1kbU0DxuQ0FchLPvUdEbRkDMWY3iTXOPgiE4qj/2azGmH/83tH9ZJb8oPduUU9KSfN90rdrLYfKKylLENLeDOs3OG8j7NZP9IhTEnUaFuoWxapvv8tdN+Wxqvaj9/8M191uTrs4peQMTxrEJQUVuwN6ZlumAHMQ0uR7KmiNfgzVcw7r2iWvpSkP8arirli7+NwSiRH7kNRi91TbqmLZ4WHB2Op9AEK+anruUR0jjeX7g
X-Microsoft-Antispam-PRVS: <MWHPR1201MB0126E40928238188AE18BADBEA880@MWHPR1201MB0126.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(9452136761055)(767451399110)(217544274631240);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(3002001)(93006095)(93001095)(3231232)(944501410)(52105095)(6055026)(6041310)(20161123560045)(20161123558120)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(6072148)(201708071742011);SRVR:MWHPR1201MB0126;BCL:0;PCL:0;RULEID:;SRVR:MWHPR1201MB0126;
X-Forefront-PRVS: 0652EA5565
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(396003)(366004)(39860400002)(39380400002)(376002)(346002)(199004)(189003)(13464003)(2501003)(110136005)(50466002)(64126003)(58126008)(54906003)(316002)(4326008)(2870700001)(486006)(6246003)(478600001)(65806001)(6116002)(65956001)(46003)(7736002)(2906002)(67846002)(6666003)(97736004)(47776003)(105586002)(305945005)(52116002)(31686004)(31696002)(81156014)(76176011)(386003)(81166006)(106356001)(59450400001)(16526019)(53936002)(68736007)(476003)(446003)(25786009)(72206003)(11346002)(2616005)(86362001)(229853002)(65826007)(53546011)(5660300001)(6486002)(1706002)(8676002)(52146003)(52396003)(8936002)(2201001)(36756003)(23676004)(2486003)(186003);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHPR1201MB0126;H:[IPv6:2607:fea8:3ce0:41b::4];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtNV0hQUjEyMDFNQjAxMjY7MjM6bWVMZE9SRGtLMmZVQklYS2JTWFh1amlX?=
 =?utf-8?B?bGlqZ3RKdHVJNWpVdFRIYkJPVzhBQWhwQ0hzb21zY3FLNWVHYTlmNzl4eHI3?=
 =?utf-8?B?Zm1hZ08xVTl4S0VDNXdoVThyODh2RTN3ZE9WNXNQQi9jUjRwMGdUMWFITHBu?=
 =?utf-8?B?ZE84TklUVGozMWlBa1A4d1U1RXM0M0RlS0FXR283SnlHZSthT0V0aU44dVhQ?=
 =?utf-8?B?SWd0WE9mOTdPb0k5NlQ2MUxKTnJXVGZMaDNVdkQvSTlnMjJjNkF4MmdLUitL?=
 =?utf-8?B?OUZlTDg3RFNwOFlZNEJ1TGdrcEYxZ2lZL0tVMVFaSVFnOFI4aFFDOXVOT2Mv?=
 =?utf-8?B?WUx3SGNWRG81cWgwM1ZCRXhqektCaVRuWG0yOEpJV0Y2Q1B3MmtHdmNrV1Jw?=
 =?utf-8?B?MExWZzFuU2lqbVlhb3pYUzdhK0tUaWJrOWlMTTlKZmZ2bFR0MlZ4SklzN2lS?=
 =?utf-8?B?QU9haHIycWVSa0U0c2ttaDkzenpDZTBmM0tTR2pxb2VYMUIzVlhVQkh2ZFdy?=
 =?utf-8?B?SklmMmZzS0dnUmNGbVpXV05Ma05rdzRDMlljU0VDZ0VSQ2JoYlg5UXVvSzlo?=
 =?utf-8?B?ZEV2ZW5kMVUyeGxVR0FPT3RLNlpGSVVsdFF1OC9kUFNsaEpBaURaUmpuaEs2?=
 =?utf-8?B?T2o1MzkvY1NQcmx2Nkl6bmdrWFR0V0piQlVOZ044NGZlbkt5bnh5OEgzWnBv?=
 =?utf-8?B?RGIyN1VSMkg0UXNwYlRyNXFKK0ZwcFJMT0RVQ0RVVWhjclYxQU5ZTDY4N05J?=
 =?utf-8?B?eENERHhSV3ZDK2htNVJ5cDlISmR2OWlGeE9McllMUFVLMGNlV05vdkdOMTEy?=
 =?utf-8?B?dk1JTTF4ZnAxVEFtUW1nOWtYdm9OTlIzd1g3T2w3Zis1VzAvSWZyNFUzZUhV?=
 =?utf-8?B?STBLdmVxdWg1M3ltRW1MbnNPd0x1Ti9oN3pjNlZadnZDc2RWWTlGTU1wMHZO?=
 =?utf-8?B?aytsREE2RjhaR2pwRElBNW5ka0o4aHE3YUhsY21kWDFzMzRpdkhUdUxYdWtE?=
 =?utf-8?B?cWxrVy9ObFdzN21TcE0xSnprVEhrYU1laFVBNDFadUlYVGZ3TnRVemFFbEV1?=
 =?utf-8?B?VEVoZm1pWnpGaXlYN0RiQnlXc2lqNnlQRnNybmxkOWFCQ0ZuUkt0SEg5dXpI?=
 =?utf-8?B?ZWxxaWZTUm4xRU00cXlMRHovOHNCWjNuNUZNU3p2ZTBxaTl6alBtLzV3bm83?=
 =?utf-8?B?TWlzQU5sa29qbWlkZlJYL0ZXZnN3RFZjc0FEWWFLRVBkbEJ1c1YvVDI0ZWk5?=
 =?utf-8?B?SktjaTB6QTZnSTVuN3d3SW81L211WEVtSytmS1o1LzdhVGVxSlMzT0VoUi80?=
 =?utf-8?B?S3BJSitwT1RGT0Q2ZWFlaDdXUUFNMmJRS3ptWm9jUU94L240RTVoN3dzOHRN?=
 =?utf-8?B?OWRFSkpna1RQazcxRW1mN3MzMzgyYlZqVlFZUE85dVVNUS9zQ25LQ3p4VC9o?=
 =?utf-8?B?QWFWRXdvT2FLcXd3WmI1TFhwYTlRMFhVK3NNRGZxUEoxV2JaMmN5VE5JSWw1?=
 =?utf-8?B?SEdsTDN1dUJBaXNkNFlLMlhFalUvNVJ3MTBoSElhL0ExdzNVd2dybHlnTXJ1?=
 =?utf-8?B?TGxCNFFRanJ4c1hSWGFuZklycVR1KzhRcW5RZVdIZ0tPSUxDN2hUd2VyMEJv?=
 =?utf-8?B?aTMrQ3RSelRpcUxDenpxeVAvcnhqZ3BPbitOMXhuVVoxbFJkbzRtdUwvbHk0?=
 =?utf-8?B?dTIwNWhqNkd1Y1Z2UEt5Yml1U0NzNTNESXhsV2JOdU5pOUcvQnJaenpSdTgx?=
 =?utf-8?B?VVZWbzJkc1BSQzVWVmdRU3Bva05ucHdiQUUvL3o3WTdRdVI3YTFKWWx0UGUy?=
 =?utf-8?B?UnR1UXl1OGNMYjVUMi9UcEdramlGYk1Pc01MSzZ4NnQ3dk95TC8rVlhoWGQr?=
 =?utf-8?B?YWdNOUlGdjgwZVhKOXN2b1JEM2ZLclNLRE00V0wrWnM1Z1EyVG92c0ZPNFdw?=
 =?utf-8?B?WVpYaXAybG85QTF0dVpaOUpwc3FTMmoxdytRdm82ekJEM3o5dlorRG4ydEVa?=
 =?utf-8?B?SmpBKzlBcFNDbGQra3RMRnl4WmcrVHNkT2lwUW5nPT0=?=
X-Microsoft-Antispam-Message-Info: 0lxlV7vWAQy52DUoHYnW3BbCjdveKJEpC29e97z5GPCU4kzXbtX3KiYPCYpiIT7DuQuKeJAwTdzHkFL+Eh/LhhLmJaCrPhoM/mtdhmp753qririeTpYeDuKtqtodJKnKUVl0LzXQY2NYAlyx+iU5bg/T0yc31+PLDOvai9BQN0lg94JlUrLvy45FAASiOo09
X-Microsoft-Exchange-Diagnostics: 1;MWHPR1201MB0126;6:UtnvFZb61jrC4V68jXCNpYuZa1rq8AY80SzteMjBwxN9d91WAhnKzA1FmHusbPvwl58ZPTytVZMa75AoULM1RHs8uTv2y5/wpgxiBEPlcRtd55FxlvCnJfQaZsaTzrewsXpngZUQpdZ+856ZJbBknZlosssneiQ/UfbbODDoodV9Lk2U6QEL/yBRXK69InDLrNPDZ373pyJ/j+ySMtI278wnGdafcYJdNUTe/zKpA6baCqvrADHG865E4nLeaFjGQtT/SWwNu/WeQZANzMTIvKEVZRpXSb8FZTarprJeuq5dOWBThpl0Y5knIwn0TNseZn+7t22Vq60zXYmhJu3omAJrn/NAgFkF9bH12JM0Rp7RbBRAHPEuuZO3jmlG735wbVlAoZWCOCnAVLds5PHiDOdZB47zf1SRyaecLWhJdlYS1XyNki3DKV08ER3sXzwKh0p7l2QjRlSzq4sTo1wX8A==;5:dJVYJU2l9PURYWcdvyA7Kypb8huYijGyvnMxPtR4pba2+UmdjhCcd1bh1zxZ701hg9g3DzQVxA5N1OsqeLH/pK/BfZW5KuRIe61e7HncYENJS91eAczQI/izJEgr4MFq3CCSr/GlQKnBZBwKt9ahHNG7jqTijILLDA04u1pHGEE=;24:6upMDq/buxe851QrhIqV7mlwAGEEEKz1f+5TKOlZyyO4tdclFCRm5rvV74DrWxuxHytegU75GRWJVb5CAYxR/yy3UbQGqaqDAnOVpVNr6xI=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;MWHPR1201MB0126;7:/tjijW82ViJndFlRVYuhf9CogP2VA+zPjkekzCavBu3e1OMa/PgLWD2m/3sNN9U9WDgTGx9YkDXYFL2cGvIEQzqzFrlTrDIAlBnDyZ+u0QLg2e51Mj0rLP/o0F23HMoXX3BCwF3O+f/VjZM8zzBPBYR0fs6jhlzGOCqXijJWWgM4PahstnQ516YpE4vbPVwEzTqsoAb6IST+s9S95ukgd4/m9/Ym4n60uOblqwDtf3JYFK82kNLSpUJ+AMMZrNPT;20:b/LQUWzuxStZGM+1MzLrpUK8Mh13JwGxWZC8orfH6/5+1Mi4MEldNNqySkP9Au3fEOHWFOHBCp50lGoB5va8OVJAvVpzjoWZRLqYO10GtH77uzWWTGmBbY0HTVMyBPGbkLMZYR+EDzzcX/MyJr8WsVbZ0JfhzsLXW9oHj4DjPeCcNG5WDcEUgASc4UEP+u2lKYDNf1pLMpKLaaQnrdCgCLGTFxVar9sbwOLm6JriiWn7DdqepBvt7gAsZyYmoNFr
X-MS-Office365-Filtering-Correlation-Id: 9e274735-008a-4c49-e683-08d5a9fc368d
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2018 15:58:24.7102 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e274735-008a-4c49-e683-08d5a9fc368d
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1201MB0126
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 04/24/2018 11:52 AM, Panariti, David wrote:
> Hi,
>
> It looks like there can be an infinite loop if neither of the if()'s become true.
> Is that an impossible condition?

That intended, we want to wait until either the fence signals or fatal 
signal received, we don't want to terminate the wait if fence is not 
signaled  even  when interrupted by non fatal signal.
Kind of dma_fence_wait_killable, except that we don't have such API 
(maybe worth adding ?)

Andrey

>
> -----Original Message-----
> From: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
> Sent: Tuesday, April 24, 2018 11:31 AM
> To: linux-kernel@vger.kernel.org; amd-gfx@lists.freedesktop.org
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Koenig, Christian <Christian.Koenig@amd.com>; Panariti, David <David.Panariti@amd.com>; oleg@redhat.com; akpm@linux-foundation.org; ebiederm@xmission.com; Grodzovsky, Andrey <Andrey.Grodzovsky@amd.com>
> Subject: [PATCH 3/3] drm/amdgpu: Switch to interrupted wait to recover from ring hang.
>
> If the ring is hanging for some reason allow to recover the waiting by sending fatal signal.
>
> Originally-by: David Panariti <David.Panariti@amd.com>
> Signed-off-by: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c | 14 ++++++++++----
>   1 file changed, 10 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
> index eb80edf..37a36af 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
> @@ -421,10 +421,16 @@ int amdgpu_ctx_wait_prev_fence(struct amdgpu_ctx *ctx, unsigned ring_id)
>   
>   	if (other) {
>   		signed long r;
> -		r = dma_fence_wait_timeout(other, false, MAX_SCHEDULE_TIMEOUT);
> -		if (r < 0) {
> -			DRM_ERROR("Error (%ld) waiting for fence!\n", r);
> -			return r;
> +
> +		while (true) {
> +			if ((r = dma_fence_wait_timeout(other, true,
> +					MAX_SCHEDULE_TIMEOUT)) >= 0)
> +				return 0;
> +
> +			if (fatal_signal_pending(current)) {
> +				DRM_ERROR("Error (%ld) waiting for fence!\n", r);
> +				return r;
> +			}
>   		}
>   	}
>   
> --
> 2.7.4
>
