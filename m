Return-Path: <ard.biesheuvel@linaro.org>
ARC-Seal: i=1; a=rsa-sha256; t=1523269510; cv=none;
        d=google.com; s=arc-20160816;
        b=iS2AOj8FtroNIOLjAa5sSpRRVyw67oKh8rJPd0yUoYIxVYj9xD5pWgD1kzx1vJafoE
         OCR62hTS7lbqHMdAmLFd+fdxu4oEmVkwTVb9A5p2S/X9SnuO+6GSy/TKiM3oaaSE4K3C
         p7j62+QwdO6pyw9x2R/aEvAHti+Fw3gKq0mdlVYenrB65SPUn+RuxoG0VAKvsPPB4p16
         I4pBXsMHCZJOyss8G3Ypf7Vaaz2RVsvW/xBiFVGd3zyW2cYxCc3coi/xM4UoRwTficS3
         Iwc2hBL6w2PGaApH6n6G8h4bSdmwuXUuC3i6CO1TKmotJisOWQpSkA5CAsNTjyh/Cmqu
         KULQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:dkim-signature
         :arc-authentication-results;
        bh=U6nIJzauH9yLUJyBjteaUlo/bE9Gp0fsJPPXmKqCwHk=;
        b=W9iRnrDQl8/zmUnD+daOgZ7KWcO7wZT0fCRHjdBEuk27uYrFNXtV63ZtYjkNnU9jRP
         1VH+W1vN+BewJ/G4QHdsxflDkLd9+DBxyIMIy7p8CuluYTjBbyggVysmy2QljrauIlbw
         cD5aGuvDySNM73yIQLHCTb5IP1fgiCL5WIxGu+J6oBXCCkHMirt2HfGhPweH6siIS/Eb
         exr9km4GBUWRIqk37YV41eDiekfBMHKVk+Gd3WWRalapRCKxMRAAQzT237Btl0vL2irZ
         E+jPtNHcCHLs0zfrtyR99f+5hKwdcLaLBVXQPVrogleZ2LK11on8Sr/TB1YJ/uRsvNH4
         6WGg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@linaro.org header.s=google header.b=R1+lnEUC;
       spf=pass (google.com: domain of ard.biesheuvel@linaro.org designates 209.85.220.41 as permitted sender) smtp.mailfrom=ard.biesheuvel@linaro.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=linaro.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@linaro.org header.s=google header.b=R1+lnEUC;
       spf=pass (google.com: domain of ard.biesheuvel@linaro.org designates 209.85.220.41 as permitted sender) smtp.mailfrom=ard.biesheuvel@linaro.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=linaro.org
X-Google-Smtp-Source: AIpwx4/hFt/Ki8VXK0VWDZJ9YnRSYHaHVOj9vwCMw37LEKPymQEz9a2T2TTVyczphxOKo/FoK9s0bQ==
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (1.0)
Subject: Re: Linux 4.9.93
From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
X-Mailer: iPhone Mail (15C202)
In-Reply-To: <20180409185751.247a0ac7@jbtheou>
Date: Mon, 9 Apr 2018 12:25:07 +0200
Cc: Greg KH <gregkh@linuxfoundation.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Will Deacon <will.deacon@arm.com>, Dan Rue <dan.rue@linaro.org>,
 Mark Brown <mark.brown@linaro.org>, Marc Zyngier <marc.zyngier@arm.com>,
 Greg Hackmann <ghackmann@google.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <40BB2246-DD5D-4956-ADFA-6143FCC98D1B@linaro.org>
References: <20180409180534.1768583293d0abe207168c5a@essential.com> <20180409093028.GA3398@kroah.com> <CAKv+Gu9Ny=EatuqrVOEFbOt+h0rH5uqxxDyHFT-PLH72ZzvZiw@mail.gmail.com> <20180409185751.247a0ac7@jbtheou>
To: Jean-Baptiste Theou <jb@essential.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597258846269332204?=
X-GMAIL-MSGID: =?utf-8?q?1597263850484712420?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>



