Return-Path: <SRS0=SFDS=MQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE404C64EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 06:22:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A298B21470
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 06:22:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A298B21470
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727269AbeJDNOF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Oct 2018 09:14:05 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:36522 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726438AbeJDNOF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Oct 2018 09:14:05 -0400
Received: from static-50-53-48-205.bvtn.or.frontiernet.net ([50.53.48.205] helo=[192.168.192.153])
        by youngberry.canonical.com with esmtpsa (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
        (Exim 4.76)
        (envelope-from <john.johansen@canonical.com>)
        id 1g7x1g-0002TQ-6X; Thu, 04 Oct 2018 06:22:20 +0000
Subject: Re: [PATCH security-next v4 23/32] selinux: Remove boot parameter
To:     Randy Dunlap <rdunlap@infradead.org>,
        Kees Cook <keescook@chromium.org>,
        James Morris <jmorris@namei.org>
Cc:     Jordan Glover <Golden_Miller83@protonmail.ch>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        Paul Moore <paul@paul-moore.com>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        "Schaufler, Casey" <casey.schaufler@intel.com>,
        linux-security-module <linux-security-module@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
References: <20181002005505.6112-1-keescook@chromium.org>
 <QpdcE4QSCQKJqDmB2QBEGBlnlioHuRHlM0g5HF8KbHjU1zIUAOjnQ2r9EIMu3m0S2OWNR3_M_TSp_M6CVDqkp6kKuFPUvegsyDPNw1AGju4=@protonmail.ch>
 <CAGXu5jKqXNbEvPr1axQtGCCnWsGhDgjynW5u326mcx4vZ1oH8g@mail.gmail.com>
 <abe03d09-4dcb-2b02-4102-5e108d617a42@canonical.com>
 <CAGXu5jJtC1gkJ0ZKDFroL8UzvjiPfmC+6EsrzyB0j0oETdSQQg@mail.gmail.com>
 <alpine.LRH.2.21.1810030758460.23596@namei.org>
 <CAGXu5jLKgrdhah-5TtAXDL-odbLGeyAUH2=PkAU769AkEnZFfQ@mail.gmail.com>
 <5955f5ce-b803-4f58-8b07-54c291e33da5@canonical.com>
 <alpine.LRH.2.21.1810040416500.13517@namei.org>
 <CAGXu5j+oPR58oJ06-n7e96-Rmu+ywTW0hud5LhOZ_3UXG5s12w@mail.gmail.com>
 <alpine.LRH.2.21.1810040427550.13517@namei.org>
 <CAGXu5jJmVR4Wsdti=aFaDhCBaxsVu1KTJOdsJOtFvZOV1ZhdvQ@mail.gmail.com>
 <alpine.LRH.2.21.1810040723320.16168@namei.org>
 <CAGXu5jJDBhFrdCBHH4MZVDmG88mMxSaSx0w9anCcyx24YHLO5w@mail.gmail.com>
 <6037a1f0-7af1-9847-91f6-6444f04f5b21@infradead.org>
From:   John Johansen <john.johansen@canonical.com>
Openpgp: preference=signencrypt
Autocrypt: addr=john.johansen@canonical.com; prefer-encrypt=mutual; keydata=
 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
Organization: Canonical
Message-ID: <9473fc3d-2737-aec3-d91a-fdd936872b7d@canonical.com>
Date:   Wed, 3 Oct 2018 23:22:16 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <6037a1f0-7af1-9847-91f6-6444f04f5b21@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/03/2018 04:59 PM, Randy Dunlap wrote:
> On 10/3/18 4:55 PM, Kees Cook wrote:
>> On Wed, Oct 3, 2018 at 2:34 PM, James Morris <jmorris@namei.org> wrote:
>>> On Wed, 3 Oct 2018, Kees Cook wrote:
>>>
>>>> On Wed, Oct 3, 2018 at 11:28 AM, James Morris <jmorris@namei.org> wrote:
>>>>> On Wed, 3 Oct 2018, Kees Cook wrote:
>>>>>
>>>>>> On Wed, Oct 3, 2018 at 11:17 AM, James Morris <jmorris@namei.org> wrote:
>>>>>>> On Tue, 2 Oct 2018, John Johansen wrote:
>>>>>>>> To me a list like
>>>>>>>>   lsm.enable=X,Y,Z
>>>>>>>
>>>>>>> What about even simpler:
>>>>>>>
>>>>>>> lsm=selinux,!apparmor,yama
>>>>>>
>>>>>> We're going to have lsm.order=, so I'd like to keep it with a dot
>>>>>> separator (this makes it more like module parameters, too). You want
>>>>>> to mix enable/disable in the same string? That implies you'd want
>>>>>> implicit enabling (i.e. it complements the builtin enabling), which is
>>>>>> opposite from what John wanted.
>>>>>>
>>>>>
>>>>> Why can't this be the order as well?
>>>>
>>>> That was covered extensively in the earlier threads. It boils down to
>>>> making sure we do not create a pattern of leaving LSMs disabled by
>>>> default when they are added to the kernel. The v1 series used
>>>> security= like this:
>>>>
>>>> +       security=       [SECURITY] An ordered comma-separated list of
>>>> +                       security modules to attempt to enable at boot. If
>>>> +                       this boot parameter is not specified, only the
>>>> +                       security modules asking for initialization will be
>>>> +                       enabled (see CONFIG_DEFAULT_SECURITY). Duplicate
>>>> +                       or invalid security modules will be ignored. The
>>>> +                       capability module is always loaded first, without
>>>> +                       regard to this parameter.
>>>>
>>>> This meant booting "security=apparmor" would disable all the other
>>>> LSMs, which wasn't friendly at all. So "security=" was left alone (to
>>>> leave it to only select the "major" LSM: all major LSMs not matching
>>>> "security=" would be disabled). So I proposed "lsm.order=" to specify
>>>> the order things were going to be initialized in, but to avoid kernels
>>>> booting with newly added LSMs forced-off due to not being listed in
>>>> "lsm.order=", it had to have implicit fall-back for unlisted LSMs.
>>>> (i.e. anything missing from lsm.order would then follow their order in
>>>> CONFIG_LSM_ORDER, and anything missing there would fall back to
>>>> link-time ordering.) However, then the objection was raised that this
>>>> didn't provide a way to explicitly disable an LSM. So I proposed
>>>> lsm.enable/disable, and John argued for CONFIG_LSM_ENABLE over
>>>> CONFIG_LSM_DISABLE.
>>>
>>> Ok, but it may end up being clearer, simpler, and thus more secure to just
>>> have a single way to configure LSM.
>>>
>>> For example:
>>>
>>>   - All LSMs which are built are NOT enabled by default
>>>
>>>   - You specify enablement and order via a Kconfig:
>>>
>>>         CONFIG_LSM="selinux,yama"
>>>
>>>   - This can be entirely overridden by a boot param:
>>>
>>>         lsm="apparmor,landlock"
>>
>> This doesn't work with how SELinux and AppArmor do their bootparams,
>> unfortunately. (And Paul and Stephen have expressed that the
>> documented selinux on/off must continue to work.) For example, let's
>> say you've built an Ubuntu kernel with:
>>
>> CONFIG_SELINUX=y
>> ...
>> CONFIG_LSM="yama,apparmor"
>>
>> (i.e. you want SELinux available, but not enabled, so it's left out of
>> CONFIG_LSM)
>>
>> Then someone boots the system with:
>>
>> selinux=1 security=selinux
>>
>> In what order does selinux get initialized relative to yama?
>> (apparmor, flagged as a "legacy major", would have been disabled by
>> the "security=" not matching it.)
>>
> 
> To me, "security=selinux" means SELinux and nothing else, so I think that
> all of these params are inviting a lot of confusion.
> 
> Sorry, I don't have a good answer for this.
> 

