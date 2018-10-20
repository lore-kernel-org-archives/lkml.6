Return-Path: <SRS0=g0DB=NA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EC2BC67863
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Oct 2018 07:58:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 45A552150C
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Oct 2018 07:58:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=amacapital-net.20150623.gappssmtp.com header.i=@amacapital-net.20150623.gappssmtp.com header.b="Gp216Xeh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 45A552150C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amacapital.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727235AbeJTQIP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 20 Oct 2018 12:08:15 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:39895 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726261AbeJTQIP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Oct 2018 12:08:15 -0400
Received: by mail-pf1-f194.google.com with SMTP id c25-v6so17515347pfe.6
        for <linux-kernel@vger.kernel.org>; Sat, 20 Oct 2018 00:58:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=Mfij2nQl4hxXxIRPwLqwUyi7mpNt1N0vIRWq7xFjbuk=;
        b=Gp216XehxWybN9ONA+z/RoF1tSdPcwbU9q/W8gL7+XxTg5Hp8X7DF/5ewc02rtM1xr
         JmjF46s4FpPla+KnHaKRqZyvP+Yvdu7wV0/OO6rPpwkoXPwaD1sOU56bpssthFloDUuw
         1ADhDbQqaA33k0NLpnSA7UJoHwBgu5aUKMBtcHYnrH4W+HAmBqL/9/rDet8KnFdN5ZWJ
         c2rbN+Zo64UZgcqPYw4LtFxBfTmE/+QoOLekk6B1TwJB1JLwlSXDksP7ArOBnESzsL6v
         9iA/smFHfYudwcfxrc/PzfpEvgAItcgdDBomI4ET5VLI+sdKfmbqYj1QDJK9JdEj4/NH
         s7ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=Mfij2nQl4hxXxIRPwLqwUyi7mpNt1N0vIRWq7xFjbuk=;
        b=QtHsPjfkaoBS9+8FUkmlOs+UjSChZqstS+tJVXEaa7kabjNXfH+SbW5FBnD7JqucwC
         GM1GuNDdXpJQdkh8KWpHgn+X1OzfobKMz77cfEPBZW/S9iZ7U3Stm0ZZ7KoHtGBWjo3n
         2j/r6p5xKK/S9BmQWigPUIEXQO2xwJbvER6NuTEJDG+f9qAQEHug+ch2MTU3QsrzHfxJ
         8EITxTsHD0qw0mfV5nyh0Zjr3LugUng8f+umt+o3MWTu+pScAqHNH66Bx/SyMyy8SEu6
         IpfQ/YkYshLEmxqbJOz1UP8VJHUCXCq76U2NuN4SrwrlvvZ1iFALH5m1GfLc0spVssLQ
         pq+Q==
X-Gm-Message-State: ABuFfohEDNzqQAO3BZ0StNPp0sjqfsbuyWt/B4/6mx4QLF06pSkEBZXC
        jV45gLaKStc0GpuCnmQzZkN1hg==
X-Google-Smtp-Source: ACcGV611t/li0+lMufksSMexnxral3x3ztlSIckE/RZV17Hi9Sm5hZxPGPymYhEJftjUlywDjTKpbw==
X-Received: by 2002:a62:da1a:: with SMTP id c26-v6mr27001604pfh.52.1540022321547;
        Sat, 20 Oct 2018 00:58:41 -0700 (PDT)
Received: from ?IPv6:2601:646:c200:7429:991f:5636:8730:192a? ([2601:646:c200:7429:991f:5636:8730:192a])
        by smtp.gmail.com with ESMTPSA id 189-v6sm30004628pfe.121.2018.10.20.00.58.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 20 Oct 2018 00:58:40 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (1.0)
