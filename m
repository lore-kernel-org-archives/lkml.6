Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.4 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,URIBL_SBL,URIBL_SBL_A,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AEE4C433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 19:24:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 53C8F20661
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 19:24:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Sp6W5BpO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 53C8F20661
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727406AbeH3X2I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 19:28:08 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:46070 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727086AbeH3X2I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 19:28:08 -0400
Received: by mail-pg1-f196.google.com with SMTP id m4-v6so4311286pgv.12
        for <linux-kernel@vger.kernel.org>; Thu, 30 Aug 2018 12:24:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=U5gYJVCPjfaPw+Q9m65wk1/MMdBFa0TfpWiFHXJfdMI=;
        b=Sp6W5BpONobDBEAX3BSuZGHvWj6CgzaWwLdMo3Y8AGor3o/CxW3EYg0HKAHWxvOSpB
         1YgG9ysC3X3LmhVMWvMXvDzdQ+cGdb/rPuMIRNJfFoZh+5Co3XZ9Wj+7g6yLfa8jEdNy
         M4JwwkI4zvhxX4gzMTk/p5/JyQrXureELovdXRhGKubAjLI5OqBojNvVfe4UMwXznrxV
         8YtpOfik3VVML3ip75X5UDwsdANc0kiKOLZXI3s8R4bo1d5et5cbkSbodUaEabK/dwck
         qoHNDYI5nHG1HO/P6byK1R1+jdJWHQwPOpEwIDB1ueiwy9xIbuRuw1nWsurZJjIWlOqe
         00jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=U5gYJVCPjfaPw+Q9m65wk1/MMdBFa0TfpWiFHXJfdMI=;
        b=tfusAhbtmU2EUyR20Wo98MEfHv5/gvLWyynyeo0Uts/uOwYP4L+fKpGa79XWhsGPF1
         hU9Q7roDJgn6bfNAJDhK2KS23r6kL/pYx7Ebd8zIey0qo4YHw2H5994sQoieNOvgI2+x
         x/lNE4MmN5pUNhSfuJH/Icr3HF365l3Sqq/BznatIwlutVj/pwcydNn+7GCeGbf9JNg6
         6rgZnBO69FWZ6y1Ci6iFTPl7Fkdv8ZgUnbH39QxgPx8VFFTgvGUVamk3ieTrCxPzDMtw
         AX4VI+SkZWxPSn2+SmvrEzVEWpw1Pk9V9oapf7oZhb+32flukmSFM2R08nnsDv8cbZhL
         T3wg==
X-Gm-Message-State: APzg51AolmVW13QOw62hW6IdJTj+Ba28iC2HjN3Ilp6yYYAfzKFbUNFU
        nnxwPzs4oG689VlPqLHeZYI=
X-Google-Smtp-Source: ANB0VdbBlqW2cn0qDidEIy44nIP9ZmIjSFSplaUPF7VNxa9HVz7qnB/JTzi9e2LNJGRt6v4JlsGxmA==
X-Received: by 2002:a62:9992:: with SMTP id t18-v6mr11723354pfk.239.1535657066639;
        Thu, 30 Aug 2018 12:24:26 -0700 (PDT)
Received: from localhost (108-223-40-66.lightspeed.sntcca.sbcglobal.net. [108.223.40.66])
        by smtp.gmail.com with ESMTPSA id q85-v6sm12601137pfa.151.2018.08.30.12.24.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 30 Aug 2018 12:24:26 -0700 (PDT)
Date:   Thu, 30 Aug 2018 12:24:24 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Joerg Roedel <jroedel@suse.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Michal Hocko <mhocko@suse.com>,
        Andi Kleen <ak@linux.intel.com>,
        the arch/x86 maintainers <x86@kernel.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Pavel Machek <pavel@ucw.cz>
Subject: Re: efi boot failures due to PTI with 32 bit builds and Intel CPUs
Message-ID: <20180830192424.GC6752@roeck-us.net>
References: <20180829201659.GA29801@roeck-us.net>
 <20180830071951.dv6wgnn6ikfhh7yt@suse.de>
 <f6d9bdcd-98a6-fcf2-5308-936ffd714ea7@roeck-us.net>
 <20180830113059.qj6yvw4ggktc7yex@suse.de>
 <915dca84-c98a-fc63-3210-b21dd926b3d4@roeck-us.net>
 <20180830180849.nmh646ehnolphq4v@suse.de>
 <CA+55aFzQwC59pkeA+T3E0G4SZe4dQsYcmnf1eKGYnYpcPTKhSQ@mail.gmail.com>
 <20180830184639.6iv5itjex6y45w3j@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180830184639.6iv5itjex6y45w3j@suse.de>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 30, 2018 at 08:46:39PM +0200, Joerg Roedel wrote:
> On Thu, Aug 30, 2018 at 11:21:49AM -0700, Linus Torvalds wrote:
> > On Thu, Aug 30, 2018 at 11:08 AM Joerg Roedel <jroedel@suse.de> wrote:
> > >
> > > Without a mapped GDT the #PF and #DF handlers also can't be started, so
> > > the machine triple-faults. Below diff fixes it for me, I'll send a
> > > proper patch tomorrow.
> > 
> > Hmm. Is there any reason why this code doesn't just use
> > 
> >         load_fixmap_gdt(0);
> 
> No idea, probably the function didn't exist when the code was written?
> I can change that when writing the patch.
> 
> > and shouldn't it do it after loading the new %cr3?
> 
> That seems more robust, yes. No sure if the old %cr3
> (initial_page_table) has the fixmap gdt mapped at all.

All three variants (hardcoded, call load_fixmap_gdt(0) first, call
load_fixmap_gdt(0) after load_cr3()) work for me. Feel free to add

Tested-by: Guenter Roeck <linux@roeck-us.net>

when you submit the patch.

Thanks a lot for tracking this down!

Guenter
