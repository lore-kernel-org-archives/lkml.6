Return-Path: <msebor@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1520276725; cv=none;
        d=google.com; s=arc-20160816;
        b=K+HNppwQzXJ+MGwOIdoMJOISafx+h1sUglBIywg5hUiiOIOvPrPAOP42hK+J/Jg5CI
         nTGk4QDrDLQ7IoasbI2eAU/rm1xReSTOR3R1eqpr3T35cSVMcxsQN8321cugKA8IEqJd
         0oKOf9Lx/pj2GNCxA9kiWUL8/QF4TPqSTUeBoY2V9gKRikb7qGrsynPoRx/WHmlCxiAB
         RtwTPItAsBD42tnWHphaK+uwdgNWzrVEYxOnGMuz/MjwVrirsDqJV5Gd9V9QxflzFFzk
         /a2yh1LE07KesbSWCOMCqHHyRVMI+Qd/8R/SKu9i93wWIUH7xUrwgVFPIcr09YN73dLR
         ubmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:in-reply-to:mime-version:user-agent:date
         :message-id:from:cc:references:to:subject:dkim-signature
         :arc-authentication-results;
        bh=pniLxOrhwMAG0kPJ33kQigGEpdRMZYJwM4BwBXo+TeQ=;
        b=OrWOD+VGqYMFYO61hkOqQRZ7T7Eg/zSeTWrbh6eZ32ZM/wvcHnCeXwAepIxSK16Whs
         0OY6dnhZVMjvdBJWdAhvoddV3EmVA+yl2o2mdKuOaIhYroFoNqOasFVZrpuEg0b0ArKU
         W8T4OVHZZrwAZFj5xUPl4DwvCLdTbaJFSXu7zViachWG8UosWE6HNFadgASn95I14Lmu
         dCbiYXt50fAj9axpdkD81f+nkIi1bTs9HA8qguJE/YDA4bKn8ajzgxWVzrTVx0NocTIg
         36wH2FR38G/ora9pkA4VVuVwUPrMcEgbcSDQ41LxbMVnaanUWK+G0uGV1537QniXqGWg
         Ph6g==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=KAsQp5Zh;
       spf=pass (google.com: domain of msebor@gmail.com designates 209.85.220.41 as permitted sender) smtp.mailfrom=msebor@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=KAsQp5Zh;
       spf=pass (google.com: domain of msebor@gmail.com designates 209.85.220.41 as permitted sender) smtp.mailfrom=msebor@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
X-Google-Smtp-Source: AG47ELs3XCE3dRfgbOcGpPfZ6q/jlX0/wMGg9w2Ro/hATgv6xK3yp0pATcdR0EHhhfYMiJHtuoxyTw==
Subject: Re: [PATCH] Support the nonstring variable attribute (gcc >= 8)
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
 Arnd Bergmann <arnd@arndb.de>
References: <20180217191035.gol4woxsgzpo4bfq@gmail.com>
 <alpine.DEB.2.10.1802181519400.205822@chino.kir.corp.google.com>
 <CANiq72=jgAzCDoU2Vkq0zVKNCDvwhPT7Eqpy5Af6W3=XacQnRA@mail.gmail.com>
 <CAK8P3a1d-DnF58zZqxMYE3DrtZO9Bs3a2o-cuvTupnJeTeG2ww@mail.gmail.com>
 <CANiq72mcBGXOw_YgtMFWU8VV5irhuDsb-VRuPjeW9=SbHuyRsw@mail.gmail.com>
Cc: David Rientjes <rientjes@google.com>, Ingo Molnar <mingo@kernel.org>,
 Josh Poimboeuf <jpoimboe@redhat.com>, Kees Cook <keescook@chromium.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 Thomas Gleixner <tglx@linutronix.de>,
 Geert Uytterhoeven <geert@linux-m68k.org>,
 Greg KH <gregkh@linuxfoundation.org>,
 "Lendacky, Thomas" <thomas.lendacky@amd.com>,
 Will Deacon <will.deacon@arm.com>,
 linux-kernel <linux-kernel@vger.kernel.org>, Willy Tarreau <w@1wt.eu>,
 Xiongfeng Wang <wangxiongfeng2@huawei.com>
