Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753399AbeD2MQg (ORCPT <rfc822;w@1wt.eu>);
        Sun, 29 Apr 2018 08:16:36 -0400
Received: from mga01.intel.com ([192.55.52.88]:34543 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752875AbeD2MQf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Apr 2018 08:16:35 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,343,1520924400";
   d="scan'208";a="46935336"
Date: Sun, 29 Apr 2018 20:16:31 +0800
From: Fengguang Wu <fengguang.wu@intel.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Network Development <netdev@vger.kernel.org>,
        David Miller <davem@davemloft.net>, xiaolou4617@gmail.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        LKP <lkp@01.org>
Subject: Re: [llc_ui_release] BUG: unable to handle kernel NULL pointer
 dereference at 0000000000000004
Message-ID: <20180429121631.fd2qf2scjdjmjvnh@wfg-t540p.sh.intel.com>
References: <20180429021235.vibzosv34t264nbs@wfg-t540p.sh.intel.com>
 <CA+55aFzeCvwUw=yi5oDy2ouv7onkXDapgamJJ5AhjybyBH8UCw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <CA+55aFzeCvwUw=yi5oDy2ouv7onkXDapgamJJ5AhjybyBH8UCw@mail.gmail.com>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 29, 2018 at 03:30:48AM +0000, Linus Torvalds wrote:
>On Sat, Apr 28, 2018 at 7:12 PM Fengguang Wu <fengguang.wu@intel.com> wrote:
>
>> FYI this happens in mainline kernel 4.17.0-rc2.
>> It looks like a new regression.
>
>> It occurs in 5 out of 5 boots.
>
>> [main] 375 sockets created based on info from socket cachefile.
>> [main] Generating file descriptors
>> [main] Added 83 filenames from /dev
>> udevd[507]: failed to execute '/sbin/modprobe' '/sbin/modprobe -bv
>platform:regulatory': No such file or directory
>> [  372.057947] caif:caif_disconnect_client(): nothing to disconnect
>> [  372.082415] BUG: unable to handle kernel NULL pointer dereference at
>0000000000000004
>
>I think this is fixed by commit 3a04ce7130a7 ("llc: fix NULL pointer deref
>for SOCK_ZAPPED")

Confirmed. Sorry for the late report!

Regards,
Fengguang
