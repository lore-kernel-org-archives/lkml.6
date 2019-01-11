Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 591E0C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 01:49:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2DE6C2133F
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 01:49:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729515AbfAKBtT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Jan 2019 20:49:19 -0500
Received: from mail.kernel.org ([198.145.29.99]:33372 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727750AbfAKBtT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jan 2019 20:49:19 -0500
Received: from vmware.local.home (cpe-66-24-56-78.stny.res.rr.com [66.24.56.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7FB52206B7;
        Fri, 11 Jan 2019 01:49:17 +0000 (UTC)
Date:   Thu, 10 Jan 2019 20:49:15 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Alexey Kardashevskiy <aik@ozlabs.ru>
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        kvm@vger.kernel.org, Laura Abbott <labbott@redhat.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Cornelia Huck <cohuck@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] vfio_pci: set TRACE_INCLUDE_PATH to fix the build error
Message-ID: <20190110204915.1cab2b78@vmware.local.home>
In-Reply-To: <9b1c9668-98cb-2a30-2fb0-b797b47aa9b6@ozlabs.ru>
References: <1546916883-25911-1-git-send-email-yamada.masahiro@socionext.com>
        <20190110144701.ah3hmedqmyqf5uzt@home.goodmis.org>
        <9b1c9668-98cb-2a30-2fb0-b797b47aa9b6@ozlabs.ru>
X-Mailer: Claws Mail 3.15.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 11 Jan 2019 12:13:35 +1100
Alexey Kardashevskiy <aik@ozlabs.ru> wrote:

> > The words in TRACE_INCLUDE_PATH can be updated by C preprocessor defines. For
> > example, if for some reason you had:
> > 
> > #define pci special_pci
> > 
> > The above would turn into:
> > 
> >  ../../drivers/vfio/special_pci
> > 
> > and it wont build, and you will be left scratching your head wondering why.  
> 
> Lovely :) imho it is +1 for
> CFLAGS_vfio_pci_nvlink2.o += -I$(src)
> and a comment.

A more realistic example is:

#define pci 1

which I hit when I first tried to do it this way when I first
implemented this code (not with "pci" but a similar word).

I'll leave this up to the maintainers of the code to decide which way
they want to do it, as they are the ones that have to deal with the
fallout if something goes wrong ;-)

-- Steve
