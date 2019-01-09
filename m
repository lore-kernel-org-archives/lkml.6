Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2817C43612
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 07:56:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9044B20821
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 07:56:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HU5Asoec"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729281AbfAIH4o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 02:56:44 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:37784 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725835AbfAIH4o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 02:56:44 -0500
Received: by mail-pf1-f194.google.com with SMTP id y126so3286617pfb.4;
        Tue, 08 Jan 2019 23:56:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=NuotCnlYVlXItjpt3k9jNig+e1RnOIU9JZ22ELQvs7g=;
        b=HU5AsoecWDqCJIQUJMvyCp5oGfb+CMvtV4avtjJySol/9PVX+kwc2qE0PG/MjB4xPV
         qnTZVcdTvmNwvLF+qaVaYmFzsSDbfH6nAVH0ouC5S4Tr2q8tGp7OC8f5RR9ZPmlJDQ4O
         L+Xi+GPRxXWH2un19NPcnlNkKQJ1o9i3I6WX5zs65X/V2lo+lIa7uGHJldqWbd+Ng4Ms
         Aai8DMvZpMADIsRQYwHdGUpZuhGYUuFEylyyEXvm9IC5q4HkANR8xp66Sff7jgaSRkjX
         ZxvubGSxNUMpYBl75eNTmBHf2LG5kOn0IB2CzJaQfQOUlgghOlbwgVFk8zuVNhUMOIGu
         eEcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=NuotCnlYVlXItjpt3k9jNig+e1RnOIU9JZ22ELQvs7g=;
        b=fmtSkqCWNIag4IeQfnMPkEPElrAhMEHoqsXRAGt0dBoIfbInO+qsfCSCzT7BCtxciN
         IdacDPUfwV2qO5aUHZ0qc3vhEesPYE2TbOLkaqk5y59RrK+x6ge8VIthcdEzJAHrF7JG
         ctNUoPn0uYasFccmlFELcEro73QGP3HcPw/chtKiDe7InGVX0LTsnSbAwbiPxcqnh7BP
         xjI/HHPJw+nBJFMtvuE8bbikDbS7ktB7jYkZRZquVnu4CgJmYNekDkKDKE945zCYHCvn
         8Suai4c8x0wvsDny0QniacAAKN0W45u71ucN9UmlARUtUXIlF3x+dCq2xtZM/1vInZmQ
         P1Yw==
X-Gm-Message-State: AJcUukc8MRy8epbNrBNpo6vu3HR2yuFBABAis8yJNrWuIgE15ugh82/5
        UCB+llOyOWJ7dZY6jxrf65+zZzTc
X-Google-Smtp-Source: ALg8bN6kzvHcQrKPpFUZWOjhtDWmLFRZKT48qj/vUfDfSGyZKHLJnHJsOkV8jMHa/4MgeNWNLHHK5A==
X-Received: by 2002:a63:cf48:: with SMTP id b8mr4548762pgj.17.1547020603420;
        Tue, 08 Jan 2019 23:56:43 -0800 (PST)
Received: from localhost ([175.223.22.241])
        by smtp.gmail.com with ESMTPSA id w128sm102632378pfw.79.2019.01.08.23.56.41
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 08 Jan 2019 23:56:42 -0800 (PST)
Date:   Wed, 9 Jan 2019 16:56:39 +0900
From:   Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
To:     Helge Deller <deller@gmx.de>
Cc:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        James Bottomley <jejb@linux.ibm.com>,
        "James E . J . Bottomley" <jejb@parisc-linux.org>,
        linux-parisc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Subject: Re: [PATCH] parisc: replace oops_in_progress manipulation with
 bust_spinlocks()
Message-ID: <20190109075639.GA16555@jagdpanzerIV>
References: <20190107095612.7086-1-sergey.senozhatsky@gmail.com>
 <d09f4a9a-f966-80d7-01e1-5d92401b5d7e@gmx.de>
 <20190109053941.GA28834@jagdpanzerIV>
 <3c7c981b-d99f-5230-c3af-2df7d59fafff@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3c7c981b-d99f-5230-c3af-2df7d59fafff@gmx.de>
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (01/09/19 08:16), Helge Deller wrote:
> I prefer that change.
> In my role as admin of the parisc-linux.org domain I plan to retire
> all @parisc-linux.org email addresses soon anyway.

I see. Well, I can send a formal patch, but I think James
would know better which one of his email addresses he'd
prefer to use; so it seems that a patch from James would
be more appropriate.

	-ss
