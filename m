Return-Path: <jmforbes@linuxtx.org>
ARC-Seal: i=1; a=rsa-sha256; t=1525366201; cv=none;
        d=google.com; s=arc-20160816;
        b=RgA0GkhnLLCCIVzgKtXiBa2Vg7Az8ydpqEzTt2XOWPjzTUMMishYXYzo64J3quR8uD
         n8KSJAwUd9/DEvemJ/P4QMQ5mfCOOVod6tglHYAGidmZXLGLOy1KNyYJzFow7cBIvXm6
         mqh5jnu5b5/7q+Xm4CrqOzUBw7qedKBjrikOkQBqG2CVwdlwYGIdLhBZh3xxA0pxu0eo
         GgcMXCxh855zjsoihuLJJ0AlQSSsKXhQJ+ButQvRlkz+mRbkxIXyDfcWuulWMRGowevz
         yWvr7JpRQnX9Al798WF8sEZ8WlTUVAQV0WKGouIEnRO6DyZ6F5WfJtjDeVW1nTP3e5yw
         x0eQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:dkim-signature:arc-authentication-results;
        bh=LKdpD56f0oWMCTu6HelYce+Xyqhid0svX3J/fdaW0QI=;
        b=OTs/eJYs5noXAvAgxN8qIVjXGgbSk6j0U/TufN79/a4dy80lPK1aJ8QZgqDGWIdzWH
         BHsREdAV20yLhPEyLvHuuhaKraMyNfyYzIyIHtfH7N8GMOWEaqPs7MXgWsHGPp6DdpGc
         6NxKu+haq3w5OmiBrlP4/IRuZ+2TJHc/Vyc1TjIr23mpnGduFmSHGqjqf1w58RHMOX7x
         CvVc8KmjoO22PhuIIGBFL1XN7DdK7CPZtNH8gTEYCuLDb3L0cDwHfAgCPe8Ol7VyUL5L
         gcyhLuwWN/uLe924/cqXfK6mgT3pcMFYVjs0TvM3X8YUWrhsKJicVFVLSRIAS+ovdT9p
         0ZXA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@linuxtx.org header.s=google header.b=W2WzBPhV;
       spf=pass (google.com: domain of jmforbes@linuxtx.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=jmforbes@linuxtx.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@linuxtx.org header.s=google header.b=W2WzBPhV;
       spf=pass (google.com: domain of jmforbes@linuxtx.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=jmforbes@linuxtx.org
X-Google-Smtp-Source: AB8JxZr1t/mVjFwXHdJFyXr/0Dh0Fqdsko2ujEhgx4jJW4jnnnOy7Lu54VD9DtlNYJ89srgSMLXbj8l3NjDRm3WlQL0=
MIME-Version: 1.0
In-Reply-To: <20180503160210.GO18390@sasha-vm>
References: <20180501163818.GD1468@sasha-vm> <CAMuHMdWNFz_9OpddZ6tTaQcNVH01pkhwd0+3Z31uDcZvbkV6Ow@mail.gmail.com>
 <20180502195138.GC18390@sasha-vm> <CAMuHMdW_i-KQpqMz0zsz77tRcE-Sron5zAyh0SHAOJ5ap7x60w@mail.gmail.com>
 <20180503000620.GA29205@thunk.org> <ed65dc49-dad0-21a1-676c-f9ba43ba5c6c@roeck-us.net>
 <20180503145533.GK18390@sasha-vm> <20180503154911.GA26754@roeck-us.net> <20180503160210.GO18390@sasha-vm>
From: Justin Forbes <jmforbes@linuxtx.org>
Date: Thu, 3 May 2018 11:50:00 -0500
Message-ID: <CAFxkdAotxEpMwf_SCxpP0TMDkWA44CMA6NEu9YA-mkt03gUXAg@mail.gmail.com>
Subject: Re: [Ksummit-discuss] bug-introducing patches
To: Sasha Levin <Alexander.Levin@microsoft.com>
Cc: Guenter Roeck <linux@roeck-us.net>, "Theodore Y. Ts'o" <tytso@mit.edu>,
	Geert Uytterhoeven <geert@linux-m68k.org>, Greg KH <gregkh@linuxfoundation.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "w@1wt.eu" <w@1wt.eu>,
	"ksummit-discuss@lists.linuxfoundation.org" <ksummit-discuss@lists.linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1599280464106480109?=
X-GMAIL-MSGID: =?utf-8?q?1599462390725238603?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, May 3, 2018 at 11:02 AM, Sasha Levin
<Alexander.Levin@microsoft.com> wrote:
> On Thu, May 03, 2018 at 08:49:11AM -0700, Guenter Roeck wrote:
>>On Thu, May 03, 2018 at 02:55:36PM +0000, Sasha Levin wrote:
>>> On Wed, May 02, 2018 at 05:38:32PM -0700, Guenter Roeck wrote:
>>> >On 05/02/2018 05:06 PM, Theodore Y. Ts'o wrote:
>>> >>On Wed, May 02, 2018 at 10:41:56PM +0200, Geert Uytterhoeven wrote:
>>> >>>
>>> >>>Between v4.17-rc1 and v4.17-rc3, there are 660 non-merge commits, of which
>>> >>>   - 245 carry a Fixes tag,
>>> >>>   - 196 carry a CC stable,
>>> >>>   - 395 contain the string "fix".
>>> >>>(non-mutually exclusive)
>>> >>>
>>> >>>That leaves us with 200 commits not falling in the bugfix category.
>>> >>
>>> >>Some non-bug fixes are allowed in -rc2.  So perhaps what might be
>>> >>interesting is to look at v4.16 (which is completed), and look at the
>>> >>distribution of commits:
>>> >>
>>> >>   * regressions fixes (for bugs introduced during the current
>>> >>           release cycle)
>>> >>   * "normal" bug fixes
>>> >>   * commits which don't touch code (e.g., spelling or
>>> >>           documentation-only fixes)
>>> >>   * other commits (features or cleanup fixes)
>>> >>
>>> >>at each rcX level.  The historic "standard" has been feature commits
>>> >>in -rc1 and -rc2 (tolerated, but ideally should before the merge
>>> >>window), bug fixes / regressions in -rc3 and -rc4, and after -rc4,
>>> >>regression fixes only.  It would be interesting to see how well we
>>> >>have been holding to the historical ideal.
>>> >>
>>> >>It would then be intersting to use Sasha's analysis to see whether
>>> >>there are more bug fixes caused by regression fixes versus normal bug
>>> >>fixes, and whether or not they are common when fixes come "out of
>>> >>cycle" --- for example, a non-regression bug fix in -rc5 or -rc6.
>>> >>
>>> >>Because if that last is the case, then the prescription is very simple
>>> >>and not controversial --- bug fixes found post -rc4 should be held to
>>> >>the next merge window.
>>> >>
>>> >
>>> >Holding up even fixes for severe bugs for 4-6 weeks ? Seriously, that is
>>> >unrealistic. Holding up the fix for the next SpeckHammer because it was not
>>> >ready before -rc4 ? I don't think so.
>>>
>>> For severe problems, the patch usually gets more than enough reviews and
>>> testing, so I don't see a need to soak it in -next more than some
>>> minimal amount of time to get bot coverage.
>>>
>>> However, these things show up only a few times per year. Most of the
>>> fixes even in late -rc cycles are for older bugs that aren't too
>>> critical. We can't base our decision on severe bugs that get exceptional
>>> treatment anyways (see PTI getting pushed in -stable).
>>>
>>> >Even when not counting severe problems, you are adding lots of additional work
>>> >for those who do and want to rely on stable releases to merge in bug fixes.
>>> >Sure, I am at times annoyed having to deal with a regression in a stable
>>> >release, but it very much beats digging through various mailing lists for
>>> >pending patches to fix CVEs, or for crashes seen in the field, just because
>>> >they are held hostage by some restrictive process. Even worse, I'd end up
>>> >picking the regressions anyway because I can _not_ wait those 4-6 weeks
>>> >plus the time it takes for the fixes to show up in a stable release.
>>>
>>> I think that for -stable we don't have a good idea how soon we want to
>>> merge patches in. On one hand enterprise distro folks complain we're
>>> jumping the gun, and on the other hand folks like yourself claim we're
>>> too slow :)
>>>
>>
>>You are misquoting me. I am saying that it would be a bad idea to hold up
>>bug fixes after -rc4, which is quite different to saying that patches
>>don't make it into stable releases fast enough. I am perfectly happy to
>>wait a week or so for a patch to soak in _mainline_ before being applied
>>to stable.
>
> Most bug fixes that go in at that point are fixes for previous released
> kernels, what's the harm in keeping them around for longer?
>
> I'm not saying that it should be some arbitrary rule for everyone, but
> just suggesting that maintainers should exercise more caution merging
> untested commits that don't even fix a current regression.
>
There is a balance here. In the past, one of the biggest complaints we
had as distro maintainers was that known regressions get reported, and
fixed, and then the maintainer would sit on the fix until the next
merge window. This happened even for trivial fixes. And not being in
tree does keep it out of stable.  This has improved greatly recently.
Perhaps things have over compensated, but I don' t think that putting
a blanket rule out there is the answer. Just perhaps some best
practices for test coverage.

