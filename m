Return-Path: <SRS0=OLKc=O6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FROM,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2514C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 14:43:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A0B4B21920
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 14:43:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aHvxybZD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403913AbeLUOnQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Dec 2018 09:43:16 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:35516 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725372AbeLUOnQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Dec 2018 09:43:16 -0500
Received: by mail-ed1-f67.google.com with SMTP id x30so4875330edx.2;
        Fri, 21 Dec 2018 06:43:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=E94jgZGuemq29sYUZWuRjpVrG/mwZv2eAZrsW9c03nM=;
        b=aHvxybZDBiibt345AwWxOz101cJSmMcqE8diIQPgBPscdEdo6JI608pLCO2wUHR8Al
         2/LgH0cdBfiroEC9t1LhV4nimbuDdZw1S0+/JVR97B7LMQ2n3BzjZxEMsgc2c4sJPNDa
         293AJOjND2czN6hEACkkgWh8ZjMNL/x4/aJ9BV+7BzgcbfSVgoAV8OnjbXjLLhu98OBH
         N/ROHvglcSxS2lCwZg4M19ua6xJ7EeJ+u0Ah8g8Y3JdlYqd5F3lB1FZAI0niJ/WUWWla
         OMNbGGY0TM0e+wJLefSTFvx30SH9yNtnnplUQwf/mplaCkCl0YXqRh2TSjjuLoqp6GFz
         fV6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=E94jgZGuemq29sYUZWuRjpVrG/mwZv2eAZrsW9c03nM=;
        b=NbhUasDdNpyltIx7/D6H+UEi8Odi9GdHUh20kVzBtXjpzwS19MRxzRfWQuo/A6y28w
         uMRdmcwrbgO/sk85VzBRrlmBLLS1KD5AmVLyEyVGcpfd3bkW+cPs1AekYhPLLcYd38NN
         uLAoGswaxmWS2nBNnl/+THmEEGz+BDTYEKjRSsp3G9Tjh62KpjU7Ui6JUA1N2FDkUknn
         QlR9gLRZjN87VyXohAVFMxDWpUpDfS8YDwOlY9VGhAD1sP52VmNr1oY1mjm3GjVYXwrO
         jfXa8hsNVVwBxXLiclPZxm5WyekPGe91+8nwu3MI9JrAjznWrfZZmqjmocea4kQKOHIr
         v/4Q==
X-Gm-Message-State: AA+aEWYC4wuHURgAMRzjS5Iv1X4HsHoLqOcJAHtO00usFIgPsCcb+P02
        M044fDl9Vk0i3XNiBqQT186xs4hMnVVm9aHRHvQ=
X-Google-Smtp-Source: AFSGD/WCb1EcxV8TK67IbCkpCrH25s4ttXZpw8AFxTLZvDYtbN7QluT3w2ZjQP6y0RskuYmDUloelbPjJx+Z+BSSlio=
X-Received: by 2002:a50:a517:: with SMTP id y23mr2633050edb.219.1545403393695;
 Fri, 21 Dec 2018 06:43:13 -0800 (PST)
MIME-Version: 1.0
References: <ba519cd8-ab88-2868-f6d0-be321d8df0be@de.ibm.com>
 <20181220091207.GA25942@splinter> <0c5a8fa8-efb3-71f2-0da9-6fc0f133cdf9@de.ibm.com>
 <20181220141752.GB861@splinter> <CAF=yD-KBkX3NxtDt6mv-PoujFfdtJJ66XsnGzx-KQop6EU6LRw@mail.gmail.com>
 <e25104e5-4385-965c-993c-85952db254c9@de.ibm.com>
In-Reply-To: <e25104e5-4385-965c-993c-85952db254c9@de.ibm.com>
From:   Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Date:   Fri, 21 Dec 2018 09:42:36 -0500
Message-ID: <CAF=yD-KCD1jwX-eBSfy9PTK3G8ZFkFh+Ysnj+YuHTbtAcRjPBw@mail.gmail.com>
Subject: Re: 4.20-rc6: WARNING: CPU: 30 PID: 197360 at net/core/flow_dissector.c:764
 __skb_flow_dissect
To:     Christian Borntraeger <borntraeger@de.ibm.com>
Cc:     Ido Schimmel <idosch@idosch.org>,
        Willem de Bruijn <willemb@google.com>,
        Michael S Tsirkin <mst@redhat.com>,
        Network Development <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "virtualization@lists.linux-foundation.org" 
        <virtualization@lists.linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 21, 2018 at 1:45 AM Christian Borntraeger
<borntraeger@de.ibm.com> wrote:
>
>
>
> On 20.12.2018 18:23, Willem de Bruijn wrote:
> > On Thu, Dec 20, 2018 at 11:17 AM Ido Schimmel <idosch@idosch.org> wrote:
> >>
> >> On Thu, Dec 20, 2018 at 03:09:22PM +0100, Christian Borntraeger wrote:
> >>> On 20.12.2018 10:12, Ido Schimmel wrote:
> >>>> +Willem
> >>>>
> >>>> On Thu, Dec 20, 2018 at 08:45:40AM +0100, Christian Borntraeger wrote:
> >>>>> Folks,
> >>>>>
> >>>>> I got this warning today. I cant tell when and why this happened, so I do not know yet how to reproduce.
> >>>>> Maybe someone has a quick idea.
> >>>>>
> >>>>> [85109.572032] WARNING: CPU: 30 PID: 197360 at net/core/flow_dissector.c:764 __skb_flow_dissect+0x1f0/0x1318
> >>>>
> >>>> I managed to trigger this warning as well the other day, but from a
> >>>> different call path:
> >>>
> >>> FWIW, it also seems to happen on 4.20-rc1. 4.19.0 seems fine. bisect seem to have failed so
> >>> my reproducer is not reliable.
> >>
> >> Yes, it is caused by commit d0e13a1488ad ("flow_dissector: lookup netns
> >> by skb->sk if skb->dev is NULL")
> >>
> >> $ git tag --contains d0e13a1488ad
> >> v4.20-rc1
> >> v4.20-rc2
> >> v4.20-rc3
> >> v4.20-rc4
> >> v4.20-rc5
> >> v4.20-rc6
> >
> > That tap_get_user_xdp path is also new for 4.20-rc1:
> >
> >     commit 0efac27791ee068075d80f07c55a229b1335ce12
> >     tap: accept an array of XDP buffs through sendmsg()
> >
> >     $ git describe --contains 0efac27791ee
> >     v4.20-rc1~14^2~382^2~1
> >
> > In v4.19 and before all packets went through tap_get_user.
>
> Hmmm, so maybe my bisect wasnt broken at all? It pointed to
>
> commit 105bc1306e9b29c2aa2783b9524f7aec9b5a5b1f
> Merge: 3475372ff60e4 d0e13a1488ad3
> Author:     David S. Miller <davem@davemloft.net>
> AuthorDate: Tue Sep 25 20:29:38 2018 -0700
> Commit:     David S. Miller <davem@davemloft.net>
> CommitDate: Tue Sep 25 20:29:38 2018 -0700
>
>     Merge git://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next

Yes, that's the right commit. The flow dissector change went in
through bpf-next.
