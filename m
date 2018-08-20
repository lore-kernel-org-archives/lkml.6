Return-Path: <SRS0=A5JR=LD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 804BEC4321D
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 17:51:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E97E21731
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 17:51:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1E97E21731
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=tycho.nsa.gov
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726504AbeHTVIL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Aug 2018 17:08:11 -0400
Received: from uhil19pa11.eemsg.mail.mil ([214.24.21.84]:38073 "EHLO
        uhil19pa11.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726077AbeHTVIL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Aug 2018 17:08:11 -0400
X-Greylist: delayed 572 seconds by postgrey-1.27 at vger.kernel.org; Mon, 20 Aug 2018 17:08:10 EDT
Received: from emsm-gh1-uea10.ncsc.mil ([214.29.60.2])
  by uhil19pa11.eemsg.mail.mil with ESMTP/TLS/AES256-SHA; 20 Aug 2018 17:42:02 +0000
X-IronPort-AV: E=Sophos;i="5.53,266,1531785600"; 
   d="scan'208";a="15015698"
IronPort-PHdr: =?us-ascii?q?9a23=3A4V/CpBGKvrWU1F1N9udVhp1GYnF86YWxBRYc79?=
 =?us-ascii?q?8ds5kLTJ76oMu7bnLW6fgltlLVR4KTs6sC17KJ9fi4EUU7or+5+EgYd5JNUx?=
 =?us-ascii?q?JXwe43pCcHRPC/NEvgMfTxZDY7FskRHHVs/nW8LFQHUJ2mPw6arXK99yMdFQ?=
 =?us-ascii?q?viPgRpOOv1BpTSj8Oq3Oyu5pHfeQpFiCa/bL9oMBm6sRjau9ULj4dlNqs/0A?=
 =?us-ascii?q?bCrGFSe+RRy2NoJFaTkAj568yt4pNt8Dletuw4+cJYXqr0Y6o3TbpDDDQ7KG?=
 =?us-ascii?q?81/9HktQPCTQSU+HQRVHgdnwdSDAjE6BH6WYrxsjf/u+Fg1iSWIdH6QLYpUj?=
 =?us-ascii?q?m58axlVAHnhzsGNz4h8WHYlMpwjL5AoBm8oxBz2pPYbJ2JOPZ7eK7Sc8kaRW?=
 =?us-ascii?q?5cVchPUSJPDJ63Y48WA+YfIepUqo/wrEYMoxSjHwmhHP7hxCFGhnH23qM03e?=
 =?us-ascii?q?ouHg7E0wM8ENwDq2jUodfvOasOTey4wqvFwDPeZP1Wwzf9743Ifwg8r/GQQ7?=
 =?us-ascii?q?1wacrRxlcpFwjYk1uQrJbqPzeR1usTs2mQ8u1tVfmyhG48sAxxvjiuydssio?=
 =?us-ascii?q?nOnI4VzEvE+j9jzIY6It24Vld2bNi5G5VTryGXL5Z6T8wtTm1yuCs216cKtY?=
 =?us-ascii?q?C0cSQU0pgr2hjSYOGdfYeS+BLsTuORLC99hHJiZb2wmQ6/8VOlyu3gTsm010?=
 =?us-ascii?q?tKrjZdntnMqH8N0xvT59CbSvRn5Eeh2CuP1xvJ5uFFJ0A0m63bK4U/zbEsjJ?=
 =?us-ascii?q?YTrUTCETP2mEXxlqOWcFkr+vO05Oj9Z7Xmp5ucO5d1igH4LKsuhtSyDfk3Pw?=
 =?us-ascii?q?UBRWSW+fmw2Kf98UD2XrlGlOA6nrHcsJ/AJMQboqC5AxVS0oYm8xu/FCqp0M?=
 =?us-ascii?q?8DkHkbLFNKZBKHj4/zN1HIO/D3F+2zg1urkDd13/zGJKHuAo3RLnjfl7fsZa?=
 =?us-ascii?q?py5FRHyAUtzdFT/YlUBa0BIP3pR0/xutjYAQEjMwGvwubnDsl92Z0aWW6VHq?=
 =?us-ascii?q?CZN6bSu0eS5u0zO+mMeJMVuDHlJvgm+fHul3k5lkEZfaWw3ZsYcmq4Eel4LE?=
 =?us-ascii?q?WfYHrshNgBHHwOvgo/V+zqlEaCXSRUZ3aqQa084D86B5iiDYfHXIyinLuB3C?=
 =?us-ascii?q?KjFJ1Mem9GEkyMEWvvd4icX/cMaSSSItJukzAdVriuVZUh1Rewuw/+0LdnMO?=
 =?us-ascii?q?XU9TMCtZ7519h6+ffTlRcs+jxwFcid1HuNT25slGMSWzA2xLx/oVB6ylqb1a?=
 =?us-ascii?q?h4gvpYFcFc5v9QSQc1K4LTz/FgC9DzRgLAfs6FSFOhQtq7HDExSsw+zsQQY0?=
 =?us-ascii?q?ZyBdqilArP3ym0DL8PkbyEGpg0/rjb33jrKMZ302zG27U5j1k6XstPMnWrib?=
 =?us-ascii?q?Nl+AjNGYHFiUWZmLysdaQHwiHN8nyOzWuIvEFETgFwVb/JUmwYZkvTtd75/F?=
 =?us-ascii?q?/NT6eyCbQ7NQtM0dONJbVMatL3k1pGQu3vOMjEb22snGe/GRWIy6iNbIrsZ2?=
 =?us-ascii?q?USwiHdBFIYnAAU+HaMLRI+CTu5o2LCEDxuEkriY0D28el/s3O7UlE7zweRYk?=
 =?us-ascii?q?1l1rq1/AMVhPOGR/MS2LIEpDkuqzFuEFmh2NLWDsKKpxB9c6VEfdM9/FBH2H?=
 =?us-ascii?q?rDuAxnPJyvNaZii0UacwR2uUPuyhp2Bp9BkcgssHMl0g5yJbiE31NGcjPLla?=
 =?us-ascii?q?z3b/fsIWn74R6rZrSSknrXy9uHsO9b4/0jpkSlpwqpH1cs93h9+9hTz3aYoJ?=
 =?us-ascii?q?7NCVxWGdjyX1wx+hw/p7jAbiQ75oXb/XltKrWv9Dja1tQ2De8hjB2nep0XZK?=
 =?us-ascii?q?CJDgn/F4gaDtKiJeornVeBahMfIPsU87Y5Odyvc//A06muaqIo1jani3lXpY?=
 =?us-ascii?q?NwyESB8wJiRePSmZUI2feV2k2ATTi2xAOls8bqicVHaCsUE26X1yfpHshSa7?=
 =?us-ascii?q?d0cIJNDn2hdYn/jNF/gYP9HmVV/0O5Bk8XncqudQeWYnTj0gBKk0cau3qqnW?=
 =?us-ascii?q?2/1TM+22Utr6yCzGnVzu//bhsbKytOQ2V/iVrEP4e5lZYZUVKuYgxvkwGqsw?=
 =?us-ascii?q?KyjbNWoKV5Mnn7XVZDfy+wKXprFKS3qPDKN9VC7JIurDV/TPW3YVfcTKX05R?=
 =?us-ascii?q?QdzXWnVyF+zTYgejfu8rnwgREwwDaRJWh+6nrQf9p9wz/e4sDRQbha2T9QAG?=
 =?us-ascii?q?EypT7cBRz0E9Sv8NiS36uJ+rSyWmSsW5sVbW/nyoiDnCq9+WBuRxa4mqb30p?=
 =?us-ascii?q?fkCwkhzSL9/91rUzjY6hf6foTvka+9NKgvKkpyBUTg5sxSHoB4j5t2hZcM1H?=
 =?us-ascii?q?xcjZKQqz5P227pM9xd8ab/amcdAz8N39PRpgPi3QcrenuTxYv/fnGcxNZxId?=
 =?us-ascii?q?i8fm4SnCk66pYZJr2T6el/gSZtole+5TnUaPx5kyZVneAi81YGkuoJv0wr1S?=
 =?us-ascii?q?zbDbcMSxoLdRfwngiFuojt5J5cY3yiJP3pjhJz?=
X-IPAS-Result: =?us-ascii?q?A2ACAgAi/Xpb/wHyM5BcGgEBAQEBAgEBAQEIAQEBAYMlg?=
 =?us-ascii?q?XoSKINwiGmMCgEBAQEBBoEILYhcjy4HI4RUAoNuNxUBAgEBAQEBAQIBbCiCN?=
 =?us-ascii?q?SQBgl0BAQEBAwEiBBFNBAsRBAEBAQICIwMCAigeCQgGAQwGAgEBgl8/gXUNp?=
 =?us-ascii?q?3F7M4N+AQFohXWBC4gkeYEHgTmCNjWHf4JXAo1HjTUJi22DbQYVjjiUfyKBU?=
 =?us-ascii?q?isIAhgIIQ+DJIIlFxGNUAFRIzABjxoBAQ?=
Received: from tarius.tycho.ncsc.mil (HELO tarius.infosec.tycho.ncsc.mil) ([144.51.242.1])
  by EMSM-GH1-UEA10.NCSC.MIL with ESMTP; 20 Aug 2018 17:41:55 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto.infosec.tycho.ncsc.mil [192.168.25.131])
        by tarius.infosec.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id w7KHfq90023990;
        Mon, 20 Aug 2018 13:41:52 -0400
