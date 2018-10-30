Return-Path: <SRS0=BpFy=NK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D8D3C2BC61
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 07:06:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5071D2075D
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 07:06:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gGVo453w"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5071D2075D
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727244AbeJ3P6S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Oct 2018 11:58:18 -0400
Received: from mail-it1-f193.google.com ([209.85.166.193]:52294 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726154AbeJ3P6R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Oct 2018 11:58:17 -0400
Received: by mail-it1-f193.google.com with SMTP id r5-v6so10578426ith.2
        for <linux-kernel@vger.kernel.org>; Tue, 30 Oct 2018 00:06:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DI7Os5ztz1YkuX9GcHkyfoOe0ZK7Ez27MR+mHaIdmiA=;
        b=gGVo453w0KKQL4OXpx6TFohPGyQblkcXQcCLkUNQlCHjT3yzciNz/54RNh8EpVp9rg
         Y7neW3lRrWNu/qn8WZUAEjWzNdqY5gGkhgvZUtWrS4+dMSfkbr34oCM+dst1nClZYoo6
         7DrtptuBMCsiaBniFb8sdJblnqpH1hCrTc4JYlWUpPFCGupeJoIEu/bJ/PPX0XvCxucT
         y7FyqLmerN4ioAEXHZzec7hEgyJkKbiJksdIoJWOsUm3tRDSPYEWR82c1rHhFg+u0PSM
         kIGd/akRywKFQiLcb4Ptj3ku/Ntkp3aoIrvOAYzxgsZn9obeKm/f3GkZPr/+zS/rqNOg
         FIQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DI7Os5ztz1YkuX9GcHkyfoOe0ZK7Ez27MR+mHaIdmiA=;
        b=UJoMkqh/+gaxM1Ot9QHW9BKSHoJgy90rz5jJIwumSe0wNLL6QokG+vbLYCM6NKZ45H
         nnBSnhVv9wbACn6cqGUFHERs3lcPtvxWcI69rh6iWEWTu+ZlljHm8ikIr6tsBoS3U0PR
         IRBOaT3N9hVi/x7DfiYe6I15ZJgIQsqERQ/OHVqZZR8hLumOwivwvU8Q2dlZ1wSa5dqa
         LYI+LVD2IpXXAowfTtJIJ/biL6KMeJsRXaS/GhP+KMbo/v5v3Rib6wk1UfepbNuhsjNb
         GdtRWX1zXiS3Noeyn+GbMonL/B0SbSN9lnuAzmVMZZV16XVSvc6RcApgZ4hstzVs/rHr
         KHtg==
X-Gm-Message-State: AGRZ1gKeL47XH5HpvD+f4zxB320L3Y0jCWmPjs9Do0J6XPx72IcEi4Ey
        6gMyrOif6cpm2i6rVbpooJ+EKVLKAM8/IJ0y+0scV1692Ms4hw==
X-Google-Smtp-Source: AJdET5efpzfZE/ulkWBtwXS6LOWJX0Q6mUhNNEDIqDFnup3zS8w6UOxAx7jmlrgQD2l+930f4AneS+SJi9oWPoI2mZw=
X-Received: by 2002:a24:7406:: with SMTP id o6-v6mr291362itc.81.1540883161077;
 Tue, 30 Oct 2018 00:06:01 -0700 (PDT)
MIME-Version: 1.0
References: <1540881776.20660.9.camel@abdul.in.ibm.com>
In-Reply-To: <1540881776.20660.9.camel@abdul.in.ibm.com>
From:   Eric Dumazet <edumazet@google.com>
Date:   Tue, 30 Oct 2018 00:05:49 -0700
Message-ID: <CANn89iJGgCMYRp7h=h+g=o+P9VA+8U+NxFhXP70B_PSG_mp7OQ@mail.gmail.com>
Subject: Re: [mainline][bisected 55469b][ppc] build error at drivers/net/ethernet/mellanox/mlx4/en_rx.c
To:     abdhalee@linux.vnet.ibm.com
Cc:     linuxppc-dev@lists.ozlabs.org, LKML <linux-kernel@vger.kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        sachinp@linux.vnet.ibm.com, manvanth@linux.vnet.ibm.com,
        aneesh.kumar@linux.vnet.ibm.com, brking@linux.vnet.ibm.com,
        netdev <netdev@vger.kernel.org>,
        Tariq Toukan <tariqt@mellanox.com>,
        linux-rdma <linux-rdma@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 29, 2018 at 11:43 PM Abdul Haleem
<abdhalee@linux.vnet.ibm.com> wrote:
>
> Greeting's
>
> mainline build fails on my powerpc with commit 55469b : drivers: net:
> remove <net/busy_poll.h> inclusion when not needed
>
> Machine type: PowerPC power 8 bare-metal
> kernel : 4.19.0
> gcc :  4.8.5
> config attached
>

Thanks for the report, but this patch is not in 4.19 kernel ? It is
scheduled for 4.20 only.

Anyway, mlx4 needs to include  <net/ip.h> directly, instead of
assuming it is indirectly included by another file.
