Return-Path: <SRS0=lWsm=I7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id B08F1C433EF
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 21:15:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 44D8A208DA
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 21:15:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="tp9diYY3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 44D8A208DA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754578AbeFMVO5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Jun 2018 17:14:57 -0400
Received: from sonic313-20.consmr.mail.bf2.yahoo.com ([74.6.133.194]:33366
        "EHLO sonic313-20.consmr.mail.bf2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1754528AbeFMVOy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jun 2018 17:14:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1528924493; bh=Ppx/Oh5cKvQIb+4lmB1ZytFj6f2gZI6hRhO4bNQo2u0=; h=Subject:To:Cc:References:From:Date:In-Reply-To:From:Subject; b=tp9diYY3zbXbbFcFgip1G+e8Dx2XWCArkjmM3OHu+EiK2vaf1zMxbmPpawQljqYMH67SuyBZRo9t5DHhaNBQdJZIqTPKLEYtCqd4Ty7TpTxwFUAeWxE/TzT8AVSBP0j1OKD+i0CBuW9B+dljq0LnGoyaQwAmglBPRCJ3i717UkP4PZyb2ToTCcvQ7qeGouB2jrDrYjOAllIri7qI3p7bCuCHiqn6zdiQL5GubSEmfRA4I5lzlWJNm+xjgV4ajjAJLTs8KN5IeE5A95tlWN3X4iGJKAZtaCnLj4g7bKpeX7SNlHIgJ2jb63F7gukXXAFNFK23WXEMiD6VAv8i1W9gJA==
X-YMail-OSG: IivEgQEVM1kJZSd.5PiOIYzpTMXsvAWqkICjNjn2NMU4uk6Z5BL5kB31qu3Zwo5
 zLVC6tfEnsTp0M3e0A2wbs4Rf0wdzII4z85TFAloypFRWnz904D0KDX0oGN9fU55iN_V9pYAz5hY
 _4XtlMnU_4.gVD26VTsSTECMZKFiOyU2r76vWKiy2CPonv.nIQ80spfKUKmLnkQP8KJie43AH_qs
 .5iJPBLE52RhPCmf8uArWL.AUr.njdLqVaC4F5coiDl8tw8pm2Ss8ympl3WO.MzwKvTRR4RBqpld
 ZeIhzmlFM4rqZVv2xhqwjECFdJ4gtr0khRhRPwnMdPANGasYfwiNh5iSAQTPUqfg90HPC1Wn68aX
 .2dokZny7EJ4AbPqOuziEUSmvA6iKhYASa8j0CsouA.0xGyqWwXt3VyWuuEBLP6s8IkffEYVMnyY
 _1wg9LnnnLHLRmv8ncCvXNfinYdKdHvAJLEC6qX02X_5DIo49qzWnotiPoEYnCLrhbLOjW3jtqlX
 2UKayMvjx5cVQqcW4ANz55yMJjSV2vJtC1jm0N76g.37s0Jc0Ewr.Hvjr8oFWD.BUvifd2PhPuKh
 _up4TT5Ob6tsTqaP2y8nVXzo9feLeOSOeAMDUu1ua5aoxo8RDqULwZQVyPPo0Zqxl0AwfoZ0CNfa
 Co2oRpQP5IBWICeElOfFsezpKO7QfOcVEAlIvoVtJzEZuNh4Kp4c54kd3DxA18KzJ5yjGJ_zYzuU
 zaESbbFgHPBpWl2hFrCZQ0xlW7Fw2a5f0LfSHettqQvA0gJ1cnL48IG4naWmY.8r1aL71wZqQdAw
 siTA8GHKX5OKNxYLY..F_qhS4m8Tt_y2HeteTePJ4SK2F689WJCPH4vQZ60N9rG981FDgQGnY.Fi
 XnMx3RGTId3xtju61AetUWqwn_TibFxakg7liX.Wkvrwh6SpQNZ8qMYiTeAtZF2kadR52Z_NvikW
 PWwR1HdJHgrNisCkvkDNimVF4RvC97e1dVw--
Received: from sonic.gate.mail.ne1.yahoo.com by sonic313.consmr.mail.bf2.yahoo.com with HTTP; Wed, 13 Jun 2018 21:14:53 +0000
Received: from c-67-169-65-224.hsd1.ca.comcast.net (EHLO [192.168.0.105]) ([67.169.65.224])
          by smtp411.mail.bf1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 19c257903c3d9455624194e7d677b4f8;
          Wed, 13 Jun 2018 21:14:53 +0000 (UTC)
Subject: Re: [-next PATCH] security: use octal not symbolic permissions
To:     Paul Moore <paul@paul-moore.com>, Joe Perches <joe@perches.com>
Cc:     James Morris <jmorris@namei.org>,
        John Johansen <john.johansen@canonical.com>,
        Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        Eric Paris <eparis@parisplace.org>,
        Kentaro Takeda <takedakn@nttdata.co.jp>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org,
        selinux@tycho.nsa.gov
References: <1e91f8e10ce76d3208239b6b5899aab76d1543ff.1528743633.git.joe@perches.com>
 <fcac609a-08a8-b3ab-a69e-2e65e2ad63e9@schaufler-ca.com>
 <alpine.LRH.2.21.1806130631400.13763@namei.org>
 <CAHC9VhTpsYDT5+CjdtiBmLMDEKV9fmGv+DyXVtUuja9d4i2ecg@mail.gmail.com>
 <3d890108a942b6a3fb9a5326501174af270707dc.camel@perches.com>
 <CAHC9VhRHd+nxKQRj5PjoN7Te3NjomtWcb_0ZxzcxAzwX024m9A@mail.gmail.com>
 <00961ef3fb41930a3304da935f1f73ebe386e83c.camel@perches.com>
 <CAHC9VhRXBx_Q2eM48FFqX9PbPz0k8R74gfFFoRhwV91n2_BPsQ@mail.gmail.com>
 <38670733fba157f7acd9c1555b44a296420f0774.camel@perches.com>
 <CAHC9VhRX7Vx9_FB69EgxLypo1SnA9bobtxeLn8KzuHEN8CSaNA@mail.gmail.com>
From:   Casey Schaufler <casey@schaufler-ca.com>
Message-ID: <1adae238-44cc-83f5-538a-1b9c12916875@schaufler-ca.com>
Date:   Wed, 13 Jun 2018 14:14:44 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <CAHC9VhRX7Vx9_FB69EgxLypo1SnA9bobtxeLn8KzuHEN8CSaNA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/13/2018 12:57 PM, Paul Moore wrote:
> On Wed, Jun 13, 2018 at 3:30 PM, Joe Perches <joe@perches.com> wrote:
>> On Wed, 2018-06-13 at 12:19 -0400, Paul Moore wrote:
>>> On Wed, Jun 13, 2018 at 12:04 PM, Joe Perches <joe@perches.com> wrote:
>>>> On Wed, 2018-06-13 at 11:49 -0400, Paul Moore wrote:
>>>>> On Tue, Jun 12, 2018 at 8:29 PM, Joe Perches <joe@perches.com> wrote:
>>>>>> On Tue, 2018-06-12 at 17:12 -0400, Paul Moore wrote:
>>>>>>> Joe, in general I really appreciate the fixes you send, but these
>>>>>>> patches that cross a lot of subsystem boundaries (this isn't the first
>>>>>>> one that does this) causes unnecessary conflicts in -next and during
>>>>>>> the merge window.  Could you split your patches up from now on please?
>>>>>> Sorry. No.  Merge conflicts are inherent in this system.
>>>>> Yes, merge conflicts are inherent in this system when one makes a
>>>>> single change which impacts multiple subsystems, e.g. changing a core
>>>>> kernel function which is called by multiple subsystems.  However, that
>>>>> isn't what this patch does, it makes a number of self-contained
>>>>> changes across multiple subsystems; there are no cross-subsystem
>>>>> dependencies in this patch.  You are increasing the likelihood of
>>>>> conflicts for no good reason; that is why I'm asking you to split this
>>>>> patch and others like it.
>>>> No.  History shows with high certainty that splitting
>>>> patches like this across multiple subsystems of a primary
>>>> subsystem means that the entire patchset is not completely
>>>> applied.
>>> I think that is due more to a lack of effort on the part of the patch
>>> author to keep pushing the individual patches.
>> Nope.  Try again.
>>
>> Resistance to change and desire for status quo
>> occurs in many subsystems.
> Which gets back to the need for persistence on the part of the patch
> author.  If your solution to a stubborn susbsystem is to go around
> them by convincing another, potentially unrelated subsystem, to merge
> the patch then I firmly believe you are doing it wrong.
>
>>>> It's _much_ simpler and provides a generic mechanism to
>>>> get the entire patch applied to send a single patch to the
>>>> top level subsystem maintainer.
>>> I understand it is simpler for you, but it is more difficult for everyone else.
>> Not true.
> I think we are at the agree to disagree stage.
>
> The way you have structured this patch it makes it easier for you to
> submit, but makes it potentially more difficult for me (likely other
> LSM maintainers too), the -next folks, and Linus.

I am agreeing with Paul. There is no reason that I/he should
be compelled to accept the Smack/SELinux patches because he/I
accepted the SELinux/Smack bits.

>
>> It's simply a matter of merge resolution being pushed down
>> where and when necessary.
>>
>> See changes like the additions of the SPDX license tags.
> Please don't even try to suggest that this trivial patch you are
> proposing is even remotely as significant as the SPDX change.  There
> are always going to be exceptions to every rule, and with each
> exception there needs to be a solid reason behind the change.  The
> SPDX change had a legitimate reason (legal concern) for doing it the
> way it was done; this patch isn't close to that level of concern.
>
>>> Further, where the LSMs are concerned, there is no "top level
>>> subsystem maintainer" anymore.  SELinux and AppArmor send pull
>>> requests directly to Linus.
>> MAINTAINERS-SECURITY SUBSYSTEM
>> MAINTAINERS-M:  James Morris <jmorris@namei.org>
>> MAINTAINERS-M:  "Serge E. Hallyn" <serge@hallyn.com>
>> MAINTAINERS-L:  linux-security-module@vger.kernel.org (suggested Cc:)
>> MAINTAINERS-T:  git git://git.kernel.org/pub/scm/linux/kernel/git/jmorris/linux-security.git
>> MAINTAINERS-W:  http://kernsec.org/
>> MAINTAINERS-S:  Supported
>> MAINTAINERS:F:  security/
>> MAINTAINERS-
>>
>> If James is not approving or merging security/selinux or
>> security/tomoyo then perhaps the F: entries could be
>> augmented with appropriate X: entries or made specific
>> by using specific entries like:
>>
>> F:      security/*
>> F:      security/integrity/
>> F:      security/keys/

There are already F: entries for security/selinux, security/smack
and security/apparmor so I don't get your point.

> That is a good point.  I'll put together a patch for selinux/next as
> soon as the merge window closes.  I'll let the other LSMs do as they
> see fit.  As I said previously, I believe the only other LSM that
> sends directly to Linux is AppArmor.

Smack will continue using the security subsystem so long as
James offers the service. There's overhead in setting up the
environment for sending directly to Linus that I'm in no rush
to incur.

