Return-Path: <w@1wt.eu>
X-Google-Smtp-Source: AB8JxZqjjKA1y3Xaw935hfgb6eaBgUV3yW8PJU0X+u3wcgR3Bv9xb7VmIjsVfwTbljTfRtqV7AsJ
ARC-Seal: i=1; a=rsa-sha256; t=1525363259; cv=none;
        d=google.com; s=arc-20160816;
        b=EyEtk1B4QDKhYqQ2u+iBLdudHVrBBAMiwPHapEX7VIKZ6x3btXn188FpB2FforA8Zg
         KG//6rvaRQ7Rq6/cKkjLP1W53duYKOBnTkNBk3kfsG0UV9V4AdlcCEOZiYwavqLj3rDS
         JSnCuWCGySU1dNG2zzSzoGWaQL3+iq2iULUwjLQPraBRvXwOCw6kuDa2L/qVc3R9BRvU
         83cbTX14sdEe737JabNQ4cTYsjDAS8vGTlaeHeNsW2Y4cXe4IFPYiwK7gXqIHzBlr3Xw
         Dr40d9lrAfKLoU0I4EJrOR1aiYARvnf7vY6VxM6yI3R3RZt/XOj4PkrrM/nhZlIOReQG
         nUjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:arc-authentication-results;
        bh=Vf7Kl4FqsCTWSiKD9kdMxWcItuMHh7ct76Hpj10Aa1Y=;
        b=PtWhK4nEp6QgNRDAQ9vhh/mMTO3EdIBr5gSgBW1vKbD6yFSiHXCMZPZOEWEbuLbT0i
         gcP5lWxOhydQ3iZCeONyk4dG0JNYitLseXce1CZx4MExRcNSTzHrFh3SqxoeH7IO0KKW
         KlqpvZJR9G3CbZMYm7igQxmZLnCFCX+jHQ+TpCYWkAFigeKjZdHNlwgijuLEoCw3ifOl
         ey/jy96Z7NdIdtcz9WPD5Q8Vfedn0NXPGgVbVJbh++54rAZP7sDktYRMrH0YJ4FQyMkw
         U0SfauFp1Jv44ocdo/H0xG9qvUFKnHGzt4cjmiegL/fsjo7c+c4UdHP5mWIhXLfqNVeQ
         nt1w==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of w@1wt.eu designates 62.212.114.60 as permitted sender) smtp.mailfrom=w@1wt.eu
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of w@1wt.eu designates 62.212.114.60 as permitted sender) smtp.mailfrom=w@1wt.eu
Date: Thu, 3 May 2018 18:00:46 +0200
From: Willy Tarreau <w@1wt.eu>
To: Sasha Levin <Alexander.Levin@microsoft.com>
Cc: "Theodore Y. Ts'o" <tytso@mit.edu>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "ksummit-discuss@lists.linuxfoundation.org" <ksummit-discuss@lists.linuxfoundation.org>
Subject: Re: [Ksummit-discuss] bug-introducing patches
Message-ID: <20180503160046.GH23311@1wt.eu>
References: <20180501163818.GD1468@sasha-vm>
 <CAMuHMdWNFz_9OpddZ6tTaQcNVH01pkhwd0+3Z31uDcZvbkV6Ow@mail.gmail.com>
 <20180502195138.GC18390@sasha-vm>
 <CAMuHMdW_i-KQpqMz0zsz77tRcE-Sron5zAyh0SHAOJ5ap7x60w@mail.gmail.com>
 <20180503000620.GA29205@thunk.org>
 <20180503144612.GJ18390@sasha-vm>
 <20180503145205.GD23311@1wt.eu>
 <20180503150104.GL18390@sasha-vm>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180503150104.GL18390@sasha-vm>
User-Agent: Mutt/1.6.1 (2016-04-27)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1599280464106480109?=
X-GMAIL-MSGID: =?utf-8?q?1599459304570597769?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, May 03, 2018 at 03:01:08PM +0000, Sasha Levin wrote:
> On Thu, May 03, 2018 at 04:52:05PM +0200, Willy Tarreau wrote:
> >I wouldn't be much surprised if you'd find that among those not introduced
> >in the current merge window, many were introduced in the previous release.
> 
> Interesting. Here it is for v4.16-rcX fixes that fix something
> introduced before v4.14:
> 
> rc1 30
> rc2 87
> rc3 51
> rc4 68
> rc5 23
> rc6 113
> rc7 61
> 
> So I'm not sure if what you described is really the case.

This is rather interesting and probably deserves some analysis or
explanation. I agree that probably a number of the 61 fixes in rc7
could have cooked a little bit more if they fixed 5 months-old bugs.

Willy
