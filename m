Return-Path: <viro@ftp.linux.org.uk>
X-Google-Smtp-Source: AB8JxZpJvWxBJSAs8yMZVJEp4FlJqIu9etCts2wlQZCAbCA7JZwPyAupDEacV25RD9DFMdXidveE
ARC-Seal: i=1; a=rsa-sha256; t=1525366493; cv=none;
        d=google.com; s=arc-20160816;
        b=V9S5v0jQHYVj8UrJLXR+WBACz14By9sCmsHs3EpuZuMm9+eCj57Lt5c3Tak/19tYTI
         bCdOoxcjbRJIoZ8PslexJK7is1vyUyVZbcjxvzTBLXjTZVKZoeQbOhou/sHaTheACXWs
         qmnFddecOCsUbWVm8EQnrG1x2pS72yzBK7VB9dHv3Ax1pHvhaN1nLRhBbkjKABpMUwHh
         JY+CuZYcOa6OQLgEwlT6cd7p2mose4MMAhMEWiy1Qb1ImyVshkBMB87BduDeLJ/WS8pq
         evfelVZOMa2jt/HhJAyTR9Pa9A0CX0FJIv/f+ETWe+nGb56APIp9eZRd+embNthp6XKO
         8BNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=sender:user-agent:in-reply-to:content-disposition:mime-version
         :references:message-id:subject:cc:to:from:date
         :arc-authentication-results;
        bh=RKddDSPc36dmBa1eVS8gEu5u/87bY6paP9Q4MWSqnaI=;
        b=EuUJX2C8aTWJydpFHgxPbP0MZFubMjZ1xdA5LoTGilN25WBOI5oSfWuFuUIXwbiSAk
         B4/M+OO28JJlk4edtjBGMmCwhg6X3Ko5gaUagmaelcXbBfyGIlVfcCnh9n1GoLLVGYQy
         obyL/zBE6cE4B7Y91jixGUZ8x54pmNxQB1rIn78wxSlIr7tdO6PHqi+fizEXqomDUR6R
         GYEe+nXZ7ZCat85Fa8hQdMYRZ+ViFvc3SS4Y1FjwDC9Q5a9agVaQNp/UIGYNe/PZrRtd
         4raIPVd88fMzqE57TEhXH+Ga9OnKX1BpCbxFfd0mt2eHIpcUbnWV1kor1UIlGorxnCRM
         FzNQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of viro@ftp.linux.org.uk designates 195.92.253.2 as permitted sender) smtp.mailfrom=viro@ftp.linux.org.uk
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of viro@ftp.linux.org.uk designates 195.92.253.2 as permitted sender) smtp.mailfrom=viro@ftp.linux.org.uk
Date: Thu, 3 May 2018 17:54:46 +0100
From: Al Viro <viro@ZenIV.linux.org.uk>
To: Sasha Levin <Alexander.Levin@microsoft.com>
Cc: "Theodore Y. Ts'o" <tytso@mit.edu>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Greg KH <gregkh@linuxfoundation.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"w@1wt.eu" <w@1wt.eu>,
	"ksummit-discuss@lists.linuxfoundation.org" <ksummit-discuss@lists.linuxfoundation.org>
Subject: Re: [Ksummit-discuss] bug-introducing patches
Message-ID: <20180503165446.GB30522@ZenIV.linux.org.uk>
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
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: Al Viro <viro@ftp.linux.org.uk>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1599280464106480109?=
X-GMAIL-MSGID: =?utf-8?q?1599462696379704986?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, May 03, 2018 at 02:46:14PM +0000, Sasha Levin via Ksummit-discuss wrote:

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

I really wonder how accurate your interpretation of Fixes: is.
Consider e.g. the situation when an old bug is found and partial fixes
applied.  Then we find that those fixes did not cover everything and,
come next cycle, add more on top of those.  Where should Fixes: on
the incrementals point to?  Original commit?  But they won't apply
without the first batch.  The last in the original pile?  But it
would imply (by your metrics) that original fixes had *INTRODUCED*
bugs.

Moreover, what the hell do you suggest in situation when
	* foofs_barf() is b0rken in quite a few ways.  There's an
easily triggerable memory corruptor that can be fixed locally as well
as something else that needs a change of e.g. ->mkdir() calling
conventions to take care of.  The change is mechanical and fairly
simple, but it's already -rc4.

Even though the whole thing is well-understood at that point,
we *can't* apply all 3 - it's too late in the cycle for the
calling conventions' change in the middle of the series.

Should we apply the first fix that cycle, or should it slide to the
next one?  We can't apply #1 + #3 --- #3 won't even compile without
#2.  We can't apply #3 without #1 --- they can be transposed, but
it's nowhere near a mechanical transformation.  So WTF should #3
have in "Fixes:"?