Subject: Re: in_compat_syscall() returns from kernel thread for X86_32.
From:   Andy Lutomirski <luto@amacapital.net>
X-Mailer: iPhone Mail (16A366)
In-Reply-To: <97D532AE-731F-4B44-9F2A-37A2EE48EABF@dilger.ca>
Date:   Sat, 20 Oct 2018 00:58:39 -0700
Cc:     Andy Lutomirski <luto@kernel.org>, NeilBrown <neilb@suse.com>,
        Ted Ts'o <tytso@mit.edu>,
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
Content-Transfer-Encoding: quoted-printable
Message-Id: <324DA988-B44C-4B98-A74F-BC5EDBE69C46@amacapital.net>
References: <1460987025-30360-1-git-send-email-dsafonov@virtuozzo.com> <tip-abfb9498ee1327f534df92a7ecaea81a85913bae@git.kernel.org> <87h8hkc9fd.fsf@notabene.neil.brown.name> <CALCETrXB8PE4Ue0BeD0wUS9psLLjpv_pt+nj=SEaj+Nb_dZzUA@mail.gmail.com> <871s8ndg6a.fsf@notabene.neil.brown.name> <CALCETrWH342Y7jKHsYdT=_3fuyDkWhvQLK9z4PTs9jzbfoCVwg@mail.gmail.com> <97D532AE-731F-4B44-9F2A-37A2EE48EABF@dilger.ca>
To:     Andreas Dilger <adilger@dilger.ca>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Oct 19, 2018, at 11:02 PM, Andreas Dilger <adilger@dilger.ca> wrote:
>=20
>> On Oct 18, 2018, at 11:26 AM, Andy Lutomirski <luto@kernel.org> wrote:
>>=20
>>> On Wed, Oct 17, 2018 at 9:36 PM NeilBrown <neilb@suse.com> wrote:
>>>=20
>>>> On Wed, Oct 17 2018, Andy Lutomirski wrote:
>>>>=20
>>>>> On Wed, Oct 17, 2018 at 6:48 PM NeilBrown <neilb@suse.com> wrote:
>>>>>=20
>>>>>=20
>>>>> Was: Re: [tip:x86/asm] x86/entry: Rename is_{ia32,x32}_task() to in_{i=
a32,x32}_syscall()
>>>>>> On Tue, Apr 19 2016, tip-bot for Dmitry Safonov wrote:
>>>>>>=20
>>>>>> Commit-ID:  abfb9498ee1327f534df92a7ecaea81a85913bae
>>>>>> Gitweb:     http://git.kernel.org/tip/abfb9498ee1327f534df92a7ecaea81=
a85913bae
>>>>>> Author:     Dmitry Safonov <dsafonov@virtuozzo.com>
>>>>>> AuthorDate: Mon, 18 Apr 2016 16:43:43 +0300
>>>>>> Committer:  Ingo Molnar <mingo@kernel.org>
>>>>>> CommitDate: Tue, 19 Apr 2016 10:44:52 +0200
>>>>>>=20
>>>>>> x86/entry: Rename is_{ia32,x32}_task() to in_{ia32,x32}_syscall()
>>>>>>=20
>>>>> ...
>>>>>> @@ -318,7 +318,7 @@ static inline bool is_x32_task(void)
>>>>>>=20
>>>>>> static inline bool in_compat_syscall(void)
>>>>>> {
>>>>>> -     return is_ia32_task() || is_x32_task();
>>>>>> +     return in_ia32_syscall() || in_x32_syscall();
>>>>>> }
>>>>>=20
>>>>> Hi,
>>>>> I'm reply to this patch largely to make sure I get the right people
>>>>> .....
>>>>>=20
>>>>> This test is always true when CONFIG_X86_32 is set, as that forces
>>>>> in_ia32_syscall() to true.
>>>>> However we might not be in a syscall at all - we might be running a
>>>>> kernel thread which is always in 64 mode.
>>>>> Every other implementation of in_compat_syscall() that I found is
>>>>> dependant on a thread flag or syscall register flag, and so returns
>>>>> "false" in a kernel thread.
>>>>>=20
>>>>> Might something like this be appropriate?
>>>>>=20
>>>>> diff --git a/arch/x86/include/asm/thread_info.h b/arch/x86/include/asm=
/thread_info.h
>>>>> index 2ff2a30a264f..c265b40a78f2 100644
>>>>> --- a/arch/x86/include/asm/thread_info.h
>>>>> +++ b/arch/x86/include/asm/thread_info.h
>>>>> @@ -219,7 +219,7 @@ static inline int arch_within_stack_frames(const v=
oid * const stack,
>>>>> #ifndef __ASSEMBLY__
>>>>>=20
>>>>> #ifdef CONFIG_X86_32
>>>>> -#define in_ia32_syscall() true
>>>>> +#define in_ia32_syscall() (!(current->flags & PF_KTHREAD))
>>>>> #else
>>>>> #define in_ia32_syscall() (IS_ENABLED(CONFIG_IA32_EMULATION) && \
>>>>>                          current_thread_info()->status & TS_COMPAT)
>>>>>=20
>>>>> This came up in the (no out-of-tree) lustre filesystem where some code=

