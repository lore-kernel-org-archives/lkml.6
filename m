Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752305AbeENDPO (ORCPT <rfc822;w@1wt.eu>);
        Sun, 13 May 2018 23:15:14 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:46354 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752280AbeENDPM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 May 2018 23:15:12 -0400
Date: Mon, 14 May 2018 04:15:09 +0100
From: Al Viro <viro@ZenIV.linux.org.uk>
To: Ian Kent <raven@themaw.net>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        autofs mailing list <autofs@vger.kernel.org>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 01/10] autofs4 - merge auto_fs.h and auto_fs4.h
Message-ID: <20180514031509.GC30522@ZenIV.linux.org.uk>
References: <152626703024.28589.9571964661718767929.stgit@pluto.themaw.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <152626703024.28589.9571964661718767929.stgit@pluto.themaw.net>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 14, 2018 at 11:03:50AM +0800, Ian Kent wrote:
> The autofs module has long since been removed so there's no need to have
> two separate include files for autofs.

Umm...  Why does fs/compat_ioctl.c need either include, actually?

> --- a/fs/compat_ioctl.c
> +++ b/fs/compat_ioctl.c
> @@ -39,7 +39,6 @@
>  #include <linux/if_pppox.h>
>  #include <linux/mtio.h>
>  #include <linux/auto_fs.h>
> -#include <linux/auto_fs4.h>
>  #include <linux/tty.h>
>  #include <linux/vt_kern.h>
>  #include <linux/fb.h>

AFAICS, we can just delete both.  Matter of fact, a *lot* of those includes are
pointless nowadays...
