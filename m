Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A26BCC0044C
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 05:01:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 51BB220685
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 05:01:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 51BB220685
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=xmission.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729167AbeJaN6G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Oct 2018 09:58:06 -0400
Received: from out01.mta.xmission.com ([166.70.13.231]:43247 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728978AbeJaN6F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Oct 2018 09:58:05 -0400
Received: from in02.mta.xmission.com ([166.70.13.52])
        by out01.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1gHidM-0000hB-Ne; Tue, 30 Oct 2018 23:01:36 -0600
Received: from 67-3-154-154.omah.qwest.net ([67.3.154.154] helo=x220.xmission.com)
        by in02.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1gHid7-0001Z2-Cf; Tue, 30 Oct 2018 23:01:36 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Christian Brauner <christian.brauner@canonical.com>
Cc:     Daniel Colascione <dancol@google.com>,
        Joel Fernandes <joelaf@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Tim Murray <timmurray@google.com>,
        Suren Baghdasaryan <surenb@google.com>
References: <20181029221037.87724-1-dancol@google.com>
        <CAJWu+oquh1RXz+1tD91NzvicYAL3GP0KVi7RLR2cgouSgHXjOw@mail.gmail.com>
        <CAKOZueub941EHifyf7zEk_yvf=2P+HV-8esE1QPFypRoxtt1qQ@mail.gmail.com>
        <20181030103910.mnzot3zcoh6j7did@gmail.com>
        <20181030104037.73t5uz3piywxwmye@gmail.com>
        <CAKOZuesb4ns1dM7itX9uzvYBGp_aSgQXV1ONuV4eQRq0FiehYQ@mail.gmail.com>
        <CAPP7u0VE-4c10A7A+WO+rMFbNF42CROP7+xGttzU_3HWQk883Q@mail.gmail.com>
        <CAKOZueswuOTvkOeuipRwg5VCYGvpf=8j1ChJftAk_fJO6xPPtQ@mail.gmail.com>
        <CAPP7u0X-FRgS0kGcL7dMEGzLys54UkXU3+drX76=NmMbCOLsxg@mail.gmail.com>
Date:   Wed, 31 Oct 2018 00:00:51 -0500
In-Reply-To: <CAPP7u0X-FRgS0kGcL7dMEGzLys54UkXU3+drX76=NmMbCOLsxg@mail.gmail.com>
        (Christian Brauner's message of "Tue, 30 Oct 2018 12:19:51 +0100")
Message-ID: <87h8h21zi4.fsf@xmission.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1gHid7-0001Z2-Cf;;;mid=<87h8h21zi4.fsf@xmission.com>;;;hst=in02.mta.xmission.com;;;ip=67.3.154.154;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX18ocbg7AB8i1EGx2q5vpV3n5aF+D6ZRGTs=
X-SA-Exim-Connect-IP: 67.3.154.154
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: Re: [RFC PATCH] Implement /proc/pid/kill
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Christian Brauner <christian.brauner@canonical.com> writes:

> On Tue, Oct 30, 2018 at 12:12 PM Daniel Colascione <dancol@google.com> wrote:
>>
>> On Tue, Oct 30, 2018 at 11:04 AM, Christian Brauner
>> <christian.brauner@canonical.com> wrote:
>> > On Tue, Oct 30, 2018 at 11:48 AM Daniel Colascione <dancol@google.com> wrote:
>> >>
>> >> Why not?
>> >>
>> >> Does your proposed API allow for a race-free pkill, with arbitrary
>> >> selection criteria? This capability is a good litmus test for fixing
>> >> the long-standing Unix process API issues.
>> >
>> > You'd have a handle on the process with an fd so yes, it would be.
>>
>> Thanks. That's good to hear.
>>
>> Any idea on the timetable for this proposal? I'm open to lots of
>> alternative technical approaches, but I don't want this capability to
>> languish for a long time.
>
> Latest end of year likely sooner depending on the feedback I'm getting
> during LPC.

Frankly.  If you want a race free fork variant probably the easiest
thing to do is to return a open copy of the proc directory entry.  Wrapped
in a bind mount so that you can't see beyond that directory in proc.

My only concern would be if a vfsmount per process would be too heavy for such a use.

Eric



