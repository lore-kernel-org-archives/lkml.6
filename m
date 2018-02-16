Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1759040AbeBPRsx (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Feb 2018 12:48:53 -0500
Received: from mail-pg0-f67.google.com ([74.125.83.67]:39762 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1759025AbeBPRsw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Feb 2018 12:48:52 -0500
X-Google-Smtp-Source: AH8x2244GpYuczweKLgL+HP5wXvXu4vNRyx2jaYzim4IteKGedUnb7bcSM2AivrDqOECvELwrnn9mg==
Content-Type: text/plain; charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [PATCH 2/3] x86/mm: introduce __PAGE_KERNEL_GLOBAL
From: Nadav Amit <nadav.amit@gmail.com>
In-Reply-To: <20180215132055.F341C31E@viggo.jf.intel.com>
Date: Fri, 16 Feb 2018 09:47:49 -0800
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, luto@kernel.org,
        torvalds@linux-foundation.org, keescook@google.com, hughd@google.com,
        jgross@suse.com, x86@kernel.org
Message-Id: <E0AB2852-C4E0-43D3-ABA7-34117A5516C1@gmail.com>
References: <20180215132053.6C9B48C8@viggo.jf.intel.com>
 <20180215132055.F341C31E@viggo.jf.intel.com>
To: Dave Hansen <dave.hansen@linux.intel.com>
X-Mailer: Apple Mail (2.3273)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w1GHn0VN002950

Dave Hansen <dave.hansen@linux.intel.com> wrote:

> 
> From: Dave Hansen <dave.hansen@linux.intel.com>
> 
> Kernel mappings are historically _PAGE_GLOBAL.  But, with PTI, we do not
> want them to be _PAGE_GLOBAL.  We currently accomplish this by simply
> clearing _PAGE_GLOBAL from the suppotred mask which ensures it is
> cleansed from many of our PTE construction sites:
> 
>        if (!static_cpu_has(X86_FEATURE_PTI))
> 	                __supported_pte_mask |= _PAGE_GLOBAL;
> 
> But, this also means that we now get *no* opportunity to use global
> pages with PTI, even for data which is shared such as the cpu_entry_area
> and entry/exit text.


Doesn’t this patch change the kernel behavior when the “nopti” parameter is used?
