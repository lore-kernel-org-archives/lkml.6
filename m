Return-Path: <SRS0=S+WB=KJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E603CC67790
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 13:55:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 13D0420852
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 13:55:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="heBWW+j2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 13D0420852
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729144AbeGYPHK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Jul 2018 11:07:10 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:36236 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728308AbeGYPHJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jul 2018 11:07:09 -0400
Received: by mail-pf1-f196.google.com with SMTP id d14-v6so1788488pfo.3;
        Wed, 25 Jul 2018 06:55:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=fA2m559H4MYtAYPVDpBveCgRZKhk3mqnDdKcvlxNrLE=;
        b=heBWW+j2SC1dSMNfzG8fH+OaSV0OLwerv4GmHXQu/W23adiGkK4Y5UB1jSZsUGaZvl
         PdAaCGir13LtPj9+DLV5iEvvIPhDXlt0DxtdhDmLDku5c1TFRVTvwWljPg0dzGIeuc+e
         DK9pzYUEdF4fzNsqxqFdorJbOmgx+EPpvOSJUtz8BIXGBrqU8vgRkmqX0E7jbWmLqiir
         XkJ7A+9JLFowmEgydPGWuGSJxc9gEQ5H1fvXb5lM3d0vA8lYwLaXiZ9D0ZpN0r1VCEio
         g9N0LspppFLQaMFOhiSnoqyWNSmXCcHxK0ur2ilIZuLTQGMurs+hluSTz7Y379lQQvWR
         4SSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=fA2m559H4MYtAYPVDpBveCgRZKhk3mqnDdKcvlxNrLE=;
        b=Uw8B1AAnvUmaSF+gjtfaPKt1BdTFtDdOmQ75M/Y+xa27jd2M9MK+/IptcYLoIaXv2F
         tzAWriXqj133qDKljA54T7kodzK7tQeGQjZ4By1M3S8q8mTsGf6biGDic4fMwd1tC0Y1
         /Z4zFfLYAf0hVH2e+JWAiyghRcth/t38JuG7NWkBVxf5ABPrTtCRsF8LMPzRU8EbMEgQ
         Ka6wGRDPWtbeobyr3Lub2MdFIH9iGm9vNt4FtLU9nMX1YBP+XTs0imJVDAPdtyS8Z1+t
         g8WClpPc/N3XkwMc6Dc03qJgdmGcF1LkVa42MfUyE06CGRW7ZEEaudX6By/uA1WElPBF
         GmQw==
X-Gm-Message-State: AOUpUlHBKg/+4qq/YLh07O8jJbN02c5svEJhng9TUMV5P80ii7AS6xpZ
        bl8xIl4CFTjruJQ9/y92YuJK/kHz
X-Google-Smtp-Source: AAOMgpfIFUhdjy5G/OUrcZh+5dAf70GzvWin3ydv09ynYOSgOde8mm/DOlPqqWAue7dJre1OU1KR0g==
X-Received: by 2002:a62:748:: with SMTP id b69-v6mr22182154pfd.177.1532526922307;
        Wed, 25 Jul 2018 06:55:22 -0700 (PDT)
Received: from [192.168.86.235] (c-67-180-167-114.hsd1.ca.comcast.net. [67.180.167.114])
        by smtp.gmail.com with ESMTPSA id 5-v6sm22466024pgc.86.2018.07.25.06.55.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 25 Jul 2018 06:55:21 -0700 (PDT)
Subject: Re: [PATCH net-next] tcp: add SNMP counter for the number of packets
 pruned from ofo queue
To:     Yafang Shao <laoar.shao@gmail.com>,
        Eric Dumazet <eric.dumazet@gmail.com>
Cc:     David Miller <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        netdev <netdev@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
References: <1532524010-11855-1-git-send-email-laoar.shao@gmail.com>
 <047bc12f-9eb5-e512-10c5-6334c494c77e@gmail.com>
 <CALOAHbCC=oWgzcA=VhkXq0rVLBa5_TvtbKtTqESGrgxvYTtH6w@mail.gmail.com>
From:   Eric Dumazet <eric.dumazet@gmail.com>
Message-ID: <096a8a2f-ea32-2107-b2af-c246450cc3b9@gmail.com>
Date:   Wed, 25 Jul 2018 06:55:20 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <CALOAHbCC=oWgzcA=VhkXq0rVLBa5_TvtbKtTqESGrgxvYTtH6w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 07/25/2018 06:40 AM, Yafang Shao wrote:

> 
> Because we want to know why packets were dropped.
> If that could be show in netstat, we could easily find that it is
> dropped due to ofo prune.


We have a counter already for these events : LINUX_MIB_OFOPRUNED

You want to add another counter tracking number of _skbs_,
which has no precise value for user,
given each skb can contain a variable number of _packets_.

