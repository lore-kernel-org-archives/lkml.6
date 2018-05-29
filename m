Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S968150AbeE2WZ3 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 29 May 2018 18:25:29 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:50273 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S968149AbeE2WYy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 May 2018 18:24:54 -0400
Date: Tue, 29 May 2018 19:24:47 -0300
From: Thadeu Lima de Souza Cascardo <cascardo@canonical.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>, stable@vger.kernel.org
Subject: Re: [PATCH] fs/binfmt_misc.c: do not allow offset overflow
Message-ID: <20180529222445.GD4441@calabresa>
References: <20180529135648.14254-1-cascardo@canonical.com>
 <20180529150854.f87fa3d65b9cdc0386672b1d@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180529150854.f87fa3d65b9cdc0386672b1d@linux-foundation.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 29, 2018 at 03:08:54PM -0700, Andrew Morton wrote:
> On Tue, 29 May 2018 10:56:48 -0300 Thadeu Lima de Souza Cascardo <cascardo@canonical.com> wrote:
> 
> > It's possible to overflow the offset to get a negative value, which might
> > crash the system, or possibly leak kernel data.
> 
> I think the missing information here is "when registering a new
> binfmt_misc binary type", yes?
> 

Yes, when registering a new type.

[...]
> > Cc: stable@vger.kernel.org
> 
> Registering a handler is a priveleged operation.  As such, I don't
> think a -stable backport is needed?
> 

Not when we take containers in mind. We might question the permission to mount
a binfmt_misc inside a container, that may already have left open other ways of
exploiting the system. But I would rather see this closed on my stable systems.

Cascardo.
