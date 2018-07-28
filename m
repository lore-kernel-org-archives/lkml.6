Return-Path: <SRS0=xGmI=KM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34F34C6778F
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Jul 2018 16:29:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D686020878
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Jul 2018 16:29:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="H7JZGVmi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D686020878
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729283AbeG1R4I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 28 Jul 2018 13:56:08 -0400
Received: from mail-io0-f194.google.com ([209.85.223.194]:35647 "EHLO
        mail-io0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729238AbeG1R4H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Jul 2018 13:56:07 -0400
Received: by mail-io0-f194.google.com with SMTP id w11-v6so6607295iob.2
        for <linux-kernel@vger.kernel.org>; Sat, 28 Jul 2018 09:29:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7PwynDpToed+TUoMbg8D4UlLiZYVpuSwuwOqeSAmzho=;
        b=H7JZGVmiKpqn7Jb1D8OaiYLfgG3w6Csxs8QB8CwGsoB8NJVKzhkBRaZMS0NfMfADkF
         LJfmbDqMsh/zOD2yhnFiRTfMncVJIMCcdcvTZQg5q5GXvU+OATEU7yr6iS5fGbe/fH3+
         pnHQcevlqazeF/7my2pJvmIuouC5hrE3rglhVN4X9rMyMAfOiTXaoX3IMlGTbX9DETi8
         jbIeETer6Yur4+V+o6U3AkTKCY70W7bXu7w4V54ON59CqaNnisC4iRce8hUPRml9ZLqR
         9+9WjwdAhmFYE69Ok4ylljok0N/QxoSmp+ydppf+LNXPZ8CGdbZi318SBdSB9fxM0Eeo
         x8Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7PwynDpToed+TUoMbg8D4UlLiZYVpuSwuwOqeSAmzho=;
        b=iFyRNTMRfDQhUOyCBp9SBhgSDps73M9QCCuMA0yKhwKZkA3hhMr/3yT1/wpuqJfySI
         L5RY9DqJK4x0UlyAy39mIU76+hv37uX/Lo2DDaUwwpiGas2Q4l64e1ZV3rVHunjFuffR
         1FJwdhknaVZn7/hO0yRHml3f1rTR4qIlvO4NtEhSXimGKIpqVOvjX9F8e5ZshKe/9tzZ
         gjlKowfH2RmCYkSH1hrF9cZajDfLMsZWjzlBPIBln4cyVYzzxqCLJn+wjFNV8Y2R2KpE
         GxSAJg44fmK/737RAjiZ9iyrLWpMXPYCr0YDt7u9e6KNW9NBWskz2jB8jwlJsm9xsiFi
         u/yA==
X-Gm-Message-State: AOUpUlEUjOJThUugjO6dTJqTJ84wLSGO7tFyPH/nPnS/7oNVkFbq1N0R
        qNbtkvQEvNw4Wp/cDzg52MsZWjPhj+JQYHeS015rSg==
X-Google-Smtp-Source: AAOMgpdN9goQgRX1rG/FzKytWZD/SMcPnq8jL4eFGf05TFox11lDEsJQCp5uLTCQo6xPqYr5zp09QkKzLJBqlJLuDOw=
X-Received: by 2002:a6b:f10f:: with SMTP id e15-v6mr8061747iog.271.1532795344151;
 Sat, 28 Jul 2018 09:29:04 -0700 (PDT)
MIME-Version: 1.0
References: <1532746900-11710-1-git-send-email-laoar.shao@gmail.com>
 <CANn89iJ=Ad7sVWr3zBmXNSyePJJZaxgnMymN8S7x6fCSvG2jTQ@mail.gmail.com>
 <CALOAHbC4Rs7w1RwZRBsw_fjGSDvuHV37=nguzJNZzkreR5f4Dw@mail.gmail.com>
 <CANn89iKXPu=RKkLop4NJWZLixE__qYV2S=PngSj6ienuvWWL8g@mail.gmail.com> <CALOAHbAjtNf1LOhWEJMKNEEHSxjfEKiVV22KPUK88CTzt-eW0w@mail.gmail.com>
In-Reply-To: <CALOAHbAjtNf1LOhWEJMKNEEHSxjfEKiVV22KPUK88CTzt-eW0w@mail.gmail.com>
From:   Eric Dumazet <edumazet@google.com>
Date:   Sat, 28 Jul 2018 09:28:52 -0700
Message-ID: <CANn89i+12HvAsvk9crDcqGh=v-DvLjuGQCOzVTPVDTUhHgeDiw@mail.gmail.com>
Subject: Re: [PATCH net-next 1/2] tcp: call tcp_drop() in tcp collapse
To:     Yafang Shao <laoar.shao@gmail.com>
Cc:     David Miller <davem@davemloft.net>,
        netdev <netdev@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 28, 2018 at 12:43 AM Yafang Shao <laoar.shao@gmail.com> wrote:
>
> On Sat, Jul 28, 2018 at 11:38 AM, Eric Dumazet <edumazet@google.com> wrote:
> > On Fri, Jul 27, 2018 at 8:35 PM Yafang Shao <laoar.shao@gmail.com> wrote:
> >
> >> So what about LINUX_MIB_TCPOFOMERGE ?
> >> Regarding LINUX_MIB_TCPOFOMERGE,  a skb is already covered by another
> >> skb, is that dropping the packet or simply lowering the memory
> >> overhead ?
> >
> > What do you think ?
> >
> > If you receive two times the same payload, don't you have to drop one
> > of the duplicate ?
> >
> > There is a a big difference between the two cases.
>
> If the drop caused some data lost (which may then cause retransmition
> or something), then this is a really DROP.
> While if the drop won't cause any data lost, meaning it is a
> non-harmful behavior, I think it should not be defined as DROP.
> This is my suggestion anyway.

Sigh.

We count drops, not because they are ' bad or something went wrong'.

If TCP stack receives twice the same sequence (same payload), we
_drop_ one of the duplicate, so we account for this event.

When ' collapsing'  we reorganize our own storage, not because we have
to drop a payload,
but for some memory pressure reason.
We have specific SNMP counters to account for these, we do not want to
pretend a packet was ' dropped' since it was not.

If we have to _drop_ some packets, it is called Pruning, and we do
properly account for these drops.
