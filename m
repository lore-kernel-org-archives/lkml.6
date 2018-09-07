Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA165C433F5
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 11:30:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 84AFA2075E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 11:30:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 84AFA2075E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728983AbeIGQLP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 12:11:15 -0400
Received: from mx2.suse.de ([195.135.220.15]:42618 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727987AbeIGQLP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 12:11:15 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 45027AE44;
        Fri,  7 Sep 2018 11:30:41 +0000 (UTC)
Subject: Re: [Xen-devel] [PATCH] xen-netfront: wait xenbus state change when
 load module manually
To:     Jiri Slaby <jslaby@suse.cz>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Xiao Liang <xiliang@redhat.com>,
        David Miller <davem@davemloft.net>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        xen-devel@lists.xenproject.org
References: <20180727095608.25210-1-xiliang@redhat.com>
 <20180729.083040.53901922165497594.davem@davemloft.net>
 <60e93e09-7dc2-d2f6-379d-c1d086aa1f49@redhat.com>
 <83ad1e3c-5e3b-8b24-430b-13e12b59ae8b@suse.cz>
 <830d73b5-8bbb-4d9a-a004-7aeea0b35067@suse.com>
 <1a6b2326-78b3-f7fa-fb3b-08c54f4f9761@oracle.com>
 <172007cc-6a82-99dd-2d1e-5103a6c1b9b0@suse.cz>
From:   Juergen Gross <jgross@suse.com>
Openpgp: preference=signencrypt
Autocrypt: addr=jgross@suse.com; prefer-encrypt=mutual; keydata=
 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
Message-ID: <360283bf-3588-8081-d939-28a57b52ef51@suse.com>
Date:   Fri, 7 Sep 2018 13:30:40 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <172007cc-6a82-99dd-2d1e-5103a6c1b9b0@suse.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: de-DE
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/09/18 13:06, Jiri Slaby wrote:
> On 08/24/2018, 04:26 PM, Boris Ostrovsky wrote:
>> On 08/24/2018 07:26 AM, Juergen Gross wrote:
>>> On 24/08/18 13:12, Jiri Slaby wrote:
>>>> On 07/30/2018, 10:18 AM, Xiao Liang wrote:
>>>>> On 07/29/2018 11:30 PM, David Miller wrote:
>>>>>> From: Xiao Liang <xiliang@redhat.com>
>>>>>> Date: Fri, 27 Jul 2018 17:56:08 +0800
>>>>>>
>>>>>>> @@ -1330,6 +1331,11 @@ static struct net_device
>>>>>>> *xennet_create_dev(struct xenbus_device *dev)
>>>>>>>       netif_carrier_off(netdev);
>>>>>>>         xenbus_switch_state(dev, XenbusStateInitialising);
>>>>>>> +    wait_event(module_load_q,
>>>>>>> +               xenbus_read_driver_state(dev->otherend) !=
>>>>>>> +               XenbusStateClosed &&
>>>>>>> +               xenbus_read_driver_state(dev->otherend) !=
>>>>>>> +               XenbusStateUnknown);
>>>>>>>       return netdev;
>>>>>>>      exit:
>>>>>> What performs the wakeups that will trigger for this sleep site?
>>>>> In my understanding, backend leaving closed/unknow state can trigger the
>>>>> wakeups. I mean to make sure both sides are ready for creating connection.
>>>> While backporting this to 4.12, I was surprised by the commit the same
>>>> as Boris and David.
>>>>
>>>> So I assume the explanation is that wake_up_all of module_unload_q in
>>>> netback_changed wakes also all the processes waiting on module_load_q?
>>>> If so, what makes sure that module_unload_q is queued and the process is
>>>> the same as for module_load_q?
>>> How could it? Either the thread is waiting on module_unload_q _or_ on
>>> module_load_q. It can't wait on two queues at the same time.
>>>
>>>> To me, it looks rather error-prone. Unless it is erroneous now, at least
>>>> for future changes. Wouldn't it make sense to wake up module_load_q
>>>> along with module_unload_q in netback_changed? Or drop module_load_q
>>>> completely and use only module_unload_q (i.e. in xennet_create_dev too)?
>>> To me this looks just wrong. A thread waiting on module_load_q won't be
>>> woken up again.
>>>
>>> I'd drop module_load_q in favor of module_unload_q.
>>
>>
>> Yes, use single queue, but rename it to something more neutral. module_wq?
> 
> Can somebody who is actually using the module fix this, please?

Already at it.


Juergen

