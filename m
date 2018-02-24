Return-Path: <wangxiongfeng2@huawei.com>
X-Google-Smtp-Source: AH8x227APr8qzdwPehDRgHXERj5m/FROWzsMAKj3uBFiKU78Bm1saqx5nN5jGYhDn/eLLGC5oZTk
ARC-Seal: i=1; a=rsa-sha256; t=1519441560; cv=none;
        d=google.com; s=arc-20160816;
        b=gaPsC0oCI19A/48BxeAeugHqjMHUESR+tFpskLq6X6rYZQvpk9Z6QBKIESlVJqwHzF
         v6CWiK/st3+NgxxFJfTJaUghzhs4ZFlou9djWpvsGsjObF9Q/t9E6zcIRYAxuSYjOM3U
         fTv8SgW2OLU1ALKazTvr6PHiFm8hqQ2/mdtrCIjQ7Njj96r3YSfu1SOC9+AP4tqYOVyU
         ajgroovQq/d0we0p0rkHqyBwLr1nWfGAvazAdmisZi+WuyN6e244Przexaljoyks43LD
         IRHDlHKzz70xOwofmPnaD5pe5nhe0TbS3Gokfa76QqAkauDH4zxkVFCVx7BqhPMaTAix
         Jlkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:in-reply-to:mime-version:user-agent:date
         :message-id:from:cc:references:to:subject:arc-authentication-results;
        bh=n98gFYmZiL1ck9B8tn6oEhxTGJ9XNEfzhY2wsfETrGw=;
        b=uiIgkxUkFqlfavRnB96Fgebvfm4ylXN4yRePDIhS38y4dCL23cCCBwYyBSj/wSSyjP
         o2I4102aoVLwshQM4eqK5S7FnWOEDDYHtYwPvO2gIdIZYQ4HGYAnmGF6hQAiuAzRoAhr
         CiQ1BgKceRGN6t2IEEIrgDq4zjGwMaR5terKOWwUGFrb22AInsId9IXNkz03hRHwX/dF
         KYB0BFHQCP14MBYsxG9ZFsEVulA0oP7Gb8eG1rdngVQlycM+5nT0iZCNtIi/E2xqVeuz
         aUDuaWCyjNappstfEfIgSimvq8+7uXajsyeQED6dU+PsCfdWggVIdXJOd5Lr8/pq4G17
         QVsw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of wangxiongfeng2@huawei.com designates 45.249.212.35 as permitted sender) smtp.mailfrom=wangxiongfeng2@huawei.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of wangxiongfeng2@huawei.com designates 45.249.212.35 as permitted sender) smtp.mailfrom=wangxiongfeng2@huawei.com
Subject: Re: [PATCH v6 11/12] arm64: topology: enable ACPI/PPTT based CPU
 topology
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Jeremy Linton
	<jeremy.linton@arm.com>
References: <20180113005920.28658-1-jeremy.linton@arm.com>
 <20180113005920.28658-12-jeremy.linton@arm.com>
 <928cb0c9-1d7a-3d0c-0538-a8bb0e2a86b1@huawei.com>
 <b4060cb0-6eed-f34a-00d5-4c2f55f20220@arm.com>
 <20180223110238.GB20461@e107981-ln.cambridge.arm.com>
CC: <linux-acpi@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<sudeep.holla@arm.com>, <hanjun.guo@linaro.org>, <rjw@rjwysocki.net>,
	<will.deacon@arm.com>, <catalin.marinas@arm.com>,
	<gregkh@linuxfoundation.org>, <viresh.kumar@linaro.org>,
	<mark.rutland@arm.com>, <linux-kernel@vger.kernel.org>,
	<linux-pm@vger.kernel.org>, <jhugo@codeaurora.org>,
	<Jonathan.Zhang@cavium.com>, <ahs3@redhat.com>,
	<Jayachandran.Nair@cavium.com>, <austinwc@codeaurora.org>, <lenb@kernel.org>,
	<vkilari@codeaurora.org>, <morten.rasmussen@arm.com>, Juri Lelli
	<juri.lelli@arm.com>
From: Xiongfeng Wang <wangxiongfeng2@huawei.com>
Message-ID: <2d248f08-79b6-d5e2-7e34-31a21efcdc07@huawei.com>
Date: Sat, 24 Feb 2018 11:05:53 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.2.0
MIME-Version: 1.0
In-Reply-To: <20180223110238.GB20461@e107981-ln.cambridge.arm.com>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.177.32.209]
X-CFilter-Loop: Reflected
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1589437013330936926?=
X-GMAIL-MSGID: =?utf-8?q?1593249953607758185?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>


