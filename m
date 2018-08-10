Return-Path: <SRS0=aVpA=KZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A8F7C4646D
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 07:30:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F3CAB2089F
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 07:30:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LSDPeOic"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F3CAB2089F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727794AbeHJJ7X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Aug 2018 05:59:23 -0400
Received: from mail-pl0-f66.google.com ([209.85.160.66]:35159 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727538AbeHJJ7X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Aug 2018 05:59:23 -0400
Received: by mail-pl0-f66.google.com with SMTP id w3-v6so3696954plq.2;
        Fri, 10 Aug 2018 00:30:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=wFNnxeBMmkIhuMsk5nFdpZCxOtUWmKM1XRENFKFYPVE=;
        b=LSDPeOicgUZjZbiNNKKXF4svLnN9XPwDZPnXEJb9Raw25bi612+d2+A6/IAt3G2I55
         cuHTfZOO7IJihMLLE8dHEuutMpE/8+zZH8EEuquK5bdma6vuSfquqzIbZb8E5on5o+ze
         Wx56d73W/zrazYcOrv1VPdjZvHeOJpbNCui3CT/xbEDGPSAbl1REDVxn/3QLURWU2Unc
         iZC33micK3hd+oxUSlQXoKq7oDKNVGtYr1d2pfWMF4Nx8kuD61r3jnhhsKk3uQaUWYiv
         mlOXCyDDgu7OwBb3XmKG9aLa6hgDp2xbkEqffR66sqlIqzXHXwQcJXV7OzkyVv09rX+g
         jyFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=wFNnxeBMmkIhuMsk5nFdpZCxOtUWmKM1XRENFKFYPVE=;
        b=DtzVifHwru8iAgR+xWC8eQTPi9EeeF5MUZ2srqPL5aLhOLbeAmerewzHw+CyeI6VsV
         ZtaCGXh9kQhLL8vnjqhdvloODOusnH9aVreOwSwm2NTKFzUVrIGXT/q6IrMDR07akM1Z
         0t5VTcUA4A2xLUCPn2QIzAfD8wgSFa2CvLPVD09td9b1A873/kv49aVOMIfCGgw40wVC
         piallVlpl1dq/JhVAx74HJzyEtY9deEzwv6RrAmblfv+RiEN7+jdlUmKoK0hrjGUCw2i
         LH489AzZFXYPOXH87WAElb2znpJfMXimThWbke5r4Gl7hr17zB9AFGbScqJOJXXKI5mM
         D6Gw==
X-Gm-Message-State: AOUpUlEkvsmpjP00rd/vj1hbrqJy8uzKE5Z7v4XDsDlyru0PHkwKkY+x
        ckBp3WvbLlz4Q5PWG9Xk/Z7Kyrq0
X-Google-Smtp-Source: AA+uWPzVyoPISGFL6CBBm08Ki/rlKgxaCAd75/c2e2RYD+i/GO5aB2R5kB1debg8oC0n1Dmq8T4VnA==
X-Received: by 2002:a17:902:599b:: with SMTP id p27-v6mr4981212pli.191.1533886245734;
        Fri, 10 Aug 2018 00:30:45 -0700 (PDT)
Received: from ?IPv6:2402:f000:1:1501:200:5efe:166.111.71.51? ([2402:f000:1:1501:200:5efe:a66f:4733])
        by smtp.gmail.com with ESMTPSA id y128-v6sm2366807pfb.56.2018.08.10.00.30.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 10 Aug 2018 00:30:45 -0700 (PDT)
Subject: Re: [BUG] net: xfrm: Two possible sleep-in-atomic-context bugs
To:     Steffen Klassert <steffen.klassert@secunet.com>
Cc:     herbert@gondor.apana.org.au, davem@davemloft.net,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <b74ebf58-16c0-4a51-a004-7ce9e6abde7a@gmail.com>
 <20180810053604.uopy5ziikf736p5o@gauss3.secunet.de>
From:   Jia-Ju Bai <baijiaju1990@gmail.com>
Message-ID: <b996cef6-530d-635a-2e28-eabca3387e2f@gmail.com>
Date:   Fri, 10 Aug 2018 15:30:40 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.0
MIME-Version: 1.0
In-Reply-To: <20180810053604.uopy5ziikf736p5o@gauss3.secunet.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for your reply :)


On 2018/8/10 13:36, Steffen Klassert wrote:
> On Fri, Aug 10, 2018 at 10:02:42AM +0800, bai wrote:
>> The code may sleep in interrupt handler.
>> xfrm_trans_reinject() is an interrupt handler set in tasklet_init().
>> The function call paths (from bottom to top) in Linux-4.16 are:
>>
>> [FUNC] schedule_timeout
>> net/core/sock.c, 2044: schedule_timeout in sock_wait_for_wmem
>> net/core/sock.c, 2083: sock_wait_for_wmem in sock_alloc_send_pskb
>> net/core/sock.c, 2102: sock_alloc_send_pskb in sock_alloc_send_skb
>> net/ipv6/mcast.c, 1989: sock_alloc_send_skb in igmp6_send
> igmp6_send calls sock_alloc_send_skb with 'noblock = 1',
> this means that sock_wait_for_wmem is not executed in
> sock_alloc_send_pskb.
>
>> net/ipv6/mcast.c, 2391: igmp6_send in igmp6_join_group
>> net/ipv6/mcast.c, 670: igmp6_join_group in igmp6_group_added
>> net/ipv6/mcast.c, 914: igmp6_group_added in ipv6_dev_mc_inc
>> net/ipv6/ndisc.c, 379: ipv6_dev_mc_inc in pndisc_constructor
>> net/core/neighbour.c, 640: [FUNC_PTR]pndisc_constructor in pneigh_lookup
>> net/ipv6/ip6_output.c, 483: pneigh_lookup in ip6_forward
>> ./include/net/dst.h, 449: [FUNC_PTR]ip6_forward in dst_input
>> net/ipv6/ip6_input.c, 71: dst_input in ip6_rcv_finish
>> net/xfrm/xfrm_input.c, 511: [FUNC_PTR]ip6_rcv_finish in xfrm_trans_reinject
>>
>> [FUNC] kmalloc(GFP_KERNEL)
>> net/core/neighbour.c, 630: kmalloc in pneigh_lookup
>> net/ipv6/ip6_output.c, 483: pneigh_lookup in ip6_forward
> ip6_forward calls pneigh_lookup with 'creat = 0',
> this means that pneigh_lookup does not do the kmalloc.
>
>> ./include/net/dst.h, 449: [FUNC_PTR]ip6_forward in dst_input
>> net/ipv6/ip6_input.c, 71: dst_input in ip6_rcv_finish
>> net/xfrm/xfrm_input.c, 511: [FUNC_PTR]ip6_rcv_finish in xfrm_trans_reinject
>>
>> Note that [FUNC_PTR] means a function pointer call is used.
>>
>> I do not find a good way to fix them, so I only report.
>> These possible bugs are found by my static analysis tool (DSAC) and checked
>> by my code review.
> Both codepaths are ok, maybe you should fix your tool ;-)

It seems that the path condition checking in my tool needs to be improved.
I will do it, thanks :)


Best wishes,
Jia-Ju Bai
