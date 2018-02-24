Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751424AbeBXHr6 (ORCPT <rfc822;w@1wt.eu>);
        Sat, 24 Feb 2018 02:47:58 -0500
Received: from mail-pl0-f46.google.com ([209.85.160.46]:34827 "EHLO
        mail-pl0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750737AbeBXHr4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Feb 2018 02:47:56 -0500
X-Google-Smtp-Source: AH8x224X+TB95tNjU+Kj5BI5q6bO4d8Z99NhtGq77dTPUIAjxJWfCSGnchBUd7K+M8sBVkhMyOrqUw==
Date: Sat, 24 Feb 2018 17:47:44 +1000
From: Nicholas Piggin <npiggin@gmail.com>
To: Christophe Leroy <christophe.leroy@c-s.fr>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>, Scott Wood <oss@buserror.net>,
        aneesh.kumar@linux.vnet.ibm.com, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v5 3/6] powerpc/mm/slice: Enhance for supporting PPC32
Message-ID: <20180224174744.0bfec326@roar.ozlabs.ibm.com>
In-Reply-To: <3e9cfc87e78d61310d1b628960a465327c20d895.1519305411.git.christophe.leroy@c-s.fr>
References: <455276187b369bf019e91715b7488e86cd932d49.1519305410.git.christophe.leroy@c-s.fr>
        <3e9cfc87e78d61310d1b628960a465327c20d895.1519305411.git.christophe.leroy@c-s.fr>
Organization: IBM
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 22 Feb 2018 15:27:24 +0100 (CET)
Christophe Leroy <christophe.leroy@c-s.fr> wrote:

> In preparation for the following patch which will fix an issue on
> the 8xx by re-using the 'slices', this patch enhances the
> 'slices' implementation to support 32 bits CPUs.
> 
> On PPC32, the address space is limited to 4Gbytes, hence only the low
> slices will be used.
> 
> The high slices use bitmaps. As bitmap functions are not prepared to
> handle bitmaps of size 0, this patch ensures that bitmap functions
> are called only when SLICE_NUM_HIGH is not nul.
> 
> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>

This looks good to me, thank you for taking my feedback into account.

Is the patch split and naming good? Yes I guess so, this adds support
for ppc32 archs that select PPC_MM_SLICES, and the next one implements
it for 8xx. There looks to be some generic arch/powerpc/mm bits in the
next patch. I wonder if you would move them over? Then the next patch
could be called powerpc/8xx: ?

Anyway it's not a big deal.

Reviewed-by: Nicholas Piggin <npiggin@gmail.com>
