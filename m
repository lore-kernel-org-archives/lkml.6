Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752331AbeD2DbB (ORCPT <rfc822;w@1wt.eu>);
        Sat, 28 Apr 2018 23:31:01 -0400
Received: from mail-io0-f169.google.com ([209.85.223.169]:35011 "EHLO
        mail-io0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751671AbeD2Da7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Apr 2018 23:30:59 -0400
X-Google-Smtp-Source: AB8JxZorhT/mlly1RpHx6uYghumJ5q2tme006QmLQigQ3UuzoZsWwk4K4AumrGqToc7yklUUBkw5/XORZxwQfkI7nZs=
MIME-Version: 1.0
References: <20180429021235.vibzosv34t264nbs@wfg-t540p.sh.intel.com>
In-Reply-To: <20180429021235.vibzosv34t264nbs@wfg-t540p.sh.intel.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sun, 29 Apr 2018 03:30:48 +0000
Message-ID: <CA+55aFzeCvwUw=yi5oDy2ouv7onkXDapgamJJ5AhjybyBH8UCw@mail.gmail.com>
Subject: Re: [llc_ui_release] BUG: unable to handle kernel NULL pointer
 dereference at 0000000000000004
To: Wu Fengguang <fengguang.wu@intel.com>
Cc: Network Development <netdev@vger.kernel.org>,
        David Miller <davem@davemloft.net>, xiaolou4617@gmail.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        LKP <lkp@01.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 28, 2018 at 7:12 PM Fengguang Wu <fengguang.wu@intel.com> wrote:

> FYI this happens in mainline kernel 4.17.0-rc2.
> It looks like a new regression.

> It occurs in 5 out of 5 boots.

> [main] 375 sockets created based on info from socket cachefile.
> [main] Generating file descriptors
> [main] Added 83 filenames from /dev
> udevd[507]: failed to execute '/sbin/modprobe' '/sbin/modprobe -bv
platform:regulatory': No such file or directory
> [  372.057947] caif:caif_disconnect_client(): nothing to disconnect
> [  372.082415] BUG: unable to handle kernel NULL pointer dereference at
0000000000000004

I think this is fixed by commit 3a04ce7130a7 ("llc: fix NULL pointer deref
for SOCK_ZAPPED")

                Liunus
