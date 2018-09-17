Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63A14ECE560
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 17:13:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E0F1214DA
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 17:13:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="KK7EoKB4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0E0F1214DA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728261AbeIQWlr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 18:41:47 -0400
Received: from sonic304-17.consmr.mail.bf2.yahoo.com ([74.6.128.40]:32776 "EHLO
        sonic304-17.consmr.mail.bf2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726795AbeIQWlr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 18:41:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1537204410; bh=t9ZLkhcSbUvbWxm7EseqgZZCEJx8hmBIJIM+CQUaE08=; h=Subject:To:Cc:References:From:Date:In-Reply-To:From:Subject; b=KK7EoKB4i3loYgobeasZi9xRM+VDqDLXZcA9hmxdSLPBy9Ro8bOPHBFOdOkpiWOadYGV9zgJ7TzOgjaz5619BGg8Lh7SXNTgQ1ed0w9XVWlDqkliCJZ4hwwlKjKUTv7nF68HRwI5Fx+ECrZNbsZTxZksxQC0D56U9EFF215yjnu8t2a3+skPYSfoHHpC1xqcf+r57nbhXjMLKNkXzt86XmE1pifTK+HuSGEaY27agopcAkZLmMnCjAkxwFac0+5d3En9fcZQkKMoSjNNtEjUpgsBDH0hr4duWCDZAjaW8SFpf9cPI5l+VWGxf4TWzi1KIg6SNAAWLPlkenQRv1NuKg==
X-YMail-OSG: V3GLlHcVM1nyPFbrJeiSuB.WhWih8QPzGFUPRQdYxUmAy95Q9imDS0MFHdJzV42
 V_oZQDmr6ecf7YRgueRmFqrjqnE.UAh_VUgips4Ja.iuUX3q3t2e5KhdEK0lVr1ghmPRSBrSeoIc
 QxV_SWhJ1l8AwPm__Ym.fYSg51G0NSOBYMPp0RA.8q6WBVidrGjqPAvVuuUqmM9xRSStXhOgp_LZ
 jBg8GBlfsLUxaNPbamKFLl1RPgAuN66UcDFcIJbe0NH9ZNp8lFmW3TcA_UNG2u6g7luMhpjTVzGh
 LZ0vcbV35D.j32d1.d4hqLJ2RrK42DqmntAc5RrzvJvDsd0hA7punahnOM2_tXxg0e8m3u7C8rIT
 s4M1GGAox4AMTdXkMu8UC014mmONcLKrErXHRubVmhitNEVdjHusRjKlJh8hmF2Y6J4j.9mAd4Xy
 39_7tBmGZym0Md_VmI3tgViGdrCp9atABOSqPDpAwltnLwe4EbTDD1w4Ec4QHNqgTVXaxlZxEvVy
 GfGBVyBF71wgGT595BkLVk106XSitP4D6WommQi5FVwS2K3GjPwxz4QO6ihp5mH1q5hRxKxFiJTe
 I5qwYzH0yN4iJNFJzeTq7Ld0zgIqSTnIzAooEWmuWeKOGfA.NYi5RjVjnywBLzD7vdCjZB15eVjQ
 XnKh55V._InTpr21AduAUyek7ijJFouS_A.16aS81idkBABguiIVGMo_21kzsGwM0z_MEekN0tD3
 PQbirElV2B1ze8.pf0ZtiIjce0_L4Av0ROyQlxD4hLAreuavdq_.pw4qQFG9f1FaNYWafT6kkTM2
 Aa0WtVzhenuttUDVtYa7uLFva0k_ejuz59hNz3ayI7tDg7ptpiDuvIMzH6N10cQCb9FUy8IT68kO
 mX1J0X.Pm47fgp_v8v2xKI3elvhe2RQrRgnd1CJjbzso5Cfj1AQuNLBUJa.qk62EbrEH2q_dA338
 hSt5m6Qw5d9fs0hnzfj4wP7dua1tmcISIToF0svnsCZUv3cbTqpiyJXELUyvisqcj4oqGK48lKmg
 9OwgD4rTe3zMSMoh3VX7Wy4iEC_A-
Received: from sonic.gate.mail.ne1.yahoo.com by sonic304.consmr.mail.bf2.yahoo.com with HTTP; Mon, 17 Sep 2018 17:13:30 +0000
Received: from c-67-169-65-224.hsd1.ca.comcast.net (EHLO [192.168.0.102]) ([67.169.65.224])
          by smtp427.mail.bf1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID f0dd9c95f18aac124fe0b7030aa8f76d;
          Mon, 17 Sep 2018 17:13:30 +0000 (UTC)
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
From:   Casey Schaufler <casey@schaufler-ca.com>
Message-ID: <8f0bd39b-29a6-325d-4558-d9f484249c22@schaufler-ca.com>
Date:   Mon, 17 Sep 2018 10:13:26 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <CAGXu5jJ71RLGh0nDgOaN3vCXFGE0poXFU2Gb9o+20aO+AEdOvw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/17/2018 9:24 AM, Kees Cook wrote:
> On Mon, Sep 17, 2018 at 8:06 AM, Casey Schaufler <casey@schaufler-ca.com> wrote:
>>> The trailing comma thing gets us some compatibility, but we still have
>>> to decide which things should be exclusive-via-"security=" since with
>>> blob-sharing it already becomes possible to do selinux + tomoyo.
>>>
>>> The -$lsm style may make it hard to sensibly order any unspecified
>>> LSMs. I guess it could just fall back to "follow builtin ordering of
>>> unspecified LSMs" (unless someone had, maybe, "-all").
>> That's why I'm not especially happy with either one.
>>
>>> so, if builtin ordering after blob-sharing is
>>> capability,integrity,yama,loadpin,{selinux,apparmor,smack},tomoyo
>>>
>>> security=apparmor  is  capability,apparmor,integrity,yama,loadpin,tomoyo
>> I would expect capability,integrity,yama,loadpin,apparmor to reflect
>> today's behavior.
> If that's desired then we have to declare tomoyo as "exclusive" even
> though it doesn't use blobs. But then what happens in the extreme
> stacking case? Do we add "lsm.extreme=1" to change how security= is
> parsed?

TOMOYO uses the cred blob pointer. When the blob is shared TOMOYO
has to be allocated a pointer size chunk to store the pointer in.
Smack has the same behavior on file blobs.


>>> security=yama,smack,-all  is  capability,yama,smack
>> Yes
>>
>>> security=loadpin,selinux,yama,-integrity  is
>>> capability,loadpin,selinux,yama,tomoyo
>> I think that the negation should only apply to
>> integrity, yama and loadpin. All blob-using modules
>> must be explicitly stated if you want to use them.
> What about tomoyo, though? It's presently considered a major LSM (i.e.
> security=tomoyo disables the other majors), but it doesn't use blobs.
>
>>> Whatever we design, it needs to handle both the blob-sharing
>>> near-future, and have an eye towards "extreme stacking" in the
>>> some-day future. In both cases, the idea of a "major" LSM starts to
>>> get very very hazy.
>> Long term the only distinction is "minor" and blob using. So long as
>> there's a way to enforce incompatibility (i.e. not Smack and SELinux)
>> in the sorter term we can adopt that mindset already.
> Given that tomoyo doesn't share blobs and integrity doesn't register
> hooks, how would they be considered in that world? Or rather, what
> distinguishes a "minor" LSM? It seems there are three cases: uses
> blobs with sharing, uses blobs without sharing, uses no blobs. What
> happens if an LSM grows a feature that needs blob sharing? If "uses no
> blobs" should be considered "shares blobs", then there is no
> distinction between "minor" and "blob sharing".

