Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBBB0C3279B
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 03:11:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D8C4208EC
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 03:11:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fuGiWIfw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8D8C4208EC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732451AbeGKDOA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Jul 2018 23:14:00 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:41061 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732407AbeGKDN7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jul 2018 23:13:59 -0400
Received: by mail-pf0-f196.google.com with SMTP id c21-v6so12804489pfn.8
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jul 2018 20:11:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=QHhCmlPxoMopSz0rwk31UVBkUXdunlKk54jZZc9UvY4=;
        b=fuGiWIfwPb126Jd66hR5e0wBYxjECyy8cFR89H/ixoekXc4Nk/LPmZdxL5LWvpwBH7
         vYRs/PPW3hCUQJTzurN9KDAqkVBccTiY/jd2aZpV7ZKhR3TjA8rLl28WE6RT+7FMBfJp
         sxg2poBQCza2TXn/cZXBFLFsCVKPmqmnuHcW61ke+GYR5wO+ZZ2RfXePj47m2p4I5mFb
         6171ZzvfjcHa4lbPl1gPCtVJZqEnS0kCM8+OVQ9Wos9e4CJDD3glYKrrHdaYRvH4SeXr
         Yr/9STbn1INptpoi9L0Sc0a9hgGIm4y9IM3hru/0aHp/wBH/SqxjGc6dPlZCLORVt42g
         Ds4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:in-reply-to
         :message-id:references:user-agent:mime-version;
        bh=QHhCmlPxoMopSz0rwk31UVBkUXdunlKk54jZZc9UvY4=;
        b=CZJ6UHyej9REnL5PghyubRfxO1NijgscUip0ykjLinHANCNC3ciWvwjy31u1uL5Lnx
         ixlI8Mchud6YDWPPoq2IJnFLpG5L/KF35gAIH2khkmdg7eQ3yEuTnPgrmfneLtORcxeh
         FU6Xr9uQk4P6GlNPuG/7oCDcGfeIYmrOJpIbLemxkkwsdcdlPUKhl5GIbXJFi9FemBFz
         iVyR/UHx/iMEW7lITML4ayTslN4a27zudogmBmd/grwsithQmXCRJc6/dgP2i6y4AoyD
         WIW9s9LKZQKyrBeIJKnD9IDG61jhsUVA+pZ3Bb+/S0fJUtxbYpwLqeyUqfE50XyfHa2I
         3r2w==
X-Gm-Message-State: APt69E1EqEm+YzVV0k8OLncD4+BdZL8FgcjVcm9xO+7UEoEBXfJE65hO
        RerfGqQQMXdQ9JNE7rGLoc4=
X-Google-Smtp-Source: AAOMgpe3lqyZIY1+a/AWndHzan6PKgxj8psf//lcpeYw6bNjWiO911+dEP9qXqtmMB1PR/fzcvuW3A==
X-Received: by 2002:a63:cf10:: with SMTP id j16-v6mr9885720pgg.238.1531278711658;
        Tue, 10 Jul 2018 20:11:51 -0700 (PDT)
Received: from i7.lan (c-73-11-52-149.hsd1.or.comcast.net. [73.11.52.149])
        by smtp.gmail.com with ESMTPSA id b1-v6sm34153163pff.141.2018.07.10.20.11.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 10 Jul 2018 20:11:51 -0700 (PDT)
Date:   Tue, 10 Jul 2018 20:11:49 -0700 (PDT)
From:   Linus Torvalds <torvalds@linux-foundation.org>
X-X-Sender: torvalds@i7.lan
To:     "Eric W. Biederman" <ebiederm@xmission.com>
cc:     Oleg Nesterov <oleg@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Wen Yang <wen.yang99@zte.com.cn>,
        majiang <ma.jiang@zte.com.cn>
Subject: Re: [RFC][PATCH 10/11] signal: Push pid type from signal senders
 down into __send_signal
In-Reply-To: <20180711024459.10654-10-ebiederm@xmission.com>
Message-ID: <alpine.LFD.2.21.999.1807102011380.30072@i7.lan>
References: <877em2jxyr.fsf_-_@xmission.com> <20180711024459.10654-10-ebiederm@xmission.com>
User-Agent: Alpine 2.21.999 (LFD 260 2018-02-26)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 10 Jul 2018, Eric W. Biederman wrote:
>
> Use the information we already have to document which signals are sent
> to a group of processes and which signals are sent to a single process
> or a single thread.

Ahh.

This is much nicer than what I was playing with yesterday, trying to 
separate out the "bool group" logic in the signal sending code.

I didn't even think to use the pidtype. 

In my defense, I would never have done this whole pidtype cleanup that 
preceded this patch just to fix that odd fork() thing.

As I started reading this patch series, I went from "this seems a bit 
pointless" to "Ahhh...." and as I did that I started liking the series a 
lot more.

My initial reaction was "this seems over-engineered" when I just looked at 
the subject lines in my mailbox.

But as I progressed through the series, I really appreciated it. And this 
"10/11" was when I went "ok, I don't even need to see patch 11, I know 
what he's doing.

Anyway, take that as a long-winded ack for the approach and the 
appreciation of the series.

Of course, that's just reading through the patches, no actual _testing_ of 
them. But it looks good to me.

Thanks,

                Linus
