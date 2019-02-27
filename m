Return-Path: <SRS0=HyMZ=RC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF322C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 08:54:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9723B218E2
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 08:54:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729752AbfB0IyJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Feb 2019 03:54:09 -0500
Received: from Galois.linutronix.de ([146.0.238.70]:48070 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726031AbfB0IyI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Feb 2019 03:54:08 -0500
Received: from localhost ([127.0.0.1] helo=vostro.local)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <john.ogness@linutronix.de>)
        id 1gyuyc-0003cs-4C; Wed, 27 Feb 2019 09:54:06 +0100
From:   John Ogness <john.ogness@linutronix.de>
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] printk/console: Do not suppress information about dropped messages
References: <20190226124945.7078-1-pmladek@suse.com>
        <87k1hmzfam.fsf@linutronix.de>
        <20190227083043.j6nw7t6nqulim6t7@pathway.suse.cz>
Date:   Wed, 27 Feb 2019 09:54:04 +0100
In-Reply-To: <20190227083043.j6nw7t6nqulim6t7@pathway.suse.cz> (Petr Mladek's
        message of "Wed, 27 Feb 2019 09:30:43 +0100")
Message-ID: <878sy1fw7n.fsf@linutronix.de>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019-02-27, Petr Mladek <pmladek@suse.com> wrote:
>> Imagine a situation where I am expecting a message to come, but don't
>> see it because it was dropped. But if no more non-supressed messages
>> come, I see neither the expected message nor the dropped message.
>
> Good point! There is a simple fix for this. We could print the warning
> also when all messages are proceed and we are about to leave the
> for-cycle.

Yes! That is the piece that was missing!

John Ogness
