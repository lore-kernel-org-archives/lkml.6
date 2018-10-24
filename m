Return-Path: <SRS0=AzW9=NE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06E36C46475
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 03:03:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD2CE2082F
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 03:03:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AD2CE2082F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726735AbeJXL3m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Oct 2018 07:29:42 -0400
Received: from mx2.suse.de ([195.135.220.15]:56220 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725896AbeJXL3m (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Oct 2018 07:29:42 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id B55ADB039;
        Wed, 24 Oct 2018 01:48:10 +0000 (UTC)
From:   NeilBrown <neilb@suse.com>
To:     Andy Lutomirski <luto@kernel.org>, Ted Ts'o <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>
Date:   Wed, 24 Oct 2018 12:47:57 +1100
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Dmitry Safonov <dsafonov@virtuozzo.com>,
        Andrew Lutomirski <luto@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Denys Vlasenko <dvlasenk@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Borislav Petkov <bp@alien8.de>, Ingo Molnar <mingo@kernel.org>,
        Brian Gerst <brgerst@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-tip-commits@vger.kernel.org, jsimmons@infradead.org
Subject: Re: in_compat_syscall() returns from kernel thread for X86_32.
In-Reply-To: <CALCETrWH342Y7jKHsYdT=_3fuyDkWhvQLK9z4PTs9jzbfoCVwg@mail.gmail.com>
References: <1460987025-30360-1-git-send-email-dsafonov@virtuozzo.com> <tip-abfb9498ee1327f534df92a7ecaea81a85913bae@git.kernel.org> <87h8hkc9fd.fsf@notabene.neil.brown.name> <CALCETrXB8PE4Ue0BeD0wUS9psLLjpv_pt+nj=SEaj+Nb_dZzUA@mail.gmail.com> <871s8ndg6a.fsf@notabene.neil.brown.name> <CALCETrWH342Y7jKHsYdT=_3fuyDkWhvQLK9z4PTs9jzbfoCVwg@mail.gmail.com>
Message-ID: <871s8g6roy.fsf@notabene.neil.brown.name>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha256; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=
Content-Type: text/plain

On Thu, Oct 18 2018, Andy Lutomirski wrote:

> On Wed, Oct 17, 2018 at 9:36 PM NeilBrown <neilb@suse.com> wrote:
>>
>> On Wed, Oct 17 2018, Andy Lutomirski wrote:
>>
>> > On Wed, Oct 17, 2018 at 6:48 PM NeilBrown <neilb@suse.com> wrote:
>> >>
>> >>
>> >> Was: Re: [tip:x86/asm] x86/entry: Rename is_{ia32,x32}_task() to in_{ia32,x32}_syscall()
>> >> On Tue, Apr 19 2016, tip-bot for Dmitry Safonov wrote:
>> >>
>> >> > Commit-ID:  abfb9498ee1327f534df92a7ecaea81a85913bae
>> >> > Gitweb:     http://git.kernel.org/tip/abfb9498ee1327f534df92a7ecaea81a85913bae
>> >> > Author:     Dmitry Safonov <dsafonov@virtuozzo.com>
>> >> > AuthorDate: Mon, 18 Apr 2016 16:43:43 +0300
>> >> > Committer:  Ingo Molnar <mingo@kernel.org>
>> >> > CommitDate: Tue, 19 Apr 2016 10:44:52 +0200
>> >> >
>> >> > x86/entry: Rename is_{ia32,x32}_task() to in_{ia32,x32}_syscall()
>> >> >
>> >> ...
>> >> > @@ -318,7 +318,7 @@ static inline bool is_x32_task(void)
>> >> >
>> >> >  static inline bool in_compat_syscall(void)
>> >> >  {
>> >> > -     return is_ia32_task() || is_x32_task();
>> >> > +     return in_ia32_syscall() || in_x32_syscall();
>> >> >  }
>> >>
>> >> Hi,
>> >>  I'm reply to this patch largely to make sure I get the right people
>> >>  .....
>> >>
>> >> This test is always true when CONFIG_X86_32 is set, as that forces
>> >> in_ia32_syscall() to true.
>> >> However we might not be in a syscall at all - we might be running a
>> >> kernel thread which is always in 64 mode.
>> >> Every other implementation of in_compat_syscall() that I found is
>> >> dependant on a thread flag or syscall register flag, and so returns
>> >> "false" in a kernel thread.
>> >>
>> >> Might something like this be appropriate?
>> >>
>> >> diff --git a/arch/x86/include/asm/thread_info.h b/arch/x86/include/asm/thread_info.h
>> >> index 2ff2a30a264f..c265b40a78f2 100644
>> >> --- a/arch/x86/include/asm/thread_info.h
>> >> +++ b/arch/x86/include/asm/thread_info.h
>> >> @@ -219,7 +219,7 @@ static inline int arch_within_stack_frames(const void * const stack,
>> >>  #ifndef __ASSEMBLY__
>> >>
>> >>  #ifdef CONFIG_X86_32
>> >> -#define in_ia32_syscall() true
>> >> +#define in_ia32_syscall() (!(current->flags & PF_KTHREAD))
>> >>  #else
>> >>  #define in_ia32_syscall() (IS_ENABLED(CONFIG_IA32_EMULATION) && \
>> >>                            current_thread_info()->status & TS_COMPAT)
>> >>
>> >> This came up in the (no out-of-tree) lustre filesystem where some code
>> >> needs to assume 32-bit mode in X86_32 syscalls, and 64-bit mode in kernel
>> >> threads.
>> >>
>> >
>> > I could get on board with:
>> >
>> > ({WARN_ON_ONCE(current->flags & PF_KTHREAD); true})
>> >
>> > The point of these accessors is to be used *in a syscall*.
>> >
>> > What on Earth is Lustre doing that makes it have this problem?
>>
>> Lustre uses it in the ->getattr method to make sure ->ino, ->dev and
>> ->rdev are appropriately sized.  This isn't very different from the
>> usage in ext4 to ensure the seek offset for directories is suitable.
>>
>> These interfaces can be used both from systemcalls and from kernel
>> threads, such as via nfsd.
>>
>> I don't *know* if nfsd is the particular kthread that causes problems
>> for lustre.  All I know is that ->getattr returns 32bit squashed inode
>> numbers in kthread context where 64 bit numbers would be expected.
>>
>
> Well, that looks like Lustre is copying an ext4 bug.

I doubt it was copied - more likely independent evolution.
But on reflection, I see that it is probably reasonable that it
shouldn't be used this way - or at all in this context.
I'll try to understand what the issues really are and see if I can
find a solution that doesn't depend on this interface.
Thanks for your help.

NeilBrown


>
> Hi ext4 people-
>
> ext4's is_32bit_api() function is bogus.  You can't use
> in_compat_syscall() unless you know you're in a syscall
>
> The buggy code was introduced in:
>
> commit d1f5273e9adb40724a85272f248f210dc4ce919a
> Author: Fan Yong <yong.fan@whamcloud.com>
> Date:   Sun Mar 18 22:44:40 2012 -0400
>
>     ext4: return 32/64-bit dir name hash according to usage type
>
> I don't know what the right solution is.  Al, is it legit at all for
> fops->llseek to care about the caller's bitness?  If what ext4 is
> doing is legit, then ISTM the VFS needs to gain a new API to tell
> ->llseek what to do.  But I'm wondering why FMODE_64BITHASH by itself
> isn't sufficient,
>
> I'm quite tempted to add a warning to the x86 arch code to try to
> catch this type of bug.  Fortunately, a bit of grepping suggests that
> ext4 is the only filesystem with this problem.
>
> --Andy

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEG8Yp69OQ2HB7X0l6Oeye3VZigbkFAlvPz04ACgkQOeye3VZi
gbkZrw//Xw6l5PW3/4PIWRyzyGPwgKsaWKcFWULHCPzWzEkwSpofc+HTJfMWqlBa
jOmn08Ht7jzdWZbQsgaEUFU9zQ/lNquO3A0Ykh8jUVpGNR+6Baj1pKS0wLFWIDle
kyy8XGilUWwOHwPVBIi65OEfCKuUd5naEzzzy7V7O4HuAaM79fCPZCW1vyb6bZDP
SePHXB8NaxJjneraQkYBbjMd1cM/BexbU3wn9EfM1bZrRPhc2S7tYVlkacmuHpG+
KERnUTAH+V8UXpiyBCuEf1F6MS9hq+/QhPODlqVsf30LuVmHjxMFl6rWMGShy1ed
uM9UFy9jsKEyVoIlBDx0A9UjhxkwDSTJN012HvWBld2H3dfq820I+wIl2ULMPZQF
4nWcaIUP8RPXzV10r6oGgNMOrWsN0t+VujqShBag4GVpUP5Pb1rvzaWXny5mNpCJ
8nUWVui26wUx9Vp7qH71Nf4eCSkUj06gVZbUeDqr6sjL8UnTtVZP+dS6HNV/v3b+
XbFSEKTGuCHVXDTG9NXGIs8waU4fwhP9qB5H/Td4KOgv9MWT6GhH2mBIqSwtCCyg
ChoCGIrpVn4kXYqo+WFV+dlXywdELIoeCPGjIg6monq+UmTePkW9iM1g+I2aporT
DCfISoVexvsuyRxY8hfiWJJf2mZ63RkJaH28tTVlYP6QBnYRIgU=
=0azg
-----END PGP SIGNATURE-----
--=-=-=--
