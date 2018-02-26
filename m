Return-Path: <linus971@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1519675654; cv=none;
        d=google.com; s=arc-20160816;
        b=XnjDlVzU9aYzn7r4gpm5vNtvK+gU/0nT3Oo7MTaMAeJR7vXjNPunJKxmlVHZe0HR3e
         kS2cRU1Ax99yqUopiP7+XHECDmNHIYePdq63vjiDueNQQb4j+pnFWyesN9otGdQ1wEpU
         LmfTc6dsBGS0/e3eL3AWreg5gIvjOTnVBkopaRFo04yJ9vvDSxPfWYByawv6niV7eAjY
         wr9J/MpC+j6A3F8VUcH9TPT5c8Ta1V00Aw7GS+R/48FiMU9qIMzUeOvR6uML+1d8TY9m
         8EPOhHgS88KOXsC4oWoSWx50mIaaNCCdOZXujuzTGOSYqeZp9YGqv+f9vvR2r0YwdILx
         HBmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to:sender
         :mime-version:dkim-signature:arc-authentication-results;
        bh=m+yFnWNJjKgD3hhwdiibbQT0B70kvKxep3LDrtqhcec=;
        b=fJA+crWnP6eSILhThD/wu8XvknVAIHX5macy4PIgDVkgmp5BIE/h85eV7+Ev+lZc4P
         9XdjFuGBoTmkdeweYkCtPnNrZMTY90dO+hce+grT6d53iy+DQX3Lk4yZ7SwQ5bEVN17O
         LxZ1q42tLmzV/01ULxQmBrFYMZ0qt29WG/NfGloWmTSLKa1tObFdkXEDaSO+tiwJVGyH
         cSrebz881fokTSj/If01uQTFpDCrWcko4sBwywUjNrsSKg6s2PvT+RnavA0wYc+fc4JM
         jQR/U5PSGiafU8I88VCPy6yFWfpXG//pUWyBjTNBSMdUld/dcTnr38l5SoLQQXgB7q8I
         PiHQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=GOuY0tdU;
       spf=pass (google.com: domain of linus971@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=linus971@gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=GOuY0tdU;
       spf=pass (google.com: domain of linus971@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=linus971@gmail.com
X-Google-Smtp-Source: AG47ELuIdDvDht1sYBT0orK7x3L3oxXdVMEJcxCdfzmIIhVYyvxh4l7y/aaGX/jySGNzyPHovvO0oyEckGBXJkXNKI4=
MIME-Version: 1.0
Sender: linus971@gmail.com
In-Reply-To: <alpine.DEB.2.21.1802261358090.1896@nanos.tec.linutronix.de>
References: <alpine.DEB.2.21.1802261358090.1896@nanos.tec.linutronix.de>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 26 Feb 2018 12:07:32 -0800
X-Google-Sender-Auth: 4-rP3Zng7SH5538kNsqo0mVlybo
Message-ID: <CA+55aFyJstnk9Ne-=0Stbo6dPo0nDnkGNJMPEMhP9TdDZ5xeqw@mail.gmail.com>
Subject: Re: [GIT pull] x86/pti updates for 4.16
To: Thomas Gleixner <tglx@linutronix.de>
Cc: LKML <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@kernel.org>,
	Greg KH <gregkh@linuxfoundation.org>, David Woodhouse <dwmw@amazon.co.uk>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593470100080212890?=
X-GMAIL-MSGID: =?utf-8?q?1593495418944947697?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, Feb 26, 2018 at 5:25 AM, Thomas Gleixner <tglx@linutronix.de> wrote:
>
>  - Teach objtool about retpolines and add annotations for indirect jumps
>    and calls.

So now we have that

  drivers/watchdog/.tmp_hpwdt.o: warning: objtool: .text+0x24:
indirect call found in RETPOLINE build

upstream.

Is the hpwdt de-crapification patch that was quoted in the discussion
about this monster lined up somewhere?


               Linus
