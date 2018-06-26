Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F47BC43142
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 06:44:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B6E42656F
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 06:44:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cXmVdKvx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4B6E42656F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752161AbeFZGo1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 02:44:27 -0400
Received: from mail-pg0-f65.google.com ([74.125.83.65]:43126 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751448AbeFZGoZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 02:44:25 -0400
Received: by mail-pg0-f65.google.com with SMTP id a14-v6so7196193pgw.10;
        Mon, 25 Jun 2018 23:44:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Oy+CvGZGR5S5EmzWStLBxl/hcCc2RcwnxW0zknpTvi0=;
        b=cXmVdKvxDr+1LjM8Yf5+3v6zahDpQ1ibjxBlT58+YyPKuuKL73m4ur1sq493TyIDhp
         DjdM8aOC0oQ9Gi2j/uREWVf4Hui6anN2nDbXEPX7Z5gLxDv+Vhj9l3NI1l+9ogdaxCBH
         RgWToXkxfSZ7emouZfV5U9DXeNeqBdhS8AqjvvADiUreTNfqLNZOYvEyzQgiwRtYgKU1
         BRzeTOMYcOaojGzl12tQSsM7GFineMjKKjlGUDihJyLOhS9EvmR46KSGzOdVUYxTxIq1
         CHrz+3DyuzWq6wBgL8EdG9Vb1I8k8o/qFGJD6Sb6w8pHRFk/w7QT++qpx2toA10B5zNq
         NF8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Oy+CvGZGR5S5EmzWStLBxl/hcCc2RcwnxW0zknpTvi0=;
        b=BlOSiS+g7A2PBmZm7wCMoog/lARyizr1wuiUcYAeVETkPTaOx4i+fJ9y4QDHQALdoD
         dgL9hSeAzdjBOT7zJ6a2M1MlvGpnyUGmFJCNvQk++WJX4GWzsehdd+0F5tC8QfuirJEB
         0eBGC5H6NKFUf1OBzbdO6o3OoMWLiav8hzvuHuYj8ohV5gB3mZmthZ4ei5mD52cXub2h
         1yNNBHvVh/04YjFg7XSfsKgnuDPwmQpTGol/qymUBtq8cqpTtdb5HDeh5F1tPEXF7acC
         RPdA2U7UxXf9t/IZYzvjiHWXkALrBN/DQKKqr2D+RVRXZqq93cHxyQ8+aV2Nfj5ppaZi
         Au/Q==
X-Gm-Message-State: APt69E3xhLMq/S4VVbu+lRTwI6TwNkNKJZxdVA83NJiqn/hoghmtBnQ/
        GraPoDTtNHbtFT0sS1q6n+0=
X-Google-Smtp-Source: AAOMgpcUiFmhKXRYH7x/nGFkJqKsa60Y/R9eoEw+sXvtXw/xmx9pmweG1k8VLcpBjyXs4neEDdpVpw==
X-Received: by 2002:a62:1c43:: with SMTP id c64-v6mr286596pfc.176.1529995464603;
        Mon, 25 Jun 2018 23:44:24 -0700 (PDT)
Received: from [192.168.86.235] (c-67-180-167-114.hsd1.ca.comcast.net. [67.180.167.114])
        by smtp.gmail.com with ESMTPSA id m25-v6sm1354332pfg.61.2018.06.25.23.44.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 25 Jun 2018 23:44:23 -0700 (PDT)
Subject: Re: [PATCH] NFC: llcp: fix nfc_llcp_send_ui_frame() lockup
To:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>
Cc:     Samuel Ortiz <sameo@linux.intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        Steven Rostedt <rostedt@goodmis.org>,
        Petr Mladek <pmladek@suse.com>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        linux-wireless@vger.kernel.org, netdev <netdev@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        syzbot <syzbot+d29d18215e477cfbfbdd@syzkaller.appspotmail.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
References: <20180626044119.30118-1-sergey.senozhatsky@gmail.com>
 <CACT4Y+ZvLqzEwXgdB25MrmAS_j2_HsS8NFaJaMojzMV3prXypg@mail.gmail.com>
 <20180626051221.GC31439@jagdpanzerIV>
From:   Eric Dumazet <eric.dumazet@gmail.com>
Message-ID: <8c410102-43ab-dfdb-0d71-2ee5951e1af8@gmail.com>
Date:   Mon, 25 Jun 2018 23:44:22 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180626051221.GC31439@jagdpanzerIV>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 06/25/2018 10:12 PM, Sergey Senozhatsky wrote:
> On (06/26/18 07:07), Dmitry Vyukov wrote:
> [..]
>>>  #include <net/nfc/nfc.h>
>>> @@ -755,7 +756,8 @@ int nfc_llcp_send_ui_frame(struct nfc_llcp_sock *sock, u8 ssap, u8 dsap,
>>>                 pdu = nfc_alloc_send_skb(sock->dev, &sock->sk, MSG_DONTWAIT,
>>>                                          frag_len + LLCP_HEADER_SIZE, &err);
>>>                 if (pdu == NULL) {
>>> -                       pr_err("Could not allocate PDU\n");
>>> +                       pr_err_ratelimited("Could not allocate PDU\n");
>>> +                       cond_resched();
>>>                         continue;
>>>                 }
>>
>>
>> But this thread is still in an infinite (unkillable?) loop? If yes, we
>> are waiting for the next syzbot report ;)
> 
> The loop is still infinite, correct, but we have a preemption point now.
> Sure, net people can come with a much better solution, I'll be happy to
> scratch my patch.
> 

This can not be the right solution, think about current thread being real time,
cond_resched() might be a nop.

We should probably not loop at all, or not use MSG_DONTWAIT.

(And remove this useless "Could not allocate PDU" message)

NFC maintainers should really take a look at this.
