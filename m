Return-Path: <linux-kernel-owner@vger.kernel.org>
Authentication-Results: smtp.codeaurora.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="q99Vup58"
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org BA9CB60764
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752491AbeFFPEo (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Wed, 6 Jun 2018 11:04:44 -0400
Received: from mail-yw0-f194.google.com ([209.85.161.194]:35201 "EHLO
        mail-yw0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752322AbeFFPEm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jun 2018 11:04:42 -0400
X-Google-Smtp-Source: ADUXVKIFe077I1c8/DA/3G+pOIItv+7SshjxWq//VO15PSKH76qIbqVtpwUyS7+kj/JTSnnk7EINWQ==
Date: Wed, 6 Jun 2018 08:04:38 -0700
From: Tejun Heo <tj@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Li Zefan <lizefan@huawei.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        cgroups <cgroups@vger.kernel.org>
Subject: Re: [GIT PULL] cgroup changes for v4.18-rc1
Message-ID: <20180606150438.GM1351649@devbig577.frc2.facebook.com>
References: <20180605192157.GG1351649@devbig577.frc2.facebook.com>
 <CA+55aFzWdPavAPC--MY15RgwvU1QYgF+Uy7rMJmx2Dr3ddJdsQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+55aFzWdPavAPC--MY15RgwvU1QYgF+Uy7rMJmx2Dr3ddJdsQ@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, Linus.

On Tue, Jun 05, 2018 at 05:13:55PM -0700, Linus Torvalds wrote:
> On Tue, Jun 5, 2018 at 12:22 PM Tejun Heo <tj@kernel.org> wrote:
> >
> > * cgroup uses file modified events to notify certain events.  A rate
> >   limiting mechanism is added.
> 
> This "explanation" didn't really parse for me at all.
>
> I edited the merge message to something that I think is correct and
> made more sense to me.

Heh, yeah, yours reads a lot better.  Sorry about that.  The
background is that the mechanism was first added to generate
notifications on events like cgroup becoming empty, which is very low
frequency.  Since then, we've expanded its usage to cover things like
memory.high breached events which can be a lot higher frequency.

The notification implementation isn't super light weight, so the patch
ratelimits the notifications by capping minimum notification interval
interval to 10ms.

Thanks.

-- 
tejun