>>>>> needs to assume 32-bit mode in X86_32 syscalls, and 64-bit mode in ker=
nel
>>>>> threads.
>>>>>=20
>>>>=20
>>>> I could get on board with:
>>>>=20
>>>> ({WARN_ON_ONCE(current->flags & PF_KTHREAD); true})
>>>>=20
>>>> The point of these accessors is to be used *in a syscall*.
>>>>=20
>>>> What on Earth is Lustre doing that makes it have this problem?
>>>=20
>>> Lustre uses it in the ->getattr method to make sure ->ino, ->dev and
>>> ->rdev are appropriately sized.  This isn't very different from the
>>> usage in ext4 to ensure the seek offset for directories is suitable.
>>>=20
>>> These interfaces can be used both from systemcalls and from kernel
>>> threads, such as via nfsd.
>>>=20
>>> I don't *know* if nfsd is the particular kthread that causes problems
>>> for lustre.  All I know is that ->getattr returns 32bit squashed inode
>>> numbers in kthread context where 64 bit numbers would be expected.
>>>=20
>>=20
>> Well, that looks like Lustre is copying an ext4 bug.
>>=20
>> Hi ext4 people-
>>=20
>> ext4's is_32bit_api() function is bogus.  You can't use
>> in_compat_syscall() unless you know you're in a syscall
>>=20
>> The buggy code was introduced in:
>>=20
>> commit d1f5273e9adb40724a85272f248f210dc4ce919a
>> Author: Fan Yong <yong.fan@whamcloud.com>
>> Date:   Sun Mar 18 22:44:40 2012 -0400
>>=20
>>   ext4: return 32/64-bit dir name hash according to usage type
>>=20
>> I don't know what the right solution is.  Al, is it legit at all for
>> fops->llseek to care about the caller's bitness?  If what ext4 is
>> doing is legit, then ISTM the VFS needs to gain a new API to tell
>> ->llseek what to do.  But I'm wondering why FMODE_64BITHASH by itself
>> isn't sufficient,
>>=20
>> I'm quite tempted to add a warning to the x86 arch code to try to
>> catch this type of bug.  Fortunately, a bit of grepping suggests that
>> ext4 is the only filesystem with this problem.
>=20
> We need to know whether the readdir cookie returned to userspace
> should be a 32-bit cookie or a 64-bit cookie.  Trying to return
> a 64-bit value will result in -EOVERFLOW for a 32-bit application,
> but is preferable (if possible) because it reduces the chance of
> hash collisions causing readdir to have problems.
>=20
>=20

Let=E2=80=99s rope Al in. Sorry, I thought he was already on cc.

The concept seems reasonable, but the implementation is problematic. For exa=
mple, the behavior of calling vfs_llseek() is basically undefined.

Is some VFS change needed to fix this?  Maybe a .compat_llseek or some other=
 explicit indication of whether a 64-bit hash is okay?=
