Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966828AbeBNEXu (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Feb 2018 23:23:50 -0500
Received: from mail-sn1nam01on0052.outbound.protection.outlook.com ([104.47.32.52]:20735
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752239AbeBNEXs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Feb 2018 23:23:48 -0500
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Thomas.Lendacky@amd.com;
Subject: Re: [RFC PATCH 1/2] KVM: x86: Add a framework for supporting
 MSR-based features
To: Paolo Bonzini <pbonzini@redhat.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc: Joerg Roedel <joro@8bytes.org>, Borislav Petkov <bp@alien8.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>
References: <20180208225833.22074.25995.stgit@tlendack-t1.amdoffice.net>
 <20180208225846.22074.70944.stgit@tlendack-t1.amdoffice.net>
 <45f3c26d-9580-7336-6c74-a0c1cd1e8963@redhat.com>
From: Tom Lendacky <thomas.lendacky@amd.com>
Message-ID: <b0cb062f-4de8-abf3-4977-9e28cdf7d578@amd.com>
Date: Tue, 13 Feb 2018 22:23:42 -0600
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <45f3c26d-9580-7336-6c74-a0c1cd1e8963@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [165.204.78.1]
X-ClientProxiedBy: DM3PR12CA0082.namprd12.prod.outlook.com (10.161.151.154) To
 CY4PR12MB1141.namprd12.prod.outlook.com (10.168.163.149)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 6ee723ba-fa1b-482d-865d-08d57362bd03
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603307)(7153060)(7193020);SRVR:CY4PR12MB1141;
X-Microsoft-Exchange-Diagnostics: 1;CY4PR12MB1141;3:XmCCNPw/4HUbtlP6IsoGgPcqZJQsBbQ2F2/AOah8NXTOX5wJbnO8x5zyG1NWo/krEUTKHerP5bcyGPph0VC0yAGdbUomkTIXGWcNa4OF5OojLimFWFYBdHxE8YSoIUvoNhoH5WXtWkAy62EhfzmkZ4MAZ38CV1BWzuOtEIQf8xG1tpC7hgHdIwcNc78kXQ3iuzsntPBZl78IsPeXLOziNnG/hvm9r74/AnFY5Nfvnx4YKLPd9fdFhGzFbjG8YWQa;25:iXZCJPBwm4DSyswGg3mzXcd3KtOAL+DDSKUvNRJfqG34nUHl8AC1N5D1qGMHcS9lrj8Hw5rOtMFk1Km1IkzLP/AhHJrvZJjkQGSTZI1MOgkyyhfPtdIY9EWgbsWmKLoPMM/JuIoTcFb0Jr+z5PlHu6m4EKaKXBfPkMZVqfmtTa57Dl2wNVWK0e6OO/EYEy15tto0o4c3+sl6q18DEMqS23r0zV3DAM020N6Pb5IeMD6jBsrU3FnR5ecIOS4G7gssVLELWdvpPfOwLN32rv8f4h8a4vK7Hd+PeA6ytptTbOv7XPBSp8LItOLt4s5Izpfs36PonnMbK73cgwqf79mIkw==;31:AnSUc2emuwUxYcOJl1PntI4wSU/0wFimWOEv4gfg8aRctNpMDMomfUQBJLM2JbW3+T6/6JsV7Mm0vHB7WwZjSEEQhqNhtPhBHOhRA8NQLrX7H7UzEz56KIwRt5cxv3D0r5LvenEjuq7j6cbfevDGb5Fbc4DvkU0R69S+/H6g5atNxoVppGz9Yz7mQufodz2PiqsjKnZd/u6LsSaz7qQT79Gl/+aCMQO9rKkNWeQfjF8=
X-MS-TrafficTypeDiagnostic: CY4PR12MB1141:
X-Microsoft-Exchange-Diagnostics: 1;CY4PR12MB1141;20:HOHMwbaGi/HJz5fhweEE6EosaLC1+/1E9IItkvWEAvSTFok9Jb8A3H6My9NVYdrRCFlid4xHa9qm+5FfQMjIROHRyNuQfwLoqSlNG3umq4tjZ884keLxwZHms3d0lD/jMtFOkSkOa6QzuwWY98QCWKApE8PTPPlyfoqt1gPZDuIhh1wpPNWFjfa54lT6Cpar+iGi4MtIsMirD1PNcE1Pt0IHnsHE4NClo7j2Tpb+A+0ocweJXxlI/9avOwuFM97NtLYwH/ishNGvfSIIXA/pIqh/V8VvOwrAx/0998IeIfOOVvVL4POWgMbJKxqJNcwZWFWvx/yLcHlbq7SBjax669AVwwwbLTH0I6ZVW1wM0+RCmAkteh7nMiI7vyRsoXGipUnHLwC/EWi9EgGxCtJKaXjiX8wPp/FeCVA/K5rmusikJ++1u5wvfTHcPR3+X9scLJwMnijNDE8x7cVVz4siCWk9UWaET+cka2WTrOkglyBJ1XVXCv1Ulrsvl1cTlReQ;4:a4pua187VwOTY+v2Ak7xi/i77Th9f0LGSBwuhI1QMGkKMBuRqwAkkYyupNMC0vrhcg0NfJrk6aF0MOBnQEA4f9LeGZ6IhItSAn2psQI/dySjs3W7D9QC/DGGERR4NQ9xZz+hvbrcRjL4Xs+Mi7IQ6/T94cg5wSAqGIeW3Mb1QIHNErCdhxTzYkCWnjPmoh4mrhiH6+1rocvV0EcyheNsjluBAQku1lSU1A3adWSlBkmD3Y97xHUn9nNARWy+OrzsrZ77By6fPKxA/dCoB5kE0Q==
X-Microsoft-Antispam-PRVS: <CY4PR12MB11417BA21EE384E5BDA019FDECF50@CY4PR12MB1141.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040501)(2401047)(8121501046)(5005006)(10201501046)(3002001)(3231101)(944501161)(93006095)(93001095)(6055026)(6041288)(20161123562045)(20161123558120)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(6072148)(201708071742011);SRVR:CY4PR12MB1141;BCL:0;PCL:0;RULEID:;SRVR:CY4PR12MB1141;
X-Forefront-PRVS: 0583A86C08
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6049001)(39860400002)(39380400002)(376002)(366004)(346002)(396003)(189003)(199004)(16526019)(31686004)(76176011)(53546011)(230700001)(386003)(186003)(6486002)(72206003)(106356001)(3260700006)(105586002)(4326008)(25786009)(86362001)(77096007)(478600001)(305945005)(26005)(2486003)(7736002)(31696002)(6116002)(3846002)(23676004)(316002)(54906003)(81166006)(50466002)(16576012)(81156014)(8676002)(47776003)(97736004)(229853002)(64126003)(52116002)(66066001)(52146003)(65956001)(65806001)(8936002)(68736007)(6666003)(2950100002)(6246003)(5660300001)(58126008)(36756003)(83506002)(2906002)(53936002)(90366009)(65826007)(217873001);DIR:OUT;SFP:1101;SCL:1;SRVR:CY4PR12MB1141;H:[10.236.65.116];FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtDWTRQUjEyTUIxMTQxOzIzOnhGcVIvVVBoalF5VE1hamZPa0RCUWhXY0l4?=
 =?utf-8?B?eWRCM0t2bms5N05FNHRSTWFKSnRnYW1uNFZDZVhaR1RrbytJN2I5dENoaXdx?=
 =?utf-8?B?OStTeitSSkhReEVhbjdRcFd4QzllVzc0L3EzSXRaWjljVnpYZEpybTFyL3cv?=
 =?utf-8?B?YXIreFdPZEpaakFWUitsUFl1N3VBaTlMNEVWWW1HVksvR25Dd0xYc3A2N2Ni?=
 =?utf-8?B?RDZjZjd2LzU4TzllTXkwcEtCaktXQTJLTWoxMVhHTWQxbjdyT1I5N2tsMWtx?=
 =?utf-8?B?amhHVHNSQUZKQlJIajBwSmhtd0x0Zy85RUE3V1MreXdTZ1RMc2lzWndsUEV4?=
 =?utf-8?B?MmRvK1gweXVnUlBXdzVtaHUzTDcycTVIQWFOenZ4Sm9GSjBxK0dRT3FDaUhO?=
 =?utf-8?B?dFJnU0RRdloxd0lJdkRmNmtaZVZmRGswMGRYbHVxT1dyd2F2OW55UWhBcnRC?=
 =?utf-8?B?R0lld2NRN0l6TUQzSkNrckw5MlNJZTJiZ1pYNlordG9uY3R2VG1FWFRQVjQ1?=
 =?utf-8?B?eHFoVFM1RnRsNi9VUWVmaExVSk1kL1IwaWtGSmtSeENRSXl1OERUV1hOZFAz?=
 =?utf-8?B?bWMvRmRkYzEyUW5jS2hLQVJJQVh3dG9lQXZMQndMWUM4T2ZoOE1YQlRJVUVV?=
 =?utf-8?B?a3V3emNya09MUDNHNXhXQXVhRU1MMytaN0hqSUFOQ3RhUGZYN1NRRThMNUNV?=
 =?utf-8?B?TCtQU3dES2RrMWFkTzlMVzZVOFBZMHR2ZGRmeGRtY3FoM1hld2d0bVVaZnRO?=
 =?utf-8?B?S0xlMTFSZ0oyRThTeTl4UmJYZUVySUhIanRleEtpdjZkb2lJbUJhditpem1s?=
 =?utf-8?B?anBYUHBTSzJGTTY1NlRxVUErNElTL3pwZ1l0Ujg4SlpGM2w2aXhOMmhoNXAz?=
 =?utf-8?B?RkJjNTZCYkxONURjeDY5UzVDaWNqalhaLzV1ZDRkZnhWTWcvbEdVNmRvcnNn?=
 =?utf-8?B?SnRRanBQaWJGa3BiSHdQMW5aMjhodUl2UG83UldUUjFVU1J1OFV0YWhBQVpQ?=
 =?utf-8?B?WllDdUtsRjZIZUpuOTVXUEgwVXd4Y2sxak9NUnpyTGFHdXpIRlFCUlZTMysv?=
 =?utf-8?B?VGRJS2Y0c0p5TEJOYW9zQVV6Qm1QZG5tNkF0U0RJVXBSZUJnbW1ZRlR3dUVw?=
 =?utf-8?B?OFZ6RVdMUmM5L1A2T3cvZlpvK1dhWGVqZVNkMWFOeHprQW9QWHl3aG0yN21S?=
 =?utf-8?B?MnFNMTR2TGxiMExuTlRCTUpCeUkzczJIS3pXbi9xQzJZT2VjR2hsYW5LV09i?=
 =?utf-8?B?QlhMNGRUMVhTeGpmdE9LSUl5d1VHYmJkSDdwVTlKK2dCaUxJQVJYcWlPYkty?=
 =?utf-8?B?T2s0ejk5eUYxcWRqa1hud2RtV0xZSkkzSnhLZ2tyRHJrMjJqaHAwZkt0NGVi?=
 =?utf-8?B?RUh6UXFWZlE1a0ZTdFVZWmphMlQzdVJLcGJvUUdacXNNY24xMjluL1hmdDNL?=
 =?utf-8?B?eFJQOTgxWGhwa3AyNzQzck5yVXhhcUI4c2U4aDA0M1NvbjVicFdwemJjb2Zi?=
 =?utf-8?B?NDkzSDBrdEhyZUZwVzhjMXR5WXJ4RnZpdVNyME5OUzNLY1lrdEFTdWxxNVFV?=
 =?utf-8?B?WkNGcEJxN21abW1iTGFSMVVpT2w5V1ljbFBIS21CRkFnQkQxeEltUjJHVTZ2?=
 =?utf-8?B?OWwxTDAwSjFlZ24rSFRHbnN5VVVJb1dwNE9nOThyNEMwUDRjaTgyVFM0Mk5j?=
 =?utf-8?B?QkNDdWtQQ1BzUW1mc2ZRcnNpQmFEL3hYT3JwalpWMkQrOS9aaU1tZldnTXFv?=
 =?utf-8?B?R1ozaE1KUFZqb1c5UUhQSlg3VlczSmlIZ2Y5NjBQZXA1aVB4L3NEcXl1QldP?=
 =?utf-8?B?SU9uaWd3Ykc3MXR3ZHBVSnlUWVFCN1RwR3JXVTl6MFRYMmRjVVYrckZqMGxm?=
 =?utf-8?B?aWtaQnlyT1JaOGI0UXRoRTFYTHZlY1dCS1VHQjBJa0hwb00vSWE5SmhjRG9l?=
 =?utf-8?Q?qoBrwRgrCW9uCaXTDGY5/lCkBjGAVM=3D?=
