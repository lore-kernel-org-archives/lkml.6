Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DFF3C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 16:24:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F3E0020831
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 16:24:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="L6mQaLBx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F3E0020831
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730029AbeKTCsK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 21:48:10 -0500
Received: from mail-vs1-f68.google.com ([209.85.217.68]:35037 "EHLO
        mail-vs1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729937AbeKTCsJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 21:48:09 -0500
Received: by mail-vs1-f68.google.com with SMTP id e7so18116424vsc.2
        for <linux-kernel@vger.kernel.org>; Mon, 19 Nov 2018 08:24:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=b/dNaTvz6Bhl24QHJ1GX7PHoKH/Ynzj09/enaeXKn6k=;
        b=L6mQaLBx1jcDiwBhZpdROTnuyCRBdcapfT7uRtrNPM99BCVmZlEH+5YGsDBrT079HI
         bA15jwju7thTg33v0zQusbxauwrGKIlbqfvAZ/Pgujx2RhN65agYakrPWUl33eX5w7E7
         CypPXjaEtWtUTJ4I8QQGi50rvp+EOoBuUquBhcg51U0C+c8Yr4+ls0FgV7H3PbtFU0l7
         cWSSHrhn9h5ZIYVwskRfET1FeFKF3EbqCLTJ3YYDT+bvdyOvHMRXUx7TfcSeBZJqR8M6
         9s67GrBsr0FUz9aA7Kr6/NFZcCVAYnUrHrG+sypCZoTXQF9e8l+LUfVvW8wVK9cv1glG
         RPeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=b/dNaTvz6Bhl24QHJ1GX7PHoKH/Ynzj09/enaeXKn6k=;
        b=oQD3HyJhd2VZvAL0wmqn2elLKfDEjbV+RZEEfwoqx0ed0C2cPwrLeBk2E/pCoRwLlE
         0M5lwUYtW4uZd6YAnpo5JI/EzJ3LOQdFr4Ed7Al/AQShOjdAgGWTXTRwmDG/Nx7xoKAy
         vBewK8rp+B6wP8zzEjhrDYgnymstBMNuC1YwPSo0YrbM4PA44yHMjkQIRM6tVXtQSc//
         XMGzAtLNYj9UA7vVJOpOCPm45GsqcW+TzjM0UmqhDigwRq5JpJIPQoclonmN5m1sF0Q7
         rwrPpn218+gHdc0U6KZGbYB/MMNl1Ehi4MJ6OnvRCaAALTDebRCYft6e3evpYW9wlLs8
         IEwA==
X-Gm-Message-State: AGRZ1gInNI2raBWuaQaxB0Q12XOCNgL2qxvXOmg5QCfzVSg3P03UDjcw
        1hDP2Kf8NHGyf8eNz+uYmr9FmKc/WYaD6s0fiAVF1w==
X-Google-Smtp-Source: AJdET5fuwC9FemPQeEUsmu4GvOG/IMwUzq8xLVs/+keTmXetuxjRRdTqKDFUiH4dn895owhJUx2eL5CF4E5+kC98GnA=
X-Received: by 2002:a67:6346:: with SMTP id x67mr9209047vsb.114.1542644643395;
 Mon, 19 Nov 2018 08:24:03 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a67:f48d:0:0:0:0:0 with HTTP; Mon, 19 Nov 2018 08:24:02
 -0800 (PST)
In-Reply-To: <20181119105426.GD28607@amd>
References: <20181031150625.147369-1-dancol@google.com> <20181105132205.138695-1-dancol@google.com>
 <20181119105426.GD28607@amd>
From:   Daniel Colascione <dancol@google.com>
Date:   Mon, 19 Nov 2018 08:24:02 -0800
Message-ID: <CAKOZueu3RQF4hOSg-0LCNVzJsJ=D_yfXg_uun2tqXW8aSkKykw@mail.gmail.com>
Subject: Re: [PATCH v2] Document /proc/pid PID reuse behavior
To:     Pavel Machek <pavel@ucw.cz>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Tim Murray <timmurray@google.com>,
        Joel Fernandes <joelaf@google.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Roman Gushchin <guro@fb.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        "Dennis Zhou (Facebook)" <dennisszhou@gmail.com>,
        Prashant Dhamdhere <pdhamdhe@redhat.com>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 19, 2018 at 2:54 AM, Pavel Machek <pavel@ucw.cz> wrote:
> On Mon 2018-11-05 13:22:05, Daniel Colascione wrote:
>> State explicitly that holding a /proc/pid file descriptor open does
>> not reserve the PID. Also note that in the event of PID reuse, these
>> open file descriptors refer to the old, now-dead process, and not the
>> new one that happens to be named the same numeric PID.
>>
>> Signed-off-by: Daniel Colascione <dancol@google.com>
>> ---
>>  Documentation/filesystems/proc.txt | 7 +++++++
>>  1 file changed, 7 insertions(+)
>>
>> Moved paragraphed to start of /proc/pid section; added signed-off-by.
>>
>> diff --git a/Documentation/filesystems/proc.txt b/Documentation/filesystems/proc.txt
>> index 12a5e6e693b6..0b14460f721d 100644
>> --- a/Documentation/filesystems/proc.txt
>> +++ b/Documentation/filesystems/proc.txt
>> @@ -125,6 +125,13 @@ process running on the system, which is named after the process ID (PID).
>>  The link  self  points  to  the  process reading the file system. Each process
>>  subdirectory has the entries listed in Table 1-1.
>>
>> +Note that an open a file descriptor to /proc/<pid> or to any of its
>> +contained files or subdirectories does not prevent <pid> being reused
>> +for some other process in the event that <pid> exits. Operations on
>
> "does not" -> "may not"?
>
> We want to leave this unspecified, so that we can change it in future.

No. "Does not". I'm sick and tired of procfs behavior being vague and
unspecified to the point where even kernel developers have an
incorrect mental model of how it all works. With Christian Brauner's
good work in place and hopefully my own work to follow, we're moving
firmly in the direction of procfs handles being struct pid references.
Instead of waffling further, let's just buy into this model and do the
best job we can of making it work well.