Your not the only one. I have had users ask about why they are getting
other security messures (yama in particular) when they specified a
specific security=



>>
>> The LSM order needs to be defined externally to enablement because
>> something may become enabled when not listed in the order.
>>
>> Now, maybe I misunderstood your earlier suggestion, and what you meant
>> was to do something like:
>>
>> CONFIG_LSM="yama,apparmor,!selinux"
>>
>> to mean "put selinux here in the order, but don't enable it". Then the
>> problem becomes what happens to an LSM that has been built in but not
>> listed in CONFIG_LSM?
>>
>> Related to that, this means that when new LSMs are added, they will
>> need to be added to any custom CONFIG_LSM= or lsm= parameters. If
>> that's really how we have to go, I'll accept it, but I think it's a
>> bit unfriendly. :P
>>
>> Another reason I don't like it is because it requires users to know
>> about all the LSMs to make changes. One LSM can't be added/removed
>> without specifying ALL of the LSMs. (i.e. there is no trivial way to
>> enable/disable a single LSM without it growing its own enable/disable
>> code as in SELinux/AppArmor. I'd hoped to make that easier for both
>> users and developers.) Again, I can live with it, but I think it's
>> unfriendly.
>>
>> I just want to have a direct I can go that meets all the requirements.
>> :) I'm fine to ignore my sense of aesthetics if everyone can agree on
>> the code.
> 
> 

