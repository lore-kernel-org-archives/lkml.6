Return-Path: <w@1wt.eu>
X-Google-Smtp-Source: AB8JxZqJvVvVMH6G+0NOJunsRjPBviwIvOPIMtGXk+bgL9J6S+7KrXds1V0aN+rbdoWu9nS/2Gws
ARC-Seal: i=1; a=rsa-sha256; t=1525365319; cv=none;
        d=google.com; s=arc-20160816;
        b=yjSErKxb6QBrYNIl2B2WMd47hTh4eb/1i0zfXoh0OfYRqtE3daYyQuD2Cb+KZmG5Gb
         cUFUkdiN2Qvk41Np+47EDn/ZVhIvsWUed1sk1mS+Q7Dj4bhc0B8Q+mgNKDGwuJXETTR/
         bOKHwYB0Jb/SmOYXb4mq4hzqDyuIzrKgiub0QdiN/Wwje6SVfyZQI2PJGhc26vZJ3XHL
         SeA6fejRkXk6vgS/C1VP/xGBENDfdGewaAydXGM3lsAGEsSuJWExLTnj9N2PHMTb+6on
         ZFYHsxCweJeFLicsKQMpKs8nvbZ5e1uBrLwQ6fhvA8eaj9HA64X5iEKgyZ9StwwXqBuN
         j8pg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:arc-authentication-results;
        bh=1VO+6s0JtP50ySALlpeQBISQLNnPhrocOk/pzShhywc=;
        b=J/7KW/yHVDkwn+AjjH8K5h69bz4Id4a9G+yOmgk86XQQ6dZpR8hw/xHbDPPdK7V1Cj
         hXd4BiS1GTGyrhbWt2lY8wamD+Ppj4CfQEfdYxqZ8jz0QzX0f435t/+Tr8JzdUdScpTf
         CDfPRTsbl1n1IMx5USgiisDbPrpRskliU+HRSzcG67c9gBSzrvMQn35DJbVrlKssBdO4
         9e6zmWTp5eDZJ7ZEhOTVQyFxVE5xaVXJLlM0e17t52PZtRd9akENAJKuZRhjjpPPtp4/
         bS56xlY7vkwo2KqKpTZ2Hg9J40VVlDXHPfXAK+2xH3GabtgtYVps8Fji88U/Ec2e8Ceq
         sn8w==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of w@1wt.eu designates 62.212.114.60 as permitted sender) smtp.mailfrom=w@1wt.eu
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of w@1wt.eu designates 62.212.114.60 as permitted sender) smtp.mailfrom=w@1wt.eu
Date: Thu, 3 May 2018 18:35:16 +0200
From: Willy Tarreau <w@1wt.eu>
To: Sasha Levin <Alexander.Levin@microsoft.com>
Cc: "Theodore Y. Ts'o" <tytso@mit.edu>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "ksummit-discuss@lists.linuxfoundation.org" <ksummit-discuss@lists.linuxfoundation.org>
Subject: Re: [Ksummit-discuss] bug-introducing patches
Message-ID: <20180503163516.GJ23311@1wt.eu>
References: <20180501163818.GD1468@sasha-vm>
 <CAMuHMdWNFz_9OpddZ6tTaQcNVH01pkhwd0+3Z31uDcZvbkV6Ow@mail.gmail.com>
 <20180502195138.GC18390@sasha-vm>
 <CAMuHMdW_i-KQpqMz0zsz77tRcE-Sron5zAyh0SHAOJ5ap7x60w@mail.gmail.com>
 <20180503000620.GA29205@thunk.org>
 <20180503144612.GJ18390@sasha-vm>
 <20180503145205.GD23311@1wt.eu>
 <20180503150104.GL18390@sasha-vm>
 <20180503160046.GH23311@1wt.eu>
 <20180503161452.GP18390@sasha-vm>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180503161452.GP18390@sasha-vm>
User-Agent: Mutt/1.6.1 (2016-04-27)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1599280464106480109?=
X-GMAIL-MSGID: =?utf-8?q?1599461465909051496?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, May 03, 2018 at 04:14:57PM +0000, Sasha Levin wrote:
> I tried looking at a few commits that came in on -rc7, and I see quite a
> few cases where a commit was merged to Linus' tree in about 24 hours
> after it was authored. Or maintainers who just wrote it, pushed it in,
> and shipped in to Linus.
> 
> I've attached the data I used. The columns are as follows:
> 
> 1. Commit ID
> 2. When was it merged
> 3. How many days it spent in -next
> 4. What commit did it fix
> 5. When was that commit merged

> b6cdbc85234b v4.16-rc7 5 ca254490c8df v4.3
> 82dd0d2a9a76 v4.16-rc7 5 8f58336d3f78 v4.2
> 5807b22c9164 v4.16-rc7 5 6c8702c60b88 v4.9
> f97c3dc3c0e8 v4.16-rc7 5 4c4dbb4a7363 v4.15
(...)

I like this (not what was done but the analysis).

I'd argue that a small part of them there are very likely valid reasons
(really obvious fix, security issue etc) but it seems there are quite a
large number of them here.

Now I understand what makes me uneasy with what I'm seeing here. As I
mentioned, -rc is for people who want to see bugs before their users.
-rc7 will ensure almost everyone discovers the fix at the same time,
because the next version will be 4.16, the first of a stable release,
the one that users are expected to trust.

So probably that we have to educate/encourage developers *not* to submit
fixes for old bugs that late in the cycle and to rather wait for the next
version so that it cooks in -rc for a while before hitting users, knowing
that these fixes will be backported to stable anyway once considered valid.

Just like Greg has its "WTF" script to remind some developers that their
patch is not suited to -stable, I think you could, based on your work,
try to spot regressions introduced by late patches that fall in the
category you've filtered and emit such WTF messages to the original
patch's authors/committers.

It's important to do it only when these patches cause breakage though,
because we don't want to needlessly delay fixes when they're considered
certain or well tested. Only when they cause trouble.

For me the rule seems simple to understand, every submitter should
think like this late in the cycle :

   "you're sending a patch that is going to be part of a stable kernel
    in no more than 2 weeks, possibly affecting all users upgrading to
    that kernel if you did something wrong. Are you really certain you
    want this patch merged now, that it got sufficient testing and that
    it cannot wait for next -rc1 to get broader exposure first ?"

I'm pretty sure that most of the time it will be "sure I want it now"
and there will be no problem, which is fine as it automatically reduces
the number of bugs in releases. Some may reconsider their submission.
Some may get caught by your automated script if a later commit fixes
an issue introduced by their patch. And there public shaming is the
only option (or maybe only the second time if you really want to be
nice).

Willy
