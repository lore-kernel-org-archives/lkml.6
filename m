Return-Path: <SRS0=wmYC=LT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83005C43334
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 17:20:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC79E205F4
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 17:20:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VV1o7zKD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DC79E205F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727618AbeIEVvc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Sep 2018 17:51:32 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:38510 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726046AbeIEVvb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Sep 2018 17:51:31 -0400
Received: by mail-pg1-f194.google.com with SMTP id t84-v6so1915947pgb.5;
        Wed, 05 Sep 2018 10:20:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=wnx/ZOvS5d0n+6j7g/r6JfgSgXoLQ3mVXKAWL2lMhpA=;
        b=VV1o7zKDRMabx9R8yt0SZJK3IgyrDJ/Swoa5KgmXi3EAOgp6NG0bCRmKqnZ89hllFy
         Na2+ZN4OQtSYuuaoff5QgPAUAmyfaSa2g+R1/l4u38RBkhy4gGxI6AZQHaeKJulQj/Kl
         a2u/7E5B1gFcCdmrUB8NcuXXz8TXzGyFzf9Mxqfs5T48FOjbad0f7OVD+FppxHTiQHuf
         gxI+O4KauVwfLZfw41F2mfkhgQ/G9f4Hj9fVs+qNTZ0MObc6eo2lfh5KGmdhRJ2Rm6N2
         uBhdz+ZNcRF+hRyCy3P9YZjGljG9TBv5O4rS9KqzZ1At7wB/AZyfZvyO37Q9SshFd0eq
         CLHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=wnx/ZOvS5d0n+6j7g/r6JfgSgXoLQ3mVXKAWL2lMhpA=;
        b=tHgisLgzTsdwJTvOTk43lfrXwUIlLaRWtaX3MYFMUkvjHzQ+cilJkJpwsAyPMr6IER
         091OLGU9ybKMm+5oN8xYIrTKyRxCNp0BnwXT2faFrG+WpFl6q1kSybhax7FHVe0I28bq
         yVjfs6o8XiL7FUxoFJYE3FBOnjaeygUVg62FE0okU/yM5vvW/16fMzrAe7rluVtTSuLS
         7/bCoKgx8tvntxmhUj7EOUHzh7rc9FzbgmA4hdRZeKBaU8csFCQ+vY4ZI8QgVFAO2dHO
         jT7OAiwgaIzh5wmXdGaPOdckBab9BazXGrgi2A2O1thMqQLvIpShlsbUS0N6i49vQ1Yh
         aeCw==
X-Gm-Message-State: APzg51A5bDTRBnxIjF7suqJIgNqX0VOmZ1TjwGbn26h+Zz3o+nBVIGQE
        v9pp14yaH5OhLVOIpqngdFg=
X-Google-Smtp-Source: ANB0VdahC0a67MCFQ0Wn4e3RazfK5O2/mi5Az6zBwuW/48DuL5Vkyn86CgqpWdMW0PQ7AOodf8C7hA==
X-Received: by 2002:a63:c14a:: with SMTP id p10-v6mr37710371pgi.305.1536168024024;
        Wed, 05 Sep 2018 10:20:24 -0700 (PDT)
Received: from dsa-mb.local ([2601:282:800:fd80:cbf:8500:e2a8:f094])
        by smtp.googlemail.com with ESMTPSA id 143-v6sm4588575pfy.156.2018.09.05.10.20.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 05 Sep 2018 10:20:22 -0700 (PDT)
Subject: Re: [RFC PATCH net-next V2 0/6] XDP rx handler
To:     Jason Wang <jasowang@redhat.com>,
        Jesper Dangaard Brouer <jbrouer@redhat.com>
Cc:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        ast@kernel.org, daniel@iogearbox.net, mst@redhat.com
References: <1534130250-5302-1-git-send-email-jasowang@redhat.com>
 <20180814003253.fkgl6lyklc7fclvq@ast-mbp>
 <5de3d14f-f21a-c806-51f4-b5efd7d809b7@redhat.com>
 <20180814121734.105769fa@redhat.com>
 <03ab3b18-9b13-8169-7e68-ada307694bc1@redhat.com>
 <08bf7aec-078a-612d-833f-5b3d09a289d0@gmail.com>
 <aa9cf883-7822-70a7-5ab5-c873b69c2098@redhat.com>
 <f4c0346d-6665-5312-0310-ffbda505b7ec@gmail.com>
 <2792239a-ed3b-d66e-0c1c-e99455311eff@redhat.com>
 <ae0e09a1-a20a-a2fc-36a0-82e109216bf4@gmail.com>
 <9a1d9340-8fd0-4e27-0938-adf361fe6939@redhat.com>
From:   David Ahern <dsahern@gmail.com>
Message-ID: <99d3e3d0-a14d-7789-2777-67421c7d4a20@gmail.com>
Date:   Wed, 5 Sep 2018 11:20:20 -0600
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:52.0)
 Gecko/20100101 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <9a1d9340-8fd0-4e27-0938-adf361fe6939@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ sorry for the delay; focused on the nexthop RFC ]

On 8/20/18 12:34 AM, Jason Wang wrote:
> 
> 
> On 2018年08月18日 05:15, David Ahern wrote:
>> On 8/15/18 9:34 PM, Jason Wang wrote:
>>> I may miss something but BPF forbids loop. Without a loop how can we
>>> make sure all stacked devices is enumerated correctly without knowing
>>> the topology in advance?
>> netdev_for_each_upper_dev_rcu
>>
>> BPF helpers allow programs to do lookups in kernel tables, in this case
>> the ability to find an upper device that would receive the packet.
> 
> So if I understand correctly, you mean using
> netdev_for_each_upper_dev_rcu() inside a BPF helper? If yes, I think we
> may still need device specific logic. E.g for macvlan,
> netdev_for_each_upper_dev_rcu() enumerates all macvlan devices on top a
> lower device. But what we need is one of the macvlan that matches the
> dst mac address which is similar to what XDP rx handler did. And it
> would become more complicated if we have multiple layers of device.

My device lookup helper takes the base port index (starting device),
vlan protocol, vlan tag and dest mac. So, yes, the mac address is used
to uniquely identify the stacked device.

> 
> So let's consider a simple case, consider we have 5 macvlan devices:
> 
> macvlan0: doing some packet filtering before passing packets to TCP/IP
> stack
> macvlan1: modify packets and redirect to another interface
> macvlan2: modify packets and transmit packet back through XDP_TX
> macvlan3: deliver packets to AF_XDP
> macvtap0: deliver packets raw XDP to VM
> 
> So, with XDP rx handler, what we need to just to attach five different
> XDP programs to each macvlan device. Your idea is to do all things in
> the root device XDP program. This looks complicated and not flexible
> since it needs to care a lot of things, e.g adding/removing
> actions/policies. And XDP program needs to call BPF helper that use
> netdev_for_each_upper_dev_rcu() to work correctly with stacked device.
> 

Stacking on top of a nic port can have all kinds of combinations of
vlans, bonds, bridges, vlans on bonds and bridges, macvlans, etc. I
suspect trying to install a program for layer 3 forwarding on each one
and iteratively running the programs would kill the performance gained
from forwarding with xdp.

