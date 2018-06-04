Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752013AbeFDXFi (ORCPT <rfc822;w@1wt.eu>);
        Mon, 4 Jun 2018 19:05:38 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:56312 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751409AbeFDXFh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jun 2018 19:05:37 -0400
Date: Mon, 4 Jun 2018 16:05:34 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Souptick Joarder <jrdr.linux@gmail.com>
Cc: mfasheh@versity.com, Joel Becker <jlbec@evilplan.org>,
        Matthew Wilcox <willy@infradead.org>, ocfs2-devel@oss.oracle.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] fs: ocfs2: Adding new return type vm_fault_t
Message-Id: <20180604160534.e393dacec8967294ab143135@linux-foundation.org>
In-Reply-To: <CAFqt6zbLPG3h66LMEqzPPrW+BWQQZsSTriegfXFVproMpz3-LQ@mail.gmail.com>
References: <20180523153258.GA28451@jordon-HP-15-Notebook-PC>
        <20180601164752.027e4f087da1b545f15c6832@linux-foundation.org>
        <CAFqt6zbLPG3h66LMEqzPPrW+BWQQZsSTriegfXFVproMpz3-LQ@mail.gmail.com>
X-Mailer: Sylpheed 3.6.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2 Jun 2018 11:46:17 +0530 Souptick Joarder <jrdr.linux@gmail.com> wrote:

> On Sat, Jun 2, 2018 at 5:17 AM, Andrew Morton <akpm@linux-foundation.org> wrote:
> > On Wed, 23 May 2018 21:02:58 +0530 Souptick Joarder <jrdr.linux@gmail.com> wrote:
> >
> >> Use new return type vm_fault_t for fault handler. For
> >> now, this is just documenting that the function returns
> >> a VM_FAULT value rather than an errno. Once all instances
> >> are converted, vm_fault_t will become a distinct type.
> >>
> >> Ref-> commit 1c8f422059ae ("mm: change return type to vm_fault_t")
> >>
> >> vmf_error() is the newly introduce inline function
> >> in 4.18.
> >>
> >> Fix one checkpatch.pl warning by replacing BUG_ON()
> >> with WARN_ON()
> >
> > err, no, I'll revert that part.
> >
> > It could be that if this assertion triggers then filesystem corruption
> > would ensue, in which case a BUG_ON() is the appropriate handling.
> > Such a change should be submitted separately, please.
> >
> 
> In few places checkpatch.pl throwing warning to replace BUG_ON()
> with WARN_ON(). Shall we ignore these warning or it will vary across
> patches ?

Such changes are unrelated to the vm_fault_t migration, so please don't
make them in this context.

It is true that we tend to be too eager to use BUG_ON(), but addressing
such things should be done one-at-a-time, as a separate project.
