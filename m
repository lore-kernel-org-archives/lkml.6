Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753440AbeBKOAD (ORCPT <rfc822;w@1wt.eu>);
        Sun, 11 Feb 2018 09:00:03 -0500
Received: from mail-pg0-f65.google.com ([74.125.83.65]:45141 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753243AbeBKOAC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Feb 2018 09:00:02 -0500
X-Google-Smtp-Source: AH8x227ifsE4IDBit+9JAQzakp06xLSQ4vBFycukPl7I9b6qGNplh6nKG5ne2C7etARzIC5p0vahOg==
Date: Sun, 11 Feb 2018 23:59:44 +1000
From: Nicholas Piggin <npiggin@gmail.com>
To: Christophe Leroy <christophe.leroy@c-s.fr>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>, Scott Wood <oss@buserror.net>,
        aneesh.kumar@linux.vnet.ibm.com, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v4 2/5] powerpc/mm/slice: Enhance for supporting PPC32
Message-ID: <20180211235944.14c2be39@roar.ozlabs.ibm.com>
In-Reply-To: <0ac518636ae1e601ea0732dd69b48dcd0f347285.1518226173.git.christophe.leroy@c-s.fr>
References: <01e8f783db8f4d4d41df91e0400a8634272b326f.1518226173.git.christophe.leroy@c-s.fr>
        <0ac518636ae1e601ea0732dd69b48dcd0f347285.1518226173.git.christophe.leroy@c-s.fr>
Organization: IBM
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 10 Feb 2018 13:54:27 +0100 (CET)
Christophe Leroy <christophe.leroy@c-s.fr> wrote:

> In preparation for the following patch which will fix an issue on
> the 8xx by re-using the 'slices', this patch enhances the
> 'slices' implementation to support 32 bits CPUs.
> 
> On PPC32, the address space is limited to 4Gbytes, hence only the low
> slices will be used.
> 
> This patch moves "slices" functions prototypes from page64.h to slice.h
> 
> The high slices use bitmaps. As bitmap functions are not prepared to
> handling bitmaps of size 0, the bitmap_xxx() calls are wrapped into
> slice_bitmap_xxx() functions which will void on PPC32

On this last point, I think it would be better to put these with the
existing slice bitmap functions in slice.c and just have a few #ifdefs
for SLICE_NUM_HIGH == 0.

Thanks,
Nick
