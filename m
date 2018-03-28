Return-Path: <maco@android.com>
ARC-Seal: i=1; a=rsa-sha256; t=1522228015; cv=none;
        d=google.com; s=arc-20160816;
        b=oOG0pZqhvxxoZ1WoPNybPe8O4Hc4Wc0+oif61M0AQnwzn1FKkmg58+x9gj3joRTniC
         sf7NOiad6usHwNVMDv5R064N2xXJmxSgBQ9jchS3zQpSOLraenJvMceye+dqU11STbfd
         U1wU4FvKOkBH4e5ehvn3Jk1gxiVb8oga5JGMiLTY1HHR24J1TSqhgLh17FgygNpeloXD
         cYavDCDW2lkqrPlIlG/WGOiDl3MHWAdZEj4SfTRMprUNPeLn79dmD+kHvpAX+DZ4FYLq
         en0uFBc6ODW0+lzL0rNRFsfQVcUgF2bzNo6Z2mq6Ml6lpfYBWP2hrEdXEzPeCGvm4aci
         2PLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:dkim-signature:arc-authentication-results;
        bh=J4FrttoojxCExM+bGN+3fLFR6Kg3qqShZLuK4o8whhc=;
        b=vocUCdVzKnvsUDx91LKCbQfLmxLog/N9IwHmbeEeWj+4yRVa/npjHg20Iur5bW12Fz
         6kwNiV0Vi9e1JWs32/LcdYxtRXq6mtFqPBZEmBAHdQJbKFIEzqEY1LjQdLpS7jKcdMTk
         Ubv9JrS+Q7Ny3pHEkuXqLaie5nGnSorCy0UANVcyJj/bctmHQGAsLaNjGKl+0gbJkvUd
         nMutEgBN1HA0H8sy0qDVwOa6GGoRY3EmIspySGx5PdQfK6yAokFXXs+LU/hYW7KE88Rx
         IxOc+jsXC+PZCS9K5XPkDH9Rd5NuUSUd9xyuz4ufTVN4Jf5T39Hiy0zyhundDbn+GYM9
         hp/Q==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@android.com header.s=20161025 header.b=CWP162o6;
       spf=pass (google.com: domain of maco@android.com designates 209.85.220.41 as permitted sender) smtp.mailfrom=maco@android.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=android.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@android.com header.s=20161025 header.b=CWP162o6;
       spf=pass (google.com: domain of maco@android.com designates 209.85.220.41 as permitted sender) smtp.mailfrom=maco@android.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=android.com
X-Google-Smtp-Source: AIpwx484UAc3TQE4FVO4KRHx5zeTWLn6dVl09tZiMcvitGfr5Me92iI4VkIrdy3Ia+n5OS9WhaFv/jHcSbDroDHdcVE=
MIME-Version: 1.0
In-Reply-To: <20180328081921.GA14201@kroah.com>
References: <20180328072903.155938-1-maco@android.com> <20180328081921.GA14201@kroah.com>
From: Martijn Coenen <maco@android.com>
Date: Wed, 28 Mar 2018 11:06:54 +0200
Message-ID: <CAB0TPYF_zs=rL5qQ=C737rBVx_Z0utaihJhv9dnRqvpJ0sp7Hw@mail.gmail.com>
Subject: Re: [PATCH] ANDROID: binder: prevent transactions into own process.
To: Greg KH <gregkh@linuxfoundation.org>
Cc: John Stultz <john.stultz@linaro.org>, Todd Kjos <tkjos@google.com>,
	=?UTF-8?B?QXJ2ZSBIasO4bm5ldsOlZw==?= <arve@android.com>,
	Amit Pundir <amit.pundir@linaro.org>,
	"open list:ANDROID DRIVERS" <devel@driverdev.osuosl.org>, Martijn Coenen <maco@google.com>,
	LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596165622257812617?=
X-GMAIL-MSGID: =?utf-8?q?1596171763796735601?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, Mar 28, 2018 at 10:19 AM, Greg KH <gregkh@linuxfoundation.org> wrote:
> Does this need to go to older kernels as well?

Yes, this should apply cleanly to 4.14 as well. It won't apply to
pre-4.14 kernels because of the fine-grained locking changes, but the
same issue exists there and I suspect it would cause the same crash.
Do you want me to send a separate patch for pre-4.14?

Also, I'm going to send a v2 for this because it can be a bit cleaner
(avoiding a deref).

Thanks,
Martijn

>
> I have a script that picks up everything the syzbot finds and tries to
> backport them, after they are applied in Linus's tree.  Might as well
> catch things before we have to rely on my script :)
>
> thanks,
>
> greg k-h
