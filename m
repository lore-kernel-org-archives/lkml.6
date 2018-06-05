Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751699AbeFEL0o (ORCPT <rfc822;w@1wt.eu>);
        Tue, 5 Jun 2018 07:26:44 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:59858 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751599AbeFEL0n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jun 2018 07:26:43 -0400
Date: Tue, 5 Jun 2018 12:26:41 +0100
From: Al Viro <viro@ZenIV.linux.org.uk>
To: Ilya Matveychikov <matvejchikov@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] ksys_mount: check for permissions before resource
 allocation
Message-ID: <20180605112641.GN30522@ZenIV.linux.org.uk>
References: <D2317950-0DB0-4311-ADB1-FF677B676E04@gmail.com>
 <BD48252B-65D7-4238-BDA2-71BAC1CEA855@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <BD48252B-65D7-4238-BDA2-71BAC1CEA855@gmail.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 05, 2018 at 10:59:51AM +0400, Ilya Matveychikov wrote:
> Just CC’ed to some of maintainers.
> 
> $ perl scripts/get_maintainer.pl fs/0001-ksys_mount-check-for-permissions-before-resource-all.patch
> Alexander Viro <viro@zeniv.linux.org.uk> (maintainer:FILESYSTEMS (VFS and infrastructure))
> linux-fsdevel@vger.kernel.org (open list:FILESYSTEMS (VFS and infrastructure))
> linux-kernel@vger.kernel.org (open list)
> 
> > On Jun 5, 2018, at 6:00 AM, Ilya Matveychikov <matvejchikov@gmail.com> wrote:
> > 
> > Early check for mount permissions prevents possible allocation of 3
> > pages from kmalloc() pool by unpriveledged user which can be used for
> > spraying the kernel heap.

I'm sorry, but there are arseloads of unpriveleged syscalls that do the same,
starting with read() from procfs files.  So what the hell does it buy?
