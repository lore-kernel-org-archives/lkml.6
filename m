Return-Path: <SRS0=G4S6=JN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A81EC43142
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 15:15:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E315D25EEE
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 15:15:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FG/ZYNin"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E315D25EEE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754761AbeF0PPN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Jun 2018 11:15:13 -0400
Received: from mail-it0-f68.google.com ([209.85.214.68]:53546 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752937AbeF0PPL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jun 2018 11:15:11 -0400
Received: by mail-it0-f68.google.com with SMTP id a195-v6so8070581itd.3;
        Wed, 27 Jun 2018 08:15:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=kjHInvt4pMcn0vt9zrZIeWXIkSa/EHpxMfGYNx9H6gk=;
        b=FG/ZYNiny8G/nqJcE9/MkmKP4nSpIhaVQdkx+TTJBtxpuSBB7VhyiFnjOCQZGmQ82s
         I8/1jbOU6mgFt/2ZlaXzy+uYm4e6i5/1ZUv3ImdNkbmt2TNGrcI89ltyVvn1JzIHPtIp
         UrCtqPPB8gyyidPCOeDnI2LG9jVqN+H4t4Kb6yjtf3d/SNqeRSuIski2nknuA3qw2fun
         a7hfiurko3qTLTzrL5YK1KJI/+w7x+j9Y8Wk63QXw+9XXjOIA3mTcZqzGiAam88S+MhD
         YhHG4J2tcjyKQr8H3mYInobJRmZIxBFnIKz23SqnQLDEpRlT6VZk3a9/94ZI5YuVFNif
         BtxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=kjHInvt4pMcn0vt9zrZIeWXIkSa/EHpxMfGYNx9H6gk=;
        b=Gk//zY6oFY93RNAQsdP7NyJasCJxJSQIhjunsdWy2J0rzUu1qEaGW3PawCz31Dej8L
         5TV5OjxV4h3I7aS47NXHo8otDY8nJFbQ6eT63s16kR9ws8hWXemf4Z4/vCJvCwb/x82a
         vupa7to7O/D+87EkEVbL7N2UgawOV+X2TBCU/ySiBbYZaOf0l+zG1+LCuLyLciXPBHji
         bF0zZ7CAhf+V8yMXfKTgmBCxReE7fklXBIYP4/J7RV/EmJuf/ggjZXzYzRbc7nE9gdBR
         Q76evDIt66fwKqkeIp9T6KKVvYJzRMTz0qFkh776UliLtqt2cOR+XdFV5quLDwZXX/1W
         wlqA==
X-Gm-Message-State: APt69E332gUFCWBHzLWX+lArxSZwx/rzGAXy/GL4KrZmHQPELq1wtXTg
        g69+MydSRHgTzIszTbDh4fPDX20cnnVN+x4ZV1g=
X-Google-Smtp-Source: ADUXVKIvVf8rVMyk1Vk6BuxPDA1boL4HieNAdoW/8wKtRJhXR7jMHFnYo+vrIcFxVGp2CDmlMoCHCyKteyImybVAUYo=
X-Received: by 2002:a24:4457:: with SMTP id o84-v6mr5275706ita.142.1530112510648;
 Wed, 27 Jun 2018 08:15:10 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a6b:ef03:0:0:0:0:0 with HTTP; Wed, 27 Jun 2018 08:14:30
 -0700 (PDT)
In-Reply-To: <c89b70f9-e70d-35a5-b9a7-7e3ed7d34edf@gmail.com>
References: <1530100216-13070-1-git-send-email-laoar.shao@gmail.com> <c89b70f9-e70d-35a5-b9a7-7e3ed7d34edf@gmail.com>
From:   Yafang Shao <laoar.shao@gmail.com>
Date:   Wed, 27 Jun 2018 23:14:30 +0800
Message-ID: <CALOAHbCdRjq2n37GpeBdorcbxXMDX2vNDLftypViJd5hRTA28A@mail.gmail.com>
Subject: Re: [PATCH net-next] tcp: replace LINUX_MIB_TCPOFODROP with
 LINUX_MIB_TCPRMEMFULLDROP for drops due to receive buffer full
To:     Eric Dumazet <eric.dumazet@gmail.com>
Cc:     Eric Dumazet <edumazet@google.com>,
        David Miller <davem@davemloft.net>,
        netdev <netdev@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 27, 2018 at 10:48 PM, Eric Dumazet <eric.dumazet@gmail.com> wrote:
>
>
> On 06/27/2018 04:50 AM, Yafang Shao wrote:
>> When sk_rmem_alloc is larger than the receive buffer and we can't
>> schedule more memory for it, the skb will be dropped.
>>
>> In above situation, if this skb is put into the ofo queue,
>> LINUX_MIB_TCPOFODROP is incremented to track it,
>> while if this skb is put into the receive queue, there's no record.
>>
>> So LINUX_MIB_TCPOFODROP is replaced with LINUX_MIB_TCPRMEMFULLDROP to track
>> this behavior.
>
>
> Hi Yafang
>
> I do not want to remove TCPOFODrop and mix multiple causes in one single counter.
>
> Please take a look at commit a6df1ae9383697c to have the reasoning.
>

Got it!

What about introduce a new counter, i.e. TCPRcvQFullDrop ?

Thanks
Yafang
