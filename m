Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966036AbeEYKw4 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 25 May 2018 06:52:56 -0400
Received: from ozlabs.org ([203.11.71.1]:56187 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S965554AbeEYKwz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 May 2018 06:52:55 -0400
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
From: Michael Ellerman <mpe@ellerman.id.au>
To: Akshay Adiga <akshay.adiga@linux.vnet.ibm.com>,
        Stewart Smith <stewart@linux.ibm.com>
Cc: ego@linux.vnet.ibm.com, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, npiggin@gmail.com
Subject: Re: [PATCH] cpuidle/powernv : init all present cpus for deep states
In-Reply-To: <20180517055542.vvpgw2vy2ivowfdc@aksadiga.ibm>
References: <1526472134-23757-1-git-send-email-akshay.adiga@linux.vnet.ibm.com> <87efiby6a9.fsf@linux.vnet.ibm.com> <20180517055542.vvpgw2vy2ivowfdc@aksadiga.ibm>
Date: Fri, 25 May 2018 20:52:53 +1000
Message-ID: <87efi0qa62.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Akshay Adiga <akshay.adiga@linux.vnet.ibm.com> writes:

> Yes this needs to be sent to  stable. 
>
> Fixes: d405a98c ("powerpc/powernv: Move cpuidle related code from setup.c
> to new file")

Is that really the commit that introduced the bug? :)

Seems like it's more likely this one:

  Fixes: 77b54e9f213f ("powernv/powerpc: Add winkle support for offline cpus")


It's true that because the code was moved in d405a98c we won't be able
to automatically backport the fix past that commit, but we should still
identify the right commit in the Fixes tag.

cheers
