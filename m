Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751797AbeBWQxY (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Feb 2018 11:53:24 -0500
Received: from mail-qt0-f179.google.com ([209.85.216.179]:34578 "EHLO
        mail-qt0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751460AbeBWQxV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Feb 2018 11:53:21 -0500
X-Google-Smtp-Source: AG47ELuGQ2LzWjEOOkJnCIbKxwAXRdCHoaCLXtO2Pz2amG7cIr1yU12aqHSyB+bE/XuZJNDQCfUmhA==
Date: Fri, 23 Feb 2018 08:53:17 -0800
From: Tejun Heo <tj@kernel.org>
To: Eric Dumazet <eric.dumazet@gmail.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
        netdev <netdev@vger.kernel.org>
Subject: Re: [PATCH] percpu: add a schedule point in pcpu_balance_workfn()
Message-ID: <20180223165317.GD1641506@devbig577.frc2.facebook.com>
References: <1519402362.55655.70.camel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1519402362.55655.70.camel@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 23, 2018 at 08:12:42AM -0800, Eric Dumazet wrote:
> From: Eric Dumazet <edumazet@google.com>
> 
> When a large BPF percpu map is destroyed, I have seen
> pcpu_balance_workfn() holding cpu for hundreds of milliseconds.
> 
> On KASAN config and 112 hyperthreads, average time to destroy a chunk
> is ~4 ms.
> 
> [ 2489.841376] destroy chunk 1 in 4148689 ns
> ...
> [ 2490.093428] destroy chunk 32 in 4072718 ns
> 
> Signed-off-by: Eric Dumazet <edumazet@google.com>

Applied to percpu/for-4.16-fixes.

Thank, Eric.

-- 
tejun
