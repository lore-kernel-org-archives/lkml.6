Return-Path: <SRS0=G4S6=JN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A767AC43144
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 14:16:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 610142614B
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 14:16:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gBxxho7j"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 610142614B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965491AbeF0OQT (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Jun 2018 10:16:19 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:39398 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965341AbeF0OQQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jun 2018 10:16:16 -0400
Received: by mail-pf0-f196.google.com with SMTP id s21-v6so1034083pfm.6;
        Wed, 27 Jun 2018 07:16:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=z/0XOVjn51tXsOtfD6L3p588LcTCp/bhtYqW0Nobf6o=;
        b=gBxxho7j9mOIs/+EmdMZDHs7t7N+X9BERTKs1R6LDY7vw1XiKS0DkdcKexvCZ447EX
         xpMzVEepVLABzV7aZJsw/OkM/GG4RPt7CmH4il/DoRbRWoqqex5B03C57iNAbCau+aoa
         hu2zWHFRy3clgcV8472iq+J9RY3Kk+MYobxWI0LaHtNfq/eXHDbGuZf1ZlRtnnpYX+38
         //CukbeuubvCKdmX62jOwo8i3pxzvLaap2YkrMHqsLZ+RB0Z7+k8Crj/ArYYXf5FULPd
         3likNgA6e3o8EA6JPp7IlQUZFUIQ9NXYR4gCUQhgqDqwFs2JNbIECkjCqMhUqwKdYEeU
         tHyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=z/0XOVjn51tXsOtfD6L3p588LcTCp/bhtYqW0Nobf6o=;
        b=SSbuhpQ+AIBRPEiBSXP3h8ZVLhSpk50/YA5sVvLmzUqNxzWQvqsfl2azvfEa4NCVc9
         5ZpodjzBT2rujz58ZIkshKXJGs3DDGiiqOogVNpjSAH9xHDYdBy+6zj5eMfhaWb0Vr4K
         4mrdMBaJdYHGRahDU1xG8j1TslE27B1R8rZqIKIoejdmpk2wzERygEw7bcFg/Cqq5Zh6
         JmcNGjBIPwTI7qf1kklgCIlT3Se1a/IK3h5kIKS59ESnCbdSYYVolKCZtlvAuAUYmc2O
         XQAvmSL/MQ9STna6ylzGl6u9YLivnzVg+7pdvCUJSZEKxNNDgNqkANBs8wuq2YUun+j6
         zvmw==
X-Gm-Message-State: APt69E3Eta264hJ6cVtWy5Sp6Ah0zMfDIJzzhRAV9q4Ue3OnbzvUAPRM
        Mqp+eL4TCVqNC8hzBFVRLM0=
X-Google-Smtp-Source: AAOMgpcao2CbDxhZAjMVYrFRVzYyheNUITT3ty5QDRsBS2rRXVexXYNa7emu7csWxwIGt1W5YE1g+Q==
X-Received: by 2002:a62:4f5b:: with SMTP id d88-v6mr1385833pfb.225.1530108976001;
        Wed, 27 Jun 2018 07:16:16 -0700 (PDT)
Received: from localhost ([121.137.63.184])
        by smtp.gmail.com with ESMTPSA id a23-v6sm6525693pfn.113.2018.06.27.07.16.14
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 27 Jun 2018 07:16:15 -0700 (PDT)
Date:   Wed, 27 Jun 2018 23:16:12 +0900
From:   Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2 0/3] printk: Deadlock in NMI regression
Message-ID: <20180627141612.GA477@tigerII.localdomain>
References: <20180627140817.27764-1-pmladek@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180627140817.27764-1-pmladek@suse.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (06/27/18 16:08), Petr Mladek wrote:
> The commit 719f6a7040f1bdaf96 ("printk: Use the main logbuf in NMI
> when logbuf_lock is available") brought back the possible deadlocks
> in printk() and NMI.
> 
> This is rework of the proposed fix, see
> https://lkml.kernel.org/r/20180606111557.xzs6l3lkvg7lq3ts@pathway.suse.cz
> 
> I realized that we could rather easily move the check to vprintk_func()
> and still avoid any race. I believe that this is a win-win solution.
> 
> 
> Changes against v1:
> 
>   + Move the check from vprintk_emit() to vprintk_func()
>   + More straightforward commit message
>   + Fix build with CONFIG_PRINTK_NMI disabled

Did I miss out V1?

> Petr Mladek (3):
>   printk: Split the code for storing a message into the log buffer
>   printk: Create helper function to queue deferred console handling
>   printk/nmi: Prevent deadlock when accessing the main log buffer in NMI

Patch 3/3 is not in my mailbox, somehow [I checked the spam folder].
I'm not Cc-ed or the message got lost somewhere before it reached my
gmail?

	-ss
