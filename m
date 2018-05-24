Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S971292AbeEXTzz (ORCPT <rfc822;w@1wt.eu>);
        Thu, 24 May 2018 15:55:55 -0400
Received: from gate.crashing.org ([63.228.1.57]:39644 "EHLO gate.crashing.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S968767AbeEXTzy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 May 2018 15:55:54 -0400
Date: Thu, 24 May 2018 14:55:38 -0500
From: Segher Boessenkool <segher@kernel.crashing.org>
To: Christophe Leroy <christophe.leroy@c-s.fr>
Cc: linux-kernel@vger.kernel.org, Paul Mackerras <paulus@samba.org>,
        netdev@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v3] powerpc: Implement csum_ipv6_magic in assembly
Message-ID: <20180524195538.GE17342@gate.crashing.org>
References: <20180522065701.9DE696CCB4@po14934vm.idsi0.si.c-s.fr> <20180523183447.GV17342@gate.crashing.org> <3848a4ad-2c0e-691f-e98f-347cfe3484e8@c-s.fr> <1dac2356-5d8a-2892-109e-6e1b26c2bd8c@c-s.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1dac2356-5d8a-2892-109e-6e1b26c2bd8c@c-s.fr>
User-Agent: Mutt/1.4.2.3i
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 24, 2018 at 10:18:44AM +0000, Christophe Leroy wrote:
> On 05/24/2018 06:20 AM, Christophe LEROY wrote:
> >Le 23/05/2018 à 20:34, Segher Boessenkool a écrit :
> >>On Tue, May 22, 2018 at 08:57:01AM +0200, Christophe Leroy wrote:
> >>>The generic csum_ipv6_magic() generates a pretty bad result
> >>
> >><snip>
> >>
> >>Please try with a more recent compiler, what you used is pretty ancient.
> >>It's not like recent compilers do great on this either, but it's not
> >>*that* bad anymore ;-)
> 
> Here is what I get with GCC 8.1
> It doesn't look much better, does it ?

There are no more mfocrf, which is a big speedup.  Other than that it is
pretty lousy still, I totally agree.  This improvement happened quite a
while ago, it's fixed in GCC 6.


Segher
