Return-Path: <SRS0=Hds+=OG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB17EC43441
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 08:05:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 61AD321104
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 08:05:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov-name.20150623.gappssmtp.com header.i=@shutemov-name.20150623.gappssmtp.com header.b="1hLvqlF/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 61AD321104
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729283AbeK0TCY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 14:02:24 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:38621 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728838AbeK0TCX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 14:02:23 -0500
Received: by mail-pg1-f195.google.com with SMTP id g189so7498471pgc.5
        for <linux-kernel@vger.kernel.org>; Tue, 27 Nov 2018 00:05:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=epFiVLwqCp/R4eBuKQfBRJX+WiG/Ul2Rk0nvnuDdVkE=;
        b=1hLvqlF/dPJQQfe8oIX/JXTjigWqI5Fc8ZNwYETuYRPnKF4ysgv6Ss11LREJblL1pG
         3JbxSnhFj4P6lhyYPoG1uVZc8NTpvwFH+GavS9xhmR15sK3HXra76ZpWuOxhJz5tT2AR
         AXMdwiLmQSrC6f3zvgsBzF7LIUTHp5fxDOMgxXMnLif8AEH9xdnIjvZgumz3VBkrEVmw
         yvKh4NPgiOxLjagYnXd/Yv0uEiPg150GtjqFWW9XYlwPs7ThtpYpifle72y7Q2xisyFq
         jgsQSQzxUrI0zv4gJW1r9cfLBtJw+7iGOyH1N/+32COuKLFYCL10cWwNpoEu+jIdSCzQ
         nzOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=epFiVLwqCp/R4eBuKQfBRJX+WiG/Ul2Rk0nvnuDdVkE=;
        b=sRGZ7SQ5xCv83BI8/JwvyI/Vh/UPqB8kDzZtmhlqzlBHpoAU6uDfngcSqBQbWfT0hw
         tY6Jj7HcZ8VfuGNDZiZEyyg4+nr5fh9VrTlLhgeqMms/75bZENiEX3dLjatW9FWD7R8c
         Sf0H9q17BqFe9J5x44eOzxfoZhVagKBy4iY6qrDRrPz4MKM4H14biJNXDPZUDDb5fP5b
         P6E7jO/ulNRR7KiA4Bh6Q4FPiuoRFLlTQiWisTGviAwzJ6itPkVPKUAfQlLVI3WYrxem
         kWqsC7UFD+Vf0hJ5fZn/iOZjmmHvRkM79zIpagF1UkAGhAruvwUa+KGW0JZxrimk9I6K
         x6QQ==
X-Gm-Message-State: AGRZ1gIvHl732lwKYSaVbocsbcvE896A6E+DTCt+/OZDvuoMJrQwNV2U
        BcvsYx6140mTScLK1h68W8AYfg==
X-Google-Smtp-Source: AJdET5fM/a7q9/tmMtwwv+Q12mpm+WTsjxSezEol6Rs2x0uREU2DbkzoIjN+C4McuGxbOOex93SW3w==
X-Received: by 2002:a62:6408:: with SMTP id y8mr31692690pfb.202.1543305920097;
        Tue, 27 Nov 2018 00:05:20 -0800 (PST)
Received: from kshutemo-mobl1.localdomain (fmdmzpr03-ext.fm.intel.com. [192.55.54.38])
        by smtp.gmail.com with ESMTPSA id b7sm3492586pfa.52.2018.11.27.00.05.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 27 Nov 2018 00:05:19 -0800 (PST)
Received: by kshutemo-mobl1.localdomain (Postfix, from userid 1000)
        id 99CC63003AF; Tue, 27 Nov 2018 11:05:15 +0300 (+03)
Date:   Tue, 27 Nov 2018 11:05:15 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Heiko Carstens <heiko.carstens@de.ibm.com>
Cc:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Li Wang <liwang@redhat.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Janosch Frank <frankja@linux.vnet.ibm.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: Re: [PATCH 3/3] s390/mm: fix mis-accounting of pgtable_bytes
Message-ID: <20181127080515.py6naga4gsi2yad2@kshutemo-mobl1>
References: <1539621759-5967-1-git-send-email-schwidefsky@de.ibm.com>
 <1539621759-5967-4-git-send-email-schwidefsky@de.ibm.com>
 <CAEemH2cHNFsiDqPF32K6TNn-XoXCRT0wP4ccAeah4bKHt=FKFA@mail.gmail.com>
 <20181031073149.55ddc085@mschwideX1>
 <20181031100944.GA3546@osiris>
 <20181031103623.6ykzsjdenrpeth7x@kshutemo-mobl1>
 <20181127073411.GA3625@osiris>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181127073411.GA3625@osiris>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 27, 2018 at 08:34:12AM +0100, Heiko Carstens wrote:
> On Wed, Oct 31, 2018 at 01:36:23PM +0300, Kirill A. Shutemov wrote:
> > On Wed, Oct 31, 2018 at 11:09:44AM +0100, Heiko Carstens wrote:
> > > On Wed, Oct 31, 2018 at 07:31:49AM +0100, Martin Schwidefsky wrote:
> > > > Thanks for testing. Unfortunately Heiko reported another issue yesterday
> > > > with the patch applied. This time the other way around:
> > > > 
> > > > BUG: non-zero pgtables_bytes on freeing mm: -16384
> > > > 
> > > > I am trying to understand how this can happen. For now I would like to
> > > > keep the patch on hold in case they need another change.
> > > 
> > > FWIW, Kirill: is there a reason why this "BUG:" output is done with
> > > pr_alert() and not with VM_BUG_ON() or one of the WARN*() variants?
> > > 
> > > That would to get more information with DEBUG_VM and / or
> > > panic_on_warn=1 set. At least for automated testing it would be nice
> > > to have such triggers.
> > 
> > Stack trace is not helpful there. It will always show the exit path which
> > is useless.
> 
> So, even with the updated version of these patches I can flood dmesg
> and the console with
> 
> BUG: non-zero pgtables_bytes on freeing mm: 16384
> 
> messages with this complex reproducer on s390:
> 
> echo "void main(void) {}" | gcc -m31 -xc -o compat - && ./compat
> 
> Besides that this needs to be fixed, I'd really like to see this
> changed to either a printk_once() or a WARN_ON_ONCE() within
> check_mm() so that an arbitrary user cannot flood the console.
> 
> E.g. something like the below. If there aren't any objections, I will
> provide a proper patch with changelog, etc.
> 
> diff --git a/kernel/fork.c b/kernel/fork.c
> index 07cddff89c7b..d7aeec03c57f 100644
> --- a/kernel/fork.c
> +++ b/kernel/fork.c
> @@ -647,8 +647,8 @@ static void check_mm(struct mm_struct *mm)
>  	}
>  
>  	if (mm_pgtables_bytes(mm))
> -		pr_alert("BUG: non-zero pgtables_bytes on freeing mm: %ld\n",
> -				mm_pgtables_bytes(mm));
> +		printk_once(KERN_ALERT "BUG: non-zero pgtables_bytes on freeing mm: %ld\n",
> +			    mm_pgtables_bytes(mm));

You can be the first user of pr_alert_once(). Don't miss a chance! ;)

-- 
 Kirill A. Shutemov
