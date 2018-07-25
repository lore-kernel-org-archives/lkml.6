Return-Path: <SRS0=S+WB=KJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74E5BC6778F
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 14:00:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D74220891
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 14:00:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q49117aV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2D74220891
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729079AbeGYPMa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Jul 2018 11:12:30 -0400
Received: from mail-it0-f66.google.com ([209.85.214.66]:50738 "EHLO
        mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727691AbeGYPMa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jul 2018 11:12:30 -0400
Received: by mail-it0-f66.google.com with SMTP id w16-v6so8843245ita.0;
        Wed, 25 Jul 2018 07:00:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=t4H7ug6QZVQHe3q/PjpQQd4vsvLIkqw5HkOQBtNrQuE=;
        b=Q49117aVkFubRJ+NplrFcp8HCPjh2ft07+S5cyiuPCeRWldcnrqtN6fUQWxwN0NAhZ
         eunwz+jTlOJrr537MlE5osVrIvqSDz8bvEAPoTYdsbBtP+fHT7ilZTEYfVLraQ1/rqVp
         8PP5DwjsqX5mIHZyuK3sH0mMnRQyUpi6ma3p7orv3i2Qn02S1Oa4CmoNyGdy4n7RNmVO
         WdPQXQPNyjPfBB6/NICfvrD6tfVzrWlmqvi7OsQBFAeFypyqfo2almhfamtpnbG279Wf
         iWrMgMAR+LgSc2xy87CDb1dMMrDA4T8IIv7QMtXlb5VB4MTW0fBaqCCjLnAXfKhSKz9b
         MaiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=t4H7ug6QZVQHe3q/PjpQQd4vsvLIkqw5HkOQBtNrQuE=;
        b=Mv38wXVK2lcfq3bSdBA0sKoC645X0vikBc5qkTf9UVOpzV+VbVgtTtIt4HMP4GvVQx
         H+aqk+jlCHlREevHv/m6O5Difen0GwPdEFhEMznP9f4pgcD+vR60atAt/37sThiL6V0w
         ZFTHi4vH/3JKEzTbaA+DoovzE9jqyMh9Q8doem0vd/s69Ni6aJgDbJItfsSamGSy/HbQ
         DTlDynyzx9Dfz47xrLbmt8LHqJbIZ3WfCxDrXWPYDZiWkq8Mvs1N9lV278TGI5iENdxm
         ycCIsNV0w8AWZT3Vax2k+6fTyUHQkgnly6IBWrj7b9o+YlObtscQ7UlZH4kdSSeTifyK
         yGLg==
X-Gm-Message-State: AOUpUlECuDjJeT/Je9HSPWia38aifVPBOAJPkvX/xJwasTjRmZM4fx/2
        qSTI/ATRrD4CFepekYNUZe4ojNLYS7L9mohGmFY=
X-Google-Smtp-Source: AAOMgpfu7z1JVh2/OAmZJsgIXjRYYvHZGlQrQsX1a9JV3+LnWprk8gh3y6PC+LysKpOzgAMISeYj7tWREZXk4Q3b9ic=
X-Received: by 2002:a02:45cd:: with SMTP id o74-v6mr18678826jad.43.1532527238236;
 Wed, 25 Jul 2018 07:00:38 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a6b:7a47:0:0:0:0:0 with HTTP; Wed, 25 Jul 2018 06:59:57
 -0700 (PDT)
In-Reply-To: <096a8a2f-ea32-2107-b2af-c246450cc3b9@gmail.com>
References: <1532524010-11855-1-git-send-email-laoar.shao@gmail.com>
 <047bc12f-9eb5-e512-10c5-6334c494c77e@gmail.com> <CALOAHbCC=oWgzcA=VhkXq0rVLBa5_TvtbKtTqESGrgxvYTtH6w@mail.gmail.com>
 <096a8a2f-ea32-2107-b2af-c246450cc3b9@gmail.com>
From:   Yafang Shao <laoar.shao@gmail.com>
Date:   Wed, 25 Jul 2018 21:59:57 +0800
Message-ID: <CALOAHbASvcEdudqpit-c=RRZ8xVD+G+0jU-ynp9PsH4_mU7xjw@mail.gmail.com>
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

On Wed, Jul 25, 2018 at 9:55 PM, Eric Dumazet <eric.dumazet@gmail.com> wrote:
>
>
> On 07/25/2018 06:40 AM, Yafang Shao wrote:
>
>>
>> Because we want to know why packets were dropped.
>> If that could be show in netstat, we could easily find that it is
>> dropped due to ofo prune.
>
>
> We have a counter already for these events : LINUX_MIB_OFOPRUNED
>
> You want to add another counter tracking number of _skbs_,
> which has no precise value for user,
> given each skb can contain a variable number of _packets_.
>

Got it.

But with LINUX_MIB_OFOPRUNED, we only know  tcp_prune_ofo_queue is
called, but have no idea how many skbs are dropped.

Thanks
Yafang
