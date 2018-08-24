Return-Path: <SRS0=6SfI=LH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A8F8C4321D
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 11:13:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D60092150F
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 11:13:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D60092150F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727403AbeHXOrK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Aug 2018 10:47:10 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:40448 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726462AbeHXOrI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Aug 2018 10:47:08 -0400
Received: by mail-wr1-f65.google.com with SMTP id n2-v6so7148369wrw.7;
        Fri, 24 Aug 2018 04:12:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=wM6N9h6EeSPQ4UnEEinpQ7i7rBosAUEBACyzOKe1Sl8=;
        b=DPclNQtIgO9xvvTOLgrEwno0f1IgXyNbqqAjxxO8S0AXiE0V59DLw16WBmTcfMsoNY
         1sNr85tZwobnwGZfL4j0WQoq8AiZa7YzIglROLzM0lHWqkPVqfuBrRiQ1qkRXzcbAA/P
         xH7O+Yuu61kb9pR6jmThuMH0C2MKITF58LPEYOd/SZHNtpprsCa5NRZrwcJtd12yoo8x
         ZsQyrugSfDqxz0H6yiC2qieKFxU592HlthIrDi6yY+IxodIUbPSLMx0n41UxaWUGrq9+
         A3uFm5JVTKgwAT3XvDxcHvnu9rPXDjjOK3P0+UzhaJEPRMIEteIfjNwgipWZCJuum+mZ
         b19w==
X-Gm-Message-State: APzg51D0sd8UJxK6zfxrobO8O/PlwH4iMju4vbLvZKdj+nVSq+Rf4QsK
        FKlBm4az90q8Dv9inIC8mzyxoWGy
X-Google-Smtp-Source: ANB0VdYtnEyxNEKRXJNmlVnom12u5KXcgprMTXZq8Q2F2UiOD9v7ql4gTts2CLjL9IcGYGMnV93OHw==
X-Received: by 2002:adf:f504:: with SMTP id q4-v6mr934729wro.241.1535109174919;
        Fri, 24 Aug 2018 04:12:54 -0700 (PDT)
Received: from ?IPv6:2a01:4240:2e27:ad85:aaaa::70f? ([2a01:4240:2e27:ad85:aaaa::70f])
        by smtp.gmail.com with ESMTPSA id d12-v6sm8313294wru.36.2018.08.24.04.12.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 24 Aug 2018 04:12:54 -0700 (PDT)
Subject: Re: [Xen-devel] [PATCH] xen-netfront: wait xenbus state change when
 load module manually
To:     Xiao Liang <xiliang@redhat.com>, David Miller <davem@davemloft.net>
Cc:     jgross@suse.com, netdev@vger.kernel.org,
        boris.ostrovsky@oracle.com, linux-kernel@vger.kernel.org,
        xen-devel@lists.xenproject.org
References: <20180727095608.25210-1-xiliang@redhat.com>
 <20180729.083040.53901922165497594.davem@davemloft.net>
 <60e93e09-7dc2-d2f6-379d-c1d086aa1f49@redhat.com>
From:   Jiri Slaby <jslaby@suse.cz>
Openpgp: preference=signencrypt
Autocrypt: addr=jslaby@suse.cz; prefer-encrypt=mutual; keydata=
 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
Message-ID: <83ad1e3c-5e3b-8b24-430b-13e12b59ae8b@suse.cz>
Date:   Fri, 24 Aug 2018 13:12:52 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <60e93e09-7dc2-d2f6-379d-c1d086aa1f49@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/30/2018, 10:18 AM, Xiao Liang wrote:
> On 07/29/2018 11:30 PM, David Miller wrote:
>> From: Xiao Liang <xiliang@redhat.com>
>> Date: Fri, 27 Jul 2018 17:56:08 +0800
>>
>>> @@ -1330,6 +1331,11 @@ static struct net_device
>>> *xennet_create_dev(struct xenbus_device *dev)
>>>       netif_carrier_off(netdev);
>>>         xenbus_switch_state(dev, XenbusStateInitialising);
>>> +    wait_event(module_load_q,
>>> +               xenbus_read_driver_state(dev->otherend) !=
>>> +               XenbusStateClosed &&
>>> +               xenbus_read_driver_state(dev->otherend) !=
>>> +               XenbusStateUnknown);
>>>       return netdev;
>>>      exit:
>> What performs the wakeups that will trigger for this sleep site?
> In my understanding, backend leaving closed/unknow state can trigger the
> wakeups. I mean to make sure both sides are ready for creating connection.

While backporting this to 4.12, I was surprised by the commit the same
as Boris and David.

So I assume the explanation is that wake_up_all of module_unload_q in
netback_changed wakes also all the processes waiting on module_load_q?
If so, what makes sure that module_unload_q is queued and the process is
the same as for module_load_q?

To me, it looks rather error-prone. Unless it is erroneous now, at least
for future changes. Wouldn't it make sense to wake up module_load_q
along with module_unload_q in netback_changed? Or drop module_load_q
completely and use only module_unload_q (i.e. in xennet_create_dev too)?

thanks,
-- 
js
suse labs
