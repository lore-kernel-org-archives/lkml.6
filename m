Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A13AEC5CFC0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 09:59:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 673F220652
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 09:59:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 673F220652
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965517AbeFRJ7g (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 05:59:36 -0400
Received: from mx2.suse.de ([195.135.220.15]:45473 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S964908AbeFRJ7e (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 05:59:34 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (charybdis-ext-too.suse.de [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 2CD98AB3D;
        Mon, 18 Jun 2018 09:59:33 +0000 (UTC)
Date:   Mon, 18 Jun 2018 11:59:32 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Subject: Re: [RFC][PATCH] printk: do not call console drivers from
 printk_safe context
Message-ID: <20180618095932.pshslpzntgfr7lg4@pathway.suse.cz>
References: <20180424022802.1330-1-sergey.senozhatsky@gmail.com>
 <20180424105104.792d2d80@gandalf.local.home>
 <20180425144813.lfhvuwsf2cebwarm@pathway.suse.cz>
 <20180618063916.GD27996@jagdpanzerIV>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180618063916.GD27996@jagdpanzerIV>
User-Agent: NeoMutt/20170421 (1.8.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 2018-06-18 15:39:16, Sergey Senozhatsky wrote:
> On (04/25/18 16:48), Petr Mladek wrote:
> > 
> > So I agree that printk_safe context does not help much. And I fine
> > with this patch.
> > 
> 
> Petr, do you want me to resend the patch with the updated commit message?

I am sorry for abandoning this patch. Hmm, I am a bit unsure about it now.

The printk_safe context partly prevents recursion problems when
console drivers print messages. I expected that this patch
would have been pushed together with a better solution for
the recursion. But we still do not have any.

Would you mind to keep it on hold for now? I know that it might
help in some situations. But it also makes the code more complicated
and there is some risk of a regression. I would prefer when it
is pushed in a situation when it is a clear win.

Best Regards,
Petr
