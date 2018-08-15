Return-Path: <SRS0=5j8r=K6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,URIBL_SBL,URIBL_SBL_A,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91D78C4321D
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 19:26:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E91E21509
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 19:26:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QSn6wkAT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4E91E21509
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727709AbeHOWUB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Aug 2018 18:20:01 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:40506 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725941AbeHOWUA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Aug 2018 18:20:00 -0400
Received: by mail-pg1-f193.google.com with SMTP id x5-v6so919128pgp.7;
        Wed, 15 Aug 2018 12:26:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=48u/BImmfj7dT4scPmdA91KJouWhuBqJWqwCJp/3MQw=;
        b=QSn6wkATDaQYMK7JrFG3QvnwgUns2q/AD1tg7mcJJhrzdkXZZ/1VSxCD7d2DCAFlO9
         MWIqedJXOEWWT/vVFSpEUXxEeRiv0w9gyn7jZMy8VroGxFBJ0GwF5jIp9o3l93O9rU2c
         /JmP/6tjzWkfN2dVyELtQhaaRkFsBQArlaDquubSCVVqVjjjTf/Qq2BNGUY4xzaV/mGk
         ht3j2V5xPyKNFazFgdPhVTtv4zyUocXmK/uEuMVMnr221i9ouNR+IOnJEuPyjWdwBzBq
         AEErfXLtIEYvSbiyvRDOtWqvdUj8Y07QfwNlOoNamcE7mJYzg6ufruxp+qfrB0Vrbjhc
         k3Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=48u/BImmfj7dT4scPmdA91KJouWhuBqJWqwCJp/3MQw=;
        b=C7j+qnTbtubLcbxJA66/xqpeZUib5/L9XsjK/0K7H03DqaVCnKzYe4RKmPvKLEvuZS
         pwwHcalr+rTcSyzIn0RSD9fDTpXjRQtGQNGo05OsNsARQoUHpuL5fJYN2UaPMlcXp361
         SvCjNwzqpsxjQXBpIwq+v2oyjWHbLwJCAl8beagJUGCkk269Fx1vYWhyKfxSuYBxPn0r
         si5l0/69dFOdBinSsa3mXm0laJ9kk7F1LJYDNzQmQZDLOb2Ww/whDcoJoi6bDVaZVZ4j
         umS4Tw4LlWKDnUQiy67IdATKR3A8eyGIupX1KvtsZrbnggD5kdrp8n8LDdqGFSfshwiB
         oNeA==
X-Gm-Message-State: AOUpUlF4S4ug8F8V1twCoB5rls3F6YXPDxl0M1TWW6WM8KxppJfBBdkQ
        pQ9yozt6fqWsBDKR+Vnp7oXrk4FG
X-Google-Smtp-Source: AA+uWPzY6XoYFfx1UgajJGah+7HLnqGcWX4p/3+hxPlw1rGZmaER9iZXc2JxhcplZFjC124evit27g==
X-Received: by 2002:a62:b40c:: with SMTP id h12-v6mr29278732pfn.18.1534361192419;
        Wed, 15 Aug 2018 12:26:32 -0700 (PDT)
Received: from localhost (108-223-40-66.lightspeed.sntcca.sbcglobal.net. [108.223.40.66])
        by smtp.gmail.com with ESMTPSA id r198-v6sm54932955pgr.8.2018.08.15.12.26.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 15 Aug 2018 12:26:31 -0700 (PDT)
Date:   Wed, 15 Aug 2018 12:26:30 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Sebastian Gottschall <s.gottschall@dd-wrt.com>
Cc:     Sven Joachim <svenjoac@gmx.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: Re: [PATCH 4.9 000/107] 4.9.120-stable review
Message-ID: <20180815192630.GA20575@roeck-us.net>
References: <20180814171520.883143803@linuxfoundation.org>
 <6272e062-6cfc-0669-bebf-ebb039da051a@dd-wrt.com>
 <87k1orms9i.fsf@turtle.gmx.de>
 <55df6754-ce8c-520a-13f9-c610ac498173@dd-wrt.com>
 <20180815185553.GA18219@roeck-us.net>
 <69700876-f31a-ea0a-bdea-2e82b7a5d308@dd-wrt.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <69700876-f31a-ea0a-bdea-2e82b7a5d308@dd-wrt.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 15, 2018 at 09:08:08PM +0200, Sebastian Gottschall wrote:
> 
> Am 15.08.2018 um 20:55 schrieb Guenter Roeck:
> >On Wed, Aug 15, 2018 at 08:27:00PM +0200, Sebastian Gottschall wrote:
> >>if i fix the other error (can be reproduced with disable smp on standard
> >>i386 build)
> >>
> >>another raises up again related to smp. to be serious. this patchset of x86
> >>patches is absolutelly broken and put together without any care. not a
> >>simple compile test has been done
> >>
> >>sorry for beeing a little bit upset. i'm sure i will find other bugs if i go
> >>deeper
> >>
> >It might possibly help if you would consider to publish your configuration(s).
> >
> >As for "not a simple compile test has been done", please have a look
> >at http://kerneltests.org/builders. I guess those compile (and boot)
> >tests don't count as "simple". I assume the same applies to all the
> >builds done by 0day and all the other test builders.
> >
> >Guenter
> 
> it was nothing special. just a standard x86 build with smp disabled. that
> triggers all of them. so this should be a common build configuration for
> testing
> these issues are covered by the rc3 patch of 4.9 right now
> 
> the issue reported by sven can be triggered by just compiling rtc-cmos.c
> which is caused by the change in dmi.h  (asm/io.h was replaced by
> linux/io.h)
> so this driver should be included in all x86 and x64 builds and must be
> uncovered in any simple compile test
> 
> btw. this issue is still unresolved but simple to fix
> 
> --- arch/x86/include/asm/i8259.h        (revision 36620)
> +++ arch/x86/include/asm/i8259.h        (working copy)
> @@ -2,6 +2,7 @@
>  #define _ASM_X86_I8259_H
> 
>  #include <linux/delay.h>
> +#include <asm/io.h>
> 

Also seen in mainline. Meaning my non-SMP test builds are broken. Hmm.

Anyway, care to send a proper patch ? I am sure Linus will be more
than happy to apply it.

Thanks,
Guenter
