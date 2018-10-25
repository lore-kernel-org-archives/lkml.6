Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 716B8C46475
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 22:15:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 14EC8207DD
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 22:15:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CnLLLqD+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 14EC8207DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727514AbeJZGtd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Oct 2018 02:49:33 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:40157 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726348AbeJZGtd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Oct 2018 02:49:33 -0400
Received: by mail-pg1-f196.google.com with SMTP id o14-v6so4667082pgv.7;
        Thu, 25 Oct 2018 15:15:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Pwz6Qvrx0sA6mwWj5Vh1b5fHZFctycd/Ce9grbu7wwE=;
        b=CnLLLqD+bjah7D238vPTMTk9sC0zc3HKcK0Z9IfvsXfB5hr+lKf1z4SiHIcuAPVTC4
         V8El90b2nn/b+7broLGXA2Uvm+3nbghrjBlmdRzVxfnHPxM7S5VGDMEGwDEBIPJtZUWM
         xbke9cw849kesDO53en8HHgZR0godkc3PXw4d3dkkpp45AdS31xAAxAz/clhzZm+uYyG
         7KBAUHzJe/f5Tr9X/5+OPBY1UhDFdgAbbXj4UXtj4bJW/EjSMZVFAPeVhzXNbUJJbniy
         QA97Wq8/Osinxch3yjgrmZxv4qojWaUCT9fWdyF13cfju11Knp4fQmVbpqKuBnM+Q3/f
         1pbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Pwz6Qvrx0sA6mwWj5Vh1b5fHZFctycd/Ce9grbu7wwE=;
        b=kx+g2Hj/D+vXZNmPEZGJDIgAjjSqxb3HSlrsf8UOvsXDYOFGOvArGLT6ECtJA/NWAC
         oHiFTQzmwBDPY29T7sHACxsH38qFvqbemkDWL/VBpijNLG59uSEIJNLHUXn8MTi024/C
         /I/wChOl/kS4nB9XLpWHPCaTjjNmBkAg6qHCB/RG028muerAAbBEIMO30mpNfrbTqw+7
         beNZYWfVLhD1PUK/K+HN8vu0V9nnXDWPQaBBHDDcPGBKUwXDAJp2F9AU0vNTFCmPZygy
         BSA+rculUAYaVNXaeCMjhpXVKeWY8Ie4oGlov4WZXM8ijVF/riJ14rvPHPjTvcGnWJWb
         YABw==
X-Gm-Message-State: AGRZ1gJBC5q+lvouYQVstQ3ucGAO3y/2fZ6AkkW3dz6q7Nux0JBktXHL
        k0SIKuwbO1uxqylVu3osLBi3Hptj
X-Google-Smtp-Source: AJdET5d2HdnbwDAXTqbYTLQEf0XKxXcNqtO1ANwUVFb/5tcPOT/d1JUR0+Y3r8oHYbJ5eEQuHGyeIA==
X-Received: by 2002:a63:2447:: with SMTP id k68-v6mr896717pgk.156.1540505705580;
        Thu, 25 Oct 2018 15:15:05 -0700 (PDT)
Received: from ?IPv6:2620:15c:2c1:200:55c7:81e6:c7d8:94b? ([2620:15c:2c1:200:55c7:81e6:c7d8:94b])
        by smtp.gmail.com with ESMTPSA id n64-v6sm6545550pfh.166.2018.10.25.15.15.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 25 Oct 2018 15:15:04 -0700 (PDT)
Subject: Re: [PATCH v1] net: ipv6: fix racey clock check in route cache aging
 logic
To:     Brendan Higgins <brendanhiggins@google.com>
Cc:     "David S . Miller" <davem@davemloft.net>, kuznet@ms2.inr.ac.ru,
        yoshfuji@linux-ipv6.org, netdev@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20181025211352.112096-1-brendanhiggins@google.com>
 <d787249c-0679-065a-62cb-ee9f87b1fba3@gmail.com>
 <CAFd5g44jmpDyeh--=Hd2fAexzik4gMYLMdNhAMqxWqnjSh4KeA@mail.gmail.com>
From:   Eric Dumazet <eric.dumazet@gmail.com>
Message-ID: <9ce74f5b-387d-b02f-2efa-f12c1450577c@gmail.com>
Date:   Thu, 25 Oct 2018 15:15:04 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <CAFd5g44jmpDyeh--=Hd2fAexzik4gMYLMdNhAMqxWqnjSh4KeA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/25/2018 02:46 PM, Brendan Higgins wrote:
> On Thu, Oct 25, 2018 at 2:40 PM Eric Dumazet <eric.dumazet@gmail.com> wrote:
>> On 10/25/2018 02:13 PM, Brendan Higgins wrote:
> <snip>
>>>
>>> diff --git a/net/ipv6/route.c b/net/ipv6/route.c
>>> index 2a7423c394560..54d28b91fd840 100644
>>> --- a/net/ipv6/route.c
>>> +++ b/net/ipv6/route.c
>>> @@ -1734,7 +1734,7 @@ static void rt6_age_examine_exception(struct rt6_exception_bucket *bucket,
>>>                       rt6_remove_exception(bucket, rt6_ex);
>>>                       return;
>>>               }
>>> -     } else if (time_after(jiffies, rt->dst.expires)) {
>>> +     } else if (time_after(now, rt->dst.expires)) {
>>>               RT6_TRACE("purging expired route %p\n", rt);
>>>               rt6_remove_exception(bucket, rt6_ex);
>>>               return;
>>>
>>
>>
>> I do not think there is a bug here ?
>>
>> As a matter of fact, using the latest value of jiffies is probably better,
>> since in some cases the @now variable could be quite in the past.
> 
> Then why do we pass the `now` parameter in at all and use it at all,
> like here: https://elixir.bootlin.com/linux/latest/source/net/ipv6/route.c#L1764
> ?
> 
> I am still skeptical that we should check jiffies in each check, but
> we should at least be consistent.

Well, this is a case where we do not really care.

When a bug is fixed (you added a Fixes: tag which is good), we want
to understand the real problem that needs to be fixed on stable kernels.

Since this does not seem to be a real issue, I would suggest you send a cleanup
patch when net-next is open (few days after linux-4.20-rc1 is release)

