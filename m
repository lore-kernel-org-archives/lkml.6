Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751386AbeFBGQV (ORCPT <rfc822;w@1wt.eu>);
        Sat, 2 Jun 2018 02:16:21 -0400
Received: from mail-lf0-f66.google.com ([209.85.215.66]:46262 "EHLO
        mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750750AbeFBGQU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Jun 2018 02:16:20 -0400
X-Google-Smtp-Source: ADUXVKJB4Wyv0ciXu30BLanOambtGYSNiMz60Wk7X+4XSSaDQrGGPq0wUGRkXi0IPCJnKCaeLVWFZJj7XmUsZiSwJ/E=
MIME-Version: 1.0
In-Reply-To: <20180601164752.027e4f087da1b545f15c6832@linux-foundation.org>
References: <20180523153258.GA28451@jordon-HP-15-Notebook-PC> <20180601164752.027e4f087da1b545f15c6832@linux-foundation.org>
From: Souptick Joarder <jrdr.linux@gmail.com>
Date: Sat, 2 Jun 2018 11:46:17 +0530
Message-ID: <CAFqt6zbLPG3h66LMEqzPPrW+BWQQZsSTriegfXFVproMpz3-LQ@mail.gmail.com>
Subject: Re: [PATCH v2] fs: ocfs2: Adding new return type vm_fault_t
To: Andrew Morton <akpm@linux-foundation.org>
Cc: mfasheh@versity.com, Joel Becker <jlbec@evilplan.org>,
        Matthew Wilcox <willy@infradead.org>, ocfs2-devel@oss.oracle.com,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 2, 2018 at 5:17 AM, Andrew Morton <akpm@linux-foundation.org> wrote:
> On Wed, 23 May 2018 21:02:58 +0530 Souptick Joarder <jrdr.linux@gmail.com> wrote:
>
>> Use new return type vm_fault_t for fault handler. For
>> now, this is just documenting that the function returns
>> a VM_FAULT value rather than an errno. Once all instances
>> are converted, vm_fault_t will become a distinct type.
>>
>> Ref-> commit 1c8f422059ae ("mm: change return type to vm_fault_t")
>>
>> vmf_error() is the newly introduce inline function
>> in 4.18.
>>
>> Fix one checkpatch.pl warning by replacing BUG_ON()
>> with WARN_ON()
>
> err, no, I'll revert that part.
>
> It could be that if this assertion triggers then filesystem corruption
> would ensue, in which case a BUG_ON() is the appropriate handling.
> Such a change should be submitted separately, please.
>

In few places checkpatch.pl throwing warning to replace BUG_ON()
with WARN_ON(). Shall we ignore these warning or it will vary across
patches ?
