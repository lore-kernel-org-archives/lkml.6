Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753921AbeCQTt6 (ORCPT <rfc822;w@1wt.eu>);
        Sat, 17 Mar 2018 15:49:58 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42582 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753259AbeCQTt4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Mar 2018 15:49:56 -0400
Message-ID: <1521316194.3722.74.camel@redhat.com>
Subject: Re: [PATCH 00/10 v2] iommu/amd: lock splitting & GFP_KERNEL
 allocation
From: Scott Wood <swood@redhat.com>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Joerg Roedel <joro@8bytes.org>
Cc: iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        tglx@linutronix.de
Date: Sat, 17 Mar 2018 14:49:54 -0500
In-Reply-To: <20180316201836.7864-1-bigeasy@linutronix.de>
References: <20180316201836.7864-1-bigeasy@linutronix.de>
Organization: Red Hat
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2018-03-16 at 21:18 +0100, Sebastian Andrzej Siewior wrote:
> The goal here is to make the memory allocation in get_irq_table() not
> with disabled interrupts and having as little raw_spin_lock as
> possible
> while having them if the caller is also holding one (like desc->lock
> during IRQ-affinity changes).
> I reverted one patch one patch in the iommu while rebasing since it
> make job easier.

If the goal is to have "as little raw_spin_lock as possible" -- and
presumably also to avoid unnecessary complexity -- wouldn't it be
better to leave my patch in, and drop patches 4 and 9?

-Scott
