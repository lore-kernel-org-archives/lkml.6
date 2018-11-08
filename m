Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 591DDECDE4B
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 14:21:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F1B6320825
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 14:21:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mx4gtDQp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F1B6320825
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727211AbeKHX51 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Nov 2018 18:57:27 -0500
Received: from mail-pl1-f171.google.com ([209.85.214.171]:44427 "EHLO
        mail-pl1-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726359AbeKHX51 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Nov 2018 18:57:27 -0500
Received: by mail-pl1-f171.google.com with SMTP id s5-v6so9590470plq.11
        for <linux-kernel@vger.kernel.org>; Thu, 08 Nov 2018 06:21:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=/yCnlpMWygRZYOrNWS535j+YfCigOZuufziajif84jQ=;
        b=mx4gtDQpDsn8O/4M6Welllu/42WDGJhEYABbxu3CS+vEJSztA8rNzxDVmouYhh92TD
         aspclMzkHJByvA6JDP8WbNhYZHJXeypTbK6QNRRZNHTGYb26Lt8VPzLPSIe+6ofnxi0e
         NlISJtIPl00DwkoxAF0jFYFAPYzitCbVQ+8OOZ/gSqZGcHVJeWhGSkEOcQQmrFW8JnpL
         DXwzcBPk+fUZnfK/ys2whgtudsJZlk2VC5wD7u8HaGgLG1wG+AevGS5jD5Ht9eeRrHEs
         Ys0ZT1DW0v404U58aYWRRetZNwjFyTRoaOUrWG1p3z4srFMiuzUlkcXuy/6fGayOQp6H
         I4lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=/yCnlpMWygRZYOrNWS535j+YfCigOZuufziajif84jQ=;
        b=XxNVa8EBFbJQbcV1urZ6bU1FE7t7se5V4LxzGT/vnX0bJoLQo/ls/k+X1aEDibDhsN
         3xKpzeCnSMQQeN7nKn4nVLTuhOmQPKjBIC6+PIFQe40kuR8dPq0VWhuzX9s89jFw2Duh
         v5MDCzOo+r90HxJdJgsI/zPBK8e8PkbR0bJQAKshfSJxtbqT2z0u6mrK1AIeC2o+tQJA
         Y4zQvLiJ3UaNdZcgb6nko1hMj1+q0nLmjdvpaKZ9l0RKUoCGpZ5eYKzqMDFnPF3v28oM
         HIx/XbDsjM3cJpnCYl6bMEt3AQxnLGccWUinxBjEF6qeIYCjzzGPUs7/SarJ/+TxVrDi
         nzKQ==
X-Gm-Message-State: AGRZ1gLh8gvHNnC6q3KMNTh7Gm96KuAAM4OAjN0bByyLebgBci4biecT
        +AKTewZe6mVOwCp/SbShzik=
X-Google-Smtp-Source: AJdET5dUFoXQUJghWd8o0P0X199TCBrLqQNDYju1Tb/Iqf5XWv8AwRSCkBClf3xMfeA5CZzMXFi0Fg==
X-Received: by 2002:a17:902:6bc9:: with SMTP id m9-v6mr4853499plt.106.1541686903656;
        Thu, 08 Nov 2018 06:21:43 -0800 (PST)
Received: from localhost ([121.137.63.184])
        by smtp.gmail.com with ESMTPSA id o81-v6sm6693605pfa.170.2018.11.08.06.21.42
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 08 Nov 2018 06:21:42 -0800 (PST)
From:   Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
X-Google-Original-From: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Date:   Thu, 8 Nov 2018 23:21:25 +0900
To:     Petr Mladek <pmladek@suse.com>
Cc:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Dmitriy Vyukov <dvyukov@google.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Alexander Potapenko <glider@google.com>,
        Fengguang Wu <fengguang.wu@intel.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will.deacon@arm.com>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Subject: Re: [PATCH 3/3] lockdep: Use line-buffered printk() for lockdep
 messages.
Message-ID: <20181108142125.GA445@tigerII.localdomain>
References: <1541165517-3557-1-git-send-email-penguin-kernel@I-love.SAKURA.ne.jp>
 <1541165517-3557-3-git-send-email-penguin-kernel@I-love.SAKURA.ne.jp>
 <20181107151900.gxmdvx42qeanpoah@pathway.suse.cz>
 <20181108044510.GC2343@jagdpanzerIV>
 <20181108115310.rf7htdyyocaowbdk@pathway.suse.cz>
 <20181108124413.GB30440@jagdpanzerIV>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181108124413.GB30440@jagdpanzerIV>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (11/08/18 21:44), Sergey Senozhatsky wrote:
> 
> If lockdep and OOM people will ACK buffered printk transition in
> its current form, then we can go ahead.

That printk_safe approach in lockdep, BTW, does not change (convert)
any printk-s within lockdep, thus Peter's earlycon should not be
affected. So Peter will have earlycon working, syzbot folks will have
buffered lockdep print outs.

	-ss
