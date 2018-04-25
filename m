Return-Path: <geert.uytterhoeven@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1524677221; cv=none;
        d=google.com; s=arc-20160816;
        b=RrMMCQSf996iGvWjgMBMT4c3VAXw3l0LmRY5twITO+Ou4xzUYYFH/3WhDzVI2nN/Pf
         f2MpQVZPsEwAqk0dm1ZyELZFwEzyvZcHn7G7b4EYOfYVtzemwMLNEKE4vxCsX18oF7+Z
         Mx0+dSbxZa0tYOgXyOlxRKMuokLfCepSVibNaGX+kjny9u2j4DiZubi+J4z8CN9mfK6q
         DK+M2NmwMrY2yhBFyQz5f+KK1MV3UqmOITLc/f/aTMp4aNdENy0LWhilwKQ/eUcTaSiM
         z2lUSuOh8d9VX57BZMyok6rkChTlUiUGOsddvYLJFspDtzp6oEikZ9hJ74twodGRct6o
         AtIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to:sender
         :mime-version:dkim-signature:arc-authentication-results;
        bh=BRA1UwvYfCMWB/mNsOCjeopvfYhqrVRWx6b34QeAC2U=;
        b=dURkqUsQAnBQKWDTbqkqx7oiSki1dsQt/cDue8fuYhSFyVOpD6/aXZLf0gVJEOva3E
         638C6smpQOCgBxBbh59X1fRJeJw+c8liiUCfM3cvvDt2ucGMVPIJ94OY628xOn3B1V8s
         VwvxsiBkN7mAqYbFkIPFAOVI4oYKVgnBU9IGiEOoUpxzpn/TCTpFNGk5g2wIss7Bn/dY
         OvgxVPEmTucYwfwhq7e7D3ZkLg40t4vc0lv0Lkm7whAmK+FsNagpXXi3B+3pLiD1i6xg
         mft4Qhgz0d4ymR5DR/rXhnpsIJRIaGl5um+kVXp6gseqlFqyghjX2VDFvgiPGurEgswu
         tTtg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=IDc+5E2I;
       spf=pass (google.com: domain of geert.uytterhoeven@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=geert.uytterhoeven@gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=IDc+5E2I;
       spf=pass (google.com: domain of geert.uytterhoeven@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=geert.uytterhoeven@gmail.com
X-Google-Smtp-Source: AB8JxZqLy3puKV1OlQOEuh4HbWUQUiGiigIDNkhIoli8BhI8LeJ006Mm7Y9ase1Z+Yq0adDWvXnKlpa6sFJa4aZhhYA=
MIME-Version: 1.0
Sender: geert.uytterhoeven@gmail.com
In-Reply-To: <20180410221902.GA16141@n2100.armlinux.org.uk>
References: <1523366506-19832-1-git-send-email-geert+renesas@glider.be> <20180410221902.GA16141@n2100.armlinux.org.uk>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 25 Apr 2018 19:27:00 +0200
X-Google-Sender-Auth: Wn7v9BR3vXQ8pojdj0Ua5M7qumU
Message-ID: <CAMuHMdV3Sy3pJ2QbTqN2kTzc8NE85Bf4y5BQL9Pm91WYuOpyAg@mail.gmail.com>
Subject: Re: [PATCH v2 0/4] ARM: amba: driver_override improvements and fixes
To: Russell King - ARM Linux <linux@armlinux.org.uk>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Adrian Salido <salidoa@google.com>,
	Nicolai Stange <nstange@suse.de>, Sasha Levin <Alexander.Levin@microsoft.com>,
	Todd Kjos <tkjos@android.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597365567140567705?=
X-GMAIL-MSGID: =?utf-8?q?1598739942354324014?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi Russell,

(Woops, seems like I forgot to send the email below, while waiting for
 a success report for my submission to your patch queue)

On Wed, Apr 11, 2018 at 12:19 AM, Russell King - ARM Linux
<linux@armlinux.org.uk> wrote:
> On Tue, Apr 10, 2018 at 03:21:42PM +0200, Geert Uytterhoeven wrote:
>> This patch series contains improvements to driver_override handling in
>> the AMBA bus driver, including two bugfixes that are based on similar
>> fixes for the PCI and platform buses, and which Todd Kjos would like to
>> get into the android common branches to fix possible double free.
>>
>> Changes compared to v1:
>>   - RMK stepped down as amba maintainer.
>
> No, in the same way as I haven't stepped down as ARM maintainer.
> I've said that I'm not going to be putting as much effort in as I
> have done, specifically I'm not going to be as active reading the
> mailing lists.

Good to hear that! Thanks for your (continued) work!

> This is the first time I've seen your patches, they look fine to
> me, so please put them in the patch system as normal.

Thanks, done.

>> Geert Uytterhoeven (4):
>>   ARM: amba: Make driver_override output consistent with other buses
>>   ARM: amba: Fix race condition with driver_override
>>   ARM: amba: Don't read past the end of sysfs "driver_override" buffer
>>   ARM: amba: Fix wrong indentation in driver_override_store()
>>
>>  drivers/amba/bus.c | 21 +++++++++++++--------
>>  1 file changed, 13 insertions(+), 8 deletions(-)

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
