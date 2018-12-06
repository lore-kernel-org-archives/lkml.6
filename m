Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 296E0C04EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 18:56:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F1E6420868
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 18:56:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F1E6420868
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726034AbeLFS4y convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 13:56:54 -0500
Received: from mx1.redhat.com ([209.132.183.28]:46616 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725901AbeLFS4y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 13:56:54 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 9E59D31500AE;
        Thu,  6 Dec 2018 18:56:53 +0000 (UTC)
Received: from oldenburg2.str.redhat.com (ovpn-116-106.ams2.redhat.com [10.36.116.106])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 4807E19C7F;
        Thu,  6 Dec 2018 18:56:46 +0000 (UTC)
From:   Florian Weimer <fweimer@redhat.com>
To:     Andy Lutomirski <luto@kernel.org>
Cc:     Christian Brauner <christian@brauner.io>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
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
Subject: Re: [PATCH v2] signal: add procfd_signal() syscall
References: <20181120105124.14733-1-christian@brauner.io>
        <87in0g5aqo.fsf@oldenburg.str.redhat.com>
        <746B7C49-CC7B-4040-A7EF-82491796D360@brauner.io>
        <20181202100304.labt63mzrlr5utdl@brauner.io>
        <8736rebl9s.fsf@oldenburg.str.redhat.com>
        <20181203180224.fkvw4kajtbvru2ku@brauner.io>
        <874lbtjvtd.fsf@oldenburg2.str.redhat.com>
        <CALCETrViXJ0gD34yVd8QpB-CSeKZzzncvkPHReycTiQin4r4WQ@mail.gmail.com>
Date:   Thu, 06 Dec 2018 19:56:44 +0100
In-Reply-To: <CALCETrViXJ0gD34yVd8QpB-CSeKZzzncvkPHReycTiQin4r4WQ@mail.gmail.com>
        (Andy Lutomirski's message of "Thu, 6 Dec 2018 10:54:02 -0800")
Message-ID: <87y392h4b7.fsf@oldenburg2.str.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.41]); Thu, 06 Dec 2018 18:56:54 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Andy Lutomirski:

>> I suppose that's fine.  Or alternatively, when thread group support is
>> added, introduce a flag that applications have to use to enable it, so
>> that they can probe for support by checking support for the flag.
>>
>> I wouldn't be opposed to a new system call like this either:
>>
>>  int procfd_open (pid_t thread_group, pid_t thread_id, unsigned flags);
>>
>> But I think this is frowned upon on the kernel side.
>
> I have no problem with it, except that I think it shouldn’t return an
> fd that can be used for proc filesystem access.

Oh no, my intention was that it would just be used with  *_send_signal
and related functions.

Thanks,
Florian
