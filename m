Return-Path: <SRS0=cBqk=QM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 864E7C282CB
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 06:46:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5DD722080D
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 06:46:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727359AbfBEGqg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Feb 2019 01:46:36 -0500
Received: from out03.mta.xmission.com ([166.70.13.233]:44261 "EHLO
        out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726646AbfBEGqg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Feb 2019 01:46:36 -0500
Received: from in01.mta.xmission.com ([166.70.13.51])
        by out03.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1gquV9-0002kB-42; Mon, 04 Feb 2019 23:46:35 -0700
Received: from ip68-227-174-240.om.om.cox.net ([68.227.174.240] helo=x220.xmission.com)
        by in01.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1gquV8-0006tg-Iq; Mon, 04 Feb 2019 23:46:34 -0700
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Kees Cook <keescook@chromium.org>,
        Christian Brauner <christian@brauner.io>,
        Jack Andersen <jackoalan@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Oleg Nesterov <oleg@redhat.com>
References: <20190203074939.7261-1-jackoalan@gmail.com>
        <20190203083933.ee4a6j4mdecesbn2@brauner.io>
        <CAGXu5jLGgCChpxt3ee8kSi2pTKPd9baHt_uZvTG6qqi8oFK2UQ@mail.gmail.com>
        <87r2cn7y9g.fsf@xmission.com>
        <CAHk-=wjFUCjvFzTGNt2hNO-Q5TaQHYSD_5NDDiS+zxwf3qQPwQ@mail.gmail.com>
Date:   Tue, 05 Feb 2019 00:46:28 -0600
In-Reply-To: <CAHk-=wjFUCjvFzTGNt2hNO-Q5TaQHYSD_5NDDiS+zxwf3qQPwQ@mail.gmail.com>
        (Linus Torvalds's message of "Tue, 5 Feb 2019 06:37:00 +0000")
Message-ID: <8736p24trv.fsf@xmission.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1gquV8-0006tg-Iq;;;mid=<8736p24trv.fsf@xmission.com>;;;hst=in01.mta.xmission.com;;;ip=68.227.174.240;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1+hfDI0E9K0YNH6jdm9atLmbWqde5zEzCM=
X-SA-Exim-Connect-IP: 68.227.174.240
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: Re: [PATCH] signal: always allocate siginfo for SI_TKILL
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds <torvalds@linux-foundation.org> writes:

> On Tue, Feb 5, 2019 at 2:41 AM Eric W. Biederman <ebiederm@xmission.com> wrote:
>>
>> I think the simpler change to just do:
>
> Ack. Changelog and sign-off?

Apologies I got distracted by processes ignoring SIGKILL.
I will write this up and send it out in the morning.

Eric
