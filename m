Return-Path: <briannorris@chromium.org>
ARC-Seal: i=1; a=rsa-sha256; t=1519698551; cv=none;
        d=google.com; s=arc-20160816;
        b=k260ICdqJzkuHrIv2AguqWrlgvy8DC7FSRYrVkfuwlX0MjzbGg2AWqfItWSri/ODlU
         y1FwgwZ/SLWxfSSGd2WA+tMH1sF7i6xuaeVFqn6O4W6P8CoeK3hL5kKtyYiRe26xUcu0
         vGkKPL0eDPEHPkC8Y5tbmakIRuGY7mP4zj7X31wRXoK/aB0vVvGHcJXTq1mpO317Aj1e
         koQRKof99NAJEaaFZohQxqkOAPULVzrPhx3uAdYblUmg+fFTxqIyiWs0DvKk4vGyyWVS
         RektpD6Aw5BpaI+J/ZIKE070mKLyFvOueNH/DSnHuxghYuhvAxA1vWqbN01AXFhQM/5X
         CaYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:dkim-signature:arc-authentication-results;
        bh=HQBFtOmOO4Ya/54BSVSkWfgEGVNmkkOk/y5N0ZMahqE=;
        b=gNo1JMAUa3n6cM6XIWLujfQKfzPMFgXxTjZNnsdxRKyVoOSn1QcnGIWujlezumGIq/
         oXLcc2sNkbEYNmmzS2uwHtJN8cNJbiCsWDXKQy1QRG6OaOV+88hGPxWyuYuXK/3rEFqC
         59c5qHCdEYe/BHNjJTP+DVGLPdSAtUUXQnIGudwKnUuW1s9u5j8B4T/Yu2nlg4EQi32d
         EnjkNjgpieLViNAvMYk5il+lHK9sMXj5e4ZEQj3yXp0FhcVnzSK3AJMQb6JM+c5l7Rpq
         365Gd4LPvAf04XV9BtTf9nv9M2DXwIdpWxbSWXEbT3m9maLiXs+3N+UfoGBREuZfpAlU
         nmwg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@chromium.org header.s=google header.b=VJ8E74gP;
       spf=pass (google.com: domain of briannorris@chromium.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=briannorris@chromium.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=chromium.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@chromium.org header.s=google header.b=VJ8E74gP;
       spf=pass (google.com: domain of briannorris@chromium.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=briannorris@chromium.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=chromium.org
X-Google-Smtp-Source: AH8x226GMjxWSIg1nnE3W6fBwQo8SgSoJdAheRgd7G7LT3YLcfQWxOVzbOJhYUs1hwK9LfHRevwA6Q==
MIME-Version: 1.0
In-Reply-To: <a6090910-7941-b194-c094-7ce3ef047974@redhat.com>
References: <20180108094416.4789-1-hdegoede@redhat.com> <20180213022455.GA151190@rodete-desktop-imager.corp.google.com>
 <8cd918fd-bf6f-70ac-e561-e7deffa695f0@redhat.com> <20180216022721.GA69988@rodete-desktop-imager.corp.google.com>
 <345b0de8-1a23-d2f8-bc56-507eadf7faa7@redhat.com> <6B37F6AC-1103-4FCF-A5DC-4BA236A7B11B@holtmann.org>
 <1a08612e-2531-3711-ec0f-a867e86d0009@redhat.com> <20180216175955.GA80944@rodete-desktop-imager.corp.google.com>
 <a846c1ac-7dea-a30a-4133-32eac606d101@redhat.com> <20180223031216.GA230265@rodete-desktop-imager.corp.google.com>
 <a6090910-7941-b194-c094-7ce3ef047974@redhat.com>
From: Brian Norris <briannorris@chromium.org>
Date: Mon, 26 Feb 2018 18:29:08 -0800
X-Gmail-Original-Message-ID: <CA+ASDXOGhi4t2R5qrbXHTFkjtzvUL=qHxkJqku4XKJ6u8Wr+cg@mail.gmail.com>
Message-ID: <CA+ASDXOGhi4t2R5qrbXHTFkjtzvUL=qHxkJqku4XKJ6u8Wr+cg@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: btusb: Restore QCA Rome suspend/resume fix
 with a "rewritten" version
To: Hans de Goede <hdegoede@redhat.com>
Cc: Marcel Holtmann <marcel@holtmann.org>, "Gustavo F. Padovan" <gustavo@padovan.org>,
	Johan Hedberg <johan.hedberg@gmail.com>,
	Bluez mailing list <linux-bluetooth@vger.kernel.org>, linux-serial@vger.kernel.org,
	ACPI Devel Maling List <linux-acpi@vger.kernel.org>, stable <stable@vger.kernel.org>,
	Leif Liddy <leif.linux@gmail.com>, Matthias Kaehlcke <mka@chromium.org>,
	Daniel Drake <drake@endlessm.com>, Kai-Heng Feng <kai.heng.feng@canonical.com>,
	Matadeen Mishra <matadeen@qti.qualcomm.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Guenter Roeck <linux@roeck-us.net>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592481108912063395?=
X-GMAIL-MSGID: =?utf-8?q?1593519428613877549?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, Feb 22, 2018 at 11:14 PM, Hans de Goede <hdegoede@redhat.com> wrote:
> On 23-02-18 04:12, Brian Norris wrote:
>> Hmm? I'm not sure I completely follow here when you say "he was not
>> hitting the firmware loading race". If things were functioning fine with
>> system suspend (but not with autosuspend), then he's not seeing the
>> controller (quoting commit fd865802c66b) "losing power during suspend".
>
>
> He was running a kernel with the original "fd865802c66b Bluetooth: btusb:
> fix QCA Rome suspend/resume" commit, which fixes regular suspend for
> devices which are "losing power during suspend", but does nothing for
> runtime-suspend.
>
> He ran tests both with and without runtime-pm enabled with that same kernel
> and he needed to disable runtime-pm to get working bluetooth.

Did he ever test with commit fd865802c66b reverted?

My symptoms were exactly the same as you described. BT was broken as
of v4.14 if I had runtime suspend enabled. Things were fine if I
either (a) reverted the patch or (b) disabled runtime suspend. I
obviously preferred (a), which is why I continued to complain :)

Did your tester ever try (a)? If not, then I don't think you've really
ensured that he really needed a "fixed" version; he may not have
needed the patch at all.

Or an alternative question: did that system work on an older Fedora
release (and presumably an older kernel)? If so, then he probably also
did not need that patch.

>> So, that would suggest he could only be seeing the race (as I was), and
>> that his machine does not deserve a RESET_RESUME quirk?
>
>
> I hope my above answer helps to clarify why I believe the quirk is
> necessary on his machine.

I'm sorry, but no it doesn't. If anything, it suggests to me even more
that it may not have been necessary.

But hey, I'm not personally going to notice if random Lenovo laptops
are wasting power.

Brian
