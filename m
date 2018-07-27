Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DB8CC6778F
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 13:49:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 83DA5208B2
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 13:49:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov-name.20150623.gappssmtp.com header.i=@shutemov-name.20150623.gappssmtp.com header.b="y6d7HfV4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 83DA5208B2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731149AbeG0PLr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Jul 2018 11:11:47 -0400
Received: from mail-pl0-f65.google.com ([209.85.160.65]:38732 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730340AbeG0PLr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jul 2018 11:11:47 -0400
Received: by mail-pl0-f65.google.com with SMTP id b1-v6so2353107pls.5
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jul 2018 06:49:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ny1o2jg810v9ouTwzCbO2A3MzDraCvLp2H0T87kOVPg=;
        b=y6d7HfV4EDeU21cyNvCkp355HAhpSSyLVVWJnLE40UxDxqAqxADYM+nGa9vT442VgR
         ItDW5+5VgnUm2BebYY1az3Eh9wYMuJ1MNOSK07J2Ee58ciNXTa9Kxh3EfyAN5CVO8q7O
         YliPhrGa1CJWv1okVqCiC9dFp8zX1tK+KdzjCDk4Rch63LjwzwZLF6Us2RU+jbTzeSdo
         3bUJ+s4YTg0zXmVwaNlkJ+zmALWcRqs59qxKfVTfhl/0Ueozxiy73+/8T3Dgc82pWBXE
         BgGRsYV9u6V7HAwNrbqHF1JxmcLsPgrc2/ZUfwFfsSLUdbHdhIQDZ8DwDVvQigXxs/CF
         n+Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ny1o2jg810v9ouTwzCbO2A3MzDraCvLp2H0T87kOVPg=;
        b=ZRCwzllv3Y4X+1/iiObo5hN6/ri7WqRsDVKbWXgmbbU4muFVkV04VDL0UACa/CtTDf
         6WWiFdbxWXUT1o5DpKkDkwJArQAG0KQkuLCjoivy9KLhpchZTxpL0c8upZByTGscEmw9
         z5iyYVPRs+MgnFFs3VZganfQ0ftOxpjGiYSEKjg7f3oJNMP0A6dZVWlSVqLhhMEWnSNb
         WSJo7HxHkVjXY2hKllYzLlUyiQB5dPe0ApJ7obW+T/giMroXmV9Drw51gqM+x5kthD2D
         4HD9zZwVKm+ldQRc0w51I76ACw6FziCE/7nqV7jBIVDor4Bt40U6DX06oDHOCTY3kSJv
         9mFA==
X-Gm-Message-State: AOUpUlF1lHUOhANv7LLUEHQMG5aWBQHSHeCCQWowuVZ0s0JI6G0AYyPI
        1vCqaCRrzBn6tfaFGiboNHrgSg==
X-Google-Smtp-Source: AAOMgpcYBkOypYm2n3R2TTHnwjFC6lA4GgadfghRaGQ1KyyrJZDU90JlD23zBPL4YjA0oOPruZGZ5w==
X-Received: by 2002:a17:902:32a4:: with SMTP id z33-v6mr1877985plb.226.1532699386063;
        Fri, 27 Jul 2018 06:49:46 -0700 (PDT)
Received: from kshutemo-mobl1.localdomain ([134.134.139.83])
        by smtp.gmail.com with ESMTPSA id b62-v6sm11142425pfm.97.2018.07.27.06.49.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 27 Jul 2018 06:49:45 -0700 (PDT)
Received: by kshutemo-mobl1.localdomain (Postfix, from userid 1000)
        id 3C6953002A5; Fri, 27 Jul 2018 16:49:41 +0300 (+03)
Date:   Fri, 27 Jul 2018 16:49:41 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Kai Huang <kai.huang@linux.intel.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCHv5 18/19] x86/mm: Handle encrypted memory in
 page_to_virt() and __pa()
Message-ID: <20180727134941.mljg2biwughv2yhr@kshutemo-mobl1>
References: <20180717112029.42378-1-kirill.shutemov@linux.intel.com>
 <20180717112029.42378-19-kirill.shutemov@linux.intel.com>
 <alpine.DEB.2.21.1807182356520.1689@nanos.tec.linutronix.de>
 <20180723101201.wjbaktmerx3yiocd@kshutemo-mobl1>
 <9966c343-1247-b505-b736-b06509e15d10@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9966c343-1247-b505-b736-b06509e15d10@intel.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 26, 2018 at 10:26:23AM -0700, Dave Hansen wrote:
> On 07/23/2018 03:12 AM, Kirill A. Shutemov wrote:
> > page_to_virt() definition overwrites default macros provided by
> > <linux/mm.h>. We only overwrite the macros if MTKME is enabled
> > compile-time.
> 
> Can you remind me why we need this in page_to_virt() as opposed to in
> the kmap() code?  Is it because we have lots of 64-bit code that doesn't
> use kmap() or something?

I just found it most suitable. It should cover all cases, even if kmap()
is not used.

-- 
 Kirill A. Shutemov
