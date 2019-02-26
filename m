Return-Path: <SRS0=tlbf=RB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EBBCC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 17:30:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1FEA8217F9
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 17:30:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551202253;
	bh=Ra4DrzAQzwm3eeWuJXccJ6oHhZfVwXJDdXkaM9C6ABQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=bTaPeMU4H0JvH91NRzVa1EBbYWc1EmQUP8O/t6KtakISlpeVGx32Q5Jb+wyJA2bhT
	 2KVUgfQVR8m+AcVJZw80wIBEvlzDnlMpdIeRqWIFf5oAhUBZY+sHWGN5x6QBLy99ni
	 nr7uoSWdIL4M3lPL96ANlU9obZfiHkd+mHwGf/0U=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728382AbfBZRav (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Feb 2019 12:30:51 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:35738 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727054AbfBZRav (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Feb 2019 12:30:51 -0500
Received: by mail-lf1-f66.google.com with SMTP id m73so4687770lfa.2
        for <linux-kernel@vger.kernel.org>; Tue, 26 Feb 2019 09:30:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Z8WiV6+wyL1bQ2au41BBimUZ0aOcD2zonC09vIf+HiE=;
        b=PiRd5v+wj162oZXDvKxMIi4z5v327DWgTjRFmkog3nxt7k2+XxuFSiJ1iqJb5YYHv7
         LX1PylrdLrHxalC/cl7HTdHJkj8BWjNE6nGeUFQjtZiZ/D8s5lCIFB2q04SyBSlCRU1C
         ndqzNsOzsC7jEKMPnTlLkR2tHqr/xcrjzJxIY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Z8WiV6+wyL1bQ2au41BBimUZ0aOcD2zonC09vIf+HiE=;
        b=uexENrif39npso6Cu202tw7lJSMR2NVA/DuE5mt7O9kFIvk+MCfYFlCPFahEHKChm9
         ih6Erg8Lh3sTlFy0S23Lwz/6Vl5HdTCDRF1A7GWaL5HXW4njb+l7eZXXBCsw1Zj2NPn2
         GuabHEsPIS+Z03TOwxG0SPprSWbYXZTZBa7SlKSfOTxHpWdjz9V54XKU1gQY1u1P/egB
         VDyrOfy2XDISKT4RU8q1/1YZeDwxmOzK7DU6HexGdkqALrpAu7rcPNgVEJL0kcBHuE21
         cg8ErCaiJiVOhqcyK20QCAfGOOlc80jQs8C4it9qZdhmg/Z1RfFS3gowfYcHkAIYc3pX
         6fow==
X-Gm-Message-State: AHQUAubrvCTjR8bX80KBFWC2szSL+saXG2XOH2Y6nHmfFRH8idqgzq86
        7rmd0nTjh9UWVUO3uMlWH4RKqnzX+2w=
X-Google-Smtp-Source: AHgI3IarTXBFAlXc0v/Q4SV2NlnpkShm9WzWZSCRRLCwjeotYp2037FF6BsZwTbf9vqD7LtHoygUBA==
X-Received: by 2002:a19:48c3:: with SMTP id v186mr7469727lfa.40.1551202248505;
        Tue, 26 Feb 2019 09:30:48 -0800 (PST)
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com. [209.85.167.51])
        by smtp.gmail.com with ESMTPSA id e29sm1280740lfj.59.2019.02.26.09.30.47
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 26 Feb 2019 09:30:47 -0800 (PST)
Received: by mail-lf1-f51.google.com with SMTP id h10so10216912lfc.12
        for <linux-kernel@vger.kernel.org>; Tue, 26 Feb 2019 09:30:47 -0800 (PST)
X-Received: by 2002:a19:4ac4:: with SMTP id x187mr10861709lfa.166.1551202246613;
 Tue, 26 Feb 2019 09:30:46 -0800 (PST)
MIME-Version: 1.0
References: <20181114092242.GD18977@shao2-debian> <20181114141713.GA25731@bombadil.infradead.org>
 <875zt7t14h.fsf@yhuang-dev.intel.com>
In-Reply-To: <875zt7t14h.fsf@yhuang-dev.intel.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 26 Feb 2019 09:30:30 -0800
X-Gmail-Original-Message-ID: <CAHk-=whn+F+vFgCR0a04atTQuBmXhq0oU1Y1f0YqMiUFHj28JQ@mail.gmail.com>
Message-ID: <CAHk-=whn+F+vFgCR0a04atTQuBmXhq0oU1Y1f0YqMiUFHj28JQ@mail.gmail.com>
Subject: Re: [LKP] [page cache] eb797a8ee0: vm-scalability.throughput -16.5% regression
To:     "Huang, Ying" <ying.huang@intel.com>
Cc:     Matthew Wilcox <willy@infradead.org>,
        "Chen, Rong A" <rong.a.chen@intel.com>, "lkp@01.org" <lkp@01.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Waiman Long <longman@redhat.com>,
        Tim C Chen <tim.c.chen@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 26, 2019 at 12:17 AM Huang, Ying <ying.huang@intel.com> wrote:
>
> As for fixing.  Should we care about the cache line alignment of struct
> inode?  Or its size is considered more important because there may be a
> huge number of struct inode in the system?

Thanks for the great analysis.

I suspect we _would_ like to make sure inodes are as small as
possible, since they are everywhere. Also, they are usually embedded
in other structures (ie "struct inode" is embedded into "struct
ext4_inode_info"), and unless we force alignment (and thus possibly
lots of padding), the actual alignment of 'struct inode' will vary
depending on filesystem.

So I would suggest we *not* do cacheline alignment, because it will
result in random padding.

But it sounds like maybe the solution is to make sure that the
different fields of the inode can and should be packed differently?

So one thing to look at is to see what fields in 'struct inode' might
be best moved together, to minimize cache accesses.

And in particular, if this is *only* an issue of "struct
rw_semaphore", maybe we should look at the layout of *that*. In
particular, I'm getting the feeling that we should put the "owner"
field right next to the "count" field, because the normal
non-contended path only touches those two fields.

Right now those two fields are pretty far from each other in 'struct
rw_semaphore', which then makes the "oops they got allocated in
different cachelines" much more likely.

So even if 'struct inode' layout itself isn't changed, maybe just
optimizing the layout of 'struct rw_semaphore' a bit for the common
case might fix it all up.

Waiman, I didn't check if your rewrite already possibly fixes this?

                   Linus
