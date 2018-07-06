Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CA3DC3279B
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 16:33:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 38E182154B
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 16:33:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov-name.20150623.gappssmtp.com header.i=@shutemov-name.20150623.gappssmtp.com header.b="VzIotV7a"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 38E182154B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933708AbeGFQdQ (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 12:33:16 -0400
Received: from mail-pf0-f180.google.com ([209.85.192.180]:33335 "EHLO
        mail-pf0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933616AbeGFQdN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 12:33:13 -0400
Received: by mail-pf0-f180.google.com with SMTP id b17-v6so8867247pfi.0
        for <linux-kernel@vger.kernel.org>; Fri, 06 Jul 2018 09:33:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=QhAwrZLioFwZNQ8dJTel8wBIlhkHmFlnw6qku/VSUPI=;
        b=VzIotV7a7BqgcRYG9Puh9jemUpbsusgV7qFBsEYecaKVjhK/LyZcYngeisV0o31VvZ
         Ml2bSt0IDvELgvZ3dXzLZNUnJX4R9gNf7Pg/2QxPkHoVag3QNDZPOOYla0/rfTqJu0x5
         85pAxZdCN8Jrm/UWP+JC2Hb2XUrJPPmXexD+Aq8k11WV0CGoPcipDo//9am8l4H6dWsz
         cxg3/ij5f8oOmYURcpdnZK6ZrYdC9TRt8Btm4GfrtVAgJhtwX+vhDcSbXa+JJaJQiNmM
         p8/y/saLtKy+E9AVfZ5afMeq1yHnk9/MmEY3mucWntHJvizDtb5/98QG4b5I8poqkL9X
         M23Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=QhAwrZLioFwZNQ8dJTel8wBIlhkHmFlnw6qku/VSUPI=;
        b=VPYjK+IdhPDD1DxAR6lEolfYRTvoKukmX7OMBeH2fix9lMzjGpUEHw3zYWkohSHjxS
         6eZN36/ISsy51xAPZ2yJS6zJ018QiWD9JCJhWQkYKO8NOSAbKdgajxY7XxJ8rkqRISH3
         7qnBvik3n4+QTCNaLegkna7GHLisduvTj65vfApt7P7soPDGvGIh0yqdvHkFaSoOW6m0
         Io9eZnyQE19yAtNPi/rCopXPYjSQZwnq9fd1QRVb7SX8hztHoNZa2cGX6CwozHI7O2MS
         IFw7UfnMHeH6gSXBLPEKuOBxwil8RRy9Q5yc2HJN+olb+dLtihxDLFGGCTgzu8cb9LiF
         IFVg==
X-Gm-Message-State: APt69E0aGKncKAkvogONszSw8v/GNRddjUmUt73CmOihxVdJTYYHZUXv
        MsAuvOVl+rtf5iv0mldwTHbfOg==
X-Google-Smtp-Source: AAOMgpf7iYzeT0OWD2ezBkwUdohly1Tm+oqEkO7WjoXPeC/Cqz3MsjGpfLRAQK318a32aILKnxuiag==
X-Received: by 2002:a62:3856:: with SMTP id f83-v6mr11362189pfa.48.1530894792762;
        Fri, 06 Jul 2018 09:33:12 -0700 (PDT)
Received: from kshutemo-mobl1.localdomain ([192.55.54.44])
        by smtp.gmail.com with ESMTPSA id o65-v6sm12399138pfb.104.2018.07.06.09.33.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 06 Jul 2018 09:33:12 -0700 (PDT)
Received: by kshutemo-mobl1.localdomain (Postfix, from userid 1000)
        id EFC1A30003D; Fri,  6 Jul 2018 19:33:07 +0300 (+03)
Date:   Fri, 6 Jul 2018 19:33:07 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Gabriel C <nix.or.die@gmail.com>
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        Benjamin Gilbert <bgilbert@redhat.com>,
        linux-x86_64@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "H. Peter Anvin" <hpa@zytor.com>, X86 ML <x86@kernel.org>,
        bero@lindev.ch, Andi Kleen <ak@linux.intel.com>,
        Michal Marek <michal.lkml@markovi.net>
Subject: Re: 4.17.x won't boot due to "x86/boot/compressed/64: Handle 5-level
 paging boot if kernel is above 4G"
Message-ID: <20180706163307.2jb6bqx2xvzyxwkr@kshutemo-mobl1>
References: <CAF=P+=5c-baQp-CK1ViG8h=mMRv6d3EgEsN_U4rbBx-Pwv_Krw@mail.gmail.com>
 <20180701213243.GA20180@trogon.sfo.coreos.systems>
 <CAEJqkghSELJRq7r_OrKvixxnT-rUncV==Ej1+jfYZvkMHz=o_w@mail.gmail.com>
 <20180703124403.veiak4vnbxtmwhv2@kshutemo-mobl1>
 <20180703142150.tqckl7miou3wf33q@kshutemo-mobl1>
 <20180704150857.szamkvy6jx3fqxlf@kshutemo-mobl1>
 <CAK7LNARMbt0h4WVdzPzKhMQD-M4ABjffjo4TdtK40RV-NGzTLw@mail.gmail.com>
 <20180706104144.6p2s43o3sqc6d5y3@kshutemo-mobl1>
 <CAK7LNAS9VuoUakpYEfdo5Bki4eic1QuruvNOfra8oUWUn0embA@mail.gmail.com>
 <CAEJqkgiSDdu7a6VyhsrA=rnjevyz2VZZdRVRHBgYHkmHjvAULw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEJqkgiSDdu7a6VyhsrA=rnjevyz2VZZdRVRHBgYHkmHjvAULw@mail.gmail.com>
User-Agent: NeoMutt/20180622
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 06, 2018 at 04:39:28PM +0200, Gabriel C wrote:
> > If not, we do not need to think about that case.
> > Just say "Do not do that".
> 
> I am sorry but I have a hard time to get your logic here.
> 
> You are saying : the *env* variable LDFLAGS as well passing
> LDFLAGS to make , which your build allows should not be use
> because is for 'internal usage' .. ?

Environment variables do not override make variables. Only passing varible
assignment as make argument will do this.

-- 
 Kirill A. Shutemov