From: Martin Sebor <msebor@gmail.com>
Message-ID: <d76825e1-6e0f-a75c-21b0-3501dbc9d7a9@gmail.com>
Date: Mon, 5 Mar 2018 12:05:22 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.8.0
MIME-Version: 1.0
In-Reply-To: <CANiq72mcBGXOw_YgtMFWU8VV5irhuDsb-VRuPjeW9=SbHuyRsw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592676488865934389?=
X-GMAIL-MSGID: =?utf-8?q?1594125687728379945?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 03/02/2018 10:36 AM, Miguel Ojeda wrote:
> On Thu, Mar 1, 2018 at 10:57 AM, Arnd Bergmann <arnd@arndb.de> wrote:
>> On Mon, Feb 19, 2018 at 1:01 AM, Miguel Ojeda
>> <miguel.ojeda.sandonis@gmail.com> wrote:
>>> On Mon, Feb 19, 2018 at 12:20 AM, David Rientjes <rientjes@google.com> wrote:
>>>> On Sat, 17 Feb 2018, Miguel Ojeda wrote:
>>>>
>>>>> From the GCC manual:
>>>>>
>>>>> The nonstring variable attribute specifies that an object or member
>>>>> declaration with type array of char or pointer to char is intended to
>>>>> store character arrays that do not necessarily contain a terminating NUL
>>>>> character. This is useful in detecting uses of such arrays or pointers
>>>>> with functions that expect NUL-terminated strings, and to avoid warnings
>>>>> when such an array or pointer is used as an argument to a bounded string
>>>>> manipulation function such as strncpy.
>>>>>
>>>>>   https://gcc.gnu.org/onlinedocs/gcc/Common-Variable-Attributes.html
>>>>>
>>>>> Some reports are already coming to the LKML regarding these
>>>>> warnings. When they are false positives, we can use __nonstring to let
>>>>> gcc know a NUL character is not required; like in this case:
>>>>>
>>>>>   https://lkml.org/lkml/2018/1/16/135
>>>>>
>>>>> Signed-off-by: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
>>>>> Cc: Ingo Molnar <mingo@kernel.org>
>>>>> Cc: Josh Poimboeuf <jpoimboe@redhat.com>
>>>>> Cc: Kees Cook <keescook@chromium.org>
>>>>> Cc: Andrew Morton <akpm@linux-foundation.org>
>>>>> Cc: Geert Uytterhoeven <geert@linux-m68k.org>
>>>>> Cc: Will Deacon <will.deacon@arm.com>
>>>>> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>>>>> Cc: David Rientjes <rientjes@google.com>
>>>>
>>>> I would have expected to have seen __nonstring used somewhere as part of
>>>> this patch.
>>>
>>> Do you mean to expand the commit message with an actual code example
>>> instead of the links to the docs and the discussion about the report?
>>> Otherwise, if you mean in the actual commit, I think in that case it
>>> should be a patch series, not a single commit.
>>>
>>> In any case, the key point here is to agree on the short-term policy:
>>> i.e. whether we want to disable the upcoming warning or try to take
>>> advantage of it (which not *necessarily* implies using __nonstring,
>>> there are other workarounds; though where applicable, __nonstring is
>>> probably the right thing to use).
>>
>> What David was asking for is to have a couple of users of the
>> __nonstring attribute in places for which it is the right solution.
>>
>
> I understood :-) My question was regarding where he was asking to see it.
>
>> I would suggest making it a patch series, with patch 1/x introducing
>> the attribute (i.e. your patch), and followed by additional patches
>> that add the attribute to individual header files or drivers for which
>> it is the right solution.
>
> Yep, that is what I suggested too.
>
>>
>> When I looked at the warning, I found that we have around 120 file
>> for which we warn. The majority of them are actually questionable
>> uses of strncpy() that probably should have been strscpy(), but
>> most of those do not actually cause undefined behavior.
>
> Then it looks like enabling the warning by default is useful and not
> too noisy (at least for just char).
>
>>
>> A smaller number like the example from ext4 are nonstrings
>> (i.e. character arrays without nul-termination) that would benefit
>> from the nonstring attribute. About half of those are actually
>> arrays of u8/__u8/uint8_t/__uint8_t for which the currently
>> implemented nonstring attribute is invalid, and it seems odd
>> to convert those to 'char', e.g.
>>
>> struct ext4_super_block {
>>         __le32  s_first_error_time;     /* first time an error happened */
>>         __le32  s_first_error_ino;      /* inode involved in first error */
>>         __le64  s_first_error_block;    /* block involved of first error */
>> -       __u8    s_first_error_func[32]; /* function where the error happened */
>> +       char    s_first_error_func[32] __nonstring;     /* function
>> where the error happened */
>>         __le32  s_first_error_line;     /* line number where error happened */
>>         __le32  s_last_error_time;      /* most recent time of an error */
>>         __le32  s_last_error_ino;       /* inode involved in last error */
>>         __le32  s_last_error_line;      /* line number where error happened */
>>         __le64  s_last_error_block;     /* block involved of last error */
>> -       __u8    s_last_error_func[32];  /* function where the error happened */
>> +       char    s_last_error_func[32] __nonstring;      /* function
>> where the error happened */
>>
>> doesn't feel right. Maybe we can extend gcc to also accept
>> the attribute on arrays of other 8-bit types.
>
> Hum... On one hand, the warning is meant to protect against misuses of
> the typical string handling functions, and those take pointers to
> char. Therefore, one could argue that using signed or unsigned char
> already marks an array/pointer as "not a string" (for the purposes of
> the attribute).
>
> On the other hand, people *will* call string handling functions with
> signed and unsigned char, and for those cases, it is useful to have
> the warning nevertheless and being able to annotate those arrays with
> nonstring, which is also good documentation-wise. On top of that, C
> specifies char as equivalent to either signed or unsigned char (even
> if it is a distinct type), so one could argue it should work for the
> three types anyway.
>
> Given that 1) this is a warning that can disabled just fine and that
> 2) we already have real life cases using nonstring, non-char arrays
> calling typical string handling functions, I would favor supporting
> the warning and the attribute for all the three types.
>
>>
>>> [By the way, CC'ing Xiongfeng, Willy and Arnd, since they were
>>> involved in the example report; sorry guys!].
>>
>> Martin Sebor also asked me about this, he's the one that worked on
>> the gcc code that introduced the warning. Sorry for not replying earlier.
>>
>
> Maybe you can pass this to him? (maybe open a bug in gcc's bugzilla?)

I've opened bug 84725 to extend attribute nonstring to the other
two character types:

https://gcc.gnu.org/bugzilla/show_bug.cgi?id=84725

Thanks
Martin

>
>> For a complete list of affected files, see https://pastebin.com/eWFQf58i
>> this is what I come up with by doing randconfig builds, but I have not
>> tried to submit additional patches here, since I'm sure that a lot of
>> those are wrong -- they need a much closer inspection to decide which
>> ones are actual bugs vs harmless warnings, and which ones should
>> use strscpy()/strlcpy() vs a nonstring annotation or a rewrite of that
>> function.
>
> Indeed -- nice work anyway finding those. If we agree on getting the
> nonstring attribute, maybe you can send that patch as an RFC to ping
> the respective maintainers?
>
> Thanks,
> Miguel
>
