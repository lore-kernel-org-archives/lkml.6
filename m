Return-Path: <jwerner@google.com>
ARC-Seal: i=1; a=rsa-sha256; t=1521062535; cv=none;
        d=google.com; s=arc-20160816;
        b=i+w0nSr5sq+bZXVwvzbjrZ5GQ+fUGC4konE+pW1liAQu+MM+PRr447CEO66YONT+dE
         AY2RHramX6RPXHIiMHGJIVfxpgGxWuo1kBKX41D1wX4d3XHb+aNyOs6B8jtnjdjwPJl4
         WeWXpZgCfwrbLONENYvNrW6gof19Y5fkX+80mQIxPFLCfsq+wkKUIFqpv/ii3FgtseX3
         vDqfcLXNQmeoA8HM6cJ3BRN6Bg7o8/XsDOKDKXR0lgJRtdUGxed7EYnBZ8z2Hm2szhPn
         r7F21hI5mrvLtAZ81T+80dMqHgGyTirW1Sn9N9PgVsUlrMawIMLVUDeWfcqRpjxpL55m
         rLFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature:arc-authentication-results;
        bh=Rg+ydLWDQsuZ/b8mPgQTS+QdBzHhwH0YTlMmCurQxHE=;
        b=aMcR5M3QRJD89MVH7swyp61EYm7eBWSFZCvj6JgNWfpTslvNKj+t+9ULNb+vZT62SX
         IJsO/OAFQ5bxW6dTVvJU9eHVmOdQWpDED1c6LJFbK9QLlnkIu91O0diuCADLQLnu48mG
         1zT0tdpp3oz5eJKb0+gU4JevotXIl6fzKYNOVUWvCd7YkMDsP+LXotvnZnC9bFU8UDvE
         taRdnighNTNWCDyTjxvIACOkgnSNusxKINUVOAxBR4rt7QrlyNuww1sZQ5OOWLy+8OjU
         Lp7iuaNjOkCwd4k1w+cJufHcX7mFeU8yR3gb7oCT1lkVhQFebM7PtfN7HIUst+CxMxVM
         n6xw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@chromium.org header.s=google header.b=e/syL7Z3;
       spf=pass (google.com: domain of jwerner@google.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=jwerner@google.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=chromium.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@chromium.org header.s=google header.b=e/syL7Z3;
       spf=pass (google.com: domain of jwerner@google.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=jwerner@google.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=chromium.org
X-Google-Smtp-Source: AG47ELsxwy/9yNSrREoPuOyMI2NfjkwqdrD46HPtaQjZt69f6nbiQOMDhuAZtxXTHzFOH7GXABQ7ONLQFCERcapkaq0=
MIME-Version: 1.0
References: <20180125014120.20851-1-samuel@sholland.org> <20180314180830.GA6311@kroah.com>
 <CAODwPW9gbZgFKs6_Lc_oD_pPgGa1nUSdM2p0k8o9Mygx9d+HJw@mail.gmail.com>
In-Reply-To: <CAODwPW9gbZgFKs6_Lc_oD_pPgGa1nUSdM2p0k8o9Mygx9d+HJw@mail.gmail.com>
From: Julius Werner <jwerner@chromium.org>
Date: Wed, 14 Mar 2018 21:22:04 +0000
Message-ID: <CAODwPW96LfXRbLFkX9OAUV7DH9t1MPogqvUUrCExrzk00Vy4_w@mail.gmail.com>
Subject: Re: [PATCH 0/5] coreboot table bus and framebuffer driver
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Guenter Roeck <linux@roeck-us.net>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: samuel@sholland.org, LKML <linux-kernel@vger.kernel.org>,
	Coreboot <coreboot@coreboot.org>, Julius Werner <jwerner@chromium.org>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1590526722620328845?=
X-GMAIL-MSGID: =?utf-8?q?1594949669376091564?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

[resend in plain text]

> It would be great to get some of the google developers to ack these, as
> this touches their code...

 From the coreboot point of view I guess we're fine with it since it claims
to maintain all of the existing functionality. It's just changing the
kernel-level plumbing for these drivers and I don't really have the
expertise to comment on whether this is better or worse than the old code
(maybe Dmitry or Guenter will?). It seems a little odd to me to call this a
"bus", but if we think that's the most fitting abstraction the kernel has
for it, I'm okay with that. All I care about is that it will work (in all
combinations... e.g. regardless of probe order and even if some parts are
compiled as modules and loaded/unloaded at runtime).
