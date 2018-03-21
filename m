Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752579AbeCUSBF (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Mar 2018 14:01:05 -0400
Received: from mailout5.zih.tu-dresden.de ([141.30.67.74]:58162 "EHLO
        mailout5.zih.tu-dresden.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752122AbeCUSBD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Mar 2018 14:01:03 -0400
Subject: Re: [RFT][PATCH v7 5/8] cpuidle: Return nohz hint from
 cpuidle_select()
To: "Rafael J. Wysocki" <rafael@kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>
CC: Peter Zijlstra <peterz@infradead.org>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Paul McKenney <paulmck@linux.vnet.ibm.com>,
        Doug Smythies <dsmythies@telus.net>, "Rik van Riel" <riel@surriel.com>,
        Aubrey Li <aubrey.li@linux.intel.com>,
        "Mike Galbraith" <mgalbraith@suse.de>,
        LKML <linux-kernel@vger.kernel.org>
References: <2390019.oHdSGtR3EE@aspire.rjw.lan>
 <1635957.yuHkCe9oyz@aspire.rjw.lan>
 <CAJZ5v0j-CnEms-Wm0Op=386ceuG2GfAouVLXO48rbD_pUPJhMg@mail.gmail.com>
From: Thomas Ilsche <thomas.ilsche@tu-dresden.de>
Message-ID: <b05c00e7-b5d8-0bcb-0b38-a91324ec597a@tu-dresden.de>
Date: Wed, 21 Mar 2018 18:59:57 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <CAJZ5v0j-CnEms-Wm0Op=386ceuG2GfAouVLXO48rbD_pUPJhMg@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MSX-L105.msx.ad.zih.tu-dresden.de (172.26.34.105) To
 MSX-L104.msx.ad.zih.tu-dresden.de (172.26.34.104)
X-PMWin-Version: 4.0.3, Antivirus-Engine: 3.70.2, Antivirus-Data: 5.49
X-TUD-Virus-Scanned: mailout5.zih.tu-dresden.de
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-03-21 15:36, Rafael J. Wysocki wrote:
> 
> So please disregard this one entirely and take the v7.2 replacement
> instead of it:https://patchwork.kernel.org/patch/10299429/
> 
> The current versions (including the above) is in the git branch at
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
>   idle-loop-v7.2

With v7.2 (tested on SKL-SP from git) I see similar behavior in idle
as with v5: several cores which just keep the sched tick enabled.
Worse yet, some go only in C1 (not even C1E!?) despite sleeping the
full sched tick.
The resulting power consumption is ~105 W instead of ~ 70 W.

https://wwwpub.zih.tu-dresden.de/~tilsche/powernightmares/v7_2_skl_sp_idle.png

I have briefly ran v7 and I believe it was also affected.
