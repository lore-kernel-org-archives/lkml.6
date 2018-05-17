Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752317AbeEQHmI (ORCPT <rfc822;w@1wt.eu>);
        Thu, 17 May 2018 03:42:08 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:35687 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751644AbeEQHmH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 May 2018 03:42:07 -0400
X-Google-Smtp-Source: AB8JxZqzK87aHL5GbvprLucsrWyqDl9oCLrAeApFG6feEGNEal/WpKx+CRSVnvhVDDwDf3HbeVXcXg==
Date: Thu, 17 May 2018 10:42:02 +0300
From: Alexey Dobriyan <adobriyan@gmail.com>
To: lennart@poettering.net
Cc: tj@kernel.org, torvalds@linux-foundation.org, carlos@redha.com,
        luto@amacapital.net, akpm@linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC] better visibility into kworkers
Message-ID: <20180517074202.GA3091@avx2>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> The kernel APIs for all this aren't really good
> though, and I always was reluctant to check for PF_KTHREAD, as that
> flag is neither documented for userspace, nor available in any
> userspace-accessible headers. However, I wanted to tighten this a bit,
> and hence we now define the flag in our own code, as it appeared to me
> otherwise there was no chance to ever make this fully robust.

PF_KTHREAD was introduced in 2.6.27 and its value appears to be stable
since then. I think it should be retroactively declared part of ABI
otherwise people will continue to rediscover that all other means do not
work.

Empty /proc/*/exe is second best option for systemd and it's only one
system call.