> On 9 Apr 2018, at 11:57, Jean-Baptiste Theou <jb@essential.com> wrote:
>=20
> On Mon, 9 Apr 2018 11:49:37 +0200
> Ard Biesheuvel <ard.biesheuvel@linaro.org> wrote:
>=20
>>> On 9 April 2018 at 11:30, Greg KH <gregkh@linuxfoundation.org> wrote:
>>>> On Mon, Apr 09, 2018 at 06:05:34PM +0900, Jean-Baptiste Theou wrote: =20=

>>>> Hi,
>>>>=20
>>>> After this patchset, a kernel built with CFI fails. Disabling
>>>> UNMAP_KERNEL_AT_EL0 fix the issue obviously. =20
>>=20
>> How does one 'build a kernel with CFI' for arm64?
>=20
> =46rom Google work on Android-4.9
>=20
> https://android.googlesource.com/kernel/common/+/00a195e7c0752ff5d65c9caad=
fbcc226270ca232
>=20
> I am not sure what is the plan on their side to upstream (Greg?), but defi=
nitely
> useful to isolate actual issues.
>=20
>>=20
>>>=20
>>> Is this a "clean" 4.9.93 tree or a "4.9.93 merged into
>>> android-common-4.9?
>=20
> It's a "clean 4.9.93" + whatever is needed for Clang/CFI support
>=20
> My take is that CFI doesn't like=20
>=20
> * void __kpti_install_ng_mappings(int cpu, int num_cpus, phys_addr_t swapp=
er)
>=20
> and=20
>=20
> remap_fn =3D (void *)__pa_symbol(idmap_kpti_install_ng_mappings);
>=20
> Maybe just flag this function to not use CFI? I remember that Sami Tolvane=
n did
> similar changes.
>=20
> I know it's a bit out of context since CFI support for ARM64 is not upstre=
am yet,
> but unfortunate that an stable patchset trigger such failures.
>=20

I am sorry but if you are implying that we should have tested these patches a=
gainst the out of tree CFI code, I have to disappoint you: that is simply no=
t upstream=E2=80=99s job, and if the Google engineers merged this into their=
 v4.9 tree without proper testing, may I suggest that you report it to them i=
nstead?

OTOH, if that is not what you are implying, please ignore the rant :-)


> Thanks a lot
>=20
> Best regards
>=20
>>>=20
>>>> Wondering if there is one of the test suite used on the review patchset=
 that covers the CFI usecase.
