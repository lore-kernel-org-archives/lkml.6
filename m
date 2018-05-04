Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751621AbeEDOZJ (ORCPT <rfc822;w@1wt.eu>);
        Fri, 4 May 2018 10:25:09 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:40839 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751307AbeEDOZH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 May 2018 10:25:07 -0400
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: linux-ide@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, tglx@linutronix.de,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 0/4] avoid disabling interrupts where it is not required
Date: Fri,  4 May 2018 16:24:42 +0200
Message-Id: <20180504142446.30525-1-bigeasy@linutronix.de>
X-Mailer: git-send-email 2.17.0
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series avoids/limits disabling of interrupts in drivers/ide.
This is from the -RT queue where it was reported initially (ata was not
widespread back then) and it hurts -RT.

While looking at alim15x3, there are some drivers which exist in both
worlds (alim15x3 included was far as I can tell). Is there a reason why
we still keep two drivers around for the same hardware? I know on mips
bigsur and swarm select IDE in their defconfig. I fixed (ages ago) ide
for swarm while I was using ata myself. So *I* think this just a relict.
If Ralf's bigsur is still alive, it is using SATA and not the onboard
IDE.

Sebastian
