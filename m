Return-Path: <SRS0=SFDS=MQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FSL_HELO_FAKE,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 670BBC64EBC
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 08:56:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 26B80213A2
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 08:56:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gczGhgdH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 26B80213A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727881AbeJDPsZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Oct 2018 11:48:25 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:45154 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727353AbeJDPsZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Oct 2018 11:48:25 -0400
Received: by mail-wr1-f67.google.com with SMTP id q5-v6so8967679wrw.12
        for <linux-kernel@vger.kernel.org>; Thu, 04 Oct 2018 01:56:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=/tOZC2aku05b84/8yimuEWwlNPpyQDx6C8b2HzELzrk=;
        b=gczGhgdHKNCCjWcOm9K5eNQ3LXvxxte1LOqHtf4CGkzMlY34gSGsRKifJxOi9EMIWJ
         UjYGarGuisfEPEvQ+f7tMiHLXhkiAKIdfuWtCdMsLt2Sf73sf6AO3CLS63UWfvdT/jaT
         PYsbZQRNJ6epD4pTRCYLWqOvF/k74Vm/Q0Z5wVBnK/7vtuV0J+FX7jD0LPs8tngjyKgO
         07X1oU/0+xsjzCmKjVpZ3EmWb5aPBlH8B/jqnDLPpfOnwQygjLfPJKgajlfAsfh7pvWf
         CvnP2REw7oJoOoit/wHtSWdJLsVjRrLWsllEvDBPGrvFv4wnkaNKHSWQngfk5urbL6Cv
         LhLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=/tOZC2aku05b84/8yimuEWwlNPpyQDx6C8b2HzELzrk=;
        b=AWUVjuLQqsqspIHgzKVDAqsj1iQQRIrRBWLJ1HBkfJ0GqaOaa4ZrZSAgQfWjXKts+H
         zXoQCjtDNDcetbrSXZm9o/Lvf4dNqZKVSRJAvnK0MfWLRktzLIr9Hh5gDk0mWIFUizCv
         SDD4xsxJySolr//qqKc7wPT45Y2rJp6MNGZjKjF8mAoanyF6tDcVc7VRUYxfJ9x4aEvZ
         dY2lp+RhJ2CdWMPt30dhnVzU2EMRCRS2HR7sFfdHcji+k9HtExgKbeJOvUf/FuRYLw+O
         CATdfjJoSj1tfmO4tXYUGactmp+ozOe1AzvveNeblKwpRUbwxnz1KC7VyKZjXGnPye3x
         /DNQ==
X-Gm-Message-State: ABuFfoj6U4djCSn0I6w0S02+VO6c6er0AWPpfUCs7Lg8mWJ5srhBz1OU
        R25xNTJAvYMDA+/LaPqrPFs=
X-Google-Smtp-Source: ACcGV60TxKQ2VMGJFRfVK/3NbAhOjbvYhTYdn2ckoR8JQSLGuLA5kLXwQA8KO8WvgP1ejV1MD7LI+A==
X-Received: by 2002:adf:e152:: with SMTP id f18-v6mr3796803wri.42.1538643369200;
        Thu, 04 Oct 2018 01:56:09 -0700 (PDT)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id r131-v6sm3833322wmb.32.2018.10.04.01.56.08
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 04 Oct 2018 01:56:08 -0700 (PDT)
Date:   Thu, 4 Oct 2018 10:56:06 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     hpa@zytor.com
Cc:     Nadav Amit <namit@vmware.com>, Ingo Molnar <mingo@redhat.com>,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Jan Beulich <JBeulich@suse.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Andy Lutomirski <luto@kernel.org>
Subject: Re: [PATCH v9 04/10] x86: refcount: prevent gcc distortions
Message-ID: <20181004085606.GA21151@gmail.com>
References: <20181003213100.189959-1-namit@vmware.com>
 <20181003213100.189959-5-namit@vmware.com>
 <20181004075755.GA3353@gmail.com>
 <20181004083333.GA9802@gmail.com>
 <10D29A50-C352-4407-A824-0C3C06CD8592@zytor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <10D29A50-C352-4407-A824-0C3C06CD8592@zytor.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* hpa@zytor.com <hpa@zytor.com> wrote:

> It's not just for working around a stupid GCC bug, but it also has a huge potential for 
> cleaning up the inline asm in general.

Sorry but that's just plain false. For example this patch:

   x86: cpufeature: use macros instead of inline assembly

... adds an extra macro indirection layer called STATIC_CPU_HAS, just to macrofy a single asm() 
statement that was perfectly readable and on-topic already...

There are some other cases where macrofying is also a cleanup due to sharing and naming a 
common pattern of code, but this is by no means an absolute quality of this approach.

Thanks,

	Ingo
