Return-Path: <SRS0=Rtk1=K5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 608CAC46464
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 16:51:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 17C942172B
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 16:51:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="hvm3OJQ+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 17C942172B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733121AbeHNTjk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Aug 2018 15:39:40 -0400
Received: from mail-io0-f176.google.com ([209.85.223.176]:45005 "EHLO
        mail-io0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731707AbeHNTjI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Aug 2018 15:39:08 -0400
Received: by mail-io0-f176.google.com with SMTP id q19-v6so18870835ioh.11
        for <linux-kernel@vger.kernel.org>; Tue, 14 Aug 2018 09:51:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8SE9LBixp0HVFx0ca4F1g0hOjjHGu2YxjZyEiEcgK+U=;
        b=hvm3OJQ+fqjazcLUcXt9IbrMYSbvTIhd1djMOId7VH/rfQ6mUFe73tNSIzE5n/Jdwk
         hbBgsyK0jslI+N6XHy+v53UD8a0p1FAwKljx++6by0IOY9FG3mAyRrpCJwkm+17QCN22
         A5m9rHGstF4/UcBuLjHuYwmaRq7W4/bqPMwgA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8SE9LBixp0HVFx0ca4F1g0hOjjHGu2YxjZyEiEcgK+U=;
        b=m37b4pbepyh8d5iN+viD5a9npheRabGiR3Ueq24+hZGmQCl1RKmMg/air/+JYMETq+
         6cBMKlc/5OwHNdl5ByDhvtIFs4z7nu5YRxVTICx9b4cN1TKdRzSnIWRMG1wagu8DErFF
         0Yrnj9WJ1oxYheHngJKB/wD47nhH/UUb6Lf8FjWOrJ4dSLaTlbWO5avz2uhzHPFWRTdJ
         faRJjxcxSc4GL8dWpS64BgxtvzfkmVAOzIejOSyrnWAhGd+19gMa4SSG4x4Q1zCqw2M7
         sa/4FZL3pvtAp0R8cabfBeNy5aq5MQGHO673AvmoYm1geU7DUOpr0Vkb6Mpi3ROaVwoh
         tgXA==
X-Gm-Message-State: AOUpUlG3Q4MFQS8oQAsToqugtZEkZi9aDhGkp+z4jJfKf9xGGwTkf5HS
        P8In+RMTDGhspop3cPvJQTag49VxnEQXNt1RG1k=
X-Google-Smtp-Source: AA+uWPz3kr1LCf24fEDmJup0Gjf7tPhWcwYPbE/6xoGJO47jaxqyPzBSKFrgdn3d99n6A6CZrvqNpJhc5dqjOk1nNy4=
X-Received: by 2002:a6b:f609:: with SMTP id n9-v6mr2175051ioh.259.1534265471932;
 Tue, 14 Aug 2018 09:51:11 -0700 (PDT)
MIME-Version: 1.0
References: <7f57199f45df7212fdbba0bd1e78142a@agner.ch> <CAOi1vP9Y5Nrr7kVo5GAKnS4casbXPa+LSgY=si=mAW6OHs7-BA@mail.gmail.com>
 <CA+55aFwyCmYfUrGt61d-6B=1XiTLoudNO=_bQ9-g_rDg8Ao_VA@mail.gmail.com>
 <22fff85b-63e5-3cfe-0e72-255044e53bab@kernel.dk> <e5589461-6331-7c4c-4171-7d7e304410e0@kernel.dk>
In-Reply-To: <e5589461-6331-7c4c-4171-7d7e304410e0@kernel.dk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 14 Aug 2018 09:51:00 -0700
Message-ID: <CA+55aFzisr_YkMJggnG0O4ALzjwKsPeio71PJY8Jur4afnOVOg@mail.gmail.com>
Subject: Re: Warning when using eMMC and partprobe: generic_make_request:
 Trying to write to read-only block-device
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Ilya Dryomov <idryomov@gmail.com>, stefan@agner.ch,
        Sagi Grimberg <sagi@grimberg.me>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 14, 2018 at 9:26 AM Jens Axboe <axboe@kernel.dk> wrote:
>
> >
> > We probably just want to special case a flush for this check. In other
> > situations, like resource allocation and issue, we'd want to consider
> > it a write.
>
> Ala:

Ack, looks sane to me.

            Linus
