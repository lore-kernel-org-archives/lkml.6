Return-Path: <SRS0=xGmI=KM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E78DC28CF6
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Jul 2018 07:43:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9BB5E2088E
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Jul 2018 07:43:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WYTyyUuH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9BB5E2088E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726328AbeG1JIs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 28 Jul 2018 05:08:48 -0400
Received: from mail-io0-f195.google.com ([209.85.223.195]:37517 "EHLO
        mail-io0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726061AbeG1JIs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Jul 2018 05:08:48 -0400
Received: by mail-io0-f195.google.com with SMTP id z19-v6so5964571ioh.4;
        Sat, 28 Jul 2018 00:43:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=oUzh+UPnEEG3jYHC+Jrm2o27FVmC0oqOoqYaBgJA4/M=;
        b=WYTyyUuHerxe2tL9YCg/v4nA1PaOsARSmJY69vgy+rBKccMupdrdYXVYI7aqPVYZe6
         hVfp4pbTB28SVicdXE+GCEVavGyDDhplK5UaV1EHFU/0k6Jsd0uVNYggZVt2tEy0ygu/
         SJ9obhgCrbCy5I1ZJtyppAmldCKDdrQU91dcqE33X6RjEOHiv6pXrF5MDcMd3mdGxyrB
         cu18M4zjxelZXsqO7VhRr6VF44O/HHAbDV1uvcr/ky8pkXEOYnAVRkIjQy9i3UEU/yjt
         E1s+4z4letXgTZhvWQupCx7xOe1kvDz3nB+EFcjPcP7ZNpIBH2b9zJKvQx2B66RHrbuC
         iN9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=oUzh+UPnEEG3jYHC+Jrm2o27FVmC0oqOoqYaBgJA4/M=;
        b=AteFM1HL2CB+/Dml40cT7sCcc6Vbz9Z8X/PMoqdGxO6FsCTCJDptjPKJp57ZU8VHPh
         nwDjR6aMlaGXfKio4A8TF1p4W9PD3/IPTdateA6aL/bQdxoTPkLxp4QAlQrvIw3NUiKi
         Pjdaqq8KPCPaSvhi2nxXjs9STUbqCL1+m0eDhXfTYtXanXMyzbgf5dXraWM6D3YmVTaV
         XvbPJO/MQUY8rRiDOLOmdhLiVNHeDT6OAVzprWh0gM82tUVPFEvuzfyYa3MD/2K9uWYw
         9ewfwToCOax9PevSI1OoDf5Dks6YCSEASkg1KZsg6GOjfJctiqM8bbkhfSNGwRb68Gqo
         fJjA==
X-Gm-Message-State: AOUpUlHxX+JfziCsy6kUs5/Z0pyf4+Cf8E+8XM0aYGQUMMWLJMqilOzg
        fZHcMPQibFMHLv+QF95ik1HrTye+1BECXD7iFaU=
X-Google-Smtp-Source: AAOMgpemkkc2eShPDMi3i7YW9auJYOc3c3RECUbngEItxbwE6kPEpAo9GvmB455x9WhLRwIpJlS+WH9gD6REwJ2XEeY=
X-Received: by 2002:a6b:c8c8:: with SMTP id y191-v6mr7527394iof.295.1532763795542;
 Sat, 28 Jul 2018 00:43:15 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a6b:7a47:0:0:0:0:0 with HTTP; Sat, 28 Jul 2018 00:42:35
 -0700 (PDT)
In-Reply-To: <CANn89iKXPu=RKkLop4NJWZLixE__qYV2S=PngSj6ienuvWWL8g@mail.gmail.com>
References: <1532746900-11710-1-git-send-email-laoar.shao@gmail.com>
 <CANn89iJ=Ad7sVWr3zBmXNSyePJJZaxgnMymN8S7x6fCSvG2jTQ@mail.gmail.com>
 <CALOAHbC4Rs7w1RwZRBsw_fjGSDvuHV37=nguzJNZzkreR5f4Dw@mail.gmail.com> <CANn89iKXPu=RKkLop4NJWZLixE__qYV2S=PngSj6ienuvWWL8g@mail.gmail.com>
From:   Yafang Shao <laoar.shao@gmail.com>
Date:   Sat, 28 Jul 2018 15:42:35 +0800
Message-ID: <CALOAHbAjtNf1LOhWEJMKNEEHSxjfEKiVV22KPUK88CTzt-eW0w@mail.gmail.com>
Subject: Re: [PATCH net-next 1/2] tcp: call tcp_drop() in tcp collapse
To:     Eric Dumazet <edumazet@google.com>
Cc:     David Miller <davem@davemloft.net>,
        netdev <netdev@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 28, 2018 at 11:38 AM, Eric Dumazet <edumazet@google.com> wrote:
> On Fri, Jul 27, 2018 at 8:35 PM Yafang Shao <laoar.shao@gmail.com> wrote:
>
>> So what about LINUX_MIB_TCPOFOMERGE ?
>> Regarding LINUX_MIB_TCPOFOMERGE,  a skb is already covered by another
>> skb, is that dropping the packet or simply lowering the memory
>> overhead ?
>
> What do you think ?
>
> If you receive two times the same payload, don't you have to drop one
> of the duplicate ?
>
> There is a a big difference between the two cases.

If the drop caused some data lost (which may then cause retransmition
or something), then this is a really DROP.
While if the drop won't cause any data lost, meaning it is a
non-harmful behavior, I think it should not be defined as DROP.
This is my suggestion anyway.

Thanks
Yafang
