Return-Path: <SRS0=+VtO=O2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E9DDC43387
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 15:41:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C35D8206A2
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 15:41:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dOAt/Oks"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387648AbeLQPlB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Dec 2018 10:41:01 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:46626 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727798AbeLQPlB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Dec 2018 10:41:01 -0500
Received: by mail-pg1-f196.google.com with SMTP id w7so6278445pgp.13
        for <linux-kernel@vger.kernel.org>; Mon, 17 Dec 2018 07:41:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=HtzbcogXkn682rdMDuWIbGFkOdQutURvhNqQPBQ8O5s=;
        b=dOAt/Oks50Yun0A1UFtcQn9emktvZee9bL/6Ml4rLqDRaiMBQZMvQjJWJx+FaECP4b
         x+058dZVHQo27Dxxbtrz0oSIGHQqqYU9dfM7JbGyf35NeArURiOxYIOIswrszb/5jEkG
         jd7JyBNzTOW5+v33vNqnHKhM5UC0mIUzyo8NUd1nN+uvTJ21BAT++tCAV/0ab8tKPwoy
         NcSgST1wGDZUf0ggICORx3bjq3UYSAPZSm4Wy2Pj/ELQzFITOrFlh7sr0sIj54DWoHGi
         YmghP3pzZ71rnJASSN9VWQJs6GDRPtWFeigi5rLKHeyRhP3gCs3PEiOF6YHOAzptb1fa
         +fsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=HtzbcogXkn682rdMDuWIbGFkOdQutURvhNqQPBQ8O5s=;
        b=gqb2BF85pUrEvJBZfYAbHiN/V4Izh//vslTh8SSmlZyMcaX74X9ozDBIHO6AyhdivD
         rPB9gXDuPLE2jvz6ZlNR1n3Zgp6lK5WIxGZrhbknDuYbzDUJ+4M/BAuoIOWtKFqXR0lZ
         x1jomdz553/vOelcJ0wj+y0OV/LOgt7zt+Vyjt3oYcgUN/4rnooH6XrrBQSWfB5Gwn4r
         9H+B36fEE/K1CJg9o1bIh0zQekuCxqG1iO0btl1qc91iEFS/4MM63YcLXYQTEiZlYMs9
         8RPh3RqyG/8LL0GLd476wJYNHkmNRq2drztdUfTkWLEzPv4ZF6DIpDGifOFBTCN3cDZ6
         ha1Q==
X-Gm-Message-State: AA+aEWY97k4zIcFPssGFVEn38HNmbqkCgb6u3r2BTJYO2ZZmW8BpnJGZ
        BXKe3u+acFfkhRPt61cAdnU=
X-Google-Smtp-Source: AFSGD/UbUTe/qfQTh6StD+gMzTIOHOSyjt8BKF1NrEueitYi/Ot4jpjXiFcXbNdUpQZBRBcPPy2Cjw==
X-Received: by 2002:a63:1258:: with SMTP id 24mr12430982pgs.114.1545061260119;
        Mon, 17 Dec 2018 07:41:00 -0800 (PST)
Received: from localhost ([121.137.63.184])
        by smtp.gmail.com with ESMTPSA id h8sm18528356pfo.162.2018.12.17.07.40.58
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 17 Dec 2018 07:40:59 -0800 (PST)
From:   Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
X-Google-Original-From: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Date:   Tue, 18 Dec 2018 00:40:56 +0900
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Dmitry Vyukov <dvyukov@google.com>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        syzkaller <syzkaller@googlegroups.com>
Subject: Re: [PATCH] printk: Add caller information to printk() output.
Message-ID: <20181217154056.GA515@tigerII.localdomain>
References: <20181203150603.cdqii263e4kmmibo@pathway.suse.cz>
 <b38c6957-c3c1-54fc-781e-06d7eed6a9b1@i-love.sakura.ne.jp>
 <20181204152724.ypk44mi4a56nrud4@pathway.suse.cz>
 <459018db-763b-9520-ead2-2c0d5975fbf3@i-love.sakura.ne.jp>
 <20181210130930.bas4fozjhe3dc5nu@pathway.suse.cz>
 <c5b5d660-d217-35f0-c4f1-7252367934d1@i-love.sakura.ne.jp>
 <e3f69846-ef08-c8f5-368f-4dada13c9970@i-love.sakura.ne.jp>
 <20181213121847.mwlr2vyv6qzclhk6@pathway.suse.cz>
 <20181213124255.GB3053@tigerII.localdomain>
 <20181217145452.3kev4rmo2l5lt2qy@pathway.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181217145452.3kev4rmo2l5lt2qy@pathway.suse.cz>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (12/17/18 15:54), Petr Mladek wrote:
> Now, I always felt that the "from" name was a bit strange but
> nothing better came to my mind until today.

Could be printk_caller, could be printk_origin. I don't have strong
preferences.

> I would like to rename "from" to "caller", see the patch below.
> If you agree, I could push it on top or I could even squash it
> into the original patch.

Can we please squash or, better yet, ask Tetsuo to resend a new, renamed
version? An immediate follow up patch that completely renames a just added
feature feels like as if we failed to communicate it the usual way.

	-ss
