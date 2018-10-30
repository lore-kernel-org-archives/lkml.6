Return-Path: <SRS0=BpFy=NK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B595C2BC61
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 19:52:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5083420823
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 19:52:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="QzU8zJZQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5083420823
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727520AbeJaEqx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Oct 2018 00:46:53 -0400
Received: from mail-qk1-f182.google.com ([209.85.222.182]:46094 "EHLO
        mail-qk1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725743AbeJaEqw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Oct 2018 00:46:52 -0400
Received: by mail-qk1-f182.google.com with SMTP id q1so6366203qkf.13
        for <linux-kernel@vger.kernel.org>; Tue, 30 Oct 2018 12:52:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=1pLum5WItWUdZIaxpZv8PD//9DZ/s8nO6SZ1lJplILo=;
        b=QzU8zJZQ79fcQJM2AZvr0GMnohdtWcanGNRFGSKcoHdyyR1sqruuFYem5ijaXb8Fse
         c4D3PcKO38OCq7bC2lgNkbsBAZf3G4E6gu81GTF7GkXT6x4RucOb3+phDeequJ3D/nzv
         +x7mEgru+uZ1/+RhMaCMKyAaOC88v6oAavEgg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=1pLum5WItWUdZIaxpZv8PD//9DZ/s8nO6SZ1lJplILo=;
        b=pp4hKWfGnVBpAWduGSh32fgqtraTvSTmCA2PuB0cue2184gm2rZ5hwqyuvrRXLB0hg
         D6sBnFkJ5X9wguNK5LNOIWDN2+KvEtFefi9EGTv82HHi81pcHlu6Sr4JHDN+BB2PYCMR
         IGqp86S5mm6e8VX3eh/ipsWHPQ2VO8/9fCcu3NdRYlXSorqXSJlTcXHapPmYvSIs7fYk
         XImg0DWPL3RHbcrGj02fI8jeuk4V0pG0ILpZh1zQDbAkCP3671PmJoBERHaFBYjfI9jp
         y0tr7GXWlC00VvkxDC7GiUiBgw8tjLm/8IyvldajZw9Vc2ZCUhnoADkIitTKXUr7TnIp
         lGOg==
X-Gm-Message-State: AGRZ1gKaR2dBzjsoZu9lWVkJMXQeuh8fmYanGcQnVsu4kSqpa8GMR/TM
        SR0R0FW0kBtA9lF/n4R0x/RiSOAm1iA=
X-Google-Smtp-Source: AJdET5dRJ/7pWTyFkbqKVWaKO/QOQ8GAYChHYAzRbHXcwgCxkFKg/sL6BaQMJeUCJHrk6PkOuEazeg==
X-Received: by 2002:a37:34f:: with SMTP id 76mr59290qkd.347.1540929120577;
        Tue, 30 Oct 2018 12:52:00 -0700 (PDT)
Received: from xanadu.home (modemcable228.104-82-70.mc.videotron.ca. [70.82.104.228])
        by smtp.gmail.com with ESMTPSA id v3-v6sm17485806qkg.14.2018.10.30.12.51.59
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 30 Oct 2018 12:51:59 -0700 (PDT)
Date:   Tue, 30 Oct 2018 15:51:58 -0400 (EDT)
From:   Nicolas Pitre <nicolas.pitre@linaro.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [GIT PULL] Cramfs fixes
In-Reply-To: <CAHk-=wh5LD3Wkk8gb_SoDGd3Yxsef2089jDDBxN4qHubab6c2w@mail.gmail.com>
Message-ID: <nycvar.YSQ.7.76.1810301550230.1498@knanqh.ubzr>
References: <nycvar.YSQ.7.76.1810301455170.1498@knanqh.ubzr> <CAHk-=wh5LD3Wkk8gb_SoDGd3Yxsef2089jDDBxN4qHubab6c2w@mail.gmail.com>
User-Agent: Alpine 2.21 (LFD 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 30 Oct 2018, Linus Torvalds wrote:

> On Tue, Oct 30, 2018 at 12:09 PM Nicolas Pitre <nicolas.pitre@linaro.org> wrote:
> >
> > Make the Cramfs code more robust against filesystem corruptions,
> > plus trivial indentation fixes.
> 
> Shortlog?

Sorry, I will next time.

> Anyway, pulled.

Thanks.


Nicolas
