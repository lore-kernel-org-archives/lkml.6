Return-Path: <w@1wt.eu>
X-Google-Smtp-Source: AB8JxZrttqdNwrOM9tDpZs16CQq9HETDxeMffSmH8vV8bTUmbaxUSArd17OaNEe21QGIzdfHswVl
ARC-Seal: i=1; a=rsa-sha256; t=1525374234; cv=none;
        d=google.com; s=arc-20160816;
        b=QaZhO0wJXs5gcJ1s/hkIIwgseLTZ5c2Pycey7vLz7P7S/XxPAXQHHD+ZUBRk/UI601
         S/SA1M7+uR5TaEDQozxn06FLa9BsPXQaZDnU4+67ymmAxAsEO4AC2y1XlpIxdHTBBUPl
         4qFBRD7vfP4GQ3FSBEa1H/MRf8BDWhNv0AHN1WA98OkEejIpvU/AkgO4gMsFoZUsBnbu
         tyfg8DWRPtQsB8hpupmSPFhgzglKjp4Gj3SWKGWPLMgACTi4bNzpXqWrSliInIr/XNfx
         1oTxeiubxrXkOa8QHcTOEfV9xyAT8NxU8bVPAhEK7Nll9LVQOSisLWUfG2pBQvKe5u28
         RNuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:arc-authentication-results;
        bh=XqKKPHeMDck1GZTkGJSeLbS2hnGJWdncqgqhIKAjEgQ=;
        b=g1NXHT9jE++x2N4HNUBz/QYnHBuXGRIu50TnF8NSAY7L+c3q2ECbEVI2ACGabdb2JA
         EzWSMhpjSTgpzpGjMmSHW4XM4xz7z1gV5elVKKFwLaJwQYYEfvUDJhoL9BkXD21fowp4
         K0f9XXkiHlELuUS2PyhlpQbeKYDH7+aciMw/gllXFVp72K8oRKwkbVS6RkW+zm+olM1q
         PD8ccESlKZxQTE8RZoJzNPdTO7urYMSwqEODeA0xSlm+hKwPsDp1I3/GXuDSmW0hdLr8
         M0Qds7krjajRzWDl9xJZzqaWAqhou7PmCRXPXz5bSCpVRS5kLvjmkD+7USyezcH1Yhr1
         8bQA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of w@1wt.eu designates 62.212.114.60 as permitted sender) smtp.mailfrom=w@1wt.eu
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of w@1wt.eu designates 62.212.114.60 as permitted sender) smtp.mailfrom=w@1wt.eu
Date: Thu, 3 May 2018 21:03:52 +0200
From: Willy Tarreau <w@1wt.eu>
To: Sasha Levin <Alexander.Levin@microsoft.com>
Cc: "Theodore Y. Ts'o" <tytso@mit.edu>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "ksummit-discuss@lists.linuxfoundation.org" <ksummit-discuss@lists.linuxfoundation.org>
Subject: Re: [Ksummit-discuss] bug-introducing patches
Message-ID: <20180503190352.GB23467@1wt.eu>
References: <20180503000620.GA29205@thunk.org>
 <20180503144612.GJ18390@sasha-vm>
 <20180503145205.GD23311@1wt.eu>
 <20180503150104.GL18390@sasha-vm>
 <20180503160046.GH23311@1wt.eu>
 <20180503161452.GP18390@sasha-vm>
 <20180503163516.GJ23311@1wt.eu>
 <20180503172926.GQ18390@sasha-vm>
 <20180503175723.GA23467@1wt.eu>
 <20180503181234.GT18390@sasha-vm>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180503181234.GT18390@sasha-vm>
User-Agent: Mutt/1.6.1 (2016-04-27)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1599280464106480109?=
X-GMAIL-MSGID: =?utf-8?q?1599470813279158987?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, May 03, 2018 at 06:12:36PM +0000, Sasha Levin wrote:
> I'm also not trying to argue whether 7% is high or low, only that it's 3
> times as many bugs per line of code than what we get from the merge
> window.

Yes but seen differently that's 14 times less bugs than the ones properly
fixed by applying the process which produces these 7%. We can discuss
about ways to improve it, but please consider that it must not reduce
the number of correct fixes represented by the 93% remaining ones.

> Isn't the merge window supposed to be the "risky" part?

"risky" might not be the correct term. Each single line of code comes
with a risk. I'd say the "most risky" part. As I said, what I agree with
the fact that early fixes just before a release have more chances of
affecting users, which in my opinion is the real problem. Education can
help here.

> For example, how about extending the release cycle until the amount of
> fixes for regressions introduced in the current merge window drops under
> a certain thershold? (so go to -rc20 if we need to).

Never works. And Linus already explained it : you cannot stop the development
process. While you're waiting, development continues, and the next merge
window gets twice the number of commits, which causes more than twice the
amount of problems. I've also experienced it in haproxy many years ago. I
made the mistake of saying "I'm finishing this, only 6 months, and I release
1.5". Result: bugs coming in parallel to development stalling progress
forever and it took 4.5 years to release it, or 9 times the expected amount
of time. Now we release approximately on time, missing features go in the
next release, easily testable fixes are merged, complex ones are postponed
for the stable releases with a note in the announce saying "don't play with
this yet, it's broken". We do ship with bugs, we're open about it and we
address them later. Overall this transparency is much appreciated. And we
also do regressions by the way.

Maybe in the end the only thing we're missing is a "known bugs" section in
release announcements, so that those with pending fixes are encouraged to
send a line or two to Linus for inclusion there, having more time to work
on their fixes.

Willy
