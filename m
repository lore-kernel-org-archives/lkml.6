Return-Path: <SRS0=aB5v=OC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FSL_HELO_FAKE,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CE52C43441
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 11:41:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E908F20861
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 11:41:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kaBVFIuH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E908F20861
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2503854AbeKWWZD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Nov 2018 17:25:03 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:46600 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390529AbeKWWZC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Nov 2018 17:25:02 -0500
Received: by mail-wr1-f68.google.com with SMTP id l9so12026425wrt.13;
        Fri, 23 Nov 2018 03:41:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=AthpPSnMAj/0Mvf97hAuWLGCUd5G7KbAhX2rxPoNpu4=;
        b=kaBVFIuHfFsSqdJcV8a70viD4Xi+MVArFPLsgmrFgio+XdVaB19LP1YwQbv6qr6GaW
         TerJO0nqZ704G4/gy+A8J93/jPH/lnLd7LFcAq70OLjMBIAW9UAWsFYWuZAsvtn83xUF
         gRXvXTaYoLFSbClkATEvZJ9NvEANKIQHdscxsrleWwwBn+wNV+pxaV0IM/7wIsxnCcKq
         Qq26KNXlzXFMFd5KDT47vVUzHvfssYkIhdZVFr5qVVKs/FbTDe77YEk0vZU+NZRqlR2j
         tcYH93MWmLEkPrzVrFt9AySLU3yFJYLxwPSVKdwWqCh0+bD5aAFqwoIcwA128QjVl5V1
         p85A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=AthpPSnMAj/0Mvf97hAuWLGCUd5G7KbAhX2rxPoNpu4=;
        b=Qhsl4vsCPX8nCOl1tPTZ0OMGJiTQ02G2fmCwhVQlUjbxoiatwYfhm0pICO/7TBVWno
         qpmZRkUGZodTC9L8EutGYCatxeH2rYA31OjLKlDrxAEPuEpIhFCW4XMEWa6eZ50pgh9d
         lenulBpQyIqwGlu7JM7OGS2FTWobIxtvQOit6g80WkYavYwTCqxyVT8ijb+S8uE9yQBu
         asz2j3pBvHH0LRQzb4oZj60SwDSXKY4K2YjSIT3LqAjcVzRyMOaDltgOskUiTFoEE+UB
         rcJ0+H8BKiiHKsjmBn8DfeUyoE7zma1PcKyD5LmPyM6w/pWjqwohUl07vGtN5A7ICkCB
         mB4w==
X-Gm-Message-State: AA+aEWa1wOFsZAimrHbTSq+ZyZCO8TMXGwzG4BXJCNh7Sht6ZHCjG+ZC
        VZYi2omtuTag9UikBYp5f9M=
X-Google-Smtp-Source: AFSGD/UsNKIdIfTKKyRX4yq7eF5A3urSOJYKS/frw0m2ICvpOcjM5yoM7QbrbCI/c2U5W5Yir6kjMQ==
X-Received: by 2002:a5d:63c3:: with SMTP id c3mr13239829wrw.215.1542973266055;
        Fri, 23 Nov 2018 03:41:06 -0800 (PST)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id n8sm19157222wrw.59.2018.11.23.03.41.03
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 23 Nov 2018 03:41:05 -0800 (PST)
Date:   Fri, 23 Nov 2018 12:41:02 +0100
From:   Ingo Molnar <mingo@kernel.org>
To:     Borislav Petkov <bp@alien8.de>
Cc:     "Moger, Babu" <Babu.Moger@amd.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "fenghua.yu@intel.com" <fenghua.yu@intel.com>,
        "reinette.chatre@intel.com" <reinette.chatre@intel.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "hpa@zytor.com" <hpa@zytor.com>, "x86@kernel.org" <x86@kernel.org>,
        "mchehab+samsung@kernel.org" <mchehab+samsung@kernel.org>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "kstewart@linuxfoundation.org" <kstewart@linuxfoundation.org>,
        "pombredanne@nexb.com" <pombredanne@nexb.com>,
        "rafael@kernel.org" <rafael@kernel.org>,
        "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
        "tony.luck@intel.com" <tony.luck@intel.com>,
        "qianyue.zj@alibaba-inc.com" <qianyue.zj@alibaba-inc.com>,
        "xiaochen.shen@intel.com" <xiaochen.shen@intel.com>,
        "pbonzini@redhat.com" <pbonzini@redhat.com>,
        "Singh, Brijesh" <brijesh.singh@amd.com>,
        "Hurwitz, Sherry" <sherry.hurwitz@amd.com>,
        "dwmw2@infradead.org" <dwmw2@infradead.org>,
        "Lendacky, Thomas" <Thomas.Lendacky@amd.com>,
        "luto@kernel.org" <luto@kernel.org>,
        "joro@8bytes.org" <joro@8bytes.org>,
        "jannh@google.com" <jannh@google.com>,
        "vkuznets@redhat.com" <vkuznets@redhat.com>,
        "rian@alum.mit.edu" <rian@alum.mit.edu>,
        "jpoimboe@redhat.com" <jpoimboe@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>