Subject: Re: [PATCH RFC v2 5/5] SELinux: Support SELinux determination of
 side-channel vulnerability
To:     "Schaufler, Casey" <casey.schaufler@intel.com>,
        "kernel-hardening@lists.openwall.com" 
        <kernel-hardening@lists.openwall.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-security-module@vger.kernel.org" 
        <linux-security-module@vger.kernel.org>,
        "selinux@tycho.nsa.gov" <selinux@tycho.nsa.gov>,
        "Hansen, Dave" <dave.hansen@intel.com>,
        "Dock, Deneen T" <deneen.t.dock@intel.com>,
        "kristen@linux.intel.com" <kristen@linux.intel.com>,
        "arjan@linux.intel.com" <arjan@linux.intel.com>
References: <20180817221624.10232-1-casey.schaufler@intel.com>
 <20180817221624.10232-6-casey.schaufler@intel.com>
 <6e70b7c7-d932-91c8-35d1-70bd6cef16a5@tycho.nsa.gov>
 <99FC4B6EFCEFD44486C35F4C281DC6732143F80E@ORSMSX107.amr.corp.intel.com>
From:   Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <f74a5824-c80a-bdb9-2d4a-e83d19ae07e8@tycho.nsa.gov>
Date:   Mon, 20 Aug 2018 13:43:41 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <99FC4B6EFCEFD44486C35F4C281DC6732143F80E@ORSMSX107.amr.corp.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/20/2018 12:59 PM, Schaufler, Casey wrote:
>> -----Original Message-----
>> From: Stephen Smalley [mailto:sds@tycho.nsa.gov]
>> Sent: Monday, August 20, 2018 9:03 AM
>> To: Schaufler, Casey <casey.schaufler@intel.com>; kernel-
>> hardening@lists.openwall.com; linux-kernel@vger.kernel.org; linux-security-
>> module@vger.kernel.org; selinux@tycho.nsa.gov; Hansen, Dave
>> <dave.hansen@intel.com>; Dock, Deneen T <deneen.t.dock@intel.com>;
>> kristen@linux.intel.com; arjan@linux.intel.com
>> Subject: Re: [PATCH RFC v2 5/5] SELinux: Support SELinux determination of
>> side-channel vulnerability
>>
>> On 08/17/2018 06:16 PM, Casey Schaufler wrote:
>>> SELinux considers tasks to be side-channel safe if they
>>> have PROCESS_SHARE access.
>>
>> Now the description and the code no longer match.
> 
> You're right.
> 
>>>
>>> Signed-off-by: Casey Schaufler <casey.schaufler@intel.com>
>>> ---
>>>    security/selinux/hooks.c | 9 +++++++++
>>>    1 file changed, 9 insertions(+)
>>>
>>> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
>>> index a8bf324130f5..7fbd7d7ac1cb 100644
>>> --- a/security/selinux/hooks.c
>>> +++ b/security/selinux/hooks.c
>>> @@ -4219,6 +4219,14 @@ static void selinux_task_to_inode(struct
>> task_struct *p,
>>>    	spin_unlock(&isec->lock);
>>>    }
>>>
>>> +static int selinux_task_safe_sidechannel(struct task_struct *p)
>>> +{
>>> +	struct av_decision avd;
>>> +
>>> +	return avc_has_perm_noaudit(&selinux_state, current_sid(),
>> task_sid(p),
>>> +				    SECCLASS_FILE, FILE__READ, 0, &avd);
>>> +}
>>
>> And my question from before still stands:  why do we need a new hook and
>> new security module instead of just using ptrace_may_access()?
> 
> Locking. The SELinux check, for example, will lock up solid while trying
> to generate an audit record. There is no good reason aside from coding
> convenience to assume that the same restrictions will apply for side-channel
> as apply to ptrace. I'm actually a touch surprised you're not suggesting a
> separate SECCLASS or access mode for the SELinux hook.

The PTRACE_MODE_NOAUDIT flag to ptrace_may_access() would address the 
locking concern. Duplicating the ptrace access checking logic seems 
prone to errors and inconsistencies. I can't imagine policy writers 
understanding what "safe sidechannel" means, much less deciding when to 
allow it.

> 
>>
>>> +
>>>    /* Returns error only if unable to parse addresses */
>>>    static int selinux_parse_skb_ipv4(struct sk_buff *skb,
>>>    			struct common_audit_data *ad, u8 *proto)
>>> @@ -7002,6 +7010,7 @@ static struct security_hook_list selinux_hooks[]
>> __lsm_ro_after_init = {
>>>    	LSM_HOOK_INIT(task_movememory, selinux_task_movememory),
>>>    	LSM_HOOK_INIT(task_kill, selinux_task_kill),
>>>    	LSM_HOOK_INIT(task_to_inode, selinux_task_to_inode),
>>> +	LSM_HOOK_INIT(task_safe_sidechannel,
>> selinux_task_safe_sidechannel),
>>>
>>>    	LSM_HOOK_INIT(ipc_permission, selinux_ipc_permission),
>>>    	LSM_HOOK_INIT(ipc_getsecid, selinux_ipc_getsecid),
>>>
> 

