Return-Path: <SRS0=A7nN=N3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6CCFC43441
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 00:04:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 75F522145D
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 00:04:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 75F522145D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=telegraphics.com.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729096AbeKPKO0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Nov 2018 05:14:26 -0500
Received: from kvm5.telegraphics.com.au ([98.124.60.144]:44874 "EHLO
        kvm5.telegraphics.com.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726409AbeKPKO0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Nov 2018 05:14:26 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
        by kvm5.telegraphics.com.au (Postfix) with ESMTP id 696ED27840;
        Thu, 15 Nov 2018 19:04:15 -0500 (EST)
Date:   Fri, 16 Nov 2018 11:04:17 +1100 (AEDT)
From:   Finn Thain <fthain@telegraphics.com.au>
To:     Michael Schmitz <schmitzmic@gmail.com>
cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Stephen N Chivers <schivers@csc.com.au>,
        Thomas Gleixner <tglx@linutronix.de>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        John Stultz <john.stultz@linaro.org>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Philip Blundell <philb@gnu.org>,
        Joshua Thompson <funaho@jurai.org>
Subject: Re: [RFC PATCH 06/13] m68k: Drop ARCH_USES_GETTIMEOFFSET
In-Reply-To: <9685f2d3-a492-29c3-a687-62a17e76b212@gmail.com>
Message-ID: <alpine.LNX.2.21.1811161057070.35@nippy.intranet>
References: <cover.1541995959.git.fthain@telegraphics.com.au> <74edaee07800f91eb416ab3e72c4670b8ef4bd4e.1541995959.git.fthain@telegraphics.com.au> <CAMuHMdXdo+L-Ta04zUsL62RSt1HOvmPJs7HFu_zEnc38R0FPjA@mail.gmail.com> <alpine.LNX.2.21.1811122002530.351@nippy.intranet>
 <fb617c67-089b-c4c0-2f47-28db41ffca6c@gmail.com> <alpine.LNX.2.21.1811131413210.362@nippy.intranet> <b824e485-796c-cbb6-9e50-504b03accd5d@gmail.com> <alpine.LNX.2.21.1811131700010.366@nippy.intranet> <0054c37f-ef34-e892-ff1d-02968ab529fa@gmail.com>
 <alpine.LNX.2.21.1811140905440.371@nippy.intranet> <73f75453-ce74-2c13-ba7c-f36f976d4ff7@gmail.com> <ab36d408-a05f-f220-1c2b-b88333f1c33b@gmail.com> <459ad559-99bd-0196-13f4-80440cd39671@gmail.com> <9685f2d3-a492-29c3-a687-62a17e76b212@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 15 Nov 2018, Michael Schmitz wrote:

> 
> Well, it sort of works - I've seen one login timeout on the console 
> under load (less than 10 seconds after typing in the password), but most 
> attempts went OK. Couldn't log in through SSH without increasing fatal: 
> Timeout before authenticationthe LoginGraceTime parameter though.
> 
> I usually get reliable login using ssh key files with the default 
> setting of 120 seconds (takes around 90 to 100 seconds to complete). 
> With your patch, even increasing this to 4800 doesn't result in reliable 
> login.
> 
> The error I see in the logs is 'fatal: Timeout before authentication'.
> 

Weird. Let's try 2942e9fd3e57. Please send me your .config so I can send 
you a kernel binary. (I don't trust gcc 4.6 on m68k...)

-- 

> Cheers,
> 
> 	Michael
> 
> 
