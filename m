Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3478C43142
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 07:00:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A9C422416A
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 07:00:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BYpyV2XC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A9C422416A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752582AbeFZHAk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 03:00:40 -0400
Received: from mail-pl0-f67.google.com ([209.85.160.67]:41369 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751025AbeFZHAi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 03:00:38 -0400
Received: by mail-pl0-f67.google.com with SMTP id w8-v6so8097803ply.8;
        Tue, 26 Jun 2018 00:00:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=CKfD6RI6MG4yqNi9D5mgM+xCuUniZDKXZD34hzHcvdU=;
        b=BYpyV2XC2afQkG6VLBIAl8qZYYLis6FuEVxGlbZwurHxXfXvFdgmogzwkiEStSYNMw
         1PEaufRSHot1GUXw7SjYLS0hSJhuQMZkNWY9xKGPcGthertumEDg4Mv3utVKVfKdZA8l
         qb2EDpPIAvmKvnabhiUzEMj+x0WP1b85ND+ad/96oGhA3zZoTUbvp5+k1huCC8S2AZEy
         q212rUn2QhSnAnxr+Ynt0+V2XN6otfd95qMW+tD38GbbTx7DB6WNjB/9oCPSdar2hBFX
         78jWyZmUTnAam9IkP47cFG99AHhHggyiQWm/XnXCCgnJBqEqtIEUKZodUznKOz7v5WfB
         e89Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=CKfD6RI6MG4yqNi9D5mgM+xCuUniZDKXZD34hzHcvdU=;
        b=ZLPztTFjMo8s2PLcgg3kUd1I1ibzOhzOV1KE3MmEeGhkCVnu1GTJsxrvDe4cGAy7V9
         cMi7EtXpGpMDYOhYsll0XCg/lO+xmbJFrrq4BZbppH5pxJ+J9oxfj7NQSEjUU3BXnlSk
         Mih51RrkSSzwMviwWj+cmP5lkbuKQ8G8BP51lYuoXKHUhha8TDXaJH0BdpsxSy9P0bfF
         OVCmDNuRdrPVGQNv39sGuXX5Ge6512wJqWDtpU9pTpt2vOTtf/Ew7lTm84vUmvrQvN4B
         2QD6RmDm6KiLbJeRO5kASoH0D9jpT9eD0za1SpjXp+P4jNSGy5G8/VvWth8LgX/8vN46
         92rg==
X-Gm-Message-State: APt69E0PQ9Kgp8Pib8iupK9D7GopUZ7sHkri7yZ/buDhoZE7n2YBWLcQ
        nNJFF+0gBJGeWG0p2z7t5VI=
X-Google-Smtp-Source: ADUXVKI2pwZHfGWfEaA7B5qaOFCcGzt45zDKFCzdf9Le+T9sb+OGUFFJDTUY2F9aZ2zJmgsUIyCehg==
X-Received: by 2002:a17:902:758e:: with SMTP id j14-v6mr346760pll.160.1529996438108;
        Tue, 26 Jun 2018 00:00:38 -0700 (PDT)
Received: from localhost ([175.223.48.122])
        by smtp.gmail.com with ESMTPSA id q82-v6sm1616402pfg.170.2018.06.26.00.00.35
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 26 Jun 2018 00:00:36 -0700 (PDT)
Date:   Tue, 26 Jun 2018 16:00:33 +0900
From:   Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
To:     Eric Dumazet <eric.dumazet@gmail.com>
Cc:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Samuel Ortiz <sameo@linux.intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        Steven Rostedt <rostedt@goodmis.org>,
        Petr Mladek <pmladek@suse.com>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        linux-wireless@vger.kernel.org, netdev <netdev@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        syzbot <syzbot+d29d18215e477cfbfbdd@syzkaller.appspotmail.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Subject: Re: [PATCH] NFC: llcp: fix nfc_llcp_send_ui_frame() lockup
Message-ID: <20180626070033.GA25715@jagdpanzerIV>
References: <20180626044119.30118-1-sergey.senozhatsky@gmail.com>
 <CACT4Y+ZvLqzEwXgdB25MrmAS_j2_HsS8NFaJaMojzMV3prXypg@mail.gmail.com>
 <20180626051221.GC31439@jagdpanzerIV>
 <8c410102-43ab-dfdb-0d71-2ee5951e1af8@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8c410102-43ab-dfdb-0d71-2ee5951e1af8@gmail.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (06/25/18 23:44), Eric Dumazet wrote:
> > The loop is still infinite, correct, but we have a preemption point now.
> > Sure, net people can come with a much better solution, I'll be happy to
> > scratch my patch.
> > 
> 
> This can not be the right solution, think about current thread being real time,
> cond_resched() might be a nop.
> NFC maintainers should really take a look at this.

I'm all for it.

	-ss
