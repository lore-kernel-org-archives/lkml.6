Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38186ECE563
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 19:23:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD760214DA
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 19:23:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="M/geCUnN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DD760214DA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728461AbeIRAwQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 20:52:16 -0400
Received: from sonic305-9.consmr.mail.bf2.yahoo.com ([74.6.133.48]:36951 "EHLO
        sonic305-9.consmr.mail.bf2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727176AbeIRAwQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 20:52:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1537212212; bh=+sXvozdIY8zCZwQR8dgN1ChzxpGArhlhwBgVBV6bGbg=; h=Subject:To:Cc:References:From:Date:In-Reply-To:From:Subject; b=M/geCUnNi5k4iklFVD4jb6VeGFvPCuAdEIfIOWh4Jzjg6DcJAXWZ4Nb9bJJ/9VTDOODt8wIgIg3EoUfthJ9jVniCAuuahsVC9A0agGZpVvMMn/AnIOhLBkd86rvPkQD0kUjcNtXumcGULxAewzNzp62Hqymbt/Sta9gF9gGUV9lGfRsgL1P3s1J92QTlXlHFs3S+I1gN3KhDmoGeFbsmvMd+rYcwmp60IxSvdxQOE94iFReobarPoHjx27BTHnl0FN1w3ww6UyIEO55/el54nVZUYxcKKK2BiEq9VbYMgdYxAfoFV69GP/LUZYRnGXx6uSwmEohUvqsNA683PINxIg==
X-YMail-OSG: d1GIaRwVM1l3rOnnvGx4QsPV.4S6FjVliBFJvuwxTfNFAwSmkuuTnAnzHkzLi5s
 TU_ObNAoG3GPIk1VdwL.UQO5DqeRIOW4GpmYQ7QnGIUGODQLZEQDGRGDkxyxyuMbAM0sTovvA345
 Nd1Auulum_OP0mj6_v7sNd0W.n2NTuxJNkARLkiFNiLLNFO0BPQi.7sN9whCweDawmWrRy.knGPI
 x4fvenbQG97RBwp8qpe4yYa0uiHhbpn9zKztPWrckXDaPKJc9PNirlPJPMqrIvCdXntHwzWaQlUF
 BAGXfqdnacr3Ki8gI.CH4HJaP6uRHeTppXJ0SLXnu6PhVyenj_8V4kxUuKxNlLwDjulw6deTloeK
 zFUjrDOLNCjZ._ZeVlUY.5vUops27lUvzQqkSH5v4468ltT1k6_rXBooATzCbPsG_q7ucAy6TzQT
 OKhNElXJIbkMfwu9r5eDsV_3tdxq1GOCxeK4nNqPhvLFe3yAKPELJ0GD8CJr9XDnq1mCgeRb1q4A
 EuUUTcrYLg4zgpmsUseU8kP2NoXo5uIwpD0x5ORdaQsuyX98842Sc_C7nDD2RoDedQSiGWKSj4KU
 js5gldUk81n9rPNw5odrwgbgTPcUWeVQXNdYjSTfocJ7c1OoXYnnUAwjVrNzFANE730y8jZPtEOj
 sBtWILoTRRZKP6VRgysGMv_DuJ8.JV0dke7sg.wsBmzZY0hNhOcruNwpxGDolPiUOhhSmMeppsWn
 FvabdUVSF10U5pDJi0QxXwGLZCnTQ3OAGrhGDjg_LKGhC45HulPJglN0R3Jqs90FLlJZ5sLncRS9
 3ewEs3o3D4OCicQ09LY5gmxpyMNau4UhY0DLTTyxu_US25L8RELNuPIud8wuLo.AXgwdSKWeV05v
 U6ek2w_aS3JwPP.q2ia2xARA_2aG6yvoi3Ro8gnlnIVINei4LutQ0juXflj4xQcjTd8AvUffbsHe
 lGf4B3wQ4baloDpbPpv5w5Zfe2HlSIHiNWE4DA.UiDdOH3xHh1y6pPnLiu_FATwnGgNfFSRClv6_
 4i76Gr3Q-
Received: from sonic.gate.mail.ne1.yahoo.com by sonic305.consmr.mail.bf2.yahoo.com with HTTP; Mon, 17 Sep 2018 19:23:32 +0000
Received: from c-67-169-65-224.hsd1.ca.comcast.net (EHLO [192.168.0.102]) ([67.169.65.224])
          by smtp413.mail.bf1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 967627353be920d439f0e7ab48b98d12;
          Mon, 17 Sep 2018 19:23:29 +0000 (UTC)
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
 <35b0af5b-e37e-e192-73b5-0d0b37d9e37f@schaufler-ca.com>
 <CAGXu5jJ71RLGh0nDgOaN3vCXFGE0poXFU2Gb9o+20aO+AEdOvw@mail.gmail.com>
 <8f0bd39b-29a6-325d-4558-d9f484249c22@schaufler-ca.com>
 <CAGXu5jLeTfwEXAZLz_H1PCx0ySWZcRhXQMfnE14TG8BvxY46JA@mail.gmail.com>
From:   Casey Schaufler <casey@schaufler-ca.com>
Message-ID: <53377892-695f-6336-8574-54c7aa0a4201@schaufler-ca.com>
Date:   Mon, 17 Sep 2018 12:23:26 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <CAGXu5jLeTfwEXAZLz_H1PCx0ySWZcRhXQMfnE14TG8BvxY46JA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/17/2018 11:14 AM, Kees Cook wrote:
>
>> Keep security=$lsm with the existing exclusive behavior.
>> Add lsm=$lsm1,...,$lsmN which requires a full list of modules
>>
>> If you want to be fancy (I don't!) you could add
>>
>> lsm.add=$lsm1,...,$lsmN which adds the modules to the stack
>> lsm.delete=$lsm1,...,$lsmN which deletes modules from the stack
> We've got two issues: ordering and enablement. It's been strongly
> suggested that we should move away from per-LSM enable/disable flags
> (to which I agree).

I also agree. There are way too many ways to turn off some LSMs.

> If ordering should be separate from enablement (to
> avoid the "booted kernel with new LSM built in, but my lsm="..." line
> didn't include it so it's disabled case), then I think we need to
> split the logic (otherwise we just reinvented "security=" with similar
> problems).

We could reduce the problem by declaring that LSM ordering is
not something you can specify on the boot line. I can see value
in specifying it when you build the kernel, but your circumstances
would have to be pretty strange to change it at boot time.

> Should "lsm=" allow arbitrary ordering? (I think yes.)

I say no. Assume you can specify it at build time. When would
you want to change the order? Why would you?

> Should "lsm=" imply implicit enable/disable? (I think no: unlisted
> LSMs are implicitly auto-appended to the explicit list)

If you want to add something that isn't there instead of making
it explicit you want "lsm.enable=" not "lsm=".

> So then we could have "lsm.enable=..." and "lsm.disable=...".
>
> If builtin list was:
> capability,yama,loadpin,integrity,{selinux,smack,tomoyo,apparmor}
> then:
>
>     lsm.disable=loadpin lsm=smack

Methinks this should be lsm.disable=loadpin lsm.enable=smack

> becomes
>
>     capability,smack,yama,integrity
>
> and
>
>     CONFIG_SECURITY_LOADPIN_DEFAULT_ENABLED=n
>     selinux.enable=0 lsm.add=loadpin lsm.disable=smack,tomoyo lsm=integrity

Do you mean
	selinux.enable=0 lsm.enable=loadpin lsm.disable=smack,tomoyo lsm.enable=integrity
	selinux.enable=0 lsm.enable=loadpin,integrity lsm.disable=smack,tomoyo
	selinux.enable=0 lsm.enable=loadpin lsm.enable=integrity lsm.disable=smack lsm.disable=tomoyo

> becomes
>
>     capability,integrity,yama,loadpin,apparmor
>
>
> If "lsm=" _does_ imply enablement, then how does it interact with
> per-LSM disabling? i.e. what does "apparmor.enabled=0
> lsm=yama,apparmor" mean? If it means "turn on apparmor" how do I turn
> on a CONFIG-default-off LSM without specifying all the other LSMs too?

There should either be one option "lsm=", which is an explicit list or
two, "lsm.enable=" and "lsm.disable", which modify the built in default.

In the "lsm=" case "apparmor.enabled=0" should be equivalent to leaving
apparmor off the list, but it's up to the AppArmor code to do that.

If "lsm.enable=apparmor apparmor.enabled=0" is specified the explict wish
of the security module is used, but it's up to the AppArmor code to do that.

If "lsm.disable=apparmor apparmor.enabled=1" is specified the infrastructure
should have shut down AppArmor before it looked to see the "apparmor.enabled=1",
so it will remain disabled.

If "lsm.enable=apparmor lsm.disable=apparmor" is specified the last value
specified is used giving "lsm.disable=apparmor".

