Return-Path: <SRS0=0E8K=OK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1A20C04EB9
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Dec 2018 13:41:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C0AF320834
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Dec 2018 13:41:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C0AF320834
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=xmission.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726801AbeLBAyM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Dec 2018 19:54:12 -0500
Received: from out02.mta.xmission.com ([166.70.13.232]:45665 "EHLO
        out02.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726619AbeLBAyL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Dec 2018 19:54:11 -0500
Received: from in01.mta.xmission.com ([166.70.13.51])
        by out02.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1gT5Wa-0002pT-JH; Sat, 01 Dec 2018 06:41:36 -0700
Received: from ip68-227-174-240.om.om.cox.net ([68.227.174.240] helo=x220.xmission.com)
        by in01.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1gT5WZ-000754-JT; Sat, 01 Dec 2018 06:41:36 -0700
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Andy Lutomirski <luto@kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Christian Brauner <christian@brauner.io>,
        Florian Weimer <fweimer@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "Serge E. Hallyn" <serge@hallyn.com>, Jann Horn <jannh@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Daniel Colascione <dancol@google.com>,
        Tim Murray <timmurray@google.com>,
        linux-man <linux-man@vger.kernel.org>,
        Kees Cook <keescook@chromium.org>
References: <20181120105124.14733-1-christian@brauner.io>
        <87in0g5aqo.fsf@oldenburg.str.redhat.com>
        <36323361-90BD-41AF-AB5B-EE0D7BA02C21@amacapital.net>
        <993B98AC-51DF-4131-AF7F-7DA2A7F485F1@brauner.io>
        <CALCETrWnQNMQcCmFZrftVVYgAMW6DT3gyxvVb_v9_enUCUkHiw@mail.gmail.com>
        <20181129195551.woe2bl3z3yaysqb6@brauner.io>
        <6E21165F-2C76-4877-ABD9-0C86D55FD6AA@amacapital.net>
        <CAK8P3a2i9DFaS9-3A9V_pKwFfwVR0bDqgLosmivge3Cx2VyiuQ@mail.gmail.com>
        <87y39b2lm2.fsf@xmission.com>
        <20181130065606.kmilbbq46oeycjp5@brauner.io>
        <CAK8P3a0kqPii5TwFAo_JHLX=o_FDMFVKXxgzzbDjLFZ7OQ5QCQ@mail.gmail.com>
        <CALCETrW2aphWwEY4=hUwo_JBCvkQyMjxzxGd9FCW017kMLaMOQ@mail.gmail.com>
Date:   Sat, 01 Dec 2018 07:41:30 -0600
In-Reply-To: <CALCETrW2aphWwEY4=hUwo_JBCvkQyMjxzxGd9FCW017kMLaMOQ@mail.gmail.com>
        (Andy Lutomirski's message of "Fri, 30 Nov 2018 08:35:45 -0800")
Message-ID: <87va4d1i0l.fsf@xmission.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1gT5WZ-000754-JT;;;mid=<87va4d1i0l.fsf@xmission.com>;;;hst=in01.mta.xmission.com;;;ip=68.227.174.240;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1849rd1zGyAih2l8kAX++Rg5ToGYkIpqPU=
X-SA-Exim-Connect-IP: 68.227.174.240
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: Re: [PATCH v2] signal: add procfd_signal() syscall
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Andy Lutomirski <luto@kernel.org> writes:

> On Fri, Nov 30, 2018 at 3:41 AM Arnd Bergmann <arnd@arndb.de> wrote:
>> siginfo_t as it is now still has a number of other downsides, and Andy in
>> particular didn't like the idea of having three new variants on x86
>> (depending on how you count). His alternative suggestion of having
>> a single syscall entry point that takes a 'signfo_t __user *' but interprets
>> it as compat_siginfo depending on in_compat_syscall()/in_x32_syscall()
>> should work correctly, but feels wrong to me, or at least inconsistent
>> with how we do this elsewhere.
>
> BTW, do we consider siginfo_t to be extensible?  If so, and if we pass
> in a pointer, presumably we should pass a length as well.

siginfo is extensible in the sense that the structure is 128 bytes
and we use at most 48 bytes.  siginfo gets embedded in stack frames when
signals get delivered so a size change upwards is non-trivial, and is
possibly and ABI break so I believe a length field would be pointless.

Eric

