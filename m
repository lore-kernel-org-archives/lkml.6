Return-Path: <geert.uytterhoeven@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1524477591; cv=none;
        d=google.com; s=arc-20160816;
        b=rpgcdptZTBgA0HcQdpE7mtD6AJY48ye3BOLccW9ccCjzLnQboq2xHnV6rah++Ujupu
         tL0JCw1nKDpodsssY0bPQpm6GgqTv8xwjhkjNDz9cRTlJS+fc18LjQ6tl2i21CQ7WUAc
         sgU1I3Nho56AO1FXYbXWpV+lrmZSqDMKJlAFoPQ2GVJSmtcwjN5h9Z+Dye5DZcNg3RKE
         K2IcQtlMfvsncLj6vBcvUgN8LJCMozwrrKrRygaKyYAZ+aAIfKuazjGypYl//WKpIcH3
         yk/r231rO3vM0HFIYcoCTsefAahBaqVQC+R1iZitk5egfXD4+72EU/cqnC0SVSM+U74T
         00rg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to:sender
         :mime-version:dkim-signature:arc-authentication-results;
        bh=ZLq9a9/3WNVgg/AMqK6cMf+r8CaEDExDzKpL638vAuA=;
        b=Jpg6yJK8CYiurrBcq4hPtT/i+C/bH92M4lTRFFxW9gBkog+RmWUpz6ZOsBhhCCTnrr
         94ezKKpAqmft4d+sQfFDAerwsrQ3JniDdduhwa94nvMpO0G1KTPp1hLJL8RTpExaKFbz
         m0yMldTPMkcMZ+QEFQqB6yPqWSURk9SdUuVJKapUrnYUUbDy+4fWSZdiqLM0r3tLrVL/
         8qGJWKNHDEcQAKWwOVPEYCknBlJREoI6qC9aFiWBdfhAkKd+75sr+MIwdigvasoSDC+E
         qTOw+SIqZdinKt1+3Z6r6GlImq+0liW6iWzpcqfuIGBFEeDpGzlYUttp66ZHgg6nj5z7
         2EwA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=oImzXZ6w;
       spf=pass (google.com: domain of geert.uytterhoeven@gmail.com designates 209.85.220.41 as permitted sender) smtp.mailfrom=geert.uytterhoeven@gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=oImzXZ6w;
       spf=pass (google.com: domain of geert.uytterhoeven@gmail.com designates 209.85.220.41 as permitted sender) smtp.mailfrom=geert.uytterhoeven@gmail.com
X-Google-Smtp-Source: AIpwx49HkHshN0ueRZ6u6EaHRwv7C4/w6BBYTnf7+VQBFddctEYh3rx4cG0JJWHlyZKffp5uELz2a0c2/Nbg58E+4DY=
MIME-Version: 1.0
Sender: geert.uytterhoeven@gmail.com
In-Reply-To: <CAJZ5v0jOk0pLegJK0-LwK3WEA5A560eNd32O5jK+PzQL9ZRofA@mail.gmail.com>
References: <1521026785-26456-1-git-send-email-geert+renesas@glider.be>
 <1521026785-26456-2-git-send-email-geert+renesas@glider.be>
 <1792056.cK5O20Fh4U@aspire.rjw.lan> <CAMuHMdWtf+AAb0i4Xu9o-LF7dym4jd9UxFZ-jKMbJcnuyQU3Fg@mail.gmail.com>
 <CAJZ5v0jOk0pLegJK0-LwK3WEA5A560eNd32O5jK+PzQL9ZRofA@mail.gmail.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 23 Apr 2018 11:59:50 +0200
X-Google-Sender-Auth: h2hGSSpTxMcLGyJhpvdWZ-uqWoE
Message-ID: <CAMuHMdW84vC5UoYbWRGXq+8-C5Rbr5pFA98VOfeWNZo=8kDxTA@mail.gmail.com>
Subject: Re: [PATCH/RFC 1/2] PM / wakeup: Add callback for wake-up change notification
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Geert Uytterhoeven <geert+renesas@glider.be>,
	Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Marek Vasut <marek.vasut+renesas@gmail.com>,
	Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
	Linux PM list <linux-pm@vger.kernel.org>,
	Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594912192574352449?=
X-GMAIL-MSGID: =?utf-8?q?1598530614275818980?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi Rafael,

On Mon, Apr 23, 2018 at 11:37 AM, Rafael J. Wysocki <rafael@kernel.org> wrote:
> On Mon, Apr 23, 2018 at 11:32 AM, Geert Uytterhoeven
> <geert@linux-m68k.org> wrote:
>> On Mon, Apr 23, 2018 at 11:18 AM, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
>>> On Wednesday, March 14, 2018 12:26:24 PM CEST Geert Uytterhoeven wrote:
>>>> Add a callback to inform a device that his wake-up setting has been
>>>> changed.  This allows a device to synchronize device configuration with
>>>> an external user action.
>>>>
>>>> E.g. on systems using a Rohm BD9571MWV PMIC and a toggle accessory power
>>>> switch, the system suspend procedure is:
>>>>   1. Configure PMIC for DDR backup mode, which changes the role of the
>>>>      accessory power switch from a power to a wake-up switch,
>>>>   2. Switch accessory power switch off, to prepare for system suspend,
>>>>   3. Suspend system.
>>>>
>>>> Hence step 1 cannot be done in the PMIC's suspend callback,
>>>
>>> I don't quite understand this, so can you please explain?
>>>
>>> What can't it be done from ->prepare() or even from a suspend notifier?
>>>
>>>> but it can be done in the new callback, in response to the user writing "enabled"
>>>> to the PMIC's wakeup virtual file in sysfs.
>>
>> Step 2 (flip a switch on the board) is a manual step, to be done by the user.
>> So it cannot be done from any suspend callback or notifier.
>
> I still find it somewhat difficult to follow you here. :-)
>
> How is this expected to work?  Is the user expected to flip the switch
> on the board and then write to "wakeup" or is that the other way
> around?

The other way around. The user must not flip the switch before the PMIC
is configured for DDR backup mode, else the system will be powered off
immediately.

  1. User writes to wakeup, which invokes the new callback, and configures
       the PMIC for DDR backup mode,
  2. User flips the switch,
  3. User writes to /sys/power/state to suspend.

After system suspend:
  4. User flips the switch to resume.

Yes, it is convoluted. I hope I managed to explain it clearly this time.

Currently step 1 is done using i2set from userspace, which is very unfriendly
(cfr. https://elinux.org/R-Car/Boards/Salvator-XS#PSCI_System_Suspend).

Note that on systems with a momentary power switch (e.g. R-Car Starter Kit Pro
or Premier aka [HM]3ULCB), step 2 is not needed.
Hence things are simplified a lot, as PMIC configuration can be done from
the PMIC's suspend callback on these platforms.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
