Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752998AbeCQVKV (ORCPT <rfc822;w@1wt.eu>);
        Sat, 17 Mar 2018 17:10:21 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:58016 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751487AbeCQVKU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Mar 2018 17:10:20 -0400
Date: Sat, 17 Mar 2018 22:10:13 +0100
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Scott Wood <swood@redhat.com>
Cc: Joerg Roedel <joro@8bytes.org>, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, tglx@linutronix.de
Subject: Re: [PATCH 00/10 v2] iommu/amd: lock splitting & GFP_KERNEL
 allocation
Message-ID: <20180317211013.rlou66s542ad4y2i@linutronix.de>
References: <20180316201836.7864-1-bigeasy@linutronix.de>
 <1521316194.3722.74.camel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1521316194.3722.74.camel@redhat.com>
User-Agent: NeoMutt/20180223
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-03-17 14:49:54 [-0500], Scott Wood wrote:
> On Fri, 2018-03-16 at 21:18 +0100, Sebastian Andrzej Siewior wrote:
> > The goal here is to make the memory allocation in get_irq_table() not
> > with disabled interrupts and having as little raw_spin_lock as
> > possible
> > while having them if the caller is also holding one (like desc->lock
> > during IRQ-affinity changes).
> > I reverted one patch one patch in the iommu while rebasing since it
> > make job easier.
> 
> If the goal is to have "as little raw_spin_lock as possible" -- and
> presumably also to avoid unnecessary complexity -- wouldn't it be
> better to leave my patch in, and drop patches 4 and 9?

9 gives me GFP_KERNEL instead atomic so no.
4 is needed I think but I could double check on Monday. 

> -Scott

Sebastian
