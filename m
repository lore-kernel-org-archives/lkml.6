Return-Path: <SRS0=QLNC=JI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.5 required=3.0 tests=DKIM_SIGNED,FSL_HELO_FAKE,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,USER_AGENT_MUTT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02100C43143
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 02:24:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A308F23C51
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 02:24:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NU9DUKNl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A308F23C51
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934071AbeFVCYK (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Jun 2018 22:24:10 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:51711 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933353AbeFVCYH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jun 2018 22:24:07 -0400
Received: by mail-wm0-f68.google.com with SMTP id r15-v6so597747wmc.1;
        Thu, 21 Jun 2018 19:24:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=JxQq/b7G04uSwQ9MALz1PIC6SE5Him6XGkLoJiyR1+M=;
        b=NU9DUKNlBgASM4HUbdAtIte1J8N47Eb2z/vJKhawD6ld/um+taVFgIVpEkzJa5Dwh0
         gsOQBoZKPn1dBiKhze4SDBKLH2IlVPBghiVeysvM4VxPdUWGA5BXF3w5XPgPfZqViWzo
         SSzGnaXIQh3jHjWm5RHuOnqdHw0wdlMjYEPu4R1am2C0Br1yBIpbq2XipFnRHjbujBBO
         BbzB6rBRficqAXTxIu2t0gOFloLW5Hj0+o8mWmVuf/8pdxLm5xoHnKz/uO2I7kK+R1rw
         m0csQiLx8/ShafdZ+CSszH5O2HjLj5lEgImceDywm6tkeR7h41JDVc1uetJVrql52QDn
         MyzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=JxQq/b7G04uSwQ9MALz1PIC6SE5Him6XGkLoJiyR1+M=;
        b=VE/QmwTRQzEfdx+puNSkcyz3v9+h1C7ZzXecPneVraoVk7yTelB+cuGkWmOVK39DRX
         1QJ1ykFGQ4+XIQEtbCNBzaJELfwuay7VNd50j8xLMn4ZRYgsffgwUSZ277RM8N1KQn+v
         gnrzyOwcIg1bjnFMUoA82PARz5nDDuLjGvCOamkqYj9dzo9YbItXMyOP4QxYAbVUYZEz
         ibB92fghS84RdFnz4o2tykmDCT+SwhxDZ8hseHGol3nr5QzTKQPkFoXLVtXnk2DuYnKM
         GoUgGYwR52j+yTphTf/DR4aGoGSpsnv2PbHzEf1s0UOvdNe2bxD1kihZqU4WQZKMMaCw
         hmKQ==
X-Gm-Message-State: APt69E3yF25nfGjI1r0myKl8Qoi+lje2H4nqOj+rlPXspdGaqsDs9j3R
        6dPd9jiXt//cpgbc5h4PvtM=
X-Google-Smtp-Source: AAOMgpcLXj9Zw9gfp+NDidWpWk7RkZGesU7K+z08fnRRW8kln1MRbyy/W/dVeUjD1clCH+4HWwe0OA==
X-Received: by 2002:a1c:108b:: with SMTP id 133-v6mr70515wmq.136.1529634246225;
        Thu, 21 Jun 2018 19:24:06 -0700 (PDT)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id e14-v6sm453111wmh.17.2018.06.21.19.24.03
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 21 Jun 2018 19:24:05 -0700 (PDT)
Date:   Fri, 22 Jun 2018 04:24:02 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     mingo@redhat.com, tglx@linutronix.de, akpm@linux-foundation.org,
        hpa@zytor.com, linux-efi@vger.kernel.org,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        virtualization@lists.linux-foundation.org, astrachan@google.com,
        manojgupta@google.com, ghackmann@google.com, sedat.dilek@gmail.com,
        tstellar@redhat.com, keescook@google.com,
        yamada.masahiro@socionext.com, michal.lkml@markovi.net,
        linux-kbuild@vger.kernel.org, geert@linux-m68k.org,
        will.deacon@arm.com, mawilcox@microsoft.com, arnd@arndb.de,
        rientjes@google.com, acme@redhat.com, pombredanne@nexb.com,
        aryabinin@virtuozzo.com, kstewart@linuxfoundation.org,
        boris.ostrovsky@oracle.com, jan.kiszka@siemens.com,
        rostedt@goodmis.org, kirill.shutemov@linux.intel.com,
        ard.biesheuvel@linaro.org, akataria@vmware.com,
        brijesh.singh@amd.com, caoj.fnst@cn.fujitsu.com,
        gregkh@linuxfoundation.org, jarkko.sakkinen@linux.intel.com,
        jgross@suse.com, jpoimboe@redhat.com, mka@chromium.org,
        thomas.lendacky@amd.com, tweek@google.com, mjg59@google.com,
        joe@perches.com, andrea.parri@amarulasolutions.com
Subject: Re: [PATCH v6 3/3] x86: paravirt: make native_save_fl extern inline
Message-ID: <20180622022402.GA24194@gmail.com>
References: <20180621162324.36656-1-ndesaulniers@google.com>
 <20180621162324.36656-4-ndesaulniers@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180621162324.36656-4-ndesaulniers@google.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Nick Desaulniers <ndesaulniers@google.com> wrote:

> native_save_fl() is marked static inline, but by using it as
> a function pointer in arch/x86/kernel/paravirt.c, it MUST be outlined.

> --- a/arch/x86/include/asm/irqflags.h
> +++ b/arch/x86/include/asm/irqflags.h
> @@ -13,7 +13,7 @@
>   * Interrupt control:
>   */
>  
> -static inline unsigned long native_save_fl(void)
> +extern inline unsigned long native_save_fl(void)
>  {
>  	unsigned long flags;
>  

What's the code generation effect of this on say a defconfig kernel vmlinux with 
paravirt enabled?

Thanks,

	Ingo
