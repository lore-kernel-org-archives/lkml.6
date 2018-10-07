Return-Path: <SRS0=94iy=MT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC624C65C1B
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Oct 2018 19:52:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 450E72084D
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Oct 2018 19:52:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 450E72084D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728415AbeJHDBA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 7 Oct 2018 23:01:00 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48420 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726365AbeJHDBA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Oct 2018 23:01:00 -0400
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.25])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 2D72230E6842;
        Sun,  7 Oct 2018 19:52:37 +0000 (UTC)
Received: from localhost.localdomain (ovpn-112-2.rdu2.redhat.com [10.10.112.2])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 1EF292010D55;
        Sun,  7 Oct 2018 19:52:25 +0000 (UTC)
Subject: Re: PROPOSAL: Extend inline asm syntax with size spec
To:     Nadav Amit <namit@vmware.com>, Richard Biener <rguenther@suse.de>,
        Borislav Petkov <bp@alien8.de>,
        "gcc@gcc.gnu.org" <gcc@gcc.gnu.org>, Michael Matz <matz@suse.de>
Cc:     Ingo Molnar <mingo@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Alok Kataria <akataria@vmware.com>,
        Christopher Li <sparse@chrisli.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "H. Peter Anvin" <hpa@zytor.com>, Jan Beulich <JBeulich@suse.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Juergen Gross <jgross@suse.com>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Kees Cook <keescook@chromium.org>,
        "linux-sparse@vger.kernel.org" <linux-sparse@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "virtualization@lists.linux-foundation.org" 
        <virtualization@lists.linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Chris Zankel <chris@zankel.net>,
        Max Filippov <jcmvbkbc@gmail.com>
References: <20181003213100.189959-1-namit@vmware.com>
 <20181007091805.GA30687@zn.tnic>
 <4F2F1BCE-7875-4160-9E1E-9F8EF962D989@vmware.com>
 <FC56B15B-0D4A-4A4A-81DA-A5093B56A210@suse.de>
 <56EB8A07-8D24-40F1-8CCE-614D7B712519@vmware.com>
From:   Jeff Law <law@redhat.com>
Openpgp: preference=signencrypt
Autocrypt: addr=law@redhat.com; prefer-encrypt=mutual; keydata=
 xsBNBFkbIO8BCACVIqDhDVh9ur8C+zNV1J/cXfwvVDAUcphDEFl4jyHqZORK4Pd3Db8oWqLm
 Q8lOCr/VOS7lrCtdpVMQkLGOGA16oJ8g7hzhnojpjY09UjsoUiG7oKacuxj8skfp6SIx93Zl
 +iNYPRa4S+za6nY8qiVjyUuiyX04ZPZMrKp2c2sGi+HnBKUZXGhrz/Jdzdox3tjajWZnObyy
 nhEN6hn9L3KawTtGPE/R6A/1RhHTD9FQmIWIeucpaY5c6GNKXTFpj2VYx57LY5hve1R5vhrJ
 IZcgwZAiOtmik5lVi96glY5h6bugRwpexjhwORTLPBCkwiYotSxX99mWd6EHL576i5CNABEB
 AAHNGUplZmYgTGF3IDxsYXdAcmVkaGF0LmNvbT7CwI4EEwEIADgWIQR+niGjtnP5P/8PpRq8
 fP682pgzWwUCWRsg7wIbAwULCQgHAgYVCAkKCwIEFgIDAQIeAQIXgAAKCRC8fP682pgzW5QG
 B/9VATJmx5235RB+8jiDYGXQf3vd9gBfPy/l1tsaK400eFAevDzfGvKmeCKe+uGnlrH3vyT8
 rg9zqH+s5a1Y+lDXPOpJAFmmzbOLU4FW4ucbawmtYvBL65PqpQneCTYnC802/OAcxjm/Onem
 HlgeK6WicNsBTPwYN/0araDFUejyYBIFi9CNqqflwk5Z3brKbQ9bAYIkysVLC/c3njKPmM0c
 WPFHG91ubLbWCHwTIK0+mAL714eTD74dXzOjO2ZDBPLGlFN/kO3+YjaO6UOD2O8acvAMCivT
 kWLr7JwRgLIQDN2DkhQDd3LTPqQE/yOcMcXBTO+fxm8KG0iKQBqWMyGJzsBNBFkbIO8BCACy
 qbOsv7XegSeea8XORt5zMaBVWKoSyhmmcCmlxZFS2cuYOBt79MO13lZE2DlO3Lv5IKikj/D4
 ketGVO4+h5psEMH5Yz5P8bx0TmgwbK1GxPZrzeXozUFJDvvCDbIlT0v0pwUXuK3hg8Ieo2h5
 uTed/cn1OjySXW5BqLxN0cyr5hL+J6dcsHvKLT/N3nTgCQhoJXK2MrEMhAGgF3jKpMn3CoS4
 i/ZbNI2MQR6LWHwdZ95f0fI8NzHSfVzeLtzCKQec7nr9fgd6Ylk1ZpGWQUPlQmKjzYgeCeTK
 NO04cwt20WIrQWeWiZFPA0U86NDBdSBrYp4kG3dfIXE+wSSvE7qPABEBAAHCwHYEGAEIACAW
 IQR+niGjtnP5P/8PpRq8fP682pgzWwUCWRsg7wIbDAAKCRC8fP682pgzW3REB/9cT7iKRPg/
 OK9bpLlllIEDM90IaKC79DQrv+fRudOR78cdV4XUwPSFnyHUsP3VJ4lDy5FhiKCwGie0BK53
 EsxgMrLy1L8hboFdTE4Vi0xzCheMaMVp4hATDU29k1cuxu1VPpCa8E3mYeHjNV7ip0HN5L4D
 rfs8lRPJE/oM1vGs9DgQFZrCPPNRNGKC97BH+DHccesEJr7tSsQrkPkt0z/FTKr5wIM02vSx
 OJjgmcVbGB7dc2j/Sx8loXmuKnuKtM35668kUG8jeJvSQk3o/VHpD27bhl0rR68R2jN6G6kQ
 egMVb6dPu1Ius8rBE5rFw88J4JEb5q4hMNClWWUFHIdP
