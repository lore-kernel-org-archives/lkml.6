Return-Path: <SRS0=01Bl=QN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31325C282CC
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 17:03:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E67C620823
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 17:03:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="t+ThiFVT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731471AbfBFRDP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Feb 2019 12:03:15 -0500
Received: from sonic302-28.consmr.mail.gq1.yahoo.com ([98.137.68.154]:36490
        "EHLO sonic302-28.consmr.mail.gq1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726767AbfBFRDO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Feb 2019 12:03:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1549472593; bh=mE8IphMtDdaabS6EguCO2ZT1kDFCkW7laBDMmxpvW7M=; h=Subject:To:Cc:References:From:Date:In-Reply-To:From:Subject; b=t+ThiFVTK4YD5bd3dOAT10Owu6eVLhByqieRnwtBsVyc+yGDFVTfm8eckPclHbLUqLJT/AG4mGbCUHqUrrohifgVZn0ugQU70eh7OEHtZygTs4sVu8vLZcLQBxeZmhujohHdNW+qYFeGP1O/llwwxuFd4c6go0Tp9zWxWNlds0FN/MWm7We+ALtl9AOdWFzcC5wol9Jnfj+Z5DztwIdjXMsCvxJxndHNBaYtp9i+IJTop9ECAeocCwOoCWh2H2kTSurkT9Rww8byT+B0FVDcQu1sM7Q/ZDNpCgUMEz/c8p4klmH9lFYJqcPpEgRGG8kcgM1sjNflhmCdg7YGrnN5JQ==
X-YMail-OSG: uCgeESEVM1kuRtnZWN6gVMJExCrskPgA2223rFcKlCDn9IJ4gbv_G9eKD5LOG31
 y2WHSGx3C38sehhLqETjG3S9ddfvOySQCmH3NUJU0ABqpZ76us147mzXJHFLh0O5R9.0P8Nj3MtG
 UlBO_3RNCtKvaV4SQmDd9tsGrBc0uaT7r2RVVUzEqVTBqamaXc8nLaZksFJj1E0P83ToBMsQiOK9
 7Cb58cpXRlLGtArTIcX.k18z.Vpd_7ZLYhB5MX8In4YMbS27aG1.uTmXpXYyuGkQiWeQeRCdWfaJ
 wNgtTYUJr29v2yG9fxZPGeCPG6Ik8JhF1FKYtD_YdDQXksbaYFWzzgnANVljdm070kZpbNOOPxto
 _gzQboN6.7Td7HuS64H0AQAUPygya_awgkYUeNM5W9uFW2rgTC1M7oVpdyDaQK4pe6YmQU_Q7TMV
 dLlF1hTP8FbCv2XldGAwqXtnyOcb8n3gT.RgKHyEbX0bSxrhHosc2qbRVuGIRvPh5o.O19uRcVdg
 gQAbakqf5S1p9O6aoiUdbkLmpDWvlMm75KMyPOc5VTJAGRgYlzsSCmGJ0kH03QkZEAlwNuxLyNRk
 .uFmkwlHArQ8XXiJFeC1Ch53KUXoDWGj7NyZH0vLEFl1jebT5TKlSytLBkKVFDRgU19GFEOP_m5I
 3EQ16MMHZMBr4a6eQuYUdLrWQUWQJdZwQObcTHN5PZDcGc5jsRBz1kFHc9_4ZgrrVtoxOpJb3ikZ
 dFjzqrUdDW8_KRwZ6JnE7_3dS.QpjfSYSUkHqBBFBNxG4J9dbVsYtjfFKUpRHKY1iqh8NcrdeW7M
 9k_t5s7CKbEbGS6rMX.nN_abaDGh6uMk6eq3LXhLOUyCygNnGqGiwBZ9PvFZv3Ue2xF8SwHuVYfR
 43gv1D8lMAyfSQt7GC6RxW0j35Mhqul6PdMhz._WawN6ECQYijhVLg9lN6VbBU7eP90iVxVwAPkR
 rtvUSGl4FGlC6J1VtcxO.JHGvWo1japYLez817.Db3.xVUQLmseI7nYUJB6muAFyocMP9taKIpYj
 nPahtJcwBHpBhiDVPU8RYjrKpWIG2npq4j3AG3cUNhrJawJ4G3Z29880SNPkKZX0MajuqxtCYiuU
 Sg8YjRDUn6dMaWt7DNtSfy94VtGcX8vFYaKjK0oX25BcfE9DExfTxALsCRYfuomH0aFEH_UUg3lP
 MTrPn27MmwYYXgSRAQ9OvP_LeMknG2ILPDn0-
Received: from sonic.gate.mail.ne1.yahoo.com by sonic302.consmr.mail.gq1.yahoo.com with HTTP; Wed, 6 Feb 2019 17:03:13 +0000
Received: from c-67-169-65-224.hsd1.ca.comcast.net (EHLO [192.168.0.100]) ([67.169.65.224])
          by smtp413.mail.gq1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 45a6055d231189cdf2a08b69a37bc133;
          Wed, 06 Feb 2019 17:03:09 +0000 (UTC)
Subject: Re: [PATCH] LSM: Allow syzbot to ignore security= parameter.
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Dmitry Vyukov <dvyukov@google.com>
Cc:     Paul Moore <paul@paul-moore.com>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        syzbot <syzbot+21016130b0580a9de3b5@syzkaller.appspotmail.com>,
        tyhicks@canonical.com, John Johansen <john.johansen@canonical.com>,
        James Morris <jmorris@namei.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-security-module@vger.kernel.org,
        Serge Hallyn <serge@hallyn.com>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Jeffrey Vander Stoep <jeffv@google.com>,
        SELinux <selinux@tycho.nsa.gov>,
        Russell Coker <russell@coker.com.au>,
        Laurent Bigonville <bigon@debian.org>,
        syzkaller <syzkaller@googlegroups.com>,
        Andrew Morton <akpm@linux-foundation.org>
References: <000000000000c178e305749daba4@google.com>
 <6c9112a2-33f3-0c29-c944-1d129a0026e7@tycho.nsa.gov>
 <CAHC9VhR6gG6_RkT1OEH4PArHpzUGkOjVCpKwAmad+TDfC15sgQ@mail.gmail.com>
 <CACT4Y+YaBpi95Puae3Bjn1opL+UsdUWns2PDaFU-EmamuMusag@mail.gmail.com>
 <e2e02f43-abfe-171e-a5b7-3fb9086cc733@schaufler-ca.com>
 <CACT4Y+aaF8pLirqA+Yv4RjemDofEZymjPV6z5EEPQk3b7or10g@mail.gmail.com>
 <e598f3c7-22bc-91c2-2f47-0eec068f5180@I-love.SAKURA.ne.jp>
 <CACT4Y+YXsD4f+ngzN7SGXcUGBn-jG1KeyrZJBzcUWo-AbdTe4w@mail.gmail.com>
 <05340d28-36c2-267e-d54e-416fddfba211@i-love.sakura.ne.jp>
 <CACT4Y+Ynyy-bMK4cxhgNoAaauFdjzExuELM6u0amksbR4wy7GQ@mail.gmail.com>
 <71e3652b-b222-0c3f-8b48-5980ddcaeb93@i-love.sakura.ne.jp>
 <CACT4Y+Z036bZfN1-_VaQ5EorwFt_tpPm=RTnrYN5qKV_ebgoFw@mail.gmail.com>
 <52531a69-10ed-d263-be66-e707705597d6@i-love.sakura.ne.jp>
 <CACT4Y+Yd1YN=OELBmzUDvwdg5KuV2WnN9WZpjk5O_yuS0i1yOA@mail.gmail.com>
 <8f48e1d0-c109-f8a9-ea94-9659b16cae49@i-love.sakura.ne.jp>
From:   Casey Schaufler <casey@schaufler-ca.com>
Message-ID: <0d23d1a5-d4af-debf-6b5f-aaaf698daaa8@schaufler-ca.com>
Date:   Wed, 6 Feb 2019 09:03:06 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <8f48e1d0-c109-f8a9-ea94-9659b16cae49@i-love.sakura.ne.jp>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/6/2019 2:23 AM, Tetsuo Handa wrote:
> On 2019/02/04 17:07, Dmitry Vyukov wrote:
>> On Fri, Feb 1, 2019 at 2:09 PM Tetsuo Handa
>> <penguin-kernel@i-love.sakura.ne.jp> wrote:
>>> On 2019/02/01 19:50, Dmitry Vyukov wrote:
>>>> On Fri, Feb 1, 2019 at 11:44 AM Tetsuo Handa
>>>> <penguin-kernel@i-love.sakura.ne.jp> wrote:
>>>>> On 2019/02/01 19:09, Dmitry Vyukov wrote:
>>>>>> Thanks for the explanations.
>>>>>>
>>>>>> Here is the change that I've come up with:
>>>>>> https://github.com/google/syzkaller/commit/aa53be276dc84aa8b3825b3416542447ff82b41a
>>>>> You are not going to apply this updated config to upstream kernels now, are you?
>>>>> Removing CONFIG_DEFAULT_SECURITY="apparmor" from configs used by upstream kernels
>>>>> will cause failing to enable AppArmor (unless security=apparmor is specified).
>>>>
>>>> We do use  security=apparmor, see:
>>>> https://github.com/google/syzkaller/blob/master/dashboard/config/upstream-apparmor.cmdline
>>>> https://github.com/google/syzkaller/blob/master/dashboard/config/upstream-selinux.cmdline
>>>> https://github.com/google/syzkaller/blob/master/dashboard/config/upstream-smack.cmdline
>>>>
>>> Oh, security= parameter is explicitly specified on all targets?
>>> Then, we can abuse CONFIG_DEBUG_AID_FOR_SYZBOT option. ;-)
>>>
>>> LSM folks, may we use this patch for linux-next.git ?
>>> CONFIG_DEBUG_AID_FOR_SYZBOT is a linux-next.git-only kernel config option used by syzbot.
>>
>> Then we also need this on syzbot side, right? Otherwise it seems that
>> all instances will default to a single security module.
>> https://github.com/google/syzkaller/commit/ffec3d1894ffd05966b50efa49ca19af76c9ea81
>>
> Right.
>
> But as I update the documentation ( https://tomoyo.osdn.jp/2.6/chapter-3.html.en#3.6 ),
> I came to think that we should ignore security= parameter when lsm= parameter is specified.
>
> Currently, it is possible to enable TOMOYO and only one of SELinux/Smack/AppArmor. Therefore,
> it is possible to disable only TOMOYO by specifying security=selinux when we want to enable
> only SELinux, by specifying security=smack when we want to enable only Smack, by specifying
> security=apparmor when we want to enable only AppArmor. That is, we can use security= parameter
> in order to specify the other LSM module which should not be disabled.
>
> But when it becomes possible to enable TOMOYO and more than one of SELinux/Smack/AppArmor,
> we will no longer be able to selectively disable one LSM module using security= parameter, for
> security= parameter is intended for specifying only one LSM module which should be enabled.
> That is, we will need to use lsm= parameter in order to selectively disable LSM modules.

Yes. That is correct. The existing behavior of security= is maintained.
The new behavior of lsm= is provided to allow general handling of a list
of security modules. It uses the same form of data as CONFIG_LSM.

> Then, I think that it is straightforward (and easier to manage) to ignore security= parameter
> when lsm= parameter is specified.

That reduces flexibility somewhat. If I am debugging security modules
I may want to use lsm= to specify the order while using security= to
identify a specific exclusive module. I could do that using lsm= by
itself, but habits die hard.

> Furthermore, we could even avoid introducing lsm= parameter
> by allowing security= parameter to specify multiple LSM modules.

security=yama would work differently than it does today.
There would be no way to specify an exclusive module but
no minor modules.

If I have Yama and SELinux built in I could never disable Yama.

	security=selinux - would not disable Yama

whereas

	lsm=selinux      - would disable Yama

> For example, security= parameter
> is interpreted as a list of all LSM modules which should be enabled when it contains a comma,
> and it is interpreted as one of LSM_FLAG_LEGACY_MAJOR modules which should be enabled otherwise.
> Then, specifying security=selinux or security=smack or security=tomoyo or security=apparmor or
> security=none will respectively enable SELinux, Smack, TOMOYO, AppArmor, none of
> SELinux/Smack/TOMOYO/AppArmor. And specifying e.g. security=, will disable all LSM modules.

We debated the possibility of making the comma an indication
that we had an explicit list. It comes down to the "trailing
comma" syntax, where "security=selinux" and "security=selinux,"
mean different things. Consensus was that this is too clever,
and everyone would hate it.

