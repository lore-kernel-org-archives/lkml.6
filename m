Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.3 required=3.0 tests=DKIM_SIGNED,FSL_HELO_FAKE,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,USER_AGENT_MUTT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81147C6778C
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 07:56:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 311DD24DE5
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 07:56:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gcxLgCB4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 311DD24DE5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933442AbeGCH4q (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 03:56:46 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:55259 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753364AbeGCH4o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 03:56:44 -0400
Received: by mail-wm0-f68.google.com with SMTP id i139-v6so1215461wmf.4
        for <linux-kernel@vger.kernel.org>; Tue, 03 Jul 2018 00:56:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=eXn9TX9uOUDrWIGJ59oHkaLXdAoTDmYnAJV1Hw2cOaY=;
        b=gcxLgCB4uHbsmUBKd2onJjBkmTOqg6pg2/WARxpItsYTq6FQID63W5A3bkJLLXHDXu
         697MjVDXs4TYT8wXfobszsr8jPF2p1TqXh6j1AlewJSLOaXoXzyMP9Im7TrN4OvXUH5F
         zxaDBqd6GyXX1NUbw3yBl+RvSn4+AgTntWMZnE1xZfqttrLX6fS2csuGr8wwotJA9o4D
         6UeJme70huodXOcUijnKQwVj0HFi+l0meS7x2JflMG8NsH95yuPNk5NnF3O8weHeyiHw
         Grq8WZnhU9xL1rS+g8sJLKm5Fdtmb0CjAAvH3GCnf3gDZqSd8wRlh9kB2ani9Oy+5Teq
         ndLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=eXn9TX9uOUDrWIGJ59oHkaLXdAoTDmYnAJV1Hw2cOaY=;
        b=GCuf8kWIfMxPUQI62L3LAVtUIRQFyAh3EY2K98izI+VtfvVArlS4xTJYLv+P6s3gh1
         BzFiiDpNVcUA7aDYU4xq7u+JCAxWEckRKmf3bogk/ttMfEQta+1uAW7C7ihdNUP0txT/
         g8qRKIauy0ptTH5Rzed3YUyVHL1+nR8NCyQ/XtVUDrIbqwWfdSHBpINwJjaxE+EB82gU
         9f/jMEe5wCMh072DxAxSkiRrLKDbQLGvFhQ3+PVeozKZMK7bHaqa/1L8y6D2qssTjWHR
         XEqXOfJVmpexY4kVbSlg6a3b/YqazKBaCFF7eWBD9QxRlCgYEPdnHz/8XAJI3IU+D8l2
         xmKQ==
X-Gm-Message-State: APt69E2vW5RrDpDD/9djimHS9HkaF02HLeYZ5utTvIIalQrF2E9vVCXL
        i7fvMdjGRX1pSznDGFIaYidQCg==
X-Google-Smtp-Source: AAOMgpeatZOLGHKH/WuFqVqGdPXYo5/ZxPHbjMYZccvgXnO2TtLhZlHWD4HNI4Eq237Fw78NGqL8TQ==
X-Received: by 2002:a1c:9754:: with SMTP id z81-v6mr386833wmd.35.1530604603608;
        Tue, 03 Jul 2018 00:56:43 -0700 (PDT)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id 24-v6sm1718588wrz.94.2018.07.03.00.56.42
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 03 Jul 2018 00:56:42 -0700 (PDT)
Date:   Tue, 3 Jul 2018 09:56:40 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Andy Lutomirski <luto@amacapital.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [GIT PULL] x86 fixes
Message-ID: <20180703075640.GA14419@gmail.com>
References: <20180630084933.GA15210@gmail.com>
 <CA+55aFz4BiRVKKwdF+y8K4O1jZnig8mmuQZ7prGp6o+DiH_TeQ@mail.gmail.com>
 <CALCETrWiTEscV8E--v6=+kkvfWKf_OXzVceMjX7GA51uJo-+DQ@mail.gmail.com>
 <CA+55aFzakezPMP+=9KAaM+fJtR4BeKWj5MjEuPFwiH6K1wBqbg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+55aFzakezPMP+=9KAaM+fJtR4BeKWj5MjEuPFwiH6K1wBqbg@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Linus Torvalds <torvalds@linux-foundation.org> wrote:

> On Mon, Jul 2, 2018 at 11:48 AM Andy Lutomirski <luto@amacapital.net> wrote:
> >
> > BTR is way more leet than AND!
> 
> I stand corrected.

Ok, on that basis I won't try to convert it to AND ;-)

Seriously though, there's two other 32-bit prefix cleanup/micro-speedup changes 
I'll queue up later today:

  [PATCH v2] x86-64: use 32-bit XOR to zero registers
  [PATCH] x86/entry/64: add two more instruction suffixes

I'll Cc: you guys on the commits and maybe you can find something weird (or leet) 
in them as well.

Thanks,

	Ingo
