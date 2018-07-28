Return-Path: <SRS0=xGmI=KM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5663EC28CF6
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Jul 2018 03:39:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F100B20841
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Jul 2018 03:39:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WC9nZBLs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F100B20841
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726108AbeG1FDq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 28 Jul 2018 01:03:46 -0400
Received: from mail-it0-f67.google.com ([209.85.214.67]:36392 "EHLO
        mail-it0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725905AbeG1FDq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Jul 2018 01:03:46 -0400
Received: by mail-it0-f67.google.com with SMTP id p81-v6so10058005itp.1
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jul 2018 20:38:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=e7U7jWa0eHTJ4xzJcfD190rtQyFi0cyqwK8TMeRGeio=;
        b=WC9nZBLsQNxRgcR5dogwxP2xN+0FhyTO4aiU6CoV1IVJjfP6vIxmJRP79tyIfW8aXM
         3c+ZoDcpv+Q50Vjru1mbBo1qUblSNl2Nu6k468TEPcCprgb7b73ECMBOzZ/BMu1O+NyC
         Clq+xUTZhZLkeruxDZTRIb+9ViPjmzagjH7FKxrtE+NFE6yZtKWbTBl6d2UbSxdPewG9
         VRvo470dxVEamPoVIpCtll+42/REeNMTlsNdiphQTlwMSPk91ja8WhPY6OS6oryZjQkF
         8fWecYxqbAlp/Mpx9X7VztNbqNEX8Jdmf7SH3bv9BCXBTGO9uiHhbYhrSu8LOwBipnDB
         NOog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=e7U7jWa0eHTJ4xzJcfD190rtQyFi0cyqwK8TMeRGeio=;
        b=A9MdLYZwdRA9Lj3zwAzsv7K7h7775fizzjGzEvuEuWkZLoD6RMlbxy4AJs+2FvZcYM
         ZVaIHTNAQm6W8/53EXoEo9n7PsuNu3yuKk9j2bLx3tsSv+/dxcBzE6Y6X2VL1Uv0T2ky
         MMB2rJNNGMtKFdsv0yPoveSVzUF7RTvOqYj/hACrhxlcjxI3EqOdgbIlElJB/1RFBBuQ
         A5YWyLtmnfMvvnqnWz07WxEVSXnC5dK/oSty/uuK0SJmzcekvxE3hdtqulcBa3eIKOAA
         e8uuYS7Hhhmk+hixJzcKxTYh5pZJHowPN6p2kPKdxiUjhN+kmvYHAvFkJsdVqNYiFTkJ
         udBg==
X-Gm-Message-State: AOUpUlGS62FYIuCU0+jeZA0Eo4s7dDuLlcFEblwMFY1u8qrEVNdRfhyV
        tzDov5I62RYxiE94YJfls0HBc9RyDGNl2EdH6aG0Iw==
X-Google-Smtp-Source: AAOMgpeFNxLpFPhDjDqQvTg8NCEtH0Kau6T/b8chswvldu4YtTDdsvlU/WsPcdybFX3+ayFx6ftFB7eu5KjqHrhxEfE=
X-Received: by 2002:a24:6f0e:: with SMTP id x14-v6mr7750837itb.139.1532749135396;
 Fri, 27 Jul 2018 20:38:55 -0700 (PDT)
MIME-Version: 1.0
References: <1532746900-11710-1-git-send-email-laoar.shao@gmail.com>
 <CANn89iJ=Ad7sVWr3zBmXNSyePJJZaxgnMymN8S7x6fCSvG2jTQ@mail.gmail.com> <CALOAHbC4Rs7w1RwZRBsw_fjGSDvuHV37=nguzJNZzkreR5f4Dw@mail.gmail.com>
In-Reply-To: <CALOAHbC4Rs7w1RwZRBsw_fjGSDvuHV37=nguzJNZzkreR5f4Dw@mail.gmail.com>
From:   Eric Dumazet <edumazet@google.com>
Date:   Fri, 27 Jul 2018 20:38:44 -0700
Message-ID: <CANn89iKXPu=RKkLop4NJWZLixE__qYV2S=PngSj6ienuvWWL8g@mail.gmail.com>
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

On Fri, Jul 27, 2018 at 8:35 PM Yafang Shao <laoar.shao@gmail.com> wrote:

> So what about LINUX_MIB_TCPOFOMERGE ?
> Regarding LINUX_MIB_TCPOFOMERGE,  a skb is already covered by another
> skb, is that dropping the packet or simply lowering the memory
> overhead ?

What do you think ?

If you receive two times the same payload, don't you have to drop one
of the duplicate ?

There is a a big difference between the two cases.
