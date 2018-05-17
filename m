Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752191AbeEQN4h (ORCPT <rfc822;w@1wt.eu>);
        Thu, 17 May 2018 09:56:37 -0400
Received: from gate.crashing.org ([63.228.1.57]:55726 "EHLO gate.crashing.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751647AbeEQN40 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 May 2018 09:56:26 -0400
Date: Thu, 17 May 2018 08:55:51 -0500
From: Segher Boessenkool <segher@kernel.crashing.org>
To: Christophe Leroy <christophe.leroy@c-s.fr>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 5/5] powerpc/lib: inline memcmp() for small constant sizes
Message-ID: <20180517135551.GT17342@gate.crashing.org>
References: <cover.1526553552.git.christophe.leroy@c-s.fr> <8a6f90d882c8b60e5fa0826cd23dd70a92075659.1526553552.git.christophe.leroy@c-s.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8a6f90d882c8b60e5fa0826cd23dd70a92075659.1526553552.git.christophe.leroy@c-s.fr>
User-Agent: Mutt/1.4.2.3i
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 17, 2018 at 12:49:58PM +0200, Christophe Leroy wrote:
> In my 8xx configuration, I get 208 calls to memcmp()
> Within those 208 calls, about half of them have constant sizes,
> 46 have a size of 8, 17 have a size of 16, only a few have a
> size over 16. Other fixed sizes are mostly 4, 6 and 10.
> 
> This patch inlines calls to memcmp() when size
> is constant and lower than or equal to 16
> 
> In my 8xx configuration, this reduces the number of calls
> to memcmp() from 208 to 123
> 
> The following table shows the number of TB timeticks to perform
> a constant size memcmp() before and after the patch depending on
> the size
> 
> 	Before	After	Improvement
> 01:	 7577	 5682	25%
> 02:	41668	 5682	86%
> 03:	51137	13258	74%
> 04:	45455	 5682	87%
> 05:	58713	13258	77%
> 06:	58712	13258	77%
> 07:	68183	20834	70%
> 08:	56819	15153	73%
> 09:	70077	28411	60%
> 10:	70077	28411	60%
> 11:	79546	35986	55%
> 12:	68182	28411	58%
> 13:	81440	35986	55%
> 14:	81440	39774	51%
> 15:	94697	43562	54%
> 16:	79546	37881	52%

Could you show results with a more recent GCC?  What version was this?

What is this really measuring?  I doubt it takes 7577 (or 5682) timebase
ticks to do a 1-byte memcmp, which is just 3 instructions after all.


Segher
