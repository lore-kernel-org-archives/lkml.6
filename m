Return-Path: <SRS0=Fmhj=NM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8A94C0044C
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 08:08:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A52822082E
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 08:08:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A52822082E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728073AbeKARKG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Nov 2018 13:10:06 -0400
Received: from mx2.suse.de ([195.135.220.15]:41284 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727753AbeKARKG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Nov 2018 13:10:06 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 1BEE4AEE9;
        Thu,  1 Nov 2018 08:08:09 +0000 (UTC)
Date:   Thu, 1 Nov 2018 09:08:08 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Cc:     linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
        Daniel Wang <wonderfly@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alan Cox <gnomes@lxorguk.ukuu.org.uk>,
        Jiri Slaby <jslaby@suse.com>,
        Peter Feiner <pfeiner@google.com>,
        linux-serial@vger.kernel.org,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Subject: Re: [PATCHv3] panic: avoid deadlocks in re-entrant console drivers
Message-ID: <20181101080808.n73lrlnjd65nk4qf@pathway.suse.cz>
References: <20181016050428.17966-2-sergey.senozhatsky@gmail.com>
 <20181025101036.6823-1-sergey.senozhatsky@gmail.com>
 <20181031122736.epbxu424l3xagge5@pathway.suse.cz>
 <20181101014821.GB502@jagdpanzerIV>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181101014821.GB502@jagdpanzerIV>
User-Agent: NeoMutt/20170421 (1.8.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 2018-11-01 10:48:21, Sergey Senozhatsky wrote:
> On (10/31/18 13:27), Petr Mladek wrote:
> > > 
> > > Signed-off-by: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
> > 
> > The patch makes sense to me. The locks should stay busted also for
> > console_flush_on_panic().
> > 
> > With the added #include <linux/vt_kern.h>:
> > 
> > Reviewed-by: Petr Mladek <pmladek@suse.com>
> 
> Thanks!
> 
> Since there are no objections - how shall we route it? Via printk tree?

Good question. OK, I am going to put it into printk.git unless I hear
complains withing next couple of days.


> I'd also prefer this patch to be in -stable, it fixes a real issue after
> all.

It makes sense.

Best Regards,
Petr
