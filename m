Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 499EDC1B0F1
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 02:32:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F20A220874
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 02:32:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F20A220874
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754167AbeFTCc2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 22:32:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:49130 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753917AbeFTCcZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 22:32:25 -0400
Received: from vmware.local.home (cpe-66-24-56-78.stny.res.rr.com [66.24.56.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CBBDE2086B;
        Wed, 20 Jun 2018 02:32:23 +0000 (UTC)
Date:   Tue, 19 Jun 2018 22:32:22 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Cc:     Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        linux-kernel@vger.kernel.org, "4 . 13+" <stable@vger.kernel.org>
Subject: Re: [PATCH] printk/nmi: Prevent deadlock when serializing NMI
 backtraces
Message-ID: <20180619223222.6cf05e0b@vmware.local.home>
In-Reply-To: <20180620015834.GD650@jagdpanzerIV>
References: <20180605124729.3vix5nlkjpjzdljx@pathway.suse.cz>
        <20180606051029.GA19211@tigerII.localdomain>
        <20180606103356.GB19211@tigerII.localdomain>
        <20180608104825.e7xoxteelaxnwx66@pathway.suse.cz>
        <20180618063738.GC27996@jagdpanzerIV>
        <20180618093917.qeaatnlqh5if6t3r@pathway.suse.cz>
        <20180618100718.GA555@jagdpanzerIV>
        <20180619075219.iq7ztwu43bn4uua7@pathway.suse.cz>
        <20180619082716.GD405@jagdpanzerIV>
        <20180619092304.6b6ba390@gandalf.local.home>
        <20180620015834.GD650@jagdpanzerIV>
X-Mailer: Claws Mail 3.15.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 20 Jun 2018 10:58:34 +0900
Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com> wrote:

> Which one of these you'd prefer to see in ftrace_dump():
> 
> - printk_nmi_direct_enter() / printk_nmi_direct_exit()

The above appears to be the most sane.

-- Steve

> - printk_chatty_nmi_enter() / printk_chatty_nmi_exit()
> - printk_large_nmi_enter() / printk_large_nmi_exit()
> - printk_dump_nmi_enter() / printk_dump_nmi_exit()

