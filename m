Return-Path: <SRS0=wmYC=LT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDDB8C433F5
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 14:39:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA6D820857
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 14:39:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LtpNRjX8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AA6D820857
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727876AbeIETKQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Sep 2018 15:10:16 -0400
Received: from mail-vk0-f66.google.com ([209.85.213.66]:43926 "EHLO
        mail-vk0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726366AbeIETKQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Sep 2018 15:10:16 -0400
Received: by mail-vk0-f66.google.com with SMTP id s17-v6so2765549vke.10;
        Wed, 05 Sep 2018 07:39:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=ZhqCLMlhsJ0fyfI0vtrNSBu63Ywd65Nq0a8g/Zf2t/8=;
        b=LtpNRjX8ht1Yb1WVoft7CDAUYFrqwz5Kp/2TtYo3hICVnUa7Mwg64dTnZSHOeeAJf1
         BxM6IChjCCl9x0UnReWq45c0BbzHLl5bUZTz/bJlFv8ASMs4unBxM4kF5SVY85M0mEdW
         a9IVv4xZQSyoj8ADaPBoz0rpj8BU8nJOPIwY+gIl0KRo776zEefZTXwp6/UYW1/bapiP
         7176uSjZiWgjSII1HX86L7mY0v3rT0KRTl8jxEWIK8cT8g6vsfp7VDhiVbkM3L8uosMe
         fw6/q3LtcQjjMwPGgdJ6ZRuTQkN7fjoo7Rjsi78R/3NYfxjfqiX0JI5xofuH7YxzmYjI
         gkJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=ZhqCLMlhsJ0fyfI0vtrNSBu63Ywd65Nq0a8g/Zf2t/8=;
        b=etW1o6goC7G8zb293+WVvFeuTWIwpIlDy4JANubEqRiWQBeGnDVNYHjtc3pTtIfp6/
         UL6i4h/pYtKoepWaGIOcmJptLu+rYICc3EIWsaNlDkaJZFk1EclWQU6rNq4GIh+6EWcq
         vDjulJ97FVpinl7e3TCq2JMzKrtCrjwpRKJ3/tXk8nDvktXY3i/JOuM4yRZeEFdPpSNr
         d9/+usSPGdjLZayVvL5z0yzoz0xOn+DnP6sUR0UcmJbTibJzeWde2YnwLUf4/Glows1z
         O0ftrH7Z7fbPwjpvwBK9OUlvO5J4FdZNQaPVxkn9MXGoHJTrIET0bXtk/DWj9KkkKzW9
         sCyg==
X-Gm-Message-State: APzg51AT3SVtGmY/oakjgFJL9oHZBGWNXAH+Ggnw4U/ObrEWz2ZyEJTB
        IhKdRpDwIb2+w5IpHVkh+zgGr/+BGvovSuRSfg==
X-Google-Smtp-Source: ANB0VdbK/TlpyD3HTROt5duQmvHY5PlEnuh2ZlaEZ1w2Y9yIlEdP3qftINDrYi5TGJOBsDaN0soi7NMEt4zeRY5VUSg=
X-Received: by 2002:a1f:5641:: with SMTP id k62-v6mr19278568vkb.12.1536158386144;
 Wed, 05 Sep 2018 07:39:46 -0700 (PDT)
MIME-Version: 1.0
References: <CAP8WD_YEyxKOimMrGk+5Db8DpNfqQL84-2xLXbe53jiY_FoPrQ@mail.gmail.com>
 <CAADnVQJjqLY3iFy2y5mb+oMR=VHS8HS_KXa0wm1HO3v0ayvrkw@mail.gmail.com>
 <CAP8WD_ba1k6uxSFQ00QtW0L23jzjSFw93YpEq+010zKE5sT27g@mail.gmail.com> <05825446-e8aa-a983-3fc6-4dc8e81cba57@iogearbox.net>
In-Reply-To: <05825446-e8aa-a983-3fc6-4dc8e81cba57@iogearbox.net>
Reply-To: whiteheadm@acm.org
From:   tedheadster <tedheadster@gmail.com>
Date:   Wed, 5 Sep 2018 10:39:34 -0400
Message-ID: <CAP8WD_ahR75c7OutCSbPKdt43QUpBB+Eup-E_b9dHaoTqTq5cw@mail.gmail.com>
Subject: Re: Allocation failure with subsequent kernel crash
To:     Daniel Borkmann <daniel@iogearbox.net>
Cc:     Matthew Whitehead <whiteheadm@acm.org>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        netdev <netdev@vger.kernel.org>, Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Alexei Starovoitov <ast@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> I've been looking into it a bit today and still am. Given you've seen
> this on x86_32 and also on older kernels, I presume JIT was not involved
> (/proc/sys/net/core/bpf_jit_enable is 0). Do you run any specific workload
> until you trigger this (e.g. fuzzer on BPF), or any specific event that
> triggers at that time after ~5hrs? Or only systemd on idle machine? Have
> you managed to reproduce this also elsewhere? Bisect seems indeed painful
> but would help tremendously; perhaps also dumping the BPF insns that are
> loaded at that point in time.

Daniel,
  I've been trying for days to bisect this, but it is hard to
reproduce. However, I did have a question.

The crash is happening when bpf_prog_load() hits an error case and
then jumps to free_used_maps(prog->aux). However, I don't see an
obvious place where the 'aux' field gets initialized in
bpf_prog_load(). So it might easily be zero/null.

Could that explain the crash due to "unable to handle kernel NULL
pointer dereference"?

- Matthew
