Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753903AbeDTACU (ORCPT <rfc822;w@1wt.eu>);
        Thu, 19 Apr 2018 20:02:20 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:52338 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753695AbeDTACT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Apr 2018 20:02:19 -0400
Date: Thu, 19 Apr 2018 17:02:17 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Alexey Dobriyan <adobriyan@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/5] proc: make /proc/*/cmdline go through LSM
Message-Id: <20180419170217.0418b519a269003fd950a291@linux-foundation.org>
In-Reply-To: <20180221192339.GA28548@avx2>
References: <20180221192339.GA28548@avx2>
X-Mailer: Sylpheed 3.6.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 21 Feb 2018 22:23:39 +0300 Alexey Dobriyan <adobriyan@gmail.com> wrote:

> /proc/*/cmdline is not different from /proc/*/environ as it accesses
> target task's memory (and can access the very same region of memory)
> but it doesn't go through ptrace_may_access() and thus doesn't go through LSM.

This change can cause existing code to break, no?

I'd like to see, in the changelog, a full explanation of why this won't
break any existing setup?