X-Microsoft-Exchange-Diagnostics: 1;CY4PR12MB1141;6:YJ3zjGqUC16ODRYaZNw2Jl6JCaAKWFgco+f3GmQ1EBuQm3qtMDfUCXA9U6P6BiPcWmaE1DGhLSdtXuktqj0IKmvHpEI9m3vdCbjCwsqX9gKQVWWAIELocBzQVrToXZ4HwqaEgFHM36rc3N+y/L60BMyeaXTAGmukXlQT12Piy6Sr+4thcGgMemdHAu43If+++hPVnXXwOpPcj5gOFBPAzyFJqmgwX8dXBtkgLd/cQqWiZlX5YYdHfCitz/C33DU6joRhWp9BuJyUeFr/5GtBv9Ci++ZrZbqMuLd80GipH8zhWEtIY7g2tzXqbR1r4J8QwSgWBEKzK95VXVPRavLPuZqGqJ0XFPFFFRJaLBFdBiI=;5:utoUNpvoT+LCLm5bIwSbIOd32Xg0mA7sfIS1QUsXsmoMgwOB60Rg9Kke+WnNw3RUtA6aAktaQHePsjTkWuU8JuJOkZTDBSkfARDsY1+frsgOS8in0DmeKUApYoUzqK31p4gbjJuDZrVkkJMcsyzz3KHZl7deiGnazbmQxMiQhN8=;24:xJtteGXpM+Y30z40ccVf0a5saQUamaoi4da0J39r6kqOv0HCyi0/533GY4qZG/qr0uGDGR49Nkjlgl9mWpvc7A/PnsYXL70AO/A/ESXuXf8=;7:eUvhdk4918myotXrT04GCxAQSc3b/6QjX8GZLLZ3k7Bc1/gv1qBT4lvKk767oRUF7E1rJC2l0El9KoysSCK6UTW0VJ21TwKQ0SRIyJd2K1vQmJtvuhbY+y7kvgZncaT3kDZDkR31CttTDZR/OOPITI48iICtASGVgLVaTPKwtX8Q++43s0DqQOczT1xIVzXOb/ES8mmrRvf5SzNdnfushE1M3VmU4d9wtSmWwVAXcYm1WloLrC8F5q8LANyNwktC
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;CY4PR12MB1141;20:CRYDti+km4yzucgokjUkP+adFRGO13Xbtp0D8+igK7iVaiXRT6YK38ulH8fDXiVh/2ByY05YQ0fhSqGPKubZ+uGjqogA7nBIAXUYPU27qYau3afxk57PVb3/2feIdnfE7WOYLGQwt/9f8xM6WA5RJvhfrxkg8qgyXUoXB1pLQHcQPE+R2n0CCOfDWT/9B0WjDc6MZ41wMlYC2ZXdNOmHSziHvzgvsDHZNxnNojeFa61g6cMgEc+GkfWA+D+Mc2uI
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2018 04:23:45.3532 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ee723ba-fa1b-482d-865d-08d57362bd03
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1141
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/13/2018 10:21 AM, Paolo Bonzini wrote:
> On 08/02/2018 23:58, Tom Lendacky wrote:
>> Provide a new KVM capability that allows bits within MSRs to be recognized
>> as features.  Two new ioctls are added to the VM ioctl routine to retrieve
>> the list of these MSRs and their values. The MSR features can optionally
>> be exposed based on a CPU and/or a CPU feature.
> 
> Yes, pretty much.  Just two changes:
> 
>> +struct kvm_msr_based_features {
>> +	u32 msr;			/* MSR to query */
>> +	u64 mask;			/* MSR mask */
>> +	const struct x86_cpu_id *match;	/* Match criteria */
>> +	u64 value;			/* MSR value */
> 
> 1) These two should be replaced by a kvm_x86_ops callback, because
> computing the value is sometimes a bit more complicated than just rdmsr
> (for example, MSRs for VMX capabilities depend on the kvm_intel.ko
> module parameters).

Ok, I'll rework this.

> 
> 
>> +	case KVM_CAP_GET_MSR_FEATURES:
> 
> This should be KVM_GET_MSR.

Yup, not sure what I was thinking there.

> 
>> +		r = msr_io(NULL, argp, do_get_msr_features, 1);
>> +		break;
> 
> 
> Bonus points for writing documentation :) and for moving the MSR> handling code to arch/x86/kvm/msr.{c,h}.

Yup, there will be documentation on it - I wanted to make sure the
direction was correct first.  Splitting out msr.c/msr.h might be
best as a separate patchset, let me see what's involved.

Thanks,
Tom

> 
> Thanks,
> 
> Paolo
> 
