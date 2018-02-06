Return-Path: <tedheadster@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1517945099; cv=none;
        d=google.com; s=arc-20160816;
        b=vl6K6vy+/P5g3g+5lP+Y+UDO2JzX2DB0+VCJTcHKn3y7bY/uBuipUSD3UNyoWsdC4N
         zcH+zVZ6YC9IVTJ9nCt40zDAbbE5fHvnNDoOGiMB+hNcfRhRjUdH7bY2qYpxKJRRn4al
         45Y7vwiYOr6jnAelEH2gKIBoqUX1zm+a2mKIaUsGJfMo+oLUa2Sw/AzqvaW5qYV9QLth
         hxY8hI9Z24/H/pl7KAn7DNJy3m8hN4Gb7YEWSTZa5MN29ULIhoGRn5jS7L/BhY17F8dG
         ZoIKOIltXe/x4hvHZ94ec/AfIWFFKMv3BUrsGMSrWCuZLkrzLVreB7yLPbYKVpvmog6U
         a6uA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to:reply-to
         :mime-version:dkim-signature:arc-authentication-results;
        bh=S9IHxfbXipoQd1EuVnL8S1qc5D9W80L7oMJMgx4hV7A=;
        b=xbgwvOHfGf4CfX1+olGkhDfJPuLAndRgwvZx35FeqQTkPvC+scnjIbMUO1v9WGzvuN
         g8Yd0NXG527APkzNL0KaKuYf3pytzleQmCoQbI6oY+3gpduGEpVWVnrRNVbzK2QqzgPj
         DqP8vPxry62GmygxTHCdWKB6q5RrGwhT1m8E6IQPgmXX3jxZlPVRk9lhiPDcSkozkNzM
         DfFB0C866Liw30VYtq3c1JuSbI7MyoCzXJWtKFiE6TV5CCOnt5MzJ1iLVoxiLl6Q7H5Z
         HJ5OMj/gW58HD0UciuXDqxftjtII6ZB9yywv+8Y/GZDpgwp81syhp6y0apumkAGYoYIn
         4drA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=t52OScfZ;
       spf=pass (google.com: domain of tedheadster@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=tedheadster@gmail.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=t52OScfZ;
       spf=pass (google.com: domain of tedheadster@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=tedheadster@gmail.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=gmail.com
X-Google-Smtp-Source: AH8x225UK7XOjAksZUPKRIzoOitPOYVeld4R/me08dhVZJTtKNWIGTrWYHvqPPzSlcDW0QxBfC5Riu7gC9Lb3GBg1l4=
MIME-Version: 1.0
Reply-To: whiteheadm@acm.org
In-Reply-To: <1517944648.3677.18.camel@infradead.org>
References: <CAP8WD_YnJnQW9o+t2jn6HRrY3kKQMRD44joP=thPYO5vS4ev7Q@mail.gmail.com>
 <1517643438.31953.108.camel@infradead.org> <CAP8WD_Yrp5g6YZwV+XQTx93YpTakWEL8MD+p0bZDaPi3-r88JQ@mail.gmail.com>
 <20180206190233.GA10476@kroah.com> <1517944227.3677.15.camel@infradead.org>
 <20180206191355.GA7424@roeck-us.net> <1517944648.3677.18.camel@infradead.org>
From: tedheadster <tedheadster@gmail.com>
Date: Tue, 6 Feb 2018 14:24:38 -0500
Message-ID: <CAP8WD_Znj+zG6hVD3zV+9tTJs0OEZtbQTy=XGOj3hurtRRXhVQ@mail.gmail.com>
Subject: Re: [BUG] x86 : i486 reporting to be vulnerable to Meltdown/Spectre_V1/Spectre_V2
To: David Woodhouse <dwmw2@infradead.org>
Cc: Guenter Roeck <linux@roeck-us.net>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Hugh Dickins <hughd@google.com>, dave.hansen@linux.intel.com, jikos@kernel.org,
	Borislav Petkov <bp@alien8.de>, Kees Cook <keescook@chromium.org>, Jamie Iles <jamie@jamieiles.com>,
	eduval@amazon.com, labbott@redhat.com, Rik van Riel <riel@surriel.com>,
	Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1591354140743903681?=
X-GMAIL-MSGID: =?utf-8?q?1591680801371521735?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, Feb 6, 2018 at 2:17 PM, David Woodhouse <dwmw2@infradead.org> wrote:
> On Tue, 2018-02-06 at 11:13 -0800, Guenter Roeck wrote:
>> On Tue, Feb 06, 2018 at 07:10:27PM +0000, David Woodhouse wrote:
>> >
>> >
>> >
>> > On Tue, 2018-02-06 at 11:02 -0800, Greg Kroah-Hartman wrote:
>> > >
>> > > .
>> > > >
>> > > >
>> > > > David
>> > > >    I believe I got the patch(es) you mention in in the stable 4.15.1 kernel:
>> > > >
>> > > > Pull x86/pti updates from Thomas Gleixner: "Another set of melted
>> > > > spectrum related changes"
>> > > > (commit 6304672b7f0a5c010002e63a075160856dc4f88d).
>> > > >
>> > > > Unfortunately, the symptoms I reported remain on at least the i486 and i686.
>> > > Can you try 4.15.2-rc1?  Or how about Linus's kernel tree now?  There
>> > > was a lot of spectrum patches merged just this week that were not in
>> > > 4.15.1.
>> > No, for the 486 it *should* have worked. The interesting commit
>> > is fec9434a12 ("x86/pti: Do not enable PTI on CPUs which are not
>> > vulnerable to Meltdown") which is indeed pulled in with the merge
>> > commit that Matthew mentions.
>> >
>> I disagree.
>>
>> $ git describe
>> v4.15.1-61-g7ab5513e4cbc
>> $ git log --oneline v4.15.1.. | grep Melt
>> 3472b3689bab x86/pti: Do not enable PTI on CPUs which are not vulnerable to Meltdown
>
> Ah right, for 4.15.1 perhaps yes. I was looking at Matthew's 'commit
> 6304672b7f0a5c010002e63a075160856dc4f88d' which isn't in 4.15.1 at all;
> that's the commit in Linus' tree where he pulled in the fix. So *that*
> one should have had it.

I think Guenter is correct and I mixed up my linux versus linux-stable
git repository directories. I am recompiling now Linus' tree and will
report back my results.

Apologies for the incorrect information.

- Matthew
