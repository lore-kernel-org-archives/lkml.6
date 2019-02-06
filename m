Return-Path: <SRS0=01Bl=QN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4639BC169C4
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 10:24:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 103D52083B
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 10:24:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729065AbfBFKYM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Feb 2019 05:24:12 -0500
Received: from www262.sakura.ne.jp ([202.181.97.72]:26469 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726728AbfBFKYL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Feb 2019 05:24:11 -0500
Received: from fsav303.sakura.ne.jp (fsav303.sakura.ne.jp [153.120.85.134])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id x16AN8qX005650;
        Wed, 6 Feb 2019 19:23:08 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav303.sakura.ne.jp (F-Secure/fsigk_smtp/530/fsav303.sakura.ne.jp);
 Wed, 06 Feb 2019 19:23:08 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/530/fsav303.sakura.ne.jp)
Received: from [192.168.1.8] (softbank126126163036.bbtec.net [126.126.163.36])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id x16AN2qE005605
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NO);
        Wed, 6 Feb 2019 19:23:08 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Subject: Re: [PATCH] LSM: Allow syzbot to ignore security= parameter.
To:     Dmitry Vyukov <dvyukov@google.com>
Cc:     Casey Schaufler <casey@schaufler-ca.com>,
        Paul Moore <paul@paul-moore.com>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        syzbot <syzbot+21016130b0580a9de3b5@syzkaller.appspotmail.com>,
        tyhicks@canonical.com, John Johansen <john.johansen@canonical.com>,
        James Morris <jmorris@namei.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-security-module@vger.kernel.org,
        Serge Hallyn <serge@hallyn.com>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Jeffrey Vander Stoep <jeffv@google.com>,
        SELinux <selinux@tycho.nsa.gov>,
        Russell Coker <russell@coker.com.au>,
        Laurent Bigonville <bigon@debian.org>,
        syzkaller <syzkaller@googlegroups.com>,
        Andrew Morton <akpm@linux-foundation.org>
References: <000000000000c178e305749daba4@google.com>
 <CACT4Y+bXaLe0FKyGPT=WqGitZPrawvpOXHS-UOVX0ZXTDV+JVQ@mail.gmail.com>
 <6c9112a2-33f3-0c29-c944-1d129a0026e7@tycho.nsa.gov>
 <CAHC9VhR6gG6_RkT1OEH4PArHpzUGkOjVCpKwAmad+TDfC15sgQ@mail.gmail.com>
 <CACT4Y+YaBpi95Puae3Bjn1opL+UsdUWns2PDaFU-EmamuMusag@mail.gmail.com>
 <e2e02f43-abfe-171e-a5b7-3fb9086cc733@schaufler-ca.com>
 <CACT4Y+aaF8pLirqA+Yv4RjemDofEZymjPV6z5EEPQk3b7or10g@mail.gmail.com>
 <e598f3c7-22bc-91c2-2f47-0eec068f5180@I-love.SAKURA.ne.jp>
 <CACT4Y+YXsD4f+ngzN7SGXcUGBn-jG1KeyrZJBzcUWo-AbdTe4w@mail.gmail.com>
 <05340d28-36c2-267e-d54e-416fddfba211@i-love.sakura.ne.jp>
 <CACT4Y+Ynyy-bMK4cxhgNoAaauFdjzExuELM6u0amksbR4wy7GQ@mail.gmail.com>
 <71e3652b-b222-0c3f-8b48-5980ddcaeb93@i-love.sakura.ne.jp>
 <CACT4Y+Z036bZfN1-_VaQ5EorwFt_tpPm=RTnrYN5qKV_ebgoFw@mail.gmail.com>
 <52531a69-10ed-d263-be66-e707705597d6@i-love.sakura.ne.jp>
 <CACT4Y+Yd1YN=OELBmzUDvwdg5KuV2WnN9WZpjk5O_yuS0i1yOA@mail.gmail.com>
