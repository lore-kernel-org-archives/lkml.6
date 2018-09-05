Return-Path: <SRS0=wmYC=LT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1927BC43334
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 23:01:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B6BD62073D
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 23:01:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B6BD62073D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727703AbeIFDdn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Sep 2018 23:33:43 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:60554 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727604AbeIFDdn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Sep 2018 23:33:43 -0400
Received: from p4fea45ac.dip0.t-ipconnect.de ([79.234.69.172] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1fxgnP-0008At-MV; Thu, 06 Sep 2018 01:01:11 +0200
Date:   Thu, 6 Sep 2018 01:01:09 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Laurent Dufour <ldufour@linux.vnet.ibm.com>
cc:     Christopher Lameter <cl@linux.com>,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        linux-kernel@vger.kernel.org,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Aaron Lu <aaron.lu@intel.com>, alex.kogan@oracle.com,
        akpm@linux-foundation.org, boqun.feng@gmail.com, brouer@redhat.com,
        dave@stgolabs.net, dave.dice@oracle.com,
        Dhaval Giani <dhaval.giani@oracle.com>, ktkhai@virtuozzo.com,
        Pavel.Tatashin@microsoft.com, paulmck@linux.vnet.ibm.com,
        shady.issa@oracle.com, tariqt@mellanox.com, tim.c.chen@intel.com,
        vbabka@suse.cz, longman@redhat.com, yang.shi@linux.alibaba.com,
        shy828301@gmail.com, Huang Ying <ying.huang@intel.com>,
        subhra.mazumdar@oracle.com,
        Steven Sistare <steven.sistare@oracle.com>, jwadams@google.com,
        ashwinch@google.com, sqazi@google.com,
        Shakeel Butt <shakeelb@google.com>, walken@google.com,
        rientjes@google.com, junaids@google.com,
        Neha Agarwal <nehaagarwal@google.com>
Subject: Re: Plumbers 2018 - Performance and Scalability Microconference
In-Reply-To: <839e2703-1588-0873-00a7-d04810f403cf@linux.vnet.ibm.com>
Message-ID: <alpine.DEB.2.21.1809060059390.1416@nanos.tec.linutronix.de>
References: <1dc80ff6-f53f-ae89-be29-3408bf7d69cc@oracle.com> <01000165aa490dc9-64abf872-afd1-4a81-a46d-a50d0131de93-000000@email.amazonses.com> <839e2703-1588-0873-00a7-d04810f403cf@linux.vnet.ibm.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 5 Sep 2018, Laurent Dufour wrote:
> On 05/09/2018 17:10, Christopher Lameter wrote:
> > Large page sizes also reduce contention there.
> 
> That's true for the page fault path, but for process's actions manipulating the
> memory process's layout (mmap,munmap,madvise,mprotect) the impact is minimal
> unless the code has to manipulate the page tables.

And how exactly are you going to do any of those operations _without_
manipulating the page tables?

Thanks,

	tglx
