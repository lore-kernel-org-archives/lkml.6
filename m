Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751287AbeEDA6a convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Thu, 3 May 2018 20:58:30 -0400
Received: from ozlabs.org ([203.11.71.1]:56505 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751126AbeEDA62 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 May 2018 20:58:28 -0400
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
From: Michael Ellerman <mpe@ellerman.id.au>
To: Michal =?utf-8?Q?Such=C3=A1nek?= <msuchanek@suse.de>
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org,
        npiggin@gmail.com
Subject: Re: [PATCH 4/6] powerpc/64s: Enable barrier_nospec based on firmware settings
In-Reply-To: <20180502134128.4a31b0fc@kitsune.suse.cz>
References: <20180424041559.32410-1-mpe@ellerman.id.au> <20180424041559.32410-4-mpe@ellerman.id.au> <20180426180258.04e6bee6@kitsune.suse.cz> <87vac7r5px.fsf@concordia.ellerman.id.au> <20180502134128.4a31b0fc@kitsune.suse.cz>
Date: Fri, 04 May 2018 10:58:26 +1000
Message-ID: <87bmdw9qz1.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Michal Suchánek <msuchanek@suse.de> writes:
> On Tue, 01 May 2018 21:11:06 +1000
> Michael Ellerman <mpe@ellerman.id.au> wrote:
>> Michal Suchánek <msuchanek@suse.de> writes:
>> > On Tue, 24 Apr 2018 14:15:57 +1000
>> > Michael Ellerman <mpe@ellerman.id.au> wrote:
>> >  
>> >> From: Michal Suchanek <msuchanek@suse.de>
>> >> 
>> >> Check what firmware told us and enable/disable the barrier_nospec
>> >> as appropriate.
>> >> 
>> >> We err on the side of enabling the barrier, as it's no-op on older
>> >> systems, see the comment for more detail.
>> >> 
>> >> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>  
>> ...
>> >
>> > I am missing the option for the barrier to be disabled by a kernel
>> > commandline argument here.
>> >
>> > It does make sense to add a kernel parameter that is checked on
>> > boot to be compatible with other platforms that implement one.  
>> 
>> No other platforms have an option to disable variant 1 mitigations, so
>> there isn't an existing parameter we can use.
>
> Right, I was looking at an older implementation which turned off both
> v1 and v2 with same parameter. In current kernel the v1 mitigation is
> not turned off at all.

Ah OK.

>> Which is not to say we can't add one, but I wasn't sure if it was
>> really worth it.
>
> The current thinking is that most performance relevant cases are
> covered with array_nospec which has little overhead. The less code we
> have for this the better ;-)

Amen to that :)

cheers
