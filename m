Return-Path: <SRS0=drEb=P7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45843C282C0
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 21:57:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 12F282184C
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 21:57:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D4e0hBZN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726354AbfAWV5Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Jan 2019 16:57:25 -0500
Received: from mail-qt1-f195.google.com ([209.85.160.195]:41552 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726101AbfAWV5Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jan 2019 16:57:25 -0500
Received: by mail-qt1-f195.google.com with SMTP id l12so4250376qtf.8
        for <linux-kernel@vger.kernel.org>; Wed, 23 Jan 2019 13:57:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pEE9amp1+x7YEgbGZejv7Ho3uHqFdzRtZvJXWFsK3FM=;
        b=D4e0hBZN+jbtYXrNNTeGxudmbdHmJ9lFh36j4YW/qbR1SryARQIfzt2yNCViayrHFd
         g1j7lEKCAknZo+chCG4tb1qbpgTEz0lm919YGN/M2wDryh7gjJtHOSqst0Blrml6uLCG
         pREiTTgcr7GKYgCN8Mkor/QXBf2ZcQ15y7iSnBMTF62OVrBI+KpAWVmmwECKMQ6cVzzh
         njl0/LaGTkg0rscuwT4XXYa5gKrBNPZwX7DUtUGodV2NagYzh9X0f8TDlZLkVlGC9H6w
         ip+xWHWnDqM1oP0wEFrauUxFTRkTMpsG2ihC4Q3+Q+nZUdY4E4VqC0fMaLK5knAz8lL6
         rT1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pEE9amp1+x7YEgbGZejv7Ho3uHqFdzRtZvJXWFsK3FM=;
        b=E4gyxMLMgarKGD++buQOfEyu4cqlku2hyROI/1FrKW72gAXq1/Qe3MQ8mT2p069hzw
         Zccl9y0AYtVzjeUxC2eqvPIb44UkiwyL90G2gi4G+wnxvO9MrkjNRy4ofsP0nGaP/S0F
         Bqu800xY4kTqCY7J8wCbAYJIQcYM4QzL+9VNVJ7NbKr1vgpqHvUmduFDeu+6Up6d3ZoP
         5dLC9yb+Cs0e0R0aV6w7LjX/UpBPgiG0XQbIpVtm2dTr6g9y8tCKK10hXEakR+80f/Tu
         R2npse5Ts0JJQep80d7dmN20/X9mGIzELOEBiY4zG+LqqMRhPYd7RkVESCDY7qPNctN2
         4aGA==
X-Gm-Message-State: AJcUukeX2pBzOzMFmnGVMCNzsh7tZeMYqlYyO3MF9AZTDvbuWnpf6caI
        XdpurzmmtvyCXmzN6efaZ4VUp5Lg5YTpB7SXLv8=
X-Google-Smtp-Source: ALg8bN7QurTjO/4pZw0mOlyY7AB0qUDHEhBTQGQOPFDg+1woJDlXDsk3ymG7STqdkyI0Hj/gULHXJTLmmyfCLxtGt7U=
X-Received: by 2002:aed:2f25:: with SMTP id l34mr4303639qtd.356.1548280644019;
 Wed, 23 Jan 2019 13:57:24 -0800 (PST)
MIME-Version: 1.0
References: <20190123000057.31477-1-oded.gabbay@gmail.com>
In-Reply-To: <20190123000057.31477-1-oded.gabbay@gmail.com>
From:   Dave Airlie <airlied@gmail.com>
Date:   Thu, 24 Jan 2019 07:57:11 +1000
Message-ID: <CAPM=9tznaiw+a7rWqfdMMO6Aj3GtsO9vetd=3n9d+bGLW0U8Cg@mail.gmail.com>
Subject: Re: [PATCH 00/15] Habana Labs kernel driver
To:     Oded Gabbay <oded.gabbay@gmail.com>,
        Jerome Glisse <jglisse@redhat.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        LKML <linux-kernel@vger.kernel.org>, ogabbay@habana.ai
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 23 Jan 2019 at 10:01, Oded Gabbay <oded.gabbay@gmail.com> wrote:
>
> Hello,
>
> For those who don't know me, my name is Oded Gabbay (Kernel Maintainer
> for AMD's amdkfd driver, worked at RedHat's Desktop group) and I work at
> Habana Labs since its inception two and a half years ago.

Hey Oded,

So this creates a driver with a userspace facing API via ioctls.
Although this isn't a "GPU" driver we have a rule in the graphics
drivers are for accelerators that we don't merge userspace API with an
appropriate userspace user.

https://dri.freedesktop.org/docs/drm/gpu/drm-uapi.html#open-source-userspace-requirements

I see nothing in these accelerator drivers that make me think we
should be treating them different.

Having large closed userspaces that we have no insight into means we
get suboptimal locked for ever uAPIs. If someone in the future creates
an open source userspace, we will end up in a place where they get
suboptimal behaviour because they are locked into a uAPI that we can't
change.

Dave.
