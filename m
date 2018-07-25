Return-Path: <SRS0=S+WB=KJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 103A0C67790
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 13:33:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE1F020882
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 13:33:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qlzSVD2A"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BE1F020882
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729187AbeGYOpZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Jul 2018 10:45:25 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:44044 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728529AbeGYOpZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jul 2018 10:45:25 -0400
Received: by mail-pg1-f193.google.com with SMTP id r1-v6so5339579pgp.11;
        Wed, 25 Jul 2018 06:33:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=MzhSwLs6JDLcZZP9ZORoYcwAxFxuqOuAMh5qsQ586OY=;
        b=qlzSVD2A5ayTWCP0SzVyJCyBesSWLY+oDBr6ZMSiArl0TMFeqnYPqK1DflCqdfUiP2
         pc6vbU9PwbBFnPuHYWBCXs1FBBYKIwS+AZb9sklxxDR+B2WytUP9iNmKRKUGi3IWRfPl
         S0aqmvcLEodNVol0inAMhhTb0c8G/5HuaCV6+d7orfYCyWw1uZEugBwDaIsULJg62diy
         GljuoyEiWyU8PRdDQgpTFJ709FHyCpugPjCL9w056QbjupmR1h2k7sP7YNZULNC5TSFn
         iXtwPiCXlj4foG74pcPwp9kUa57xpIBLGpi5zCSr8U/06VXulbBdGZ/96WtcyWgjmGMW
         HOBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=MzhSwLs6JDLcZZP9ZORoYcwAxFxuqOuAMh5qsQ586OY=;
        b=OMrYChjqQo/68fpsOt4GfV6kX/mdP25vdOa8FmnIHoX4iFthXDMPVw1HUdKfEktp/A
         GItBWaWPbtVXRB+0bQ+telZJpH4H4zREQvTtVsokZAO41cnPhxNOP5cG3Z7Mc1IQoUbv
         eN2X8Ow9gjf2u/kxYZuJMsoxOMTXmh3+KAeWNloj1Xu2MDAzOQ0J5i8Wr0WjDfStx9YL
         c4z5Xu3jRPyyArfSqR29413S35afJh6C8wQAZ5lSf89q0L7/stta3/73rzIqXk08tepD
         1dmoX/Wil+nm2Zy480j0DBfLG5J9gRxKt15QhBOg9HCzVSXEguE0B+2JxZMJvAU/R2jV
         +hRw==
X-Gm-Message-State: AOUpUlEZ3NgUmwqaLV7WzHD0xvE0Bx+BHrNIgx8vTsuxWzdhlAYDpwL1
        PDxuosKKJGNLkfHTKn/J2j7y4t7U
X-Google-Smtp-Source: AAOMgpf6ygze2q2p6fXe2iFd9ocgyFUpgbKyh9OfvOq3/YFakvjucfRpuo+DFn7NPXm8XVcGCiGOWQ==
X-Received: by 2002:a62:9b57:: with SMTP id r84-v6mr22047014pfd.6.1532525623143;
        Wed, 25 Jul 2018 06:33:43 -0700 (PDT)
Received: from [192.168.86.235] (c-67-180-167-114.hsd1.ca.comcast.net. [67.180.167.114])
        by smtp.gmail.com with ESMTPSA id t14-v6sm15224855pgu.0.2018.07.25.06.33.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 25 Jul 2018 06:33:42 -0700 (PDT)
Subject: Re: [PATCH net-next] tcp: add SNMP counter for the number of packets
 pruned from ofo queue
To:     Yafang Shao <laoar.shao@gmail.com>, davem@davemloft.net,
        edumazet@google.com
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1532524010-11855-1-git-send-email-laoar.shao@gmail.com>
From:   Eric Dumazet <eric.dumazet@gmail.com>
Message-ID: <047bc12f-9eb5-e512-10c5-6334c494c77e@gmail.com>
Date:   Wed, 25 Jul 2018 06:33:41 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <1532524010-11855-1-git-send-email-laoar.shao@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 07/25/2018 06:06 AM, Yafang Shao wrote:
> LINUX_MIB_OFOPRUNED is used to count how many times ofo queue is pruned,
> but sometimes we want to know how many packets are pruned from this queue,
> that could help us to track the dropped packets.
> 
> As LINUX_MIB_OFOPRUNED is a useful event for us, so I introduce a new
> SNMP counter LINUX_MIB_OFOPRUNEDROP, which could be showed in netstat as
> OfoPruneDrop.


Okay, but why tracking number of skbs that are removed ?

Skb can contain many segments (because of GRO and TCP coalescing)

So your claim of tracking dropped packets is ill defined.

Also I prefer having net tree being merged into net-next, since your patch would
add a merge conflict.


