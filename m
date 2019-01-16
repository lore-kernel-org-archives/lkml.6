Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68DBEC43387
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 16:56:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2BB15205C9
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 16:56:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="1fohCox4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394376AbfAPQ4F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 11:56:05 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:35540 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388325AbfAPQ4E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 11:56:04 -0500
Received: by mail-ot1-f66.google.com with SMTP id 81so8366511otj.2
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jan 2019 08:56:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=AOAiEL+/8C4L4IM8a4sTEPSnKDCXeMhX5DoT7rtynYE=;
        b=1fohCox49WptNDKFo+AllzPtWzec91m1mOEYaAsgXNjWJ5CrmaNa9SXb+GU646gyK6
         xGBSgpag4ZWSTEcrNG9m7s3X3LpcCMV3xbRiNCDnkwLO2R6TRY3Kh+DggzVmEEJqkjHJ
         TqfvzS03YrEFTp4dz0CNRTv+naEgefc2iCMmLuLVfA518QJ29tTQX+5WkXzMbnSS/8B/
         le/MvXWhdGVuRm9JPOXDOBcJPWMi/LmDtHTNad9kPi8PfuxPUKEorXa7JvmxMsm+rRHl
         MH0lTAKlt/kWuxwvW3nq7KYwnRasqnF8HngMz7KMuJaRReyplTiWix/Uco4cCeFI/jtG
         1m2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=AOAiEL+/8C4L4IM8a4sTEPSnKDCXeMhX5DoT7rtynYE=;
        b=fv2PsOuNDkkdnSD5mNynWi1WlInOGFLwtlnyN73kjbbOQBcoI4cE3dsMf4W+3ZcC/x
         2z+onIVhggpjavDd7gCLafsI2qM06Sdf/ovWpFXfTgJ50+qEe+TrTCfjA9Hn65hPj/VF
         Xkydk8bKCKbb6pJxw3Gc8rP+Rfwjgr26O3MjPU3AXh7BJjqXNt97AbSiYm9pJAzoskQ/
         Qq6xZcJIbrJAWwgZhZKEwVh0drCB6KWJPx7doabR+8znNYJvlTJT1jsSyBtCFqIulhau
         P99RIiKOXXWAVISQcZz/C4I57Gcl3ZIjS23/SDvkSjZYVJ6MDZPxQmslIun9V0VBB39r
         YeeA==
X-Gm-Message-State: AJcUukdKbLFZ0ZnqXyi29t+2FwvQJ+fWJrtp1+WxGmMrCd8yo2Fh6ZAL
        R7Zry2ZU/Hj7xSKs1RQrGKPW8BGCbkC+wHfd6jDZUA==
X-Google-Smtp-Source: ALg8bN5y5OaMHKHunRJ8UPAnFsJvM/MFVlI1THG04lITO1eS6slbD+jeGnS78UFz2u+u9ZNDtte+pMBriGuVYDlLquk=
X-Received: by 2002:a9d:6a50:: with SMTP id h16mr5837069otn.95.1547657763252;
 Wed, 16 Jan 2019 08:56:03 -0800 (PST)
MIME-Version: 1.0
References: <e3c4c0e0-1434-4353-b893-2973c04e7ff7@oracle.com>
 <CAPcyv4j67n6H7hD6haXJqysbaauci4usuuj5c+JQ7VQBGngO1Q@mail.gmail.com>
 <20190111081401.GA5080@hori1.linux.bs1.fc.nec.co.jp> <20190116093046.GA29835@hori1.linux.bs1.fc.nec.co.jp>
In-Reply-To: <20190116093046.GA29835@hori1.linux.bs1.fc.nec.co.jp>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Wed, 16 Jan 2019 08:55:52 -0800
Message-ID: <CAPcyv4jnHqDp7s1SdqHePms2Z-8d0zk-+6meqKeMQUNArxHb_w@mail.gmail.com>
Subject: Re: [PATCH] mm: hwpoison: use do_send_sig_info() instead of
 force_sig() (Re: PMEM error-handling forces SIGKILL causes kernel panic)
