Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751829AbeBETlN (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Feb 2018 14:41:13 -0500
Received: from mail-wm0-f67.google.com ([74.125.82.67]:51415 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751015AbeBETlF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Feb 2018 14:41:05 -0500
X-Google-Smtp-Source: AH8x224K+pHUli5HCrDvlWzt75FXRCEDMYWH3RgGvY+tZCyfFIywZ92bJEH+GDdqrWWYs9XN2a7/Nw==
Date: Mon, 5 Feb 2018 22:41:01 +0300
From: Alexey Dobriyan <adobriyan@gmail.com>
To: syzbot <syzbot+75334212ef69a07c3209@syzkaller.appspotmail.com>,
        dvyukov@google.com
Cc: akpm@linux-foundation.org, dave@stgolabs.net, dhowells@redhat.com,
        geliangtang@gmail.com, hkallweit1@gmail.com,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        tiwai@suse.de, viro@zeniv.linux.org.uk
Subject: Re: WARNING in proc_register
Message-ID: <20180205194101.GB7593@avx2>
References: <94eb2c0555129c9b0e05647acdba@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <94eb2c0555129c9b0e05647acdba@google.com>
User-Agent: Mutt/1.7.2 (2016-11-26)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 05, 2018 at 09:58:01AM -0800, syzbot wrote:
> proc_dir_entry 'ipt_CLUSTERIP/172.20.0.170' already registered
> WARNING: CPU: 1 PID: 4074 at fs/proc/generic.c:330  

>   proc_create_data+0xf8/0x180 fs/proc/generic.c:494
>   clusterip_config_init net/ipv4/netfilter/ipt_CLUSTERIP.c:250 [inline]

Dima, this warning is never about /proc but always about some other code
registering duplicate /proc entry.

I don't know how easily scriptable is mail sender but you want to look at
the second line in the backtrace.
