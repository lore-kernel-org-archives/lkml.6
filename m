Return-Path: <arndbergmann@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1519898270; cv=none;
        d=google.com; s=arc-20160816;
        b=B/B1q03DVQyFSB+F5iTTX2uD/82OWta+/7ryczfbR4MfZT93mXRFUlbT2hMjdyfo2n
         d2O9nW7tYyz/ZYXU+y3dgGKycb5BtCTf18MDrdPnfV+b2VSicTfM3fDwlg4NFL5ja/gj
         12E+3vGDOCUiou2wLZ2PG0nzY4n3crkdZPZOgP/whQqbhJylqIva1ungkaWGzWCtcTEI
         lQHjINCkDPrT5twV1W4aFF/MMBbDD7+eJm/zsUx46wr5Teim+cIgjzb7LGi+/5Mdpg8A
         rm6mxZweweCmBD++GP9yXbfGw38l6VsOkFfEwHRzJz/aHdiaU69PuvEnmFxGEzimao1q
         h9iw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to:sender
         :mime-version:dkim-signature:arc-authentication-results;
        bh=zLnjBcFRZZde/xT4A5GUPWo7VmLHENlTmBUX52lnNKI=;
        b=Cvh1vNzGlvXspnN4mDC3+MCXO1hGPc+A1hCMl3Jise1UkUjZ443OOOaWfG/mYxkufx
         V7PGSxKgS0WxsxmTCXrJyfSIQYtDNKYrWpBF17648b0vHKBHBOK4T/rNA6ZzkUNfx5XC
         wGTY1gOBmBRD9JmOszeCUShqIO8GhTrseCtwXP4Rd1XxuV4JJhhCCc6Zrp3ZfAzqiCsz
         n6y/r3V0e9a9VhQ4no8Ga7M3ZXJUOSEtxL7PT3mUGlfq4ZQbH2gjBLKXeCKwTI+966aY
         r1lb3aa7TC4pg5ti2IAFDc/DZ9TTsaCMXZN7MQDQapVoMP8ump/kDNa89w8vnV3MacsW
         +mqA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=dt5l1fY1;
       spf=pass (google.com: domain of arndbergmann@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=arndbergmann@gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=dt5l1fY1;
       spf=pass (google.com: domain of arndbergmann@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=arndbergmann@gmail.com
X-Google-Smtp-Source: AG47ELuyW4r/ILG65CzHiCIs1PuUDByHU17gJ4+IuxvFnV8w5NMrKptEc4w87P8D0zoN+YzMNHqihXifhgPMdYcB2a4=
MIME-Version: 1.0
Sender: arndbergmann@gmail.com
In-Reply-To: <CANiq72=jgAzCDoU2Vkq0zVKNCDvwhPT7Eqpy5Af6W3=XacQnRA@mail.gmail.com>
References: <20180217191035.gol4woxsgzpo4bfq@gmail.com> <alpine.DEB.2.10.1802181519400.205822@chino.kir.corp.google.com>
 <CANiq72=jgAzCDoU2Vkq0zVKNCDvwhPT7Eqpy5Af6W3=XacQnRA@mail.gmail.com>
From: Arnd Bergmann <arnd@arndb.de>
Date: Thu, 1 Mar 2018 10:57:49 +0100
X-Google-Sender-Auth: 2tvNMmOClD8FrgcGmXAcA1BKzcY
Message-ID: <CAK8P3a1d-DnF58zZqxMYE3DrtZO9Bs3a2o-cuvTupnJeTeG2ww@mail.gmail.com>
Subject: Re: [PATCH] Support the nonstring variable attribute (gcc >= 8)
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc: David Rientjes <rientjes@google.com>, Ingo Molnar <mingo@kernel.org>,
	Josh Poimboeuf <jpoimboe@redhat.com>, Kees Cook <keescook@chromium.org>,
	Andrew Morton <akpm@linux-foundation.org>, Thomas Gleixner <tglx@linutronix.de>,
	Geert Uytterhoeven <geert@linux-m68k.org>, Greg KH <gregkh@linuxfoundation.org>,
	"Lendacky, Thomas" <thomas.lendacky@amd.com>, Will Deacon <will.deacon@arm.com>,
	linux-kernel <linux-kernel@vger.kernel.org>, Willy Tarreau <w@1wt.eu>,
	Xiongfeng Wang <wangxiongfeng2@huawei.com>, Martin Sebor <msebor@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592676488865934389?=
X-GMAIL-MSGID: =?utf-8?q?1593728849370145487?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, Feb 19, 2018 at 1:01 AM, Miguel Ojeda
<miguel.ojeda.sandonis@gmail.com> wrote:
> On Mon, Feb 19, 2018 at 12:20 AM, David Rientjes <rientjes@google.com> wrote:
>> On Sat, 17 Feb 2018, Miguel Ojeda wrote:
>>
>>> From the GCC manual:
>>>
>>> The nonstring variable attribute specifies that an object or member
>>> declaration with type array of char or pointer to char is intended to
>>> store character arrays that do not necessarily contain a terminating NUL
>>> character. This is useful in detecting uses of such arrays or pointers
>>> with functions that expect NUL-terminated strings, and to avoid warnings
>>> when such an array or pointer is used as an argument to a bounded string
>>> manipulation function such as strncpy.
>>>
>>>   https://gcc.gnu.org/onlinedocs/gcc/Common-Variable-Attributes.html
>>>
>>> Some reports are already coming to the LKML regarding these
>>> warnings. When they are false positives, we can use __nonstring to let
>>> gcc know a NUL character is not required; like in this case:
>>>
>>>   https://lkml.org/lkml/2018/1/16/135
>>>
>>> Signed-off-by: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
>>> Cc: Ingo Molnar <mingo@kernel.org>
>>> Cc: Josh Poimboeuf <jpoimboe@redhat.com>
>>> Cc: Kees Cook <keescook@chromium.org>
>>> Cc: Andrew Morton <akpm@linux-foundation.org>
>>> Cc: Geert Uytterhoeven <geert@linux-m68k.org>
>>> Cc: Will Deacon <will.deacon@arm.com>
>>> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>>> Cc: David Rientjes <rientjes@google.com>
>>
>> I would have expected to have seen __nonstring used somewhere as part of
>> this patch.
>
> Do you mean to expand the commit message with an actual code example
> instead of the links to the docs and the discussion about the report?
> Otherwise, if you mean in the actual commit, I think in that case it
> should be a patch series, not a single commit.
>
> In any case, the key point here is to agree on the short-term policy:
> i.e. whether we want to disable the upcoming warning or try to take
> advantage of it (which not *necessarily* implies using __nonstring,
> there are other workarounds; though where applicable, __nonstring is
> probably the right thing to use).

What David was asking for is to have a couple of users of the
__nonstring attribute in places for which it is the right solution.

I would suggest making it a patch series, with patch 1/x introducing
the attribute (i.e. your patch), and followed by additional patches
that add the attribute to individual header files or drivers for which
it is the right solution.

When I looked at the warning, I found that we have around 120 file
for which we warn. The majority of them are actually questionable
uses of strncpy() that probably should have been strscpy(), but
most of those do not actually cause undefined behavior.

A smaller number like the example from ext4 are nonstrings
(i.e. character arrays without nul-termination) that would benefit
from the nonstring attribute. About half of those are actually
arrays of u8/__u8/uint8_t/__uint8_t for which the currently
implemented nonstring attribute is invalid, and it seems odd
to convert those to 'char', e.g.

struct ext4_super_block {
        __le32  s_first_error_time;     /* first time an error happened */
        __le32  s_first_error_ino;      /* inode involved in first error */
        __le64  s_first_error_block;    /* block involved of first error */
-       __u8    s_first_error_func[32]; /* function where the error happened */
+       char    s_first_error_func[32] __nonstring;     /* function
where the error happened */
        __le32  s_first_error_line;     /* line number where error happened */
        __le32  s_last_error_time;      /* most recent time of an error */
        __le32  s_last_error_ino;       /* inode involved in last error */
        __le32  s_last_error_line;      /* line number where error happened */
        __le64  s_last_error_block;     /* block involved of last error */
-       __u8    s_last_error_func[32];  /* function where the error happened */
+       char    s_last_error_func[32] __nonstring;      /* function
where the error happened */

doesn't feel right. Maybe we can extend gcc to also accept
the attribute on arrays of other 8-bit types.

> [By the way, CC'ing Xiongfeng, Willy and Arnd, since they were
> involved in the example report; sorry guys!].

Martin Sebor also asked me about this, he's the one that worked on
the gcc code that introduced the warning. Sorry for not replying earlier.

For a complete list of affected files, see https://pastebin.com/eWFQf58i
this is what I come up with by doing randconfig builds, but I have not
tried to submit additional patches here, since I'm sure that a lot of
those are wrong -- they need a much closer inspection to decide which
ones are actual bugs vs harmless warnings, and which ones should
use strscpy()/strlcpy() vs a nonstring annotation or a rewrite of that
function.

       Arnd
