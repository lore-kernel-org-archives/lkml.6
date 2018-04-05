Return-Path: <mforce2@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1522944331; cv=none;
        d=google.com; s=arc-20160816;
        b=ss40eI+fBrIBphzQDZiUhPs+8UcWzJlwq3iKfaGV4xDOVi+tpfsaQtC5fh+WUjNoUL
         ZN8raOKF8VWkgRXpZZbHUCH7PbOF5rmpvaA1ATLVdidowm/XdTrm820xCZYAC6aB4W4G
         Hcw9soygjDv3/0h1aJuwXF74/GIGFOQfBM7STycQsx+wMIF8mQphlg5H3kxCntPcBUFe
         mo7brqdauKoRQ3ICA3yJD0YjJ6YgePX4EECYB1AF+jhX9GG+FlhFFtlP93qetvwVppmP
         D5ESPQJeESnpzv8ojgeJfBr8RW5/YoMFHuoT53IKCQb4+wlM11qBgd0cYe0Cl+Ulz5KK
         1Rig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature
         :arc-authentication-results;
        bh=YomI7RiqBKcxn/RxLsA1D2/LWwCFCA+Ry9gL7bsaThs=;
        b=hqLsEJAgb8fzE5YtNNsrkT4DNG6OqiTiDK674m0XIhttBNgHK53R1Biq43JvpATNQv
         eLEz49dSbsbO7AnrGp8JgQSHmLDnXUYtXlZaDQXIEbRyWtSXern1wwMcx0yqEACDSFE7
         ovvo4KR5gHLRzSHUyD8RjH0mQBW3znStxE5vp5+BO3ZpRYRCQJjMkxDhjP/AXqs86bP2
         w1VhByMgpOmzTm4YZQG6OdkBCDxM86g/msd89fbveS1Hvehr8T0GacjG8yZvqlb92i/I
         Jrwwk2ElCt4u7l+EseLN0zm4V8P7C81imMtLo3Lp/3boToImTmtUFRdfFGxq6GhGrqCd
         HjKw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=unjYnE1r;
       spf=pass (google.com: domain of mforce2@gmail.com designates 209.85.220.41 as permitted sender) smtp.mailfrom=mforce2@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=unjYnE1r;
       spf=pass (google.com: domain of mforce2@gmail.com designates 209.85.220.41 as permitted sender) smtp.mailfrom=mforce2@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
X-Google-Smtp-Source: AIpwx49zrm67BnHeeR4ULhnj//X30Elq92ATDlSN/R+NwNL3E6wogJCnah0Ms9ldEuKihySkvTuj4u8UR6pHO3H/FwE=
MIME-Version: 1.0
From: Marius Cirsta <mforce2@gmail.com>
Date: Thu, 5 Apr 2018 19:05:29 +0300
Message-ID: <CANO0Vk63RYFRU1Yr+vhktQ+xsnqH+a=4sV_jR-sHfFJMH9jLLw@mail.gmail.com>
Subject: Re: Logitech webcam USB audio breakage during the 4.10 merge window
To: linux-usb@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Gabriel C <nix.or.die@gmail.com>,
	gregkh@linuxfoundation.org
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596922875548741641?=
X-GMAIL-MSGID: =?utf-8?q?1596922875548741641?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Adding the linux-usb mailing , maybe someone from there will be able
to help with this.

On Sun, Feb 25, 2018 at 12:45 PM, Marius Cirsta <mforce2@gmail.com> wrote:
> Hi,
>
>  Thanks for your answer.
>
>  Yes, I tried reverting just that commit on top of kernel 4.15.5 and
> there was no change so I too suspect it's something from USB core
> related to the quirks that this webcam needs.
>
> Regards,
>
> Marius Cirsta,
>
> mforce2@gmail.com
>
> On Sun, Feb 25, 2018 at 11:45 AM, Takashi Iwai <tiwai@suse.de> wrote:
>> On Sun, 25 Feb 2018 02:53:15 +0100,
>> Marius Cirsta wrote:
>>>
>>>  I have a problem that was previously reported here:
>>>
>>> https://www.spinics.net/lists/linux-usb/msg156999.html
>>>
>>>  It seems that with the 4.10-rc1 kernel a regression was introduced
>>> that makes my Logitech C310 microphone record a distorted ( chipmunk )
>>> sound. With the 4.9.1 kernel it works perfectly.
>>>
>>>  Immediately after I plug it into the USB port all is fine but after a
>>> few minutes this problem occurs.
>>>
>>>  Also if add this the kernel cmd line :  usbcore.autosuspend=-1  it
>>> also works fine.
>>>
>>>  One other thing that I've noticed is that if I make the sampling rate
>>> 22K it again works fine so only the 44K and 48K sampling rates have
>>> this problem but unfortunately those are the default that Chromium for
>>> instance uses ( it gets them from pulseaudio )
>>>
>>>
>>> Let me know if you need any more details or testing.
>>
>> Well it's an old topic, so I don't remember, but did you try to revert
>> the commit fd1a5059610c as already suggested?
>>
>> If it doesn't give any difference, it's not about USB-audio driver
>> side, rather likely some change in USB core.
>>
>>
>> Takashi
