Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932228AbeCDKyU convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Sun, 4 Mar 2018 05:54:20 -0500
Received: from ozlabs.org ([103.22.144.67]:39465 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751844AbeCDKyT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Mar 2018 05:54:19 -0500
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
From: Michael Ellerman <mpe@ellerman.id.au>
To: Mathieu Malaterre <malat@debian.org>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>, Jiri Slaby <jslaby@suse.com>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        Mathieu Malaterre <malat@debian.org>
Subject: Re: [PATCH 15/21] powerpc: Add missing prototype for MMU_setup
In-Reply-To: <20180225172236.29650-16-malat@debian.org>
References: <20180225172236.29650-1-malat@debian.org> <20180225172236.29650-16-malat@debian.org>
Date: Sun, 04 Mar 2018 21:54:16 +1100
Message-ID: <87o9k4glgn.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Mathieu Malaterre <malat@debian.org> writes:
> Add a function declaration for MMU_setup at the beginning of the file to
> fix a warning (treated as error in W=1):
>
>   CC      kernel/sys.o
> arch/powerpc/mm/init_32.c:102:13: error: no previous prototype for ‘MMU_setup’ [-Werror=missing-prototypes]
>  void __init MMU_setup(void)
>              ^~~~~~~~~
> cc1: all warnings being treated as errors

Can't it be static instead?

  $ git grep -n MMU_setup
  arch/powerpc/mm/init_32.c:102:void __init MMU_setup(void)
  arch/powerpc/mm/init_32.c:135:  MMU_setup();

cheers
