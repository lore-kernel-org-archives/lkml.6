Return-Path: <SRS0=Fmhj=NM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B59ABC0044C
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 01:48:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5FE1820823
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 01:48:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cSv/oU5R"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5FE1820823
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727502AbeKAKtP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Nov 2018 06:49:15 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:46397 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725978AbeKAKtP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Nov 2018 06:49:15 -0400
Received: by mail-pf1-f193.google.com with SMTP id r64-v6so8495913pfb.13;
        Wed, 31 Oct 2018 18:48:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=R4QznA1zNb8qlU5c1UoOjZCoeSLsyaRSx0Z0DXKT61o=;
        b=cSv/oU5RvQzwpYFLi1nXxNJrrII1B1J3Ck5eRfLyYiuK0oEqSMbpx+rr35zkweyToE
         /q73iFq0NaZjWFoNL8/aXmAeDwZ1wumZYsVn0ZWCb3EI/yWOLRm4fwNy+RaTbUUhQQlg
         kvf85pxuabaQ4OdEVOnZ3gbr90JTkS9XVH2w1LevnX4io3JpfKypqWUA4wA+dNrFUhgM
         DH3/uu34FRxcnfMw5RrzqGFx60a10GUM27s+wO3h86Zd19uiGy/QjDhygYVXHrbNaNvB
         IIjI7CBveYnik9KP7h9JOz7CAN5cbhZWiW6ASBlH4IOoD0jYr3mrg0dHr1zLpL1WuJit
         315A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=R4QznA1zNb8qlU5c1UoOjZCoeSLsyaRSx0Z0DXKT61o=;
        b=pG9s6XXyXfyBH8GLAJ4rIB6TzG44aWufbxhDMOwgADdfZaFkIjx13SvFL+jT95nbZg
         VYU3CNsK5x0XDlO2Eytiqk7i5mMpJ6jXNBVcxrZi7ZVhtJw56jw6tTJavoPI0dAuRhCz
         apC2miYXkpikef7AFHscy5DiFBe5t7WxmN2h5prn2cgpsVoKjOUuJKqGCaGsD0h4uIVh
         Pr1PZ6C7ikj0lBkY8eWirjYEtzblcNUB9FR2iBvL5vr4Lqn7b0tfvxjQgm1TTCXklaMD
         sglU/Cn8l/sDK34GHHkXIZw4ME1ZG0KvA/Creqh1MzRSNA/dwy/lU7zJgFZcaORt0n2v
         25gg==
X-Gm-Message-State: AGRZ1gK7FIK2CMLRuM79PnlHliU2XisP4SEVXGy9OvWmehD6THTm9zdZ
        IHh/1x9n0bEHSoV9yrhWtaQ=
X-Google-Smtp-Source: AJdET5djex3Tv+5ms7i4RqgnnNiwbVvJXHlndQNKAd5wg4/+H9NIFM87EImP09V015wxaLby7ZUO9w==
X-Received: by 2002:a63:6302:: with SMTP id x2mr5366991pgb.183.1541036905942;
        Wed, 31 Oct 2018 18:48:25 -0700 (PDT)
Received: from localhost ([175.223.27.119])
        by smtp.gmail.com with ESMTPSA id s8-v6sm2103378pgi.44.2018.10.31.18.48.23
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 31 Oct 2018 18:48:24 -0700 (PDT)
Date:   Thu, 1 Nov 2018 10:48:21 +0900
From:   Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
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
Message-ID: <20181101014821.GB502@jagdpanzerIV>
References: <20181016050428.17966-2-sergey.senozhatsky@gmail.com>
 <20181025101036.6823-1-sergey.senozhatsky@gmail.com>
 <20181031122736.epbxu424l3xagge5@pathway.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181031122736.epbxu424l3xagge5@pathway.suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (10/31/18 13:27), Petr Mladek wrote:
> > 
> > Signed-off-by: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
> 
> The patch makes sense to me. The locks should stay busted also for
> console_flush_on_panic().
> 
> With the added #include <linux/vt_kern.h>:
> 
> Reviewed-by: Petr Mladek <pmladek@suse.com>

Thanks!

Since there are no objections - how shall we route it? Via printk tree?
I'd also prefer this patch to be in -stable, it fixes a real issue after
all.

	-ss
