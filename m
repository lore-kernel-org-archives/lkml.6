Return-Path: <geert.uytterhoeven@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1525293717; cv=none;
        d=google.com; s=arc-20160816;
        b=nKjdmPcnDVYqtOo+KwgxZSVjcm9ruEV6VaF6mL4ra3VKh53uSVV8OrVd/L7AYuwz6h
         QohpXFvG38ht5XJVwtAu4tztuj1SFS3RxmuUdJHpcewNkCWHu7jTsB08pGLXLh3CYFSg
         HdH2OyYAGyx5r/XzECodWbUCSs5p88qXDtk8XCb51qSN+fMoGXY47W7xCJ7nRlzKuaHN
         cL+qfPfAkDKzgA+ekkgXOYZPBF4GJXig61yYeSTPfbSEjcfj07HKvBZfzelckoLlZrIT
         542gjQDboXeQiqswZDOzS5bmXIX7yLkhQOTHznqaGjHkd2uPabuhQRyH+EdTIy71fREd
         LeJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to:sender
         :mime-version:dkim-signature:arc-authentication-results;
        bh=unN+gv20x95QZ4ydt5yq1sLpd4Wz1GSmDLfENlAEqqE=;
        b=ehnVDWHZuSwqsxLvT7kud7Yfnnq1sjjbHtghgORzk7fZaTj3yrZqHR9J/Fu8fzaUUh
         4Q4EGB/U3SN+7YGAcIHUuLnRm6+PAteBIr9AIAViplYJJ+SEtjzMIvTONTpK7ALaGkhr
         v3nCjUyEi53Wq/AfGv23uuLF6q73iMNy4UGrCeoUPhdBOMWBklsQ3nWRwj8RJEHSV5io
         8HGc6zuiAPI0/7bJeTzFXjXEFA+1JNJ+E8CkszoUdVovugqwxOkXQha9qpFOFMnHUk+S
         B7Q1k4zsidoWQ5OfVdot48n+7s7kilCB2ES1Ua5iVUe3Ol9LLtmzh6aUBJz+mXkGaYCD
         yLSA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=B+nWrtIZ;
       spf=pass (google.com: domain of geert.uytterhoeven@gmail.com designates 209.85.220.41 as permitted sender) smtp.mailfrom=geert.uytterhoeven@gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=B+nWrtIZ;
       spf=pass (google.com: domain of geert.uytterhoeven@gmail.com designates 209.85.220.41 as permitted sender) smtp.mailfrom=geert.uytterhoeven@gmail.com
X-Google-Smtp-Source: AB8JxZqt/dMzPdUjh3PJ7X3q/pJSRklqd+X6TODzFbqk628zMVG7WtOieNHbVO30RaakssFU9cxsnD9POmjJBZYcDCQ=
MIME-Version: 1.0
Sender: geert.uytterhoeven@gmail.com
In-Reply-To: <20180502195138.GC18390@sasha-vm>
References: <20180501163818.GD1468@sasha-vm> <CAMuHMdWNFz_9OpddZ6tTaQcNVH01pkhwd0+3Z31uDcZvbkV6Ow@mail.gmail.com>
 <20180502195138.GC18390@sasha-vm>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 2 May 2018 22:41:56 +0200
X-Google-Sender-Auth: io3Tu1cNU5vsN-zODbCVn8ub5z8
Message-ID: <CAMuHMdW_i-KQpqMz0zsz77tRcE-Sron5zAyh0SHAOJ5ap7x60w@mail.gmail.com>
Subject: Re: bug-introducing patches
To: Sasha Levin <Alexander.Levin@microsoft.com>
Cc: "ksummit-discuss@lists.linuxfoundation.org" <ksummit-discuss@lists.linuxfoundation.org>,
	Greg KH <gregkh@linuxfoundation.org>, "w@1wt.eu" <w@1wt.eu>,
	"julia.lawall@lip6.fr" <julia.lawall@lip6.fr>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1599280464106480109?=
X-GMAIL-MSGID: =?utf-8?q?1599386385540079461?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi Sasha,

On Wed, May 2, 2018 at 9:51 PM, Sasha Levin
<Alexander.Levin@microsoft.com> wrote:
> On Wed, May 02, 2018 at 05:32:37PM +0200, Geert Uytterhoeven wrote:
>>On Tue, May 1, 2018 at 6:38 PM, Sasha Levin
>><Alexander.Levin@microsoft.com> wrote:
>>> Working on AUTOSEL, it became even more obvious to me how difficult it is for a
>>> patch to get a proper review. Maintainers found it difficult to keep up with
>>> the upstream work for their subsystem, and reviewing additional -stable patches
>>> put even more load on them which some suggested would be more than what they
>>> can handle.
>>
>>Thanks for your work!
>>
>>>  - For some reason, the odds of a -rc commit to be targetted for -stable is
>>>    over 20%, while for merge window commits it's about 3%. I can't quite
>>> explain why that happens, but this would suggest that -rc commits end up
>>> hurting -stable pretty badly.
>>
>>Aren't more -rc commits targeted for -stable because they are bugfixes?
>>Ideally, new features are supposed to be merged during the merge window,
>>while -rc commits fix bugs.
>
> new features can only be merged during a merge window, bug fixes can
> be merged at any point.

I wrote "ideally". There's a big difference between theory and practice...

>>So they can be categorized like:
>>  1. Plain -rc commits,
>
> What's this exactly? -rc commits are only supposed to fix bugs.

... hence not all of them are fixes.

Sometimes fast-tracking a new feature or API reduces dependencies for the
next merge window. This is just one example of IMHO valid non-bugfix
-rc commits.

Between v4.17-rc1 and v4.17-rc3, there are 660 non-merge commits, of which
  - 245 carry a Fixes tag,
  - 196 carry a CC stable,
  - 395 contain the string "fix".
(non-mutually exclusive)

That leaves us with 200 commits not falling in the bugfix category.

>>  2. -rc commits fixing a bug:
>>       a. in the same release cycle,
>>       b. in a previous release.
>>
>>2a assumes the bug was backported to -stable, too, doesn't it?
>
> Bug fixes for features introduced in that release cycle won't be
> backported to stable.

They do, if the original commit was introduced during the same cycle and
backported to stable.

>>Do you have statistics for which categories are most buggy?
>
> I haven't broken it down to subsystems for a few reasons:

I didn't mean break down by subsystem, but by category from the list above
(1, 2a, 2b).

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
