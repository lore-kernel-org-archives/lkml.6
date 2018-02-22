Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933057AbeBVPgY (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Feb 2018 10:36:24 -0500
Received: from mail-co1nam03on0047.outbound.protection.outlook.com ([104.47.40.47]:27870
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932902AbeBVPgW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Feb 2018 10:36:22 -0500
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Thomas.Lendacky@amd.com;
Subject: Re: [PATCH 3/3] x86/microcode: Quiesce all threads before a microcode
 update.
To: "Raj, Ashok" <ashok.raj@intel.com>, Borislav Petkov <bp@suse.de>
Cc: X86 ML <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@kernel.org>,
        Tony Luck <tony.luck@intel.com>, Andi Kleen <andi.kleen@intel.com>,
        Arjan Van De Ven <arjan.van.de.ven@intel.com>
References: <1519231784-9941-1-git-send-email-ashok.raj@intel.com>
 <1519231784-9941-4-git-send-email-ashok.raj@intel.com>
 <20180221190611.GE16888@pd.tnic>
 <20180221201308.GB14170@araj-mobl1.jf.intel.com>
From: Tom Lendacky <thomas.lendacky@amd.com>
Message-ID: <533adfd7-1ca8-1e3c-87f6-d92d172c6f9d@amd.com>
Date: Thu, 22 Feb 2018 09:36:08 -0600
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180221201308.GB14170@araj-mobl1.jf.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [165.204.78.1]
X-ClientProxiedBy: CO1PR15CA0092.namprd15.prod.outlook.com
 (2603:10b6:101:21::12) To MWHPR12MB1152.namprd12.prod.outlook.com
 (2603:10b6:300:e::16)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 860fc800-786d-4896-fa96-08d57a0a0518
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(48565401081)(5600026)(4604075)(2017052603307)(7153060)(7193020);SRVR:MWHPR12MB1152;
X-Microsoft-Exchange-Diagnostics: 1;MWHPR12MB1152;3:gPHlCdzxCwDuQXMckzC1PFeDHJjG0FKJn+k6eObaV66LgQ7haRsGSL3j54yrR1F3TqIGwrkz/sOzezkJNHxXbWoLt+VEJ2M85XPCgO5o4B9aMF3GuuSddYHl6piTyrctkJrO2M0gZ+Ysjx73i4t6sqiDGaIm1ehPfVnhQx11Kgfi5WRp+gpci0bRKlc65L9bKi0eko1FcjwbhBruomLP25Os2c9tdyFGWtSBBupKjvzG3CXFP70qZPSOBnYdtA+g;25:yddPjL82WvtKNTjOvwR0qZbqBallOk0ywx4YNQw1eRTmuoZF4PT9yGcKn6ICKhi/jsXPsw0Ws3V97E7mVR1GutXCImCfQn0E2otkjG1rohrw8z/tk49BSUJjRxjDtrkcGrRWA2rvdYaqCaZYhIyqdpwbjEXXQ87em6g0Vf9bDyT9T8JIjBPGRNOn2HiAB8Wlx0g+3rvQRwGwpnWDb9dHlW/1FTQ7IGMsT9rpVGW6d90xHE4J/Fo8a0/SZ28FYwBGCFuFFp822Q9GbIWQEjQn7HLqIbK+SNYVEYRkONDNYwkIiCLZ1sbxkDPhM++EHzqPaLV7rlOddsleGr98gKMjNg==;31:AErAHH94wEMR+tlGzHcuYCmqfRN0rOKJ9yMtmXPsVrDcs0R3cv7zupOyrnfxpKg869t5T3BHYTOpV1nsxD/iRfRhRHZ4YSos7jMfprzRhSUlZRbyzKvqcC7Xq0LM5j9mg+xHl+domFwh71bA2ABKIHfInMFleqT2nGJ+2modbwLTOpzcv5Fec7Qx8UdEQl38JchlgLs8gVqFK9AY9n3ecYCcApKk2Bcnz9dO/0KhDYc=
X-MS-TrafficTypeDiagnostic: MWHPR12MB1152:
X-Microsoft-Exchange-Diagnostics: 1;MWHPR12MB1152;20:NMRCRMA0pLOS1t3klzirPoANiFU6qTGM5rbC98hnUyq16s690IYsbfX3DruoDsuBio2uiQ2U5f1eVnZpvCYE+3IvW5glxRWRzgXyUY1QnphiXjRa+lxZIX1/JiE05x5ro0wKVFVdr46/Bmka59gQDry9y8K7+7Q0xOaPneRGHr31lYjFBIuthQkHTVmyL5ikvpgVKBaI6i4Ll8gG0nJOGfkY/f7lIKlatKHWn6BVRoXKgWyBHLADnYMx8ngR8Uak17NbsIRhZEGgbkq+FN6ATHYkrZaaT0JOzsq2wWQXdGtdq7i5LT/DhvERkOFp9Q1J6pw3NCPaqxQXwWxPiM1YfkhwfdYBIOlW1m/EGbmdiNoQGwcFfC+SiSehv72l9XTDCCTkknohrA1ecBzBQP3v72ykqAmiI0KaWH89Hqo9M6trbBuVRyJXwPRhieduXL1a97cCSVF4K62izaF93rNP1x8ukaN6gijY/MVQg3QGkbpH6tlap1f2EnH5XukcOKmS;4:yw4ImkNORbAd6nloKnYe2bXqKWuyoFVMzWnKTVhZNVwrftXXLHVE5mxAxr7Z1eWyhW6FJ401ibZAvovqNYAiw6UpqjiehWtqpl7fVMnt7VAApWBuaa05Vw2jbHDguGDhSu8nQRgR23uKKPCpYZH/+NMdHjSMHtlmC6AlOMulaPF8cGPXuwPL6HwNTHi4EI7dRim/7SUPl+1IDYINZLZJSoGItDv/TD3x2Qf69KeWZGQbaO4AgWu8NPaPj7dpF1pgs23SaYb75FK9OCu2Sv3flZGdEIrV0z5IQJQ2ZC7cVX1V60NUX8/4PBfPfgMdHLmQ
X-Microsoft-Antispam-PRVS: <MWHPR12MB11526E8DDE86E177815A6284ECCD0@MWHPR12MB1152.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(209352067349851);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001080)(6040501)(2401047)(8121501046)(5005006)(3231101)(944501161)(10201501046)(3002001)(93006095)(93001095)(6055026)(6041288)(20161123558120)(20161123560045)(20161123562045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:MWHPR12MB1152;BCL:0;PCL:0;RULEID:;SRVR:MWHPR12MB1152;
X-Forefront-PRVS: 059185FE08
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6049001)(39860400002)(366004)(346002)(396003)(39380400002)(376002)(51344004)(199004)(189003)(64126003)(6116002)(25786009)(3846002)(3260700006)(36756003)(186003)(229853002)(305945005)(575784001)(86362001)(77096007)(26005)(8936002)(16526019)(106356001)(68736007)(15650500001)(31696002)(59450400001)(105586002)(7736002)(93886005)(386003)(65826007)(97736004)(53546011)(23676004)(2486003)(52146003)(81156014)(50466002)(2950100002)(81166006)(2906002)(47776003)(2870700001)(5660300001)(478600001)(52116002)(4326008)(8676002)(6246003)(53936002)(110136005)(58126008)(65806001)(66066001)(16576012)(72206003)(65956001)(6666003)(54906003)(31686004)(316002)(76176011)(6486002);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHPR12MB1152;H:[10.236.65.116];FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtNV0hQUjEyTUIxMTUyOzIzOldtL011bFMwNllZbmxvUlpJRTMzc0FtVnkx?=
 =?utf-8?B?NEVFS25ORkdMWnVTVksxUXhaN3hGNWh1SHF0dDM5ZVpjRzdVUFkrU0t1Qm9t?=
 =?utf-8?B?Q2daTkxId0pZU3BIZmJTNW5sRDBJbXM2eWFvSzB2TEpCS0xNWUZYeXE0djNs?=
 =?utf-8?B?UjQyVjA2WHFWL0RIZ2xvK25RaytpMVRZN25hRDcvWE5ReUUyeWZ6LzJ2Qzl2?=
 =?utf-8?B?WkYyK2dRanoyWDBHOWg0anFPYTUzVmp0d3RWZnRSa1FRY1VGbWpQcnFsek1T?=
 =?utf-8?B?a01TMytwV1RRQk0vNlNQZXNxN1hJOEJUNC8zaGpydkFuRDNSblpWS21MN0t5?=
 =?utf-8?B?bm5SYVZLdmxwYkRQWFpFRG04Q29pYzIxTmYrbHhNVzIwUW1uMTlzTk5UQ3R5?=
 =?utf-8?B?Z0hlRE5JeTRrSGt5VXFGU3owMHB0VkEzN29zRExNY3RxNTlMdDRRYmUzcTZD?=
 =?utf-8?B?VUhXbktIQkcyajg4cWhDaWdPL0cvWE5KTVdtZzk0QjlEUUgxOFdEOWoxTTA3?=
 =?utf-8?B?VzkyZ3drY09qcUZZMzA3UDFDd0xwQjhkTFRlZnkvRzVXT3pXWEJ0Q2JaWkFK?=
 =?utf-8?B?VTlRcHByeStJT2JRemNLSVh2WjRGYnAzN2xSMWhZZFhzKzAyZkdZOUVZakk3?=
 =?utf-8?B?NmxyMnBObFJWOG1IMnViT1cyUVMzL2U1SXZrSkY0c3FKNlJRNGcrNU95M3Vw?=
 =?utf-8?B?NUVwdC9IS3dBQXJWQ0FucTZla0tEeVc4dFlwakRLOVY1ME02Mnd4K293UmEw?=
 =?utf-8?B?VmlmcSs3OHQ5d2kxQ3lQa3FyMUg4aXYzN1hjWWJFaTVNbkpENkRtV04rQ2ls?=
 =?utf-8?B?b2lKTGxCL0dQZlR0b0VIR3YzeEpzdjZ2bkJDbENSd2ZrRDVKbzBvMXkrdFBi?=
 =?utf-8?B?TkNMbWxJQUhEOG9jdWNhTng1b0diRUJzaHRsaUV0eVhBQ0dRNW9WR0JaTFo1?=
 =?utf-8?B?eGNWS201azJ4UlRPMExLNDA3UVZCVC9ieDFRa3ZjbWMvYW5TVnY5RWhLY0Nm?=
 =?utf-8?B?Z25lMHRldnNsbXQwdmZmYk5MelBqaDRxNFZOcWdRbzlSZDUyUzlwNmNMK1hB?=
 =?utf-8?B?UlJwOFpQNE5sN3owRWtoNitQOVFMc2xJc1B1WEs2QVJUTVAxVUgyVHY5OERl?=
 =?utf-8?B?Uk1RTTFzdHZGZ29CcXpGQzE0TnN2eGY1bnpob2w4OGdZa0JrNmFjSk5FZ05K?=
 =?utf-8?B?cmxqZlhEbVM0SXFieDZPd0VBc0FrRHhXdUpTdGVSVWplajU1WXlpU1pYY3h1?=
 =?utf-8?B?bTRmMFh5bmw0ODZtYVFsY0M1a3VEbkxBcU40V25BMVVHaklwRmp1dndKZzVJ?=
 =?utf-8?B?QllhWWJpOFUwQWJ4ZGFFc1B4RWZBT3VYVEZIUE9SVnJtU3lWMFdHMzJoMG1q?=
 =?utf-8?B?Z0ozdEMrWHMyME5kVGdQZFI3TlI1ekVacTJ6NmtTQitCSTVvamF5UjlGdE1a?=
 =?utf-8?B?UE9tWXlmZFBEVkk2alZiUEd1d3F4SUI0cDFpSUFsS0hONTFHTlIybDcvcDAy?=
 =?utf-8?B?cVFUemJKN0ZwZVJYcWhCZDg0bFQ2YmZVdkVISTFNM3ZnaWxLZ1JXNjVDUTJD?=
 =?utf-8?B?SnRHOURmZUpJZTNjWDlneU5YTEFDa0dpVWdsbng2dTkvZXBSdUl4N2JFTVNJ?=
 =?utf-8?B?MVNxK25Mb2M4eFFuT0VlTE52RFRYdnRSWFIxbDc4T1hpSVU0eHlCOE84QzUz?=
 =?utf-8?B?TnJ2Nm50Rjh4dS95MEJ4d3JRSkhBdHFaVjV4M2VJR2t0K1NtWVVqenNtK0F0?=
 =?utf-8?B?andrNXc0Z0JkdVNSOEVmT054OCt2ZjByS1NMSDNkZmMzSEFKVU1rT0pURmY2?=
 =?utf-8?B?N0FURnhpbEdraVRkVDFzTUU2Mkt1S0xmZVZURUVHbCtOSXRxNXBHSkRWTFN3?=
 =?utf-8?B?dWdCSTMyaS80WjUwTVUwaGVpNkl5WWhPTFVJKzV0Y3kvR25RU2h4VlRkSXJ6?=
 =?utf-8?B?Y3RyRmo3K2cxbHJ2V1pSZFFoTWFCVUxrQ2haQmp4RU9hdUNxVGhpMHhLTFNj?=
 =?utf-8?B?MDF5bGtxOThSVXZFWS9DWFgxMFRaMklCVlAvVURGZ0tFN1U2RXpFWnY2MU5F?=
 =?utf-8?Q?4raerWGDwrNIBwyFnc0lZUqdM?=
X-Microsoft-Exchange-Diagnostics: 1;MWHPR12MB1152;6:uauaCOTJCvYAm68EWmGh68fNvkfBW2skty/rbOuVtLEMVGDj2Pi4OqjO2Vc3bcHkEb/JMVbYSw8DNHUQUxAMLw6AOUHacJS6qq3pcv1w/qb7qCxR/Hv/VO3bfRaFopg+FoECEhz4wTaJZBqASbywGscpw0y2XHca9iU3p67b2v6UFn78dp51QxJKsbVCTGRrl1vTSNtR4cuFQ6NjxkKcIT9bHbs6ByCNlXmB0BKMXwEOVKNjm5wl4H006GX+mSIfDDcy0/A74HcOTpl6s7//D7MRRnClyrBViieTumzAJxLAnHCM4Fn4wYyATkKS5Yt36PCHJ4FIHpC65iLLvggclcvGk20dDI+Lsw51NtZswTg=;5:n/IKhlsGE8nx+Hg6o3yvAZUDJQS2UzpZxyAw1Gr+lP+QKUYXv4+UXoxVDQ9LjigS1HEddZvOHovtuAOnMcmLhGXnW3+X88oXTyZfJA/3XpKSShdlWDSMC+pOIrX6/zlZ5aXhWrB+dz/N8ikKoEBGseqKjjtuf5K9wYcgAOxzrjU=;24:fOzPKcLF+xk1azalP7q9KUBDtGqutSI+ny40FQa8jo407j0jzc92kpXKBrmMXs1pOY2dcL8Q5V0B8ljr2lVZXOpr4YABFMKNpbwDAEOeUeQ=;7:ZdRQ5g/TbLrltPXdQP26Nt2QoqM5FGFE9YDSChFe/1vZbyXubUfq5a+ErWJr/80l7EnfyHndgAI3L67mne/Y+E9F3KlaWbetu4UApo7Uq48c7YmR1VD1p1eDZMt+zU6HwHGj/PxLuX74YCwEDzYhnpr6PxUVFz0zv246xD/e0R6u8KoHgoTSokntnbBQYV/OpV1qVt5H8Nx7f6yU3Okt1ahk845Vab9qsSJnaAm99nNAxDLmtj/30PeRWTrVLBsV
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;MWHPR12MB1152;20:Isqt1J1wafF2OjXCSLGawQsQsgeXwst+aiv4N8ObbZqU2J8Ww0HABa9fNykzIZ84gsJaNWdhVsPOMIDiCLpIbM33oiPpDw+Plqs/li9MkhK0iVLZ1gE7z+2ibxnXiNPrd5vUZLUk3/wytGNzwA88sbTNnoK0A+VwJWSSS/9dMEiruzQIqZUSELIJPTKomKJCe1gs0gXNaQ9/dKA9p39EBaD5Ck4nk/YULpDqeXvHn0KKMBswn37Pn8UFETwAGbw2
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Feb 2018 15:36:18.7202 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 860fc800-786d-4896-fa96-08d57a0a0518
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1152
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/21/2018 2:13 PM, Raj, Ashok wrote:
> On Wed, Feb 21, 2018 at 08:06:11PM +0100, Borislav Petkov wrote:
>>>  arch/x86/kernel/cpu/microcode/core.c  | 113 +++++++++++++++++++++++++++++-----
>>
>> This is generic so Tom needs to ack whatever we end up doing for the AMD
>> side.
> 
> Yes, i did ping Tom to check if this is ok with them.

I did some testing with these patches and didn't notice any issues on my
EPYC system.  At the moment, I currently don't have access to anything
older on which to test.  But I don't believe there should be any issues
with this approach.  I'll retest when we get closer to the final version
of the patch.

Thanks,
Tom

> >>
>>>  arch/x86/kernel/cpu/microcode/intel.c |   1 +
>>>  2 files changed, 98 insertions(+), 16 deletions(-)
>>>
>>> diff --git a/arch/x86/kernel/cpu/microcode/core.c b/arch/x86/kernel/cpu/microcode/core.c
>>> index aa1b9a4..af0aeb2 100644
>>> --- a/arch/x86/kernel/cpu/microcode/core.c
>>> +++ b/arch/x86/kernel/cpu/microcode/core.c
>>> @@ -31,6 +31,9 @@
>>>  #include <linux/cpu.h>
>>>  #include <linux/fs.h>
>>>  #include <linux/mm.h>
>>> +#include <linux/nmi.h>
>>> +#include <linux/stop_machine.h>
>>> +#include <linux/delay.h>
>>>  
>>>  #include <asm/microcode_intel.h>
>>>  #include <asm/cpu_device_id.h>
>>> @@ -489,19 +492,82 @@ static void __exit microcode_dev_exit(void)
>>>  /* fake device for request_firmware */
>>>  static struct platform_device	*microcode_pdev;
>>>  
>>> -static enum ucode_state reload_for_cpu(int cpu)
>>> +static struct ucode_update_param {
>>> +	spinlock_t ucode_lock;
>>> +	atomic_t   count;
>>> +	atomic_t   errors;
>>> +	atomic_t   enter;
>>> +	int	   timeout;
>>> +} uc_data;
>>> +
>>> +static void do_ucode_update(int cpu, struct ucode_update_param *ucd)
>>>  {
>>> -	struct ucode_cpu_info *uci = ucode_cpu_info + cpu;
>>> -	enum ucode_state ustate;
>>> +	enum ucode_state retval = 0;
>>>  
>>> -	if (!uci->valid)
>>> -		return UCODE_OK;
>>> +	spin_lock(&ucd->ucode_lock);
>>> +	retval = microcode_ops->apply_microcode(cpu);
>>> +	spin_unlock(&ucd->ucode_lock);
>>
>> What's the spinlock protecting against?
> 
> This is ensuring no 2 cpus do ucode update at the same time.
> 
> Since all cpus wait for all the online cpus to arrive in stop_machine handler.
> Once we let go, every cpu tries to update. This just serializes against that.
> 
>>
>> We hold the hotplug lock and the microcode mutex. And yet interrupts are
>> still enabled. So what's up?
> 
> hotplug lock/microcode mutex are at global level, these are 
> protecting individual cpus in stop machine trying to update microcode.
> 
> these are called while in stop_machine() so i think interrupts are disabled IRC.
> 
>>
>>
>>> +	if (retval > UCODE_NFOUND) {
>>> +		atomic_inc(&ucd->errors);
>>
>> You don't need ->errors. Simply propagate retval from do_ucode_update().
>> Or compare ucd->count to the number of CPUs. Or something like that.
> 
> That's what we are doing here, but simply returning number of cpus
> that encountered failure instead of a per-cpu retval
> like before.
> 
> I use ucd->count to use as an exit rendezvous.. to make sure we leave only
> after all cpus have done updating ucode.
> 
>>> +		pr_warn("microcode update to cpu %d failed\n", cpu);
>>> +	}
>>> +	atomic_inc(&ucd->count);
>>> +}
>>> +
>>> +/*
>>> + * Wait for upto 1sec for all cpus
>>> + * to show up in the rendezvous function
>>> + */
>>> +#define MAX_UCODE_RENDEZVOUS	1000000000 /* nanosec */
>>
>> 				1 * NSEC_PER_SEC
>>
>>> +#define SPINUNIT		100	   /* 100ns */
>>> +
>>> +/*
>>> + * Each cpu waits for 1sec max.
>>> + */
>>> +static int ucode_wait_timedout(int *time_out, void *data)
>>> +{
>>> +	struct ucode_update_param *ucd = data;
>>> +	if (*time_out < SPINUNIT) {
>>> +		pr_err("Not all cpus entered ucode update handler %d cpus missing\n",
>>> +			(num_online_cpus() - atomic_read(&ucd->enter)));
>>> +		return 1;
>>> +	}
>>> +	*time_out -= SPINUNIT;
>>> +	touch_nmi_watchdog();
>>> +	return 0;
>>> +}
>>> +
>>> +/*
>>> + * All cpus enter here before a ucode load upto 1 sec.
>>> + * If not all cpus showed up, we abort the ucode update
>>> + * and return. ucode update is serialized with the spinlock
>>
>> ... and yet you don't check stop_machine()'s retval and issue an error
>> message that it failed.
>>
> 
> Will add that 
> 
>>> + */
>>> +static int ucode_load_rendezvous(void *data)
>>
>> The correct prefix is "microcode_"
>>
>>> +{
>>> +	int cpu = smp_processor_id();
>>> +	struct ucode_update_param *ucd = data;
>>> +	int timeout = MAX_UCODE_RENDEZVOUS;
>>> +	int total_cpus = num_online_cpus();
>>>  
>>> -	ustate = microcode_ops->request_microcode_fw(cpu, &microcode_pdev->dev, true);
>>> -	if (ustate != UCODE_OK)
>>> -		return ustate;
>>> +	/*
>>> +	 * Wait for all cpu's to arrive
>>> +	 */
>>> +	atomic_dec(&ucd->enter);
>>> +	while(atomic_read(&ucd->enter)) {
>>> +		if (ucode_wait_timedout(&timeout, ucd))
>>> +			return 1;
>>> +		ndelay(SPINUNIT);
>>> +	}
>>> +
>>> +	do_ucode_update(cpu, ucd);
>>>  
>>> -	return apply_microcode_on_target(cpu);
>>> +	/*
>>> +	 * Wait for all cpu's to complete
>>> +	 * ucode update
>>> +	 */
>>> +	while (atomic_read(&ucd->count) != total_cpus)
>>> +		cpu_relax();
>>> +	return 0;
>>>  }
>>>  
>>>  static ssize_t reload_store(struct device *dev,
>>> @@ -509,7 +575,6 @@ static ssize_t reload_store(struct device *dev,
>>>  			    const char *buf, size_t size)
>>>  {
>>>  	enum ucode_state tmp_ret = UCODE_OK;
>>> -	bool do_callback = false;
>>>  	unsigned long val;
>>>  	ssize_t ret = 0;
>>>  	int cpu;
>>> @@ -523,21 +588,37 @@ static ssize_t reload_store(struct device *dev,
>>>  
>>>  	get_online_cpus();
>>>  	mutex_lock(&microcode_mutex);
>>> +	/*
>>> +	 * First load the microcode file for all cpu's
>>> +	 */
>>
>> It is always "CPU" or "CPUs". Fix all misspelled places.
>>
>>>  	for_each_online_cpu(cpu) {
>>
>> You need to fail loading and not even try when not all cores are online.
>> And issue an error message.
>>
> 
> When we online any of the offline cpu's we do a microcode load again right? 
> 
> I did check with offlining 2 threads of the same core offline, then reload with a 
> new version of microcode. Online the new cpus i did find the microcode was updated 
> during online process.
> 
> Since offline ones don't participate in any OS activity  thought its ok to 
> update everything that is available and visitible to the OS.
> 
> If BIOS has turned off cores due to some failures and didn't expose
> in MADT during boot, we will never get a chance to update online.
> 
>>> -		tmp_ret = reload_for_cpu(cpu);
>>> +		tmp_ret = microcode_ops->request_microcode_fw(cpu,
>>> +				&microcode_pdev->dev, true);
>>
>> This needs to happen only once - not per CPU. Let's simply forget
>> heterogeneous microcode revisions.
> 
> Sounds good.. let me take a look at this.
> 
>>
>>>  		if (tmp_ret > UCODE_NFOUND) {
>>> -			pr_warn("Error reloading microcode on CPU %d\n", cpu);
>>> +			pr_warn("Error reloading microcode file for CPU %d\n", cpu);
>>>  
>>>  			/* set retval for the first encountered reload error */
>>>  			if (!ret)
>>>  				ret = -EINVAL;
>>
>> You can't continue loading here if you've encountered an error.
> 
> Sounds good.
>>
>>>  		}
>>> -
>>> -		if (tmp_ret == UCODE_UPDATED)
>>> -			do_callback = true;
>>>  	}
>>> +	pr_debug("Done loading microcode file for all cpus\n");
>>>  
>>> -	if (!ret && do_callback)
>>> +	memset(&uc_data, 0, sizeof(struct ucode_update_param));
>>> +	spin_lock_init(&uc_data.ucode_lock);
>>> +	atomic_set(&uc_data.enter, num_online_cpus());
>>> +	/*
>>> +	 * Wait for a 1 sec
>>> +	 */
>>> +	uc_data.timeout = USEC_PER_SEC;
>>> +	stop_machine(ucode_load_rendezvous, &uc_data, cpu_online_mask);
>>> +
>>> +	pr_debug("Total CPUS = %d uperrors = %d\n",
>>> +		atomic_read(&uc_data.count), atomic_read(&uc_data.errors));
>>> +
>>> +	if (atomic_read(&uc_data.errors))
>>> +		pr_warn("Update failed for %d cpus\n", atomic_read(&uc_data.errors));
>>> +	else
>>>  		microcode_check();
>>
>> This whole jumping through hoops needs to be extracted away in a
>> separate function.
> 
> Not sure what you mean by jumping through hoops need to be extracted away.. 
> 
>>
>> Ok, that should be enough review for now. More with v2.
>>
>> -- 
>> Regards/Gruss,
>>     Boris.
>>
>> SUSE Linux GmbH, GF: Felix Imendörffer, Jane Smithard, Graham Norton, HRB 21284 (AG Nürnberg)
>> -- 
