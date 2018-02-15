Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1166902AbeBOSwK (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Feb 2018 13:52:10 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:40776 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1162019AbeBOSwG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Feb 2018 13:52:06 -0500
Date: Thu, 15 Feb 2018 18:52:04 +0000
From: Al Viro <viro@ZenIV.linux.org.uk>
To: Enrico Weigelt <lkml@metux.net>
Cc: Richard Weinberger <richard.weinberger@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: fs_struct refcounting: spinlock vs atomic
Message-ID: <20180215185204.GD30522@ZenIV.linux.org.uk>
References: <7547a9ed-a2e7-e975-a3ba-f41abc16f4bc@metux.net>
 <CAFLxGvz2t8rnEQh4VBJ8v3b66GKA5DY3iMk33jnMP664+RMubw@mail.gmail.com>
 <9cc188a2-406e-bf7c-e769-e982735ba5b6@metux.net>
 <20180215183956.GC30522@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180215183956.GC30522@ZenIV.linux.org.uk>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 15, 2018 at 06:39:57PM +0000, Al Viro wrote:

> Not true.  We also assume that once fs_struct has been locked, the number of
> tasks with reference to it won't change.  See fs/exec.c:check_unsafe_exec(),
> for example.

PS: any discussion of VFS and filesystems stuff belongs on fsdevel; Cc to l-k
is fine, but don't expect anyone to be able to reliably spot it there.

l-k is far too high volume (and low S/N) to keep up with it; some of us have
entirely given up on it (Linus is certainly not the only one who'd unsubscribed
from l-k many years ago), some try to scan it for something relevant, but
latency and reliability of such scans inevitably sucks.
