Return-Path: <SRS0=n5k7=KW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D5E4C4646D
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 01:41:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 03D5B21A5E
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 01:41:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KWBhfIVJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 03D5B21A5E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387448AbeHGDxP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Aug 2018 23:53:15 -0400
Received: from mail-it0-f68.google.com ([209.85.214.68]:37831 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729786AbeHGDxP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Aug 2018 23:53:15 -0400
Received: by mail-it0-f68.google.com with SMTP id h20-v6so20905469itf.2;
        Mon, 06 Aug 2018 18:41:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=duih8xtEl8dcKiqrRSMQb8mIrFSoiDvO60a+C7OqFL8=;
        b=KWBhfIVJi0dxw9QHd6G6IQ3VAZUpamRA+Nr0tvbTMwq/o7oYzM3I/P6VfwmyaBij85
         oo9GZVllOr+nTOFkrgi28rajocHE481finmQy/qDdvI5Ug7LiIZI3aJrwIHJQHUi01D+
         4diRyn2FHJ+2jP3CyMX+rHBIM8+i/tFAz9Lf4NFDY/6Oj/exkkXb/ase0oR9iBsb3t2a
         jMLEgMB0a7cP01Ejs1mdWSkum3WPT4P4xUOJn9255Q5+wrDxbuA5+3FUbMlfB4syOhNo
         rI4lolJw35zoGPFsJ0j6tvMvDsAMn0rRXg1dDPaIkPqaL9SV6iKBLSBfYvU0rR4CjOk+
         5kdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=duih8xtEl8dcKiqrRSMQb8mIrFSoiDvO60a+C7OqFL8=;
        b=SrYio03UiwLejZVWuoTTNkiXsa9NRzWIsSCx77Ym+lo+Eaar9i2SyplwCS3AEmlx2g
         qD3iDykzp9PxOxqKjfTB63sZmjwdoJ8bE8MOLFSev82wFJMYQ+CK8Txhdp7426gdUaWq
         38zT7LshJGlGTdX5Tiyh7YOI/JAe/zP5YZ9qf5wUau+NYCX0fLe863ZLfmpXb/s7FhEG
         Mu8pA//asqOyN8oYGuNqCXWY2kQkiQxFixA9z1aTNsM3Jr15xFGw54+xT3/WrLeYk8ee
         cJjrGtjgw8s9QhC07j9pWg7Q1GL4Z/AgN56/iUDU97235OeCDa1hAZBC6Uv+JLkhx2PW
         lsqQ==
X-Gm-Message-State: AOUpUlHiAO5Yg8cuuV946QrV8cJPM6j5h/JdO8Sq2DKdizKLGCH0+Weg
        lO8g97xYrWnPRDAoQ/v/UIlyNl6MOoYJWY905+U=
X-Google-Smtp-Source: AA+uWPzefWo9c20Ljy8RNe7d4hOdJ3dmErx+JxqGHFdFCcjZbMtpLfSaqkzvk3dpCw/9BJ8wF/J/AZ9rr/Tm5JFZwWI=
X-Received: by 2002:a24:5004:: with SMTP id m4-v6mr347247itb.38.1533606082906;
 Mon, 06 Aug 2018 18:41:22 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a6b:7a47:0:0:0:0:0 with HTTP; Mon, 6 Aug 2018 18:40:42 -0700 (PDT)
In-Reply-To: <20180806.134116.1016660959593702560.davem@davemloft.net>
References: <1533556020-20778-1-git-send-email-laoar.shao@gmail.com> <20180806.134116.1016660959593702560.davem@davemloft.net>
From:   Yafang Shao <laoar.shao@gmail.com>
Date:   Tue, 7 Aug 2018 09:40:42 +0800
Message-ID: <CALOAHbBU4ntM7YBuD1QAXybmJkOa2K10WksxXDF91ci=TFc+pw@mail.gmail.com>
Subject: Re: [PATCH net-next] tcp: fix the calculation of sysctl_max_tw_buckets
 in tcp_sk_init()
To:     David Miller <davem@davemloft.net>
Cc:     Eric Dumazet <edumazet@google.com>,
        yanhaishuang@cmss.chinamobile.com, netdev <netdev@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 7, 2018 at 4:41 AM, David Miller <davem@davemloft.net> wrote:
> From: Yafang Shao <laoar.shao@gmail.com>
> Date: Mon,  6 Aug 2018 19:47:00 +0800
>
>> tcp_hashinfo.ehash_mask is always an odd number, which is set in function
>> alloc_large_system_hash(). See bellow,
>>       if (_hash_mask)
>>               *_hash_mask = (1 << log2qty) - 1; <<< always odd number
>>
>> Hence the local variable 'cnt' is a even number, as a result of that it is
>> no difference to do the incrementation here.
>>
>> Maybe the compiler could also optimize it, but this code is a little ugly.
>>
>> Fix: fee83d09 ("ipv4: Namespaceify tcp_max_syn_backlog knob")
>
> The correct tag is "Fixes: "

OK

>
>> @@ -2543,7 +2543,7 @@ static int __net_init tcp_sk_init(struct net *net)
>>       net->ipv4.sysctl_tcp_tw_reuse = 2;
>>
>>       cnt = tcp_hashinfo.ehash_mask + 1;
>> -     net->ipv4.tcp_death_row.sysctl_max_tw_buckets = (cnt + 1) / 2;
>> +     net->ipv4.tcp_death_row.sysctl_max_tw_buckets = cnt / 2;
>>       net->ipv4.tcp_death_row.hashinfo = &tcp_hashinfo;
>
> This is completely harmless, and does no harm.
>

It is harmless, meanwhile, it is useless and a little ugly.

By the way,  why do we init sysctl_max_tw_buckets to
(tcp_hashinfo.ehash_mask + 1) / 2 or (tcp_hashinfo.ehash_mask + 2) / 2
?
Per my pespective, this default value is a little huge, sometimes we
have to set this value to a lower value with sysctl, otherwise it may
easily cause tcp port exhaustion issue.
So why not just init it to a lower value ?

> You aren't "fixing" anything.
