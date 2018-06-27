Return-Path: <SRS0=G4S6=JN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 655C6C43144
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 14:23:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2061420C0A
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 14:23:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E7v4vYXZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2061420C0A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934610AbeF0OXj (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Jun 2018 10:23:39 -0400
Received: from mail-pl0-f67.google.com ([209.85.160.67]:35682 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934187AbeF0OXb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jun 2018 10:23:31 -0400
Received: by mail-pl0-f67.google.com with SMTP id k1-v6so1121113plt.2;
        Wed, 27 Jun 2018 07:23:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=AlY3m0xCVe3AendWlJhX228CeN8xRB/X0Z/yE0S6oZU=;
        b=E7v4vYXZlQFkI7WKKTn1TnDiABVoG/k6DTWIuGzPgOj8Iz++TwIeqmYBUYgnDXTtNs
         1S1hJqdXLXr0qufZeLDVmROfnajoASEF/usP7lW0cn4ni1+bOYCVO8oM5zEnAEKYxty+
         /Yp6um+2mQx58h/xf9goOceG+J4OFBhjlO6eJJdTLFyR/ZwNWsGdrHHipuRwuSi78chy
         7LNlKt4116fg/ojOhSpJV4LG7f6R6Lb68hXnIZXel3Bv/5lJ8e8Ut6/9Mcle1CPi8EQ9
         OV3VWLNEgZhPdfMsWtkUhibQl8lLEQebqM6GGxWwL9Tfbv+glSYUEivPsoFpHeefVG3S
         iT4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=AlY3m0xCVe3AendWlJhX228CeN8xRB/X0Z/yE0S6oZU=;
        b=QDdwL0tHsHUhD6RJli+KCEdrdbGTWghr2xM2ka6ezwoGZXrhF+pMb7cyu4oEtmRGa8
         C2Ly3cwmWk4ivvZ5wZyt/kQcOQ4CGSmCR/bvnMTzzFCXFiEGsAMJXro+8r53WR1JzMj2
         Z+tm5W3vcN+Tzt0IX1RT29jWN8ltz01uUZ15rZ9gnW0OEbzFGcKHZvcbN5lQVQI+tGQz
         wB5ATU4W9pvFIiInBPjH7xXJoUeIZGRliRC7/NqypKtriabuk0RAs6Ci5r44ni+LlV+X
         G7xRT6RqEfSlqKNRIurElmijDua/0Zns8XXHjUZScNW1R4bxJj2ElKouGXZsW7ODTXiZ
         j1rg==
X-Gm-Message-State: APt69E18kdN2Nu5CzPljG+RRnPO3VzopXxrS4pc0wBTETJQcaTqOLzug
        HXVrEaTnWd1GIkiKFyb6mlU=
X-Google-Smtp-Source: ADUXVKJ8S7bCLrMM9IlIM0tS/CZg+6cgtFxswvJ/KRR5B/jIgmyiWBmgMh1BSX+bJyDuSB/L+wrkbA==
X-Received: by 2002:a17:902:1703:: with SMTP id i3-v6mr6188384pli.263.1530109410566;
        Wed, 27 Jun 2018 07:23:30 -0700 (PDT)
Received: from localhost ([121.137.63.184])
        by smtp.gmail.com with ESMTPSA id o12-v6sm8377704pgs.52.2018.06.27.07.23.29
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 27 Jun 2018 07:23:29 -0700 (PDT)
Date:   Wed, 27 Jun 2018 23:23:27 +0900
From:   Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
To:     Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Cc:     Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2 0/3] printk: Deadlock in NMI regression
Message-ID: <20180627142327.GC477@tigerII.localdomain>
References: <20180627140817.27764-1-pmladek@suse.com>
 <20180627141612.GA477@tigerII.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180627141612.GA477@tigerII.localdomain>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (06/27/18 23:16), Sergey Senozhatsky wrote:
> > Petr Mladek (3):
> >   printk: Split the code for storing a message into the log buffer
> >   printk: Create helper function to queue deferred console handling
> >   printk/nmi: Prevent deadlock when accessing the main log buffer in NMI
> 
> Patch 3/3 is not in my mailbox, somehow [I checked the spam folder].
> I'm not Cc-ed or the message got lost somewhere before it reached my
> gmail?

UPD: 3/3 just arrived, with a 12 minutes delay.

	-ss
