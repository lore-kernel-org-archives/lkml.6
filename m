Return-Path: <linux@roeck-us.net>
X-Google-Smtp-Source: AB8JxZq17rpD93lG3T7L6F5xhZNF/CPPyFAI8qE4a4JjNYGvBSZCTSnJt48Ybp1nI98uZ1x6z8Cy
ARC-Seal: i=1; a=rsa-sha256; t=1525362557; cv=none;
        d=google.com; s=arc-20160816;
        b=BGUbyZazQG+Mvp/xlBb32Y1V3boYFCnU5m8h6MLt9qcdLUU1MTnz//4coMbRGrgPHZ
         DJA9vDpbQhhGa+5n6wISIt5CtB/FxMe2MdYbn7WXHavj+sBx24SBD6MReA0I/7qpZShf
         0lQn5gcxK9WReH7NAOE9EVRPaNm0no0FhNGnbQjFq+3QUyR2nwGdSGGtO0VQG/JjZc/v
         UCOUR9opUzZi5cDiOvgTTCbhzX81yz1L+xi92ILJo7gybXWYUkRroviGlB7XikmWBPR7
         1Ws6ODbPnmlLA+v1ptNu9hwVnORabZ/rhgi0IExHinMjZSC5fhOsvX+nDQvQphB6dVRd
         VMhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:dkim-signature
         :arc-authentication-results;
        bh=U6fzWXJUmwEtE/qLcsfkjEsb9sxWWWDC93kI8RBuHro=;
        b=bs74/dFdFSn7Vsj8zNLsJHTjBjK8n5HdY3zYbmhhSt0KUU+V648Op2S8UZN+NIUaBk
         GsjdE/v/TMQttLxJmlP8zbgeCh1aCsyQmY/2pPn3vIHRvL475Vc3RD8ARXminL0zVODL
         0ePScR1PWYExOldJA5mLnxcT8M+1b+495cfdl6tsppIYOmOetWMd6qPLSCkBjkDlQgv9
         ePLtGJmqxSKToBuinwh3qQ6egoGcXd73ytOMoaRH0CvqJGw73hvpYlo3s+cAq91wZptf
         rE2hyYp5a6bjnugm2w/i/QyqrwK59DOy4/fMw86vwDaQCBkMvUYDtYlfcLRKEzit5aiF
         d1wQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@roeck-us.net header.s=default header.b=M6/SB1jS;
       spf=pass (google.com: domain of linux@roeck-us.net designates 208.91.199.152 as permitted sender) smtp.mailfrom=linux@roeck-us.net
Authentication-Results: mx.google.com;
       dkim=pass header.i=@roeck-us.net header.s=default header.b=M6/SB1jS;
       spf=pass (google.com: domain of linux@roeck-us.net designates 208.91.199.152 as permitted sender) smtp.mailfrom=linux@roeck-us.net
Date: Thu, 3 May 2018 08:49:11 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Sasha Levin <Alexander.Levin@microsoft.com>
Cc: "Theodore Y. Ts'o" <tytso@mit.edu>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Greg KH <gregkh@linuxfoundation.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"w@1wt.eu" <w@1wt.eu>,
	"ksummit-discuss@lists.linuxfoundation.org" <ksummit-discuss@lists.linuxfoundation.org>
Subject: Re: [Ksummit-discuss] bug-introducing patches
Message-ID: <20180503154911.GA26754@roeck-us.net>
References: <20180501163818.GD1468@sasha-vm>
 <CAMuHMdWNFz_9OpddZ6tTaQcNVH01pkhwd0+3Z31uDcZvbkV6Ow@mail.gmail.com>
 <20180502195138.GC18390@sasha-vm>
 <CAMuHMdW_i-KQpqMz0zsz77tRcE-Sron5zAyh0SHAOJ5ap7x60w@mail.gmail.com>
 <20180503000620.GA29205@thunk.org>
 <ed65dc49-dad0-21a1-676c-f9ba43ba5c6c@roeck-us.net>
 <20180503145533.GK18390@sasha-vm>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180503145533.GK18390@sasha-vm>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Authenticated_sender: guenter@roeck-us.net
