Return-Path: <arndbergmann@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1518728456; cv=none;
        d=google.com; s=arc-20160816;
        b=tE74YNOuUb1rHY9NGhJOirnadZM7ma/z1vbweu7K1ZCwu1gmVezgNc27F3mDsNCyaH
         djb95iH1OzOZKdqb/52yAAvObXNvqCXL1NtMcFfqhpp8kfXAhwKk8wQr49Qd/updSy/S
         pHIZDYCRs/nIDCe3jiAiWsC3VRNGZrYDA2fszIAL0aKTZqxHw4JQd1pTMwdnoc5aW6jB
         RooTPtM4pkTcP//y7EdVYTbf5vh2+nAXbiQAZwyCkeykvS4vehzjlKyC5XQBZijYqTlh
         5kzD7MlErXx/54aS8CqNvXY3ah+7NxBE41cjrhcQAuCBuo3916mBiGVRENFaF4AiHKwX
         UFhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to:sender
         :mime-version:dkim-signature:arc-authentication-results;
        bh=AGBS9FXeAe9c0GvqC+6MGzFW52C2MGpAekivq9aFiog=;
        b=xJ/OW5w8R0QlcyLyn9PPqQnXVB0bZ2cnoiLVY+VChsI3gyRkB6X9seAQQYM2wDyQ0+
         EmGN56GNhViQkbR/eueuERlfC6QGkHpc4uRgBlyiT9C0BFP0G8cWOhrc4G4/HaM1nCTb
         txLdnZf57wJ9qmn74vXbMeAcZt+/5yuP3iKmjCeR4ocj3Ms9M+1CDgzSJ/aarYkweJUg
         fFDnmKJzEI3gycf9vQmXCenRUkq+9sEAEQoYfpVCxswQXWn0uzqklXY8POdMN2XUcYeH
         cgY9xOlLt96rQCZEoo2k5+gQL6dX9sVh8DV4F6/bM1vOsyLaVQbXn8nfUBtGgrcKRQjV
         orMw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=gGqkuGc3;
       spf=pass (google.com: domain of arndbergmann@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=arndbergmann@gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=gGqkuGc3;
       spf=pass (google.com: domain of arndbergmann@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=arndbergmann@gmail.com
X-Google-Smtp-Source: AH8x226XP7LXGOerwZVwE0mXQK6Y/2jDOaLie6CGMCJ+zjwyZpn1lJ846j94j2T15NbFbXxBthcfd5Zmxk6uB6d4RnA=
MIME-Version: 1.0
Sender: arndbergmann@gmail.com
In-Reply-To: <20180215164343.GA6230@kroah.com>
References: <20171206141627.688219-1-arnd@arndb.de> <CAK8P3a0ZN2ALu1tj9sm8-Lt9SsRgpbQtz91zR4MhY-Np7TQNyg@mail.gmail.com>
 <af5124d4-b2cc-7d3c-5b8e-f7381859efd6@linux.intel.com> <CAK8P3a3pyM2FwHcAvFQckvbfqt7WvgRYSWE97pwLAtdvd77ToQ@mail.gmail.com>
 <20180215054357.GC7377@kroah.com> <CAK8P3a0hTbb+zRPH6nXVEdxP7zJyu5mYcjLqnWd4AfG_=Yrm-w@mail.gmail.com>
 <20180215164343.GA6230@kroah.com>
From: Arnd Bergmann <arnd@arndb.de>
Date: Thu, 15 Feb 2018 22:00:53 +0100
X-Google-Sender-Auth: 8TbHiuMYsmTsBNUhmjZ4f1cE9Ys
Message-ID: <CAK8P3a0YwGfO=XTcNzA2pbxjUTc=AsC8geX7Lbqwmq==jeRhmg@mail.gmail.com>
Subject: Re: [PATCH] x86/mm/kaiser: avoid 32-bit/PAE build warning
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Dave Hansen <dave.hansen@linux.intel.com>, "the arch/x86 maintainers" <x86@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, stable <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcSW1wb3J0YW50Ig==?=
X-GMAIL-THRID: =?utf-8?q?1592481842416907194?=
X-GMAIL-MSGID: =?utf-8?q?1592502209813042944?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, Feb 15, 2018 at 5:43 PM, Greg KH <gregkh@linuxfoundation.org> wrote:
> On Thu, Feb 15, 2018 at 04:37:10PM +0100, Arnd Bergmann wrote:
>> On Thu, Feb 15, 2018 at 6:43 AM, Greg KH <gregkh@linuxfoundation.org> wrote:
>> > On Wed, Feb 14, 2018 at 11:12:24PM +0100, Arnd Bergmann wrote:
>> >> On Wed, Dec 6, 2017 at 4:08 PM, Dave Hansen <dave.hansen@linux.intel.com> wrote:
>>
>> >>
>> >> I also saw another warning:
>> >>
>> >> /git/arm-soc/arch/x86/mm/kaiser.c: In function 'kaiser_init':
>> >> /git/arm-soc/arch/x86/mm/kaiser.c:347:8: error: 'vsyscall_pgprot'
>> >> undeclared (first use in this function); did you mean
>> >> 'massage_pgprot'?
>> >>
>> >> I can send this as proper patches for inclusion in 4.9-stable, unless
>> >> someone has a better idea or finds a problem
>> >
>> > proper patches would be good :)
>>
>> Sent two patches now. I want to make sure I haven't missed anything there,
>> especially as my first approach at fixing it ended up causing other build
>> failures.
>>
>> In order to test this, I backported some 35 other (mostly trivial) patches later
>> kernels, and now I have a 4.9.80 based tree that produces a clean randconfig
>> build every time on arm64 and x86_64. If you want, I'll send you the list
>> of the required backports as well. From what I can tell, they are all
>> harmless (unused functions, missing Kconfig dependencies etc), but
>> being able to do randconfig builds reliable gives us an additional tool for
>> regression testing the stable kernels.
>
> Sure, I'll be glad to take those.

Here are the ones that I think should apply cleanly

ac29fc66855b drm/i915: fix intel_backlight_device_register declaration
23f919d4ad0e shmem: avoid maybe-uninitialized warning
aa01338c0184 clk: sunxi-ng: fix build error without CONFIG_RESET_CONTROLLER
fbdf0e28d061 vmxnet3: prevent building with 64K pages
11d8b05855f3 perf/x86: Shut up false-positive -Wmaybe-uninitialized warning
42db500a551f PCI: vmd: Fix suspend handlers defined-but-not-used warning
fbc2a294f29e gpio: intel-mid: Fix build warning when !CONFIG_PM
b4aca383f9af platform/x86: intel_mid_thermal: Fix suspend handlers
unused warning
c8bd2ac3b4c6 usb: musb: fix compilation warning on unused function
de5bbdd01cf9 PCI: Change pci_host_common_probe() visibility
c0bfc549e962 perf: xgene: Include module.h
484c7bbf2649 video: fbdev: via: remove possibly unused variables
067fdeb2f391 dmaengine: zx: fix build warning
f46e7cd36b5f scsi: advansys: fix build warning for PCI=n
d4b2ac63b0ea x86/ras/inject: Make it depend on X86_LOCAL_APIC=y
b115bebc07f2 gpio: xgene: mark PM functions as __maybe_unused
f13d52cb3fad arm64: define BUG() instruction without CONFIG_BUG
75e2f0a6b161 x86/fpu/math-emu: Fix possible uninitialized variable use
e572d0887137 tools build: Add tools tree support for 'make -s'
d460131dd505 x86/build: Silence the build with "make -s"
68fd77cf8a4b thermal: fix INTEL_SOC_DTS_IOSF_CORE dependencies
c2ce3f5d89d5 x86: add MULTIUSER dependency for KVM
d689c64d189e x86/platform: Add PCI dependency for PUNIT_ATOM_DEBUG
3ba5b5ea7dc3 x86/vm86: Fix unused variable warning if THP is disabled
44a5b977128c scsi: advansys: fix uninitialized data access
2e449048a25e arm64: Kconfig: select COMPAT_BINFMT_ELF only when
BINFMT_ELF is set
46a049dae771 ALSA: hda/ca0132 - fix possible NULL pointer use
ab4949640d66 reiserfs: avoid a -Wmaybe-uninitialized warning

For the rest, some need context changes, and some need a new patch
as the patch that avoided the warning or error in later kernels is not
a backportable fix (e.g. driver removed).

>> I suspect 4.4 would require even more patches, but I have not looked.
>
> If the above doesn't clean up 4.4 as well, that would be surprising :)
>
> Anyway, 4.4 might be nice to have "clean" if possible, and it's not too
> much trouble.

I think it was before 4.9 that I started doing randconfig testing on x86
and arm64, so I would expect some additional backports mostly.
I used to do randconfig testing for arm32 only, as that caught the
most bugs from arm-soc. However, there is still a large number of
issues for arm32 that require non-upstream workarounds, mostly for
the more esoteric configurations that other architectures don't have.

       Arnd
