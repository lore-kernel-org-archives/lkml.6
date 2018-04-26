Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754777AbeDZVfT (ORCPT <rfc822;w@1wt.eu>);
        Thu, 26 Apr 2018 17:35:19 -0400
Received: from mail-yb0-f196.google.com ([209.85.213.196]:35735 "EHLO
        mail-yb0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753708AbeDZVfR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Apr 2018 17:35:17 -0400
X-Google-Smtp-Source: AIpwx4/H2MtsXvPKPLEZcV1/t4ZLKuMqmAOqsMPnkdhQYubjb9Qrz3x+7iWds1WVrA42lrYwRqBCVw==
Date: Thu, 26 Apr 2018 14:35:14 -0700
From: Tejun Heo <tj@kernel.org>
To: Li Zefan <lizefan@huawei.com>, Johannes Weiner <hannes@cmpxchg.org>
Cc: cgroups@vger.kernel.org, kernel-team@fb.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH cgroup/for-4.17 2/2] Subject: cgroup: Limit event
 generation frequency
Message-ID: <20180426213514.GV1911913@devbig577.frc2.facebook.com>
References: <20180323194722.GE2149215@devbig577.frc2.facebook.com>
 <20180323194753.GF2149215@devbig577.frc2.facebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180323194753.GF2149215@devbig577.frc2.facebook.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 23, 2018 at 12:47:53PM -0700, Tejun Heo wrote:
> ".events" files generate file modified event to notify userland of
> possible new events.  Some of the events can be quite bursty
> (e.g. memory high event) and generating notification each time is
> costly and pointless.
> 
> This patch implements a event rate limit mechanism.  If a new
> notification is requested before 10ms has passed since the previous
> notification, the new notification is delayed till then.
> 
> As this only delays from the second notification on in a given close
> cluster of notifications, userland reactions to notifications
> shouldn't be delayed at all in most cases while avoiding notification
> storms.
> 
> Signed-off-by: Tejun Heo <tj@kernel.org>

Applied 1-2 to cgroup/for-4.18.

Thanks.

-- 
tejun
