Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752801AbeCPUSp (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Mar 2018 16:18:45 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:57113 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752579AbeCPUSo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Mar 2018 16:18:44 -0400
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Joerg Roedel <joro@8bytes.org>
Cc: iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        tglx@linutronix.de
Subject: [PATCH 00/10 v2] iommu/amd: lock splitting & GFP_KERNEL allocation 
Date: Fri, 16 Mar 2018 21:18:26 +0100
Message-Id: <20180316201836.7864-1-bigeasy@linutronix.de>
X-Mailer: git-send-email 2.16.2
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The goal here is to make the memory allocation in get_irq_table() not
with disabled interrupts and having as little raw_spin_lock as possible
while having them if the caller is also holding one (like desc->lock
during IRQ-affinity changes).
I reverted one patch one patch in the iommu while rebasing since it
make job easier.

The patches were boot tested on an AMD EPYC 7601.

Sebastian
