Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S964856AbeBUOxE (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Feb 2018 09:53:04 -0500
Received: from mail-dm3nam03on0053.outbound.protection.outlook.com ([104.47.41.53]:49637
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S933218AbeBUOxC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Feb 2018 09:53:02 -0500
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Thomas.Lendacky@amd.com;
Subject: Re: [PATCH v2 1/2] KVM: x86: Add a framework for supporting MSR-based
 features
From: Tom Lendacky <thomas.lendacky@amd.com>
To: Paolo Bonzini <pbonzini@redhat.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc: Joerg Roedel <joro@8bytes.org>, Borislav Petkov <bp@alien8.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>
References: <20180215231156.31016.79657.stgit@tlendack-t1.amdoffice.net>
 <20180215231206.31016.78914.stgit@tlendack-t1.amdoffice.net>
 <00583b68-d599-b709-133a-3741c258df13@redhat.com>
 <7f6a78ae-abab-2a03-aebd-e43e6fe168b4@amd.com>
 <94f6ed44-07ab-ff0f-2a6d-b3d8ff4ff4b1@redhat.com>
 <f1b934f4-e228-e6e3-496d-d8287018602e@amd.com>
Message-ID: <d77a8a6e-d10b-82d9-6df4-7ed5505ef40f@amd.com>
Date: Wed, 21 Feb 2018 08:52:46 -0600
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <f1b934f4-e228-e6e3-496d-d8287018602e@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [165.204.78.1]
X-ClientProxiedBy: CO1PR15CA0109.namprd15.prod.outlook.com
 (2603:10b6:101:21::29) To MWHPR12MB1151.namprd12.prod.outlook.com
 (2603:10b6:300:e::15)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 743adab9-2b28-4673-5bb5-08d5793acbd9
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(48565401081)(5600026)(4604075)(2017052603307)(7153060)(7193020);SRVR:MWHPR12MB1151;
X-Microsoft-Exchange-Diagnostics: 1;MWHPR12MB1151;3:+LQg2t/UWUjx86G4pnUVSGli4yQhkxc0lZAqeGCpBwfSdqLMi8RZ9rgIuJURvdSR2GWN49Vk41uvoXzmUrT3ee7pGFuZZY1HHpjr07qZMFNzkbNv3ycmdWdz+33OjqS8uv+FRrLubCrtVtVQ1zrubxL6qNTTO2LrmV5yloHZwxv7edgYpdkVBc+8IBdY1psOcaYlGz1Uzsx+ncQGfjjso2o10gVk1a5F1MTC1nfProaI167TGRQn0pL0j4E8+ure;25:Ytw8LrGomzQEm5P9aINJgfrgM4flYkeOm0SyS3uUYIqm+HUV93vJr0IW1qf94FsAubF+W8ri+cQw+kB0/xRk4tkFrb/SVGFx8hTb267c7ylpPxV7YlIz+Vj7xq26wLDj1sREJq+7j6WYN8niOG1uc+MA3q/Yk7Q/NQzM8TmhRhzT4H97cHRv4tkxUP3y64LBLFGcaaAyoaF2755ql/3NXipU81wMYgwreYGb8TY0hSrg3zqEOTw1pXwzlGW6DsGWOS5yMXXJ39C26uAuDFoETy2j0WdvB9L2PT/1nvqRQKk+iawyZD1AJsI6JFWWQuzXVoWc9gh5QnUjyGKjaY91OA==;31:il+nnyc+fg0YH1ZVptk6aaCpkQEAkuLaBJ+RQg2T3Etk4pCyH1q2HEwPnmZwA42IIGmAdnu1E+BvG8nCkkkYdMPU67PxLIzlsEUEP3ehuzTqcblHv7DCUaJKDT019KRndw8nq5V81I3jG7Y80XtD0QJLDpVF46ZwEi80GJWzHGVi1OJL++po7J7yF35YYTD9IDT2lClxmRVTpUZgmW8j72+xLVRDtgZIJpB+GPGFCDA=
X-MS-TrafficTypeDiagnostic: MWHPR12MB1151:
X-Microsoft-Exchange-Diagnostics: 1;MWHPR12MB1151;20:ZQDyoBUckS4HP/OF39r0ZFqKlrQz6a2HJRfjztJZ6Cgb23xz8ZzkeTHF2QEJ+K07xrDoLwbhpsCkQ0VAokooNh+qsR73tA8kquIvJthKOtKp6Tid9WaCY0LdxBjIyU8MQMTTDitT7WJsciEQnja4PCa6/5FpN6YQuBxIPVHia7VziSz3R8Igm578ZZmZeZYzdedmZzX91CSILjcOe+8vtyzDp5//wZtpPZa427IfeCk5Voi5msTzBLRb8RKuDcDkA7xiGaPkAfxksNbj1nK4maEP8eQ8Btq22p8IRE32CDB0GWud2ZVRsqalGkOLldC/n6o5iSHf+WeO7CNLWQFAGOeL4oidnhvgESwb3Z/u2B1LH8kfeEMLxxCeVmm1i3VlcOiNoulo2Kgikr78WecvMZ1BDAviE86by7q9qN4PFPZxfGPp7/c95cDhsIvmU20XWXwfto9zBsAgZA7Fbd3nPHo0YFKYzqN5KhBt56m9suxBOnTXkQimNxTboxgfgnUS;4:OYSudRHMU3rtNEb9xs/fOM5Pg1tK3Jzb6Jdq9n81oj3cA2kv6aQTTl5LNUR8PF9+4QpMM2juTw3FygAP2JFL1M6T+IdQ/gpYOPIS5VUMPeNztZYgJV8xcrF9hjKNAt65dY0D8RfVJ+sKnnuTlVQAgxEhoGHobBW0h8/jE6ymfL++yb7+RUsae4IiVjxmBvCT2CfkJq2yJ+428FQAd2v/Jojd8PepW0/ap7xBnhttUJCNRgMXuaJqH6IZLbeKa2JNcoBHNr40k5kpnHcWe+g9Zg==
X-Microsoft-Antispam-PRVS: <MWHPR12MB115190E4EFBB6210C4CBB6E2ECCE0@MWHPR12MB1151.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001068)(6040501)(2401047)(8121501046)(5005006)(10201501046)(93006095)(93001095)(3002001)(3231101)(944501161)(6055026)(6041288)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123558120)(6072148)(201708071742011);SRVR:MWHPR12MB1151;BCL:0;PCL:0;RULEID:;SRVR:MWHPR12MB1151;
X-Forefront-PRVS: 0590BBCCBC
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6049001)(396003)(376002)(346002)(39860400002)(39380400002)(366004)(189003)(199004)(86362001)(23676004)(2486003)(52146003)(6486002)(2950100002)(52116002)(50466002)(230700001)(6666003)(105586002)(4326008)(47776003)(31686004)(65956001)(31696002)(66066001)(3260700006)(106356001)(64126003)(65806001)(53936002)(93886005)(97736004)(25786009)(76176011)(386003)(229853002)(6306002)(53546011)(8936002)(72206003)(966005)(58126008)(478600001)(16576012)(316002)(6246003)(36756003)(81156014)(2906002)(186003)(16526019)(26005)(81166006)(5660300001)(65826007)(77096007)(8676002)(54906003)(3846002)(305945005)(6116002)(7736002)(68736007)(6606295002);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHPR12MB1151;H:[10.236.65.116];FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtNV0hQUjEyTUIxMTUxOzIzOmVTbWJqaENmVUdLLzlLK3pPWTI2QktvbmVU?=
 =?utf-8?B?RnF6QlVSYWIyY3JUT1cxS3JLNVk0QUxFbFhJY244Z2M0RkZta3lzSGRFZnVK?=
 =?utf-8?B?UXU3VkR4L0hXSkpUU25lRklsZ3ZoQVd2QVNId3IrYkkvZFZCQW9TRmtyd3dB?=
 =?utf-8?B?T1hrRWhYVGNZeXBua3JkM2w1MFR3QkdsU0R2bDVaY0FmcEpiUWxuZEhwWnE0?=
 =?utf-8?B?cTFRUTcrNTYwcmk5b0ZLUCt0WGFkOXFKVUlvV2lMN0p3QktGM0tML0d5TEF6?=
 =?utf-8?B?UTRIZUh2Rit4ZkRlVmU0U2lWZEx4WE5RRktzMkUwTGdMQVhtWkFaR0ViRmxM?=
 =?utf-8?B?ZlI1QUtmL01mbWpYU0RUWjh2SDNwaFFnUk9yeUthcHVBdWFuQWpWTExpbzNz?=
 =?utf-8?B?MEppeW83bnFrM0hFUTk4dkptL2pDZmI1N21zdzlCaER5RFZRbUloeUR5bENi?=
 =?utf-8?B?RGJOa1FNV2NldXVtMW5YeDNBenRKK0hnWGVVanlmUmxNWjJDRVA1OTkxSG95?=
 =?utf-8?B?b3lidHVCSGlKT3AzUTYwbzFMUU1FNDB6TnVCbFYxVjFkODY2RFU3UFZBc2ZJ?=
 =?utf-8?B?Nyt1L3grbDlDTC9TRzJMdllLdG5adE5EMmYrdVM3SU42bjBJbDVKSGtEa3pz?=
 =?utf-8?B?YjIyb1JFSWYwTmR5WEc1UW9DTnBZa20ycWp2ZjBZdmdDWlc3UTJaY2VTcWNN?=
 =?utf-8?B?SzBkYVR6Vlo2TjBxYi93ZktGZDdJZjFCVDR2VFk1YmJrSFBUcXJwT3JaTkJ5?=
 =?utf-8?B?a2kydmFiU2l0TEgrcDR4ekViL0hOcjU4MkNNYUNwU3ZJRGRHMjlibkNHYkJu?=
 =?utf-8?B?MFdiMkNLcXhuTnhIOU9GbVJOTGFhOElacDBlUTRxRllhVVh2UXdnT2xDZ1oy?=
 =?utf-8?B?RUZjeUJQalJZRGFKS1pnUkxNNlZaQlhYekgweTRQRzFXWm1RN3FlU3VERmlp?=
 =?utf-8?B?M0NvR1NVRkZqbEtocU1iS1B6SzhiMkg0a21RVkI4K0VrcU01TC9sdzJGYXJM?=
 =?utf-8?B?TGRCdkNKa29BdlhyUlBpODA0ZVRKVUx3Q1pUQmR4bU5NcVZCeXFkOUdRdVl0?=
 =?utf-8?B?OCt2MWo3SlRsaHQ2SDVyNUdNRFhQdG95Rlk2UWRvRkNuUS8zdDJHNVVIdkMw?=
 =?utf-8?B?dzI3RUY4bXY2ZUM0VVViR3JEUUlDU1Q5SUpJeWxUekllR2NJaENQc2ZIUWFj?=
 =?utf-8?B?alJ3bHBYUnVPMjJ5cXo1aEgvU0JSTHR4ekZEa29rRTcvQ09MenVjUUtNMlVW?=
 =?utf-8?B?c0d0WFllbi9uZUp2M1ZBNmxGTXNFK0xnWFJVV3ZSblZtcXlVUE1IUHkzK2pi?=
 =?utf-8?B?OC8yTkIyVmtoQ1ArcmcwTEhTNDJjUzQ2YnVwSmF2Y29oc3E1eW95MEo5YjVY?=
 =?utf-8?B?MmpSdVRoTW1tbHVOVTlaSHVuVzhJbHU1WXVaZVpxYm9GQmtrYlR3OG8zV0FZ?=
 =?utf-8?B?c2pqem1YRTVMZ2srK01EeEwvYVRXM1BLRWZDNHZQNzErNklDdDRVOWQ4Wkdz?=
 =?utf-8?B?NCtKYmcxVElLSDNoR0VaaHNjR0piN0VhWFdaek1PbWVFeUVyQW1FWHRNUmJI?=
 =?utf-8?B?VXdyaEw0S2crNXZuTGdUZVBIZ2VteExMZTZ0SWJ5eHFCRHZZbGMzVm5rcmYv?=
 =?utf-8?B?a0xYMktCYzdxazRFTitWcXRHRityNHdOSTFEWkZ1Y010UFR2TDZOUVNZQTUx?=
 =?utf-8?B?SkJNSUwxUDBFbVZPQ0xZNVNYUkpjNVdCR2VoR3dTYnpMNDNTcmZOVzZTYVZB?=
 =?utf-8?B?RDNMSUl6ZUVKb0RkMFFQVVd5akx2aTZ2cFlVR2d6eXBVTHVTcnJyY2o1OG1Y?=
 =?utf-8?B?MXNmclpUU0pmYUJwYjdVVHA3QzZrb2FQMzQ5WkJ1NHBZSXZLSENiMTFoN0d5?=
 =?utf-8?B?UzlEQ2xJVTU2RUpwakJuSmVwV0ltM3k2eGExb3FER1MxQWJBZkhuejEyRUl1?=
 =?utf-8?B?L1hFdjlOVFpCYUxnUDF4NGFsWmNqRnpOb1U5OFIwc1hMR0ZXOXZ4U21ka3Fl?=
 =?utf-8?Q?MzksNx?=
