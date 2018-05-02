Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751483AbeEBLlc convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Wed, 2 May 2018 07:41:32 -0400
Received: from mx2.suse.de ([195.135.220.15]:35248 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750954AbeEBLlb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 May 2018 07:41:31 -0400
Date: Wed, 2 May 2018 13:41:28 +0200
From: Michal =?UTF-8?B?U3VjaMOhbmVr?= <msuchanek@suse.de>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org,
        npiggin@gmail.com
Subject: Re: [PATCH 4/6] powerpc/64s: Enable barrier_nospec based on
 firmware settings
Message-ID: <20180502134128.4a31b0fc@kitsune.suse.cz>
In-Reply-To: <87vac7r5px.fsf@concordia.ellerman.id.au>
References: <20180424041559.32410-1-mpe@ellerman.id.au>
        <20180424041559.32410-4-mpe@ellerman.id.au>
        <20180426180258.04e6bee6@kitsune.suse.cz>
        <87vac7r5px.fsf@concordia.ellerman.id.au>
Organization: SUSE Linux
X-Mailer: Claws Mail 3.15.1-dirty (GTK+ 2.24.31; x86_64-suse-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 01 May 2018 21:11:06 +1000
Michael Ellerman <mpe@ellerman.id.au> wrote:

> Michal Suchánek <msuchanek@suse.de> writes:
> > Hello,
> >
> > On Tue, 24 Apr 2018 14:15:57 +1000
> > Michael Ellerman <mpe@ellerman.id.au> wrote:
> >  
> >> From: Michal Suchanek <msuchanek@suse.de>
> >> 
> >> Check what firmware told us and enable/disable the barrier_nospec
> >> as appropriate.
> >> 
> >> We err on the side of enabling the barrier, as it's no-op on older
> >> systems, see the comment for more detail.
> >> 
> >> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>  
> ...
> >
> > I am missing the option for the barrier to be disabled by a kernel
> > commandline argument here.
> >
> > It does make sense to add a kernel parameter that is checked on
> > boot to be compatible with other platforms that implement one.  
> 
> No other platforms have an option to disable variant 1 mitigations, so
> there isn't an existing parameter we can use.

Right, I was looking at an older implementation which turned off both
v1 and v2 with same parameter. In current kernel the v1 mitigation is
not turned off at all.
> 
> Which is not to say we can't add one, but I wasn't sure if it was
> really worth it.

The current thinking is that most performance relevant cases are
covered with array_nospec which has little overhead. The less code we
have for this the better ;-)

Thanks

Michal
