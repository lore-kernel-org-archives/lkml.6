Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id ctIKBfxVGVt0OwAAmS7hNA
	; Thu, 07 Jun 2018 15:58:56 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 7EBDA608BA; Thu,  7 Jun 2018 15:58:56 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j34OkdqR"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FROM,MAILING_LIST_MULTI autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 0429D6063F;
	Thu,  7 Jun 2018 15:58:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 0429D6063F
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934773AbeFGP6y (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 11:58:54 -0400
Received: from mail-pg0-f48.google.com ([74.125.83.48]:36708 "EHLO
        mail-pg0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933050AbeFGP6u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 11:58:50 -0400
Received: by mail-pg0-f48.google.com with SMTP id m5-v6so4966825pgd.3;
        Thu, 07 Jun 2018 08:58:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ZJTFB1JqQb2JKVoh8eKpMYd2j40ASf99GVQUsgDOUZo=;
        b=j34OkdqR9Xv0P9R0XJppkBv7MWMdBZbLB6VaFUogeYITo+wocZYi+imc9H7XeEso8u
         ogAPyYChQisR5kB2NeMPFT/ENUnZ/U2MXSbvjGty0EtNWiyDm9WDLsoP9/tpsm6AY2Qn
         eXskenJYhz3W+PW9h8VZEy8HAGbTVgQQKEIigBrrUp0I3MEXrnRV13CIWqcDQqnzGGc4
         qbK3Vre2R8cWudy8lPkxnAhqQ3DBOtPbOkRN7tkkeuAl2w4ST0/7FaELalH0/lYpSDAO
         GrnX8y35jSIkX86m/AJO1VhUgqY24Mer/oR6W8K2v9Eykr3IaPLuS/qTsqvrFKk+o3Gr
         sisg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ZJTFB1JqQb2JKVoh8eKpMYd2j40ASf99GVQUsgDOUZo=;
        b=aXndMD95nuv1n/htPRryy84L2sVj1M0w5DzFxz6r10/WyvDtS0dCv/J8OVFM0MtqvJ
         IcfFuDAwhsfTU55ldwUy4EnrpuGXeq7cdAyY0HKABTfsQtP3Uyi/RUrxej/cV3WFVi47
         MjruxqqWgh5P4lML9cL4N48saDwObRXmvy8pJ5DDw8DcjoquNpqAMFpUI6xwCTrtcMy5
         gKPzPXYp9t82p0aAJXMgVUR/YSKDoEU/KR0PaP0HngT8Llf5GU/zhNLmlaK+ZqOglvYo
         PvXpR1jkKnnKmffTRu/uEv3m4673sJf732m82Cm0U7vdT03PQtrC+qiyFc4wTCLuG2uu
         Wppw==
X-Gm-Message-State: APt69E3VSus5homONMZr/uOhI8QPtuY+sGMPYF+nQIuFar251/7jb/pW
        FbunwHsmRXmLCla7cMUXyDftwbWB
X-Google-Smtp-Source: ADUXVKICB43z2Oib2eBLAp/2HNNpNwGwxBA778XDIJxu9ZblpFfDSIHsLR6KNvMLky0mS8nmCkIHKQ==
X-Received: by 2002:a62:4715:: with SMTP id u21-v6mr2308461pfa.89.1528387130072;
        Thu, 07 Jun 2018 08:58:50 -0700 (PDT)
Received: from dsa-mb.dana.cumulusnetworks.com (fw.cumulusnetworks.com. [216.129.126.126])
        by smtp.googlemail.com with ESMTPSA id r79-v6sm61145066pfe.115.2018.06.07.08.58.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 07 Jun 2018 08:58:48 -0700 (PDT)
Subject: Re: kmemleak reports unreferenced object 0xf2bee080 (size 96)
To: Paul Menzel <pmenzel+linux-netdev@molgen.mpg.de>,
        "David S. Miller" <davem@davemloft.net>,
        Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
        Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <5d7376e2-d936-38ed-3419-262fc64f6a40@molgen.mpg.de>
From: David Ahern <dsahern@gmail.com>
Message-ID: <bdd72f43-c28d-4bfa-69f1-b0693732f9f6@gmail.com>
Date: Thu, 7 Jun 2018 08:58:47 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:52.0)
 Gecko/20100101 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <5d7376e2-d936-38ed-3419-262fc64f6a40@molgen.mpg.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/7/18 8:54 AM, Paul Menzel wrote:
> $ dmesg
> […]
> [  677.139874] PM: suspend exit
> [  678.490993] kmemleak: 1 new suspected memory leaks (see /sys/kernel/debug/kmemleak)
> [  679.517022] r8169 0000:03:00.0 enp3s0: link up
> […]
> $ sudo more /sys/kernel/debug/kmemleak
> unreferenced object 0xf2bee080 (size 96):
>   comm "systemd-network", pid 209, jiffies 4294894477 (age 851.812s)
>   hex dump (first 32 bytes):
>     00 00 00 00 dc 05 00 00 00 00 00 00 00 00 00 00  ................
>     00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
>   backtrace:
>     [<fb9b1020>] kmem_cache_alloc_trace+0x195/0x3a0
>     [<bbe5d9f4>] ip6_convert_metrics+0x4a/0xe0
>     [<4d869f67>] ip6_route_info_create+0x294/0xd10
>     [<2f08c8d0>] ip6_route_add+0x1d/0x90
>     [<304de076>] inet6_rtm_newroute+0x72/0x80
>     [<f9e280dd>] rtnetlink_rcv_msg+0x2df/0x4f0
>     [<9287c3cf>] netlink_rcv_skb+0x8f/0x130
>     [<fbddd35b>] rtnetlink_rcv+0x12/0x20
>     [<60ffd06b>] netlink_unicast+0x1ab/0x2b0
>     [<4260e680>] netlink_sendmsg+0x2b5/0x5c0
>     [<ec0cda7b>] sock_sendmsg+0x5a/0xa0
>     [<08adf1a5>] __sys_sendto+0xea/0x170
>     [<93e4f4e1>] sys_socketcall+0x1f4/0x380
>     [<dcd25cae>] do_fast_syscall_32+0xd3/0x360
>     [<0ce0c28f>] entry_SYSENTER_32+0x4e/0x7c
>     [<2324e043>] 0xffffffff
> ```
> 


I'll take a look. Thanks for the report.
