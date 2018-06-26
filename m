Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7110C43144
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 05:07:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8BDF126509
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 05:07:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V2uFFtfY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8BDF126509
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751347AbeFZFHh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 01:07:37 -0400
Received: from mail-pl0-f67.google.com ([209.85.160.67]:39534 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750960AbeFZFHf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 01:07:35 -0400
Received: by mail-pl0-f67.google.com with SMTP id s24-v6so7947383plq.6;
        Mon, 25 Jun 2018 22:07:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=l8jDJ2S/e0L7yGEIqe1TG2CV/lgShCWQVM1f2Gd7HYk=;
        b=V2uFFtfYLrbFQQGui8FSp9XARWJXwsbIlLYOyM5Y6PLzSTeya84E/5qfVLH/VI03O/
         3hyctq0/jdElvioFTqGbWdqWBqL8LF0aPhM6be2pQ0Qbk4RvRCSeAMgUuZlbbmtztWF/
         exmaRIK8fNTjmvmUdtpj+DDFB753W+snDP9KlI7FyVAIeICWYEpaVWBYU+15IqZ0Mvdl
         bOSY7fsAnC/JbUpZOxPcGkvL53V/Bd0NbtrQpO/p+gHOgXqNESrwMhuh2Rtq9X98nIfK
         WGqWWwl6AEbPAJ0cEn7vdKdmWJ3zivqYXmPNA5Bb9MfinapTQPUEfpLun1AdO+XBKNHE
         ie2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=l8jDJ2S/e0L7yGEIqe1TG2CV/lgShCWQVM1f2Gd7HYk=;
        b=aANdoIaRZX1Tk1TbFcvtormqaBEJK/jFOLhylrSkN/aGyzU2jGbwPxo7a5tqHswKGJ
         eb/z+1jinHcTcgjOmx0LBDK6sjKLyX4AUAoYpGKkIDj0ERojNTcp1jebXt4wSDn5HvIi
         M1NB9mjgdEeK5LH6sB1e4nk4rY5mp9lPUDayfe84O7gUgvgF9+fXV2NtFqKtCPVyg7H9
         c0o7XU5t9mFKnWfbUkVQwKkN35c7P9xIMfBbiTxZK+y7omAqtiQLP13JauXOLZ5bxZN9
         s3W77OX36vYiVmDK/MrJO+FiwMvVYV44b68qh3dnMqilGcbWfPvSrPCpkQSEUfhVVGRV
         gQLA==
X-Gm-Message-State: APt69E3/Uc9C9kIFRJugddZcE96TWX7Pciy1zT/9rePb+cPVx/Zpl5d5
        7ulsnnfkT+3TQrsOnm7szF0=
X-Google-Smtp-Source: ADUXVKIkGiL6R9M29OYOrA/4cl6qmGVHROL9nDDp/GA0DIwOX2O2ub/uJJTvFqiZL/G8liPB9cFxGg==
X-Received: by 2002:a17:902:4d:: with SMTP id 71-v6mr15207064pla.317.1529989655273;
        Mon, 25 Jun 2018 22:07:35 -0700 (PDT)
Received: from localhost ([175.223.48.122])
        by smtp.gmail.com with ESMTPSA id t23-v6sm1346420pfa.86.2018.06.25.22.07.33
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 25 Jun 2018 22:07:33 -0700 (PDT)
Date:   Tue, 26 Jun 2018 14:07:31 +0900
From:   Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
To:     Dmitry Vyukov <dvyukov@google.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        syzbot <syzbot+d29d18215e477cfbfbdd@syzkaller.appspotmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Samuel Ortiz <sameo@linux.intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        linux-wireless@vger.kernel.org, netdev <netdev@vger.kernel.org>
Subject: Re: INFO: rcu detected stall in vprintk_emit
Message-ID: <20180626050731.GB31439@jagdpanzerIV>
References: <000000000000720530056f7f9b63@google.com>
 <20180626014924.GB11229@jagdpanzerIV>
 <20180625225937.43aee76c@vmware.local.home>
 <CACT4Y+YWFhUk9cdpSR5+yR3+D6mNFUz2WwRcHULCNpj0-4qXyg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACT4Y+YWFhUk9cdpSR5+yR3+D6mNFUz2WwRcHULCNpj0-4qXyg@mail.gmail.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (06/26/18 07:03), Dmitry Vyukov wrote:
> > I don't think this is a printk() issue per se, so I think Option B is
> > the only option. You should not get stuck in an infinite loop if we run
> > short on memory. Perhaps we could have an Option C which would exit
> > this loop gracefully with some kind of error. But I haven't looked at
> > the surrounding code to be sure if that is possible.
> 
> I suspect this is not even OOM.

Could be. But at the same time it stalls RCU, so OOM at some point
becomes realistic.

	-ss
