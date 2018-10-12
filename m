Return-Path: <SRS0=REtU=MY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08C81C67837
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 01:20:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BDB6A2086A
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 01:20:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BDB6A2086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727365AbeJLIty (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Oct 2018 04:49:54 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:59754 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726196AbeJLItw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Oct 2018 04:49:52 -0400
Received: from static-50-53-48-205.bvtn.or.frontiernet.net ([50.53.48.205] helo=[192.168.192.153])
        by youngberry.canonical.com with esmtpsa (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
        (Exim 4.76)
        (envelope-from <john.johansen@canonical.com>)
        id 1gAm7M-0000Xf-WD; Fri, 12 Oct 2018 01:19:53 +0000
Subject: Re: [PATCH security-next v5 00/30] LSM: Explict ordering
To:     Jordan Glover <Golden_Miller83@protonmail.ch>
Cc:     Kees Cook <keescook@chromium.org>,
        James Morris <jmorris@namei.org>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        Paul Moore <paul@paul-moore.com>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        LSM <linux-security-module@vger.kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
References: <20181011001846.30964-1-keescook@chromium.org>
 <CAGXu5jLBaHj5MhXaK-8zdu6Rgo2B6rEq+at17xZ1Puct+YUajQ@mail.gmail.com>
 <ZhaXhoElmWQlsxHmgFHpB2xSWzJYFZWBasrSKQNjGj4_T2A4AY2F9v1rP9LkUfilUbZ0ExWXX9koLNjUM8S6baX6xfSSMPXY_CpihbCetVc=@protonmail.ch>
 <CAGXu5j+kekUdcE2EhUu__8MXJ1O+D=-zTXLGNCRVa_VyDxePpw@mail.gmail.com>
 <f68e5f4b-6360-a9e7-597f-89d1d3ca73c1@canonical.com>
 <32stV62RmME8Dj5jKB8Z03zPe_Et72kMo71D8SpgSOHUo6SaROc8DomMWdk5jDGpyqVd8T63NIIK2NdDw95clpF8Uj47Wca2FBFItXDRh7E=@protonmail.ch>
From:   John Johansen <john.johansen@canonical.com>
Openpgp: preference=signencrypt
Autocrypt: addr=john.johansen@canonical.com; prefer-encrypt=mutual; keydata=
 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
Organization: Canonical
Message-ID: <38dde301-d77e-35fd-88d4-5cdc5b570ee8@canonical.com>
Date:   Thu, 11 Oct 2018 18:19:48 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <32stV62RmME8Dj5jKB8Z03zPe_Et72kMo71D8SpgSOHUo6SaROc8DomMWdk5jDGpyqVd8T63NIIK2NdDw95clpF8Uj47Wca2FBFItXDRh7E=@protonmail.ch>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/11/2018 05:11 PM, Jordan Glover wrote:
> ‐‐‐‐‐‐‐ Original Message ‐‐‐‐‐‐‐
> On Friday, October 12, 2018 1:48 AM, John Johansen <john.johansen@canonical.com> wrote:
> 
>> On 10/11/2018 04:09 PM, Kees Cook wrote:
>>
>>> On Thu, Oct 11, 2018 at 3:58 PM, Jordan Glover
>>> Golden_Miller83@protonmail.ch wrote:
>>>
>>>> On Thursday, October 11, 2018 7:57 PM, Kees Cook keescook@chromium.org wrote:
>>>>
>>>>>     To switch to SELinux at boot time with
>>>>>     "CONFIG_LSM=yama,loadpin,integrity,apparmor", the old way continues to
>>>>>     work:
>>>>>
>>>>>     selinux=1 security=selinux
>>>>>
>>>>>     This will work still, since it will enable selinux (selinux=1) and
>>>>>     disable all other major LSMs (security=selinux).
>>>>>
>>>>>     The new way to enable selinux would be using
>>>>>     "lsm=yama,loadpin,integrity,selinux".
>>>>>
>>>>
>>>> It seems to me that legacy way is more user friendly than the new one.
>>>> AppArmor and SElinux are households names but the rest may be enigmatic
>>>> for most users and the need for explicit passing them all may be
>>>> troublesome. Especially when the new ones like sara,landlock or cows :)
>>>> will be incoming. Moreover to knew what you have to pass there, you need
>>>> to look at CONFIG_LSM in kernel config (which will vary across distros
>>>> and also mean copy-paste from the web source may won't work as expected)
>>>> which again most users don't do.
>>>> I think there is risk that users will end up with "lsm=selinux" without
>>>> realizing that they may disable something along the way.
>>>> I would prefer for "lsm=" to work as override to "CONFIG_LSM=" with
>>>> below assumptions:
>>>> I. lsm="$lsm" will append "$lsm" at the end of string. Before extreme
>>>> stacking it will also remove the other major (explicit) lsm from it.
>>>> II. lsm="!$lsm" will remove "$lsm" from the string.
>>>> III. If "$lsm" already exist in the string, it's moved at the end of it
>>>> (this will cover ordering).
>>>
>>> We've had things sort of like this proposed, but if you can convince
>>> James and others, I'm all for it. I think the standing objection from
>>> James and John about this is that the results of booting with
>>> "lsm=something" ends up depending on CONFIG_LSM= for that distro. So
>>> you end up with different behaviors instead of a consistent behavior
>>> across all distros.
>>
>> Its certainly a point that could confuse the user. I do have concerns
>> about it, but not something that is on a must haves list
>>
>>> Now, in the future blob and extreme stacking world, having the
>>> explicit lsm= list shouldn't be too bad since LSMs will effectively
>>> ALL be initialized -- but they'll be inactive since they have no
>>> policy loaded.
>>
>> you are more optimistic about this than I am, but there will be at
>> least some movement towards this.
>>
>>> But I still agree with you: I'd like a friendlier way to
>>> disable/enable specific LSMs, but an explicit lsm= seems to be the
>>> only way.
>>
>> Hrmmm, I don't know about the only way, but a way to provide the
>> explicit list, and also set a specific set as the default in the
>> Kconfig is a hard requirement.
>>
> 
> My proposition allows for explicit "lsm=" list but also accepts non
> explicit list. This is it's advantage above current approach.
> 
> The current approach works but it seems to target the very same people
> who designed it :)
> 
>> The initial lsm.ebable, lsm.disable had too many issues, and for
>> various reasons I never managed to get back to kees' proposal
>> for using +.
>>
>> That said, I do think the right approach for the initial pass is
>> the explicit list. It moves the arguments to the side and allows
>> this work to move forward.
>>
> 
> I'm afraid when it hits stable kernel and people will rely on it,
> then it will be too late. Things will be even more hard to change
> than now when we have to keep legacy syntax of security=xxx.
> 
> I added explanation why explicit list doesn't solve consistency
> across distros in the other reply
> 

It isn't perfect but it manages consistency across distros as best as
can be achieved atm.

Its just a fact that some LSMs are not going to be built into some
kernels. The only way to deal with that is direct people to build
their own kernels.

The other major problem is that the current LSM stacking patches do
not deal with "extreme" stacking. So doing

lsm=+apparmor

(I am going to stick with the + syntax atm to avoid confusion between
adding and setting)

assuming apparmor is builtin will not necessarily get you apparmor if
another major lsm is enabled.  Yes your specific proposal would as it
specifies it overrides the current major, except that ordering
important so if say landlock registers before apparmor, you may still
not get apparmor.

You proposal does not provide a means to ensure you have only a
specific set of LSMs enabled. As an LSM not explicitly listed in lsm=
lsm=! may still be enabled. So the user is going to have to be aware
of the initial LSMs list if they are trying to guarentee a specific
security arrangement.

This violates one of the hard asks, and I will tell you that this will
just mean there is going to be some distro patching to make sure it
exists.

The current explicit list is more consistent, and it is amenable to
being extended with + or ! as selective add/remove so we are not
locked into only supporting an explicit list.


>>>> It's possible that something lime this was discussed already
>>>> but without full examples it was hard to me for tracking things.
>>>
>>> It's been a painful thread. ;)
>>
>> Indeed
> 
> Jordan
> 

