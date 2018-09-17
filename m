Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 192DFECE560
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 22:37:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9764C2147A
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 22:37:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9764C2147A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727070AbeIREGf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 00:06:35 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:58919 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725787AbeIREGf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 00:06:35 -0400
Received: from static-50-53-48-205.bvtn.or.frontiernet.net ([50.53.48.205] helo=[10.8.192.6])
        by youngberry.canonical.com with esmtpsa (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
        (Exim 4.76)
        (envelope-from <john.johansen@canonical.com>)
        id 1g228d-0007IY-EI; Mon, 17 Sep 2018 22:37:09 +0000
Subject: Re: [PATCH 16/18] LSM: Allow arbitrary LSM ordering
To:     Casey Schaufler <casey@schaufler-ca.com>,
        Kees Cook <keescook@chromium.org>
Cc:     James Morris <jmorris@namei.org>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Paul Moore <paul@paul-moore.com>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        "Schaufler, Casey" <casey.schaufler@intel.com>,
        LSM <linux-security-module@vger.kernel.org>,
        LKLM <linux-kernel@vger.kernel.org>
References: <20180916003059.1046-1-keescook@chromium.org>
 <20180916003059.1046-17-keescook@chromium.org>
 <84e1a5a8-8997-829f-cf09-1d29895a3f99@schaufler-ca.com>
 <CAGXu5jK5CzXUii97q_yk3KzBTw0SOmoc=-zcm+3jAqEHe76AgQ@mail.gmail.com>
 <35b0af5b-e37e-e192-73b5-0d0b37d9e37f@schaufler-ca.com>
 <CAGXu5jJ71RLGh0nDgOaN3vCXFGE0poXFU2Gb9o+20aO+AEdOvw@mail.gmail.com>
 <8f0bd39b-29a6-325d-4558-d9f484249c22@schaufler-ca.com>
 <CAGXu5jLeTfwEXAZLz_H1PCx0ySWZcRhXQMfnE14TG8BvxY46JA@mail.gmail.com>
 <53377892-695f-6336-8574-54c7aa0a4201@schaufler-ca.com>
 <7ecfffc3-d2a4-3ff7-4bf5-db3029d73c59@canonical.com>
 <fbdc2a75-8364-c743-f9c3-9dcd2570c569@schaufler-ca.com>
From:   John Johansen <john.johansen@canonical.com>
Openpgp: preference=signencrypt
Autocrypt: addr=john.johansen@canonical.com; prefer-encrypt=mutual; keydata=
 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
Organization: Canonical
Message-ID: <e9292d89-12bd-2c4a-9ca2-5758de790f2f@canonical.com>
Date:   Mon, 17 Sep 2018 15:36:45 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <fbdc2a75-8364-c743-f9c3-9dcd2570c569@schaufler-ca.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/17/2018 02:57 PM, Casey Schaufler wrote:
> On 9/17/2018 12:55 PM, John Johansen wrote:
>> On 09/17/2018 12:23 PM, Casey Schaufler wrote:
>>> On 9/17/2018 11:14 AM, Kees Cook wrote:
>>>>> Keep security=$lsm with the existing exclusive behavior.
>>>>> Add lsm=$lsm1,...,$lsmN which requires a full list of modules
>>>>>
>>>>> If you want to be fancy (I don't!) you could add
>>>>>
>>>>> lsm.add=$lsm1,...,$lsmN which adds the modules to the stack
>>>>> lsm.delete=$lsm1,...,$lsmN which deletes modules from the stack
>>>> We've got two issues: ordering and enablement. It's been strongly
>>>> suggested that we should move away from per-LSM enable/disable flags
>>>> (to which I agree).
>>> I also agree. There are way too many ways to turn off some LSMs.
>>>
>> I wont disagree, but its largely because we didn't have this discussion
>> when we should have.
> 
> True that.
> 
> 
>>>> If ordering should be separate from enablement (to
>>>> avoid the "booted kernel with new LSM built in, but my lsm="..." line
>>>> didn't include it so it's disabled case), then I think we need to
>>>> split the logic (otherwise we just reinvented "security=" with similar
>>>> problems).
>>> We could reduce the problem by declaring that LSM ordering is
>>> not something you can specify on the boot line. I can see value
>>> in specifying it when you build the kernel, but your circumstances
>>> would have to be pretty strange to change it at boot time.
>>>
>> if there is LSM ordering the getting
>>
>>   lsm=B,A,C
>>
>> is not the behavior I would expect from specifying
>>
>>   lsm=A,B,C
> 
> Right. You'd expect that they'd be used in the order specified.
> 

and yet you argue for something different ;)

>>>> Should "lsm=" allow arbitrary ordering? (I think yes.)
>>> I say no. Assume you can specify it at build time. When would
>>> you want to change the order? Why would you?
>>>
>> because maybe you care about the denial message from one LSM more than
>> you do from another. Since stacking is bail on first fail the order
>> could be important from an auditing POV
> 
> I understand that a distribution would want to specify the order
> for support purposes and that a developer would want to specify
> the order to ensure reproducible behavior. But they are going to
> be controlling their kernel builds. I'm not suggesting that the
> order shouldn't be capable of build time specification. What I
> don't see is a reason to rearrange it at boot time.
> 

Because not all users have the same priority as the distro. It can
also aid in debugging and testing of LSMs in a stacked situation.

>> Auditing is why apparmor's internal stacking is not bail on first
>> fail.
> 
> Within a security module I get that. But we've already got the
> priority wrong for audit in general, because you only get to the
> LSM if the traditional code approves. Every guidance I ever got

true

> said you should do the MAC checks first, because you're much more
> concerned about getting audit records about MAC failures than DAC.
> 

yep, wouldn't that be nice to have

>>>> Should "lsm=" imply implicit enable/disable? (I think no: unlisted
>>>> LSMs are implicitly auto-appended to the explicit list)
>>> If you want to add something that isn't there instead of making
>>> it explicit you want "lsm.enable=" not "lsm=".
>>>
>>>> So then we could have "lsm.enable=..." and "lsm.disable=...".
>>>>
>>>> If builtin list was:
>>>> capability,yama,loadpin,integrity,{selinux,smack,tomoyo,apparmor}
>>>> then:
>>>>
>>>>     lsm.disable=loadpin lsm=smack
>>> Methinks this should be lsm.disable=loadpin lsm.enable=smack
>>>
>> that would only work if order is not important
> 
> It works unless you want to change the order at boot, and
> I still don't see a use case for that.

see above

> 
>>>> becomes
>>>>
>>>>     capability,smack,yama,integrity
>>>>
>>>> and
>>>>
>>>>     CONFIG_SECURITY_LOADPIN_DEFAULT_ENABLED=n
>>>>     selinux.enable=0 lsm.add=loadpin lsm.disable=smack,tomoyo lsm=integrity
>>> Do you mean
>>> 	selinux.enable=0 lsm.enable=loadpin lsm.disable=smack,tomoyo lsm.enable=integrity
>>> 	selinux.enable=0 lsm.enable=loadpin,integrity lsm.disable=smack,tomoyo
>>> 	selinux.enable=0 lsm.enable=loadpin lsm.enable=integrity lsm.disable=smack lsm.disable=tomoyo
>>>
>>>> becomes
>>>>
>>>>     capability,integrity,yama,loadpin,apparmor
>>>>
>>>>
>>>> If "lsm=" _does_ imply enablement, then how does it interact with
>>>> per-LSM disabling? i.e. what does "apparmor.enabled=0
>>>> lsm=yama,apparmor" mean? If it means "turn on apparmor" how do I turn
>>>> on a CONFIG-default-off LSM without specifying all the other LSMs too?
>>> There should either be one option "lsm=", which is an explicit list or
>>> two, "lsm.enable=" and "lsm.disable", which modify the built in default.
>>>
>> maybe but this breaks with current behavior as their is a mismatch between
>> how the major lsms do selection/enablement and the minor ones.
> 
> Which is why you have to continue supporting "security=".
> 
I would argue that switching to lsm= isn't exactly a fix either as we have
the whole minor lsm problem that we are currently debating.

>> I personally would prefer
>>
>>   lsm=
>>
>> but that breaks how the minor lsms are currently enable
> 
> I don't know if I'd say "breaks", but it would require change.
> 
depends how you look at it. Its a change to how its interacted with but so
is switching to lsm=

or making the minor module kconfig automatically add the current minor
lsms to a default lsm selection list, and making $lsm.disable behave
like apparmor or selinux=0.

we got it wrong early on, so now we have to live with something not
as clean as it could have been


>>> In the "lsm=" case "apparmor.enabled=0" should be equivalent to leaving
>>> apparmor off the list, but it's up to the AppArmor code to do that.
>>>> If "lsm.enable=apparmor apparmor.enabled=0" is specified the explict wish
>>> of the security module is used, but it's up to the AppArmor code to do that.
>>>
>> current behavior
> 
> That's right.
> 
>>> If "lsm.disable=apparmor apparmor.enabled=1" is specified the infrastructure
>>> should have shut down AppArmor before it looked to see the "apparmor.enabled=1",
>>> so it will remain disabled.
>>>
>> yep, current behavior
> 
> 2 for 2!
> 
> 
>>> If "lsm.enable=apparmor lsm.disable=apparmor" is specified the last value
>>> specified is used giving "lsm.disable=apparmor".
>>>
>> makes sense
> 
> The rules for modification are pretty obvious. The downside is, as
> you point out, that they don't address ordering. Maybe we address that
> directly:
> 
> 	lsm.order=*,tomoyo
> 
> 		TOMOYO should be last.
> 
> 	lsm.order=apparmor,*
> 
> 		AppArmor should be first.
> 
> 
> 	lsm.order=*,sara,selinux,*
> 
> 		SELinux should come directly after SARA but we otherwise don't care.
> 
> 	lsm.order=smack,*,landlock,*
> 
> 		Smack should be first and LandLock should come sometime later.
> 
> 	lsm.order=*,yama,*
> 
> 		Is meaningless.
> 
> Modules not listed may go anywhere there is a "*" in the order.
> An lsm.order= without a "*" is an error, and ignored.
> If a module is specified in lsm.order but not built in it is ignored.
> If a module is specified but disabled it is ignored.
> The capability module goes first regardless.
> 

I don't mind using lsm.order if we must but really do not like the '*'
idea. It makes this way more complicated than it needs to be

