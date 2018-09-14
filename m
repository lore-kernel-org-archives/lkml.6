Return-Path: <SRS0=Jh2l=L4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6550ECDFD0
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 14:10:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F9B120671
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 14:10:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8F9B120671
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728248AbeINTZY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Sep 2018 15:25:24 -0400
Received: from mx2.suse.de ([195.135.220.15]:44524 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727013AbeINTZX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Sep 2018 15:25:23 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id DA7A5ACD2;
        Fri, 14 Sep 2018 14:10:40 +0000 (UTC)
Subject: Re: [Xen-devel] [PATCH 1/6] xenbus: prepare data structures and
 parameter for xenwatch multithreading
To:     Dongli Zhang <dongli.zhang@oracle.com>,
        xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org,
        paul.durrant@citrix.com
Cc:     wei.liu2@citrix.com, konrad.wilk@oracle.com,
        srinivas.eeda@oracle.com, boris.ostrovsky@oracle.com,
        roger.pau@citrix.com
References: <1536910456-13337-1-git-send-email-dongli.zhang@oracle.com>
 <1536910456-13337-2-git-send-email-dongli.zhang@oracle.com>
 <23dc17b9-dc76-776b-74ef-d11f4b77552d@suse.com>
 <45609402-c392-565b-042d-71179d982d61@oracle.com>
From:   Juergen Gross <jgross@suse.com>
Openpgp: preference=signencrypt
Autocrypt: addr=jgross@suse.com; prefer-encrypt=mutual; keydata=
 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
Message-ID: <c5f10394-5eba-ef0a-2904-1338c5ceb7d0@suse.com>
Date:   Fri, 14 Sep 2018 16:10:38 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <45609402-c392-565b-042d-71179d982d61@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Language: de-DE
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/09/18 15:57, Dongli Zhang wrote:
> Hi Juergen and Paul,
> 
> On 09/14/2018 04:32 PM, Juergen Gross wrote:
>> On 14/09/18 09:34, Dongli Zhang wrote:
>>> This is the 1st patch of a (6-patch) patch set.
>>>
>>> This patch set of six patches introduces xenwatch multithreading (or
>>> multithreaded xenwatch, abbreviated as 'mtwatch') to dom0 kernel. In
>>> addition to the existing single xenwatch thread, each domU has its own
>>> kernel thread ([xen-mtwatch-<domid>]) to process its xenwatch event.
>>>
>>> A kernel parameter 'xen_mtwatch' is introduced to control whether the
>>> feature is enabled or not during dom0 kernel boot. The feature is disabled
>>> by default if 'xen_mtwatch' is not set in grub. In addition, this patch
>>> also introduces the data structures to maintain the status of each per-domU
>>> xenwatch thread. The status of each xenwatch thread (except the default
>>> one) is maintained by a mtwatch domain.
>>>
>>> The feature is available only on dom0.
>>>
>>> Signed-off-by: Dongli Zhang <dongli.zhang@oracle.com>
>>> ---
>>>  Documentation/admin-guide/kernel-parameters.txt |  3 ++
>>>  drivers/xen/xenbus/xenbus_xs.c                  | 31 ++++++++++++
>>>  include/xen/xenbus.h                            | 65 +++++++++++++++++++++++++
>>>  3 files changed, 99 insertions(+)
>>>
>>> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
>>> index 64a3bf5..fc295ef 100644
>>> --- a/Documentation/admin-guide/kernel-parameters.txt
>>> +++ b/Documentation/admin-guide/kernel-parameters.txt
>>> @@ -4992,6 +4992,9 @@
>>>  				the unplug protocol
>>>  			never -- do not unplug even if version check succeeds
>>>  
>>> +	xen_mtwatch     [KNL,XEN]
>>> +			Enables the multithreaded xenwatch (mtwatch).
>>> +
>>>  	xen_nopvspin	[X86,XEN]
>>>  			Disables the ticketlock slowpath using Xen PV
>>>  			optimizations.
>>> diff --git a/drivers/xen/xenbus/xenbus_xs.c b/drivers/xen/xenbus/xenbus_xs.c
>>> index 49a3874..3f137d2 100644
>>> --- a/drivers/xen/xenbus/xenbus_xs.c
>>> +++ b/drivers/xen/xenbus/xenbus_xs.c
>>> @@ -95,6 +95,19 @@ static pid_t xenwatch_pid;
>>>  static DEFINE_MUTEX(xenwatch_mutex);
>>>  static DECLARE_WAIT_QUEUE_HEAD(watch_events_waitq);
>>>  
>>> +bool xen_mtwatch;
>>> +EXPORT_SYMBOL_GPL(xen_mtwatch);
>>> +
>>> +struct mtwatch_info *mtwatch_info;
>>> +
>>> +static bool param_xen_mtwatch;
>>> +static __init int xen_parse_mtwatch(char *arg)
>>> +{
>>> +	param_xen_mtwatch = true;
>>> +	return 0;
>>> +}
>>> +early_param("xen_mtwatch", xen_parse_mtwatch);
>>
>> Add a Kconfig item to set the default when building the kernel? We can
>> start with default "off", but later we might want to enable this feature
>> as the default.
> 
> Is there any weakness/downside configuring the param via early_param? Or is
> there any strength via Kconfig?
> 
> I would prefer to not fix the configuration when building the kernel. The
> administrator/user will not be able to choose the preferred option.

I wouldn't remove the kernel param, but let the config choose the
default to use. The user would still be able to set the value either
way via boot parameter.

> 
> I would prefer to configure the option via kernel param and set default as 'off'
> (false). In a common cloud environment, the administrator is only required to
> enable the param in dom0/driver domain kernel.
> 
> For common domU (not using as backend), this feature is useless. I assume there
> are always more domUs than dom0 (and driver domain), especially in cloud
> environment.
> 
>>
>>> +
>>>  static void xs_suspend_enter(void)
>>>  {
>>>  	spin_lock(&xs_state_lock);
>>> @@ -929,6 +942,24 @@ int xs_init(void)
>>>  	if (err)
>>>  		return err;
>>>  
>>> +	if (xen_initial_domain() && param_xen_mtwatch) {
>>
>> Wouldn't it be better to drop the test for xen_initial_domain() and do
>> this initialization only when a caller (backend) is requesting the
>> multithread mode? This would avoid wasting memory in case it isn't going
>> top be used and - more important - would support driver domains.
> 
> This would save us <4KB.
> 
> Suppose the default 'param_xen_mtwatch' is 'off'. The administrator knows the
> domain is used as pv backend when he/she enables the option manually.
> 
> In such scenario, is there any benefit to make it on-demand to save <4KB memory?

It is a benefit in case a distro ships the kernel with default on in
order to avoid the need to add kernel parameters for dom0 or a driver
domain. In a normal domU there is no backend running so the behavior
would be as today.

If the feature is stable and we know it is better to switch it on for
driver domains (and dom0, of course), we shouldn't require the user to
do so.


Juergen
