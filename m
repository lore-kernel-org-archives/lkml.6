Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1161561AbeEXVtp (ORCPT <rfc822;w@1wt.eu>);
        Thu, 24 May 2018 17:49:45 -0400
Received: from terminus.zytor.com ([198.137.202.136]:42261 "EHLO
        mail.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S966099AbeEXVtl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 May 2018 17:49:41 -0400
Subject: Re: [clang] stack protector and f1f029c7bf
To: Nick Desaulniers <ndesaulniers@google.com>
Cc: Alistair Strachan <astrachan@google.com>,
        Manoj Gupta <manojgupta@google.com>,
        Matthias Kaehlcke <mka@google.com>,
        Greg Hackmann <ghackmann@google.com>, sedat.dilek@gmail.com,
        tstellar@redhat.com, LKML <linux-kernel@vger.kernel.org>,
        Kees Cook <keescook@google.com>
References: <CAKwvOd=jmi_7LvZbS0PA5-zt62m5ZFPUNG7JtMQVmerCR63ebQ@mail.gmail.com>
 <BDEF22F0-84A5-4A36-B153-13E6A4260922@zytor.com>
 <CAKwvOdnLt5qr_5ah86qdsocTxUbo_3X1y3PPRp1EZwt=__NxnA@mail.gmail.com>
 <CAKwvOdmQER7XtO_uygYDBxGgUr-EruGyjUq9DMbNwQFh11=9gg@mail.gmail.com>
 <CAKwvOdkd480hmHduDHnV2ekoAm_dyPnApU9jc7TARyD072KOGA@mail.gmail.com>
From: "H. Peter Anvin" <hpa@zytor.com>
Message-ID: <40166a47-749e-e6a8-41fa-e5dc0defaaab@zytor.com>
Date: Thu, 24 May 2018 14:49:32 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <CAKwvOdkd480hmHduDHnV2ekoAm_dyPnApU9jc7TARyD072KOGA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/24/18 14:12, Nick Desaulniers wrote:
> 
> Looks like those builtins got added to GCC around the 4.9 timeframe:
> https://godbolt.org/g/9VS2E9
> 
> Problematically, it seems that GCC does not have __has_builtin to do
> feature detection:
> https://clang.llvm.org/docs/LanguageExtensions.html#feature-checking-macros
> https://godbolt.org/g/oku8ux
> 

We have support in the kernel build system for doing that, though.

I just added a concurring opinion to the gcc bug report:

https://gcc.gnu.org/bugzilla/show_bug.cgi?id=66970
