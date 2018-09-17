Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 812ABECE560
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 21:58:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ECD742088F
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 21:58:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="oYPFVVId"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ECD742088F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728611AbeIRD1S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 23:27:18 -0400
Received: from sonic306-10.consmr.mail.bf2.yahoo.com ([74.6.132.49]:43920 "EHLO
        sonic306-10.consmr.mail.bf2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728460AbeIRD1S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 23:27:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1537221483; bh=XoAp+Np7qcRhrmJ16ghHkHbUTCV2niLFW+wFAMcI7HM=; h=Subject:To:Cc:References:From:Date:In-Reply-To:From:Subject; b=oYPFVVIdT5lqmOHcUvaa5GKcSi3cljy+4ddt7KAJsKOsur4PODP8LBeNXQBFMqQcAsOIVUlCtM+wNeyWb2NZIMX/a+8Bjezlv1/tydn/GZvqd6UeBgYdgBJDf8p+DpOrSMUYy7I7Az/a0qDHXJilpNUSvA7dJRaSqkjH0E3v5qtSaTAxVB1b2ELXjKdTU5FkPI+Pl+T6r0Znl05SKHKFlcFx8GPg9MLMYbasNojt10E9ouAd58wFhy/uDW91fXNQlOdM89M+xUAB5WDwfJ77xZ7IMDRznfyxQtnf/KzYEBsbNa9d0S85F39V96NMF7vCOgwNJb1UJm07WuZ4FQmE5g==
X-YMail-OSG: BIO72EYVM1lGXk9nF8gh9MjZB2spyC3MRl8QvRM8xlHucb2GAEwPX4SFc4YxKk_
 dOfB_BvHboKWrW9VZWjERVp44vrUlfj62A_1Z2c5yg2Nv19qPokvY1r5fGvcz1s6xiVKl7Lr.mi.
 Flt4Wer0gfoGpbXwK6nC87hzS.kkpSy8NLHDp.kSOyfXKIHCY_SisDsxaONZKizM7Y8Q37IJnMex
 1dFAhFB6P3Xn4RRLW12gqN7gZtKZmdh2NRSpHE43._PSFN0eGacrGSx6BnWu7d6VTQS2yVnJskkK
 JyywlGAecUqqhv_X.RlrtqUvMFqMgyQdXRKQ39mLPEkTAWczXeRhPdH9oDRlZZE72OPBY1zCboY2
 1OlbGJ_mPRPeFSUJ82fHZ5D9KV8JPeMxf69v661O2Hmg3uPpqSQD5_7ebWumDbIiwW7OaGg709GE
 aVu5ixHX04OGMgj5l.ecd2ORWePCEXX_Mjc7dU12uO0pbMzUA7_9oiTaxh0KaDc0YMdwF3TbOtTp
 RrCcOhbV9PKbMJrCUMEk_n3rIY1XcuVzKbFa4tx1JDf5yNWuMU3DtmRFpYLhnP4dGYhTTTF7Ts.5
 .AkjMJChCH2GsAoWJGznZ7G8t88bfMMLjqwwZEbAZ1gyCr.MVl4p1P8AoTlBhCO9Y1TwTjCeDNQe
 wB9d1oEhRJNnMLlom8sMr3P.I0PeMMTkqEC453C6K.67HmOW_UROy4DfF.2_h1Wbhlph9B.eBJyA
 wGJoKn0.xv2_i_2enjqVY2B_mP4kZ9yTbilT3NdWKPnBXi0iAHfIYE_Gedm1in_IBN.nEpHZml7R
 sE8USWQ4dRvtc_2goGnfustJ8cKrBUMV5V7k_Z0i.qLKf7S5vqKPwPLNbafSseLfICifDgJSa_gL
 AGIfhyAcuYLDhsRPfmJvonl3_ra9cKDamCRZDCdOJL_R.p.XpsdqeAXJfFeeSvv4lfLEO22dZCsP
 fndyJwIK48.TiSa8UCh3fMAqi7_SUzIfyiCRXj_v788c_XG_a6svP8ZlmpCbqhfuEk.ceP7Y8BBV
 vAGSM0LxbQIYod3h1
Received: from sonic.gate.mail.ne1.yahoo.com by sonic306.consmr.mail.bf2.yahoo.com with HTTP; Mon, 17 Sep 2018 21:58:03 +0000
Received: from c-67-169-65-224.hsd1.ca.comcast.net (EHLO [192.168.0.102]) ([67.169.65.224])
          by smtp406.mail.bf1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID d3acf020ebd287ac9d60d8975d2c0073;
          Mon, 17 Sep 2018 21:58:03 +0000 (UTC)
Subject: Re: [PATCH 16/18] LSM: Allow arbitrary LSM ordering
To:     John Johansen <john.johansen@canonical.com>,
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
From:   Casey Schaufler <casey@schaufler-ca.com>
Message-ID: <fbdc2a75-8364-c743-f9c3-9dcd2570c569@schaufler-ca.com>
Date:   Mon, 17 Sep 2018 14:57:58 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <7ecfffc3-d2a4-3ff7-4bf5-db3029d73c59@canonical.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/17/2018 12:55 PM, John Johansen wrote:
> On 09/17/2018 12:23 PM, Casey Schaufler wrote:
>> On 9/17/2018 11:14 AM, Kees Cook wrote:
>>>> Keep security=$lsm with the existing exclusive behavior.
>>>> Add lsm=$lsm1,...,$lsmN which requires a full list of modules
>>>>
>>>> If you want to be fancy (I don't!) you could add
>>>>
>>>> lsm.add=$lsm1,...,$lsmN which adds the modules to the stack
>>>> lsm.delete=$lsm1,...,$lsmN which deletes modules from the stack
>>> We've got two issues: ordering and enablement. It's been strongly
>>> suggested that we should move away from per-LSM enable/disable flags
>>> (to which I agree).
>> I also agree. There are way too many ways to turn off some LSMs.
>>
> I wont disagree, but its largely because we didn't have this discussion
> when we should have.

True that.


>>> If ordering should be separate from enablement (to
>>> avoid the "booted kernel with new LSM built in, but my lsm="..." line
>>> didn't include it so it's disabled case), then I think we need to
>>> split the logic (otherwise we just reinvented "security=" with similar
>>> problems).
>> We could reduce the problem by declaring that LSM ordering is
>> not something you can specify on the boot line. I can see value
>> in specifying it when you build the kernel, but your circumstances
>> would have to be pretty strange to change it at boot time.
>>
> if there is LSM ordering the getting
>
>   lsm=B,A,C
>
> is not the behavior I would expect from specifying
>
>   lsm=A,B,C

Right. You'd expect that they'd be used in the order specified.

>>> Should "lsm=" allow arbitrary ordering? (I think yes.)
>> I say no. Assume you can specify it at build time. When would
>> you want to change the order? Why would you?
>>
> because maybe you care about the denial message from one LSM more than
> you do from another. Since stacking is bail on first fail the order
> could be important from an auditing POV

I understand that a distribution would want to specify the order
for support purposes and that a developer would want to specify
the order to ensure reproducible behavior. But they are going to
be controlling their kernel builds. I'm not suggesting that the
order shouldn't be capable of build time specification. What I
don't see is a reason to rearrange it at boot time.

> Auditing is why apparmor's internal stacking is not bail on first
> fail.

Within a security module I get that. But we've already got the
priority wrong for audit in general, because you only get to the
LSM if the traditional code approves. Every guidance I ever got
said you should do the MAC checks first, because you're much more
concerned about getting audit records about MAC failures than DAC.

>>> Should "lsm=" imply implicit enable/disable? (I think no: unlisted
>>> LSMs are implicitly auto-appended to the explicit list)
>> If you want to add something that isn't there instead of making
>> it explicit you want "lsm.enable=" not "lsm=".
>>
>>> So then we could have "lsm.enable=..." and "lsm.disable=...".
>>>
>>> If builtin list was:
>>> capability,yama,loadpin,integrity,{selinux,smack,tomoyo,apparmor}
>>> then:
>>>
>>>     lsm.disable=loadpin lsm=smack
>> Methinks this should be lsm.disable=loadpin lsm.enable=smack
>>
> that would only work if order is not important

It works unless you want to change the order at boot, and
I still don't see a use case for that.

>>> becomes
>>>
>>>     capability,smack,yama,integrity
>>>
>>> and
>>>
>>>     CONFIG_SECURITY_LOADPIN_DEFAULT_ENABLED=n
>>>     selinux.enable=0 lsm.add=loadpin lsm.disable=smack,tomoyo lsm=integrity
>> Do you mean
>> 	selinux.enable=0 lsm.enable=loadpin lsm.disable=smack,tomoyo lsm.enable=integrity
>> 	selinux.enable=0 lsm.enable=loadpin,integrity lsm.disable=smack,tomoyo
>> 	selinux.enable=0 lsm.enable=loadpin lsm.enable=integrity lsm.disable=smack lsm.disable=tomoyo
>>
>>> becomes
>>>
>>>     capability,integrity,yama,loadpin,apparmor
>>>
>>>
>>> If "lsm=" _does_ imply enablement, then how does it interact with
>>> per-LSM disabling? i.e. what does "apparmor.enabled=0
>>> lsm=yama,apparmor" mean? If it means "turn on apparmor" how do I turn
>>> on a CONFIG-default-off LSM without specifying all the other LSMs too?
>> There should either be one option "lsm=", which is an explicit list or
>> two, "lsm.enable=" and "lsm.disable", which modify the built in default.
>>
> maybe but this breaks with current behavior as their is a mismatch between
> how the major lsms do selection/enablement and the minor ones.

Which is why you have to continue supporting "security=".

> I personally would prefer
>
>   lsm=
>
> but that breaks how the minor lsms are currently enable

I don't know if I'd say "breaks", but it would require change.

>> In the "lsm=" case "apparmor.enabled=0" should be equivalent to leaving
>> apparmor off the list, but it's up to the AppArmor code to do that.
>>> If "lsm.enable=apparmor apparmor.enabled=0" is specified the explict wish
>> of the security module is used, but it's up to the AppArmor code to do that.
>>
> current behavior

That's right.

>> If "lsm.disable=apparmor apparmor.enabled=1" is specified the infrastructure
>> should have shut down AppArmor before it looked to see the "apparmor.enabled=1",
>> so it will remain disabled.
>>
> yep, current behavior

2 for 2!


>> If "lsm.enable=apparmor lsm.disable=apparmor" is specified the last value
>> specified is used giving "lsm.disable=apparmor".
>>
> makes sense

The rules for modification are pretty obvious. The downside is, as
you point out, that they don't address ordering. Maybe we address that
directly:

	lsm.order=*,tomoyo

		TOMOYO should be last.

	lsm.order=apparmor,*

		AppArmor should be first.


	lsm.order=*,sara,selinux,*

		SELinux should come directly after SARA but we otherwise don't care.

	lsm.order=smack,*,landlock,*

		Smack should be first and LandLock should come sometime later.

	lsm.order=*,yama,*

		Is meaningless.

Modules not listed may go anywhere there is a "*" in the order.
An lsm.order= without a "*" is an error, and ignored.
If a module is specified in lsm.order but not built in it is ignored.
If a module is specified but disabled it is ignored.
The capability module goes first regardless.

