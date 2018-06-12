Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 42F7CC433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 18:53:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC9FB2086D
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 18:53:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EC9FB2086D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933273AbeFLSxF convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jun 2018 14:53:05 -0400
Received: from terminus.zytor.com ([198.137.202.136]:53661 "EHLO
        mail.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754083AbeFLSxC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jun 2018 14:53:02 -0400
Received: from wld62.hos.anvin.org (c-24-5-245-234.hsd1.ca.comcast.net [24.5.245.234] (may be forged))
        (authenticated bits=0)
        by mail.zytor.com (8.15.2/8.15.2) with ESMTPSA id w5CIpTY7134381
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO);
        Tue, 12 Jun 2018 11:51:29 -0700
From:   "H. Peter Anvin" <hpa@zytor.com>
Message-Id: <201806121851.w5CIpTY7134381@mail.zytor.com>
Date:   Tue, 12 Jun 2018 11:51:22 -0700
User-Agent: K-9 Mail for Android
In-Reply-To: <CAKwvOdmxFHfkj81YAXa8fE86fC+k+KvqMvgk4=e62pNCcXbKOg@mail.gmail.com>
References: <20180607204927.219329-1-ndesaulniers@google.com> <20180607204927.219329-2-ndesaulniers@google.com> <CAK8P3a0yi+MrOS=+pjCeUu==YBE_AppB8vfqdsQS-1NpSO2c4A@mail.gmail.com> <CA+icZUXDoeo5ktZZPFcFyLzk3xthM-98N88QJFzesg6t+Vr5cQ@mail.gmail.com> <CAKwvOdmxFHfkj81YAXa8fE86fC+k+KvqMvgk4=e62pNCcXbKOg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 8BIT
Subject: Re: [PATCH v4 1/3] compiler-gcc.h: add gnu_inline to all inline declarations
To:     Nick Desaulniers <ndesaulniers@google.com>, sedat.dilek@gmail.com,
        Arnd Bergmann <arnd@arndb.de>
CC:     Andrew Morton <akpm@linux-foundation.org>, mingo@redhat.com,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-efi@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        x86@kernel.org, virtualization@lists.linux-foundation.org,
        Alistair Strachan <astrachan@google.com>,
        Manoj Gupta <manojgupta@google.com>,
        Greg Hackmann <ghackmann@google.com>, tstellar@redhat.com,
        Kees Cook <keescook@google.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        geert@linux-m68k.org, Will Deacon <will.deacon@arm.com>,
        mawilcox@microsoft.com, David Rientjes <rientjes@google.com>,
        acme@redhat.com, Philippe Ombredanne <pombredanne@nexb.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        boris.ostrovsky@oracle.com, "J. Kiszka" <jan.kiszka@siemens.com>,
        rostedt@goodmis.org, kirill.shutemov@linux.intel.com,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        akataria@vmware.com, brijesh.singh@amd.com, Cao.jin@zytor.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

<caoj.fnst@cn.fujitsu.com>,Greg KH <gregkh@linuxfoundation.org>,jarkko.sakkinen@linux.intel.com,jgross@suse.com,Josh Poimboeuf <jpoimboe@redhat.com>,Matthias Kaehlcke <mka@chromium.org>,thomas.lendacky@amd.com,Thiebaud Weksteen <tweek@google.com>,mjg59@google.com,joe@perches.com
From: hpa@zytor.com
Message-ID: <191E4EBE-4CB2-4C8B-AB61-689A91FFE7A8@zytor.com>

