Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S968460AbeEYVGh (ORCPT <rfc822;w@1wt.eu>);
        Fri, 25 May 2018 17:06:37 -0400
Received: from terminus.zytor.com ([198.137.202.136]:40265 "EHLO
        mail.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S968376AbeEYVGg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 May 2018 17:06:36 -0400
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
 <dd1626ae-114f-3817-c8b2-f845e079bfc6@zytor.com>
 <CAKwvOdkEHqv7Ut8H6Rb+gSvfWsMHqO=E3f7yxm=06m9yEn=h6w@mail.gmail.com>
 <26B017D5-4063-46CB-8768-B0E5E7CD3838@zytor.com>
 <CAKwvOdk_4g5PsRUoLgOeWEwt+d0diyD_Ycx6s7LQsJrSMsBEuA@mail.gmail.com>
 <319FB971-ABB6-4BE7-969B-D87D84853196@zytor.com>
 <CAKwvOdmryseROx=iSs6CZ86-tr90Fni8RC_w6Y7nFSXGW=508g@mail.gmail.com>
 <31A5469A-176F-451F-886A-ECD649DDC78C@zytor.com>
 <CAKwvOdkpWZC4vWK8hDdgUGseTmK4Hz5uDHn_mP9yc=jbfdVPmg@mail.gmail.com>
 <A042BB2E-FACF-4AE0-8B1E-716061666C5F@zytor.com>
 <CAKwvOdkWsxoyXCnQz+Xwh0RQ0yPPVD3iCqVaWAimW_Z4QU0XiA@mail.gmail.com>
From: "H. Peter Anvin" <hpa@zytor.com>
Message-ID: <38f21c66-fa34-3a77-33bc-d15065c15af9@zytor.com>
Date: Fri, 25 May 2018 14:06:28 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <CAKwvOdkWsxoyXCnQz+Xwh0RQ0yPPVD3iCqVaWAimW_Z4QU0XiA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/25/18 13:36, Nick Desaulniers wrote:
> On Fri, May 25, 2018 at 10:56 AM <hpa@zytor.com> wrote:
>> You need the extern inline in the .h file and the out-of-line .S file
> both.
> 
> But the out-of-line .S file looks like:
> 
> ...
>     10 ENTRY(native_save_fl)
> 
>     11   pushf
> 
>     12   pop %_ASM_AX
> 
>     13   ret
> 
>     14 ENDPROC(native_save_fl)
> 
>     15 EXPORT_SYMBOL(native_save_fl)
> ...
> 
> I don't see how you can specify to the linker from assembly source that
> this function should be treated as `extern inline`?
> 

"extern inline" is a C directive. In the header file you should provide
the inlinable implementation (which is already there.) It means that "if
you don't want to inline this there is an external implementation
available."


> I assume you don't literally mean the C keywords `extern inline` but
> whatever the equivalent incantation is needed in terms of assembler
> directives (which I also don't know).
> 
> I'm beginning to think that what you'd like to see cannot be expressed (at
> least via `extern inline`).
> 