>>>>=20
>>>> Best regards,
>>>>=20
>>>> [    0.249191] CPU features: detected feature: GIC system register CPU i=
nterface
>>>> [    0.256391] CPU features: detected feature: Privileged Access Never
>>>> [    0.262719] CPU features: detected feature: User Access Override
>>>> [    0.268791] CPU features: detected feature: 32-bit EL0 Support
>>>> [    0.274683] CPU features: detected feature: Kernel page table isolat=
ion (KPTI)
>>>> [    0.282166] CFI failure:
>>>> [    0.282169] CFI failure:
>>>> [    0.282172] CFI failure:
>>>> [    0.282173] CFI failure:
>>>> [    0.282175] CFI failure:
>>>> [    0.282176] CFI failure:
>>>> [    0.282177] CFI failure:
>>>> [    0.282178] CFI failure:
>>>> [    0.282188] ------------[ cut here ]------------
>>>> [    0.282189] ------------[ cut here ]------------
>>>> [    0.282190] ------------[ cut here ]------------
>>>> [    0.282191] ------------[ cut here ]------------
>>>> [    0.282193] ------------[ cut here ]------------
>>>> [    0.282196] kernel BUG at kernel/cfi.c:32!
>>>> [    0.282198] ------------[ cut here ]------------
>>>> [    0.282201] kernel BUG at kernel/cfi.c:32!
>>>> [    0.282202] ------------[ cut here ]------------
>>>> [    0.282204] kernel BUG at kernel/cfi.c:32!
>>>> [    0.282207] kernel BUG at kernel/cfi.c:32!
>>>> [    0.282209] kernel BUG at kernel/cfi.c:32!
>>>> [    0.282211] kernel BUG at kernel/cfi.c:32!
>>>> [    0.282214] kernel BUG at kernel/cfi.c:32!
>>>> [    0.282215] ------------[ cut here ]------------
>>>> [    0.282216] kernel BUG at kernel/cfi.c:32!
>>>> [    0.282218] Internal error: Oops - BUG: 0 [#1] PREEMPT SMP
>>>> [    0.282224] Modules linked in:
>>>> [    0.282230] CPU: 2 PID: 25 Comm: migration/2 Not tainted 4.9.93-perf=
+ #39
>>>> [    0.282232] Hardware name: <REMOVED>
>>>> [    0.282235] task: fffffffbb3b36580 task.stack: fffffffbb30cc000
>>>> [    0.282250] PC is at __cfi_check_fail+0x14/0x1c
>>>> [    0.282253] LR is at __cfi_check_fail+0x14/0x1c
>>>> [    0.282255] pc : [<ffffff93b3f03d90>] lr : [<ffffff93b3f03d90>] psta=
te: 60c00085
>>>> [    0.282256] sp : fffffffbb30cfc30
>>>> [    0.282259] x29: fffffffbb30cfc30 x28: ffffff93b6415000
>>>> [    0.282261] x27: 00000013b65c1000 x26: ffffff93b5ce6000
>>>> [    0.282264] x25: ffffff93b5ce6000 x24: ffffff93b6419000
>>>> [    0.282266] x23: ffffff93b65c1000 x22: ffffff93b65c4000
>>>> [    0.282268] x21: 9d12f8172cb2f296 x20: 000000008180e3e0
>>>> [    0.282271] x19: 0000000000000000 x18: 000000000000002c
>>>> [    0.282274] x17: 00000000000fd054 x16: 0000000000000000
>>>> [    0.282276] x15: ffffff93b65ec000 x14: 000000000000000c
>>>> [    0.282279] x13: 0000000000000004 x12: 0000000000000000
>>>> [    0.282281] x11: 0000000000000000 x10: 0000000001440144
>>>> [    0.282283] x9 : 260822e8751d5000 x8 : 260822e8751d5000
>>>> [    0.282286] x7 : 0000000000000000 x6 : fffffffbbac75b60
>>>> [    0.282288] x5 : 0000000000000000 x4 : 0000000000000000
>>>> [    0.282290] x3 : 000000003a657275 x2 : 0000000000000000
>>>> [    0.282292] x1 : 0000000000000000 x0 : 000000000000000c
>>>> [    0.282294]
>>>> [    0.282294] PC: 0xffffff93b3f03d50:
>>>> [    0.282308] 3d50  b9001ac8 f94002c8 370ffec8 17ffffbe d4210000 14000=
000 aa1603e0 f90007e8
>>>> [    0.282315] 3d70  94536017 f94007e8 17ffffe2 a9bf7bfd 910003fd d000d=
100 913ee400 94533cc7
>>>> [    0.282322] 3d90  d4210000 14000000 b0013788 2a1f03e0 f901c51f d65f0=
3c0 f940406b 2a0203e8
>>>> [    0.282329] 3db0  2a0103e9 aa0003ea b400008b f9000145 f94000cb b4000=
1ab a9bf7bfd 910003fd
>>>> [    0.282330]
>>>> [    0.282330] LR: 0xffffff93b3f03d50:
>>>> [    0.282336] 3d50  b9001ac8 f94002c8 370ffec8 17ffffbe d4210000 14000=
000 aa1603e0 f90007e8
>>>> [    0.282343] 3d70  94536017 f94007e8 17ffffe2 a9bf7bfd 910003fd d000d=
100 913ee400 94533cc7
>>>> [    0.282350] 3d90  d4210000 14000000 b0013788 2a1f03e0 f901c51f d65f0=
3c0 f940406b 2a0203e8
>>>> [    0.282357] 3db0  2a0103e9 aa0003ea b400008b f9000145 f94000cb b4000=
1ab a9bf7bfd 910003fd
>>>> [    0.282358]
>>>> [    0.282358] SP: 0xfffffffbb30cfbf0:
>>>> [    0.282365] fbf0  b3f03d90 ffffff93 b30cfc30 fffffffb b3f03d90 fffff=
f93 60c00085 00000000
>>>> [    0.282372] fc10  b6415000 ffffff93 b642fa00 ffffff93 ffffffff fffff=
fff b3f03d90 ffffff93
>>>> [    0.282378] fc30  b30cfc70 fffffffb b3d458c0 ffffff93 00000080 00000=
000 00000001 00000000
>>>> [    0.282385] fc50  b65c4000 ffffff93 b64420f0 ffffff93 8180e3e0 00000=
000 00000002 00000000
>>>> [    0.282387] Process migration/2 (pid: 25, stack limit =3D 0xfffffffb=
b30cc000)
>>>> [    0.282389] Call trace:
>>>> [    0.282391] Exception stack(0xfffffffbb30cfb00 to 0xfffffffbb30cfc30=
)
>>>> [    0.282395] fb00: 000000000000000c 0000000000000000 0000000000000000=
 000000003a657275
>>>> [    0.282397] fb20: 0000000000000000 0000000000000000 fffffffbbac75b60=
 0000000000000000
>>>> [    0.282400] fb40: 260822e8751d5000 260822e8751d5000 0000000001440144=
 0000000000000000
>>>> [    0.282403] fb60: 0000000000000000 0000000000000004 000000000000000c=
 ffffff93b65ec000
>>>> [    0.282405] fb80: 0000000000000000 00000000000fd054 000000000000002c=
 0000000000000000
>>>> [    0.282408] fba0: 000000008180e3e0 9d12f8172cb2f296 ffffff93b65c4000=
 ffffff93b65c1000
>>>> [    0.282411] fbc0: ffffff93b6419000 ffffff93b5ce6000 ffffff93b5ce6000=
 00000013b65c1000
>>>> [    0.282413] fbe0: ffffff93b6415000 fffffffbb30cfc30 ffffff93b3f03d90=
 fffffffbb30cfc30
>>>> [    0.282416] fc00: ffffff93b3f03d90 0000000060c00085 ffffff93b6415000=
 ffffff93b642fa00
>>>> [    0.282418] fc20: ffffffffffffffff ffffff93b3f03d90
>>>> [    0.282421] [<ffffff93b3f03d90>] __cfi_check_fail+0x14/0x1c
>>>> [    0.282430] [<ffffff93b3d458c0>] name_to_dev_t+0x0/0x47c
>>>> [    0.282436] [<ffffff93b3d51b80>] kpti_install_ng_mappings+0x178/0x2e=
0
>>>> [    0.282443] [<ffffff93b3eae950>] multi_cpu_stop+0x114/0x170
>>>> [    0.282445] [<ffffff93b3eaf08c>] cpu_stopper_thread+0x128/0x2e8
>>>> [    0.282452] [<ffffff93b3db5504>] smpboot_thread_fn+0x230/0x558
>>>> [    0.282455] [<ffffff93b3dae848>] kthread+0x21c/0x238
>>>> [    0.282459] [<ffffff93b3c838f0>] ret_from_fork+0x10/0x20
>>>> [    0.282464] Code: 910003fd d000d100 913ee400 94533cc7 (d4210000) =20=

>>>=20
>>> Oh fun :(
>>>=20
>>> Dragging in a bunch more people to the cc: and to: lines to have them
>>> look at this...
>>>=20
>>> thanks,
>>>=20
>>> greg k-h =20
