Return-Path: <jmforbes@linuxtx.org>
ARC-Seal: i=1; a=rsa-sha256; t=1525787900; cv=none;
        d=google.com; s=arc-20160816;
        b=HC1D8Azjz32rt8Lxg+Rjxy+bNVqgG5vO2e/nrAEgVPE5vLtHLzmT/481MlUYOLu4w3
         /NcXWFn4847i4YO/Q5V8cnexrRkPi3h7MG8Tpc1Jntd6j58VW77IR0+Y3HrG+aYtFmhn
         zf6orAvP9wRgC8va5F1rTyEibhBm8dK8/2ds0mkLi1JRb5DpxX0lj+7ABXzsQT3kqOHj
         ADhBMYtqBWecwbKjAtzTJpLcvDPycKosFOxfjKAMCnzm39lbkQDtdLdAJaW0TU9BVx8G
         BlMhJGhrk5+kRle7kU0ibF5n1HIj/hEUYd//GvsXTLYjlgFnZLrYbTOIAUfyHGS4AzLv
         wewA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:dkim-signature:arc-authentication-results;
        bh=FucuCKgyXG7P70qY4mBUzqtTrV/6Bda92guL48WF0+U=;
        b=ZlxbJrFJ0zEAvJElOdpfS8yKDJRvL4jrWCmBGOfFL4ad5NV7XRbam4oDer+z/6+L7C
         9Ic4BNGfBa6uuDjVVrJ2WvPEDvduZm8+avJsLnmxJ3y4x/lZ7zI+LpdB6QfQ7J27XGh3
         dXMIe6JIWz5sylaxBpGqNo4Aei5qSJ4MA33YEhidnqpCeI+QfttCrj2HD9rcNQgSGdyh
         6AET1hucnx8PjherhcYLHzFwFsZOdtj+mFlBI+h25ctGfqubETnphGyCx52fKc1kNsoE
         qiHMoZjo/kfHW1GFhIbIaEwgsL754oD3NG3O0OFCtPXi63jikX/Tl/cxtl+Nhyv1oznk
         K9KA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@linuxtx.org header.s=google header.b=LdEO3qV8;
       spf=pass (google.com: domain of jmforbes@linuxtx.org designates 209.85.220.41 as permitted sender) smtp.mailfrom=jmforbes@linuxtx.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@linuxtx.org header.s=google header.b=LdEO3qV8;
       spf=pass (google.com: domain of jmforbes@linuxtx.org designates 209.85.220.41 as permitted sender) smtp.mailfrom=jmforbes@linuxtx.org
X-Google-Smtp-Source: AB8JxZr7sqH+eTMJ5giJIvRNkes90Zb4ELCIB5ITbkf+otVZ5Wa0MJf0pt/jnm67P3cH8Biq6GQKCwg1MkN+M5e/8Ec=
MIME-Version: 1.0
In-Reply-To: <20180508023439.GA8514@sasha-vm>
References: <20180501200019.GA7397@sasha-vm> <20180501205448.GE10479@thunk.org>
 <20180501211551.GI2714@sirena.org.uk> <CAKMK7uHjA27K8y-kwYFyhLy3cSkJJw8Oe1gP=3hZXdfxcWAcNQ@mail.gmail.com>
 <20180502194632.GB18390@sasha-vm> <20180503020550.GP2714@sirena.org.uk>
 <20180503031000.GC29205@thunk.org> <0276fcda-0385-8f22-dbdb-e063f7ed8bbe@roeck-us.net>
 <20180503224217.GR2714@sirena.org.uk> <20180503230905.GA98604@atomide.com> <20180508023439.GA8514@sasha-vm>
From: Justin Forbes <jmforbes@linuxtx.org>
Date: Tue, 8 May 2018 08:58:19 -0500
Message-ID: <CAFxkdAqEK3Kv1Q8Jy4KZ7AHPXAA7ux6CYsQ4m6grKwFGwzNrXQ@mail.gmail.com>
Subject: Re: [Ksummit-discuss] bug-introducing patches
To: Sasha Levin <Alexander.Levin@microsoft.com>
Cc: Tony Lindgren <tony@atomide.com>, Mark Brown <broonie@kernel.org>,
	Greg KH <gregkh@linuxfoundation.org>, "w@1wt.eu" <w@1wt.eu>,
	"ksummit-discuss@lists.linuxfoundation.org" <ksummit-discuss@lists.linuxfoundation.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1599280464106480109?=
X-GMAIL-MSGID: =?utf-8?q?1599904573958181861?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, May 7, 2018 at 9:34 PM, Sasha Levin
<Alexander.Levin@microsoft.com> wrote:
> On Thu, May 03, 2018 at 04:09:05PM -0700, Tony Lindgren wrote:
>>* Mark Brown <broonie@kernel.org> [180503 22:44]:
>>> On Wed, May 02, 2018 at 08:52:29PM -0700, Guenter Roeck wrote:
>>>
>>> > As for -next, me and others stopped reporting bugs in it, because when we do
>>> > we tend to get flamed for the "noise". Is anyone aware (or cares) that mips
>>> > and nds32 images don't build ? Soaking clothes in an empty bathtub won't make
>>> > them wet, and bugs in code which no one builds, much less tests or uses, won't
>>> > be found.
>>>
>>> You've been flamed for testing -next?  That's not been my experience and
>>> frankly it's pretty horrifying that it's happening.  Testing is pretty
>>> much the whole point of -next existing in the first place so you have to
>>> wonder why people are putting their trees there if they don't want
>>> testing.  I have seen a few issues with people reporting bugs on old
>>> versions of -next but otherwise...
>>
>>Yes I agree testing Linux next is very important. That's the best way for
>>maintainers to ensure a usable -rc1 after a merge window. And then for
>>the -rc cycle, there not much of need for chasing bugs to get things working.
>>
>>Bugs reported for Linux next often seem to get fixed or reverted faster
>>compared to the -rc cycle too. I think that's because people realize that
>>their code will not get merged until it's been fixed.
>>
>>So some daily testing of Linux next can save a lot scrambling after the
>>merge window :)
>>
>>Users don't usually upgrade kernels until after later -rc releases or only
>>after major releases so that probably explains some of the -rc cycle fixes.
>
> Tony, I'm curious, how many users are you aware of who actually run
> Linus's tree? All the users I've encountered so far on Azure seem to be
> running something based on -stable.

I couldn't tell you the number of users we have running rawhide
kernels (daily builds of Linus's tree), but it is a positive integer.
We do get bug reports on things, sometimes a day after Linus commits
them.

>
> I can't really get any solid statistics about that on my end both
> because I don't have visibility inside user VMs (I don't actually have
> prod access believe it or not), and even if I had it would probably be
> confidential, so I'm just basing this on reports from user's I've seen
> so far.
>
> I think that a question we should be asking ourselves is whether we
> should be basing our decisions here on the assumption that (pretty much)
> no one runs Linus's tree anymore?
