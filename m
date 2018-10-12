Return-Path: <SRS0=REtU=MY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 969D8C67877
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 18:11:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E63220645
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 18:11:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2E63220645
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727080AbeJMBpV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Oct 2018 21:45:21 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:49777 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726339AbeJMBpU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Oct 2018 21:45:20 -0400
Received: from static-50-53-48-205.bvtn.or.frontiernet.net ([50.53.48.205] helo=[192.168.192.153])
        by youngberry.canonical.com with esmtpsa (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
        (Exim 4.76)
        (envelope-from <john.johansen@canonical.com>)
        id 1gB1uM-0008Bs-KV; Fri, 12 Oct 2018 18:11:31 +0000
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
 <37rRa7F7i2XcwVPiT6gLC8cX8p0732iDiT6mGjstlbBi3mcJsQCLA6A8HcDMNjR0SGheErloJl8z-Z5c57XxtJRBF9-LO_fUTUf41EcAGC4=@protonmail.ch>
 <1a8ac9f4-8f82-5d3b-46ef-08801793443e@canonical.com>
 <oANoEf39nJu-HzALTRaisEW9Um9AoAH5KyO5lM7tpmml58QTZLk7U9aHpTmcg8W_684zTws70sLPZXlK5Z91zLluFesVPYXiEUbIZr98Ljs=@protonmail.ch>
From:   John Johansen <john.johansen@canonical.com>
Openpgp: preference=signencrypt
Autocrypt: addr=john.johansen@canonical.com; prefer-encrypt=mutual; keydata=
 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
Organization: Canonical
Message-ID: <841f16b4-a8d0-4a4f-6e3e-15cd70bc25cc@canonical.com>
Date:   Fri, 12 Oct 2018 11:11:26 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <oANoEf39nJu-HzALTRaisEW9Um9AoAH5KyO5lM7tpmml58QTZLk7U9aHpTmcg8W_684zTws70sLPZXlK5Z91zLluFesVPYXiEUbIZr98Ljs=@protonmail.ch>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/12/2018 04:31 AM, Jordan Glover wrote:
> ‐‐‐‐‐‐‐ Original Message ‐‐‐‐‐‐‐
> On Friday, October 12, 2018 2:26 AM, John Johansen <john.johansen@canonical.com> wrote:
> 
>> On 10/11/2018 04:53 PM, Jordan Glover wrote:
>>
>>> ‐‐‐‐‐‐‐ Original Message ‐‐‐‐‐‐‐
>>> On Friday, October 12, 2018 1:09 AM, Kees Cook keescook@chromium.org wrote:
>>>
>>>> We've had things sort of like this proposed, but if you can convince
>>>> James and others, I'm all for it. I think the standing objection from
>>>> James and John about this is that the results of booting with
>>>> "lsm=something" ends up depending on CONFIG_LSM= for that distro. So
>>>> you end up with different behaviors instead of a consistent behavior
>>>> across all distros.
>>>
>>> Ok, I'll try :)
>>> The final lsm string contains two parts: Kconfig "CONFIG_LSM=" and boot
>>> param "lsm=". Changing even only one of those parts also changes the
>>> final string.
>>> In case of distros, it's the "CONFIG_LSM=" which changes. Even when "lsm="
>>> stays constant, the behavior will be different, example:
>>> Distro A has: CONFIG_LSM=loadpin,integrity,selinux
>>> Distro B has CONFIG_LSM=yama,loadpin,integrity,selinux
>>> User on distro A wants to enable apparmor with:
>>> lsm=loadpin,integrity,apparmor
>>> which they do and add it to howto on wiki.
>>> User on distro B want to enable apparmor, they found info on some wiki and do:
>>> lsm=loadpin,integrity,apparmor
>>> Puff, yama got disabled!
>>> Above example shows why I think "consistent behavior across all distros"
>>> argument for current approach is flawed - because distros aren't
>>> consistent. In my proposition the user will just use "lsm=apparmor" and
>>> it will consistently enable apparmor on all distros which is what they
>>> really wanted, but all pre-existing differences across distros will
>>> remain unchanged.
>>
>> Are you sure about that? I have had more than one question about
>> security=X resulting in a system with more than just X enabled. Ie why
>> is yama enabled when I specifically set security to X.
>>
> 
> So, non-explicit list will match current "security=" behavior which users
> are more familiar with. The current answer for this question is "because
> your distro enabled it and you didn't disabled it. With non-explcit list
> that answer will stay the same.
> 

the current behavior is problematic leads to a configuration nightmare, 
and is the reason lsm= is proposed instead of just sticking with
security=

> With explicit list, the question will be "why is yama disabled when I
> enabled AppArmor with lsm=apparmor".
> 
yes that will happen as well

> To ask both questions user have to know that something like "yama" exist
> in first place.
> 
yes. However when it comes to security I don't think its too insane to
want to vet new modules before they become part of your configuration.
This is something distros want to be able to do and something some users
want.

I am not claiming this is what all users will want, and it certainly
isn't the best situation for the adoption of new lsms. But is a very
understandable security policy stance.

> As for question what users typically want you may look at search results
> for "disable/enable yama" and "disable/enable apparmor/selinux". The
> difference is several orders of magnitude. That's why I think typical user
> just want to switch on/off one major lsm. I don't think anecdotal evidence
> is representative here.
> 
>> There will certainly be cases where what you describe is exactly what
>> the user wants. The problem is an explosion of options isn't good
>> for the user either.
>>
>> What I want at the moment is the discussion about different ways to
>> enable LSMs to be split off so this work can move forward.
>>
>>> The current approach requires that everyone who dares to touch "lsm="
>>> knows about existence of all lsm, their enabled/disabled status on
>>> target distro and their order. I doubt there are many people other
>>> than recipients of this mail who fit for the above.
>>
>> Without having gotten a chance to review the current set of patches
>> that was not what was discussed, it should only requires they know the
>> set that they want.
>>
> 
> "it should only requires they know the set that they want" is very
> hard requirement and I don't think most users will pass this.
> Especially when sets like:
> 
> lsm=yama,loadpin,integrity,apparmor
> lsm=loadpin,integrity,yama,apparmor
> 
> will behave differently.
> 
yes, that is a problem and it highlights the complexity of the problem
we are dealing with.

Your proposal tries to hide the ordering issues from the user but they
still suffer from the potentially different behavior of list ordering
as it is moving the lsm around in the list.

fwiw kees finally convinced me that having the order set separate from
enablement in the kconfig is better for the user because of problems
like this.
