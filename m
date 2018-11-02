Return-Path: <SRS0=zRJA=NN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC49BC32789
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 21:14:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F6B72081F
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 21:14:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="Qkz2RLSJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7F6B72081F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728101AbeKCGXP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 3 Nov 2018 02:23:15 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:31664 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726106AbeKCGXP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Nov 2018 02:23:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1541193272; x=1572729272;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=4+i51fRxigkTF2mXa0noRy1cmn2afNEARp6SCWUQGdI=;
  b=Qkz2RLSJvNWUzPHNC+4r99m45+I09wxhGIqOqIolekwOTF4q4tFJNg8l
   u/iw9F5LdRb6c5DJtiHuhlYGa8f2ioWiQbORj8+gxLOZ6emHMCSmnrPn7
   KXMyR/XFlmZpj0a0vK5aAjclcnk7pG0DaDzBJCBrCS9DqznfWobgXSp/1
   DXmmT6OJkccc8WV3vSwFjBDe008uX2Y+6vf4vpJhwYRo2G5rtwilb/yJ1
   EzClXDI6mFqCmh8Dwc8oknmY+Lcb6lOBXXmPIsvLWX6uSAt89CMpxYg9B
   qJ51Qq57221XLU88j8kE1+exPzWJsJhKwBE3Wn1qHDUoknJZsGjtPtFwq
   w==;
X-IronPort-AV: E=Sophos;i="5.54,457,1534780800"; 
   d="scan'208";a="93415111"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 03 Nov 2018 05:14:32 +0800
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP; 02 Nov 2018 13:58:15 -0700
Received: from c02v91rdhtd5.sdcorp.global.sandisk.com (HELO [10.111.69.187]) ([10.111.69.187])
  by uls-op-cesaip02.wdc.com with ESMTP; 02 Nov 2018 14:14:31 -0700
Subject: Re: [RFC 0/2] Add RISC-V cpu topology
To:     Nick Kossifidis <mick@ics.forth.gr>
Cc:     "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        "alankao@andestech.com" <alankao@andestech.com>,
        "hch@infradead.org" <hch@infradead.org>,
        "anup@brainfault.org" <anup@brainfault.org>,
        "palmer@sifive.com" <palmer@sifive.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "zong@andestech.com" <zong@andestech.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>
References: <1541113468-22097-1-git-send-email-atish.patra@wdc.com>
 <866dedbc78ab4fa0e3b040697e112106@mailhost.ics.forth.gr>
From:   Atish Patra <atish.patra@wdc.com>
Message-ID: <9385b2eb-4729-8247-b0ae-1540793d078b@wdc.com>
Date:   Fri, 2 Nov 2018 14:14:30 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:52.0)
 Gecko/20100101 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <866dedbc78ab4fa0e3b040697e112106@mailhost.ics.forth.gr>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/2/18 11:59 AM, Nick Kossifidis wrote:
> Hello All,
> 
> Στις 2018-11-02 01:04, Atish Patra έγραψε:
>> This patch series adds the cpu topology for RISC-V. It contains
>> both the DT binding and actual source code. It has been tested on
>> QEMU & Unleashed board.
>>
>> The idea is based on cpu-map in ARM with changes related to how
>> we define SMT systems. The reason for adopting a similar approach
>> to ARM as I feel it provides a very clear way of defining the
>> topology compared to parsing cache nodes to figure out which cpus
>> share the same package or core.  I am open to any other idea to
>> implement cpu-topology as well.
>>
> 
> I was also about to start a discussion about CPU topology on RISC-V
> after the last swtools group meeting. The goal is to provide the
> scheduler with hints on how to distribute tasks more efficiently
> between harts, by populating the scheduling domain topology levels
> (https://elixir.bootlin.com/linux/v4.19/ident/sched_domain_topology_level).
> What we want to do is define cpu groups and assign them to
> scheduling domains with the appropriate SD_ flags
> (https://github.com/torvalds/linux/blob/master/include/linux/sched/topology.h#L16).
> 

Scheduler domain topology is already getting all the hints in the 
following way.

static struct sched_domain_topology_level default_topology[] = {
#ifdef CONFIG_SCHED_SMT
         { cpu_smt_mask, cpu_smt_flags, SD_INIT_NAME(SMT) },
#endif
#ifdef CONFIG_SCHED_MC
         { cpu_coregroup_mask, cpu_core_flags, SD_INIT_NAME(MC) },
#endif
         { cpu_cpu_mask, SD_INIT_NAME(DIE) },
         { NULL, },
};

#ifdef CONFIG_SCHED_SMT
static inline const struct cpumask *cpu_smt_mask(int cpu)
{
         return topology_sibling_cpumask(cpu);
}
#endif

const struct cpumask *cpu_coregroup_mask(int cpu)
{
         return &cpu_topology[cpu].core_sibling;
}


> So the cores that belong to a scheduling domain may share:
> CPU capacity (SD_SHARE_CPUCAPACITY / SD_ASYM_CPUCAPACITY)
> Package resources -e.g. caches, units etc- (SD_SHARE_PKG_RESOURCES)
> Power domain (SD_SHARE_POWERDOMAIN)
> 
> In this context I believe using words like "core", "package",
> "socket" etc can be misleading. For example the sample topology you
> use on the documentation says that there are 4 cores that are part
> of a package, however "package" has a different meaning to the
> scheduler. Also we don't say anything in case they share a power
> domain or if they have the same capacity or not. This mapping deals
> only with cache hierarchy or other shared resources.
> 
> How about defining a dt scheme to describe the scheduler domain
> topology levels instead ? e.g:
> 
> 2 sets (or clusters if you prefer) of 2 SMT cores, each set with
> a different capacity and power domain:
> 
> sched_topology {
>    level0 { // SMT
>     shared = "power", "capacity", "resources";
>     group0 {
>      members = <&hart0>, <&hart1>;
>     }
>     group1 {
>      members = <&hart2>, <&hart3>;
>     }
>     group2 {
>      members = <&hart4>, <&hart5>;
>     }
>     group3 {
>      members = <&hart6>, <&hart7>;
>     }
>    }
>    level1 { // MC
>     shared = "power", "capacity"
>     group0 {
>      members = <&hart0>, <&hart1>, <&hart2>, <&hart3>;
>     }
>     group1 {
>      members = <&hart4>, <&hart5>, <&hart6>, <&hart7>;
>     }
>    }
>    top_level { // A group with all harts in it
>     shared = "" // There is nothing common for ALL harts, we could have
> capacity here
>    }
> }
> 

I agree that naming could have been better in the past. But it is what 
it is now. I don't see any big advantages in this approach compared to 
the existing approach where DT specifies what hardware looks like and 
scheduler sets up it's domain based on different cpumasks.


Regards,
Atish
> Regards,
> Nick
> 
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv
> 

