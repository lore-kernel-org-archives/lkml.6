Return-Path: <SRS0=7Z+k=KK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B56DBC6778F
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 01:44:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D96020685
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 01:44:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UMgl/HWc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6D96020685
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728666AbeGZC5z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Jul 2018 22:57:55 -0400
Received: from mail-it0-f66.google.com ([209.85.214.66]:37232 "EHLO
        mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728378AbeGZC5y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jul 2018 22:57:54 -0400
Received: by mail-it0-f66.google.com with SMTP id h20-v6so576774itf.2;
        Wed, 25 Jul 2018 18:43:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=28igxy1/bTrjGplMxdc/TLk+L1N2lSFIChL3GAHhTrU=;
        b=UMgl/HWcnQw+1W141j7+F2WD6vdAyuF9l8bxqTSFV4Wjysa4z0tJWBKHmPDbbKfOhg
         gJHtMq/4DmXccSFOuYmOEoL9HI4FQRrz0jyRY0SU8JSkMk1/wOwBLcTr7u4irGa3Ov5S
         CbtwyX8E3SyLuxA7sE6YmkZJt3ozx+UkBK33btrVWLkadFbxt1aztuRROuKd2zZJliYA
         xrnYyibPgC5Stm4oL3np5nQI1qfy+Btif9lLDqFJxRew9HuzIaJFbD5CxqPHXPNTB1Q8
         uOF+K6qJc9S10lUEwp52+pFrdfbwHXrtlXd/G0b1yMbj6CiNscHHV9sPyc1XELrQttF/
         L2Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=28igxy1/bTrjGplMxdc/TLk+L1N2lSFIChL3GAHhTrU=;
        b=Jq5C02ya85KW2w4JUrX7XTUjZ6sMWwfqFvntpuP+AqlYf4Sn1idz+RXg5wWog5YqxY
         /45NVlt80JymKdhfOZik6xfn5ltPeTwF9q4+DyAJDeEtSXOIgzzob+yTGKaoxUD8X0UG
         BEriRAGZkIassL/3Bs//87kbSMM/c2TSfe0V38vaCsG4q1xfKXSqN3HBOEvYMlowifkR
         e7me1f0eWnkN9Vgm8M2PTjfGHMQyfaQ8Nq7+FXF3uf4YvaraNV+grOcgYC0L0RvB3OOC
         /ZkAxUfSm3UDSQQAZIyzbF/CI9B9lKN2ZzYaTJZ2ENOQdJqgZH1sT9mV+EG+0ZcCx3a/
         QJYw==
X-Gm-Message-State: AOUpUlEetBH5I8jLLY3/Yj+eHJyhX4Pgnds3Jp2STz1ChkYW+W/1ZVIc
        pE4Smok41ZRGn76LSczZvFfrLzHcX2AkSEDp97s=
X-Google-Smtp-Source: AAOMgpcbWlRvdyPkowGynOqN77EmixXSvGF0A9OciEeBXh+NnSDtzJKurfkf849bbv0jlfv0wWtAXscKMCHxna28IIg=
X-Received: by 2002:a24:5004:: with SMTP id m4-v6mr334420itb.38.1532569411010;
 Wed, 25 Jul 2018 18:43:31 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a6b:7a47:0:0:0:0:0 with HTTP; Wed, 25 Jul 2018 18:42:50
 -0700 (PDT)
In-Reply-To: <CALOAHbASvcEdudqpit-c=RRZ8xVD+G+0jU-ynp9PsH4_mU7xjw@mail.gmail.com>
References: <1532524010-11855-1-git-send-email-laoar.shao@gmail.com>
 <047bc12f-9eb5-e512-10c5-6334c494c77e@gmail.com> <CALOAHbCC=oWgzcA=VhkXq0rVLBa5_TvtbKtTqESGrgxvYTtH6w@mail.gmail.com>
 <096a8a2f-ea32-2107-b2af-c246450cc3b9@gmail.com> <CALOAHbASvcEdudqpit-c=RRZ8xVD+G+0jU-ynp9PsH4_mU7xjw@mail.gmail.com>
From:   Yafang Shao <laoar.shao@gmail.com>
Date:   Thu, 26 Jul 2018 09:42:50 +0800
Message-ID: <CALOAHbAHgEF_=w_hbd_03NOH3h9m-4W=UJ0HCYGK0BtEyq=5Tw@mail.gmail.com>
Subject: Re: [PATCH net-next] tcp: add SNMP counter for the number of packets
 pruned from ofo queue
To:     Eric Dumazet <eric.dumazet@gmail.com>
Cc:     David Miller <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        netdev <netdev@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 25, 2018 at 9:59 PM, Yafang Shao <laoar.shao@gmail.com> wrote:
> On Wed, Jul 25, 2018 at 9:55 PM, Eric Dumazet <eric.dumazet@gmail.com> wrote:
>>
>>
>> On 07/25/2018 06:40 AM, Yafang Shao wrote:
>>
>>>
>>> Because we want to know why packets were dropped.
>>> If that could be show in netstat, we could easily find that it is
>>> dropped due to ofo prune.
>>
>>
>> We have a counter already for these events : LINUX_MIB_OFOPRUNED
>>
>> You want to add another counter tracking number of _skbs_,
>> which has no precise value for user,
>> given each skb can contain a variable number of _packets_.
>>
>
> Got it.
>
> But with LINUX_MIB_OFOPRUNED, we only know  tcp_prune_ofo_queue is
> called, but have no idea how many skbs are dropped.
>


Hi Eric,

LINUX_MIB_TCPOFOQUEUE, LINUX_MIB_TCPOFODROP and LINUX_MIB_TCPOFOMERGE
are all for the number of SKBs, but only  LINUX_MIB_OFOPRUNED is for
the event, that could lead misunderstading.
So I think introducing a counter for the number of SKB pruned could be
better, that could help us to track the whole behavior of ofo queue.
That is why I submit this patch.


Thanks
Yafang
