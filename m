Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0327C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 14:27:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ADDA821479
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 14:27:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M2tigcFW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ADDA821479
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730562AbeKVBCI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Nov 2018 20:02:08 -0500
Received: from mail-ed1-f68.google.com ([209.85.208.68]:45369 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726849AbeKVBCH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Nov 2018 20:02:07 -0500
Received: by mail-ed1-f68.google.com with SMTP id d39so5011005edb.12;
        Wed, 21 Nov 2018 06:27:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=34QTK7OeG1TZywdi1Tg4zHkVOpYjEGspENTdEZheEyM=;
        b=M2tigcFW240lX227EHTuCKKAMFHhLYO5UMQJdpXtOAzHhQaoFmPCLAP6iPS+WN7v06
         DRDs7ioEZ7eEXawBnrA84ST7Kqizu4xNb8KRWx1z1U0rya83pYyuh0i0ppHr1oa78x2I
         BJS3B0Wjdq+Qlf3zm54nM8e53WYx9hCtdL3apm7TGsourckflNDUFjVUrj84+hE5Gwn9
         ObWvIXIUxwAh4sxd2ijkoIAvjmSn1RFxlSn5jkdfKXJUxtiB2+wwUxUUxegUXBo5IFVn
         UUl1t4Q4KNCotMW8HmZdb0AXPQ4ky+Agbi045pNgvIe0ZtxlHhN+5CzO/14Rtij+l8MT
         UGrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=34QTK7OeG1TZywdi1Tg4zHkVOpYjEGspENTdEZheEyM=;
        b=XgFFr1D/7phWPWsKmnZC7vita+I9fZPnzzIL1yQjSkR8uvz+6Gm62j2MyItt6JuKcT
         TrtNlE44NHBTwzFJmOz1OlHxb58Mtl5yyfV5lr9Fqd/xgQLkTORQyPiHEy9LNmQbXGWL
         eVodIPZlWa95sNlwDoLZx1TXQCYMF2BsUb3FgiB8Z4+JH+mGlgoNjkDjLkidXP2WxaEO
         Rgv4/6oHYFR0/36BAAsCM28Be0LeOSnK7OSSobgu3dN29afsDscuhQXDGQAYqZeCxEp8
         HWVrdbTpLATF2nS3jeMu1W4bGziXQoGIS0rboyTWr/Bi2F3QKit3hLWESvOyqVGBT61x
         7pfA==
X-Gm-Message-State: AA+aEWZj1jtDmUnReCHa1Tx7u3wTAonmn56l4eqI9E+/xbg5x5/qc8O1
        oYFpn0qsZoGb1dus6aWxnsMRYL3leAJwiXWbKvo=
X-Google-Smtp-Source: AJdET5fQ4SDn98F98bDRE2AB5ymTwxhilkbMOzYjS2JVU1/VsNJZzdK+g67K3CLFgstQMk8iAQrsn/VqHv2nRAb3Vfc=
X-Received: by 2002:a17:906:d054:: with SMTP id bo20-v6mr5246163ejb.239.1542810447094;
 Wed, 21 Nov 2018 06:27:27 -0800 (PST)
MIME-Version: 1.0
References: <1542736289-31338-1-git-send-email-longman@redhat.com>
In-Reply-To: <1542736289-31338-1-git-send-email-longman@redhat.com>
From:   Michael Kerrisk <mtk.manpages@gmail.com>
Date:   Wed, 21 Nov 2018 15:27:15 +0100
Message-ID: <CAHO5Pa1axpoweQuO7A9K2yv+HvSkVXCkXS5f6Ag3fA1_SjPcuA@mail.gmail.com>
Subject: Re: [PATCH v4 0/5] cgroup: Introducing bypass mode
To:     longman@redhat.com
Cc:     Tejun Heo <tj@kernel.org>, lizefan@huawei.com,
        Johannes Weiner <hannes@cmpxchg.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>, cgroups@vger.kernel.org,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        linux-doc <linux-doc@vger.kernel.org>, guro@fb.com,
        axboe@kernel.dk, Andrew Morton <akpm@linux-foundation.org>,
        dennis@kernel.org, shakeelb@google.com,
        Linux API <linux-api@vger.kernel.org>,
        Michael Kerrisk <mtk.manpages@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[CC += linux-api@vger.kernel.org]

Hi Waiman,

Since this is a kernel-user-space API change, for all future
iterations of this patch, please CC linux-api@.

The kernel source file Documentation/SubmitChecklist notes that all
Linux kernel patches that change userspace interfaces should be CCed
to linux-api@vger.kernel.org, so that the various parties who are
interested in API changes are informed. For further information, see
https://www.kernel.org/doc/man-pages/linux-api-ml.html

Thanks,

Michael
On Tue, Nov 20, 2018 at 8:45 PM Waiman Long <longman@redhat.com> wrote:
>
>  v4:
>   - Rebased to the latest for-4.21 branch of cgroup tree.
>   - Make each controller explicitly opt in to become bypassable by
>     setting the bypassable cgroup_subsys flag. Currently, only cpu
>     controller is made bypassable.
>   - Break out the cgroup_v2.rst documentation update as separate patch.
>
>  v3:
>   - Remove invalid cgroup subdirectory creation patch.
>   - Add use cases for the bypass mode and removing statements about
>     control files ownership in cgroup-v2.txt.
>   - Restrict bypass mode to non-domain (threaded) controllers only.
>
>  v3 patch - https://lkml.org/lkml/2017/8/9/604
>
> This patchset introduces a new bypass mode to the cgroup v2 core to
> give more freedom and flexibility to controllers which choose to become
> bypassable the freedom to shape their own unique views of the virtual
> cgroup hierarchies that can best suit thier own use cases.
>
> Because of the inherent performance overhead in enabling cpu controller,
> it is made bypassable so that the controller only needs to be enabled
> at those cgroups that really need it instead of in every cgroups at a
> given layer if at least one of them needs it.
>
> The cpu controller performance problem is one of the major issues
> in migrating from cgroup v1 to v2.
>
> For example,
>
>   R - A(+) - B(#) - C(+)
>                   \ D(#)
>
> where "+" means the controller is enabled and "#" means the controller
> is bypassed. For this controller's perspective, the cgroups are
> equivalent to:
>
>   R - A|B|D - C
>
> Underneath the root R, cgoups A, B and D are controlled by one set of
> knobs and cgroup C is controlled by another set of knobs as a child of
> cgroups A|B|C.
>
> This patchset is layered on top of the "for-4.21" branch of Tejun's
> cgroup git tree.
>
> Patch 1 introduces a new bypass mode that allows a bypassable
> controller to be disabled in a cgroup, but to be re-enabled again in its
> children. This is enabled by writing the controller name prefixed with
> '#' to the "cgroup.subtree_control" file. Then all its children will
> have this controller in bypass mode.
>
> Patch 2 extends the bypass mode mechanism to allow those child cgroups
> that are put into the bypass mode for a particular bypassable controller
> by their parent to be re-enabled again by writing the controller name
> with the '+' prefix to the "cgroup.controllers" file.
>
> Patch 3 extends the debug controller to expose additional controller
> masks introduced by this patchset.
>
> Patch 4 makes the cpu controller bypassable.
>
> Patch 5 documents the new bypass mode in cgroup-v2.rst file.
>
> Waiman Long (5):
>   cgroup: subtree_control bypass mode for bypassable controllers
>   cgroup: Allow reenabling of controller in bypass mode
>   cgroup: Make debug controller report new controller masks
>   sched/core: Make cpu cgroup controller bypassable
>   cgroup: Document bypass mode
>
>  Documentation/admin-guide/cgroup-v2.rst |  66 +++++---
>  include/linux/cgroup-defs.h             |  26 +++-
>  kernel/cgroup/cgroup.c                  | 256 +++++++++++++++++++++++++-------
>  kernel/cgroup/debug.c                   |   2 +
>  kernel/sched/core.c                     |   1 +
>  5 files changed, 276 insertions(+), 75 deletions(-)
>
> --
> 1.8.3.1
>


-- 
Michael Kerrisk Linux man-pages maintainer;
http://www.kernel.org/doc/man-pages/
Author of "The Linux Programming Interface", http://blog.man7.org/
