Return-Path: <SRS0=7C3F=LS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98385C43334
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 03:38:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F2D4E205F4
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 03:38:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QIDlVlmE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F2D4E205F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726336AbeIDIBX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Sep 2018 04:01:23 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:35113 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725995AbeIDIBX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Sep 2018 04:01:23 -0400
Received: by mail-pf1-f193.google.com with SMTP id p12-v6so976792pfh.2;
        Mon, 03 Sep 2018 20:38:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=8z/Jo3Ftn9dpJHOayiqH53GvZVqt80NHTrmSQshkhVc=;
        b=QIDlVlmEpxwcj9JuR1Gh2919zTfsvckFM9eI/yxop2CdVSdpfR9EQDedU9e+BHKbIs
         pEPEiQU9J29B6CaAxlQq9e+6o1+UHHc3YHSLn1GacvsZheVQLc4+wa45+R7BIhIRSwj8
         yUrfjfjYrFsGE7W3W3LVF5J7/gPLBDeFzyxtgHE90uY0s2DgPTXMjztrL4kN8tpM3Sus
         VgEWtmXYnmgB7Wb8S2SoRRun+tATuMbnU/2HCuPVAKsC0ezkfzXEQEZSSNWfDCRlMLo1
         5om+xlvRoqhzOLg0lyd+gHT42VpwhRdECv0GggahHzZd/Vh+imabNK+ASlKYkLcTiKBv
         jDgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=8z/Jo3Ftn9dpJHOayiqH53GvZVqt80NHTrmSQshkhVc=;
        b=qm4zGdumwuJtxdiT3qcXaqnwJrBxovEfIMRxAKz6FNhuRSSh6p0UGWj9IUyTOEocF0
         c0sMq1B9coWkwHVD5CsSnX7697V0t+pMIqfcQ8E4HwmZ8DzyNoDG0k39ugaxgWm3Qge8
         4AX4PJXjr/0QfoNlxocyZ1VAVRPkvlGdzoZwIu/IqBYQz7YVTt8qjeKZKzWzzteMt7lA
         jI9GCHsf6t7Tej767uI1NaUbILEwTpOeOetz+nFhfp7sRZ4nlOMDjK+scX7yTwXnfmK1
         SvDIG5HI7lQWWwbP9gJEcJrlAVNnAX3U7oWF+5jhgNZ2lgnQD+3aHZdvQh/BciOjUs5m
         CmMA==
X-Gm-Message-State: APzg51ATRXD8+TvZksn8l59ATIGwlN+RvfAilSdbuGO3o0TF00GIvNDE
        YV93flngLz7PYEeMTlDFRb1S2Lit
X-Google-Smtp-Source: ANB0VdbGTEzPY/LXZXNNEsExQbmFzWnbX0QsdVVEqcw9FyIghqIxiXxnuFk0OAxwxzuQrQIjp9MDEA==
X-Received: by 2002:a63:f966:: with SMTP id q38-v6mr28606493pgk.213.1536032297136;
        Mon, 03 Sep 2018 20:38:17 -0700 (PDT)
Received: from ?IPv6:2402:f000:1:1501:200:5efe:166.111.71.58? ([2402:f000:1:1501:200:5efe:a66f:473a])
        by smtp.gmail.com with ESMTPSA id 6-v6sm33470722pfs.58.2018.09.03.20.38.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 03 Sep 2018 20:38:16 -0700 (PDT)
Subject: Re: [PATCH] net: ipv6: route: Fix a sleep-in-atomic-context bug in
 ip6_convert_metrics()
To:     David Ahern <dsahern@gmail.com>, davem@davemloft.net,
        kuznet@ms2.inr.ac.ru, yoshfuji@linux-ipv6.org
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20180901111958.26529-1-baijiaju1990@gmail.com>
 <94b1372d-43da-1a9a-9cde-40c855050552@gmail.com>
From:   Jia-Ju Bai <baijiaju1990@gmail.com>
Message-ID: <6976ed37-d42e-e166-e298-053a35ddc479@gmail.com>
Date:   Tue, 4 Sep 2018 11:38:12 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.0
MIME-Version: 1.0
In-Reply-To: <94b1372d-43da-1a9a-9cde-40c855050552@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2018/9/4 10:40, David Ahern wrote:
> On 9/1/18 5:19 AM, Jia-Ju Bai wrote:
>> The kernel module may sleep with holding a spinlock.
>>
>> The function call paths (from bottom to top) in Linux-4.16 are:
>>
>> [FUNC] kzalloc(GFP_KERNEL)
>> net/ipv6/route.c, 2430:
>> 	kzalloc in ip6_convert_metrics
>> net/ipv6/route.c, 2890:
>> 	ip6_convert_metrics in ip6_route_add
>> net/ipv6/addrconf.c, 2322:
>> 	ip6_route_add in addrconf_prefix_route
>> net/ipv6/addrconf.c, 3331:
>> 	addrconf_prefix_route in fixup_permanent_addr
>> net/ipv6/addrconf.c, 3354:
>> 	fixup_permanent_addr in addrconf_permanent_addr
>> net/ipv6/addrconf.c, 3358:
>> 	_raw_write_lock_bh in addrconf_permanent_addr
>>
>> To fix this bug, GFP_KERNEL is replaced with GFP_ATOMIC.
>>
>> This bug is found by my static analysis tool DSAC.
> No kernel change is needed. Your static analysis tool and you in sending
> out patches need to take into context.
>
> ip6_convert_metrics only calls kzalloc when fc_mx is set. fc_mx is only
> set via the RTA_METRICS attribute and only from the userspace call path.
> Hence, kzalloc with GFP_KERNEL is the appropriate argument.

Oh, sorry for my false report.


Best wishes,
Jia-Ju Bai
