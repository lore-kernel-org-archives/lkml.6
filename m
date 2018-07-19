Return-Path: <SRS0=/F/O=KD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D20AC468C6
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 07:22:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C1A120693
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 07:22:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov-name.20150623.gappssmtp.com header.i=@shutemov-name.20150623.gappssmtp.com header.b="0SLvjTn9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3C1A120693
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730432AbeGSIEP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Jul 2018 04:04:15 -0400
Received: from mail-pl0-f53.google.com ([209.85.160.53]:46686 "EHLO
        mail-pl0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727451AbeGSIEO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jul 2018 04:04:14 -0400
Received: by mail-pl0-f53.google.com with SMTP id t17-v6so667047ply.13
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jul 2018 00:22:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=CQnIrC/UF3jw2Pp17aC6lk4RP7cOOWSL/mYL4siOjeM=;
        b=0SLvjTn9qryo7iJhVB424QYE0aaGBCFoxvaRHPY0Ds5DwKxp68+HwFWONLVSnXDTE8
         P/0H8/5JuhUed55jB01NhnADn3n4/Tt0obJfldtsLtDc7zFyGbaHKQjsPXve++25WAnF
         oIOkQgsOMMO74CakxyyRS3hZvi7wkHAxQvHfac3/tvt9pijrNHoTl/0QCSSWQYCNK8cT
         hyItoOVdWa9Q7600lmG8rI4YU/diCKs5kxcFrenqYWiUBdAhJ4QQGSU4+wFLaQamSTZc
         hfFHT+JoaFM1AUdrgG+81gc0EbYE0u9Rl6l/MaVjqAEbPBrPT8R6AgfB8i/JoIwFmrX4
         NH7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=CQnIrC/UF3jw2Pp17aC6lk4RP7cOOWSL/mYL4siOjeM=;
        b=iw69u29+0M1AMk6O15QEXmbGMzpVBff/K80EDLu/IpTe5rwn5Vu3s7v/rzeYU+5Ur1
         11CLKlT+N27CzWeGCCN2JEQR5cl07FnNqHXmd1JkFfOCmYnB3SU9kWdhnbkfSZT5ncqs
         7JRX48Bot8xEehUhwj+ocSadIK5rk/VhClJqvUU+QIo0E9TDfUNN2khdwMsUbGbQFG7X
         bwoxmI3KcjmRIvEHteKqRAFchcHBQ05t8ZNymk6aP+Tbcqe5J/t/n5zsxw0Uox7R4V4t
         3tOHVsGGKTZVMMUYOSZa/si5i8Qawnfk8pc5syTGgV+R3+/2EW446/O5F7AWBRabnCKQ
         Wd7g==
X-Gm-Message-State: AOUpUlEY3tOogxfUjmh8xQkdSorm9ZfB4ENKVoUVeSH0TsS0Eis/Ajnk
        K3tYl/Rk1ckDHDpJaa5AugyA5w==
X-Google-Smtp-Source: AAOMgpfe97877ID/Q5v+0GF/KPzPbbNIlGQ0B5i45MoaRFuaMjVYW3Kl7h+dotpxC140dDbVehXW/w==
X-Received: by 2002:a17:902:981:: with SMTP id 1-v6mr9108153pln.11.1531984953178;
        Thu, 19 Jul 2018 00:22:33 -0700 (PDT)
Received: from kshutemo-mobl1.localdomain ([134.134.139.83])
        by smtp.gmail.com with ESMTPSA id p62-v6sm8289481pfb.58.2018.07.19.00.22.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 19 Jul 2018 00:22:32 -0700 (PDT)
Received: by kshutemo-mobl1.localdomain (Postfix, from userid 1000)
        id BE0913001F8; Thu, 19 Jul 2018 10:16:06 +0300 (+03)
Date:   Thu, 19 Jul 2018 10:16:06 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>, x86@kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Kai Huang <kai.huang@linux.intel.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCHv5 02/19] mm: Do not use zero page in encrypted pages
Message-ID: <20180719071606.dkeq5btz5wlzk4oq@kshutemo-mobl1>
References: <20180717112029.42378-1-kirill.shutemov@linux.intel.com>
 <20180717112029.42378-3-kirill.shutemov@linux.intel.com>
 <e09c67ab-38a7-5b76-29e6-a45627eec1e5@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e09c67ab-38a7-5b76-29e6-a45627eec1e5@intel.com>
User-Agent: NeoMutt/20180622
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 18, 2018 at 10:36:24AM -0700, Dave Hansen wrote:
> On 07/17/2018 04:20 AM, Kirill A. Shutemov wrote:
> > Zero page is not encrypted and putting it into encrypted VMA produces
> > garbage.
> > 
> > We can map zero page with KeyID-0 into an encrypted VMA, but this would
> > be violation security boundary between encryption domains.
> 
> Why?  How is it a violation?
> 
> It only matters if they write secrets.  They can't write secrets to the
> zero page.

I believe usage of zero page is wrong here. It would indirectly reveal
content of supposedly encrypted memory region.

I can see argument why it should be okay and I don't have very strong
opinion on this.

If folks see it's okay to use zero page in encrypted VMAs I can certainly
make it work.

> Is this only because you accidentally inherited ->vm_page_prot on the
> zero page PTE?

Yes, in previous patchset I mapped zero page with wrong KeyID. This is one
of possible fixes for this.

-- 
 Kirill A. Shutemov
