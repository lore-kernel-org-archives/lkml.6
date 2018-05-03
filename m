Return-Path: <w@1wt.eu>
X-Google-Smtp-Source: AB8JxZoVbN0YLb5TRHAKz8VwMULv4YH8DqnE21h5xfyoYGGFxIt55vRLxrwc+F0JLpz+drUyFB0R
ARC-Seal: i=1; a=rsa-sha256; t=1525374846; cv=none;
        d=google.com; s=arc-20160816;
        b=cP94ApnkZMyOet9cPyzxVGJLUBQXyFLmmiipTLWEmDi9ChiO91NrYz4OmmYjOE0RNc
         6scsitjDL/5NDExuRi/M7oPPkd+sL1fGdfwwm3Su1SqL6GGZig5UOmv03zo93UWQYf5x
         4+jxfZGPNS8ELoDbqIUuV06HVzAA9p/vAtVowKrlq7Z45BLAzq7v1LL1rCLpZz5EIAaR
         VldtgCTcL3KPPfTIHs4PMN2AxmCAoMnktMzsIs5ZXVAi8KOEwHP5El507Ur9U6ezvyC5
         LgZ09rsMhyUmOP9oO6aYX+BP4/6qymnB/BdcVoJmNs/OdG7yeLJ7wI62JoDbJXO8aH2g
         3bYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:arc-authentication-results;
        bh=4rzowIYHxjpnbLp5lm0fdTLXLyUEjBEJ2Cfg+0VfD4c=;
        b=d+4Q65xofXxVY9Vyr+KeFxVMvIpAPcMH3NyOEx39bJn45vZB8NB2yUjfBTRVOfytIJ
         SWfpuOWRATzuCZfbUEiYbb7IqzSnNKyn4t7yDYtT48qXzZo3KDsTNmTw7iGs9KfCkfpS
         jysP3CIX9nCGnqTHSweCoG6fAUj8MESzc2Cfu+twD64WpFXBu/Mck2IkXO5Er7UkP7Ua
         0M8EqONm5LJj/vccevEe6BVRWYEjxff3wuvBgbO0Z41U+Zb2myupRHKf3xncbeXl0CgB
         SCjkHGckZctl1dxqOmPAAtpDzLs0/43oT6izbJqatybO0WKVTpwyHRZs8ZCkBfQ68d+7
         5ofQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of w@1wt.eu designates 62.212.114.60 as permitted sender) smtp.mailfrom=w@1wt.eu
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of w@1wt.eu designates 62.212.114.60 as permitted sender) smtp.mailfrom=w@1wt.eu
Date: Thu, 3 May 2018 21:14:05 +0200
From: Willy Tarreau <w@1wt.eu>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Al Viro <viro@ZenIV.linux.org.uk>,
        Sasha Levin <Alexander.Levin@microsoft.com>,
        "ksummit-discuss@lists.linuxfoundation.org" <ksummit-discuss@lists.linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [Ksummit-discuss] bug-introducing patches
Message-ID: <20180503191405.GC23467@1wt.eu>
References: <20180501163818.GD1468@sasha-vm>
 <CAMuHMdWNFz_9OpddZ6tTaQcNVH01pkhwd0+3Z31uDcZvbkV6Ow@mail.gmail.com>
 <20180502195138.GC18390@sasha-vm>
 <CAMuHMdW_i-KQpqMz0zsz77tRcE-Sron5zAyh0SHAOJ5ap7x60w@mail.gmail.com>
 <20180503000620.GA29205@thunk.org>
 <20180503144612.GJ18390@sasha-vm>
 <20180503165446.GB30522@ZenIV.linux.org.uk>
 <20180503173422.GR18390@sasha-vm>
 <20180503182039.GC30522@ZenIV.linux.org.uk>
 <20180503185529.GB15247@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180503185529.GB15247@kroah.com>
User-Agent: Mutt/1.6.1 (2016-04-27)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1599280464106480109?=
X-GMAIL-MSGID: =?utf-8?q?1599471455105609657?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, May 03, 2018 at 11:55:29AM -0700, Greg KH wrote:
> Don't care about me for stuff like this.  Fix it correctly and I'll
> worry about any dependancy issues later :)

For me the real value of the Fixes header is to let the person doing
the backport know if they must search when the patch looks irrelevant
at first glance. On old kernels more than half of the patches don't
apply and sometimes you really do not know if the code moved somewhere
else or if it was not there. Fixes gives some clues what to look for
and sometimes about an exact commit to get more details. I've been
quite happy with those mentioning only "3.2+" in it just like those
copy-pasting the commit ID is pretty fine as well. The former making it
easier to skip a useless patch, the latter providing more information.
But in my opinion these must not add burden on the committer. Even some
vague information like "4.4, maybe 4.2" or "oldest one having subsystem
foo" is extremely helpful there.

The dependency chain however matters less because once you start fighting
with a small patch set for 1 hour you can spend an extra minute testing
several combinations or figuring the dependencies in mainline.

Willy
