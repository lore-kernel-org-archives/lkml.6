Return-Path: <SRS0=tq6k=PW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2885C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 19:33:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F8222064C
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 19:33:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="IBA2gUjT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726880AbfANTdU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 14:33:20 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:46807 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726728AbfANTdU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 14:33:20 -0500
Received: by mail-lf1-f68.google.com with SMTP id y14so108871lfg.13
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jan 2019 11:33:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=84ro3k+X6NMxIBhEZRQp3mgWvrx6fo/f2TsIhb327rE=;
        b=IBA2gUjTLiM2gJOqvvEIFmaFIKGSuQuoewgwBYEO/SAS9LFsqBpSXZqcVhn78nMuVX
         MuSjF/OjIWF/Fy3wcPe8vVfrAjv4exwrCY/gNpmEqeMM2/SvO5nCyefPaAOwLJ/jmvqQ
         BwO10ZF8a7qLl60oZC/MseeT2g5S9lagn2Tn0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=84ro3k+X6NMxIBhEZRQp3mgWvrx6fo/f2TsIhb327rE=;
        b=nIPM+KgK6oYnIpbJHT8tb55nQo2YuCl4WHZcdACUoc8zsgQ7wx2ypWks4zlSl/NfwY
         5znSXVX5dqJmj8eenlRUK4Yy6oAi2AE41nFk1gAJo1VyOFXBAC2Rp7Yy1BwwtkiQF/3U
         wHnDceqRWLfnFLHqs8XlaCyi5saCtRR9NGv9J8hOZA2IscJyPEC9hWelDdi/0IhfVaUH
         IQ/EZiWVfKkCwdvpYIHGWmJ+YuBGTkw1gBC3pdabLHGU3pfeVPOEUQhN9lJUFI9FtNso
         G0LiNVCjbeILUCnQjRhKUxIdWvoRwFjjLBhCqSRfzVbWpV7fMin6JqNfqkw5w+hizTos
         IuaQ==
X-Gm-Message-State: AJcUukcJn8S6+1XyUALMJTceE5pfiS6MMUTrEsqZ+7QEarjVxGCsN4Sg
        yBlU58YRfBdHOp/G1B5quTgPP27nFO8=
X-Google-Smtp-Source: ALg8bN59Pzige3HR7166KtmmCyXFVwUQnkUIcWyyQzC54Xdu2BxVF18OdI7Jg6VZ1HsTJhE1LRGoOw==
X-Received: by 2002:a19:920a:: with SMTP id u10mr47334lfd.122.1547494397587;
        Mon, 14 Jan 2019 11:33:17 -0800 (PST)
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com. [209.85.208.170])
        by smtp.gmail.com with ESMTPSA id d23sm232096lfc.11.2019.01.14.11.33.16
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 14 Jan 2019 11:33:16 -0800 (PST)
Received: by mail-lj1-f170.google.com with SMTP id k19-v6so144913lji.11
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jan 2019 11:33:16 -0800 (PST)
X-Received: by 2002:a2e:3e04:: with SMTP id l4-v6mr43551lja.148.1547494395747;
 Mon, 14 Jan 2019 11:33:15 -0800 (PST)
MIME-Version: 1.0
References: <20190114122540.7a54e6f3@gandalf.local.home>
In-Reply-To: <20190114122540.7a54e6f3@gandalf.local.home>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 15 Jan 2019 07:32:59 +1200
X-Gmail-Original-Message-ID: <CAHk-=wh6GsuJSoRH_2KzRVAggzeJTVo8W4uBWMi+7GATf3YzYg@mail.gmail.com>
Message-ID: <CAHk-=wh6GsuJSoRH_2KzRVAggzeJTVo8W4uBWMi+7GATf3YzYg@mail.gmail.com>
Subject: Re: [PATCH] sbitmap: Protect swap_lock from softirqs
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Jens Axboe <axboe@kernel.dk>, LKML <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        Clark Williams <williams@redhat.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Ming Lei <ming.lei@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 15, 2019 at 5:25 AM Steven Rostedt <rostedt@goodmis.org> wrote:
>
> The swap_lock used by sbitmap has a chain with locks taken from
> softirq, but the swap_lock is not protected from being preempted by
> softirqs.
>
> A chain exists of:
>
>  sbq->ws[i].wait -> dispatch_wait_lock -> swap_lock
>
> Where the sbq->ws[i].wait lock can be taken from softirq context, which
> means all locks below it in the chain must also be protected from
> softirqs.
>
> Cc: stable@vger.kernel.org

Ack and applied, except for the "stable" tag.

Both the original buggy code, and the incorrect "shut up lockdep" were
only merged after 4.20.

                 Linus
