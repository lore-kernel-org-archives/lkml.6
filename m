Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751836AbeBBCvI (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Feb 2018 21:51:08 -0500
Received: from mx1.redhat.com ([209.132.183.28]:51558 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751611AbeBBCuu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Feb 2018 21:50:50 -0500
Date: Fri, 2 Feb 2018 04:50:42 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
To: =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>
Cc: linux-kernel@vger.kernel.org, slp@redhat.com, bhe@redhat.com,
        somlo@cmu.edu, xiaolong.ye@intel.com
Subject: Re: [PATCH v11 0/4] fw_cfg: add DMA operations & etc/vmcoreinfo
 support
Message-ID: <20180202044841-mutt-send-email-mst@kernel.org>
References: <20180201130300.9962-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180201130300.9962-1-marcandre.lureau@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 01, 2018 at 02:02:56PM +0100, Marc-André Lureau wrote:
> Hi,
> 
> This series adds DMA operations support to the qemu fw_cfg kernel
> module and populates "etc/vmcoreinfo" with vmcoreinfo location
> details (since qemu 2.11).

At this point you need to scope this down significantly.  I'll give the
vmcore one more chance in this release if you test the hell out of it with 32 and 64 bit
guests and repost tomorrow with just the vmcore enabled and that ASAP,
and without kmalloc on crash which is problematic by itself.

> v11:
> - add #include <linux/crash_core.h> in last patch,
>   fixing kbuild .config test
> 
> Marc-André Lureau (4):
>   fw_cfg: add DMA register
>   fw_cfg: do DMA read operation
>   crash: export paddr_vmcoreinfo_note()
>   fw_cfg: write vmcoreinfo details
> 
>  drivers/firmware/qemu_fw_cfg.c | 268 ++++++++++++++++++++++++++++++++++++-----
>  kernel/crash_core.c            |   1 +
>  2 files changed, 237 insertions(+), 32 deletions(-)
> 
> -- 
> 2.16.0.rc1.1.gef27df75a1
