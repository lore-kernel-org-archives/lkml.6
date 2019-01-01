Return-Path: <SRS0=7Uv1=PJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A606C43387
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Jan 2019 23:33:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 46613208E3
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Jan 2019 23:33:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="HF2uUcXv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727127AbfAAXdK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Jan 2019 18:33:10 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:42420 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726024AbfAAXdJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Jan 2019 18:33:09 -0500
Received: by mail-lf1-f65.google.com with SMTP id l10so19982794lfh.9
        for <linux-kernel@vger.kernel.org>; Tue, 01 Jan 2019 15:33:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EEVFybTvP7SGy/qZudzrxJYUtOtZ93TyGtrjhOSMPPA=;
        b=HF2uUcXvlcCU9e37vZAWixODHk4s/4AUVIf2YbJ6LPfJFeio0N98hKJVb/6hGwTLrG
         tRW9xh4AgjhxgMj+s4BdO5xz2TUpRv4z5ORwQydFXvK29a2aV43dEjfvUhYY3s0nzNJ1
         cca+bK8cQNS4CVe/syyByZHlBPcqoD9ZcZYj8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EEVFybTvP7SGy/qZudzrxJYUtOtZ93TyGtrjhOSMPPA=;
        b=g25nYqt1wkQF59N6d8E/8/px70Sr+SJvwMu3EdSXv8MlKL/5M/bBphY1PQj3VJ4TFv
         wBOxl5cpPEXqoBoow06ST5hC1XcHYFKr1VKcqWjmMpNpvdduARmInfmzhFZOKHQwAZCN
         RZ1tbhpecH+GlPOTDA+Mric8iVWSr3mFF2b0HXk+cI0U5mYJnm4mQWMzMlieSAcz3Zu9
         qT+I6gyyG1RiRcR82GFFJxqLECMlYd80HscCqFtCi58og1jnJiQ42hgjO9OWU+kjYHCF
         E6rQe5V5OJ/sskSUkTeWpEq/dpb4XKFVu6tuYoYG8d/CC+jrP9WMK/MkAMZtvnOvNPIO
         +3bw==
X-Gm-Message-State: AA+aEWbywtV77i4kfCgexrTeoEHmjgC9oKsV7zN7BFic3RgtVshfY025
        xylemVGQs+L/KpdBRBF2kbebMA/eL8E=
X-Google-Smtp-Source: AFSGD/Xecl2Qd0IfBzlPyb6R59o7oYN0w/pH6HUlf6BxrUn+pHxZEATfhMH3IPPDvOlh5VL5WXQ2+A==
X-Received: by 2002:a19:4345:: with SMTP id m5mr20422559lfj.142.1546385587464;
        Tue, 01 Jan 2019 15:33:07 -0800 (PST)
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com. [209.85.208.176])
        by smtp.gmail.com with ESMTPSA id z6sm9947977lfd.50.2019.01.01.15.33.06
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 01 Jan 2019 15:33:06 -0800 (PST)
Received: by mail-lj1-f176.google.com with SMTP id k15-v6so25757337ljc.8
        for <linux-kernel@vger.kernel.org>; Tue, 01 Jan 2019 15:33:06 -0800 (PST)
X-Received: by 2002:a2e:2416:: with SMTP id k22-v6mr26001315ljk.80.1546385586070;
 Tue, 01 Jan 2019 15:33:06 -0800 (PST)
MIME-Version: 1.0
References: <20190101160503.GA3306@localhost.localdomain> <CAHk-=whXWWXSMMPpm3eGV=PL12=K5LFM3didLBuGy1Y7vUbXVg@mail.gmail.com>
 <20190101231526.GA7944@localhost.localdomain>
In-Reply-To: <20190101231526.GA7944@localhost.localdomain>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 1 Jan 2019 15:32:50 -0800
X-Gmail-Original-Message-ID: <CAHk-=wiku0MygbFLmLjvCo-zzu4ygivkshdGzVVADYdwe-b57A@mail.gmail.com>
Message-ID: <CAHk-=wiku0MygbFLmLjvCo-zzu4ygivkshdGzVVADYdwe-b57A@mail.gmail.com>
Subject: Re: [GIT PULL] Thermal-SoC management updates for v4.21-rc1
To:     Eduardo Valentin <edubezval@gmail.com>
Cc:     Rui Zhang <rui.zhang@intel.com>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 1, 2019 at 3:16 PM Eduardo Valentin <edubezval@gmail.com> wrote:
>
> > It doesn't even build cleanly.
> >
>
> Do you still have have a copy of the build error?

A plain "make allmodconfig" shows a warning.

And I refuse to add new warnings.

                 Linus
