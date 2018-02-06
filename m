Return-Path: <tedheadster@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1517949956; cv=none;
        d=google.com; s=arc-20160816;
        b=PTKm4YfC/KHLG0aSvrc5wlqzCanG5ZSeQkrSUz+0hduAc9QKmNlmAiCllXsFxpj5ui
         MuCDeWhmVMqP0jxfSI7V1wpy8wSplDswanYeGZQisjLcke52pKTplW55554MWH0u4hgM
         Age0jHDbLhL7nMP+sMs80NMMM0IfHBaEdtKG94PXqYTiNBLmSo+uzXmYQXgxPGKDHuOK
         FC0aVulgcczmmyQq2I+NF5V7pmR4VnGJucdxJDgoL0DcDpUG+uD2SY7b7tUZnwGP43ai
         5ANcoQnNK6nPJF3foVWinW/4+9+RJdoRzqwofKWvUxo45Wu/1zqtjbR99ioKylc4O/X9
         1msA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to:reply-to
         :mime-version:dkim-signature:arc-authentication-results;
        bh=emg1mfnO7LKR1IRVUUlTQ/gh5d1rwxrZstUJoLfsqlY=;
        b=AWDHkWm04RLDvw735D1W+i9vV30rH4m//aZ/YSMj7y4Uu3d4nx17kb6xG7r6ILM0UH
         o7oHBonzsqBPZleaSnppYM5hmqqTEXoOKUs7mbzGBLmkEgs8c9cz9n3+tl4Vy60ZKusJ
         AdhjO+5/JHEYKNYo12bE/mtFx1TYnbzO6fTwxlv5R3yRV9khjv9ZJxvOLsht2bOheWEu
         icEhhTWj18wY1SByhhYVSk5NkuVDBJxlnXhCaLgtlA7fdXunlUvnaD9/Rc4gbQo4svj6
         LVApb2XecK9pDMqRfo4xnEWH30VfveEoPtI5AS7HHe4vv/zLXB1wzx/n9+UDqZ1eMMVJ
         6XBw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=UawN1Nbj;
       spf=pass (google.com: domain of tedheadster@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=tedheadster@gmail.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=UawN1Nbj;
       spf=pass (google.com: domain of tedheadster@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=tedheadster@gmail.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=gmail.com
X-Google-Smtp-Source: AH8x225ZINI8wuTCneUcu/0KcrPBsY9/5OQLBiHHPl/W6pFv+cmUrenYR833DwjJeJj7BymhKFyizThSGdJaL2mFA8w=
MIME-Version: 1.0
Reply-To: whiteheadm@acm.org
In-Reply-To: <CAP8WD_Znj+zG6hVD3zV+9tTJs0OEZtbQTy=XGOj3hurtRRXhVQ@mail.gmail.com>
References: <CAP8WD_YnJnQW9o+t2jn6HRrY3kKQMRD44joP=thPYO5vS4ev7Q@mail.gmail.com>
 <1517643438.31953.108.camel@infradead.org> <CAP8WD_Yrp5g6YZwV+XQTx93YpTakWEL8MD+p0bZDaPi3-r88JQ@mail.gmail.com>
 <20180206190233.GA10476@kroah.com> <1517944227.3677.15.camel@infradead.org>
 <20180206191355.GA7424@roeck-us.net> <1517944648.3677.18.camel@infradead.org> <CAP8WD_Znj+zG6hVD3zV+9tTJs0OEZtbQTy=XGOj3hurtRRXhVQ@mail.gmail.com>
From: tedheadster <tedheadster@gmail.com>
Date: Tue, 6 Feb 2018 15:45:35 -0500
Message-ID: <CAP8WD_Ztwp3dLvv+kbQ9QizWHWCwpZnnXxQ++Z0OVnLnaj01+Q@mail.gmail.com>
Subject: Re: [BUG] x86 : i486 reporting to be vulnerable to Meltdown/Spectre_V1/Spectre_V2
To: David Woodhouse <dwmw2@infradead.org>, Guenter Roeck <linux@roeck-us.net>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Hugh Dickins <hughd@google.com>,
	dave.hansen@linux.intel.com, jikos@kernel.org, Borislav Petkov <bp@alien8.de>,
	Kees Cook <keescook@chromium.org>, Jamie Iles <jamie@jamieiles.com>, eduval@amazon.com,
	labbott@redhat.com, Rik van Riel <riel@surriel.com>, Thomas Gleixner <tglx@linutronix.de>,
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1591354140743903681?=
X-GMAIL-MSGID: =?utf-8?q?1591685893792936229?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, Feb 6, 2018 at 2:24 PM, tedheadster <tedheadster@gmail.com> wrote:
> On Tue, Feb 6, 2018 at 2:17 PM, David Woodhouse <dwmw2@infradead.org> wrote:
>> On Tue, 2018-02-06 at 11:13 -0800, Guenter Roeck wrote:
>>> On Tue, Feb 06, 2018 at 07:10:27PM +0000, David Woodhouse wrote:
>>> >
>>> >
>>> >
>>> > On Tue, 2018-02-06 at 11:02 -0800, Greg Kroah-Hartman wrote:
>>> > >
>>> > > .
>>> > > >
>>> > > >
>>> > > > David
>>> > > >    I believe I got the patch(es) you mention in in the stable 4.15.1 kernel:
>>> > > >
>>> > > > Pull x86/pti updates from Thomas Gleixner: "Another set of melted
>>> > > > spectrum related changes"
>>> > > > (commit 6304672b7f0a5c010002e63a075160856dc4f88d).
>>> > > >
>>> > > > Unfortunately, the symptoms I reported remain on at least the i486 and i686.
>>> > > Can you try 4.15.2-rc1?  Or how about Linus's kernel tree now?  There
>>> > > was a lot of spectrum patches merged just this week that were not in
>>> > > 4.15.1.
>>> > No, for the 486 it *should* have worked. The interesting commit
>>> > is fec9434a12 ("x86/pti: Do not enable PTI on CPUs which are not
>>> > vulnerable to Meltdown") which is indeed pulled in with the merge
>>> > commit that Matthew mentions.
>>> >
>>> I disagree.
>>>
>>> $ git describe
>>> v4.15.1-61-g7ab5513e4cbc
>>> $ git log --oneline v4.15.1.. | grep Melt
>>> 3472b3689bab x86/pti: Do not enable PTI on CPUs which are not vulnerable to Meltdown
>>
>> Ah right, for 4.15.1 perhaps yes. I was looking at Matthew's 'commit
>> 6304672b7f0a5c010002e63a075160856dc4f88d' which isn't in 4.15.1 at all;
>> that's the commit in Linus' tree where he pulled in the fix. So *that*
>> one should have had it.
>

Okay, I did a 'git pull' from Linus' tree and rebuilt. I _believe_ I
have the correct patches from this information:

localhost /usr/src/linux # git log | grep "Do not enable PTI on CPUs
which are not vulnerable to Meltdown"
    Fixes: fec9434a12f3 ("x86/pti: Do not enable PTI on CPUs which are
not vulnerable to Meltdown")
      x86/pti: Do not enable PTI on CPUs which are not vulnerable to Meltdown
    x86/pti: Do not enable PTI on CPUs which are not vulnerable to Meltdown

localhost /usr/src/linux # git log | grep -A8
6304672b7f0a5c010002e63a075160856dc4f88d
commit 6304672b7f0a5c010002e63a075160856dc4f88d
Merge: 942633523cde 64e16720ea08
Author: Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon Jan 29 19:08:02 2018 -0800

    Merge branch 'x86-pti-for-linus' of
git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip

    Pull x86/pti updates from Thomas Gleixner:
     "Another set of melted spectrum related changes:


If that is correct (and I might be wrong), then I am up to date and I
am still getting the following in /proc/cpuinfo on my Pentium 4M i686:

bugs  : cpu_meltdown spectre_v1 spectre_v2

- Matthew
