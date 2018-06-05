Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751804AbeFEJIr (ORCPT <rfc822;w@1wt.eu>);
        Tue, 5 Jun 2018 05:08:47 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:36450 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751671AbeFEJIn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jun 2018 05:08:43 -0400
Date: Tue, 5 Jun 2018 11:08:36 +0200
From: Stefano Brivio <sbrivio@redhat.com>
To: kernel test robot <xiaolong.ye@intel.com>
Cc: Steffen Klassert <steffen.klassert@secunet.com>,
        Xin Long <lucien.xin@gmail.com>, LKML <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>, lkp@01.org
Subject: Re: [lkp-robot] [vti6]  b4331a6818:
 kernel_selftests.net.pmtu.sh.fail
Message-ID: <20180605110836.4307eb3c@epycfail>
In-Reply-To: <20180605070927.GN16472@yexl-desktop>
References: <20180605070927.GN16472@yexl-desktop>
Organization: Red Hat
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 5 Jun 2018 15:09:27 +0800
kernel test robot <xiaolong.ye@intel.com> wrote:

> FYI, we noticed the following commit (built with gcc-7):
> 
> commit: b4331a681822b420511b3258f1c3db35001fde48 ("vti6: Change minimum MTU to IPV4_MIN_MTU, vti6 can carry IPv4 too")
> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master
>
> [...]
>
> caused below changes (please refer to attached dmesg/kmsg for entire log/backtrace):
> 
> 
> selftests: pmtu.sh
> ========================================
> TEST: vti6: PMTU exceptions                                         [ OK ]
> TEST: vti4: PMTU exceptions                                         [ OK ]
> TEST: vti4: default MTU assignment                                  [ OK ]
> TEST: vti6: default MTU assignment                                  [ OK ]
> TEST: vti4: MTU setting on link creation                            [ OK ]
> TEST: vti6: MTU setting on link creation                            [FAIL]
>   vti6 tunnel created with invalid MTU 1279

This is solved by net-next.git commit 5a643c861d0f ("selftests: pmtu:
Minimum MTU for vti6 is 68"), which should get merged into net.git soon.

-- 
Stefano