Today the distinction is based on how the module registers hooks.
Modules that use blobs (including TOMOYO) use security_module_enable()
and those that don't just use security_add_hooks(). The "pick one"
policy is enforced in security_module_enable(), which is why you can
have as many non-blob users as you like. You could easily have a
non-blob using module that was exclusive simply by using
security_module_enable().

In the stacking case you could have integrity_init() call
security_module_enable() but not security_add_hooks(). You wouldn't
want to do that without stacking configured, because that would
make integrity exclusive.
 

>>> As for how we classify things, based on hooks...
>>>
>>> now:
>>>     always: capability
>>>     major: selinux,apparmor,smack,tomoyo
>>>     minor: yama,loadpin
>>>     init-only: integrity
>>>
>>> blob-sharing:
>>>     always: capability
>>>     exclusive: selinux,apparmor,smack
>>>     sharing: tomoyo,integrity,yama,loadpin
>>>
>>> extreme:
>>>     always: capability
>>>     sharing: selinux,apparmor,smack,tomoyo,integrity,yama,loadpin
>>>
>>> The most special are capability (unconditional, run first) and
>>> integrity (init-only, no security_add_hooks() call).
>>>
>>> Can we classify things as MAC and non-MAC for "major" vs "minor"? SARA
>>> and Landlock aren't MAC (and neither is integrity), or should we do
>>> the "-$lsm" thing instead?
>> I don't like using MAC because the use of the module isn't the issue,
>> it's the interfaces used. As ugly as it is, I like the -$lsm better.
> Agreed on MAC. And yes, I think -$lsm is best here. Should we overload
> "security=" or add "lsm.stacking="?

Keep security=$lsm with the existing exclusive behavior.

Add lsm=$lsm1,...,$lsmN which requires a full list of modules

If you want to be fancy (I don't!) you could add

lsm.add=$lsm1,...,$lsmN which adds the modules to the stack
lsm.delete=$lsm1,...,$lsmN which deletes modules from the stack

