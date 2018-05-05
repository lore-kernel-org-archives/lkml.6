Return-Path: <w@1wt.eu>
X-Google-Smtp-Source: AB8JxZo1Zqc/4OS5sxRJPZ99ojl9Suf0/O0uAmSChb1itySv2G/lEzwzIamXbzcVFrGMF1in/Zo+
ARC-Seal: i=1; a=rsa-sha256; t=1525494242; cv=none;
        d=google.com; s=arc-20160816;
        b=F5vXw3UF6HReLrxBSJZNy5ycetd0nKPgDbInbr6WlnbsNmbMPSeqey2PQkDbkwo+nW
         BwSkSihP04dmjWSOtAf/MJu+YGX2kWmE7nIcPuS6VZoUw+ZoCCFIEd5kjvHUVIZc6u1S
         KldG7/yuH3ZgOiadzbH5LDCr8ZbyhV8I3u76vCiJKAmmNFqNUw8EKw4USKLR0q8rWoNi
         jDWZcSEFj1Fd6h8Ti1Rg2/Dqt7Pw7BSf3FavPuehau4nuvcnSGyHMT255rMzfMAtrwZU
         v+MZbm9zild75VTeFCzxB4V+qtVI1mlHE61yiLPDX1yaXhBRqEl84/h8YD7pHhfqQ6IY
         wAfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:to:from:date:arc-authentication-results;
        bh=5AqGj+Q9Kvpm4Oy0Z8ZJI6PvxyjWdyCKNmIgyD80O/A=;
        b=V+5s0b35tznsCW2IxhH3e4h4294lh/8wGFNify40R2/eWor4QZRJgqkqCSxNRwCept
         jmCRUT65rXbViGqPYfjLC0u5z4dQqEMQYzpuTYGcriRjdvxqy51oOHQTIPW6IsdR2esk
         0AljuXA5iNKPAX6mLxYlxB3U6BzUTST/RTh/8fkidzkI4fcdNfyhF7hYMAYzaPM9VqHL
         3CPXIxkWrFwlL2qd5nh/S0myLK1vgZ+ySvi0Pi1MfLIGuIzthDpi2nb7GGqWaiEd3Qd9
         W8a0F5SzgMPP06m3qOeXzF+lzGKWhqB3nsLqpyasBbr4AgMau8erz8gH8L/WPp6TZ1BL
         oPAg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of w@1wt.eu designates 62.212.114.60 as permitted sender) smtp.mailfrom=w@1wt.eu
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of w@1wt.eu designates 62.212.114.60 as permitted sender) smtp.mailfrom=w@1wt.eu
Date: Sat, 5 May 2018 06:23:56 +0200
From: Willy Tarreau <w@1wt.eu>
To: "Theodore Y. Ts'o" <tytso@mit.edu>,
        Sasha Levin <Alexander.Levin@microsoft.com>,
        James Bottomley <James.Bottomley@HansenPartnership.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "ksummit-discuss@lists.linuxfoundation.org" <ksummit-discuss@lists.linuxfoundation.org>
Subject: Re: [Ksummit-discuss] bug-introducing patches
Message-ID: <20180505042356.GA24575@1wt.eu>
References: <20180503173422.GR18390@sasha-vm>
 <20180503182039.GC30522@ZenIV.linux.org.uk>
 <8669.1525427874@warthog.procyon.org.uk>
 <87fu377gbu.fsf@intel.com>
 <20180504130932.GI29205@thunk.org>
 <20180504174055.GF4649@kroah.com>
 <20180504211317.GK29205@thunk.org>
 <1525469881.4114.5.camel@HansenPartnership.com>
 <20180504215111.GX18390@sasha-vm>
 <20180504233542.GM29205@thunk.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180504233542.GM29205@thunk.org>
User-Agent: Mutt/1.6.1 (2016-04-27)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1599280464106480109?=
X-GMAIL-MSGID: =?utf-8?q?1599596650318142998?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, May 04, 2018 at 07:35:42PM -0400, Theodore Y. Ts'o wrote:
> On Fri, May 04, 2018 at 09:51:14PM +0000, Sasha Levin wrote:
> > I don't have an objection to moving this to it's own tag. It will make
> > my scripts somewhat simpler for sure.
> 
> It's not a matter "moving this it's own tag", but creating a new tag
> --- because what is in the docs is a lie.  It does not describe what
> we do today.  And current practice is the reality, not what is in the
> docs.
> 
> As to whether we should create a new tag to support explicit
> dependencies, I'll leave that between you and Greg K-H and the rest of
> the stable maintainers.  :-)

Guys, *personally*, I've sometimes been a bit annoyed by the huge amount
of irregular extra headers trying to compensate for horribly vague commit
messages, and I'm pretty sure it pisses off patch authors who don't know
anymore what to put in their description. We need to keep in mind that
authors are humans and not machines, and that natural language remains
the best to explain complex dependencies. I'd prefer to see :

    This patch needs to be backported to all stable branches that contain
    717d3133 and 207f5b3c (that's 3.10+) or their respective backports but
    must be adapted (contact me) if only a backport of 717d3133 is present.

    Cc: stable # v3.10+

Rather than horrible stuff like this :

    Cc: stable # v3.10+ (717d3133 && 207f5b3c) || WARN_ON(back(717d3133))

Of course it's a bit made up, but not too far from what is being discussed
here, probably only the next step. People will often get complex rules
wrong, both on the producer and on the consumer side. The day we need a
compiler to emit commit messages, we'll have to wonder if we didn't go
too far.

Also I've found the Fixes header pretty useful. It allows patch authors
to mention what is being fixed without necessarily copying stable,
because sometimes you'd rather not see your patch immediately backported
or you think the risks are higher than the bug. And here as well, it's
only suited for simple situations with a single commit ID, complex
desriptions have to be part of the commit message body.

I think that what we have now works pretty well but that some descriptions
lack a bit of detail, especially on the impact of the bug which would help
decide to backport or drop. This is understandable because often the person
fixing a bug documents it for people knowing the same subsystem well. But
when you backport fixes into other kernel versions, you don't know well
how each subsystem works, and guessing the impact of a bug is not always
obvious. Most of the time, authors who add Fixes: and/or Cc: stable take
care of providing enough information, though I'd suspect that sometimes
they're making efforts trying to figure how to place the information
there and possibly try to avoid redundancy by writing a shorter body.

At this point, I'm really not seeing what we're trying to improve or
optimize, and to be honest this discussion worries me a bit, by just
thinking that it could result in annoying changes...

Willy
