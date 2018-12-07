Return-Path: <SRS0=szhz=OQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25724C04EB8
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 01:07:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C99A820989
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 01:07:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C99A820989
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725993AbeLGBHr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 20:07:47 -0500
Received: from mail.kernel.org ([198.145.29.99]:41674 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725939AbeLGBHr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 20:07:47 -0500
Received: from vmware.local.home (unknown [208.91.3.26])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 788DB208E7;
        Fri,  7 Dec 2018 01:07:46 +0000 (UTC)
Date:   Thu, 6 Dec 2018 20:07:43 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Olof Johansson <olof@lixom.net>
Cc:     David Abdurachmanov <david.abdurachmanov@gmail.com>,
        Palmer Dabbelt <palmer@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv@lists.infradead.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] riscv: remove unused variable in ftrace
Message-ID: <20181206200743.0f951d19@vmware.local.home>
In-Reply-To: <CAOesGMiT2OpN9VFaeST5tBW=epkknRUcrQtVLrpeR-GpRCr34w@mail.gmail.com>
References: <20181206102626.2557-1-david.abdurachmanov@gmail.com>
        <CAOesGMiT2OpN9VFaeST5tBW=epkknRUcrQtVLrpeR-GpRCr34w@mail.gmail.com>
X-Mailer: Claws Mail 3.15.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 6 Dec 2018 11:20:31 -0800
Olof Johansson <olof@lixom.net> wrote:

> On Thu, Dec 6, 2018 at 2:26 AM David Abdurachmanov
> <david.abdurachmanov@gmail.com> wrote:
> >
> > Noticed while building kernel-4.20.0-0.rc5.git2.1.fc30 for
> > Fedora 30/RISCV.
> >
> > [..]
> > BUILDSTDERR: arch/riscv/kernel/ftrace.c: In function 'prepare_ftrace_return':
> > BUILDSTDERR: arch/riscv/kernel/ftrace.c:135:6: warning: unused variable 'err' [-Wunused-variable]
> > BUILDSTDERR:   int err;
> > BUILDSTDERR:       ^~~

Bah. I could have sworn I checked for all the error messages when I did
my cross-compiling of the architectures. I fixed this issue in other
places, not sure how I missed riscv.

Thanks for fixing it.

Acked-by: Steven Rostedt (VMware) <rostedt@goodmis.org>

-- Steve

 
> > [..]
> >
> > Signed-off-by: David Abdurachmanov <david.abdurachmanov@gmail.com>  
> 
> Please add a:
> Fixes: e949b6db51dc1 ("riscv/function_graph: Simplify with
> function_graph_enter()")
> Reviewed-by: Olof Johansson <olof@lixom.net>

