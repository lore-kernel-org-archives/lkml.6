Return-Path: <SRS0=n7Wc=J2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63E68C3279B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 12:48:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0DD24208E3
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 12:48:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iYbht0ki"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0DD24208E3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754439AbeGJMs1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Jul 2018 08:48:27 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:46474 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751201AbeGJMsZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jul 2018 08:48:25 -0400
Received: by mail-pf0-f194.google.com with SMTP id l123-v6so16017196pfl.13;
        Tue, 10 Jul 2018 05:48:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=t4Hr5h5TPA6MdWw4GEBymgaHp4gbuFgRfPybtZGR3DU=;
        b=iYbht0kiLswSypU/o2BBkxlqz/VHSEYfDiB+HRp/JrgFrPYXdd3dVH2iL1+agrUFeC
         EVmWD7lFeMFA49xM5/Nc4CearejaGSpRSg3AWpLeEOXa5v/Yuf3BiX7lbrvCBhv3sPN7
         CkTWOruoRAim64IKAnB9cOyy9d0H5/WYNaY+KrOU1nCiYzRTq2grA4SwtceR3YrjzJZi
         IMtfj6R6GoLqMUSG8ptgLNkf9aW7mn86c6t/LEcBRCmc+DdtEBez8oyS+sMSOiXaOKAf
         fT2qemn+Uq42bYIxaj96sIDuuAi2XRmrtCYXe/3PIDfucBb+3f8mnMrS5UG5v94uIOlx
         wKvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=t4Hr5h5TPA6MdWw4GEBymgaHp4gbuFgRfPybtZGR3DU=;
        b=lZkcgplr+ztniyEds2w6JZLOaaXLdE7eRYObt7zoNW/JMQNA7fO9jRflx5wtEEQKA/
         LQFjJBg5MUkzqyPMPi4b18QEkZY9sabBGEzZ2iGJ4UL/2rrNFZEGaioNvqnZ5b82XaXP
         yzfFsVgM5miat6jOtWcUVraXI6Ca9pD33sHeV3tsqgsFoh8RtKhdYVX7k0GKf6ZJimFI
         dC5sFnoM/H7axpFh8Br8mMDz4yCJfsxOiP+Gp7p26Zk+XLPfNj37if2QiOKwV5PW114e
         011zPZQ1QaIU536VCt+F7lcwiTXZQjEEils6qNjSFnuloUT24RkHDyPymuCxTgPDC+H2
         cabA==
X-Gm-Message-State: APt69E0zdpfFSQkPvrsK9EUnpY64fQkl2X5KILH1eLVls/KBSs3sjYdx
        c5X6W04gknlT3Yp/aL3kqW0=
X-Google-Smtp-Source: AAOMgpc54ZFwQLjnTOjjhV+BBwIV8lDtFHuxl1EHv6sPhExdTMmGYU2Xt9kdVnxI80GkY8QN9BMbkg==
X-Received: by 2002:aa7:81d3:: with SMTP id c19-v6mr25654455pfn.224.1531226904938;
        Tue, 10 Jul 2018 05:48:24 -0700 (PDT)
Received: from [192.168.86.235] (c-67-180-167-114.hsd1.ca.comcast.net. [67.180.167.114])
        by smtp.gmail.com with ESMTPSA id 77-v6sm56435634pga.40.2018.07.10.05.48.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 10 Jul 2018 05:48:23 -0700 (PDT)
Subject: Re: [net-next,v3] tcp: Improve setsockopt() TCP_USER_TIMEOUT accuracy
To:     Jon Maxwell <jmaxwell37@gmail.com>, davem@davemloft.net
Cc:     edumazet@google.com, ncardwell@google.com, David.Laight@aculab.com,
        kuznet@ms2.inr.ac.ru, yoshfuji@linux-ipv6.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        jmaxwell@redhat.com
References: <20180710065147.27647-1-jmaxwell37@gmail.com>
 <3f856638-52bc-6630-a3d2-2b50f1bf7e48@gmail.com>
From:   Eric Dumazet <eric.dumazet@gmail.com>
Message-ID: <c29f1535-3c5d-e588-862c-ba948363c973@gmail.com>
Date:   Tue, 10 Jul 2018 05:48:22 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <3f856638-52bc-6630-a3d2-2b50f1bf7e48@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 07/10/2018 05:38 AM, Eric Dumazet wrote:

> Note that if we always do jiffies_to_msecs(icsk->icsk_user_timeout) in TCP,
> we also could change the convention and store msecs in this field instead of jiffies.
> 
> That would eliminate the msecs_to_jiffies() and jiffies_to_msecs() dance.
> 
> (That would be done in a patch of its own, of course)

tcp_keepalive_timer() does use icsk->icsk_user_timeout directly in jiffies unit,
but considering keeapalive timers are rarely used, this point would have to
do the msecs_to_jiffies() conversion.
