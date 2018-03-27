Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750954AbeC0F7F (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Mar 2018 01:59:05 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:55339 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750742AbeC0F7D (ORCPT
        <rfc822;Linux-kernel@vger.kernel.org>);
        Tue, 27 Mar 2018 01:59:03 -0400
X-Google-Smtp-Source: AIpwx4/UCfvmL3NCn3kf6+55toS57COM7cVGwg8FnZF1HwHXJkySsbup2UUEsATpW7xMy0GVAHfVzQ==
Date: Tue, 27 Mar 2018 07:58:59 +0200
From: Ingo Molnar <mingo@kernel.org>
To: Jin Yao <yao.jin@linux.intel.com>
Cc: acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com,
        Linux-kernel@vger.kernel.org, ak@linux.intel.com, kan.liang@intel.com,
        yao.jin@intel.com
Subject: Re: [PATCH v1 2/3] perf version: Print the status of compiled-in
 libraries
Message-ID: <20180327055859.s2tjsvgdwd7cdkf7@gmail.com>
References: <1522080424-12912-1-git-send-email-yao.jin@linux.intel.com>
 <1522080424-12912-3-git-send-email-yao.jin@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1522080424-12912-3-git-send-email-yao.jin@linux.intel.com>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Jin Yao <yao.jin@linux.intel.com> wrote:

> +#ifdef HAVE_DWARF_SUPPORT
> +#ifdef HAVE_DWARF_GETLOCATIONS
> +#ifdef NO_GLIBC
> +#ifdef HAVE_GTK2_SUPPORT
> +#ifdef HAVE_LIBAUDIT_SUPPORT
> +#ifdef HAVE_LIBBFD_SUPPORT
> +#ifdef HAVE_LIBELF_SUPPORT
> +#ifdef HAVE_LIBNUMA_SUPPORT
> +#ifdef NO_LIBPERL
> +#ifdef NO_LIBPYTHON
> +#ifdef HAVE_SLANG_SUPPORT
> +#ifdef HAVE_LIBCRYPTO_SUPPORT
> +#ifdef HAVE_LIBUNWIND_SUPPORT
> +#ifdef HAVE_DWARF_SUPPORT
> +#ifdef HAVE_ZLIB_SUPPORT
> +#ifdef HAVE_LZMA_SUPPORT
> +#ifdef HAVE_AUXTRACE_SUPPORT
> +#ifdef HAVE_LIBBPF_SUPPORT

BTW., it would be nice at this point to fix those 3 outliers that have a negation 
in their library support status macro:

> +#ifdef NO_GLIBC
> +#ifdef NO_LIBPERL
> +#ifdef NO_LIBPYTHON

... and invert them back to the HAVE_* side of the logic:

> +#ifdef HAVE_GLIBC
> +#ifdef HAVE_LIBPERL
> +#ifdef HAVE_LIBPYTHON

That should make all related code more consistent and more readable.

Thanks,

	Ingo