Hi,
On 2018/2/23 19:02, Lorenzo Pieralisi wrote:
> On Thu, Jan 25, 2018 at 09:56:30AM -0600, Jeremy Linton wrote:
>> Hi,
>>
>> On 01/25/2018 06:15 AM, Xiongfeng Wang wrote:
>>> Hi Jeremy,
>>>
>>> I have tested the patch with the newest UEFI. It prints the below error:
>>>
>>> [    4.017371] BUG: arch topology borken
>>> [    4.021069] BUG: arch topology borken
>>> [    4.024764] BUG: arch topology borken
>>> [    4.028460] BUG: arch topology borken
>>> [    4.032153] BUG: arch topology borken
>>> [    4.035849] BUG: arch topology borken
>>> [    4.039543] BUG: arch topology borken
>>> [    4.043239] BUG: arch topology borken
>>> [    4.046932] BUG: arch topology borken
>>> [    4.050629] BUG: arch topology borken
>>> [    4.054322] BUG: arch topology borken
>>>
>>> I checked the code and found that the newest UEFI set PPTT physical_package_flag on a physical package node and
>>> the NUMA domain (SRAT domains) starts from the layer of DIE. (The topology of our board is core->cluster->die->package).
>>
>> I commented about that on the EDK2 mailing list. While the current spec
>> doesn't explicitly ban having the flag set multiple times between the leaf
>> and the root I consider it a "bug" and there is an effort to clarify the
>> spec and the use of that flag.
>>>
>>> When the kernel starts to build sched_domain, the multi-core sched_domain contains all the cores within a package,
>>> and the lowest NUMA sched_domain contains all the cores within a die. But the kernel requires that the multi-core
>>> sched_domain should be a subset of the lowest NUMA sched_domain, so the BUG info is printed.
>>
>> Right. I've mentioned this problem a couple of times.
>>
>> At at the moment, the spec isn't clear about how the proximity domain is
>> detected/located within the PPTT topology (a node with a 1:1 correspondence
>> isn't even required). As you can see from this patch set, we are making the
>> general assumption that the proximity domains are at the same level as the
>> physical socket. This isn't ideal for NUMA topologies, like the D05, that
>> don't align with the physical socket.
>>
>> There are efforts underway to clarify and expand upon the specification to
>> deal with this general problem. The simple solution is another flag (say
>> PPTT_PROXIMITY_DOMAIN which would map to the D05 die) which could be used to
>> find nodes with 1:1 correspondence. At that point we could add a fairly
>> trivial patch to correct just the scheduler topology without affecting the
>> rest of the system topology code.
> 
> I think Morten asked already but isn't this the same end result we end
> up having if we remove the DIE level if NUMA-within-package is detected
> (instead of using the default_topology[]) and we create our own ARM64
> domain hierarchy (with DIE level removed) through set_sched_topology()
> accordingly ?
> 
> Put it differently: do we really need to rely on another PPTT flag to
> collect this information ?
> 
> I can't merge code that breaks a platform with legitimate firmware
> bindings.

I think we really need another PPTT flag, from which we can get information
about how to build a multi-core sched_domain. I think only cache-sharing information
is not enough to get information about how to build a multi-core shced_domain.

How about this? We assume the upper layer of the lowest layer to be multi-core layer.
After that flag is added into ACPI specs, we add another patch to adapt to the change.

Thanks,
Xiongfeng

> 
> Thanks,
> Lorenzo
> 
>>
>>>
>>> If we modify the UEFI to make NUMA sched_domain start from the layer of package, then all the topology information
>>> within the package will be discarded. I think we need to build the multi-core sched_domain using the cores within
>>> the cluster instead of the cores within the package. I think that's what 'multi-core' means. Multi cores form a cluster. I guess.
>>> If we build the multi-core sched_domain using the cores within a cluster, I think we need to add fields in struct cpu_topology
>>> to record which cores are in each cluster.
>>
>> The problem is that there isn't a generic way to identify which level of
>> cache sharing is the "correct" top layer MC domain. For one system cluster
>> might be appropriate, for another it might be the highest caching level
>> within a socket, for another is might be a something in between or a group
>> of clusters or LLCs..
>>
>> Hence the effort to standardize/guarantee a PPTT node that exactly matches a
>> SRAT domain. With that, each SOC/system provider has clearly defined method
>> for communicating where they want the proximity domain information to begin.
>>
>> Thanks,
>>
>>>
>>>
>>> Thanks,
>>> Xiongfeng
>>>
>>> On 2018/1/13 8:59, Jeremy Linton wrote:
>>>> Propagate the topology information from the PPTT tree to the
>>>> cpu_topology array. We can get the thread id, core_id and
>>>> cluster_id by assuming certain levels of the PPTT tree correspond
>>>> to those concepts. The package_id is flagged in the tree and can be
>>>> found by calling find_acpi_cpu_topology_package() which terminates
>>>> its search when it finds an ACPI node flagged as the physical
>>>> package. If the tree doesn't contain enough levels to represent
>>>> all of the requested levels then the root node will be returned
>>>> for all subsequent levels.
>>>>
>>>> Cc: Juri Lelli <juri.lelli@arm.com>
>>>> Signed-off-by: Jeremy Linton <jeremy.linton@arm.com>
>>>> ---
>>>>  arch/arm64/kernel/topology.c | 46 +++++++++++++++++++++++++++++++++++++++++++-
>>>>  1 file changed, 45 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/arch/arm64/kernel/topology.c b/arch/arm64/kernel/topology.c
>>>> index 7b06e263fdd1..ce8ec7fd6b32 100644
>>>> --- a/arch/arm64/kernel/topology.c
>>>> +++ b/arch/arm64/kernel/topology.c
>>>> @@ -11,6 +11,7 @@
>>>>   * for more details.
>>>>   */
>>>> +#include <linux/acpi.h>
>>>>  #include <linux/arch_topology.h>
>>>>  #include <linux/cpu.h>
>>>>  #include <linux/cpumask.h>
>>>> @@ -22,6 +23,7 @@
>>>>  #include <linux/sched.h>
>>>>  #include <linux/sched/topology.h>
>>>>  #include <linux/slab.h>
>>>> +#include <linux/smp.h>
>>>>  #include <linux/string.h>
>>>>  #include <asm/cpu.h>
>>>> @@ -300,6 +302,46 @@ static void __init reset_cpu_topology(void)
>>>>  	}
>>>>  }
>>>> +#ifdef CONFIG_ACPI
>>>> +/*
>>>> + * Propagate the topology information of the processor_topology_node tree to the
>>>> + * cpu_topology array.
>>>> + */
>>>> +static int __init parse_acpi_topology(void)
>>>> +{
>>>> +	bool is_threaded;
>>>> +	int cpu, topology_id;
>>>> +
>>>> +	is_threaded = read_cpuid_mpidr() & MPIDR_MT_BITMASK;
>>>> +
>>>> +	for_each_possible_cpu(cpu) {
>>>> +		topology_id = find_acpi_cpu_topology(cpu, 0);
>>>> +		if (topology_id < 0)
>>>> +			return topology_id;
>>>> +
>>>> +		if (is_threaded) {
>>>> +			cpu_topology[cpu].thread_id = topology_id;
>>>> +			topology_id = find_acpi_cpu_topology(cpu, 1);
>>>> +			cpu_topology[cpu].core_id   = topology_id;
>>>> +			topology_id = find_acpi_cpu_topology_package(cpu);
>>>> +			cpu_topology[cpu].package_id = topology_id;
>>>> +		} else {
>>>> +			cpu_topology[cpu].thread_id  = -1;
>>>> +			cpu_topology[cpu].core_id    = topology_id;
>>>> +			topology_id = find_acpi_cpu_topology_package(cpu);
>>>> +			cpu_topology[cpu].package_id = topology_id;
>>>> +		}
>>>> +	}
>>>> +
>>>> +	return 0;
>>>> +}
>>>> +
>>>> +#else
>>>> +static inline int __init parse_acpi_topology(void)
>>>> +{
>>>> +	return -EINVAL;
>>>> +}
>>>> +#endif
>>>>  void __init init_cpu_topology(void)
>>>>  {
>>>> @@ -309,6 +351,8 @@ void __init init_cpu_topology(void)
>>>>  	 * Discard anything that was parsed if we hit an error so we
>>>>  	 * don't use partial information.
>>>>  	 */
>>>> -	if (of_have_populated_dt() && parse_dt_topology())
>>>> +	if ((!acpi_disabled) && parse_acpi_topology())
>>>> +		reset_cpu_topology();
>>>> +	else if (of_have_populated_dt() && parse_dt_topology())
>>>>  		reset_cpu_topology();
>>>>  }
>>>>
>>>
>>
> 
> .
> 
