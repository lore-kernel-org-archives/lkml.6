Return-Path: <kernel-hardening-return-12008-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AG47ELv2lCdJg1sO5pz69uQMU1WWlyFCVd15t2111VyVYAOd3aiUCoBE3Ik27JvlVVSFEwbq0SXI
ARC-Seal: i=1; a=rsa-sha256; t=1519754654; cv=none;
        d=google.com; s=arc-20160816;
        b=cY7zhXPZ8xIvmGtvXTEM7Qn7FKQ1zgnIJZVNXMhTEbk6k8Klwyu+kICFlxHvAMjIUl
         o/kkAA/reWwmeTYd7rpprBfRfpuBJSszbHEex/XQ5HJ/8CqXsJoZgNI5xlnL63qG67kp
         nqqmmzzzi4EwAA0XQjG+olPJWqKHvrQof2j1kKpQs0gQWM4FFhBwyLN9tW39G+Q0dM9q
         TS2t3Yt4emsZ+GpO1A7CYAscSLHFfUvlHfsBGR2da9cxPrH67OrXBz4qHIJSuANWY50f
         /7zLWVQ23IEZJWOgE8nLls9oCwTzbz2KlFerPl/7Ego5UEHQSNPvMvBvqHbxixAaXxh2
         /p6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-language:content-transfer-encoding:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :dkim-signature:delivered-to:list-id:list-subscribe:list-unsubscribe
         :list-help:list-post:precedence:mailing-list
         :arc-authentication-results;
        bh=I2AzXnLXH5X7gddWwl0T6UiiBr+rBOhY3ySyetnFak8=;
        b=e4xycGI1ZwHxhJEU7fDNa9LDbw778pMFnpQpTY/jYZkxC+hpsuYOaQyKeZjMK5o5+3
         C18dsRHxjdOTIq+CGIoatgmba9+A5YMVyZjeSi5qVl3g4AboptGTirlt1vRk6VidUKfI
         lPrbJpTCte5LzXZLFXZPP/K1W8mygYbOlCvOZ8gzQ1pym1LUO0W8e4uozQ10HO575p3I
         qDE+lyAXiRZbe54IsdNd5QkogKpA9aRbWJFvPSAd9TlFXGDdSSgoKHHoB9VVKCMzUiSV
         wdjqEwFWTpC7N0bFOHvQ1F0VZe64jBKenga2zcg6bzscUW+QodeccgYlEwH4UOB9z3vP
         RuHA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@yahoo.com header.s=s2048 header.b=W2+jTSko;
       spf=pass (google.com: domain of kernel-hardening-return-12008-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12008-gregkh=linuxfoundation.org@lists.openwall.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@yahoo.com header.s=s2048 header.b=W2+jTSko;
       spf=pass (google.com: domain of kernel-hardening-return-12008-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12008-gregkh=linuxfoundation.org@lists.openwall.com
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
X-YMail-OSG: DfEgvQUVM1k7R6XRyjLxhxdH8qiAbyuTaXnQHxV3ughvC_Laj.T37moGQ4zdWit
 HhREg4wDTSAJGohO4bW.me5aXqJLvUzBGKZYITvt1NTOdnTrvrEpm5MoBHAeHr6s.YENfiyV4_fA
 zv5N6jUQnsHkGtTgRxYHHxSaWYUhxa39NbfC3vFKKEkJzhRsTawsXEcw8ki3Q.chH7zmJKE6mqKL
 pVKKcr3e26yH8TzHtklmhmMzEwhywv4kRx_LW6fjCvsbyY.fXHdcxtLzF76w8zHyvFujqq1Liymv
 .DkGBbFA47uIi2AAZ8T4niYXBkWc6L8Vj7M95I7eA6WFuIV_rVz.NLXrTsHw2Hv9VRU.NNX49Yw0
 O_FgHZ473UR43gbAYymbG6ahooMKiuDOCudZ9jVAmrybQJ5jnbdB8ymtLy2m.C90VsyF4UaT2N91
 5uCn3J2KX5gap1Zr2lEVGILxuwghyfX5Wy.scNmqffQ_L.L19QxfTBuAK7bUbaQGOnxdTspf8a5g
 mrbDmumefJPe3LrWoNmfmnEwhTE8TZuZGwgw5SQ--
Subject: Re: [PATCH bpf-next v8 05/11] seccomp,landlock: Enforce Landlock
 programs per process hierarchy
To: Andy Lutomirski <luto@kernel.org>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>,
 =?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?= <mic@digikod.net>,
 LKML <linux-kernel@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, David Drysdale
 <drysdale@google.com>, "David S . Miller" <davem@davemloft.net>,
 "Eric W . Biederman" <ebiederm@xmission.com>, Jann Horn <jann@thejh.net>,
 Jonathan Corbet <corbet@lwn.net>, Michael Kerrisk <mtk.manpages@gmail.com>,
 Kees Cook <keescook@chromium.org>, Paul Moore <paul@paul-moore.com>,
 Sargun Dhillon <sargun@sargun.me>, "Serge E . Hallyn" <serge@hallyn.com>,
 Shuah Khan <shuah@kernel.org>, Tejun Heo <tj@kernel.org>,
 Thomas Graf <tgraf@suug.ch>, Tycho Andersen <tycho@tycho.ws>,
 Will Drewry <wad@chromium.org>,
 Kernel Hardening <kernel-hardening@lists.openwall.com>,
 Linux API <linux-api@vger.kernel.org>,
 LSM List <linux-security-module@vger.kernel.org>,
 Network Development <netdev@vger.kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>
References: <20180227004121.3633-1-mic@digikod.net>
 <20180227004121.3633-6-mic@digikod.net>
 <20180227020856.teq4hobw3zwussu2@ast-mbp>
 <CALCETrVKRYnGJ9XNW-x7eHdMt+eGP90j7cAed-KTzp1KT_kMeQ@mail.gmail.com>
 <20180227045458.wjrbbsxf3po656du@ast-mbp>
 <CALCETrXZ=xJEd53RhA67_VDoAKBWgUeyBi9XN7ibrE7V6nzk5Q@mail.gmail.com>
 <20180227053255.a7ua24kjd6tvei2a@ast-mbp>
 <CALCETrUqc0wbig4ntQe9KNS-fOgYOpD+MPodXYruCRyJ7bhagA@mail.gmail.com>
 <b9579dae-625e-cd91-0656-821a8d1f2893@schaufler-ca.com>
 <CALCETrVo61UOGHJ6AgrLN_AyzUYuz-JRgET4d6ut-ErwUg_vZA@mail.gmail.com>
From: Casey Schaufler <casey@schaufler-ca.com>
Message-ID: <a40d339b-bdaa-0650-bb4a-bf030d8b3294@schaufler-ca.com>
Date: Tue, 27 Feb 2018 10:03:00 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <CALCETrVo61UOGHJ6AgrLN_AyzUYuz-JRgET4d6ut-ErwUg_vZA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593512796406478909?=
X-GMAIL-MSGID: =?utf-8?q?1593578255879461604?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 2/27/2018 9:36 AM, Andy Lutomirski wrote:
> On Tue, Feb 27, 2018 at 5:30 PM, Casey Schaufler <casey@schaufler-ca.com> wrote:
>> On 2/27/2018 8:39 AM, Andy Lutomirski wrote:
>>> On Tue, Feb 27, 2018 at 5:32 AM, Alexei Starovoitov
>>> <alexei.starovoitov@gmail.com> wrote:
>>>> [ Snip ]
>>> An earlier version of the patch set used the seccomp filter chain.
>>> Mickaël, what exactly was wrong with that approach other than that the
>>> seccomp() syscall was awkward for you to use?  You could add a
>>> seccomp_add_landlock_rule() syscall if you needed to.
>>>
>>> As a side comment, why is this an LSM at all, let alone a non-stacking
>>> LSM?  It would make a lot more sense to me to make Landlock depend on
>>> having LSMs configured in but to call the landlock hooks directly from
>>> the security_xyz() hooks.
>> Please, no. It is my serious intention to have at least the
>> infrastructure blob management in within a release or two, and
>> I think that's all Landlock needs. The security_xyz() hooks are
>> sufficiently hackish as it is without unnecessarily adding more
>> special cases.
>>
>>
> What do you mean by "infrastructure blob management"?

Today each security module manages their own module specific data,
for example inode->i_security and file->f_security. This prevents
having two security modules that have inode or file data from being
used at the same time, because they both need to manage those fields.
Moving the management of the module specific data (aka "blobs") from
the security modules to the module infrastructure will allow those
modules to coexist. Restrictions apply, of course, but I don't think
that Landlock uses any of the facilities that would have issues.
