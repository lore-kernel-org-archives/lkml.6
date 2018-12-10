Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23E2AC04EB8
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 23:40:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6385C20645
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 23:40:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="iwH2r7d/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6385C20645
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=purestorage.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729217AbeLJXk3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 18:40:29 -0500
Received: from mail-qt1-f170.google.com ([209.85.160.170]:38493 "EHLO
        mail-qt1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726607AbeLJXk3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 18:40:29 -0500
Received: by mail-qt1-f170.google.com with SMTP id p17so14471958qtl.5
        for <linux-kernel@vger.kernel.org>; Mon, 10 Dec 2018 15:40:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5lHAcv/QXMe2YI9fXzyLxIPXQ2T2mb3s2pqJM8ZHvZw=;
        b=iwH2r7d/HDHiNgSiLGqSabAf4j2C7oyYqWEafoKgyo5bw2f28Piz8e3e9Ai+nPAfjS
         wTLGlZ60vjpKnDXsTP7JlWIK+/vXruflErdge86pnixa1Nizj4pCAo8XbZ3j4z9PDlZu
         Sn7JwN5ZkNaoRABUUq1DIR9PJCbYft9w2F6g0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5lHAcv/QXMe2YI9fXzyLxIPXQ2T2mb3s2pqJM8ZHvZw=;
        b=ZjB5yXq7MxADoiR3S8rrtBYEMx07zPX3TRiqa5jTlUkkgtABHfKie9QUB3akT4WG9y
         r0ZRMd0b1Frtftp8TH0l3jT87qSi3kfY3Tw/AnzTDomAKaqsphPb8VoMzgSEAE/l0wfu
         xhG1Tnn4mmO3uIdnGuvyNSLbG86dnQGvV3phV2AHbsa+ufMmiswRXMRkrgtR6ZfF9fbM
         rqGiTDqu0kkS4xO0zDYlh6f1cDRAa8ppPR+B0LOp5FPKJXXP2cM5Gj9Vm5fjxFHgpDXg
         32ONb00ESILuDtYsliBBdt0UHy00WMBwWLgsu7Klj3lHiz7HaEGr+WvgImRdQYqEdFSk
         1HgQ==
X-Gm-Message-State: AA+aEWatUP5RjCITPHpZuwvyvdNZ2CNJ6dp+ioqBNJtAT27n7jM0x7ZS
        ZjTGpvQ6alkrM1klTAuFNe9qJNHTBjT7rLGTqzGu7w==
X-Google-Smtp-Source: AFSGD/WhWx/FTUtvQgiZZOkjiPnnQao17hSVg/rZeaQbxidv6Zn/pbzIiQNy6me8m8RVjJ99vT0o6wMNPRbwSHhcTvI=
X-Received: by 2002:a0c:e5c1:: with SMTP id u1mr13552132qvm.113.1544485227829;
 Mon, 10 Dec 2018 15:40:27 -0800 (PST)
MIME-Version: 1.0
References: <1543535954-28073-1-git-send-email-jalee@purestorage.com>
 <cc7cbad6-0e7d-8328-c602-61d659c3a7de@grimberg.me> <b7b26a7a-70be-d805-ee64-67fba0b4efa8@mellanox.com>
In-Reply-To: <b7b26a7a-70be-d805-ee64-67fba0b4efa8@mellanox.com>
From:   Jaesoo Lee <jalee@purestorage.com>
Date:   Mon, 10 Dec 2018 15:40:16 -0800
Message-ID: <CAJX3Cti_ZJF5E+NRuRzSeEUgaXsbA2U9C+Rh5OdYd4EMwXC1gw@mail.gmail.com>
Subject: Re: [PATCH] nvme-rdma: complete requests from ->timeout
To:     nitzanc@mellanox.com
Cc:     sagi@grimberg.me, keith.busch@intel.com, axboe@fb.com, hch@lst.de,
        Roland Dreier <roland@purestorage.com>,
        Prabhath Sajeepa <psajeepa@purestorage.com>,
        Ashish Karkare <ashishk@purestorage.com>,
        linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It seems that your patch is addressing the same bug. I will see if
that works for our failure scenarios.

Why don't you make it upstream?

On Sun, Dec 9, 2018 at 6:22 AM Nitzan Carmi <nitzanc@mellanox.com> wrote:
>
> Hi,
> We encountered similar issue.
> I think that the problem is that error_recovery might not even be
> queued, in case we're in DELETING state (or CONNECTING state, for that
> matter), because we cannot move from those states to RESETTING.
>
> We prepared some patches which handle completions in case such scenario
> happens (which, in fact, might happen in numerous error flows).
>
> Does it solve your problem?
> Nitzan.
>
>
> On 30/11/2018 03:30, Sagi Grimberg wrote:
> >
> >> This does not hold at least for NVMe RDMA host driver. An example
> >> scenario
> >> is when the RDMA connection is gone while the controller is being
> >> deleted.
> >> In this case, the nvmf_reg_write32() for sending shutdown admin
> >> command by
> >> the delete_work could be hung forever if the command is not completed by
> >> the timeout handler.
> >
> > If the queue is gone, this means that the queue has already flushed and
> > any commands that were inflight has completed with a flush error
> > completion...
> >
> > Can you describe the scenario that caused this hang? When has the
> > queue became "gone" and when did the shutdown command execute?
> >
> > _______________________________________________
> > Linux-nvme mailing list
> > Linux-nvme@lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/linux-nvme
