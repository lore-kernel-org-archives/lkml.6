Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1425388AbeCBOVd (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Mar 2018 09:21:33 -0500
Received: from mx2.suse.de ([195.135.220.15]:57583 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1425309AbeCBOVc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Mar 2018 09:21:32 -0500
Subject: Re: [Xen-devel] [PATCH] xen: use hvc console for dom0
To: Julien Grall <julien.grall@arm.com>,
        Stefano Stabellini <sstabellini@kernel.org>
Cc: nd@arm.com, Andrii Anisov <andrii_anisov@epam.com>,
        linux-kernel@vger.kernel.org, xen-devel@lists.xenproject.org,
        boris.ostrovsky@oracle.com, jbeulich@suse.com
References: <20180226110822.13787-1-jgross@suse.com>
 <0d8bdda5-faef-41da-344a-644b5c3d6006@epam.com>
 <58e94cc9-9b09-d6b7-3122-fb4c83e97926@suse.com>
 <b57092b4-e740-e1f8-3885-a817bb7d4e70@arm.com>
 <alpine.DEB.2.10.1802271159070.4239@sstabellini-ThinkPad-X260>
 <19afb9f9-a845-e627-8f78-d1fdb349c6bd@arm.com>
From: Juergen Gross <jgross@suse.com>
Message-ID: <73110605-e3b9-92d2-cc78-56ff8d13b9ea@suse.com>
Date: Fri, 2 Mar 2018 15:21:30 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <19afb9f9-a845-e627-8f78-d1fdb349c6bd@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: de-DE
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27/02/18 21:09, Julien Grall wrote:
> Hi,
> 
> On 27/02/2018 20:03, Stefano Stabellini wrote:
>> On Tue, 27 Feb 2018, Julien Grall wrote:
>>> Hi,
>>>
>>> On 26/02/18 12:32, Juergen Gross wrote:
>>>> On 26/02/18 13:06, Andrii Anisov wrote:
>>>>> Hello Juergen,
>>>>>
>>>>>
>>>>> On 26.02.18 13:08, Juergen Gross wrote:
>>>>>> Today the hvc console is added as a preferred console for pv domUs
>>>>>> only. As this requires a boot parameter for getting dom0 messages per
>>>>>> default add it for dom0, too.
>>>>>>
>>>>>> Signed-off-by: Juergen Gross <jgross@suse.com>
>>>>>> ---
>>>>>>     arch/x86/xen/enlighten_pv.c | 4 +++-
>>>>>>     1 file changed, 3 insertions(+), 1 deletion(-)
>>>>>>
>>>>>> diff --git a/arch/x86/xen/enlighten_pv.c
>>>>>> b/arch/x86/xen/enlighten_pv.c
>>>>> Is this something x86 specific? Could it be a generic approach?
>>>>
>>>> In case ARM wants something similar I guess the test for
>>>> xen_initial_domain() should be dropped in xen_early_init().
>>> I am pretty sure we discussed to remove !xen_initial_domain() for Arm
>>> in the
>>> past. But I don't remember why the patch was not sent to remove it.
>>>
>>> Anyway, I guess this should be fine to have hvc as a preferred
>>> console for the
>>> initial domain as well.
>>
>> Usually, Dom0 has access to several physical UARTs and/or VGA, making
>> this patch less obviously desirable. I think that for Dom0 the best
>> behavior would be to add "hvc0" as first console rather than last
>> console, so that if the user specified something else, this call won't
>> interfere with it.
> 
> Well, that's exactly the goal of add_preferred_console. It will use hvc0
> unless specified otherwise by the user on the command line.

I suggest someone who can test it should post a patch for ARM.


Juergen
