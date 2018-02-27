Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752393AbeB0JIc (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Feb 2018 04:08:32 -0500
Received: from mail-pg0-f49.google.com ([74.125.83.49]:33534 "EHLO
        mail-pg0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751117AbeB0JI3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Feb 2018 04:08:29 -0500
X-Google-Smtp-Source: AH8x227sYlbNkGuBSSrO2oAsOXoHSTvHUf5BG8IvK9KTuvgQUSghge3fZtOHFhkeSLKyarNTF+WmiA==
Date: Tue, 27 Feb 2018 19:08:18 +1000
From: Nicholas Piggin <npiggin@gmail.com>
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Cc: Christophe Leroy <christophe.leroy@c-s.fr>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [RFC REBASED 4/5] powerpc/mm/slice: Use const pointers to
 cached slice masks where possible
Message-ID: <20180227190818.3f3673e4@roar.ozlabs.ibm.com>
In-Reply-To: <87h8q27uvi.fsf@linux.vnet.ibm.com>
References: <02a62db83282b5ef3e0e8281fdc46fa91beffc86.1518382747.git.christophe.leroy@c-s.fr>
        <6a8c9183257dfcfeb1d8ed1ecc778ec3da19dcd4.1518382747.git.christophe.leroy@c-s.fr>
        <87h8q27uvi.fsf@linux.vnet.ibm.com>
Organization: IBM
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 27 Feb 2018 12:59:53 +0530
"Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com> wrote:

> Christophe Leroy <christophe.leroy@c-s.fr> writes:
> 
> > The slice_mask cache was a basic conversion which copied the slice
> > mask into caller's structures, because that's how the original code
> > worked. In most cases the pointer can be used directly instead, saving
> > a copy and an on-stack structure.
> >
> > This also converts the slice_mask bit operation helpers to be the usual
> > 3-operand kind, which is clearer to work with. And we remove some
> > unnecessary intermediate bitmaps, reducing stack and copy overhead
> > further.  
> 
> Can we move the reduce unncessary intermediate bitmaps as another patch?

This was rightly split out -- it moved to Christophe's patch he already
made in his series. The changelog can just be adjusted.

Thanks,
Nick
