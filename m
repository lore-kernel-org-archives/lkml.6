Return-Path: <SRS0=aqUf=NR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A670C32789
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 09:05:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 52E822081D
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 09:05:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RQ+8S5oK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 52E822081D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730333AbeKFSaD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Nov 2018 13:30:03 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:33727 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730210AbeKFSaC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Nov 2018 13:30:02 -0500
Received: by mail-pf1-f195.google.com with SMTP id v68-v6so2214354pfk.0
        for <linux-kernel@vger.kernel.org>; Tue, 06 Nov 2018 01:05:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=HPVPLytIc7to945vg9wQBtTc/vqQGuz3z4P/lZ3QIk4=;
        b=RQ+8S5oKlOBrCn69TQNJzNcLCTDBOXLXCIzszz82KmAK7p7524SyKnw6eRL4yzCwV2
         +bFfdSGNmYRCyKmqbipf6hTBxjQfcxnd8ncZjpgOl0xAOWhXf2zWOo7TjnpJg5Zfn8AS
         Tg/Hf/L7OBy9sWNZphWG7tfjCRF/E7Td3zXOhcU1K9zw+xhpF1Fi1z6vC1nzQbIY+G63
         8VC9H6qQVed+ccwyZxsycMKnE9Px5W38gK0hPoutW30dvz+9d1sIHKKm8+TznYCtl13Z
         evBldOKgmI5P3bWUAIifQrpT2Xy1UVR2pwB3tQJFCManT19zfa5mhjC+FBZOistbHFld
         PoAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=HPVPLytIc7to945vg9wQBtTc/vqQGuz3z4P/lZ3QIk4=;
        b=qk5tZbi2g5k99WrFx4/Q7X9BxNMav0tNs+WcT/UOstmBIEhu9aU65UfDaX5lZjqikK
         U7bOgaNWOK2DAw1/aTP5+rFjGM4x+ccZabcUEHibmaQHEYKIPlk1w7pTE2udlkoX8crn
         31yLmMDev/1R2NswoLEKh9JiE83qzP4dlAHNnU6y1yYBX/MGYeTxnzvGyTnZYqU6+cOe
         Wk5bVr0BZQo6kxOAvUM0o2/1KAN/gwhmEKZqbd1Zgcx00CHw8AJepyXwE0KFa1qoubo3
         Bc717e9DA15GfmRWPOVGD8lWF7Lr0aPurmgg3FK6mMHJ+cAZnhwE6cit0QOo1Y1Aq4WM
         tubQ==
X-Gm-Message-State: AGRZ1gKP7RexF78QypERxojiLEWRT+bbtOtJu58btcffqmg3jnfO0zDN
        DPcqtUG/SuFj3N2IuVg643A=
X-Google-Smtp-Source: AJdET5dJXkOvlCu2TUqRAD1zve9hx3tyga6pwDz+yVuz2fEX9mIYSxt+aeEmp+dvZwCD1C4F/s+Gog==
X-Received: by 2002:a65:560e:: with SMTP id l14mr19415040pgs.168.1541495149460;
        Tue, 06 Nov 2018 01:05:49 -0800 (PST)
Received: from localhost ([39.7.54.209])
        by smtp.gmail.com with ESMTPSA id c7-v6sm49319283pfh.25.2018.11.06.01.05.47
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 06 Nov 2018 01:05:48 -0800 (PST)
Date:   Tue, 6 Nov 2018 18:05:44 +0900
From:   Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
To:     Petr Mladek <pmladek@suse.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
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
        Will Deacon <will.deacon@arm.com>
Subject: Re: [PATCH 3/3] lockdep: Use line-buffered printk() for lockdep
 messages.
Message-ID: <20181106090544.GA516@jagdpanzerIV>
References: <1541165517-3557-1-git-send-email-penguin-kernel@I-love.SAKURA.ne.jp>
 <1541165517-3557-3-git-send-email-penguin-kernel@I-love.SAKURA.ne.jp>
 <20181102133629.GN3178@hirez.programming.kicks-ass.net>
 <20181106083856.lhmibz6vrgtkqsj7@pathway.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181106083856.lhmibz6vrgtkqsj7@pathway.suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (11/06/18 09:38), Petr Mladek wrote:
> 
> If you would want to avoid buffering, you could set the number
> of buffers to zero. Then it would always fallback to
> the direct printk().

This printk-fallback makes me wonder if 'cont' really can ever go away.
We would totally break cont printk-s that trapped into printk-fallback;
as opposed to current sometimes-cont-works-just-fine.

	-ss
