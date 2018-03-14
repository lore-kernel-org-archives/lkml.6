Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751537AbeCNT1h (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Mar 2018 15:27:37 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:52076 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751714AbeCNT1g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Mar 2018 15:27:36 -0400
Date: Wed, 14 Mar 2018 20:27:10 +0100 (CET)
From: Thomas Gleixner <tglx@linutronix.de>
To: Toshi Kani <toshi.kani@hpe.com>
cc: mingo@redhat.com, hpa@zytor.com, bp@alien8.de, luto@kernel.org,
        gratian.crisan@ni.com, x86@kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] x86/mm: remove pointless checks in vmalloc_fault
In-Reply-To: <20180313170347.3829-3-toshi.kani@hpe.com>
Message-ID: <alpine.DEB.2.21.1803142024540.1946@nanos.tec.linutronix.de>
References: <20180313170347.3829-1-toshi.kani@hpe.com> <20180313170347.3829-3-toshi.kani@hpe.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 13 Mar 2018, Toshi Kani wrote:

> vmalloc_fault() sets user's pgd or p4d from the kernel page table.
> Once it's set, all tables underneath are identical. There is no point
> of following the same page table with two separate pointers and makes
> sure they see the same with BUG().
> 
> Remove the pointless checks in vmalloc_fault(). Also rename the kernel
> pgd/p4d pointers to pgd_k/p4d_k so that their names are consistent in
> the file.

I have no idea to which branch this might apply. The first patch applies
cleanly on linus head, but this one fails in hunk #2 on everything I
tried. Can you please check?

Thanks,

	tglx
