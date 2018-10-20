Return-Path: <SRS0=g0DB=NA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07747C67863
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Oct 2018 06:02:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A7AE20843
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Oct 2018 06:02:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=dilger-ca.20150623.gappssmtp.com header.i=@dilger-ca.20150623.gappssmtp.com header.b="qdRNiDQN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9A7AE20843
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=dilger.ca
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727023AbeJTOLp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 20 Oct 2018 10:11:45 -0400
Received: from mail-it1-f194.google.com ([209.85.166.194]:53095 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726261AbeJTOLo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Oct 2018 10:11:44 -0400
Received: by mail-it1-f194.google.com with SMTP id 134-v6so6687203itz.2
        for <linux-kernel@vger.kernel.org>; Fri, 19 Oct 2018 23:02:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dilger-ca.20150623.gappssmtp.com; s=20150623;
        h=from:message-id:mime-version:subject:date:in-reply-to:cc:to
         :references;
        bh=NqTI4bEWi8W3l4KL22rcYQ1rTFJxXCggF41vE27d5Ec=;
        b=qdRNiDQN7JF/MFGWH1AEapdrUPMwgkqj4QotY0FxRJaiaruRI9ymCwPuru0vBfhJpd
         2gDLnmXpwcToP1Io0i1yLsTRbCVc3zS6rE/+y64GIqLVlRHJmHAFOgTUY5PvGEil4Fg3
         bvnSFliP6448R/47HRMDAAxdG5Q0LaLblW8M2CefdgQfaK9oe+b424N5aPXZ7tT7c5EQ
         DHfTDMZDMp/vYc7DGyGgRwiqzVtRhh5H2gdfYacJVZqfgHkbjlFyHrWioRufgOWFl/u/
         hwEXg7w5b6jFxCEO5uR9UCyRWP6TYZFwDfreEWPP93BU9P1GdNo5+7jm6exONn5ihYX3
         vjOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:message-id:mime-version:subject:date
         :in-reply-to:cc:to:references;
        bh=NqTI4bEWi8W3l4KL22rcYQ1rTFJxXCggF41vE27d5Ec=;
        b=B1ssyKqctgCCllDjvk9+wvR8cTrQ5/ldERxrfMsffbgN5Ht6sXTCoaf6VjGcW6FJ9m
         8cmyqZSzWkq0INO4Syvnrc5UwmoV/EgN3oACUUwAp5pNeeMCSA2E4LD9TWAn/M6r8e/s
         Hd8m2HwYz437z2esDFowfcEz3Cl7YGV+MWqUh62PL+cZQjnF8LYOQq09wRZEesL1qzXG
         OfVn6Uts0un/O29kMhpg5Dh+xM5b7nHztuKSDQRWXpoXEsuymZxgxiQPKbhsOZ2JInrU
         mh5rUtH2JZYLB7VOC+WBk7NQJoTM0ylDhgynpzyK7BGI0AAziXK/vJ8j28HyWtuq0FNl
         Ow7w==
X-Gm-Message-State: ABuFfoj1/ThZiirGP6ouPb2HeUIP4RM+N9vcxD6NQAp0nBiai1CGwEDz
        Sh9WTncltXQ/AluyzFU9//Dl5PlWlKcgNw==
X-Google-Smtp-Source: ACcGV61Yzd/DTml3XlFHxxL35sy6XUiZhzewNQwNVLQn9iAnQ7inkFMJdpEoNxFL1bvimUln60VHWA==
X-Received: by 2002:a02:b04b:: with SMTP id q11-v6mr3091963jah.88.1540015347396;
        Fri, 19 Oct 2018 23:02:27 -0700 (PDT)
Received: from cabot-wlan.adilger.int (S0106a84e3fe4b223.cg.shawcable.net. [70.77.216.213])
        by smtp.gmail.com with ESMTPSA id n7-v6sm2401542itb.22.2018.10.19.23.02.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 19 Oct 2018 23:02:26 -0700 (PDT)
From:   Andreas Dilger <adilger@dilger.ca>
Message-Id: <97D532AE-731F-4B44-9F2A-37A2EE48EABF@dilger.ca>
Content-Type: multipart/signed;
 boundary="Apple-Mail=_F324B551-A205-4C38-82F3-BDF1F1F8388F";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: in_compat_syscall() returns from kernel thread for X86_32.
Date:   Sat, 20 Oct 2018 00:02:23 -0600
In-Reply-To: <CALCETrWH342Y7jKHsYdT=_3fuyDkWhvQLK9z4PTs9jzbfoCVwg@mail.gmail.com>
Cc:     NeilBrown <neilb@suse.com>, Ted Ts'o <tytso@mit.edu>,
        Peter Zijlstra <peterz@infradead.org>,
        Dmitry Safonov <dsafonov@virtuozzo.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Denys Vlasenko <dvlasenk@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Borislav Petkov <bp@alien8.de>, Ingo Molnar <mingo@kernel.org>,
        Brian Gerst <brgerst@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-tip-commits@vger.kernel.org,
        James Simmons <jsimmons@infradead.org>
To:     Andy Lutomirski <luto@kernel.org>
References: <1460987025-30360-1-git-send-email-dsafonov@virtuozzo.com>
 <tip-abfb9498ee1327f534df92a7ecaea81a85913bae@git.kernel.org>
 <87h8hkc9fd.fsf@notabene.neil.brown.name>
 <CALCETrXB8PE4Ue0BeD0wUS9psLLjpv_pt+nj=SEaj+Nb_dZzUA@mail.gmail.com>
 <871s8ndg6a.fsf@notabene.neil.brown.name>
 <CALCETrWH342Y7jKHsYdT=_3fuyDkWhvQLK9z4PTs9jzbfoCVwg@mail.gmail.com>
X-Mailer: Apple Mail (2.3273)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Apple-Mail=_F324B551-A205-4C38-82F3-BDF1F1F8388F
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii

On Oct 18, 2018, at 11:26 AM, Andy Lutomirski <luto@kernel.org> wrote:
>=20
> On Wed, Oct 17, 2018 at 9:36 PM NeilBrown <neilb@suse.com> wrote:
>>=20
>> On Wed, Oct 17 2018, Andy Lutomirski wrote:
>>=20
>>> On Wed, Oct 17, 2018 at 6:48 PM NeilBrown <neilb@suse.com> wrote:
>>>>=20
>>>>=20
>>>> Was: Re: [tip:x86/asm] x86/entry: Rename is_{ia32,x32}_task() to =
in_{ia32,x32}_syscall()
>>>> On Tue, Apr 19 2016, tip-bot for Dmitry Safonov wrote:
>>>>=20
>>>>> Commit-ID:  abfb9498ee1327f534df92a7ecaea81a85913bae
>>>>> Gitweb:     =
http://git.kernel.org/tip/abfb9498ee1327f534df92a7ecaea81a85913bae
>>>>> Author:     Dmitry Safonov <dsafonov@virtuozzo.com>
>>>>> AuthorDate: Mon, 18 Apr 2016 16:43:43 +0300
>>>>> Committer:  Ingo Molnar <mingo@kernel.org>
>>>>> CommitDate: Tue, 19 Apr 2016 10:44:52 +0200
>>>>>=20
>>>>> x86/entry: Rename is_{ia32,x32}_task() to in_{ia32,x32}_syscall()
>>>>>=20
>>>> ...
>>>>> @@ -318,7 +318,7 @@ static inline bool is_x32_task(void)
>>>>>=20
>>>>> static inline bool in_compat_syscall(void)
>>>>> {
>>>>> -     return is_ia32_task() || is_x32_task();
>>>>> +     return in_ia32_syscall() || in_x32_syscall();
>>>>> }
>>>>=20
>>>> Hi,
>>>> I'm reply to this patch largely to make sure I get the right people
>>>> .....
>>>>=20
>>>> This test is always true when CONFIG_X86_32 is set, as that forces
>>>> in_ia32_syscall() to true.
>>>> However we might not be in a syscall at all - we might be running a
>>>> kernel thread which is always in 64 mode.
>>>> Every other implementation of in_compat_syscall() that I found is
>>>> dependant on a thread flag or syscall register flag, and so returns
>>>> "false" in a kernel thread.
>>>>=20
>>>> Might something like this be appropriate?
>>>>=20
>>>> diff --git a/arch/x86/include/asm/thread_info.h =
b/arch/x86/include/asm/thread_info.h
>>>> index 2ff2a30a264f..c265b40a78f2 100644
>>>> --- a/arch/x86/include/asm/thread_info.h
>>>> +++ b/arch/x86/include/asm/thread_info.h
>>>> @@ -219,7 +219,7 @@ static inline int =
arch_within_stack_frames(const void * const stack,
>>>> #ifndef __ASSEMBLY__
>>>>=20
>>>> #ifdef CONFIG_X86_32
>>>> -#define in_ia32_syscall() true
>>>> +#define in_ia32_syscall() (!(current->flags & PF_KTHREAD))
>>>> #else
>>>> #define in_ia32_syscall() (IS_ENABLED(CONFIG_IA32_EMULATION) && \
>>>>                           current_thread_info()->status & =
TS_COMPAT)
>>>>=20
>>>> This came up in the (no out-of-tree) lustre filesystem where some =
code
>>>> needs to assume 32-bit mode in X86_32 syscalls, and 64-bit mode in =
kernel
>>>> threads.
>>>>=20
>>>=20
>>> I could get on board with:
>>>=20
>>> ({WARN_ON_ONCE(current->flags & PF_KTHREAD); true})
>>>=20
>>> The point of these accessors is to be used *in a syscall*.
>>>=20
>>> What on Earth is Lustre doing that makes it have this problem?
>>=20
>> Lustre uses it in the ->getattr method to make sure ->ino, ->dev and
>> ->rdev are appropriately sized.  This isn't very different from the
>> usage in ext4 to ensure the seek offset for directories is suitable.
>>=20
>> These interfaces can be used both from systemcalls and from kernel
>> threads, such as via nfsd.
>>=20
>> I don't *know* if nfsd is the particular kthread that causes problems
>> for lustre.  All I know is that ->getattr returns 32bit squashed =
inode
>> numbers in kthread context where 64 bit numbers would be expected.
>>=20
>=20
> Well, that looks like Lustre is copying an ext4 bug.
>=20
> Hi ext4 people-
>=20
> ext4's is_32bit_api() function is bogus.  You can't use
> in_compat_syscall() unless you know you're in a syscall
>=20
> The buggy code was introduced in:
>=20
> commit d1f5273e9adb40724a85272f248f210dc4ce919a
> Author: Fan Yong <yong.fan@whamcloud.com>
> Date:   Sun Mar 18 22:44:40 2012 -0400
>=20
>    ext4: return 32/64-bit dir name hash according to usage type
>=20
> I don't know what the right solution is.  Al, is it legit at all for
> fops->llseek to care about the caller's bitness?  If what ext4 is
> doing is legit, then ISTM the VFS needs to gain a new API to tell
> ->llseek what to do.  But I'm wondering why FMODE_64BITHASH by itself
> isn't sufficient,
>=20
> I'm quite tempted to add a warning to the x86 arch code to try to
> catch this type of bug.  Fortunately, a bit of grepping suggests that
> ext4 is the only filesystem with this problem.

We need to know whether the readdir cookie returned to userspace
should be a 32-bit cookie or a 64-bit cookie.  Trying to return
a 64-bit value will result in -EOVERFLOW for a 32-bit application,
but is preferable (if possible) because it reduces the chance of
hash collisions causing readdir to have problems.

Cheers, Andreas






--Apple-Mail=_F324B551-A205-4C38-82F3-BDF1F1F8388F
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - http://gpgtools.org

iQIzBAEBCAAdFiEEDb73u6ZejP5ZMprvcqXauRfMH+AFAlvKxO8ACgkQcqXauRfM
H+BLSxAAnuQIr99B79jSl1Lt8gkdjGEmJ29j+CKNWNIMqwUGmkCCxrB1gKAAEL3a
1TzdTJLjSG8uz4HOKLkWxdXXqRgCZgofOTdA/xjhGFxWNlojFb6SIzlMglEb9tuQ
3i+MhFRn2jgLiyg8+D2+hw8RGgpcp9ILZdiyHeKgmidWTox5RBkGaIQaCroEEhYC
5AWkOFDQVvh7Ql7g9RzR6+nw1Zo/YLAYoZAxre8x/ya8dE0WX4oce5oOMDOWfFZL
ZJF20wWgkYrhHcAr0ehb5yCRlgiZiQeuIZDr8SgpI4eGE54GQi7UH0EuFn4cB8mG
aiShYX1Ie2KdGFYQaVE3qZ/2Gi66OI89RUy183LB1m0X56LVRa5ft0LSGRxvPxUl
wSwxvIxwjUM5sn344c100miNIiZiG3i/RnmntBPwkjSYcGdxWM+W47Y7IimtAAIx
dkbVUHL5El4SQdol3bRacmxjwwv6zbdh25KhOMgXmv3aoo3oVV+VIxKAj3HzdENu
nAMePqm7EbiEJMd6z+QTVNim9wAHsvc22nGqX2eJbNlm7fFgWaKQIUbbjgulHdX1
Fi3P082P1IB5By2ZVIT4hGcciwskMoaRdJuBJY0AVHj/jnoZi1eq0Tmv7GIkpeRZ
ujp9pDIs9eYPoQri/wtziYObyY3Kdmu2dlH1ZWToHX3pndY4oQo=
=iidt
-----END PGP SIGNATURE-----

--Apple-Mail=_F324B551-A205-4C38-82F3-BDF1F1F8388F--