Subject: Re: [PATCH v9 01/13] x86/resctrl: Rename and move rdt files to new
 directory
Message-ID: <20181123114102.GB130228@gmail.com>
References: <20181121202811.4492-1-babu.moger@amd.com>
 <20181121202811.4492-2-babu.moger@amd.com>
 <20181123072839.GA51597@gmail.com>
 <20181123082258.GA30697@zn.tnic>
 <20181123084117.GA130228@gmail.com>
 <20181123090011.GB30697@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181123090011.GB30697@zn.tnic>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Borislav Petkov <bp@alien8.de> wrote:

> On Fri, Nov 23, 2018 at 09:41:17AM +0100, Ingo Molnar wrote:
> > Then at least make the directory name resource_control/, which is only 
> > marginally longer and a lot more readable.
> > 
> > We really don't have to fit directly names into the 8 character DOS limit 
> > anymore. ;-)
> 
> How about
> 
> resource_ctl
> 
> ?

The thing is, thinking about this as a 'CPU resource' is really a 
misnomer on the conceptual level, which is why it's bothering me: RDT is 
not really about 'CPU resources', because registers are CPU resources, 
ioports and iomem are CPU resources, APICs are CPU resources and PMU 
events are resources - none of which is part of RDT.

The key difference in RDT is that they are *shared* resources - caches 
really - where the ad-hoc cache sharing might be causing security and 
scalability problems so there's partitioning and throttling (bandwidth 
control) support in the hardware.

Is there any other resource handled than caches by RDT or by the AMD 
variant?

So how about "cache_control"? It's shorter and a lot closer to what the 
code actually does.

> resource_control/ is kinda long-ish and the other names we have there
> are nice and short, see below.
> 
> BTW, while we're talking renaming, I have a patch which renames the MCE
> pile and am planning to slap it in around -rc6 timeframe since we don't
> have a lot of RAS commits this time around, see also the end of this
> mail. It makes the naming there all nicely regular. :)

That's cool - these IMHO need to be done periodically to keep overall 
namespace complexity low enough. (As long as can be done without breaking 
any ABI that is.)

>  15 files changed, 14 insertions(+), 14 deletions(-)
>  rename arch/x86/kernel/cpu/{mcheck => mce}/Makefile (52%)
>  rename arch/x86/kernel/cpu/{mcheck/mce_amd.c => mce/amd.c} (99%)
>  rename arch/x86/kernel/cpu/{mcheck/mce-apei.c => mce/apei.c} (99%)
>  rename arch/x86/kernel/cpu/{mcheck/mce.c => mce/core.c} (99%)
>  rename arch/x86/kernel/cpu/{mcheck => mce}/dev-mcelog.c (99%)
>  rename arch/x86/kernel/cpu/{mcheck/mce-genpool.c => mce/genpool.c} (99%)
>  rename arch/x86/kernel/cpu/{mcheck/mce-inject.c => mce/inject.c} (99%)
>  rename arch/x86/kernel/cpu/{mcheck/mce_intel.c => mce/intel.c} (99%)
>  rename arch/x86/kernel/cpu/{mcheck/mce-internal.h => mce/internal.h} (100%)
>  rename arch/x86/kernel/cpu/{mcheck => mce}/p5.c (100%)
>  rename arch/x86/kernel/cpu/{mcheck/mce-severity.c => mce/severity.c} (99%)
>  rename arch/x86/kernel/cpu/{mcheck => mce}/therm_throt.c (100%)
>  rename arch/x86/kernel/cpu/{mcheck => mce}/threshold.c (100%)
>  rename arch/x86/kernel/cpu/{mcheck => mce}/winchip.c (100%)

Standardizing around 'MCE' sounds good to me!

Thanks,

	Ingo