Message-ID: <0f93b80c-c7c1-0a85-9863-87a2a0dfd051@redhat.com>
Date:   Sun, 7 Oct 2018 13:52:24 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <56EB8A07-8D24-40F1-8CCE-614D7B712519@vmware.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.25
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.46]); Sun, 07 Oct 2018 19:52:38 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/7/18 1:06 PM, Nadav Amit wrote:
> at 9:46 AM, Richard Biener <rguenther@suse.de> wrote:
> 
>> On October 7, 2018 6:09:30 PM GMT+02:00, Nadav Amit <namit@vmware.com> wrote:
>>> at 2:18 AM, Borislav Petkov <bp@alien8.de> wrote:
>>>
>>>> Hi people,
>>>>
>>>> this is an attempt to see whether gcc's inline asm heuristic when
>>>> estimating inline asm statements' cost for better inlining can be
>>>> improved.
>>>>
>>>> AFAIU, the problematic arises when one ends up using a lot of inline
>>>> asm statements in the kernel but due to the inline asm cost
>>> estimation
>>>> heuristic which counts lines, I think, for example like in this here
>>>> macro:
>>> https://na01.safelinks.protection.outlook.com/?url=https%3A%2F%2Fgit.kernel.org%2Fpub%2Fscm%2Flinux%2Fkernel%2Fgit%2Ftorvalds%2Flinux.git%2Ftree%2Farch%2Fx86%2Finclude%2Fasm%2Fcpufeature.h%23n162&amp;data=02%7C01%7Cnamit%40vmware.com%7C860403cecb874db64b7e08d62c746f46%7Cb39138ca3cee4b4aa4d6cd83d9dd62f0%7C1%7C0%7C636745275975505381&amp;sdata=Nd0636K9Z1IsUs1RWSRAhVuVboLxlBCB4peiAMfmQzQ%3D&amp;reserved=0
>>>> the resulting code ends up not inlining the functions themselves
>>> which
>>>> use this macro. I.e., you see a CALL <function> instead of its body
>>>> getting inlined directly.
>>>>
>>>> Even though it should be because the actual instructions are only a
>>>> couple in most cases and all those other directives end up in another
>>>> section anyway.
>>>>
>>>> The issue is explained below in the forwarded mail in a larger detail
>>>> too.
>>>>
>>>> Now, Richard suggested doing something like:
>>>>
>>>> 1) inline asm ("...")
>>>> 2) asm ("..." : : : : <size-expr>)
>>>> 3) asm ("...") __attribute__((asm_size(<size-expr>)));
>>>>
>>>> with which user can tell gcc what the size of that inline asm
>>> statement
>>>> is and thus allow for more precise cost estimation and in the end
>>> better
>>>> inlining.
>>>>
>>>> And FWIW 3) looks pretty straight-forward to me because attributes
>>> are
>>>> pretty common anyways.
>>>>
>>>> But I'm sure there are other options and I'm sure people will have
>>>> better/different ideas so feel free to chime in.
>>>
>>> Thanks for taking care of it. I would like to mention a second issue,
>>> since
>>> you may want to resolve both with a single solution: not inlining
>>> conditional __builtin_constant_p(), in which there are two code-paths -
>>> one
>>> for constants and one for variables.
>>>
>>> Consider for example the Linux kernel ilog2 macro, which has a
>>> condition
>>> based on __builtin_constant_p() (
>>> https://na01.safelinks.protection.outlook.com/?url=https%3A%2F%2Felixir.bootlin.com%2Flinux%2Fv4.19-rc7%2Fsource%2Finclude%2Flinux%2Flog2.h%23L160&amp;data=02%7C01%7Cnamit%40vmware.com%7C860403cecb874db64b7e08d62c746f46%7Cb39138ca3cee4b4aa4d6cd83d9dd62f0%7C1%7C0%7C636745275975515386&amp;sdata=Hk39Za9%2FxcFyK0sGENB24d6QySjsDGzF%2FwqjnUEMiGk%3D&amp;reserved=0
>>> ). The compiler mistakenly considers the “heavy” code-path that is
>>> supposed
>>> to be evaluated only in compilation time to evaluate the code size.
>>
>> But this is a misconception about __builtin_constant_p. It doesn't guard sth like 'constexpr' regions. If you try to use it with those semantics you'll fail (appearantly you do). 
>>
>> Of course IPA CP code size estimates when seeing a constant fed to bcp might be not optimal, that's another issue of course. 
> 
> I understand that this is might not be the right way to implement macros
> such as ilog2() and test_bit(), but this code is around for some time.
That doesn't make it right -- and there's been numerous bogus bugs
reported against ilog2 because the authors of ilog2 haven't had a clear
understanding of the semantics of builtin_constant_p.


Jeff