To:     Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Jane Chu <jane.chu@oracle.com>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 16, 2019 at 1:33 AM Naoya Horiguchi
<n-horiguchi@ah.jp.nec.com> wrote:
>
> [ CCed Andrew and linux-mm ]
>
> On Fri, Jan 11, 2019 at 08:14:02AM +0000, Horiguchi Naoya(=E5=A0=80=E5=8F=
=A3 =E7=9B=B4=E4=B9=9F) wrote:
> > Hi Dan, Jane,
> >
> > Thanks for the report.
> >
> > On Wed, Jan 09, 2019 at 03:49:32PM -0800, Dan Williams wrote:
> > > [ switch to text mail, add lkml and Naoya ]
> > >
> > > On Wed, Jan 9, 2019 at 12:19 PM Jane Chu <jane.chu@oracle.com> wrote:
> > ...
> > > > 3. The hardware consists the latest revision CPU and Intel NVDIMM, =
we suspected
> > > >    the CPU faulty because it generated MCE over PMEM UE in a unlike=
ly high
> > > >    rate for any reasonable NVDIMM (like a few per 24hours).
> > > >
> > > > After swapping the CPU, the problem stopped reproducing.
> > > >
> > > > But one could argue that perhaps the faulty CPU exposed a small rac=
e window
> > > > from collect_procs() to unmap_mapping_range() and to kill_procs(), =
hence
> > > > caught the kernel  PMEM error handler off guard.
> > >
> > > There's definitely a race, and the implementation is buggy as can be
> > > seen in __exit_signal:
> > >
> > >         sighand =3D rcu_dereference_check(tsk->sighand,
> > >                                         lockdep_tasklist_lock_is_held=
());
> > >         spin_lock(&sighand->siglock);
> > >
> > > ...the memory-failure path needs to hold the proper locks before it
> > > can assume that de-referencing tsk->sighand is valid.
> > >
> > > > Also note, the same workload on the same faulty CPU were run on Lin=
ux prior to
> > > > the 4.19 PMEM error handling and did not encounter kernel crash, pr=
obably because
> > > > the prior HWPOISON handler did not force SIGKILL?
> > >
> > > Before 4.19 this test should result in a machine-check reboot, not
> > > much better than a kernel crash.
> > >
> > > > Should we not to force the SIGKILL, or find a way to close the race=
 window?
> > >
> > > The race should be closed by holding the proper tasklist and rcu read=
 lock(s).
> >
> > This reasoning and proposal sound right to me. I'm trying to reproduce
> > this race (for non-pmem case,) but no luck for now. I'll investigate mo=
re.
>
> I wrote/tested a patch for this issue.
> I think that switching signal API effectively does proper locking.
>
> Thanks,
> Naoya Horiguchi
> ---
> From 16dbf6105ff4831f73276d79d5df238ab467de76 Mon Sep 17 00:00:00 2001
> From: Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>
> Date: Wed, 16 Jan 2019 16:59:27 +0900
> Subject: [PATCH] mm: hwpoison: use do_send_sig_info() instead of force_si=
g()
>
> Currently memory_failure() is racy against process's exiting,
> which results in kernel crash by null pointer dereference.
>
> The root cause is that memory_failure() uses force_sig() to forcibly
> kill asynchronous (meaning not in the current context) processes.  As
> discussed in thread https://lkml.org/lkml/2010/6/8/236 years ago for
> OOM fixes, this is not a right thing to do.  OOM solves this issue by
> using do_send_sig_info() as done in commit d2d393099de2 ("signal:
> oom_kill_task: use SEND_SIG_FORCED instead of force_sig()"), so this
> patch is suggesting to do the same for hwpoison.  do_send_sig_info()
> properly accesses to siglock with lock_task_sighand(), so is free from
> the reported race.
>
> I confirmed that the reported bug reproduces with inserting some delay
> in kill_procs(), and it never reproduces with this patch.
>
> Note that memory_failure() can send another type of signal using
> force_sig_mceerr(), and the reported race shouldn't happen on it
> because force_sig_mceerr() is called only for synchronous processes
> (i.e. BUS_MCEERR_AR happens only when some process accesses to the
> corrupted memory.)
>
> Reported-by: Jane Chu <jane.chu@oracle.com>
> Cc: Dan Williams <dan.j.williams@intel.com>
> Cc: stable@vger.kernel.org
> Signed-off-by: Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>
> ---

Looks good to me.

Reviewed-by: Dan Williams <dan.j.williams@intel.com>

...but it would still be good to get a Tested-by from Jane.