X-OutGoing-Spam-Status: No, score=-1.0
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - bh-25.webhostbox.net
X-AntiAbuse: Original Domain - linuxfoundation.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - roeck-us.net
X-Get-Message-Sender-Via: bh-25.webhostbox.net: authenticated_id: guenter@roeck-us.net
X-Authenticated-Sender: bh-25.webhostbox.net: guenter@roeck-us.net
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1599280464106480109?=
X-GMAIL-MSGID: =?utf-8?q?1599458568609526852?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, May 03, 2018 at 02:55:36PM +0000, Sasha Levin wrote:
> On Wed, May 02, 2018 at 05:38:32PM -0700, Guenter Roeck wrote:
> >On 05/02/2018 05:06 PM, Theodore Y. Ts'o wrote:
> >>On Wed, May 02, 2018 at 10:41:56PM +0200, Geert Uytterhoeven wrote:
> >>>
> >>>Between v4.17-rc1 and v4.17-rc3, there are 660 non-merge commits, of which
> >>>   - 245 carry a Fixes tag,
> >>>   - 196 carry a CC stable,
> >>>   - 395 contain the string "fix".
> >>>(non-mutually exclusive)
> >>>
> >>>That leaves us with 200 commits not falling in the bugfix category.
> >>
> >>Some non-bug fixes are allowed in -rc2.  So perhaps what might be
> >>interesting is to look at v4.16 (which is completed), and look at the
> >>distribution of commits:
> >>
> >>	* regressions fixes (for bugs introduced during the current
> >>		release cycle)
> >>	* "normal" bug fixes
> >>	* commits which don't touch code (e.g., spelling or
> >>		documentation-only fixes)
> >>	* other commits (features or cleanup fixes)
> >>
> >>at each rcX level.  The historic "standard" has been feature commits
> >>in -rc1 and -rc2 (tolerated, but ideally should before the merge
> >>window), bug fixes / regressions in -rc3 and -rc4, and after -rc4,
> >>regression fixes only.  It would be interesting to see how well we
> >>have been holding to the historical ideal.
> >>
> >>It would then be intersting to use Sasha's analysis to see whether
> >>there are more bug fixes caused by regression fixes versus normal bug
> >>fixes, and whether or not they are common when fixes come "out of
> >>cycle" --- for example, a non-regression bug fix in -rc5 or -rc6.
> >>
> >>Because if that last is the case, then the prescription is very simple
> >>and not controversial --- bug fixes found post -rc4 should be held to
> >>the next merge window.
> >>
> >
> >Holding up even fixes for severe bugs for 4-6 weeks ? Seriously, that is
> >unrealistic. Holding up the fix for the next SpeckHammer because it was not
> >ready before -rc4 ? I don't think so.
> 
> For severe problems, the patch usually gets more than enough reviews and
> testing, so I don't see a need to soak it in -next more than some
> minimal amount of time to get bot coverage.
> 
> However, these things show up only a few times per year. Most of the
> fixes even in late -rc cycles are for older bugs that aren't too
> critical. We can't base our decision on severe bugs that get exceptional
> treatment anyways (see PTI getting pushed in -stable).
> 
> >Even when not counting severe problems, you are adding lots of additional work
> >for those who do and want to rely on stable releases to merge in bug fixes.
> >Sure, I am at times annoyed having to deal with a regression in a stable
> >release, but it very much beats digging through various mailing lists for
> >pending patches to fix CVEs, or for crashes seen in the field, just because
> >they are held hostage by some restrictive process. Even worse, I'd end up
> >picking the regressions anyway because I can _not_ wait those 4-6 weeks
> >plus the time it takes for the fixes to show up in a stable release.
> 
> I think that for -stable we don't have a good idea how soon we want to
> merge patches in. On one hand enterprise distro folks complain we're
> jumping the gun, and on the other hand folks like yourself claim we're
> too slow :)
> 

You are misquoting me. I am saying that it would be a bad idea to hold up
bug fixes after -rc4, which is quite different to saying that patches
don't make it into stable releases fast enough. I am perfectly happy to
wait a week or so for a patch to soak in _mainline_ before being applied
to stable.

I am absolutely _not_ happy with the number of patches making it into
-stable releases recently. I am especially very concerned that the current
flurry of patches queued for -stable will destabilize pretty much all
stable releases, and pretty badly, for that matter. I am seriously
contemplating not to integrate the next few stable releases into ChromeOS
for that very reason. That would be a different discussion, though.

Guenter
