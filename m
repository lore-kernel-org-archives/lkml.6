Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C53ACC5CFC1
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 17:20:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 76C5A20661
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 17:20:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=amacapital-net.20150623.gappssmtp.com header.i=@amacapital-net.20150623.gappssmtp.com header.b="BsU5QsUe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 76C5A20661
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amacapital.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967110AbeFSRUK (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 13:20:10 -0400
Received: from mail-pl0-f65.google.com ([209.85.160.65]:36249 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966551AbeFSRUG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 13:20:06 -0400
Received: by mail-pl0-f65.google.com with SMTP id a7-v6so202430plp.3
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jun 2018 10:20:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=GlGVxOfc/4SeVv8qRH9Agv8rkOuTFAZd92nwAvRCJ0o=;
        b=BsU5QsUe/wEkagMPkV3NWNGu5UvVOEH0svlXrWMWZZogelDZExqbv/fS58UFJ+d0Gr
         wKfGy92cexSNL5Nw/2LOhGvgygJBEgrdoFUn0OE9O8MT0bP1j6ri30X5Vm6a802Y8MxM
         GSInF+Cd77bswYK0gKxvN/YSbdXggNF7pzrr0VYF9GiAoQIYvk7ZsYeuRYICt8+enC7B
         Zj7ziwYBd3J2RYffTmllgkC7JZP9mQQpSFlRMIP7zzFt/JmD2yCbNof1EMt7SGpTHq15
         n2VfLe18o06akOZuu5od5fhLGW+utr3kCUD53fZDQwnVvs2Xpx8D3Rlc6b87P/pwwc40
         gKtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=GlGVxOfc/4SeVv8qRH9Agv8rkOuTFAZd92nwAvRCJ0o=;
        b=Kp0Nq/y48J0nU88GqarFD0LYpNIQoW/KnvzdLP3/5hl5jPTefXcT7JEpXM6z1c48cR
         xxmo573cb7c1t4cJIHUT4a4IPnKzycGoSKDHup6IXM/Cs67M/RiMQtTCw1WmFUXUhXU5
         OFI9Hl64VDGYx5+BwI5Ptqd29MUctfstWtHS4MT+mSuctlPidykV86WmszuHrmv2roTB
         BljmpDthAcT/jaogFRiO1Fxcsdu4SkGibcg10ZU6wn4xsA57lHizVd4ZvIUjRj7ok7nG
         S7EVzuY7xIBBoEvmaLR3IGVhG3Hk6byeLGnLCAsZz9MNS44zL3EDWFLcBR2gEjzodcAp
         GGvQ==
X-Gm-Message-State: APt69E3lIisay+lmmBOvqgRN4Ay8qEf7t4ofZ5TLByKS9gfWnnV0EHSu
        wPWm2mSWZhe/gA8Q4ftjD3A1kQ==
X-Google-Smtp-Source: ADUXVKLES6jUj9+q4BWj7fEguqe7zRm2LzEpO9yeKW1Zl/AGjlh+uXWgTFke7cNUyHvAxytW3X21Xg==
X-Received: by 2002:a17:902:bd8f:: with SMTP id q15-v6mr20125996pls.161.1529428806064;
        Tue, 19 Jun 2018 10:20:06 -0700 (PDT)
Received: from ?IPv6:2600:1010:b023:c12a:9165:dc8d:85a7:914? ([2600:1010:b023:c12a:9165:dc8d:85a7:914])
        by smtp.gmail.com with ESMTPSA id e16-v6sm236813pfn.46.2018.06.19.10.20.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 19 Jun 2018 10:20:04 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH 06/10] x86/cet: Add arch_prctl functions for shadow stack
From:   Andy Lutomirski <luto@amacapital.net>
X-Mailer: iPhone Mail (15F79)
In-Reply-To: <CAGXu5jJ4ivrvi-kG0iY=4C0mQQXBDXwPdfY36Dk+JqOpX19n0w@mail.gmail.com>
Date:   Tue, 19 Jun 2018 10:20:03 -0700
Cc:     Yu-cheng Yu <yu-cheng.yu@intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        "H. J. Lu" <hjl.tools@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>, linux-doc@vger.kernel.org,
        Linux-MM <linux-mm@kvack.org>,
        linux-arch <linux-arch@vger.kernel.org>, X86 ML <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        "Shanbhogue, Vedvyas" <vedvyas.shanbhogue@intel.com>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Oleg Nesterov <oleg@redhat.com>, Arnd Bergmann <arnd@arndb.de>,
        mike.kravetz@oracle.com, Florian Weimer <fweimer@redhat.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <0AF8B71E-B6CC-42DE-B95C-93896196C3D7@amacapital.net>
References: <20180607143807.3611-1-yu-cheng.yu@intel.com> <20180607143807.3611-7-yu-cheng.yu@intel.com>
 <CALCETrU6axo158CiSCRRkC4GC5hib9hypC98t7LLjA3gDaacsw@mail.gmail.com>
 <1528403417.5265.35.camel@2b52.sc.intel.com> <CALCETrXz3WWgZwUXJsDTWvmqKUArQFuMH1xJdSLVKFpTysNWxg@mail.gmail.com>
 <CAMe9rOr49V8rqRa_KVsw61PWd+crkQvPDgPKtvowazjmsfgWWQ@mail.gmail.com>
 <alpine.DEB.2.21.1806121155450.2157@nanos.tec.linutronix.de>
 <CAMe9rOoCiXQ4iVD3j_AHGrvEXtoaVVZVs7H7fCuqNEuuR5j+2Q@mail.gmail.com>
 <CALCETrXO8R+RQPhJFk4oiA4PF77OgSS2Yro_POXQj1zvdLo61A@mail.gmail.com>
 <CAMe9rOpLxPussn7gKvn0GgbOB4f5W+DKOGipe_8NMam+Afd+RA@mail.gmail.com>
 <CALCETrWmGRkQvsUgRaj+j0CP4beKys+TT5aDR5+18nuphwr+Cw@mail.gmail.com>
 <CAMe9rOpzcCdje=bUVs+C1WrY6GuwA-8AUFVLOG325LGz7KHJxw@mail.gmail.com>
 <alpine.DEB.2.21.1806122046520.1592@nanos.tec.linutronix.de>
 <CAMe9rOrGjJf0aMnUjAP38MqvOiW3=iXGQjcUT3O=f9pE85hXaw@mail.gmail.com>
 <CALCETrVsh5t-V1Sm88LsZE_+DS0GE_bMWbcoX3SjD6GnrB08Pw@mail.gmail.com>
 <CAGXu5jK0gospOXRpN6zYiQPXOZeE=YpVAz2qu4Zc3-32v85+EQ@mail.gmail.com>
 <569B4719-6283-4575-A16E-D0A78D280F4E@amacapital.net> <CAGXu5jJNgu4bW_Zthqjfpe9gLxK0zxG8QFEqqK+pJNebz6tUaw@mail.gmail.com>
 <1529427588.23068.7.camel@intel.com> <CAGXu5jJ4ivrvi-kG0iY=4C0mQQXBDXwPdfY36Dk+JqOpX19n0w@mail.gmail.com>
To:     Kees Cook <keescook@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Jun 19, 2018, at 10:07 AM, Kees Cook <keescook@chromium.org> wrote:
>=20
>> On Tue, Jun 19, 2018 at 9:59 AM, Yu-cheng Yu <yu-cheng.yu@intel.com> wrot=
e:
>>> On Tue, 2018-06-19 at 09:44 -0700, Kees Cook wrote:
>>> On Tue, Jun 19, 2018 at 7:50 AM, Andy Lutomirski <luto@amacapital.net
>>>> wrote:
>>>>=20
>>>>>=20
>>>>> On Jun 18, 2018, at 5:52 PM, Kees Cook <keescook@chromium.org>
>>>>> wrote:
>>>>> Following Linus's request for "slow introduction" of new security
>>>>> features, likely the best approach is to default to "relaxed"
>>>>> (with a
>>>>> warning about down-grades), and allow distros/end-users to pick
>>>>> "forced" if they know their libraries are all CET-enabled.
>>>> I still don=E2=80=99t get what =E2=80=9Crelaxed=E2=80=9D is for.  I thi=
nk the right design
>>>> is:
>>>>=20
>>>> Processes start with CET on or off depending on the ELF note, but
>>>> they start with CET unlocked no matter what. They can freely switch
>>>> CET on and off (subject to being clever enough not to crash if they
>>>> turn it on and then return right off the end of the shadow stack)
>>>> until they call ARCH_CET_LOCK.
>>> I'm fine with this. I'd expect modern loaders to just turn on CET and
>>> ARCH_CET_LOCK immediately and be done with it. :P
>>=20
>> This is the current implementation.  If the loader has CET in its ELF
>> header, it is executed with CET on.  The loader will turn off CET if
>> the application being loaded does not support it (in the ELF header).
>> The loader calls ARCH_CET_LOCK before passing to the application.  But
>> how do we handle dlopen?
>=20
> I thought CET_LOCK would not get set in "relaxed" mode, due to dlopen
> usage, and that would be the WARN case. People without dlopen concerns
> can boot with "enforced" mode? If a system builder knows there are no
> legacy dlopens they build with enforced enabled, etc.

I think we=E2=80=99re getting ahead of ourselves. dlopen() of a non-CET-awar=
e library in a CET process is distinctly non-trivial, especially in a multit=
hreaded process. I think getting it right will require *userspace* support. =
 It certainly needs ld.so to issue to arch_prctl at a bare minimum. So I see=
 no point to a kernel-supplied =E2=80=9Crelaxed=E2=80=9D mode. I think there=
 may be demand for a ld.so relaxed mode, but it will have nothing to do with=
 boot options.

It=E2=80=99s potentially helpful to add an arch_prctl that turns CET off for=
 all threads, but only if unlocked. It would obviously be one hell of a gadg=
et.

>=20
>>>> Ptrace gets new APIs to turn CET on and off and to lock and unlock
>>>> it.  If an attacker finds a =E2=80=9Cptrace me and turn off CET=E2=80=9D=
 gadget,
>>>> then they might as well just do =E2=80=9Cptrace me and write shell code=
=E2=80=9D
>>>> instead. It=E2=80=99s basically the same gadget. Keep in mind that the
>>>> actual sequence of syscalls to do this is incredibly complicated.
>>> Right -- if an attacker can control ptrace of the target, we're way
>>> past CET. The only concern I have, though, is taking advantage of
>>> expected ptracing. For example: browsers tend to have crash handlers
>>> that launch a ptracer. If ptracing disabled CET for all threads, this
>>> won't by safe: an attacker just gains control in two threads, crashes
>>> one to get the ptracer to attach, which disables CET in the other
>>> thread and the attacker continues ROP as normal. As long as the
>>> ptrace
>>> disabling is thread-specific, I think this will be okay.
>>=20
>> If ptrace can turn CET on/off and it is thread-specific, do we still
>> need ptrace lock/unlock?

Let me clarify. I don=E2=80=99t think ptrace() should have any automatic eff=
ect on CET. I think there should be an explicit way to ask ptrace to twiddle=
 CET, and it should probably apply per thread.

>=20
> Does it provide anything beyond what PR_DUMPABLE does?

What do you mean?


>=20
> -Kees
>=20
> --=20
> Kees Cook
> Pixel Security
