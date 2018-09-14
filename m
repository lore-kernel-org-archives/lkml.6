Return-Path: <SRS0=Jh2l=L4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	GAPPY_SUBJECT,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB3BDECE560
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 20:48:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 829CF2083A
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 20:48:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="WbixYg5x"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 829CF2083A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728183AbeIOCEN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Sep 2018 22:04:13 -0400
Received: from sonic305-10.consmr.mail.bf2.yahoo.com ([74.6.133.49]:34882 "EHLO
        sonic305-10.consmr.mail.bf2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727745AbeIOCEL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Sep 2018 22:04:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1536958082; bh=2uVeTV5Ex1ksHGlBVF0sXXy3gManY/sEHQgGZdBAnSQ=; h=Subject:To:Cc:References:From:Date:In-Reply-To:From:Subject; b=WbixYg5xKemFlquPZHv1GAcCx5izsGn0acE7DvrwUXF0XCm5098zvTJ+l+MeqSX53vcVCf965QTfDcdnTbQ7EOtTZvD6a3AK1i9ZJDFQyqkBvaqRfj+G4e1wHI7z/Exa5ydpD7PxN6cpN3djnulT7xe7cVe96XR2AdCQT2FPO6jfd2Jx33kHpE8ugsIVFIQAh5l5MtygVyguCtEWd3hW/T+EIGJvSU7exnbmhr6N3mAHPKFPctgpidVGw7dfKf2tygs/X+8VqDz2AKJholElCI97IwqaV/ENwfS3mWU0PCkJ4/ihyqnHZarsfx95lBgpWagys22/Xu7BbJDyoQW0Fg==
X-YMail-OSG: lIx6fI4VM1lEiaM9.5UGaOnyskJ.oa3lUQNxzNEb8ycCdNcVHM4crZrCiT9DFhy
 hsgA5VWONGRP_yW0b4FXyppEcTCLyXJRQAHV0ivS.IhJctUHZPxQakIjXM0hsIe_005.qyOLsWKZ
 D6Cfizj23iUv.bjMnKlO8HzMXhZ89pW6vsUqYdOPjqxdTg0g4jYY7qEVQn1kcHMrbYhhEjQr3XDy
 PBCnpOLCCc1XEcsiKNb9_jeqjacAOdhkHKsLN1SD.DfB5qG31JA9h7U_vn2L5bmOPH7JRtf5dr6Q
 Rr5ZGGC7LZuAthGN5gBKMJ4h7sJtTJJHV3D2luzpRbFS6xDpJfChqEOK0USUSx32sCtg__OqHTrD
 KhUxakBBWDEUHAbEXeuevR0_zQEomrFOHILFSwi8CNyN6dNppuUoGEHFJpgDYF80RHtPskNxhZ80
 DUDC3ej5XDYiWv72ODQGmEyg0cKXL9V3cLHSqa7LV2CDcram..plsVNM4BG_8K9IqklcNWLIBmVX
 5kUBm6WC188v4EVor8W0X7h1TOvhIK7ungD9Of4SzMdxivZl7z0f3iHBNLhfVjZaTfqgxiz6Qemn
 WQlIlRRKNmVPKrsgN4rye.0RLm7Glc6K3b0Za7oWtnEEeZgfJGNr46EpEDcX7FtQJSGrWRHiumET
 HDoQPY9MRJsFboscjbsAdJFVo_jv95l6Upicqqf08cly5.IwiQixTzY3ogucHVDsRs3ipj0hsiL7
 BDN0wEaIzzYesMOzh7RwNqeqN3mFKjVwz.m.IUXCORHAgIi_y.gWnRCx00B0qEzrqhS6visCZ5R_
 cetIbwNnEZ_7Jxy6.BYYu_gQMF0Kbnufdup95U2DduNqB_ECyAFxEZ.41FbzC7gJxuS3l89QXYSN
 TvIHZofbvkjn_ueTBld0aBKmvv_rT5HwedLch1XRfUeBI1FEo8WtmezKxGo_.MG3gVhzB32OAx4P
 z9innDm3QAdtkNAPillemP2SsUlFJgFR7Kcn..VKN93x_gH2uGSIwyedC9Cob55.eMdkjS_kHHP8
 2cXDnPhlaZn89g3mG4VASlEusHgNccD8-
Received: from sonic.gate.mail.ne1.yahoo.com by sonic305.consmr.mail.bf2.yahoo.com with HTTP; Fri, 14 Sep 2018 20:48:02 +0000
Received: from c-67-169-65-224.hsd1.ca.comcast.net (EHLO [192.168.0.102]) ([67.169.65.224])
          by smtp426.mail.bf1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 680dcabb72fd6524d94ab1481012a204;
          Fri, 14 Sep 2018 20:47:59 +0000 (UTC)
Subject: Re: [PATCH 10/10] LSM: Blob sharing support for S.A.R.A and LandLock
To:     Kees Cook <keescook@chromium.org>
Cc:     Paul Moore <paul@paul-moore.com>,
        linux-security-module <linux-security-module@vger.kernel.org>,
        James Morris <jmorris@namei.org>,
        LKML <linux-kernel@vger.kernel.org>,
        SE Linux <selinux@tycho.nsa.gov>,
        John Johansen <john.johansen@canonical.com>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        "Schaufler, Casey" <casey.schaufler@intel.com>
References: <cbf848ae-a1ac-c5ab-f23b-bc9217fceebe@schaufler-ca.com>
 <CAGXu5jLONSfPHYYYTLSma-+arVHSQKaEWb9JxpOn6TNKtyLNhw@mail.gmail.com>
 <CAHC9VhQN0wq0zZS5BYU9jBomaWvCaJ_BqJjHF3AT7FG8Z0nLDQ@mail.gmail.com>
 <CAGXu5jJs6kmd6Tjgwqb2Zx7e-jNbHqfJ57poZuyz4Qj=AKVfmQ@mail.gmail.com>
 <CAHC9VhQ20tBAMwOJ9mg0tBHYUoxjh0Szr3d62HuPw2SyT4XDLw@mail.gmail.com>
 <CAGXu5jKec1JTsoqwKGThcJoamdL618AHu4jfFbqqQiauz1kjyg@mail.gmail.com>
 <CAHC9VhQwT4d3wC37cVrrX-hZq1L3e6=TEAse4m-YH9SiFnkieA@mail.gmail.com>
 <CAGXu5jLapViSK-j08Tq8cCZodiZXFsXze71xFPg6MQhDWDHDAA@mail.gmail.com>
 <CAGXu5j+j47FH5RF2vrJh95=YFX76oSBFo8O6GZqa0utcfE1AVA@mail.gmail.com>
 <d1d12866-d557-8c15-6506-a54b9d927952@schaufler-ca.com>
 <CAGXu5jJG=wk6e_RU=KYDY48kOc=RmL3OB79T+rHqCyzaDSn=zg@mail.gmail.com>
 <5b983bba-049c-795a-3354-a2e8ab33cecf@schaufler-ca.com>
 <CAGXu5jJ5__jdBM5X0vVyEU1TKnN4dpkXbj=10iak9RvD1DZk9g@mail.gmail.com>
 <2bc5e4f5-8429-6843-f255-8fab6dacf39b@schaufler-ca.com>
 <CAGXu5jL2LjPhLsx2bQJQdj4GraTDakYTqb3fqUbWGrOfUsW8=w@mail.gmail.com>
From:   Casey Schaufler <casey@schaufler-ca.com>
Message-ID: <b5601e1a-2c29-55f1-63db-01421eeaa6ea@schaufler-ca.com>
Date:   Fri, 14 Sep 2018 13:47:55 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <CAGXu5jL2LjPhLsx2bQJQdj4GraTDakYTqb3fqUbWGrOfUsW8=w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/14/2018 1:05 PM, Kees Cook wrote:
> On Fri, Sep 14, 2018 at 8:57 AM, Casey Schaufler <casey@schaufler-ca.com> wrote:
>> On 9/13/2018 5:19 PM, Kees Cook wrote:
>>> We already have the minor LSMs that cannot change order.
>> Are you saying that we don't have a mechanism to change
>> the order, or that they wouldn't work right in a different
>> order? Well, there's the capability module that has to be
>> first.
> I just meant their order is explicit in security.c.
>
>>> They aren't
>>> part of security= parsing either.
>> True, but there's no reason now that we couldn't change that.
>> Except for capability. Hmm.
> Right, we have at least one that MUST be first (and must not be disabled).
>
>>> Should "blob-sharing" LSMs be like major LSMs or minor LSMs?
>> I like the idea of changing the minor modules to do the full
>> registration process. That would make them all the same.
>> Except for capability. In any case, the "blob-sharing" LSMs
>> need to do the full registration process to account for their
>> blobs sizes, and that brings the "major" behavior along with it.
> I agree. I'm working on some clean-ups that I'll send out soon, though
> I'm worried about some of the various boot-time options...

Looking forward to seeing them.

>>> If someone is booting with "security=selinux,tomoyo" and then SARA
>>> lands upstream, does that person have to explicitly add "sara" to
>>> their boot args, since they're doing a non-default list of LSMs?
>> Yes. security= is explicit.
>>
>>> (I actually prefer the answer being "yes" here, FWIW, I just want to
>>> nail down the expectations.)
>> For now let's leave the minor (capability, yama, loadpin) as they are,
>> and require all new modules of any flavor to use full registration.
> I would even be fine to convert yama and loadpin.

That shouldn't be difficult.

>> We could consider something like
>>
>> security=$lsm           # Stack with $lsm at priority 2 - Existing behavior
>> $lsm.stacked=N          # Add $lsm to the stack at priority N. Delete if N == 0
>>
>> It's OK to specify "selinux.stacked=2" and "sara.stacked=2". Which gets
>> called first is left up to the system to decide. Whatever the behavior is
>> gets documented. Capability will always be first and have priority 1.
>> It's OK to specify "smack.stacked=1".
> I'm less excited about this kind of stacking priority, but, whatever
> the case, I think my cleanups may help with whatever we decide.

OK

>> The default stack is determined by CONFIG_SECURITY_$lsm_STACKED at
>> build time. CONFIG_SECURITY_$lsm_STACKED changes from a boolean to
>> an integer value to establish the default hook order.
>>
>> /sys/kernel/security/lsm reports the modules in hook call order.
> Didn't I send a patch to new-line terminate this list? I always get
> annoyed when I "cat" it. ;)

SELinux set the precedence on that one. Not my fault!

>> /sys/kernel/security/lsm-stack reports the list with the hook call priority
>>
>>         capability:1,yama:1,selinux:1,sara:5,landlack:17
>>
>> If stacking is not configured $lsm.stacked=0 is treated as security=none.
>> For other values of N $lsm.stacked=N is treated as security=$lsm.
> I feel like "order" is bad enough. Can we avoid adding "priority"?

Sorry. I changed terminology (order and priority) halfway through the
message. Yes, I like order better. We should stick with that.

