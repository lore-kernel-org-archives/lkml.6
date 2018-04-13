Return-Path: <msfjarvis@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1523603047; cv=none;
        d=google.com; s=arc-20160816;
        b=Ab0WmOUhLuIIZ1BKs5xUMHat/g6ml5qMnfRWB2DyxYLIi/V6mRztLfQaLbmbirnKdo
         7uVi4vimTysl/IRGntX4hG1SwNgo4JHuXJqx+QFOgl1kbch7Z5W7qm9Rnbl9ZP80D6qe
         Hgw8HC/GRleumOgZ6ZTXqZJX7fiXQEsqJ9sXwpWXtQvgdIdNqAx6QdTksv0MXNlLzHPA
         OQKg+vJfItO1R8rDcybcIGB0x4ye5vno9XhlZNMIXa+aG+Xr7NTCZuS8drfLUJrUtwJG
         CLIx25RHepSzr20NASDSGJIvlhIJYKQvrhzJf6gNiuPEN2MhkJGxiSWds4RPFk4wWTcp
         UNHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=message-id:from:cc:to:subject:content-transfer-encoding
         :mime-version:references:in-reply-to:user-agent:date:dkim-signature
         :arc-authentication-results;
        bh=FSQVd3SB6bC2m1fO8aEQKSMxt4G5bQU+wa8HiTo02LA=;
        b=ZmwcKybyg3f5SZkhd+tbD/hntjiAe7eO6RMpgXS+eMDXYrmOCSooggSDsBk3QozTMS
         kl+bI13v6rcW4ASC+N8pbKOZ5M7jhko8wm18VFKuiKieEsvTdHTR6+EH3uRxT9e+YeZD
         UcV76n31CSiX2zCVNhWAqyFB9O9bPgfxZaR/gH3diWjdbXP6QSmI6eTqOGP+ZVfm43Z8
         DsBb6+1Yk1VeMS3MtInFU5yePaL6HJEXtGTIiBRSEdBORLVd09kyUpaH60ft4Lx6F5Jb
         LTQ+FrxVRTBLFDXbgNDWCh2bc93NeCO6Z38+rZlNJIJfdi7hg9ftZz5hPjQ4kitgeUw+
         MIEw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=tBwytFaT;
       spf=pass (google.com: domain of msfjarvis@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=msfjarvis@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=tBwytFaT;
       spf=pass (google.com: domain of msfjarvis@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=msfjarvis@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
X-Google-Smtp-Source: AIpwx49PX5rIO9C9eJ27BVB4swPsBKVksPITYRseKdU+E50c2cBuNtnuHVK6fgnWXYSHWrHe7Z82zw==
Date: Fri, 13 Apr 2018 12:34:00 +0530
User-Agent: K-9 Mail for Android
In-Reply-To: <20180413062128.GA22147@kroah.com>
References: <20180413002951.155762-1-ghackmann@google.com> <F4A1736F-B00A-4EA6-94CD-BCD6CC7758C3@gmail.com> <20180413062128.GA22147@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] Revert "xhci: plat: Register shutdown for xhci_plat"
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC: Greg Hackmann <ghackmann@google.com>,Adam Wallis <awallis@codeaurora.org>,Mathias Nyman <mathias.nyman@intel.com>,Badhri Jagan Sridharan <badhri@google.com>,linux-usb@vger.kernel.org,linux-kernel@vger.kernel.org,stable@vger.kernel.org
From: Harsh Shandilya <msfjarvis@gmail.com>
Message-ID: <663D81E0-C7F1-42BC-950C-803E508BD4ED@gmail.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597588813245206760?=
X-GMAIL-MSGID: =?utf-8?q?1597613589344976000?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 13 April 2018 11:51:28 AM IST, Greg Kroah-Hartman <gregkh@linuxfoundatio=
n=2Eorg> wrote:
>On Fri, Apr 13, 2018 at 08:12:31AM +0530, Harsh Shandilya wrote:
>> On 13 April 2018 5:59:51 AM IST, Greg Hackmann <ghackmann@google=2Ecom>
>wrote:
>> >Pixel 2 field testers reported that when they tried to reboot their
>> >phones with some USB devices plugged in, the reboot would get wedged
>> >and
>> >eventually trigger watchdog reset=2E  Once the Pixel kernel team found
>a
>> >reliable repro case, they narrowed it down to this commit's 4=2E4=2Ey
>> >backport=2E  Reverting the change made the issue go away=2E
>>=20
>> Are you allowed to make the repro steps public? I'm writing this from
>> a walleye and would be grateful if I could test for this in the
>> modifed tree I'm running atm=2E  --=20
>
>I was told the steps are pretty simple:
>	- reboot the phone a lot
>eventually it will hang=2E  There's a fix in the code aurora kernel tree
>for this that they never sent upstream for some odd reason (they sent
>the first patch, why not the second?)
>
>I'll go revert this for now, thanks for the patch!
>
>greg k-h

That'd make sense, I only tried rebooting like five times before I had to =
run for a class=2E

As far as CAF is concerned, I feel the not submitting upstream, working ex=
tra to write patches which have usually better variants already upstream, s=
eems to be common=2E All USB changes were dropped when they merged kernel-c=
ommon into msm-3=2E18 with no real explanation which has been an annoyance =
more than once during merging -stable in my fork of msm-3=2E18=2E While I u=
nderstand their situation of maintaining upwards of 5 million lines of code=
 not upstream, it still feels sloppy to not merge stable updates and do ext=
ra work instead=2E /* End rant */
--=20
Harsh Shandilya, PRJKT Development LLC
