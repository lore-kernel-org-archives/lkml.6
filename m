Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752655AbeC3TEP (ORCPT <rfc822;w@1wt.eu>);
        Fri, 30 Mar 2018 15:04:15 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:38035 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752159AbeC3TEO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Mar 2018 15:04:14 -0400
X-Google-Smtp-Source: AIpwx4+5C0GaJQupC752QTNyxvf6k+YGlP63E9DV99bmkigT4JaQK2wSq905fMkyxyyT9tExmYvj9A==
From: Kai-Heng Feng <kai.heng.feng@canonical.com>
Content-Type: text/plain;
        charset=us-ascii;
        delsp=yes;
        format=flowed
Content-Transfer-Encoding: 7bit
Mime-Version: 1.0 (Mac OS X Mail 11.2 \(3445.5.20\))
Subject: Regression caused by commit bc976233a872, ethernet r8169 stops
 working after system S3
Message-Id: <E3F55561-8733-4056-ABEC-5AF87AC288CB@canonical.com>
Date: Sat, 31 Mar 2018 03:04:04 +0800
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>
X-Mailer: Apple Mail (2.3445.5.20)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Thomas,

A user reported [1] that the Realtek ethernet r8169 stops working after S3  
since v4.15-rc6. The issue still exists in Linus' tree:

[ 150.877998] IPv6: ADDRCONF(NETDEV_UP): enp1s0: link is not ready
[ 150.944101] do_IRQ: 3.37 No irq handler for vector
[ 150.944105] r8169 0000:01:00.0 enp1s0: link down
[ 150.944180] IPv6: ADDRCONF(NETDEV_UP): enp1s0: link is not ready

My desktop also has this device, which is also affected by this regression.  
So I did a bisect, and this is the bad commit:
bc976233a872 genirq/msi x86/vector: Prevent reservation mode for non  
maskable MSI

After this commit gets reverted, the issue is gone.

Let me know if you need more debug information.

Kai-Heng

[1] https://bugs.launchpad.net/bugs/1752772
