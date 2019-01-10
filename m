Return-Path: <SRS0=lBHl=PS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4E58C43444
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 22:00:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A93D420665
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 22:00:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729543AbfAJWAT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Jan 2019 17:00:19 -0500
Received: from namei.org ([65.99.196.166]:55420 "EHLO namei.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727653AbfAJWAS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jan 2019 17:00:18 -0500
Received: from localhost (localhost [127.0.0.1])
        by namei.org (8.14.4/8.14.4) with ESMTP id x0AM08XL012576;
        Thu, 10 Jan 2019 22:00:08 GMT
Date:   Fri, 11 Jan 2019 09:00:08 +1100 (AEDT)
From:   James Morris <jmorris@namei.org>
To:     Paul Moore <paul@paul-moore.com>
cc:     Kees Cook <keescook@chromium.org>,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Casey Schaufler <casey@schaufler-ca.com>,
        John Johansen <john.johansen@canonical.com>,
        =?ISO-8859-15?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>,
        Salvatore Mesoraca <s.mesoraca16@gmail.com>
Subject: Re: [GIT PULL] blob-stacking updates for security-next
In-Reply-To: <CAHC9VhSma5JCGf6Fi9NS1841kuWAKm4h9d7qW94yJNEO5t8oHg@mail.gmail.com>
Message-ID: <alpine.LRH.2.21.1901110858130.11115@namei.org>
References: <20190108213504.GA32901@beast> <alpine.LRH.2.21.1901110733060.7043@namei.org> <CAHC9VhSma5JCGf6Fi9NS1841kuWAKm4h9d7qW94yJNEO5t8oHg@mail.gmail.com>
User-Agent: Alpine 2.21 (LRH 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 10 Jan 2019, Paul Moore wrote:

> > Please test!
> 
> While not exhaustive by any stretch of the imagination, you might want
> to throw the audit-testsuite at it too.
> 
> * https://github.com/linux-audit/audit-testsuite

I'm seeing lots of failures with vanilla -rc1, probably much to do with my 
kconfig:

Test Summary Report
-------------------
exec_name/test         (Wstat: 0 Tests: 5 Failed: 2)
  Failed tests:  4-5
filter_exclude/test    (Wstat: 0 Tests: 21 Failed: 2)
  Failed tests:  20-21
lost_reset/test        (Wstat: 0 Tests: 5 Failed: 2)
  Failed tests:  4-5
netfilter_pkt/test     (Wstat: 0 Tests: 13 Failed: 13)
  Failed tests:  1-13
syscalls_file/test     (Wstat: 0 Tests: 3 Failed: 2)
  Failed tests:  2-3
syscall_module/test    (Wstat: 0 Tests: 6 Failed: 4)
  Failed tests:  2-3, 5-6
syscall_socketcall/test (Wstat: 0 Tests: 3 Failed: 3)
  Failed tests:  1-3
user_msg/test          (Wstat: 0 Tests: 2 Failed: 2)
  Failed tests:  1-2
Files=14, Tests=80, 16 wallclock secs ( 0.04 usr  0.02 sys +  2.21 cusr  
0.60 csys =  2.87 CPU)
Result: FAIL
Failed 8/14 test programs. 30/80 subtests failed.

It would be good to have a defconfig to merge like with the SELinux 
testsuite.



-- 
James Morris
<jmorris@namei.org>

