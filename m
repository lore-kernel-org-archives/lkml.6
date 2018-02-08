Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752132AbeBHXgz (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Feb 2018 18:36:55 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:53380 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751094AbeBHXgy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Feb 2018 18:36:54 -0500
Date: Thu, 8 Feb 2018 15:36:52 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: daniel.m.jordan@oracle.com
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, aaron.lu@intel.com,
        ak@linux.intel.com, Dave.Dice@oracle.com, dave@stgolabs.net,
        khandual@linux.vnet.ibm.com, ldufour@linux.vnet.ibm.com,
        mgorman@suse.de, mhocko@kernel.org, pasha.tatashin@oracle.com,
        steven.sistare@oracle.com, yossi.lev@oracle.com
Subject: Re: [RFC PATCH v1 00/13] lru_lock scalability
Message-Id: <20180208153652.481a77e57cc32c9e1a7e4269@linux-foundation.org>
In-Reply-To: <20180131230413.27653-1-daniel.m.jordan@oracle.com>
References: <20180131230413.27653-1-daniel.m.jordan@oracle.com>
X-Mailer: Sylpheed 3.4.1 (GTK+ 2.24.23; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 31 Jan 2018 18:04:00 -0500 daniel.m.jordan@oracle.com wrote:

> lru_lock, a per-node* spinlock that protects an LRU list, is one of the
> hottest locks in the kernel.  On some workloads on large machines, it
> shows up at the top of lock_stat.

Do you have details on which callsites are causing the problem?  That
would permit us to consider other approaches, perhaps.