On June 12, 2018 11:33:14 AM PDT, Nick Desaulniers <ndesaulniers@google.com> wrote:
>On Fri, Jun 8, 2018 at 3:04 AM Sedat Dilek <sedat.dilek@gmail.com>
>wrote:
>>
>> On Fri, Jun 8, 2018 at 9:59 AM, Arnd Bergmann <arnd@arndb.de> wrote:
>> > On Thu, Jun 7, 2018 at 10:49 PM, Nick Desaulniers
>> > <ndesaulniers@google.com> wrote:
>> >> Functions marked extern inline do not emit an externally visible
>> >> function when the gnu89 C standard is used. Some KBUILD Makefiles
>> >> overwrite KBUILD_CFLAGS. This is an issue for GCC 5.1+ users as
>without
>> >> an explicit C standard specified, the default is gnu11. Since c99,
>the
>> >> semantics of extern inline have changed such that an externally
>visible
>> >> function is always emitted. This can lead to multiple definition
>errors
>> >> of extern inline functions at link time of compilation units whose
>build
>> >> files have removed an explicit C standard compiler flag for users
>of GCC
>> >> 5.1+ or Clang.
>> >>
>> >> Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
>> >> Suggested-by: H. Peter Anvin <hpa@zytor.com>
>> >> Suggested-by: Joe Perches <joe@perches.com>
>> >
>> > I suspect this will break Geert's gcc-4.1.2, which I think doesn't
>have that
>> > attribute yet (4.1.3 or higher have it according to the
>documentation.
>> >
>> > It wouldn't be hard to work around that if we want to keep that
>version
>> > working, or we could decide that it's time to officially stop
>supporting
>> > that version, but we should probably decide on one or the other.
>
>Heh, so earlier we decided against compiler flags (-std=gnu89 or
>-fgnu89-inline) in preference to function attributes.  The function
>attribute is preferable as some of the Makefiles [accidentally?]
>overwrite KBUILD_CFLAGS, which is problematic for gcc 5.1 users as the
>implicit c standard used was changed to gnu11 from gnu89.  What's nice
>is that to support gcc 4.1 users, we simply don't need to add any
>attribute, as their implicit c standard is gnu89 which has the
>semantics for extern inline that we want.  I have a simple change to
>this patch that can support users of various gcc versions, see below:
>
>> Good point.
>> What is the minimum requirement of GCC version currently?
>> AFAICS x86/asm-goto support requires GCC >= 4.5?
>
>Yes, but that's only for x86, IIUC.  It seems the kernel may have
>different minimum required versions of GCC based on arch then?  That
>may be ok, but I'm not sure that's easy to keep track of without
>having it explicitly stated somewhere like the docs perhaps?
>
>> Just FYI...
>> ...saw the last days in upstream commits that kbuild/kconfig for
>> 4.18-rc1 offers possibilities to check for cc-version dependencies.
>
>Those will be helpful.  If we want to pursue compiler flags, which get
>set some Makefiles, then yes.  But I think a simpler change to my
>patch would be as below.
>
>It seems gcc did not get __has_attribute [0] until 5.1, but will
>define __GNUC_GNU_INLINE__ if supported. [1]  Unfortunately, Clang
>does not define __GNUC_GNU_INLINE__ [2].  So a proper feature test
>might look like:
>
>```
>#ifndef __has_attribute
>#define __has_attribute(x) 0
>#endif
>
>#if defined(__GNUC_GNU_INLINE__) || __has_attribute(gnu_inline)
>#define __gnu_inline __attribute__(gnu_inline)
>#endif
>
>#define inline inline __attribute__((always_inline, unused)) notrace
>__gnu_inline
>```
>
>Thoughts on this approach? I can send a v5 tomorrow if there's no
>major issues.  Feedback appreciated, as always.
>
>[0] https://clang.llvm.org/docs/LanguageExtensions.html#has-attribute
>[1]
>https://gcc.gnu.org/onlinedocs/gcc/Common-Function-Attributes.html#Common-Function-Attributes
>[2] https://bugs.llvm.org/show_bug.cgi?id=37784

Please fix clang. It isn't all that hard to fix.

However, __GCC_GNU_INLINE__ means you are in GNU mode by default, on gcc's new enough to have multiple misses.

The right thing to look for is __GCC_STDC_INLINE__ in which case you need the attribute.

By the way, you should check clang against gcc's predefined macros by doing:

gcc [options] -x c -Wp,-dM -E /dev/null | sort

Options can change the predefined macros substantially, especially the, -std=, arch and -O options. -x c can be replaced with e.g. -x c++, objective-c, assembler-with-cpp etc.
-- 
Sent from my Android device with K-9 Mail. Please excuse my brevity.
