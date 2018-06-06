Return-Path: <linux-kernel-owner@vger.kernel.org>
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="Kq1hKLkw"
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org B22FC606DD
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752480AbeFFPOm (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Wed, 6 Jun 2018 11:14:42 -0400
Received: from mail-io0-f195.google.com ([209.85.223.195]:36441 "EHLO
        mail-io0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752348AbeFFPOj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jun 2018 11:14:39 -0400
X-Google-Smtp-Source: ADUXVKKXPKjNbHbFltUdyEb4/izirGNUM/iVsHD4hvaPjZyEeGpvA1ZuzVTR0N+Sus09YlUetOsLEojNLxKa5QJl5UM=
MIME-Version: 1.0
References: <20180605192157.GG1351649@devbig577.frc2.facebook.com>
 <CA+55aFzWdPavAPC--MY15RgwvU1QYgF+Uy7rMJmx2Dr3ddJdsQ@mail.gmail.com> <20180606150438.GM1351649@devbig577.frc2.facebook.com>
In-Reply-To: <20180606150438.GM1351649@devbig577.frc2.facebook.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 6 Jun 2018 08:14:27 -0700
Message-ID: <CA+55aFy=a3nm+r7462mLq4D6eDxDsPXUO3_tviT=DqJPsohx5A@mail.gmail.com>
Subject: Re: [GIT PULL] cgroup changes for v4.18-rc1
To: Tejun Heo <tj@kernel.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Li Zefan <lizefan@huawei.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        cgroups <cgroups@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 6, 2018 at 8:04 AM Tejun Heo <tj@kernel.org> wrote:
>
> The notification implementation isn't super light weight, so the patch
> ratelimits the notifications by capping minimum notification interval
> interval to 10ms.

Yeah, I looked at the patch (and the code) to make sense of the explanation.

My reaction to that was that it might be a better idea to simply not
notify if a notification was already pending, rather than have the
timeout. Or perhaps in addition to. The path _to_ the fsnotify code
looked quite messy, though.

             Linus
