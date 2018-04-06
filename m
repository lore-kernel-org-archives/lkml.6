Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756493AbeDFOGD (ORCPT <rfc822;w@1wt.eu>);
        Fri, 6 Apr 2018 10:06:03 -0400
Received: from www.llwyncelyn.cymru ([82.70.14.225]:56084 "EHLO fuzix.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753084AbeDFOGC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Apr 2018 10:06:02 -0400
Date: Fri, 6 Apr 2018 13:01:46 +0100
From: Alan Cox <gnomes@lxorguk.ukuu.org.uk>
To: Simon Que <sque@chromium.org>
Cc: linux-kernel@vger.kernel.org, frankhu@chromium.org,
        John Joseph <jnjoseph@google.com>, Rob Springer <rspringer@google.com>
Subject: Re: Looking for way to program external MMU from userspace (or
 viable alternative)
Message-ID: <20180406130146.5a9c7ff3@alans-desktop>
In-Reply-To: <CANV8Hs0XsCnLRwOdC=r4sot+iKkivofMzEg-kA_b5UjRw9Xmng@mail.gmail.com>
References: <CANV8Hs0XsCnLRwOdC=r4sot+iKkivofMzEg-kA_b5UjRw9Xmng@mail.gmail.com>
Organization: Intel Corporation
X-Mailer: Claws Mail 3.15.1-dirty (GTK+ 2.24.31; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> The current kernel driver code looks up the physical address of a page of
> user-allocated memory by traversing the page table, and then writing the
> physical address to the external MMU. If we were to move the driver to
> userspace, this procedure would require exposing the physical address to
> user space, which insecure and thus a no-go.
> 
> What possibilities are there for programming the MMU from a userspace
> driver?

If you want to be secure none.

That's not to say you can't keep most of the code in user space but
you'll need the DMA and MMU manager to be kernel side because you have to
trust it.

Even if you use something like VT-D, you've then got to program the IOMMU
and that has to be done in kernel for the same obvious reasons. Look at
VFIO.. maybe that helps.

Alan