X-Microsoft-Exchange-Diagnostics: 1;MWHPR12MB1151;6:XsFZEnQKgNdAj3GWAoWOujj4pXrfT3DKDSYHhHrAAQ4eAS9CqleqdEiYc2pkWqgWmt3og8YHhWUrrZd+pNgx1+5h1UWRpcVswvbQwMVxiZSClD2GNJ2g1wwIo3fB/6qSGwaJ7kzRSSlvQb3sIfILBG27K7MlrUCPNj2coM/7WoydjuyIUHBnaJ1LXLDucZ4x8zYQHuo4d+LEj/BZN5a3KFGsuB87jGXOPYTIgVOzzO1dwYoVJKjyDkCPGDGLWCOjWCg++rZ14WeYaXLW0uyfplhKnAPjHB8CeSSsDkPafVxGj8L+Kwav7TpKOU53eVrERsSSf4xyUqpTy32DRHxkx3wSIZ3NPvSrce6gCoMkObw=;5:xSe2aJFXWQqunqPqFLUUPO5B3vEjAGafAaiOTEJ/zzEhHfzGFSJSYchOsUDVqV9grui0v4NcCrzctzyGgJGf3qKuta/eCGzz0OxFpTPq7YgqdMvhmTKuOzLSKQtSIZT4Emo0ZhS/M0RMNtOe8tS0c/IFfhjs9wPDFF6BTB6A8G0=;24:TDVInqHob+SI4dyYolYmB8aYCTtvtEk5MT69J05miU5ybqfawfkwesBaObpYQff4KS+eJgVKsDPBnfvUzmyz/5xef55UIoB7vzzNgd/44ks=;7:YTJ/nn1j2Wk4Am47Pa/WmazOLlaW5sy62Cw4B8ooPxB3ls92A+b4AVFLoCA2diONJ3zxOhaabrtlnPbIVp97f8MIYzfDsNhWwxynMRanmJURTfyULYUiiUufbupyLTXeYcaWgSegvcboeQF8AYZegnbEyjFfAHUcGD6vZrqUhcdwja+eM7CV0qeB6+gAw5mEJXL+EynyrN/eveT/HU92clIyZrtYe09dnigmdsHm6snY/4pEnY3Mbe0lL912mG1+
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;MWHPR12MB1151;20:miHHopBDnUVSTrwSJDhrFFQTv4BURY31xUZfzOMGmTRqjOPJnTw3Ty6Kaf7j9vHbwineqenKaS+eDwmrUfsX04fYyFizcffKtOshZ19FaHggfavh370hXa7BDYZgww+4axVVP8pLZ1/3/ESp709+S0JoPWyr+4bQmnnfmDCvW///2+P+tiXWgJuW/hIGMSKFGHhcBlvgisdZ9chMmJwPu23L1WwCHc0+9aJntZAVcBMGzu921v5yt9+YfbRweT7o
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Feb 2018 14:52:56.8814 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 743adab9-2b28-4673-5bb5-08d5793acbd9
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1151
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/21/2018 8:47 AM, Tom Lendacky wrote:
> On 2/21/2018 8:32 AM, Paolo Bonzini wrote:
>> On 21/02/2018 15:15, Tom Lendacky wrote:
>>> On 2/21/2018 5:41 AM, Paolo Bonzini wrote:
>>>> On 16/02/2018 00:12, Tom Lendacky wrote:
>>>>> +static u32 msr_based_features[] = {
>>>>> +};
>>>>> +
>>>>> +static unsigned int num_msr_based_features = ARRAY_SIZE(msr_based_features);
>>>>> +
>>>>>  bool kvm_valid_efer(struct kvm_vcpu *vcpu, u64 efer)
>>>>>  {
>>>>>  	if (efer & efer_reserved_bits)
>>>>> @@ -2785,6 +2794,7 @@ int kvm_vm_ioctl_check_extension(struct kvm *kvm, long ext)
>>>>>  	case KVM_CAP_SET_BOOT_CPU_ID:
>>>>>   	case KVM_CAP_SPLIT_IRQCHIP:
>>>>>  	case KVM_CAP_IMMEDIATE_EXIT:
>>>>> +	case KVM_CAP_GET_MSR_FEATURES:
>>>>>  		r = 1;
>>>>>  		break;
>>>>>  	case KVM_CAP_ADJUST_CLOCK:
>>>>> @@ -4410,6 +4420,47 @@ long kvm_arch_vm_ioctl(struct file *filp,
>>>>>  			r = kvm_x86_ops->mem_enc_unreg_region(kvm, &region);
>>>>>  		break;
>>>>>  	}
>>>>> +	case KVM_GET_MSR_INDEX_LIST: {
>>>>> +		struct kvm_msr_list __user *user_msr_list = argp;
>>>>> +		struct kvm_msr_list msr_list;
>>>>> +		unsigned int n;
>>>>> +
>>>>> +		r = -EFAULT;
>>>>> +		if (copy_from_user(&msr_list, user_msr_list, sizeof(msr_list)))
>>>>> +			goto out;
>>>>> +		n = msr_list.nmsrs;
>>>>> +		msr_list.nmsrs = num_msr_based_features;
>>>>> +		if (copy_to_user(user_msr_list, &msr_list, sizeof(msr_list)))
>>>>> +			goto out;
>>>>> +		r = -E2BIG;
>>>>> +		if (n < msr_list.nmsrs)
>>>>> +			goto out;
>>>>> +		r = -EFAULT;
>>>>> +		if (copy_to_user(user_msr_list->indices, &msr_based_features,
>>>>> +				 num_msr_based_features * sizeof(u32)))
>>>>> +			goto out;
>>>>> +		r = 0;
>>>>> +		break;
>>>>
>>>> I think it's better to have some logic in kvm_init_msr_list, to filter
>>>> the MSR list based on whatever MSRs the backend provides.
>>>
>>> Ok, that's what I had originally and then you said to just return the full
>>> list and let KVM_GET_MSR return a 0 or 1 if it was supported. I can switch
>>> it back.
>>
>> Hmm, I cannot find this remark (I would have been very confused, so I
>> tried to look for it).  I commented on removing kvm_valid_msr_feature,
>> but not kvm_init_msr_list.
> 
> I think this is the reply that sent me off on that track:
>   https://marc.info/?l=linux-kernel&m=151862648123153&w=2
> 
> I'll make it consistent with the other MSR-related items and initialize
> the list in kvm_init_msr_list().  I'll change the signature of the
> msr_feature() kvm_x86_ops callback to take an index and optionally return
> a data value so it can be used to check for support when building the
> list and return a value when needed.

Hmm, actually I'll just leave the signature alone and pass in a local
kvm_msr_entry struct variable for the call when initializing the list.

Thanks,
Tom

> 
> Thanks,
> Tom
> 
>>
>>>>
>>>>> +	}
>>>>> +	case KVM_GET_MSR: {
>>>>
>>>> It's not that the API isn't usable, KVM_GET_MSR is fine for what we need
>>>> here (it's not a fast path), but it's a bit confusing to have
>>>> KVM_GET_MSR and KVM_GET_MSRS.
>>>>
>>>> I see two possibilities:
>>>>
>>>> 1) reuse KVM_GET_MSRS as in the previous version.  It's okay to
>>>> cut-and-paste code from msr_io.
>>>
>>> If I go back to trimming the list based on support, then KVM_GET_MSRS can
>>> be used.
>>
>> No problem, renaming is enough---I should have made a better suggestion
>> in the previous review.
>>
>> Paolo
>>
