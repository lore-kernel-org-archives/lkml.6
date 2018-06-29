Return-Path: <SRS0=sqHT=JP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23085C43144
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 10:01:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CDA3027D14
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 10:01:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ng00Tv+O"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CDA3027D14
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754811AbeF2KBh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Jun 2018 06:01:37 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:37239 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752491AbeF2KBf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jun 2018 06:01:35 -0400
Received: by mail-pf0-f193.google.com with SMTP id h20-v6so2061181pfn.4;
        Fri, 29 Jun 2018 03:01:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=YIfENbRpQB2+Go/S99IB+WnIMmYW2om/+IIwypL1tdo=;
        b=Ng00Tv+OMkUKQa3od/V03srTYHiROR8O3Sb0XcGE6C1Bnn9dOtgEUNkzfQs/4DLTTW
         3Ig2ASVY/5Ld9vBGAJYyxVww22fnv7sF/okEQlJrN8y1UwUfRUTMPYtRVrou9dLG/R8M
         rX8RicKdSKl2V24s1W8B+XjhK8QR24nY8jWnVutcvScYdkK7jfGLh2GoZ+iM+OX63cAd
         avv08EHcRVxJITgR3C6xlcjAfNkssom6Kkzpp951bLHnwZqp7Qu9Tf+uOJMjc4zIbCg8
         zic7yIwTaXAnk0QMSmOevRqo0Ie5T3H+sxPp+bIe9IKlktqHfBAPsSID+EvjjY3HXo6w
         H5sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=YIfENbRpQB2+Go/S99IB+WnIMmYW2om/+IIwypL1tdo=;
        b=obHnDVFc40muGgz5SpWRcbfR6ki0AqRA/NgKStpdMKdl8K5cnx2tc62fJNju/CO41x
         VXVIFxuM7hiwFuk6H68wOJUvSEXQ3jm0t+1M5uhqQ9MBWZWzhofSWwMXrtXRMJuWSwbd
         3lJqUmnyZbv7xXWRzLWXUlJoYE1iQtWuVqsiN8tAYF1K1M3UhJW8ebyixybGKzm7vJPX
         FkbK3Lx67xhq3O59wGQsMpIEdVjRWFTrx9D4Qh2NYt6rVbfxq2JLGbV89gdLN8dA8JxH
         Sw6vLC1BrrBMcfu1nw84olTi9BakQ2RRO0vNvkXvU3Cv+7bxZLYzp49LhzWX2pJSjOWR
         PD+Q==
X-Gm-Message-State: APt69E0njsZtuwKQcArDTqXXqntM4rkkpbM2HlY+jz7VJ++41k22Fmvm
        6hIPvQXBMsDlPCEx1bQ90rY=
X-Google-Smtp-Source: AAOMgpfHd2GiHK2LP/HBT2DmMGJoEp0cbi6Ld1I5d2m6GvyVUlCEWmWzECbWtSKa1p6ATz89NuRnKg==
X-Received: by 2002:a62:fd0b:: with SMTP id p11-v6mr13834681pfh.52.1530266494884;
        Fri, 29 Jun 2018 03:01:34 -0700 (PDT)
Received: from localhost ([110.70.26.165])
        by smtp.gmail.com with ESMTPSA id z10-v6sm13893908pgo.58.2018.06.29.03.01.32
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 29 Jun 2018 03:01:33 -0700 (PDT)
Date:   Fri, 29 Jun 2018 19:01:29 +0900
From:   Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2 3/3] printk/nmi: Prevent deadlock when accessing the
 main log buffer in NMI
Message-ID: <20180629100129.GA10345@jagdpanzerIV>
References: <20180627140817.27764-1-pmladek@suse.com>
 <20180627142028.11259-1-pmladek@suse.com>
 <20180628022507.GD481@jagdpanzerIV>
 <20180628094125.cq5qunckjyxhbovb@pathway.suse.cz>
 <20180629014703.GA614@jagdpanzerIV>
 <20180629072507.lroaj34gxl2d5bze@pathway.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180629072507.lroaj34gxl2d5bze@pathway.suse.cz>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (06/29/18 09:25), Petr Mladek wrote:
> > So I summon Mr. Rostedt!
> > 
> > Does schedule_console_output() look bad?
> > What about defer_console_output()?
> 
> I am fine with both. I slightly prefer defer_console_output()

I am fine with defer_console_output().

	-ss