> w.r.t stable, as you just said, you're fine with a week or two, the
> enterprise folks (as well as Ted, to some extend, in this thread)
> suggest that this should be a month+

I don' t have an issue with some things percolating in mainline for a
bit before being pulled into stable, it might have saved us a lot of
grief with the random patches last week.  But again there isn't a set
rule that seems logical here. Adequate test coverage is the concern,
not some set time, especially for obvious fixes.  I know for Fedora,
we do have (some) people testing rawhide daily, so things in Linus'
tree start getting end user testing usually within 24 hours.

I am not saying that things are great now, or cannot be improved. I am
just concerned that we come up with some "rule" that takes us back to
keeping legitimate fixes out of tree for much longer than necessary.

>>I am absolutely _not_ happy with the number of patches making it into
>>-stable releases recently. I am especially very concerned that the current
>>flurry of patches queued for -stable will destabilize pretty much all
>>stable releases, and pretty badly, for that matter. I am seriously
>>contemplating not to integrate the next few stable releases into ChromeOS
>>for that very reason. That would be a different discussion, though.

There is certainly concern here. If end users stop trusting stable
kernel updates, the next time there is a big security issue, they may
just ignore the fix until there is consensus that it is safe to update
.
>
> For AUTOSEL, I'd be happy to learn of issues you encounter and address
> them in my process.
>
> I've been submitting automatically selected patches for over a year now
> and the track record for regressions is on par with patches that are
> tagged for stable.
