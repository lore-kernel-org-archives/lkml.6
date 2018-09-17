Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDCE5ECE563
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 15:06:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 862342098A
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 15:06:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="F115Hy4f"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 862342098A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729235AbeIQUeQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 16:34:16 -0400
Received: from sonic305-9.consmr.mail.bf2.yahoo.com ([74.6.133.48]:37673 "EHLO
        sonic305-9.consmr.mail.bf2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728437AbeIQUeQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 16:34:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1537196790; bh=78sNzUDjSTfN/EcroDY5pjw1eLznxtGPJiUJU0lHJ0U=; h=Subject:To:Cc:References:From:Date:In-Reply-To:From:Subject; b=F115Hy4fla6CL4hZiQG/6d1bdsdoXYO+mPdY3sQCDoJGqStw68q32fN+ZZ5qr0FKP66GK6TvceybBXDDZShjw33rQgZzJXM7b4vOgYe6cpKwiK24SKfCzMCJJYfY1TsvP73Yy74edUJXMHcPpdF3TYIN0J6I+PvygMhGwDoavAgBiZbT1eArDlq0fG6gQOBTQaf3bSBlev4iAUd8xtUjYuLgzbamLjlBlyejs20jm7tFmSmzDBqT05GfNzMbCpAwyV6w1meI7KbjEkYyn/oOmy5wE8Q0obiEI01Hwhzoj1In2dX4P7gkgEXZuSYCXIXqqSa4aCgMLZxZRyvfamO2+A==
X-YMail-OSG: 9ohC.7QVM1mcqFGMYT992cjdOrOANpnnobGQYj6WOEK6laesBbY6MuHUjvFeOks
 73js.ON4Emf1O59hivb1EL_iLb5hpr13Zc5316Y4DG5akuCBfCxNR.NnS9GAbQpHboFcg2BVX6SR
 T3V5qti3co7LHIH5Xg5DAgCh.xrgKX3UtPkoDR3Rr0sp4HPwz_eh9OD6HsduwC7_2_.Ar0N4FTyh
 CTnOcgjk1skM_5TKDp64nHx9D96.hUm1rGYr8lthuwBAhYO_Ghh0I0znxjv9VNwa9Ek5bFakrZKE
 rrwnT_oAmukJTnXmEi7nUwOoPHRUHpzdlmi3o._8FP5_JWF1Pz.Cw_xqvv3y.Yv7man5ygdrhzcC
 e6.T7zvgkvIav9L8m2ZAcfUhibYB9TiCqbsF.mMZWyx1Eu_7hmVbJYGyVEcwfF__atF95to3fwMH
 CqNhS1LNLmPnA2DIYL19rmPr9JdeYUSy4Nq5PXdO6DjfnEMnDZK0f0JoFVrYhJKn2USlBmfH60iU
 NzELqo9AmCQ7GtfVI79Zhi9_SZ7DQGAePTOw23RZbvht3PvtxmmUVO9zi95B5WT8P0arvEjSnYSi
 74p.pXYBAPj4IHL8zYYHK_qhda8MHERWenEbu1YLFyZG1PZfCjYd.2PnXBkjVHCpAz7vcsHgxKRu
 vQgRZx_PjBGGNQc3rjW.v0WQB7wfySGdaSkLk5xdzdCBNI.1tP33Ahe_qaJ7bx6GTJiDBrqHhAfq
 3PCZOfC1byWTFeT45GJiJVM0LRHm96Wj9_3AhmIKesJJ4tB6tOORqV_Ah4_hCwOLWmIgMiJJ1gYd
 KU7aPPmz1opvfpc6EeyFvb9VTwQ5Vn6bSTroO2C1E773Gpl9WGSzQd1j92FAn90JXu5tomWCwla8
 Ac1VK2ekMlhvua1zz4vR.iIFdCPPFrs.ecP6_JiaDgHM.lPFDe1eg9vA2iiTKkaTSkWbQZMWRZGy
 JC_Cruo7HHemhLHHFQAS2VmMg9PmegWTx60SjVApb9OroD3ZyTFNkAlv18sgxanuhKSQnedQXnI8
 RYuOCxyBlreVDsAE1vqpBtubk
Received: from sonic.gate.mail.ne1.yahoo.com by sonic305.consmr.mail.bf2.yahoo.com with HTTP; Mon, 17 Sep 2018 15:06:30 +0000
Received: from c-67-169-65-224.hsd1.ca.comcast.net (EHLO [192.168.0.102]) ([67.169.65.224])
          by smtp411.mail.bf1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 0acf1918e7c46743c1a124e5389d8a5e;
          Mon, 17 Sep 2018 15:06:27 +0000 (UTC)
Subject: Re: [PATCH 16/18] LSM: Allow arbitrary LSM ordering
To:     Kees Cook <keescook@chromium.org>
Cc:     James Morris <jmorris@namei.org>,
        John Johansen <john.johansen@canonical.com>,
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
From:   Casey Schaufler <casey@schaufler-ca.com>
Message-ID: <35b0af5b-e37e-e192-73b5-0d0b37d9e37f@schaufler-ca.com>
Date:   Mon, 17 Sep 2018 08:06:23 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <CAGXu5jK5CzXUii97q_yk3KzBTw0SOmoc=-zcm+3jAqEHe76AgQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/16/2018 4:00 PM, Kees Cook wrote:
> On Sun, Sep 16, 2018 at 11:49 AM, Casey Schaufler
> <casey@schaufler-ca.com> wrote:
>> On 9/15/2018 5:30 PM, Kees Cook wrote:
>>> To prepare for having a third type of LSM ("shared blob"), this implements
>>> dynamic handling of LSM ordering. The visible change here is that the
>>> "security=" boot commandline is now a comma-separated ordered list of
>>> all LSMs, not just the single "exclusive" LSM. This means that the
>>> "minor" LSMs can now be disabled at boot time by omitting them from the
>>> commandline. Additionally LSM ordering becomes entirely mutable for LSMs
>>> with LSM_ORDER_MUTABLE ("capability" is not mutable and is always enabled
>>> first).
>> Today if I have Yama enabled and use security=apparmor I get a
>> module list of capability,yama,apparmor. With this change I would
>> get a different result, capability,apparmor. I am personally OK with
>> this, but I think others may see it as a violation of compatibility.
> Correct. That is the problem I had asked about earlier: it means
> people with existing security= for specifying the active major LSM
> will _disable_ all the minor LSMs after this change. It makes me
> uncomfortable.
>
>> One solution is to leave security= as is, not affecting "minor"
>> modules and only allowing specification of one major module, and adding
> I would much prefer this, yes.
>
> A question remains: how do we map the existing "security=" selection
> of a "major" LSM against what will be next "exclusive" plus tomoyo,
> and in the extreme case, nothing?
>
> Perhaps as part of deprecating "security=", we could just declare that
> it is selecting between SELinux, AppArmor, Smack, and Tomoyo only?

I'd be happier keeping yama and loadpin as the special cases. Someone
might want to say security=landlock and expect the existing "minor"
module behavior.

>> another boot option security.stack= that overrides a security= option
>> and that takes the list as you've implemented here.
> or "lsm.stack=" that overrides "security=" entirely?

I thought about that. In some ways that would be most sane.

>> An icky alternative would be to say that any security= specification
>> with no commas in it retains the old behavior. So
>>         security=apparmor
>>         security=apparmor,
>> would get you
>>         capability,yama,apparmor
>>         capability,apparmor
>> respectively.
>>
>> Another option would be to require negation on the minor modules,
>> such as
>>         security=apparmor,-loadpin
>>
>> I can't honestly say which I like least or best.
> The trailing comma thing gets us some compatibility, but we still have
> to decide which things should be exclusive-via-"security=" since with
> blob-sharing it already becomes possible to do selinux + tomoyo.
>
> The -$lsm style may make it hard to sensibly order any unspecified
> LSMs. I guess it could just fall back to "follow builtin ordering of
> unspecified LSMs" (unless someone had, maybe, "-all").

That's why I'm not especially happy with either one.

> so, if builtin ordering after blob-sharing is
> capability,integrity,yama,loadpin,{selinux,apparmor,smack},tomoyo
>
> security=apparmor  is  capability,apparmor,integrity,yama,loadpin,tomoyo

I would expect capability,integrity,yama,loadpin,apparmor to reflect
today's behavior.

> security=yama,smack,-all  is  capability,yama,smack

Yes

> security=loadpin,selinux,yama,-integrity  is
> capability,loadpin,selinux,yama,tomoyo

I think that the negation should only apply to
integrity, yama and loadpin. All blob-using modules
must be explicitly stated if you want to use them.

> Whatever we design, it needs to handle both the blob-sharing
> near-future, and have an eye towards "extreme stacking" in the
> some-day future. In both cases, the idea of a "major" LSM starts to
> get very very hazy.

Long term the only distinction is "minor" and blob using. So long as
there's a way to enforce incompatibility (i.e. not Smack and SELinux)
in the sorter term we can adopt that mindset already.

> As for how we classify things, based on hooks...
>
> now:
>     always: capability
>     major: selinux,apparmor,smack,tomoyo
>     minor: yama,loadpin
>     init-only: integrity
>
> blob-sharing:
>     always: capability
>     exclusive: selinux,apparmor,smack
>     sharing: tomoyo,integrity,yama,loadpin
>
> extreme:
>     always: capability
>     sharing: selinux,apparmor,smack,tomoyo,integrity,yama,loadpin
>
> The most special are capability (unconditional, run first) and
> integrity (init-only, no security_add_hooks() call).
>
> Can we classify things as MAC and non-MAC for "major" vs "minor"? SARA
> and Landlock aren't MAC (and neither is integrity), or should we do
> the "-$lsm" thing instead?

I don't like using MAC because the use of the module isn't the issue,
it's the interfaces used. As ugly as it is, I like the -$lsm better.

>
> -Kees
>

