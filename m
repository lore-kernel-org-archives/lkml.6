Return-Path: <kkamagui@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1519811326; cv=none;
        d=google.com; s=arc-20160816;
        b=nfTFChqkwT3VyT8d2mbJeKGwG7WIFkHctBpvGq9rGYr/yk5BfVqAMkNba/euebXcL3
         RWyMIHqYdMLf+62gPFDdAgqpZVhAJZpz3RhBaAYo2/MHO+bOF5TIgZd9oJGZWyGA6K9y
         teRhuxKk//OMzGBrpxhaDRlW+Ezbgb1tjqSlWcf2l4CTVNiAtAthP9/3og3/N7m8JTgq
         WuglzHDEpVRyQOhW4+tDfl1CudbEsEShHjcwc3TJX4XyBo+4AeXUinDj+vZNkV6kcQky
         6ovl0ThiAsm4EkkHRBB2m8RbRPxWdgmmBKZf8Jl/4iBvONOrPmE3/XxRCCic337MJmF7
         WQHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:dkim-signature:arc-authentication-results;
        bh=O/CmAOqFlD2mZpT5KYuKYAOozTIwr43WLUrNUQW5yVY=;
        b=ZAvMqK3UuJPRQooWW/e6HRMsCM/rTFWXTTe8QI255N4Yz20QYOlYVyZgxpor5zTFVB
         HgpPIW25dSg4YvgC6xOySfScozmqVnYUDYRSvX47kD20Ikj1XDxqlhwdADtyjB8H18uD
         Y8XvNLeAES8kGRceSUgtZv+UsoQukORLtvN8fTpwa7qwKeaDSFMlD2MSfil0DWasq8kw
         OnX2j8ufsFwlp00G0u1dchJSSdO08Z8ls/rbu1JiuE/gecpfZEExGE60mt/0nJFmElTr
         ajVbbt+5hYy+huaHMcq0xJ56wRQs0uDAYlJ4jlGMmESncKbiN9eBVx+q0VsJRTWfOZWp
         Cwsw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=gkOJtJ3E;
       spf=pass (google.com: domain of kkamagui@gmail.com designates 209.85.220.41 as permitted sender) smtp.mailfrom=kkamagui@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=gkOJtJ3E;
       spf=pass (google.com: domain of kkamagui@gmail.com designates 209.85.220.41 as permitted sender) smtp.mailfrom=kkamagui@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
X-Google-Smtp-Source: AG47ELuCvUkjqgWUVkMdtYEd/0dla97AHhMDqq0mws6zdLpGKw0ZevBwvY0k/93DWkOBckfn0cuUdLLeuecDMDLDBew=
MIME-Version: 1.0
In-Reply-To: <20180228093238.GA3769@pd.tnic>
References: <20180223101350.8344-1-kkamagui@gmail.com> <20180223105220.GA12058@kroah.com>
 <CAHjaAcTVUxm6LnD_3sp2BwGgR9ustuctoHUBFkMD1nZh4o6bTA@mail.gmail.com> <20180228093238.GA3769@pd.tnic>
From: Seunghun Han <kkamagui@gmail.com>
Date: Wed, 28 Feb 2018 18:48:45 +0900
Message-ID: <CAHjaAcT2s0v8cZ4dvGZMVOZHzk=2-LpthC2umw7-FfjfsJczjQ@mail.gmail.com>
Subject: Re: [PATCH] x86: mce: fix kernel panic when check_interval is changed
To: Borislav Petkov <bp@alien8.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Tony Luck <tony.luck@intel.com>,
	linux-edac@vger.kernel.org,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593186374882748310?=
X-GMAIL-MSGID: =?utf-8?q?1593637681558053776?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hello, Borislav.

2018-02-28 18:32 GMT+09:00 Borislav Petkov <bp@alien8.de>:
> On Mon, Feb 26, 2018 at 05:05:04AM +0900, Seunghun Han wrote:
>> >> It is a critical security problem because the attacker can make kernel panic
>> >> by writing a value to the check_interval file in userspace, and it can be
>> >> used for Denial-of-Service (DoS) attack.
>> >
>> > As only root can write to that file, it's not that critical of an issue,
>> > but yes, this is a problem.  Nice find and fix.
>
> This is still the wrong fix. You need to:
>
> 1. check the old value of check_interval in store_int_with_restart() and
> exit early if it is the same.
>
> 2. have mce_restart() grab a newly defined mutex, say, mce_sysfs_mutex
> or so, which synchronizes all CPUs so that their timers get deleted and
> reinitialized in the proper order.

Thank you for your advice.
I will change my patch like that and send it again.

Best regard.

Seunghun.

>
> Thx.
>
> --
> Regards/Gruss,
>     Boris.
>
> Good mailing practices for 400: avoid top-posting and trim the reply.
