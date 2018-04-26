Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756989AbeDZVgc (ORCPT <rfc822;w@1wt.eu>);
        Thu, 26 Apr 2018 17:36:32 -0400
Received: from mail-yb0-f196.google.com ([209.85.213.196]:33672 "EHLO
        mail-yb0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754728AbeDZVga (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Apr 2018 17:36:30 -0400
X-Google-Smtp-Source: AB8JxZq+LWCJhLVqDxiM3kCzcXITmAxPThvIOXF+xYMeDLyWVKarQ84i5buJMU1aBZw90Ld5ZKQMjw==
Date: Thu, 26 Apr 2018 14:36:27 -0700
From: Tejun Heo <tj@kernel.org>
To: lizefan@huawei.com, hannes@cmpxchg.org
Cc: cgroups@vger.kernel.org, linux-kernel@vger.kernel.org, guro@fb.com,
        kernel-team@fb.com
Subject: Re: [PATCH] cgroup: Make cgroup_rstat_updated() ready for root
 cgroup usage
Message-ID: <20180426213627.GX1911913@devbig577.frc2.facebook.com>
References: <20180323231313.1254142-1-tj@kernel.org>
 <20180402214913.GH388343@devbig577.frc2.facebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180402214913.GH388343@devbig577.frc2.facebook.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 02, 2018 at 02:49:13PM -0700, Tejun Heo wrote:
> From b7be022bf811d02605098fa61b7545bc146b78e7 Mon Sep 17 00:00:00 2001
> From: Tejun Heo <tj@kernel.org>
> Date: Mon, 2 Apr 2018 14:45:20 -0700
> 
> cgroup_rstat_updated() ensures that the cgroup's rstat is linked to
> the parent.  If there's no parent, it never gets linked and the
> function ends up grabbing and releasing the cgroup_rstat_lock each
> time for no reason which can be expensive.
> 
> This hasn't been a problem till now because nobody was calling the
> function for the root cgroup but rstat is gonna be exposed to
> controllers and use cases, so let's get ready.  Make
> cgroup_rstat_updated() an no-op for the root cgroup.
> 
> Signed-off-by: Tejun Heo <tj@kernel.org>

Applied to cgroup/for-4.18.

Thanks.

-- 
tejun
