Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id C3F0DC433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 21:31:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 836252089C
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 21:31:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 836252089C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934392AbeFLVby (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jun 2018 17:31:54 -0400
Received: from terminus.zytor.com ([198.137.202.136]:45821 "EHLO
        mail.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933533AbeFLVbw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jun 2018 17:31:52 -0400
Received: from hanvin-mobl2.amr.corp.intel.com (jfdmzpr04-ext.jf.intel.com [134.134.139.73])
        (authenticated bits=0)
        by mail.zytor.com (8.15.2/8.15.2) with ESMTPSA id w5CLV8LT178792
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO);
        Tue, 12 Jun 2018 14:31:09 -0700
Subject: Re: [PATCH v4 1/3] compiler-gcc.h: add gnu_inline to all inline
 declarations
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     sedat.dilek@gmail.com, Arnd Bergmann <arnd@arndb.de>,
        Andrew Morton <akpm@linux-foundation.org>, mingo@redhat.com,
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
        akataria@vmware.com, brijesh.singh@amd.com
References: <20180607204927.219329-1-ndesaulniers@google.com>
 <20180607204927.219329-2-ndesaulniers@google.com>
 <CAK8P3a0yi+MrOS=+pjCeUu==YBE_AppB8vfqdsQS-1NpSO2c4A@mail.gmail.com>
 <CA+icZUXDoeo5ktZZPFcFyLzk3xthM-98N88QJFzesg6t+Vr5cQ@mail.gmail.com>
 <CAKwvOdmxFHfkj81YAXa8fE86fC+k+KvqMvgk4=e62pNCcXbKOg@mail.gmail.com>
 <201806121851.w5CIpTY7134381@mail.zytor.com>
 <CAKwvOdkeEqb0HnHoggpwmHiKtDo06VN0N_r9ffv0rzigNLvXUg@mail.gmail.com>
From:   "H. Peter Anvin" <hpa@zytor.com>
Message-ID: <7e375fab-f8ad-705a-dd04-f7e18952bd0c@zytor.com>
Date:   Tue, 12 Jun 2018 14:31:08 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <CAKwvOdkeEqb0HnHoggpwmHiKtDo06VN0N_r9ffv0rzigNLvXUg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/12/18 13:19, Nick Desaulniers wrote:
> 
> Oh, by [0] __GCC_STDC_INLINE__ is indeed actually the correct symbol
> to check for.  Clang does support that, so nothing to fix there.
> 
>> By the way, you should check clang against gcc's predefined macros by doing:
>>
>> gcc [options] -x c -Wp,-dM -E /dev/null | sort
>>
>> Options can change the predefined macros substantially, especially the, -std=, arch and -O options. -x c can be replaced with e.g. -x c++, objective-c, assembler-with-cpp etc.
> 
> Neat, I'll have to bookmark that incantation.  I can s/gcc/clang/ to
> get a similar list (which is how I know it supports
> __GCC_STDC_INLINE__).>

I bet that if you add -fgnu89-inlines then it *does* define
__GNUC_GNU_INLINE__.

> 
> Patch now becomes something like:
> 
> #ifdef __GNUC_GNU_INLINE__
> #define __gnu_inline __attribute__((gnu_inline))
> #else
> #define __gnu_inline
> #endif
> 
> #define inline inline __attribute__((always_inline, unused)) notrace
> __gnu_inline
> ...
> 
> Issues with that approach?
> 

s/__GNUC_GNU_INLINE__/__GNUC_STDC_INLINE__/

	-hpa

