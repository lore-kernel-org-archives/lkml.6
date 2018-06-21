Return-Path: <SRS0=bmN+=JH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCF0CC43141
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 07:13:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6CCAD20837
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 07:13:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d4nglDB9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6CCAD20837
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754157AbeFUHM6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Jun 2018 03:12:58 -0400
Received: from mail-io0-f173.google.com ([209.85.223.173]:36617 "EHLO
        mail-io0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751147AbeFUHM5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jun 2018 03:12:57 -0400
Received: by mail-io0-f173.google.com with SMTP id k3-v6so2085800iog.3
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jun 2018 00:12:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pxV8RoOD28Fu2nOTdk0UVglhM7eKj6B4j+iYGsVJqyI=;
        b=d4nglDB9u06BmV+Zd5jMtV8HVhY7r2eKQKIZq+/l/enW6z41n7sRlsU2g3rqLLpVFC
         //PviufgZIr7LHoovlSQFkd7aABjLjygtQFkvONftxkZOfRhnE9SMXQf8pWr3MYW8bYJ
         bvZNWoMmKo56ld3+xoqzNuWmU7UBNw1muxk+GoUtnyf+OiKygCd2rI2Y9OjYQVSGaAi1
         TqA9Q8JJeXmKXPtYAq6g+chdohWNPNKbgRY8Vl/Z82bi+EM+12KXNcGdUTL2SxEOQvvb
         yOcDPPwdNJuVRAP+GM++0cyWT8mzdyLvR7Mhsax67LaP70AK2kMioTTQMhc3Zfv36Ha6
         3rjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pxV8RoOD28Fu2nOTdk0UVglhM7eKj6B4j+iYGsVJqyI=;
        b=RQhAJyC/wknGSeILaBK3ASxQWMFBYWBXCoyGZT1owD8+hcpvriaFHOGHpZ38lKeMEi
         z3GfC4vUVsGElSmKN8uGpTXiSNL8OjuE8Lxubk8+G8WOiQLq5iGSWJqEPtD4X4JTXDPK
         XoD3F5GMy0PdxJb4C2+zt6Mosxjj031XorZixRt4KxBBp+qocH+Vy2o/vB+zGa4B58B5
         BwKrG3BNdpWKl0RjcwLpeJwAze930o8wm0fnvGNkuFpytuyVr0xMDvA1Lc8hZApJNYQl
         o+nio/ueCoBEoHeLzjCtr2h4Kz8t13w2kq83mUUbwm1RgzqFQ+erRV2OV5L0o0BRBtDm
         bMrw==
X-Gm-Message-State: APt69E3nUwMXYZpbbem8v0Q1GAr5BpmYcTczJH5vACDoGAdfMlVvntSe
        dZFdpHB94+/4v603kH4fGbcWXspbM95IgIODoU8=
X-Google-Smtp-Source: ADUXVKLVl9TyDMdIgqLFHhiuQ5mkIUJIMS1iZ2UAriISObohSZTcES+ZpjoA1LXj3370gHawFih6WihaXOKxMFi/INQ=
X-Received: by 2002:a6b:5316:: with SMTP id h22-v6mr19593205iob.63.1529565176374;
 Thu, 21 Jun 2018 00:12:56 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1529506497.git.zong@andestech.com> <3f86f9eb853380686a86a8abe6bda0dd3720ee10.1529506497.git.zong@andestech.com>
 <20180621064135.GD19319@infradead.org>
In-Reply-To: <20180621064135.GD19319@infradead.org>
From:   Zong Li <zongbox@gmail.com>
Date:   Thu, 21 Jun 2018 15:12:45 +0800
Message-ID: <CA+ZOyah0-d3diK2iaWXsoPsCS9T8pTfp5-gxOixfBvJYRVjdLQ@mail.gmail.com>
Subject: Re: [PATCH 4/5] RISC-V: Change variable type for 32-bit compatible
To:     hch@infradead.org
Cc:     Zong Li <zong@andestech.com>, linux-riscv@lists.infradead.org,
        Palmer Dabbelt <palmer@sifive.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        aou@eecs.berkeley.edu, greentime@adnestech.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > -     s64 offset = (void *)v - (void *)location;
> > +     uintptr_t offset = (void *)v - (void *)location;
>
> s64 is signed, uintptr is not, so this might change behavior and needs
> an explanation.
>

Yes, it should be intptr_t. Thanks!
