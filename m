Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6F91C4161D
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 16:37:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7025F204FD
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 16:37:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bTmh6Lie"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7025F204FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730002AbeKUDHX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 22:07:23 -0500
Received: from mail-qk1-f195.google.com ([209.85.222.195]:39458 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726243AbeKUDHX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 22:07:23 -0500
Received: by mail-qk1-f195.google.com with SMTP id q70so3204036qkh.6
        for <linux-kernel@vger.kernel.org>; Tue, 20 Nov 2018 08:37:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=W4G16yYEKxuiLGGqPZ/spDOvHty0DanvYfCipwMzgm0=;
        b=bTmh6LieD+FvZkomC4SuYevLJFEXF5A5p4Jh5iFgx7VdjSdQFSpbqBT3CfowwCkBnt
         AonXRRVAFg94QT0Dd7z1Mx63vdDi3V4TG8bZfATMySL1dnlrIhK61HmosxAsBVmKHZXI
         VnHms7t/O0wEtT+H77cFvYS+2rSTL0+nuXEU8NyUw+MiFNgiEATYDEMy6kKpnq+Pa3dz
         eH5CQrlX3Q7Wq+oVLuhuDRm7yzSD4l1Xj22lSgQyFNHNbpjya3iprQ263U7pN1lkb7Qm
         6Fcd2PMEcRr7z0OOzIyGCCDCkbJ0qqhjEyecMfFNecDz25sLnMQ+XyF54Jq+b+bU147I
         4dkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=W4G16yYEKxuiLGGqPZ/spDOvHty0DanvYfCipwMzgm0=;
        b=qhUDwj/n9d5H2/l6guAr/MxK0RfXRUCnf6acUm6IJmvyQN43l5JvUhd37bd2XP/qE/
         JfKAzlb4g9/IgW1MzbOUcuDYP/N6S0lV4pc1oiDllxWD6iQX2ymNEAGZ4YcD66JFTtEE
         /mTlkuzAkevHX0HTlZpADIJUFsB6C04KP75s7aNmAbaRafDKE8niXI3BbKAjQRr3e15a
         GfTkCxRQn6jn1Ov9eABgaXqmG+DOCD7sm/Xy5Aq7o4tEJPLE7zsHma9lwFv2EIY5MsRz
         C01GzQIKvLZrwtDhfqBRWg0XHgsjMujw/lFJRL+wdiIytL05c8Ppk67JOgrEZIixrFvU
         5f0g==
X-Gm-Message-State: AA+aEWaQ1/+vDit+ow/sTWOHu6+75kCVjqtzGBxo5CmzcAs9AV+Z6RTW
        cUVKfgydFnQQImIQJJ4CvhFFIZKZ65BtEq3VqfqJxA==
X-Google-Smtp-Source: AFSGD/Wu9+CcxOuFNCTc+8pabEuCvaVcn1TGNahb0QR5837PJaAN+r9HWgeZjbnuJ2Q/DMBiP5QHb+G3pyyoryKbisk=
X-Received: by 2002:a37:10cf:: with SMTP id 76mr2315147qkq.99.1542731841261;
 Tue, 20 Nov 2018 08:37:21 -0800 (PST)
MIME-Version: 1.0
References: <20181031150625.147369-1-dancol@google.com> <20181105132205.138695-1-dancol@google.com>
 <20181119105426.GD28607@amd> <1c5caa66-3c61-cb57-754a-f099200c73b2@suse.cz>
In-Reply-To: <1c5caa66-3c61-cb57-754a-f099200c73b2@suse.cz>
From:   Joel Fernandes <joelaf@google.com>
Date:   Tue, 20 Nov 2018 08:37:09 -0800
Message-ID: <CAJWu+orh1imt2iNWQeF+o=uZ-4W=sp4TRzZGi+cO8SectEa0vQ@mail.gmail.com>
Subject: Re: [PATCH v2] Document /proc/pid PID reuse behavior
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     pavel@ucw.cz, Daniel Colascione <dancol@google.com>,
        LKML <linux-kernel@vger.kernel.org>, rppt@linux.ibm.com,
        Tim Murray <timmurray@google.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Andrew Morton <akpm@linux-foundation.org>, guro@fb.com,
        rppt@linux.vnet.ibm.com, kirill.shutemov@linux.intel.com,
        dennisszhou@gmail.com, pdhamdhe@redhat.com,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 20, 2018 at 1:05 AM Vlastimil Babka <vbabka@suse.cz> wrote:
>
> On 11/19/18 11:54 AM, Pavel Machek wrote:
> > On Mon 2018-11-05 13:22:05, Daniel Colascione wrote:
> >> State explicitly that holding a /proc/pid file descriptor open does
> >> not reserve the PID. Also note that in the event of PID reuse, these
> >> open file descriptors refer to the old, now-dead process, and not the
> >> new one that happens to be named the same numeric PID.
> >>
> >> Signed-off-by: Daniel Colascione <dancol@google.com>
> >> ---
> >>  Documentation/filesystems/proc.txt | 7 +++++++
> >>  1 file changed, 7 insertions(+)
> >>
> >> Moved paragraphed to start of /proc/pid section; added signed-off-by.
> >>
> >> diff --git a/Documentation/filesystems/proc.txt b/Documentation/filesystems/proc.txt
> >> index 12a5e6e693b6..0b14460f721d 100644
> >> --- a/Documentation/filesystems/proc.txt
> >> +++ b/Documentation/filesystems/proc.txt
> >> @@ -125,6 +125,13 @@ process running on the system, which is named after the process ID (PID).
> >>  The link  self  points  to  the  process reading the file system. Each process
> >>  subdirectory has the entries listed in Table 1-1.
> >>
> >> +Note that an open a file descriptor to /proc/<pid> or to any of its
> >> +contained files or subdirectories does not prevent <pid> being reused
> >> +for some other process in the event that <pid> exits. Operations on
> >
> > "does not" -> "may not"?
> >
> > We want to leave this unspecified, so that we can change it in future.
>
> Why can't the documentation describe the current implementation, and
> change in the future if the implementation changes? I doubt somebody
> would ever rely on the pid being reused while having the descriptor
> open. How would that make sense?
>

Agreed. I am also of the opinion that this should be documented.

 - Joel
