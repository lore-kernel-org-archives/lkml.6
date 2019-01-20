Return-Path: <SRS0=5EgK=P4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7663CC26641
	for <linux-kernel@archiver.kernel.org>; Sun, 20 Jan 2019 19:12:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 431FE2084F
	for <linux-kernel@archiver.kernel.org>; Sun, 20 Jan 2019 19:12:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727798AbfATTMX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 20 Jan 2019 14:12:23 -0500
Received: from smtp.ctxuk.citrix.com ([185.25.65.24]:19109 "EHLO
        SMTP.EU.CITRIX.COM" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727415AbfATTMX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Jan 2019 14:12:23 -0500
X-IronPort-AV: E=Sophos;i="5.56,499,1539648000"; 
   d="scan'208";a="84843133"
Subject: Re: [PATCH v2 3/3] x86/umwait: Control umwait maximum time
To:     Andy Lutomirski <luto@kernel.org>,
        Fenghua Yu <fenghua.yu@intel.com>
CC:     Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>, Ingo Molnar <mingo@redhat.com>,
        H Peter Anvin <hpa@zytor.com>,
        Ashok Raj <ashok.raj@intel.com>,
        Ravi V Shankar <ravi.v.shankar@intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>, x86 <x86@kernel.org>
References: <1547673522-226408-1-git-send-email-fenghua.yu@intel.com>
 <1547673522-226408-4-git-send-email-fenghua.yu@intel.com>
 <CALCETrVenEpKH5O=Z6J+faWTcdZpa1xx4-dYwdWu1OSEDyiUWw@mail.gmail.com>
From:   Andrew Cooper <andrew.cooper3@citrix.com>
Openpgp: preference=signencrypt
Autocrypt: addr=andrew.cooper3@citrix.com; prefer-encrypt=mutual; keydata=
 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
 6+ahAA==
Message-ID: <ae8d5a07-9fbc-7c76-fa88-ff2718696686@citrix.com>
Date:   Sun, 20 Jan 2019 19:12:17 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <CALCETrVenEpKH5O=Z6J+faWTcdZpa1xx4-dYwdWu1OSEDyiUWw@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Content-Language: en-GB
X-ClientProxiedBy: AMSPEX02CAS01.citrite.net (10.69.22.112) To
 AMSPEX02CL02.citrite.net (10.69.22.126)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17/01/2019 00:00, Andy Lutomirski wrote:
> On Wed, Jan 16, 2019 at 1:24 PM Fenghua Yu <fenghua.yu@intel.com> wrote:
>> IA32_UMWAIT_CONTROL[31:2] determines the maximum time in TSC-quanta
>> that processor can stay in C0.1 or C0.2.
>>
>> The maximum time value in IA32_UMWAIT_CONTROL[31-2] is set as zero which
>> means there is no global time limit for UMWAIT and TPAUSE instructions.
>> Each process sets its own umwait maximum time as the instructions operand.
>>
>> User can specify global umwait maximum time through interface:
>> /sys/devices/system/cpu/umwait_control/umwait_max_time
>> The value in the interface is in decimal in TSC-quanta. Bits[1:0]
>> are cleared when the value is stored.
>>
>> Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
>> ---
>>  arch/x86/include/asm/msr-index.h |  2 ++
>>  arch/x86/power/umwait.c          | 42 +++++++++++++++++++++++++++++++-
>>  2 files changed, 43 insertions(+), 1 deletion(-)
>>
>> diff --git a/arch/x86/include/asm/msr-index.h b/arch/x86/include/asm/msr-index.h
>> index b56bfecae0de..42b9104fc15b 100644
>> --- a/arch/x86/include/asm/msr-index.h
>> +++ b/arch/x86/include/asm/msr-index.h
>> @@ -62,6 +62,8 @@
>>  #define MSR_IA32_UMWAIT_CONTROL                0xe1
>>  #define UMWAIT_CONTROL_C02_BIT         0x0
>>  #define UMWAIT_CONTROL_C02_MASK                0x00000001
>> +#define UMWAIT_CONTROL_MAX_TIME_BIT    0x2
>> +#define UMWAIT_CONTROL_MAX_TIME_MASK   0xfffffffc
>>
>>  #define MSR_PKG_CST_CONFIG_CONTROL     0x000000e2
>>  #define NHM_C3_AUTO_DEMOTE             (1UL << 25)
>> diff --git a/arch/x86/power/umwait.c b/arch/x86/power/umwait.c
>> index 95b3867aac1e..4a1a507d3bb7 100644
>> --- a/arch/x86/power/umwait.c
>> +++ b/arch/x86/power/umwait.c
>> @@ -10,6 +10,7 @@
>>  #include <asm/msr.h>
>>
>>  static int umwait_enable_c0_2 = 1; /* 0: disable C0.2. 1: enable C0.2. */
>> +static u32 umwait_max_time; /* In TSC-quanta. Only bits [31:2] are used. */
>>  static DEFINE_MUTEX(umwait_lock);
>>
>>  /* Return value that will be used to set umwait control MSR */
>> @@ -20,7 +21,8 @@ static inline u32 umwait_control_val(void)
>>          * When bit 0 is 1, C0.2 is disabled. Otherwise, C0.2 is enabled.
>>          * So value in bit 0 is opposite of umwait_enable_c0_2.
>>          */
>> -       return ~umwait_enable_c0_2 & UMWAIT_CONTROL_C02_MASK;
>> +       return (~umwait_enable_c0_2 & UMWAIT_CONTROL_C02_MASK) |
>> +              umwait_max_time;
>>  }
>>
>>  static ssize_t umwait_enable_c0_2_show(struct device *dev,
>> @@ -61,8 +63,46 @@ static ssize_t umwait_enable_c0_2_store(struct device *dev,
>>
>>  static DEVICE_ATTR_RW(umwait_enable_c0_2);
>>
>> +static ssize_t umwait_max_time_show(struct device *kobj,
>> +                                   struct device_attribute *attr, char *buf)
>> +{
>> +       return sprintf(buf, "%u\n", umwait_max_time);
>> +}
>> +
>> +static ssize_t umwait_max_time_store(struct device *kobj,
>> +                                    struct device_attribute *attr,
>> +                                    const char *buf, size_t count)
>> +{
>> +       u32 msr_val, max_time;
>> +       int cpu, ret;
>> +
>> +       ret = kstrtou32(buf, 10, &max_time);
>> +       if (ret)
>> +               return ret;
>> +
>> +       mutex_lock(&umwait_lock);
>> +
>> +       /* Only get max time value from bits [31:2] */
>> +       max_time &= UMWAIT_CONTROL_MAX_TIME_MASK;
>> +       /* Update the max time value in memory */
>> +       umwait_max_time = max_time;
>> +       msr_val = umwait_control_val();
>> +       get_online_cpus();
>> +       /* All CPUs have same umwait max time */
>> +       for_each_online_cpu(cpu)
>> +               wrmsr_on_cpu(cpu, MSR_IA32_UMWAIT_CONTROL, msr_val, 0);
>> +       put_online_cpus();
>> +
>> +       mutex_unlock(&umwait_lock);
>> +
>> +       return count;
>> +}
>> +
>> +static DEVICE_ATTR_RW(umwait_max_time);
>> +
>>  static struct attribute *umwait_attrs[] = {
>>         &dev_attr_umwait_enable_c0_2.attr,
>> +       &dev_attr_umwait_max_time.attr,
>>         NULL
>>  };
> You need something to make sure that newly onlined CPUs get the right
> value in the MSR.  You also need to make sure you restore it on resume
> from suspend.  Something like cpu_init() might be the right place.
>
> Also, as previously discussed, I think we should set the default to
> something quite small, maybe 100 microseconds.  IMO the goal is to
> pick a value that is a high enough multiple of the C0.2 entry+exit
> latency that we get most of the power and SMT resource savings while
> being small enough that no one things that UMWAIT is more than a
> glorified, slightly improved, and far more misleading version of REP
> NOP.
>
> Andrew, would having Linux default to a small value do much to
> mitigate your concerns that UMWAIT is problematic for hypervisors?

Sadly no - not really.

Being an MSR, there is no way the guest kernel is having unfiltered
access, so the hypervisor can set whatever bound it wishes.

For any non-trivial wait period, it would be better for the system as a
whole to switch to a different vcpu, but the semantics don't allow for
that.  Shortening the timeout just results in userspace taking over
again, and most likely concluding that there was an early wakeup and
going back to sleep.

More useful semantics would be something similar to pause-loop-exiting
so we can swap contexts while the processor is logically idle in userspace.

~Andrew
