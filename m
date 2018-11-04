Return-Path: <SRS0=jXQK=NP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD170C0044C
	for <linux-kernel@archiver.kernel.org>; Sun,  4 Nov 2018 01:13:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 533B52081D
	for <linux-kernel@archiver.kernel.org>; Sun,  4 Nov 2018 01:13:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="LsbQHhGD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 533B52081D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728796AbeKDK0m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 4 Nov 2018 05:26:42 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:37863 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727755AbeKDK0l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Nov 2018 05:26:41 -0500
Received: by mail-lj1-f196.google.com with SMTP id e5-v6so777478lja.4
        for <linux-kernel@vger.kernel.org>; Sat, 03 Nov 2018 18:13:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zHhZXUJDiiUCRfw/IkJelq8lkJ0ambiASotg+aIADnw=;
        b=LsbQHhGDim4jVlJ2Ghcv6iWZZ4GSJ2+VkqA3cMK+9x00Ycz2/l7v72pg5UDcBwPSse
         7Xoorxd+9ltCAQH5Q7cfjcvrlpJDVWrfk08Y+mYuGi05MLzaGReMM+hascmZ2FYMYujL
         P3+tclsVd7Bc80ZouitR6p1BTh9kWAWQp2ET4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zHhZXUJDiiUCRfw/IkJelq8lkJ0ambiASotg+aIADnw=;
        b=mTUcnw9kW+6SBjyq2tOSGAWp8/qjkpy9wKsPnoscJBkXTKjFKFjQOu77sl4d2mhMC6
         R//mT+USdxjwg+XYRfzelE231wVFYfrIM8x9YKc9hTscAP8rkuoNSFQbvSDEGZJxtwdh
         dy67UTVtUdDTGYmZZiSLS5CZ+POAPGLwIov2CpGKi/yWFw+lNWOJDOxlKc2QAIqZixrs
         ELmwdb4HvzgdutggPogwPyv1O/b1FpVFIApS2VUAvk3n6fmxmiAmSgpxpE3i49+P4GGs
         bFvGc7+9LMSZ9cWT8yDqCefUd/fiYb1ImUe0AKijpo62O+foKw7LvCsCkcdfR5ce8YxG
         qQNA==
X-Gm-Message-State: AGRZ1gKSssLdMTFt9cyp1PT6waa7Ax3uvrnc5WiICUpRFjEFcbSh8c4J
        KgwDK4SE7M8iJuQE8FizkTAhqYcsIKs=
X-Google-Smtp-Source: AJdET5cayfO719d4NGNNrsB5TaZy2fil4axsAD3B3ZluCIuFXUkJmTw/TdskjyB1sZw4E8JJnooBZg==
X-Received: by 2002:a2e:8403:: with SMTP id z3-v6mr11892035ljg.121.1541294017656;
        Sat, 03 Nov 2018 18:13:37 -0700 (PDT)
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com. [209.85.208.171])
        by smtp.gmail.com with ESMTPSA id z17-v6sm2642254lfd.14.2018.11.03.18.13.36
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 03 Nov 2018 18:13:36 -0700 (PDT)
Received: by mail-lj1-f171.google.com with SMTP id w10-v6so2267206ljh.0
        for <linux-kernel@vger.kernel.org>; Sat, 03 Nov 2018 18:13:36 -0700 (PDT)
X-Received: by 2002:a2e:9584:: with SMTP id w4-v6mr11182432ljh.118.1541294015633;
 Sat, 03 Nov 2018 18:13:35 -0700 (PDT)
MIME-Version: 1.0
References: <20181103225932.GA62024@gmail.com>
In-Reply-To: <20181103225932.GA62024@gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 3 Nov 2018 18:13:19 -0700
X-Gmail-Original-Message-ID: <CAHk-=wh1iDUdAtxoCzgv2DSHs4SJ0xRbNcj1EGbkAuFvFS+4mw@mail.gmail.com>
Message-ID: <CAHk-=wh1iDUdAtxoCzgv2DSHs4SJ0xRbNcj1EGbkAuFvFS+4mw@mail.gmail.com>
Subject: Re: [GIT PULL] IRQ fixes
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        tglx@linutronix.de, Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 3, 2018 at 3:59 PM Ingo Molnar <mingo@kernel.org> wrote:
>
> An irqchip driver fix and a memory (over-)allocation fix.

Pulled,

                 Linus
