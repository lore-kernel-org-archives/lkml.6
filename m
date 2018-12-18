Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DC05C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 13:09:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF2A7217D7
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 13:09:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bxoH90DC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726686AbeLRNJu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 08:09:50 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:41128 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726403AbeLRNJt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 08:09:49 -0500
Received: by mail-pl1-f193.google.com with SMTP id u6so7801235plm.8
        for <linux-kernel@vger.kernel.org>; Tue, 18 Dec 2018 05:09:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=l1T2K68BW+YxQN+ol4hCsTnwd1ty+C890FuPQPHCMUQ=;
        b=bxoH90DCWuZlxhYjDnmIxQdKAa05nKtaHWo3/KbevjRi5Jq31l2BcrUiytNASoKq+e
         pH7+ZTf6PmlCYooXLT3jC1manjFoOgisccllS5PJT1CAFv8ac1vdtGbs2+QFg6L8hXww
         eojY3WcLO3MKz3y6z44io58DLG/AGtWx8ua9CTd4caBD58w9L0Cn5M8lXAIBqHzdrrSf
         eMkcERxXzBtkL5SQLHk7iJ8DWj5tWYsUM/IWSniLowVL6jMlokE30hEnQRckoLE1H9p2
         xtelleJcXUSFld2VByB1RsRVAEio8b8qnbot/1TLI7Iiu4y0x383SiCRN0D7fHxEYB0C
         T9GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=l1T2K68BW+YxQN+ol4hCsTnwd1ty+C890FuPQPHCMUQ=;
        b=r6kEMqkwGiUldhVB/JCL3Aho9Z5CjGjILSi5o9MhhCjbUpuRf3+iB16/SQn5a7pxRO
         aeGU5lp0qkSTtZwpR0L1T05veNzrTlx+aB5822coLoVsYGDPBeCgLumuviB9rMmKZ1NP
         LrxvrkJfe/vwcHAn+/zRErflKkUr9DNNuYvp6IU0tBDbbXZumJJ23+QQ8UULtnGIBvtf
         nC2eCYvkeLD8upfpbpPJx+G+fxYemTxMt2pI9PZJzCCJ1Nf6UXlUZDp1RPDL6S0hNJAC
         4L2lTBvtG4WxBlPluQ8KuhQ8MF15R3ncvMyhWh3qW+5JlGZLUtkyE2hQ2FT8XuIZpSOc
         gI1g==
X-Gm-Message-State: AA+aEWb0rm+d7II2sczBiyxrNbz7w3r43ny9BP8fZo7llVobMqBf16xv
        ePe7b0zwgLpU2z4d5N0hSDk=
X-Google-Smtp-Source: AFSGD/WEGVgINvMx/vez/paOrShbgm2yvwOwEsPMirjNK0gD+u8jhLat35yOtna5hgz+A26C4qeH1Q==
X-Received: by 2002:a17:902:64c1:: with SMTP id y1mr16277688pli.64.1545138589004;
        Tue, 18 Dec 2018 05:09:49 -0800 (PST)
Received: from localhost ([121.137.63.184])
        by smtp.gmail.com with ESMTPSA id p6sm20003204pfn.53.2018.12.18.05.09.47
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 18 Dec 2018 05:09:48 -0800 (PST)
From:   Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
X-Google-Original-From: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Date:   Tue, 18 Dec 2018 22:09:46 +0900
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Borislav Petkov <bp@alien8.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Subject: Re: [RFC][PATCH] printk: increase devkmsg write() ratelimit
Message-ID: <20181218130946.GB665@tigerII.localdomain>
References: <20181218091842.4996-1-sergey.senozhatsky@gmail.com>
 <20181218104812.GC15430@hirez.programming.kicks-ass.net>
 <20181218111701.GA32522@jagdpanzerIV>
 <20181218112934.GF15430@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181218112934.GF15430@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (12/18/18 12:29), Peter Zijlstra wrote:
> > We certainly can. As far as I understand, they log shutdown events
> > (including errors and warnings): what they kill, what they stop,
> > what they umount, etc. The more partitions, services are running
> > (I guess), the more things they need to umount, kill, stop; hence,
> > the more messages. I kinda can imagine what they will answer ;)
> > 
> > The below (and a bunch of other) messages are getting ratelimited.
> > I'm not sure what will happen should any of those steps fail and
> > print warning-s. My guess would be that we probably can ratelimit
> > those warnings:
> 
> Why are they writing it to /dev/kmsg though? Shouldn't they be writing
> this to syslog directly?

Can't really answer for systemd developers. To make those messages
appear on the serial/net console?

	-ss
