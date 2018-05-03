Return-Path: <w@1wt.eu>
X-Google-Smtp-Source: AB8JxZoSXQL8oO3NnHyhcv1YEfpsytIMm7eZA6KvQBeOmJb/RTvntnXElm72rYUMIsVz06Ejws8i
ARC-Seal: i=1; a=rsa-sha256; t=1525370246; cv=none;
        d=google.com; s=arc-20160816;
        b=SxNKQIrksU+SWHc1TZyMV/m/NYZpJS2Kg60gDuGdxTPFM4Or8/kKwB3nkW06ExSQNc
         SRAZcC1gs0tbLlLnXS6aqmNGxAvoTAyl+XPrbWo3EH7iDOmL2zC2unu/I1slL82nmtFP
         nZhUHsXWzbmHsQeaHixnA7RCMW3gmUaNl/it7GIC8rIYCcjGwC54tE2hvGoavzFvBwo0
         OnOSmtjUywO2uwfCg1Ex18GPhFJoT9a5xalANzbMuN/XHlY3GqL98OpUal7OU0+ZSE9O
         2VIFpKsAMUrGF5bibSGE4e6h4A3GrzzEpF6wbHyF5/WbDDhyT1/0mWnW3mP4HDWaK+Iv
         3uOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:arc-authentication-results;
        bh=oJqdFPMYooNfneqSmY3kiW74qkNspOeH4RlYutFjb5w=;
        b=rzS6MNTvTN5YkTXwDWRkqligx4KQvRzWzNvnfJCqxSGqJbhBneyod7sc0Ad4hGX+ai
         3/T61b76tFPYI/lgt1tPUQn3171RIziL5rQgDFS7/xsDzeigJtbMdKIH0fTWLInetJd7
         q+51xdu5RpeOc/Y9wDRrfclPRGjb7UfzlQPHPF2ptAawH/ln4HwvpJqZkWedcrLanm4E
         Nghpnz3hZ6rk3LGTGHu5cRDHQmKvc1r48BIO8fzryHBpsfPLvxVUCx1v3G7MWn4e6Z2N
         I7qoovrUUuAwG6AQT9U0wmH/+zWkGeR5MsSjSbOOrxIQUU6DDHD4Ukh0KigTHQx7bBP+
         UE8w==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of w@1wt.eu designates 62.212.114.60 as permitted sender) smtp.mailfrom=w@1wt.eu
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of w@1wt.eu designates 62.212.114.60 as permitted sender) smtp.mailfrom=w@1wt.eu
Date: Thu, 3 May 2018 19:57:23 +0200
From: Willy Tarreau <w@1wt.eu>
To: Sasha Levin <Alexander.Levin@microsoft.com>
Cc: "Theodore Y. Ts'o" <tytso@mit.edu>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "ksummit-discuss@lists.linuxfoundation.org" <ksummit-discuss@lists.linuxfoundation.org>
Subject: Re: [Ksummit-discuss] bug-introducing patches
Message-ID: <20180503175723.GA23467@1wt.eu>
References: <20180502195138.GC18390@sasha-vm>
 <CAMuHMdW_i-KQpqMz0zsz77tRcE-Sron5zAyh0SHAOJ5ap7x60w@mail.gmail.com>
 <20180503000620.GA29205@thunk.org>
 <20180503144612.GJ18390@sasha-vm>
 <20180503145205.GD23311@1wt.eu>
 <20180503150104.GL18390@sasha-vm>
 <20180503160046.GH23311@1wt.eu>
 <20180503161452.GP18390@sasha-vm>
 <20180503163516.GJ23311@1wt.eu>
 <20180503172926.GQ18390@sasha-vm>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180503172926.GQ18390@sasha-vm>
User-Agent: Mutt/1.6.1 (2016-04-27)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1599280464106480109?=
X-GMAIL-MSGID: =?utf-8?q?1599466632087115615?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, May 03, 2018 at 05:29:29PM +0000, Sasha Levin wrote:
> I tried pulling all the fixes that went in 4.17 (so far) for bugs that
> were introduced as fixes in the v4.16 cycle, I got this list:
> 
> d65026c6c62e v4.16-rc7 5 6b1e6cc7855b v4.7   d14d2b78090c
> 63489f8e8211 v4.16-rc6 13 045c7a3f53d9 v4.11-rc6   5df63c2a149a
> 5dcd8400884c v4.16-rc6 6 0759e552bce7 v4.7   bd28899dd34f
> 0ef58b0a05c1 v4.16-rc6 6 0cf737808ae7 v4.14   a56d99d71466 7992894c305e 2afc5d61a719
> 8936ef7604c1 v4.16-rc6 6 6c8702c60b88 v4.9   a957fa190aa9
> bbc09e7842a5 v4.16-rc6 6 65a206c01e8e v4.13   3239534a79ee
> 6a2cf8d3663e v4.16-rc5 12 d64d6c5671db v4.15   6d6340672ba3
> 859d880cf544 v4.16-rc4 14 b68a68d3dcc1 v4.15   8420f71943ae
> e39a97353e53 v4.16-rc4 16 2a842acab109 v4.12   cbe095e2b584
> a27fd7a8ed38 v4.16-rc4 19 f214f915e7db v4.13   bffd168c3fc5
> 0f9da844d877 v4.16-rc2 16 28128c61e08e v4.16-rc2   a95b37e20db9
> 7324f5399b06 v4.16-rc2 19 186b3c998c50 v4.14   51568d69407d
> e78c637127ee v4.16-rc3 25 187d7967a5ee v4.4   e988867fd774
> ca9eee95a2de v4.16-rc3 25 d717f7352ec6 v4.12   e988867fd774
> 
> So out of 755 commits, 14 have been fixed, that's about 2% and we're not
> even done with 4.17.

OK but this is low. Quite frankly, at 2% regressions, even if this is
never fun, it means 98% of the fixes were right. Now just delay them
longer and you'll have 500 commits instead of 755, thus 255 more bugs
unfixed in the release just to try to save 14 wrong ones. *this* is
the problem I'm concerned about by enforcing extra delays on everyone.
This is the reason why in my opinion the most important is to raise
awareness about this so people are more careful or more verbose (and
more detailed commit messages don't hurt, I think all stable maintainers
have many times thought "WTF is this supposed to fix?"), and then remind
everyone that when some get caught abusing, they'll get a public blame.

> >Some may get caught by your automated script if a later commit fixes
> >an issue introduced by their patch. And there public shaming is the
> >only option (or maybe only the second time if you really want to be
> >nice).
> 
> I'd much prefer to blame this on maintainers. Authors should be able to
> submit a patch whenever they feel like it, maintainers should only merge
> a patch in when it's right.

Sorry, wrong word on my side, I also meant maintainers (I very much favor
pushing back to ensure everyone in the chain is responsible for what is
done).

Willy
