Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754992AbeDCK0D (ORCPT <rfc822;w@1wt.eu>);
        Tue, 3 Apr 2018 06:26:03 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:59264 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752475AbeDCK0C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Apr 2018 06:26:02 -0400
Date: Tue, 3 Apr 2018 12:25:56 +0200 (CEST)
From: Thomas Gleixner <tglx@linutronix.de>
To: Li RongQing <lirongqing@baidu.com>
cc: LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH] genirq: only scan the present CPUs
In-Reply-To: <1522647902-11426-1-git-send-email-lirongqing@baidu.com>
Message-ID: <alpine.DEB.2.21.1804031224150.2511@nanos.tec.linutronix.de>
References: <1522647902-11426-1-git-send-email-lirongqing@baidu.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2 Apr 2018, Li RongQing wrote:

> lots of application will read /proc/stat, like ps and vmstat, but we
> find the reading time are spreading on Purley platform which has lots
> of possible CPUs and interrupt.
> 
> To reduce the reading time, only scan the present CPUs, not all possible
> CPUs, which speeds the reading of /proc/stat 20 times on Purley platform
> which has 56 present CPUs, and 224 possible CPUs

Why is BIOS/ACPI telling the kernel that there are 224 possible CPUs unless
it supports physical CPU hotplug.

Thanks,

	tglx
