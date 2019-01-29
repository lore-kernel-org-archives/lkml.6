Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51554C169C4
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 11:33:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2916F20844
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 11:33:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727688AbfA2Lc6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 06:32:58 -0500
Received: from www262.sakura.ne.jp ([202.181.97.72]:16757 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725772AbfA2Lc6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 06:32:58 -0500
Received: from fsav101.sakura.ne.jp (fsav101.sakura.ne.jp [27.133.134.228])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id x0TBW5sg099493;
        Tue, 29 Jan 2019 20:32:05 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav101.sakura.ne.jp (F-Secure/fsigk_smtp/530/fsav101.sakura.ne.jp);
 Tue, 29 Jan 2019 20:32:05 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/530/fsav101.sakura.ne.jp)
Received: from [192.168.1.8] (softbank126126163036.bbtec.net [126.126.163.36])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id x0TBW5hP099488
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NO);
        Tue, 29 Jan 2019 20:32:05 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Subject: Re: WARNING in apparmor_secid_to_secctx
To:     Dmitry Vyukov <dvyukov@google.com>,
        Casey Schaufler <casey@schaufler-ca.com>
Cc:     Paul Moore <paul@paul-moore.com>,
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
        Laurent Bigonville <bigon@debian.org>
References: <000000000000c178e305749daba4@google.com>
 <CACT4Y+Z9wmuq=Pb-gxAJauQNi0uZGDUimWEL66UzWGSp_x2uQA@mail.gmail.com>
 <37aec45f-69ad-9705-21f1-64ee4ce4a772@tycho.nsa.gov>
 <CAHC9VhSeP=b1xxpCT8R-CYLEP3507ezwDwkq2Bsyekfa4otLGw@mail.gmail.com>
 <9537a6ff-daf4-d572-bf93-68230909b68e@tycho.nsa.gov>
 <4b37e892-4d79-aefb-92ab-7753b89b8963@tycho.nsa.gov>
 <CACT4Y+YOxTTYzEi3uCeLm3gquvSkJNZ+DhPVziEnbXGX6HVkVA@mail.gmail.com>
 <1ea19628-3bbe-2073-d623-824337c15ed6@tycho.nsa.gov>
 <CACT4Y+ai0do=8smTG0h0QXDnOrWh8PNwaTosJtqOEB_HG59eGg@mail.gmail.com>
 <b2b38348-f3a4-6498-c9b8-1090532f6a23@tycho.nsa.gov>
 <CACT4Y+bXaLe0FKyGPT=WqGitZPrawvpOXHS-UOVX0ZXTDV+JVQ@mail.gmail.com>
 <6c9112a2-33f3-0c29-c944-1d129a0026e7@tycho.nsa.gov>
 <CAHC9VhR6gG6_RkT1OEH4PArHpzUGkOjVCpKwAmad+TDfC15sgQ@mail.gmail.com>
 <CACT4Y+YaBpi95Puae3Bjn1opL+UsdUWns2PDaFU-EmamuMusag@mail.gmail.com>
 <e2e02f43-abfe-171e-a5b7-3fb9086cc733@schaufler-ca.com>
 <CACT4Y+aaF8pLirqA+Yv4RjemDofEZymjPV6z5EEPQk3b7or10g@mail.gmail.com>
From:   Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Message-ID: <e598f3c7-22bc-91c2-2f47-0eec068f5180@I-love.SAKURA.ne.jp>
Date:   Tue, 29 Jan 2019 20:32:01 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <CACT4Y+aaF8pLirqA+Yv4RjemDofEZymjPV6z5EEPQk3b7or10g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018/09/06 19:59, Dmitry Vyukov wrote:
> On Wed, Sep 5, 2018 at 7:37 PM, Casey Schaufler <casey@schaufler-ca.com> wrote:
>> On 9/5/2018 4:08 AM, Dmitry Vyukov wrote:
>>> Thanks! I've re-enabled selinux on syzbot:
>>> https://github.com/google/syzkaller/commit/196410e4f5665d4d2bf6c818d06f1c8d03cfa8cc
>>> Now we will have instances with apparmor and with selinux.
>>
>> Any chance we could get a Smack instance as well?
> 
> Hi Casey,
> 
> Sure!
> Provided you want to fix bugs ;)
> I've setup an instance with smack enabled:
> https://github.com/google/syzkaller/commit/0bb7a7eb8e0958c6fbe2d69615b9fae4af88c8ee
> 

Dmitry, is it possible to update configs for linux-next.git , for
we want to test a big change in LSM which will go to Linux 5.1 ?

TOMOYO security module (CONFIG_SECURITY_TOMOYO=y) can now coexist with
SELinux/Smack/AppArmor security modules, and SafeSetID security module
(CONFIG_SECURITY_SAFESETID=y) was added. Testing with these modules also
enabled might find something...
