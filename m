Return-Path: <mforce2@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1519555553; cv=none;
        d=google.com; s=arc-20160816;
        b=VOnhhFDBwv/3LSDRhv624nHz6jAF4qOzARaiOxY5k82Dl/IkpN4yeFZwW2hBl+TRPh
         MRt0Er/HXCcX5xUE8zq3qNSKROF4IgC+CMDyJTjSKmtpy2kQkHo4NqU+XZ/1+v6GH2xV
         FMZwxFuvgmBrTENasfKOOxvh5YbV8NLTiXxyXp3b0U2b1yNGXCCKL2jldqjQ2odICUty
         J/Fnw3ZRGfWQ7X2pLg7Hfmro8T/VYcjL52e08Lvr3CPgrgviovVCyP59Mr1Xdcz7+iwU
         JjEx7v5SWDz4pUOQCkfTpuOwDidbFPpAaR61EWB2tXuwGaDowhhhZF1bL6GEakBL8tVm
         cd3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:dkim-signature:arc-authentication-results;
        bh=o6AgbU5Bw6fVSo7l2ERhrvIQwC/gLH33pY+5rc244Mw=;
        b=hmECMsR5PCz+vYqRuDUT5FBwdIt+8287rICD+mZfVZVgzKhEqpDbZ1i1rLOtNFgFa+
         G2LAlJS0sDzYzczL/aqHdZV9pRV3YRXCxQbm6dHyKFQuQ1e7wANarlbOJD81ZrQZOxpo
         NTyS4mF6p/4h0lQI4LljwqrILfWtrAhd6kl93HLFRVaCQtFdQUb5H7wCTghIQaKWbJDx
         wImP0gMh31SYpYU5UNrsNNVDlNt/evT+ljQwTdvNWOW1tcSIMZe2IHrKQCCfN2y2Rzs8
         sSE8qr88jK3PvRN3adovSgqS5VCo9IaJhYOTFqCcBeg1JQcvSmaeHTnY0tpwrkLwQr+V
         EiGw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=HYqxWBFO;
       spf=pass (google.com: domain of mforce2@gmail.com designates 209.85.220.41 as permitted sender) smtp.mailfrom=mforce2@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=HYqxWBFO;
       spf=pass (google.com: domain of mforce2@gmail.com designates 209.85.220.41 as permitted sender) smtp.mailfrom=mforce2@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
X-Google-Smtp-Source: AH8x225ci72H02l4kMYRt6BKzN9q3+ydO2LumCX82PhFw52IMN3vP/EiylvGDBgkOsES2aDm6A+/hcKOBvwD8O54aBE=
MIME-Version: 1.0
In-Reply-To: <s5hy3jhxv0y.wl-tiwai@suse.de>
References: <CANO0Vk6d+cqo5fqtwPUp6e3DugV4--BbT_k-FNTgSkL0N635yw@mail.gmail.com>
 <s5hy3jhxv0y.wl-tiwai@suse.de>
From: Marius Cirsta <mforce2@gmail.com>
Date: Sun, 25 Feb 2018 12:45:51 +0200
Message-ID: <CANO0Vk6DRLa3-ehM5FEp_rY=nP6svGyL46R6Ma_P9QiU8NnF7g@mail.gmail.com>
Subject: Re: Logitech webcam USB audio breakage during the 4.10 merge window
To: Takashi Iwai <tiwai@suse.de>
Cc: linux-kernel@vger.kernel.org, Gabriel C <nix.or.die@gmail.com>,
	gregkh@linuxfoundation.org
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593335974570800484?=
X-GMAIL-MSGID: =?utf-8?q?1593369483403450479?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi,

 Thanks for your answer.

 Yes, I tried reverting just that commit on top of kernel 4.15.5 and
there was no change so I too suspect it's something from USB core
related to the quirks that this webcam needs.

Regards,

Marius Cirsta,

mforce2@gmail.com

On Sun, Feb 25, 2018 at 11:45 AM, Takashi Iwai <tiwai@suse.de> wrote:
> On Sun, 25 Feb 2018 02:53:15 +0100,
> Marius Cirsta wrote:
>>
>>  I have a problem that was previously reported here:
>>
>> https://www.spinics.net/lists/linux-usb/msg156999.html
>>
>>  It seems that with the 4.10-rc1 kernel a regression was introduced
>> that makes my Logitech C310 microphone record a distorted ( chipmunk )
>> sound. With the 4.9.1 kernel it works perfectly.
>>
>>  Immediately after I plug it into the USB port all is fine but after a
>> few minutes this problem occurs.
>>
>>  Also if add this the kernel cmd line :  usbcore.autosuspend=-1  it
>> also works fine.
>>
>>  One other thing that I've noticed is that if I make the sampling rate
>> 22K it again works fine so only the 44K and 48K sampling rates have
>> this problem but unfortunately those are the default that Chromium for
>> instance uses ( it gets them from pulseaudio )
>>
>>
>> Let me know if you need any more details or testing.
>
> Well it's an old topic, so I don't remember, but did you try to revert
> the commit fd1a5059610c as already suggested?
>
> If it doesn't give any difference, it's not about USB-audio driver
> side, rather likely some change in USB core.
>
>
> Takashi
