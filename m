Return-Path: <gnomes@lxorguk.ukuu.org.uk>
X-Google-Smtp-Source: AIpwx49at/AvogLaR3rgMmY8s8yzaaunAj8vXOohprNA8NKsFk+7g8+nepCMSazg9XvYqTEQU9r1
ARC-Seal: i=1; a=rsa-sha256; t=1522940317; cv=none;
        d=google.com; s=arc-20160816;
        b=YgDlbYv2ph0/zUVhHbeBV/PDpeMpwYeX+B3kg0G78AZpjq2asCRoA8fVqkvbywxAtY
         TU9ADshRtBERk3HrYYiaXA7CigTzceAlU0btWmhVBnrbTjGtOeK4g1kRimo3IMDY8g1w
         Zm2x0jNGIIX0+8pe4nOgUv6kzKAtVEedI4zlEbUuHemDqhrGJelluALKdTFEdP9QeiPZ
         OFcsY2aU2NZaNZbWi5RX4xF6umWwopssYrUWgxJhccgZ3+bsNCeZn9Kup/HT/sLvUqHV
         +oH2FjYH/eywvSUwQI7eFT+xTP5jYLw0JtskiJlfGB5aWNn4Qcf6WDILWWYVgp/mpk3P
         IvbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:mime-version:organization:references
         :in-reply-to:message-id:subject:cc:to:from:date
         :arc-authentication-results;
        bh=fNIw3aw6Y+1hxa12naG68dtcGRrgdWdTD+Ylt+iAxwE=;
        b=DJVTfZ6V5Sm04vAoM1fW3QodHRk8O9DRhp5woUccEmzoPk/+NqNkXNLzRnlH4eJ+q4
         OIhmHjBD3A2amayviRlLmuFCl422POhhYTY9YtiCmrXeKjUw8g258G4IHkQBH/+8idhg
         S/jZZ6P7kLiWzJaFkdorXAfvrbu/1DXOy/MLtZmRCqyGRP5aat3pLqxx1qSGS4g237+r
         gLBPqKmWI+qEfRkCHjXy8mi4pI0mD4N8fBows1CphKq8KeTmGypruKx7NSHBFeklyMOv
         LZK504xaf+ygyBTwjGltSiL7+/xdbJLUiwq6eFROh8gaLL6/K5qVbgjCEi44YSx52IHv
         0BNw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of gnomes@lxorguk.ukuu.org.uk designates 82.70.14.225 as permitted sender) smtp.mailfrom=gnomes@lxorguk.ukuu.org.uk
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of gnomes@lxorguk.ukuu.org.uk designates 82.70.14.225 as permitted sender) smtp.mailfrom=gnomes@lxorguk.ukuu.org.uk
Date: Thu, 5 Apr 2018 15:58:25 +0100
From: Alan Cox <gnomes@lxorguk.ukuu.org.uk>
To: Matthew Garrett <mjg59@google.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, luto@kernel.org,
        David
 Howells <dhowells@redhat.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>, jmorris@namei.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux
 Kernel Mailing List <linux-kernel@vger.kernel.org>,
        jforbes@redhat.com, linux-man@vger.kernel.org, jlee@suse.com,
        LSM List
 <linux-security-module@vger.kernel.org>,
        linux-api@vger.kernel.org, Kees
 Cook <keescook@chromium.org>,
        linux-efi <linux-efi@vger.kernel.org>
Subject: Re: [GIT PULL] Kernel lockdown for secure boot
Message-ID: <20180405155825.588b2775@alans-desktop>
In-Reply-To: <CACdnJuvuf13VrHfBadvXvVLUQoqjdbwqmnsRHamfDN_O4Ve+kA@mail.gmail.com>
References: <4136.1522452584@warthog.procyon.org.uk>
	<9349.1522794769@warthog.procyon.org.uk>
	<CALCETrV6E+r942K+fu-ALNf-x6qOZ3o1hNKGeu7qEMvr8sMP9A@mail.gmail.com>
	<CA+55aFxKzxdRZthzaokaGPAsWCp3a-p3aVfJSutF+9Fp9sbaVA@mail.gmail.com>
	<CACdnJusSfwULV-ubvgtYd8G_cTF4LnJ4DAeTCux4XRhHKVpBUw@mail.gmail.com>
	<CA+55aFzG==xr2OLK8F03RH0nkUDeP6btWqepFTuHZqkPTAOWjQ@mail.gmail.com>
	<CACdnJuv_=ihPut=5OvCYEphdBOn7+JrKacBbNa0n3wv_JvFMzg@mail.gmail.com>
	<CA+55aFyWNok1K-Jo3TQAXGXHvFOTvuOb-Hw977B9RGjBa7prrg@mail.gmail.com>
	<CA+55aFx9u-O81MwSq8zpb+MKaWYjYvtEcFu1NLP1_s63ED6_3Q@mail.gmail.com>
	<CACdnJutkO9dgz=HZpPRR9PZC=+cHh97dRUiGB+D3gruZr6U9Kg@mail.gmail.com>
	<CA+55aFxZN_p_cU94z7QN8=HnPanRrpRHH7UUkOBaFDSjfrivnQ@mail.gmail.com>
	<CACdnJutOAPTmPm6dmHiw4+8rj=M7B1SiCkPaRZLmi9-CCuRyNg@mail.gmail.com>
	<CA+55aFzH6doC2F1xBitPRwTZtbiCO_mX+QVcJ8HQCdsdD3Vmpg@mail.gmail.com>
	<CACdnJuvuf13VrHfBadvXvVLUQoqjdbwqmnsRHamfDN_O4Ve+kA@mail.gmail.com>
Organization: Intel Corporation
X-Mailer: Claws Mail 3.15.1-dirty (GTK+ 2.24.31; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcSW1wb3J0YW50Ig==?=
X-GMAIL-THRID: =?utf-8?q?1596848216178927191?=
X-GMAIL-MSGID: =?utf-8?q?1596918666139798027?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, 04 Apr 2018 00:12:04 +0000
Matthew Garrett <mjg59@google.com> wrote:

> On Tue, Apr 3, 2018 at 5:08 PM Linus Torvalds
> <torvalds@linux-foundation.org>
> wrote:
> > Still better than telling them to disable/enable secure boot, which
> > they may or may not even be able to to.  
> 
> Users who can boot a non-vendor Linux distribution on their platform can
> disable Secure Boot 100% of the time.

So can anyone else, or ignore it. Vendors of all OS's have released
enough buggy but signed kernel images over the past years that rummaging
around in the archive will find you a wide choice of signed boot images
that'll then let you do wtf you like including chaining some other target.

It was IMHO broken by design, it's always been broken by design and the
horse left the stable several years ago. Key revocation is hard, nobody
ever gets it right.

Thus "secure" boot is irrelevant to all of this

The most useful application of this kind of hardening is against remote
attacks. I don't care too much that someone local can attack my machine.
They can also steal it, ask me nicely with a baseball bat to remember the
password and so on.

If my box boots a random unsigned image that has these kinds of hardening
enabled then by the time it's on a network it's much much trickier to
attack. Yes you might be able to update the boot and reboot - but if I've
got that far I can insert an ancient buggy signed kernel image from a
vendor and chain through that anyway.

Real men boot security sensitive servers off a write protected SD card. If
your enterprise vendor doesn't supply a write protect for the boot
partition then maybe you should ask them why they don't 8)

In some ways the real application for this stuff is embedded. Whatever
the boot process most embedded devices benefit from that kind of lock
down.

Alan
