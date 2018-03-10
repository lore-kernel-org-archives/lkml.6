Return-Path: <kernel-hardening-return-12376-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AG47ELtTGtkGMzEGwmGXDBXAHTLyPViRxOrnrloDDWQfQWpl59Q6b2ZIUIDoCmEFYRem+Pj7o7oR
ARC-Seal: i=1; a=rsa-sha256; t=1520696051; cv=none;
        d=google.com; s=arc-20160816;
        b=xHSFmiOyJgjGnXf5c16WxA6Ej94MAI/YzbKCppRXgWBqmSlgwNb95S5Wb6snLuS+sZ
         7jD7hMBAgn+ZUFSrpW5InH2ZjDzK+Bc84/1hiIR8tRcmP5V0XYgUtMoHLsk/H1TZO5Kf
         jjd1drjqv68IYC5Tu06WYU5/1hFc3LShqeA4iN/ynj7IToYUK58s+2eqBisnbOSMwA4T
         QUYP1FMR2e5El9dn64A2/6UbsItStZYjFt6joayZD9F2J8kSTXM7FEX2Ev3blaq8QwEB
         nCE8Ws7ofP5qrMIDwVi1hmIUHDtDwIOq9tEwGAKJ8G36aVpjYyICl60DEBuQlk6Q3Q9/
         0e/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :references:in-reply-to:sender:mime-version:dkim-signature
         :dkim-signature:delivered-to:list-id:list-subscribe:list-unsubscribe
         :list-help:list-post:precedence:mailing-list
         :arc-authentication-results;
        bh=HQ/jBD3pT9s4OGOqXuZbODc4vSyLbkaTwajeRWgRaDw=;
        b=z4FifNGFAmNkvK3jbX3jwalEmqWoyPIy+zg+FoTdqjwwgeja4g7DRMaYVbuvN+/tFn
         NLuGrvSSUFKP4H8su7YVfgYpVX6mi2mM+vGY/oTjGPRNScNjnCY8/D1YdlInYVAOemcv
         MesicuLUD9/3SJv5LdCi3Ze5yeMXOTt+dAg3lSLUQRruO0Qb7TFVoCON4zqqGExMe19G
         9lcyq10+0f+LBeXcXp4OYyBtVUTM/OGc7Gy4Dzg5AUNU/WKZnap0fCUTa9XxxQlK7ZuJ
         NvVWt3Ui74TtfN3ft1Vz3uBkSlvMwB1eimMMQq5eYnDUD7uOSA2Ec3Pr1uLmyG2J76Vj
         2kHg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@google.com header.s=20161025 header.b=qxDcvTHx;
       dkim=pass header.i=@chromium.org header.s=google header.b=L8pOjnWK;
       spf=pass (google.com: domain of kernel-hardening-return-12376-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12376-gregkh=linuxfoundation.org@lists.openwall.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=chromium.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@google.com header.s=20161025 header.b=qxDcvTHx;
       dkim=pass header.i=@chromium.org header.s=google header.b=L8pOjnWK;
       spf=pass (google.com: domain of kernel-hardening-return-12376-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12376-gregkh=linuxfoundation.org@lists.openwall.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=chromium.org
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
MIME-Version: 1.0
Sender: keescook@google.com
In-Reply-To: <CANiq72k_vsTPMXvcfTNo+sjRoVMkihvRz-fzeXdcXvNEEeY-Pw@mail.gmail.com>
References: <20180309200536.GA5670@beast> <20180309160719.154a3158e2d8ee56e43a918f@linux-foundation.org>
 <e8874944-f0b7-7a1f-26f3-446d7d7fcc38@infradead.org> <CANiq72k_vsTPMXvcfTNo+sjRoVMkihvRz-fzeXdcXvNEEeY-Pw@mail.gmail.com>
From: Kees Cook <keescook@chromium.org>
Date: Sat, 10 Mar 2018 07:33:53 -0800
X-Google-Sender-Auth: HUpLL2wuqspJqhyCgRDCaSlM644
Message-ID: <CAGXu5jLtKAUsoYemHZTrJqKEH9=BqwO_QXk=x3BPfCKqZ6DRYA@mail.gmail.com>
Subject: Re: [PATCH v3] kernel.h: Skip single-eval logic on literals in min()/max()
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc: Randy Dunlap <rdunlap@infradead.org>, Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel <linux-kernel@vger.kernel.org>, Josh Poimboeuf <jpoimboe@redhat.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>, "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
	"Tobin C. Harding" <me@tobin.cc>, Steven Rostedt <rostedt@goodmis.org>, Jonathan Corbet <corbet@lwn.net>,
	Chris Mason <clm@fb.com>, Josef Bacik <jbacik@fb.com>, David Sterba <dsterba@suse.com>,
	"David S. Miller" <davem@davemloft.net>, Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
	Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>, Ingo Molnar <mingo@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>, Thomas Gleixner <tglx@linutronix.de>,
	Masahiro Yamada <yamada.masahiro@socionext.com>, Borislav Petkov <bp@suse.de>,
	Ian Abbott <abbotti@mev.co.uk>, Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
	Petr Mladek <pmladek@suse.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Pantelis Antoniou <pantelis.antoniou@konsulko.com>, Linux Btrfs <linux-btrfs@vger.kernel.org>,
	Network Development <netdev@vger.kernel.org>,
	Kernel Hardening <kernel-hardening@lists.openwall.com>,
	Linus Torvalds <torvalds@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594491887701841138?=
X-GMAIL-MSGID: =?utf-8?q?1594565383414690903?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, Mar 9, 2018 at 10:10 PM, Miguel Ojeda
<miguel.ojeda.sandonis@gmail.com> wrote:
> On Sat, Mar 10, 2018 at 4:11 AM, Randy Dunlap <rdunlap@infradead.org> wro=
te:
>> On 03/09/2018 04:07 PM, Andrew Morton wrote:
>>> On Fri, 9 Mar 2018 12:05:36 -0800 Kees Cook <keescook@chromium.org> wro=
te:
>>>
>>>> When max() is used in stack array size calculations from literal value=
s
>>>> (e.g. "char foo[max(sizeof(struct1), sizeof(struct2))]", the compiler
>>>> thinks this is a dynamic calculation due to the single-eval logic, whi=
ch
>>>> is not needed in the literal case. This change removes several acciden=
tal
>>>> stack VLAs from an x86 allmodconfig build:
>>>>
>>>> $ diff -u before.txt after.txt | grep ^-
>>>> -drivers/input/touchscreen/cyttsp4_core.c:871:2: warning: ISO C90 forb=
ids variable length array =E2=80=98ids=E2=80=99 [-Wvla]
>>>> -fs/btrfs/tree-checker.c:344:4: warning: ISO C90 forbids variable leng=
th array =E2=80=98namebuf=E2=80=99 [-Wvla]
>>>> -lib/vsprintf.c:747:2: warning: ISO C90 forbids variable length array =
=E2=80=98sym=E2=80=99 [-Wvla]
>>>> -net/ipv4/proc.c:403:2: warning: ISO C90 forbids variable length array=
 =E2=80=98buff=E2=80=99 [-Wvla]
>>>> -net/ipv6/proc.c:198:2: warning: ISO C90 forbids variable length array=
 =E2=80=98buff=E2=80=99 [-Wvla]
>>>> -net/ipv6/proc.c:218:2: warning: ISO C90 forbids variable length array=
 =E2=80=98buff64=E2=80=99 [-Wvla]
>>>>
>>>> Based on an earlier patch from Josh Poimboeuf.
>>>
>>> v1, v2 and v3 of this patch all fail with gcc-4.4.4:
>>>
>>> ./include/linux/jiffies.h: In function 'jiffies_delta_to_clock_t':
>>> ./include/linux/jiffies.h:444: error: first argument to '__builtin_choo=
se_expr' not a constant
>>
>>
>> I'm seeing that problem with
>>> gcc --version
>> gcc (SUSE Linux) 4.8.5
>
> Same here, 4.8.5 fails. gcc 5.4.1 seems to work. I compiled a minimal
> 5.1.0 and it seems to work as well.

And sparse freaks out too:

   drivers/net/ethernet/via/via-velocity.c:97:26: sparse: incorrect
type in initializer (different address spaces) @@    expected void
*addr @@    got struct mac_regs [noderef] <avoid *addr @@
   drivers/net/ethernet/via/via-velocity.c:97:26:    expected void *addr
   drivers/net/ethernet/via/via-velocity.c:97:26:    got struct
mac_regs [noderef] <asn:2>*mac_regs
   drivers/net/ethernet/via/via-velocity.c:100:49: sparse: incorrect
type in argument 2 (different base types) @@    expected restricted
pci_power_t [usertype] state @@    got _t [usertype] state @@

Alright, I'm giving up on fixing max(). I'll go back to STACK_MAX() or
some other name for the simple macro. Bleh.

-Kees

--=20
Kees Cook
Pixel Security
