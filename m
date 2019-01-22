Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A0D8C282C3
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 13:08:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A2D8F21019
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 13:08:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov-name.20150623.gappssmtp.com header.i=@shutemov-name.20150623.gappssmtp.com header.b="a/l+QbVc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728471AbfAVNIG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 08:08:06 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:46692 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728390AbfAVNIG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 08:08:06 -0500
Received: by mail-pl1-f195.google.com with SMTP id t13so11449202ply.13
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jan 2019 05:08:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=4wni7hajAynAQ3IhMurTkKg3VYM8RlUZEkdP4Omy5PU=;
        b=a/l+QbVclKT3JMyMq2BmvMg/YPvobHaMLHdP5UQMDk3y7BwML7x22ziUZHkU4NR+1m
         rSd6U0wLYPG3QE7wcXn2Q7/O0tmnMfH9eKQwQq4J3mPEvmncyem9bcA8KsrPR2suE4T6
         t+r9ONam+xCnEpHcEKA13ywQTkV9o72xFIydGxqhOqhdyykh3iBDQRu6UMAITDFdXb+x
         jiTQwfvG167aqpje4UMDx0adCXFAKU01pJpQl28hv0ew43hp6K8V/CRxlopXWYwp/JM1
         yR+TD1s0kwAeI1ZTQqvZ1Hh+g6sXkJwq2lxnouBZ5tOhKYxdJIBL1zQHeZHOr4REX14Z
         57Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=4wni7hajAynAQ3IhMurTkKg3VYM8RlUZEkdP4Omy5PU=;
        b=Mh2e05KWlEjGwHA1GmviANhrGS1FoABTBKtzNdVqJA1TiOxSdTOR0yuCeuntPOzSYe
         QGzZdD2got1aoVcxsvdjmc0UaL6iQDlvW/jgQwpOKc1pKNW4wNT5VQ0DXKgzk8pk9w4U
         xKg6RtzLlen+fs3xfbEAQqS/tUdn9NWjPKGO8ipeQ56eE2x88OSthlhohSVWQ5klmz7X
         gozPBcavjSw90nWx5QiAPiwl8C2IEIkCjw7rSob87VP/JcNYKfD/ztINw0BoxP31iFAT
         WSerdKUyhG+RQ6HKfCp5+brOcp8BpoDm8IpFSdCvG+Ny3WYEuaVnAfQc9bTKbRmvENb6
         0/Zg==
X-Gm-Message-State: AJcUukcKWoyT1SCtNUoXjHM8YJnont2fEBPBrhWX/qO1abSCsDSvwCLl
        FKgGZ01aFrXvkFOkkEM9QyS/Nw==
X-Google-Smtp-Source: ALg8bN5rpY+J1tuR3+gDiuT6XlplxSbPzrnjmGzS/MN60A1dXsvq0booKulVVaeH7R21cKLIfSGpNw==
X-Received: by 2002:a17:902:ab84:: with SMTP id f4mr33416531plr.207.1548162485428;
        Tue, 22 Jan 2019 05:08:05 -0800 (PST)
Received: from kshutemo-mobl1.localdomain ([192.55.54.40])
        by smtp.gmail.com with ESMTPSA id x12sm15370184pgr.55.2019.01.22.05.08.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 22 Jan 2019 05:08:04 -0800 (PST)
Received: by kshutemo-mobl1.localdomain (Postfix, from userid 1000)
        id 44869301A3F; Tue, 22 Jan 2019 16:08:00 +0300 (+03)
Date:   Tue, 22 Jan 2019 16:08:00 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Cao jin <caoj.fnst@cn.fujitsu.com>
Cc:     kirill.shutemov@linux.intel.com,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, bp@alien8.de,
        "H. Peter Anvin" <hpa@zytor.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: question about head_64.S
Message-ID: <20190122130800.cpfor3klov22badb@kshutemo-mobl1>
References: <6aebbf86-2ba1-c517-dc47-054279daec49@cn.fujitsu.com>
 <023da151-bb1d-1b11-ec1d-01eb675d528f@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <023da151-bb1d-1b11-ec1d-01eb675d528f@cn.fujitsu.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 22, 2019 at 03:31:25PM +0800, Cao jin wrote:
> Hi, Kirll,
> 
> On 1/15/19 7:45 PM, Cao jin wrote:
> > Hi,
> >   I have been digging into this file for a while, and I still have 2
> > questions unclear, hope to get your help.
> > 
> 
> > 
> > 2.
> > Why gdt64 has following definition?:
> > 
> > gdt64:
> > 	.word	gdt_end - gdt
> > 	.long	0
> > 	.word	0
> > 	.quad   0
> > 
> > obviously, gdt64 stores the GDTR content under x86_64, which is 10 bytes
> > long, so why not just:
> > 
> > gdt64:
> > 	.word	gdt_end - gdt
> > 	.quad   0
> > 
> > With above modification, it can boot.
> > 
> 
> Seems you introduced gdt64 code in commit beebaccd50, could you help
> with this question?

Looks like you are right. I've got confused at some point.

Could you prepare a patch?

> And it also remind me of another question about adjust_got which is also
> introduced by you. Because I failed to construct a test environment with
> ld version less than 2.24 until now, so I wanna do a quick ask here:
> does it make sense to adjust GOT from the 4th entry of it? Because as I
> know, the first 3 entries are special one, which (I guess) will be not used.

No.

These 3 entries are reserved for a special symbols (like entry 0 for
_DYNAMIC). It means linker should not use these entries for normal
symbols, but it doesn't mean that they don't need to be adjusted during
the load.

-- 
 Kirill A. Shutemov
