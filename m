Return-Path: <SRS0=Rtk1=K5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 587F0C46464
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 01:24:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 00EBE2170A
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 01:24:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YVZOdFXp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 00EBE2170A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725999AbeHNEJQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Aug 2018 00:09:16 -0400
Received: from mail-qk0-f177.google.com ([209.85.220.177]:45066 "EHLO
        mail-qk0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725778AbeHNEJP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Aug 2018 00:09:15 -0400
Received: by mail-qk0-f177.google.com with SMTP id c192-v6so12340265qkg.12;
        Mon, 13 Aug 2018 18:24:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=XuUMUDp/ceC1PRucYU5HbvWZsnuilPRMPaLQ/lh7Ymw=;
        b=YVZOdFXpzkh5N9dxrAY8zvVgbyManefU8UkjfzyJnOHIHT7W8s3+CXQREI/O1Dxk26
         9BFY/eBBzm/Q0cbvQpVime6t5kAupBeBaUYg9TEqEixgAGl+QxPu7OBG+0bm/1mIiIz7
         NplsTpQJQMvRXVhYdwT5nRN7itJjer5g2ferMO7PXtnT6kN5ORZdjTSjk4JoD0AkTU7p
         zwuJ1LmvBqpniozRdWVN1anzKz06uCZIrCRUyLYZTaGgqprp5+EWrkLloOikpRCtdKRX
         bNSy/FaSpgTy87nHKpQYsdOJ8Q179M/Vn5iCHocoF4yi0dI18SlqHtTyWPJvULLeCRDG
         s18A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=XuUMUDp/ceC1PRucYU5HbvWZsnuilPRMPaLQ/lh7Ymw=;
        b=aW75eAAoBU96JnxYapgiahnN1ASBeUroaTfEnnVrHyUCgjih5BQxL/cZS0Nli3C5bX
         xPA4jiMKESCvC4iAwK0v7vdPw+0AsCtRkqQHwiiBY+TFYjdu3RfYWPh+/XzX9aivhJTo
         usfS6coqZnRpf7bLeVT04Exg5cVrKEj4PQnoZDc4U6rWL7eo9JE2399J3gC7/x/MPma6
         +0/7aqF3hW4NNVvFogAIr8kKsGv9uamiWTpLZdqIGKmSdo2iN3UyKHvYnZi+7lo7dmNv
         WTea+AbQG38aS1oUcKviaB2HJBeNsWByWdAn2xfXnGSNYp44W2Cz5qAN3NayyQU2vSbx
         Psig==
X-Gm-Message-State: AOUpUlGIxc+kEQw4FQd+M1mTKSw3LJclGYXZxCNSatMoPh2P3FcE6QIX
        7NJvryJs/4zI0ZEwfogurSQ=
X-Google-Smtp-Source: AA+uWPwPeZg/cMzsbDS6aox1kwVRK6H36z9YttVuJQzxDRIf6ZdhXQ/DsoI1NZ4oW21Gjy6ykY/HFQ==
X-Received: by 2002:a37:c91b:: with SMTP id q27-v6mr18298041qki.397.1534209867718;
        Mon, 13 Aug 2018 18:24:27 -0700 (PDT)
Received: from localhost.localdomain ([2001:1284:f016:221:8acd:4adb:7ae9:59ac])
        by smtp.gmail.com with ESMTPSA id b62-v6sm12923342qkj.48.2018.08.13.18.24.25
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 13 Aug 2018 18:24:26 -0700 (PDT)
Received: by localhost.localdomain (Postfix, from userid 1000)
        id F05E9180BFC; Mon, 13 Aug 2018 22:24:21 -0300 (-03)
Date:   Mon, 13 Aug 2018 22:24:21 -0300
From:   Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>
To:     syzbot <syzbot+6a15c8ad0f0632ccd7f3@syzkaller.appspotmail.com>
Cc:     davem@davemloft.net, linux-kernel@vger.kernel.org,
        linux-sctp@vger.kernel.org, netdev@vger.kernel.org,
        nhorman@tuxdriver.com, syzkaller-bugs@googlegroups.com,
        vyasevich@gmail.com
Subject: Re: WARNING: refcount bug in sctp_transport_put
Message-ID: <20180814012419.GB26909@localhost.localdomain>
References: <000000000000fb3b1605735aa815@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <000000000000fb3b1605735aa815@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 13, 2018 at 05:55:02PM -0700, syzbot wrote:
> ------------[ cut here ]------------
> refcount_t: underflow; use-after-free.
> WARNING: CPU: 1 PID: 7203 at lib/refcount.c:187
> refcount_sub_and_test+0x2e7/0x350 lib/refcount.c:187
> Kernel panic - not syncing: panic_on_warn set ...
> 
...
>  refcount_dec_and_test+0x1a/0x20 lib/refcount.c:212
>  sctp_transport_put+0x76/0x200 net/sctp/transport.c:331
>  sctp_generate_heartbeat_event+0x2d7/0x450 net/sctp/sm_sideeffect.c:416
>  call_timer_fn+0x242/0x970 kernel/time/timer.c:1326
>  expire_timers kernel/time/timer.c:1363 [inline]
>  __run_timers+0x7a6/0xc70 kernel/time/timer.c:1666
>  run_timer_softirq+0x4c/0x70 kernel/time/timer.c:1692
>  __do_softirq+0x2e8/0xb17 kernel/softirq.c:292
>  invoke_softirq kernel/softirq.c:372 [inline]
>  irq_exit+0x1d4/0x210 kernel/softirq.c:412
>  exiting_irq arch/x86/include/asm/apic.h:527 [inline]
>  smp_apic_timer_interrupt+0x186/0x730 arch/x86/kernel/apic/apic.c:1055
>  apic_timer_interrupt+0xf/0x20 arch/x86/entry/entry_64.S:863
>  </IRQ>

Interesting, again on heartbeat timer handler.

  Marcelo
