Return-Path: <w@1wt.eu>
X-Google-Smtp-Source: AB8JxZo6IWxCN6usX7sapWmE0w0RnEMAJkGU/12xstIVwzL9arp9cM4MXhIq1b8bK8K5Fr+VZDD7
ARC-Seal: i=1; a=rsa-sha256; t=1525359128; cv=none;
        d=google.com; s=arc-20160816;
        b=KWVqq2NG6kkO41EpsrkTAECH3tF2z1rrKgwNfWYITUjKuq7fLIjzZ5DlDQWTzWyYNI
         poVssaPM2b5H8jf/geaaDgksHKvGGmEbVFf+ldjv2Fdneq6TOfKyNZ7O4iux1HvrpJ/C
         PPo2++Nu2eLlCl2jdBY0km+c3xkcR/4ugwwQ4zqk80iwPBm4l9gijGH2VnsfugFmIU7s
         K4HjBK/lH93JtY6jItgrVxK3HKlj97Sl0vHou5aLehWYKXSUlldV7AHqHvYBRxPsJmxb
         TRjDHf+5bxgO83ikc0M/aBBOyPl6Fn5YjHBHw8HJlSD6BNP7CdBw2fEQ8j5z6hlxj+Jp
         75Fw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:arc-authentication-results;
        bh=lnvLC9mO/Qw8zbbu/g1Jnc3Br7VeB0zKHgGwAcjNhLc=;
        b=VfCnru2QMxWdKZxFOTH9Iy6lWLaDOtke2V00vgyG6iz1yLvye1aaSQ0HLsZpzMuQEY
         Tq+Rwp+cq2/pBO8aJQh08Lp5Rla27+7ZpojUn15wMakKxBlSDPQPiU9IOOARXjeLqyXi
         K2uBrc2/0Azd8YUlSEXMGMvTXna3z7LHIUk9UvORQW0QH5CPM43AAGrlFq2JVRTI37Js
         im3vjShV5/rg4akq5AJ3mNRoBxiLL/0kVqgCrkWDZSIYTD4YG8I8clKSrv9p+Oy1j/Yz
         R1wYVk2hhg+Ck7DgfjO2zFUT9qV5UIMvVjYRuNjxKfHLielu6ODcKOkJ4z5vFVpdsB3i
         MuMw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of w@1wt.eu designates 62.212.114.60 as permitted sender) smtp.mailfrom=w@1wt.eu
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of w@1wt.eu designates 62.212.114.60 as permitted sender) smtp.mailfrom=w@1wt.eu
Date: Thu, 3 May 2018 16:52:05 +0200
From: Willy Tarreau <w@1wt.eu>
To: Sasha Levin <Alexander.Levin@microsoft.com>
Cc: "Theodore Y. Ts'o" <tytso@mit.edu>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "ksummit-discuss@lists.linuxfoundation.org" <ksummit-discuss@lists.linuxfoundation.org>
Subject: Re: [Ksummit-discuss] bug-introducing patches
Message-ID: <20180503145205.GD23311@1wt.eu>
References: <20180501163818.GD1468@sasha-vm>
 <CAMuHMdWNFz_9OpddZ6tTaQcNVH01pkhwd0+3Z31uDcZvbkV6Ow@mail.gmail.com>
 <20180502195138.GC18390@sasha-vm>
 <CAMuHMdW_i-KQpqMz0zsz77tRcE-Sron5zAyh0SHAOJ5ap7x60w@mail.gmail.com>
 <20180503000620.GA29205@thunk.org>
 <20180503144612.GJ18390@sasha-vm>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180503144612.GJ18390@sasha-vm>
User-Agent: Mutt/1.6.1 (2016-04-27)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1599280464106480109?=
X-GMAIL-MSGID: =?utf-8?q?1599454973605790569?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, May 03, 2018 at 02:46:14PM +0000, Sasha Levin wrote:
> I'll work on breaking up the 4.16 commits into categories, but one
> interesting statistic I've noticed while starting the work is:
> 
> Fixes in -rc cycles:
> rc1 68
> rc2 147
> rc3 88
> rc4 121
> rc5 40
> rc6 193
> rc7 98
> 
> Average days in -next, for a fix, per -rc cycle:
> rc1 27.25
> rc2 21.4286
> rc3 22.5114
> rc4 18.281
> rc5 14.65
> rc6 12.6166
> rc7 8.70408
> 
> Fixes for bugs not introduced in current merge window:
> rc1 40
> rc2 113
> rc3 61
> rc4 79
> rc5 25
> rc6 139
> rc7 72
> 
> So for some reason, there is a rush to push fixes for older bugs (that
> were not introduced in the current merge window) to the point that rc7
> commits that only existed for a few days are merged in to address older
> bugs.

IMHO it's because it's the time it takes for users to start to trust the
3rd or 4th stable release of the previous version, to switch to it, to
face a bug, to report it, and for the maintainer to write a fix.

I wouldn't be much surprised if you'd find that among those not introduced
in the current merge window, many were introduced in the previous release.

Willy