From:   Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Message-ID: <8f48e1d0-c109-f8a9-ea94-9659b16cae49@i-love.sakura.ne.jp>
Date:   Wed, 6 Feb 2019 19:23:03 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <CACT4Y+Yd1YN=OELBmzUDvwdg5KuV2WnN9WZpjk5O_yuS0i1yOA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019/02/04 17:07, Dmitry Vyukov wrote:
> On Fri, Feb 1, 2019 at 2:09 PM Tetsuo Handa
> <penguin-kernel@i-love.sakura.ne.jp> wrote:
>>
>> On 2019/02/01 19:50, Dmitry Vyukov wrote:
>>> On Fri, Feb 1, 2019 at 11:44 AM Tetsuo Handa
>>> <penguin-kernel@i-love.sakura.ne.jp> wrote:
>>>>
>>>> On 2019/02/01 19:09, Dmitry Vyukov wrote:
>>>>> Thanks for the explanations.
>>>>>
>>>>> Here is the change that I've come up with:
>>>>> https://github.com/google/syzkaller/commit/aa53be276dc84aa8b3825b3416542447ff82b41a
>>>>
>>>> You are not going to apply this updated config to upstream kernels now, are you?
>>>> Removing CONFIG_DEFAULT_SECURITY="apparmor" from configs used by upstream kernels
>>>> will cause failing to enable AppArmor (unless security=apparmor is specified).
>>>
>>>
>>> We do use  security=apparmor, see:
>>> https://github.com/google/syzkaller/blob/master/dashboard/config/upstream-apparmor.cmdline
>>> https://github.com/google/syzkaller/blob/master/dashboard/config/upstream-selinux.cmdline
>>> https://github.com/google/syzkaller/blob/master/dashboard/config/upstream-smack.cmdline
>>>
>>
>> Oh, security= parameter is explicitly specified on all targets?
>> Then, we can abuse CONFIG_DEBUG_AID_FOR_SYZBOT option. ;-)
>>
>> LSM folks, may we use this patch for linux-next.git ?
>> CONFIG_DEBUG_AID_FOR_SYZBOT is a linux-next.git-only kernel config option used by syzbot.
> 
> 
> Then we also need this on syzbot side, right? Otherwise it seems that
> all instances will default to a single security module.
> https://github.com/google/syzkaller/commit/ffec3d1894ffd05966b50efa49ca19af76c9ea81
> 

Right.

But as I update the documentation ( https://tomoyo.osdn.jp/2.6/chapter-3.html.en#3.6 ),
I came to think that we should ignore security= parameter when lsm= parameter is specified.

Currently, it is possible to enable TOMOYO and only one of SELinux/Smack/AppArmor. Therefore,
it is possible to disable only TOMOYO by specifying security=selinux when we want to enable
only SELinux, by specifying security=smack when we want to enable only Smack, by specifying
security=apparmor when we want to enable only AppArmor. That is, we can use security= parameter
in order to specify the other LSM module which should not be disabled.

But when it becomes possible to enable TOMOYO and more than one of SELinux/Smack/AppArmor,
we will no longer be able to selectively disable one LSM module using security= parameter, for
security= parameter is intended for specifying only one LSM module which should be enabled.
That is, we will need to use lsm= parameter in order to selectively disable LSM modules.

Then, I think that it is straightforward (and easier to manage) to ignore security= parameter
when lsm= parameter is specified. Furthermore, we could even avoid introducing lsm= parameter
by allowing security= parameter to specify multiple LSM modules. For example, security= parameter
is interpreted as a list of all LSM modules which should be enabled when it contains a comma,
and it is interpreted as one of LSM_FLAG_LEGACY_MAJOR modules which should be enabled otherwise.
Then, specifying security=selinux or security=smack or security=tomoyo or security=apparmor or
security=none will respectively enable SELinux, Smack, TOMOYO, AppArmor, none of
SELinux/Smack/TOMOYO/AppArmor. And specifying e.g. security=, will disable all LSM modules.
