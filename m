Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755267AbeEAMZW convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Tue, 1 May 2018 08:25:22 -0400
Received: from ozlabs.org ([203.11.71.1]:42103 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755068AbeEAMZV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 May 2018 08:25:21 -0400
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
From: Michael Ellerman <mpe@ellerman.id.au>
To: Michal =?utf-8?Q?Such=C3=A1nek?= <msuchanek@suse.de>
Cc: linuxppc-dev@ozlabs.org, npiggin@gmail.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/6] powerpc/64s: Add support for ori barrier_nospec patching
In-Reply-To: <20180426181042.38971664@kitsune.suse.cz>
References: <20180424041559.32410-1-mpe@ellerman.id.au> <20180424041559.32410-2-mpe@ellerman.id.au> <20180426181042.38971664@kitsune.suse.cz>
Date: Tue, 01 May 2018 22:25:14 +1000
Message-ID: <87sh7br2ad.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Michal Suchánek <msuchanek@suse.de> writes:
> On Tue, 24 Apr 2018 14:15:55 +1000
> Michael Ellerman <mpe@ellerman.id.au> wrote:
>
>> From: Michal Suchanek <msuchanek@suse.de>
>> 
>> Based on the RFI patching. This is required to be able to disable the
>> speculation barrier.
>
> why do you not patch the nospec barrier which is included as part of
> the RFI flush code?

We didn't want to put it in the asm like you had, because not all RFI
flush types need the spec barrier.

So it's more complicated than just patching in the spec barrier, we'd
need to only patch it in if the configured RFI flush also needed it.

> I think when debugging the code it would make more sense if RFI is
> patched by RFI patcher and nospec by nospec patcher.

True. I think what I'm saying is that the spec barrier in the RFI
flush is not a nospec barrier, it's part of that RFI flush type.

> A separate question is if the RFI flush would break without the nospec
> barrier.

The ORI flush requires it, but the others don't.

cheers
