Return-Path: <kernel-hardening-return-12105-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AG47ELuSTjPWTbXmKvpisOJGhFmyILgsX4xtm47NS+etPxcAubZYZpT4MJcM7BGISWyvYvKZ6C/m
ARC-Seal: i=1; a=rsa-sha256; t=1520265930; cv=none;
        d=google.com; s=arc-20160816;
        b=kU4VHmXFOa9ULuJ0ZgnawKmcMGPVQ8inkzaY6kvmIVg67TCdpzMaiHOJc0klbQAYV9
         BQQe1NA/1lHsiefEa8bLN1nz0cybNbBtNc7ueEIhWPjzpxoWLPKvWFjqEMD6IImZ655M
         ZR6iX6GGm1KVGU0UROnI6+nP2fcMLuaqK9zSG3Hm0x5kMhi6h8Pvy7qnIgfSblUbSdlp
         Re6Ic6AcZufaYQSHPdcVl1iQJOKj+2WryeZzs6hzFLVCXx7noKxTdO4sqyBNvbXrH0tp
         hH6zztQzQNYgyw9sKx+H60CENvmcy4uzdE5Ik/BDBpz25SrqIZ+ehay224N3yTQCMXdl
         GQsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:dkim-signature:delivered-to
         :list-id:list-subscribe:list-unsubscribe:list-help:list-post
         :precedence:mailing-list:arc-authentication-results;
        bh=Brhb63k5tXeR3zAWkCQfG+j0SRWIESRW7IQtgqH9sfw=;
        b=iQXsqZwG5yF5UKejW3cPv5jGKeoIfoRvj8RRsgRTSO2hJckDYSdF/aJEFwaqg5q9P+
         ur14dn6CSHM2WTbuzBTGLKCE5ssEzsQjiEaVlMaYBg6DiUY8xHTYQWp+KA5KDYNXbrBz
         UqCYOonov2DJpeCIeLibwoFjNR37x5QdXJ0pqihNccmYpjRNBYyM78fEJ4p5i63GEDcb
         JsbLsPvsA7p645o5NUfaP9TUbdRaDXwhfizUnm6WoTnIJeMQOrmVaTUe4kYvxDFQwf4h
         u7zwxwuzJllmFyiLxIQRgXp0EeAcQDg/VFG41g4wizv4gOAAsYB81gOfSNUZqwI648tF
         Megg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=WWGGJkOb;
       spf=pass (google.com: domain of kernel-hardening-return-12105-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12105-gregkh=linuxfoundation.org@lists.openwall.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=WWGGJkOb;
       spf=pass (google.com: domain of kernel-hardening-return-12105-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12105-gregkh=linuxfoundation.org@lists.openwall.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 11.2 \(3445.5.20\))
Subject: Re: [RFC PATCH] Randomization of address chosen by mmap.
From: Ilya Smith <blackzert@gmail.com>
In-Reply-To: <CA+DvKQKHqVzk9u2GwSC+F2vF938DY4Heb+JexwOSZhfcFkuqcw@mail.gmail.com>
Date: Mon, 5 Mar 2018 19:05:08 +0300
Cc: Matthew Wilcox <willy@infradead.org>,
 Kees Cook <keescook@chromium.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 Dan Williams <dan.j.williams@intel.com>,
 Michal Hocko <mhocko@suse.com>,
 "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
 Jan Kara <jack@suse.cz>,
 Jerome Glisse <jglisse@redhat.com>,
 Hugh Dickins <hughd@google.com>,
 Helge Deller <deller@gmx.de>,
 Andrea Arcangeli <aarcange@redhat.com>,
 Oleg Nesterov <oleg@redhat.com>,
 Linux-MM <linux-mm@kvack.org>,
 LKML <linux-kernel@vger.kernel.org>,
 Kernel Hardening <kernel-hardening@lists.openwall.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <896E6047-A49F-4E2E-A831-34CC2AD48550@gmail.com>
References: <20180227131338.3699-1-blackzert@gmail.com>
 <CAGXu5jKF7ysJqj57ZktrcVL4G2NWOFHCud8dtXFHLs=tvVLXnQ@mail.gmail.com>
 <55C92196-5398-4C19-B7A7-6C122CD78F32@gmail.com>
 <20180228183349.GA16336@bombadil.infradead.org>
 <CA+DvKQKoo1U7T_iOOLhfEf9c+K1pzD068au+kGtx0RokFFNKHw@mail.gmail.com>
 <2CF957C6-53F2-4B00-920F-245BEF3CA1F6@gmail.com>
 <CA+DvKQ+mrnm4WX+3cBPuoSLFHmx2Zwz8=FsEx51fH-7yQMAd9w@mail.gmail.com>
 <20180304034704.GB20725@bombadil.infradead.org>
 <20180304205614.GC23816@bombadil.infradead.org>
 <7FA6631B-951F-42F4-A7BF-8E5BB734D709@gmail.com>
 <CA+DvKQKHqVzk9u2GwSC+F2vF938DY4Heb+JexwOSZhfcFkuqcw@mail.gmail.com>
To: Daniel Micay <danielmicay@gmail.com>
X-Mailer: Apple Mail (2.3445.5.20)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593560218941631465?=
X-GMAIL-MSGID: =?utf-8?q?1594114368313595617?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

> On 5 Mar 2018, at 17:23, Daniel Micay <danielmicay@gmail.com> wrote:
> I didn't suggest this as the way of implementing fine-grained
> randomization but rather a small starting point for hardening address
> space layout further. I don't think it should be tied to a mmap flag
> but rather something like a personality flag or a global sysctl. It
> doesn't need to be random at all to be valuable, and it's just a first
> step. It doesn't mean there can't be switches between random pivots
> like OpenBSD mmap, etc. I'm not so sure that randomly switching around
> is going to result in isolating things very well though.
>=20

Here I like the idea of Kees Cook:
> I think this will need a larger knob -- doing this by default is
> likely to break stuff, I'd imagine? Bikeshedding: I'm not sure if this
> should be setting "3" for /proc/sys/kernel/randomize_va_space, or a
> separate one like /proc/sys/mm/randomize_mmap_allocation.
I mean it should be a way to turn randomization off since some =
applications are=20
really need huge memory.
If you have suggestion here, would be really helpful to discuss.
I think one switch might be done globally for system administrate like=20=

/proc/sys/mm/randomize_mmap_allocation and another one would be good to =
have=20
some ioctl to switch it of in case if application knows what to do.

I would like to implement it in v2 of the patch.

>> I can=E2=80=99t understand what direction this conversation is going =
to. I was talking
>> about weak implementation in Linux kernel but got many comments about =
ASLR
>> should be implemented in user mode what is really weird to me.
>=20
> That's not what I said. I was saying that splitting things into
> regions based on the type of allocation works really well and allows
> for high entropy bases, but that the kernel can't really do that right
> now. It could split up code that starts as PROT_EXEC into a region but
> that's generally not how libraries are mapped in so it won't know
> until mprotect which is obviously too late. Unless it had some kind of
> type key passed from userspace, it can't really do that.

Yes, thats really true. I wrote about earlier. This is the issue - =
kernel can=E2=80=99t=20
provide such interface thats why I try to get maximum from current mmap =
design.=20
May be later we could split mmap on different actions by different types =
of=20
memory it handles. But it will be a very long road I think.=20

>> I think it is possible  to add GUARD pages into my implementations, =
but initially
>> problem was about entropy of address choosing. I would like to =
resolve it step by
>> step.
>=20
> Starting with fairly aggressive fragmentation of the address space is
> going to be a really hard sell. The costs of a very spread out address
> space in terms of TLB misses, etc. are unclear. Starting with enforced
> gaps (1 page) and randomization for those wouldn't rule out having
> finer-grained randomization, like randomly switching between different
> regions. This needs to be cheap enough that people want to enable it,
> and the goals need to be clearly spelled out. The goal needs to be
> clearer than "more randomization =3D=3D good" and then accepting a =
high
> performance cost for that.
>=20

I want to clarify. As I know TLB caches doesn=E2=80=99t care about =
distance between=20
pages, since it works with pages. So in theory TLB miss is not an issue =
here. I=20
agree, I need to show the performance costs here. I will. Just give some =
time=20
please.

The enforced gaps, in my case:
+	addr =3D get_random_long() % ((high - low) >> PAGE_SHIFT);
+	addr =3D low + (addr << PAGE_SHIFT);
but what you saying, entropy here should be decreased.

How about something like this:
+	addr =3D get_random_long() % min(((high - low) >> PAGE_SHIFT),=20=

MAX_SECURE_GAP );
+	addr =3D high - (addr << PAGE_SHIFT);
where MAX_SECURE_GAP is configurable. Probably with sysctl.

How do you like it?

> I'm not dictating how things should be done, I don't have any say
> about that. I'm just trying to discuss it.

Sorry, thanks for your involvement. I=E2=80=99m really appreciate it.=20

Thanks,
Ilya
