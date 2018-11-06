Return-Path: <SRS0=aqUf=NR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D420C0044C
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 02:59:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC2772084F
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 02:59:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XJCVi8PK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CC2772084F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729623AbeKFMWk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Nov 2018 07:22:40 -0500
Received: from mail-qk1-f196.google.com ([209.85.222.196]:38607 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726680AbeKFMWk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Nov 2018 07:22:40 -0500
Received: by mail-qk1-f196.google.com with SMTP id d19so17633587qkg.5;
        Mon, 05 Nov 2018 18:59:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5E2XFtedg+a6UNNp9ie/vKGQF5bDeRCtCVHQwwFhM0g=;
        b=XJCVi8PKuDf88tPZ5wVmHHpqSrEr2v9lzn9IqWV7sluoMi0TywShoGujMhOiua6ltS
         BRW42YqkvkLbc5ArLNtk14rcKxUCQpjzu90QYuSgji8YCG6PX76POFkaj9s2V4AVa0GN
         Qht3p5c3t4MQyOfeAKGRLXj/OijVas1AXP62r8jbBcf496M/DQndTd1pQmfnMEJwch8y
         OPnGzmB+mXSGwOetjbzl8cZcVNnq9tWBx2zDTjDXxlpoC0UnQmL75gzvYOw/a9fcRUOF
         EQLafNBbwOuGZfjXgsJkQHsg+wTDiOGNRYSlC/fgryt8P75Cb8TRSHg6th8CGQ+M+EQw
         xxqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5E2XFtedg+a6UNNp9ie/vKGQF5bDeRCtCVHQwwFhM0g=;
        b=OAgVFpTCp8sHWT4uMWQ54KGBa4WFOdB8QSUtPs+XRdHRs/7fBBoVZaN0B68D+tqTGg
         ic6PZO7mB41A/12VUKYTNG1b0rPpnWBa2q+1iHIUsg8WgBSaa74CBy/nrVJg9m1w5Bvt
         XyJjZBKsHE2zN+qOrSRSSWwk89wxt4uHZ9XTvN/I/9phHwSBLILOg0hqrkmwYYMA/FIf
         w7JnEdakjvAcy9VlyHM+anKAWq7i4rP9YBITtYTO/kzwT469d+/96S/QU3CARmchwpH5
         Wi9ONLuSSFmUZFJiKueA/mLG5enPOz2/vIvYwDeUjMkZAsMNZyiLuaRJDIL6X9O2U5dV
         D6Ng==
X-Gm-Message-State: AGRZ1gLcDombRYufHLQVJ60TsFyTuhC3kRAF6n0AoU6c94PnVBCRWx1A
        LKrnq7RJlr4Ff/6+lNXgXMzkKUS5/kBcRJefdQE=
X-Google-Smtp-Source: AJdET5f77jhCbcFnjVmQZlgwAJPmnXSx5rBiubPtfotT8nEP8mHNZMx+TjA8Ib4DGL+XVtXPsNtWqJfhJIVWOkx92q8=
X-Received: by 2002:ae9:f50d:: with SMTP id o13mr3209926qkg.137.1541473182997;
 Mon, 05 Nov 2018 18:59:42 -0800 (PST)
MIME-Version: 1.0
References: <20181102160710.3741-1-v.mayatskih@gmail.com> <20181102160710.3741-2-v.mayatskih@gmail.com>
 <fe79c7fd-1e9f-dab8-3c65-8151181c922c@redhat.com> <CAGF4SLgDk+48aLKHhA_ZgRc6D30tGdnB89b5m5bZKwzyoDb0dQ@mail.gmail.com>
 <617e0c54-7d11-09b6-21e5-968260107872@redhat.com>
In-Reply-To: <617e0c54-7d11-09b6-21e5-968260107872@redhat.com>
From:   Vitaly Mayatskih <v.mayatskih@gmail.com>
Date:   Mon, 5 Nov 2018 21:59:31 -0500
Message-ID: <CAGF4SLhXq0x+eJcVzE6G_PoDv93bXnu1h=D24NRLXVsoMeEHJg@mail.gmail.com>
Subject: Re: [PATCH 1/1] vhost: add per-vq worker thread
To:     Jason Wang <jasowang@redhat.com>
Cc:     "Michael S . Tsirkin" <mst@redhat.com>, kvm@vger.kernel.org,
        virtualization@lists.linux-foundation.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 5, 2018 at 9:49 PM Jason Wang <jasowang@redhat.com> wrote:

> If you allow device to specify the worker itself, you can do any kinds
> of mapping bettween work and worker kthread I think. The advantage of
> doing this is that you can keep the vhost-net untouched. This makes
> things a little bit easier and proving two kthreads is better than one
> for -net workload is probably not as easy as it looks. We may get boost
> in some cases but degradation for the rest.

Sounds good. 1 worker is created by vhost as today, all the others are
entering from userspace via ioctl.
-- 
wbr, Vitaly
