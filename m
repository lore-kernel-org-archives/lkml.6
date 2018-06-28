Return-Path: <SRS0=VxZE=JO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E93F4C43144
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 02:55:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F942257C5
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 02:55:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PpOMGRp6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9F942257C5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932761AbeF1CzX (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Jun 2018 22:55:23 -0400
Received: from mail-pg0-f66.google.com ([74.125.83.66]:32957 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932322AbeF1CzR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jun 2018 22:55:17 -0400
Received: by mail-pg0-f66.google.com with SMTP id e11-v6so1794969pgq.0;
        Wed, 27 Jun 2018 19:55:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=skCbf+DfXdqw9S/HcSge1QOD7NgcjCH4BdVpJ466xIM=;
        b=PpOMGRp6cgf4gCXTZf/k4N+j1RFB/Hu4wXskTxKuyn5oVl5/nRllrlqw8+dq9t6eKA
         rPwRZ+u/lkUKA63bAPXi1u0s+uAxNoFnq5gH4WFYsy89Ko4q6+sZlY3bcqLxG1xHRjrM
         7MtX22YNTT04pXiH2SrLFU/MNnDa/jBhJEaTS3k0OwU1OjX54QUbW59MfRhu/OSnff4e
         1btH+cn8RYVzfbTWnK2xLQ+1CsFTiJPrk1ZgbbupZMMzUINQFib8t8P1B2cn2YRXwm+B
         Qo5DfTnK+GPI3va+ENPg3AtxR8gM5C0wbGVZi4ZLQ9AP3BEOGNCTFPjTjPNL/rFJUT4R
         pOQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=skCbf+DfXdqw9S/HcSge1QOD7NgcjCH4BdVpJ466xIM=;
        b=Yk1avL05FaKseRty6KtQkyivznKcv2mLlcE6gzOLrWTNftutF+tqESCJLsOh/njC1A
         +FrPSe6nkb1Vnb7w3isjNQ7aMlSkBZe866euuHL1JWPFBx6wYeqct53l4vGVNfXDrZUP
         aR1xPo4uTJJDWMhDNV7Ti3iVzVE+FXLqPAeAZ9yoAA9myQrQZWbYSxyTesyvID0oOg8j
         +exLOIN8yooESAFiuwATSNg0UzemhQMZr87u8BeHdDHff0Pgz5Cw47IXqGHMOeAGdkw6
         T18dJ0sIa1+hrrlP7oPGtwLlPcyMFEBhM1WUfEeTtWwuhJUFe54xmugQryWSypk1J9FQ
         dT2w==
X-Gm-Message-State: APt69E3gaePv4coKenwJoCD3ETi6ZnSc7FM2wFUapzGss5c0qgiGfCNI
        aELq5tk+OMqKI0mzslD+oVhGcDP/
X-Google-Smtp-Source: AAOMgpdYUZU5QBlOunr1DIlC8iTsB86aZiGlxOyQVNCapTipn15vscP87sAsBdEtRR60OrIxSN7Brg==
X-Received: by 2002:a63:4386:: with SMTP id q128-v6mr1096162pga.353.1530154517074;
        Wed, 27 Jun 2018 19:55:17 -0700 (PDT)
Received: from localhost ([110.70.27.221])
        by smtp.gmail.com with ESMTPSA id u1-v6sm7820302pfn.59.2018.06.27.19.55.14
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 27 Jun 2018 19:55:15 -0700 (PDT)
Date:   Thu, 28 Jun 2018 11:55:12 +0900
From:   Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>,
        Steven Rostedt <rostedt@goodmis.org>
Cc:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Petr Mladek <pmladek@suse.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-serial <linux-serial@vger.kernel.org>,
        SergeySenozhatsky <sergey.senozhatsky@gmail.com>
Subject: Re: [RFC][PATCH 0/6] Use printk_safe context for TTY and UART port
 locks
Message-ID: <20180628025512.GF481@jagdpanzerIV>
References: <20180615093919.559-1-sergey.senozhatsky@gmail.com>
 <20180618143818.50b2f2f9@alans-desktop>
 <20180619005308.GA405@jagdpanzerIV>
 <20180619083021.4avsgvcqjrpkat6s@pathway.suse.cz>
 <CA+55aFz9aGc-vGvKv_ZR2W2ZkZNSZfOHa0m_MbGH_a=x8oAW5Q@mail.gmail.com>
 <20180620025050.GE650@jagdpanzerIV>
 <CA+55aFzC5=awDhzOy9u_2FNaQmRprUTxj_KV2xO+GnpNAFg8MQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+55aFzC5=awDhzOy9u_2FNaQmRprUTxj_KV2xO+GnpNAFg8MQ@mail.gmail.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (06/20/18 12:38), Linus Torvalds wrote:
> On Wed, Jun 20, 2018 at 11:50 AM Sergey Senozhatsky
> <sergey.senozhatsky.work@gmail.com> wrote:
> >
> > It's not UART on its own that immediately calls into printk(), that would
> > be trivial to fix, it's all those subsystems that serial console driver
> > can call into.
> 
> We already have the whole PRINTK_SAFE_CONTEXT_MASK model that only
> adds it to a secondary buffer if you get recursion.  Why isn't that
> triggering? That's the whole point of it.

Linus, Alan, Steven,
are you on board with the patch set?
What shall I do to improve it?

PRINTK_SAFE_CONTEXT_MASK is what we answer nowadays when someone says
"printk causes deadlocks". We really can't remove all printk-s that can
cause uart->...->printk->uart recursion, and the only other option is to
use spin_trylock on uart_port->lock in every driver and discard con->write()
if we see that we have re-entered uart. I'd rather use per-CPU printk_safe
buffer in this case.

	-ss
