Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754812AbeCGXBa (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Mar 2018 18:01:30 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:40118 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754500AbeCGXB3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Mar 2018 18:01:29 -0500
Date: Wed, 7 Mar 2018 15:01:27 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Toshi Kani <toshi.kani@hpe.com>
Cc: mhocko@suse.com, tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com,
        bp@suse.de, catalin.marinas@arm.com, guohanjun@huawei.com,
        will.deacon@arm.com, wxf.wang@hisilicon.com, linux-mm@kvack.org,
        x86@kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] x86/mm: implement free pmd/pte page interfaces
Message-Id: <20180307150127.1e09e9826e0f2c80ce42fa4d@linux-foundation.org>
In-Reply-To: <20180307183227.17983-3-toshi.kani@hpe.com>
References: <20180307183227.17983-1-toshi.kani@hpe.com>
        <20180307183227.17983-3-toshi.kani@hpe.com>
X-Mailer: Sylpheed 3.6.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed,  7 Mar 2018 11:32:27 -0700 Toshi Kani <toshi.kani@hpe.com> wrote:

> Implement pud_free_pmd_page() and pmd_free_pte_page() on x86, which
> clear a given pud/pmd entry and free up lower level page table(s).
> Address range associated with the pud/pmd entry must have been purged
> by INVLPG.

OK, now we have implementations which match the naming ;) Again, is a
cc:stable warranted?

Do you have any preferences/suggestions as to which tree these should
be merged through?  You're hitting core, arm and x86.
