Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753940AbeCFSD1 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Mar 2018 13:03:27 -0500
Received: from mail-wr0-f169.google.com ([209.85.128.169]:46804 "EHLO
        mail-wr0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753892AbeCFSDX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Mar 2018 13:03:23 -0500
X-Google-Smtp-Source: AG47ELuydFmn/d6AoZ6VeeccSmNWbYhmL06odcYLIK3JII1pD4kHZm7AW5e8SHQl3axdXMROHUs6Pg==
Date: Tue, 6 Mar 2018 21:03:19 +0300
From: Alexey Dobriyan <adobriyan@gmail.com>
To: Kees Cook <keescook@chromium.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Jann Horn <jann@thejh.net>,
        linux-kernel@vger.kernel.org
Subject: Re: + mm-relax-ptrace-mode-in-process_vm_readv2.patch added to -mm
 tree
Message-ID: <20180306180319.GC2080@avx2>
References: <20180306000721.gx9qqFGe8%akpm@linux-foundation.org>
 <CAGXu5jKP03X7+XX9Oq+vVjQJhO1+A9ZyLDD+Gsxv2nRCgVD4wQ@mail.gmail.com>
 <20180306174218.GA2080@avx2>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180306174218.GA2080@avx2>
User-Agent: Mutt/1.7.2 (2016-11-26)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 06, 2018 at 08:42:19PM +0300, Alexey Dobriyan wrote:
> On Mon, Mar 05, 2018 at 05:02:08PM -0800, Kees Cook wrote:
> > On Mon, Mar 5, 2018 at 4:07 PM,  <akpm@linux-foundation.org> wrote:
> 
> > > It is more natural to check for read-from-memory permissions in case of
> > > process_vm_readv() as PTRACE_MODE_ATTACH is equivalent to write
> > > permissions.
> > 
> > NAK, this weakens the existing permission model for reading
> 
> What if existing permission model is overezealous?
> 
> /proc/*/auxv, /proc/*/environ, /proc*/cmdline, /proc/*/mem opened
> for reading and process_vm_readv(2) should do PTRACE_MODE_READ and
> everything else should do PTRACE_MODE_ATTACH.

Or in other words:

what if there should be 3 levels:
1) permission to write to address space
2) permission to read arbitrarily from adress space
3) permission to read auxv, argv and envp

Current code conflates (1) and (2).
