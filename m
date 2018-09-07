Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B425DC4321E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 11:06:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F9FE20869
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 11:06:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4F9FE20869
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728663AbeIGPq5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 11:46:57 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:55877 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727378AbeIGPq5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 11:46:57 -0400
Received: by mail-wm0-f66.google.com with SMTP id f21-v6so14328255wmc.5;
        Fri, 07 Sep 2018 04:06:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=ymOZgBAnvHhoJNgXBFKVfjedCZyvztEGs3i1TO+AF1I=;
        b=W3TYTzvUly68b9SOX3M2oSz5HN1S1v46vonn+/vCUw+G1dKpb2E0UyAPOQRCdOV28u
         J3XjYDDJTAvhF5WNSl8AphgkZZOxh5zTR1H3Esxmm3kp7saKeyThuDce4w18/P6fLCtN
         khiYGKtYsuJ64Q8ohu2bvsLxS0twr/UL6s3CUuaI4SteVSuIm4S8CsLQtHdWiKlhs7aw
         6TERFa8NpIvnI6h+5e7UWgz1WBctmp+p+oGTEP5GJuEVK3DxFTGEVGk/cACdBwYHrAbk
         9gzMyBs+lbMp4VZVyhS+6K6cIJ4nBVakt4wIvtUCcVuLjYGoMmJ15q4C4jstws/WGnqf
         o/5w==
X-Gm-Message-State: APzg51D/VJsXgK5B5f4qE/gTppv4WWhDUZPeiFTe4FuleNXurXF5wFB7
        6sPNLWWhIpKCSnWgIsogbHs=
X-Google-Smtp-Source: ANB0VdZwe41RuHDZVrXfDuFdUlxKdJVAnb8VOV1eDwiLTTL1+O/3fk4Sw4zJ65QZYwn1pEGWtLYDDA==
X-Received: by 2002:a1c:be14:: with SMTP id o20-v6mr4970880wmf.73.1536318388110;
        Fri, 07 Sep 2018 04:06:28 -0700 (PDT)
Received: from ?IPv6:2a01:4240:2e27:ad85:aaaa::70f? ([2a01:4240:2e27:ad85:aaaa::70f])
        by smtp.gmail.com with ESMTPSA id v1-v6sm8016134wrt.34.2018.09.07.04.06.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 07 Sep 2018 04:06:26 -0700 (PDT)
Subject: Re: [Xen-devel] [PATCH] xen-netfront: wait xenbus state change when
 load module manually
To:     Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>,
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
From:   Jiri Slaby <jslaby@suse.cz>
Openpgp: preference=signencrypt
Autocrypt: addr=jslaby@suse.cz; prefer-encrypt=mutual; keydata=
 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
Message-ID: <172007cc-6a82-99dd-2d1e-5103a6c1b9b0@suse.cz>
Date:   Fri, 7 Sep 2018 13:06:25 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <1a6b2326-78b3-f7fa-fb3b-08c54f4f9761@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/24/2018, 04:26 PM, Boris Ostrovsky wrote:
> On 08/24/2018 07:26 AM, Juergen Gross wrote:
>> On 24/08/18 13:12, Jiri Slaby wrote:
>>> On 07/30/2018, 10:18 AM, Xiao Liang wrote:
>>>> On 07/29/2018 11:30 PM, David Miller wrote:
>>>>> From: Xiao Liang <xiliang@redhat.com>
>>>>> Date: Fri, 27 Jul 2018 17:56:08 +0800
>>>>>
>>>>>> @@ -1330,6 +1331,11 @@ static struct net_device
>>>>>> *xennet_create_dev(struct xenbus_device *dev)
>>>>>>       netif_carrier_off(netdev);
>>>>>>         xenbus_switch_state(dev, XenbusStateInitialising);
>>>>>> +    wait_event(module_load_q,
>>>>>> +               xenbus_read_driver_state(dev->otherend) !=
>>>>>> +               XenbusStateClosed &&
>>>>>> +               xenbus_read_driver_state(dev->otherend) !=
>>>>>> +               XenbusStateUnknown);
>>>>>>       return netdev;
>>>>>>      exit:
>>>>> What performs the wakeups that will trigger for this sleep site?
>>>> In my understanding, backend leaving closed/unknow state can trigger the
>>>> wakeups. I mean to make sure both sides are ready for creating connection.
>>> While backporting this to 4.12, I was surprised by the commit the same
>>> as Boris and David.
>>>
>>> So I assume the explanation is that wake_up_all of module_unload_q in
>>> netback_changed wakes also all the processes waiting on module_load_q?
>>> If so, what makes sure that module_unload_q is queued and the process is
>>> the same as for module_load_q?
>> How could it? Either the thread is waiting on module_unload_q _or_ on
>> module_load_q. It can't wait on two queues at the same time.
>>
>>> To me, it looks rather error-prone. Unless it is erroneous now, at least
>>> for future changes. Wouldn't it make sense to wake up module_load_q
>>> along with module_unload_q in netback_changed? Or drop module_load_q
>>> completely and use only module_unload_q (i.e. in xennet_create_dev too)?
>> To me this looks just wrong. A thread waiting on module_load_q won't be
>> woken up again.
>>
>> I'd drop module_load_q in favor of module_unload_q.
> 
> 
> Yes, use single queue, but rename it to something more neutral. module_wq?

Can somebody who is actually using the module fix this, please?

I could fix it, but untested changes are "a bit" worse than tested changes.

thanks,
-- 
js
suse labs
