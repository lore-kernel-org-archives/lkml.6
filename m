Return-Path: <SRS0=6SfI=LH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F08D4C433F5
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 18:47:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9CCA52075C
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 18:47:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tmOU9bkc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9CCA52075C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726842AbeHXWWt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Aug 2018 18:22:49 -0400
Received: from mail-yw1-f41.google.com ([209.85.161.41]:41817 "EHLO
        mail-yw1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726569AbeHXWWt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Aug 2018 18:22:49 -0400
Received: by mail-yw1-f41.google.com with SMTP id q129-v6so3442952ywg.8;
        Fri, 24 Aug 2018 11:46:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=4lIYOQNAJ/SvFT4BpHwj/tw6JnH50j7Nlqzxh6kS2EU=;
        b=tmOU9bkcgkKrddtNAMGJAuKlXnIH87w/pshcyUjZwr613VSWnQCgM0zi7gxM7e60Vk
         JA53FlueFh+/0aJibt5QBDIdz6EDDX9Hev04vOJ3OYrfd9L5Zzma4DlbdDW7syx+0ozO
         qHbZHbLzUGLGv8RACCsDxp7uIfp/F8mI2DuYjV0MiHCkFgJtjY01o0Wa7IfxLkmrxs/B
         lF1YOetwcyTvgkBusDGh7D9rawuVPxi8OmmnDEhKCXUOOMapvd52wTV/Fra/6o/iV1nq
         eYLiuF3b9lLWkNeucSTj/6jEruGp7cf6jZ/DkP9O5wPVfsfaTTj0EUdv9okQGF/2/7Ek
         diVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition:user-agent;
        bh=4lIYOQNAJ/SvFT4BpHwj/tw6JnH50j7Nlqzxh6kS2EU=;
        b=lZiRxGe98G6hDcEO0QEv5BP2n9m2b6XOFsr3gIqQIwpLbWmt0cnmf9OOuIRBeBiTca
         WR0MNjTrsmAW07Gqm0LVIlNi2n96qxts3FbjnAutq7M4NoCZ0DviWhL5FEjrJIfbashA
         r1syIk+7CqRQ+eJx58jUk/K6UhPftVQvNO2Epu9jmWkdv6XChFisb37idizEzEPQrWRv
         GV5J076fhB9tIPu8/4qpTnrB0WfN4LMZnEAkcjET4rlLi9bQK/ZJ+xzoFqnSauw8IEKl
         RN1+fpOXVdj44wUcwjtj94b2KuhXGEQIM8/hRAuSeXoTA956iXH6gOmJYugyyE3MeFph
         1rvA==
X-Gm-Message-State: APzg51B2+Pp/50vAGPU34GrLeiIpCP3qivHqIGBLrBmMmSAfbnKECdkf
        FLa1zhbHRmjpUcsiU8GwtfQ=
X-Google-Smtp-Source: ANB0VdbVmXuRIPlx8jqX4cWTNrBN1+XhGiimRod+jNj/luTMNDTVERXXqS+w9Z7MPMSGz4XboGL/ZQ==
X-Received: by 2002:a0d:e942:: with SMTP id s63-v6mr1790087ywe.504.1535136419153;
        Fri, 24 Aug 2018 11:46:59 -0700 (PDT)
Received: from localhost ([2620:10d:c091:200::3:8925])
        by smtp.gmail.com with ESMTPSA id c126-v6sm3750076ywa.104.2018.08.24.11.46.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 24 Aug 2018 11:46:58 -0700 (PDT)
Date:   Fri, 24 Aug 2018 11:46:56 -0700
From:   Tejun Heo <tj@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Li Zefan <lizefan@huawei.com>,
        Johannes Weiner <hannes@cmpxchg.org>, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [GIT PULL] cgroup changes for v4.19-rc1
Message-ID: <20180824184656.GX3978217@devbig004.ftw2.facebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Just one commit from Steven to take out spin lock from trace event
handlers.

Thanks.

The following changes since commit 1e09177acae32a61586af26d83ca5ef591cdcaf5:

  Merge tag 'mips_fixes_4.18_3' of git://git.kernel.org/pub/scm/linux/kernel/git/mips/linux (2018-07-10 16:18:09 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup.git for-4.19

for you to fetch changes up to e4f8d81c738db6d3ffdabfb8329aa2feaa310699:

  cgroup/tracing: Move taking of spin lock out of trace event handlers (2018-07-11 10:48:47 -0700)

----------------------------------------------------------------
Steven Rostedt (VMware) (1):
      cgroup/tracing: Move taking of spin lock out of trace event handlers

 include/trace/events/cgroup.h   | 47 ++++++++++++++++++++---------------------
 kernel/cgroup/cgroup-internal.h | 26 +++++++++++++++++++++++
 kernel/cgroup/cgroup-v1.c       |  4 ++--
 kernel/cgroup/cgroup.c          | 12 ++++++-----
 4 files changed, 58 insertions(+), 31 deletions(-)

-- 
tejun
