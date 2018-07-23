Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F3EBECDFB8
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 21:48:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB51120854
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 21:48:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=markrailton-com.20150623.gappssmtp.com header.i=@markrailton-com.20150623.gappssmtp.com header.b="P5ymQPWN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EB51120854
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=markrailton.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388198AbeGWWvS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 18:51:18 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:36584 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388137AbeGWWvS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 18:51:18 -0400
Received: by mail-ed1-f65.google.com with SMTP id k15-v6so2253807edr.3
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jul 2018 14:48:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=markrailton-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=dKqyDj3vrA5uJCgjhlfGSPtco1hfjdKUb+O1yIzMhRc=;
        b=P5ymQPWNwGZ4T/s4BmpU7uxhosyLLWy6wUKBSHeKIrJUivCRN3i3wjiNPSQjc6mUrE
         Kt3u3cp8YmcuGLtn6QTMz8Aj2+duPY/rGzLQ8eWl4EdYJ6+RRh9W2PHfQd6cIFbuol9q
         MfsA1ueOQg4V++/MgAbCQ8mrJLY5A2vTnOTVepK5iOChtfEDjmyMDHIcQXa3uo6WsOLu
         QHU/1AlshyBhxnPZn5I5VtX3KUP3wzp6s66deNPrfrqnO35RYlse1mJ8cqnkxQtE72jD
         wLbmXsmp/jWeg/CazNM6PS2z9OHCop0HunHMHtKJQjV39KC6pMhSkosmlEm3hV0368RO
         IGOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=dKqyDj3vrA5uJCgjhlfGSPtco1hfjdKUb+O1yIzMhRc=;
        b=TQmlqBPaXn60IKqva1vOGshhrDT2gti2OYsXoJgRsC0G2hwKoaupLoYazKdlOR/H3+
         hf9SodbetXKX96OjSrbV0u73F89dZ0MGIqacEVX7LmZ004x/WEHWV3pbbweKagkTUHbM
         Mrgx6vp7JaOj2bi3hQXia3CdGMeG1IgUTrVmWnjdRxmJCvBuieZvFpPWuY5jAMmM5WOp
         t/x4t0edtuqqYrMw0ytXotl7AtDsTixUfAPkjQwzyanI910C/Zx9mQzpPPOYHjjuI6F+
         /t2pUj4x5+c01KmiNJvo/ErIntA7DHxMI/i9FEcvaZBTwqV0hXOpL2O7tZR2ssVjsbZ9
         rjkA==
X-Gm-Message-State: AOUpUlEZHkIhWNmm6S28bAZJIZ3mXB1KYeOCmtXECmGN8hYblfDb8/b/
        i7eg4WNso/BUYUHOFpMCkKN8OCbyu9WAojWj
X-Google-Smtp-Source: AAOMgpcasF4AtTssR4h80E3G8fLWMVteurc92WPgE2r4/L1fgsLQx7CjbrDqgOJEdhXNYeDTdyMh+w==
X-Received: by 2002:a50:9818:: with SMTP id g24-v6mr16161451edb.174.1532382486222;
        Mon, 23 Jul 2018 14:48:06 -0700 (PDT)
Received: from ZeroCool ([109.255.141.80])
        by smtp.gmail.com with ESMTPSA id d15-v6sm4863529edq.31.2018.07.23.14.48.05
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 23 Jul 2018 14:48:05 -0700 (PDT)
Date:   Mon, 23 Jul 2018 22:48:04 +0100
From:   Mark Railton <mark@markrailton.com>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     boris.ostrovsky@oracle.com, jgross@suse.com,
        xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Drivers: Xen: xlate_mmu.c: Fixed comment layout
Message-ID: <20180723214804.GA21761@ZeroCool>
References: <20180723213404.20720-1-mark@markrailton.com>
 <e0b30ab8-d418-cbe0-d03c-a0aee1d48367@infradead.org>
 <20180723214011.GA21167@ZeroCool>
 <01b221f3-d923-1abb-0168-bfeba80b9a9a@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <01b221f3-d923-1abb-0168-bfeba80b9a9a@infradead.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 23, 2018 at 02:44:28PM -0700, Randy Dunlap wrote:
> On 07/23/2018 02:40 PM, Mark Railton wrote:
> > On Mon, Jul 23, 2018 at 02:38:20PM -0700, Randy Dunlap wrote:
> >> On 07/23/2018 02:34 PM, Mark Railton wrote:
> >>> Fixed issue with multi line comment
> >>
> >> Fix [not Fixed]
> >>
> >>>
> >>> Signed-off-by: Mark Railton <mark@markrailton.com>
> >>> ---
> >>>  drivers/xen/xlate_mmu.c | 5 +++--
> >>>  1 file changed, 3 insertions(+), 2 deletions(-)
> >>>
> >>> diff --git a/drivers/xen/xlate_mmu.c b/drivers/xen/xlate_mmu.c
> >>> index 23f1387b3ef7..3b03bc1641ed 100644
> >>> --- a/drivers/xen/xlate_mmu.c
> >>> +++ b/drivers/xen/xlate_mmu.c
> >>> @@ -151,8 +151,9 @@ int xen_xlate_remap_gfn_array(struct vm_area_struct *vma,
> >>>  	struct remap_data data;
> >>>  	unsigned long range = DIV_ROUND_UP(nr, XEN_PFN_PER_PAGE) << PAGE_SHIFT;
> >>>  
> >>> -	/* Kept here for the purpose of making sure code doesn't break
> >>> -	   x86 PVOPS */
> >>> +	/* Kept here for the purpose of making sure code doesn't
> >>> +	 * break x86 PVOPS
> >>> +	 */
> >>
> >> That is still not the preferred kernel multi-line comment style.
> >> Documentation/process/coding-style.rst says:
> >>
> >> 	/*
> >> 	 * This is the preferred style for multi-line
> >> 	 * comments in the Linux kernel source code.
> >> 	 * Please use it consistently.
> >> 	 *
> >> 	 * Description:  A column of asterisks on the left side,
> >> 	 * with beginning and ending almost-blank lines.
> >> 	 */
> >>
> >> although Networking code has a slightly different preferred style (as in
> >> your patch).
> >>
> >>>  	BUG_ON(!((vma->vm_flags & (VM_PFNMAP | VM_IO)) == (VM_PFNMAP | VM_IO)));
> >>>  
> >>>  	data.fgfn = gfn;
> >>>
> >>
> >>
> >> -- 
> >> ~Randy
> > 
> > Thank's for the feedback, I'll get that updated now.
> > 
> > I'm still kinda new to this, I assume I need to send the new patch via
> > git send-email?
> 
> That is one option.  Use whatever works for you.
> 
> There are several email clients that also work well.
> See Documentation/process/email-clients.rst.
> 
> 
> -- 
> ~Randy

From 57c8104d2a30020005be16df2ca69ed66f6c4ae9 Mon Sep 17 00:00:00 2001
From: Mark Railton <mark@markrailton.com>
Date: Mon, 23 Jul 2018 22:28:53 +0100
Subject: [PATCH] Drivers: Xen: xlate_mmu.c: Fixed comment layout

Fixed issue with multi line comment

Signed-off-by: Mark Railton <mark@markrailton.com>
---
 drivers/xen/xlate_mmu.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/xen/xlate_mmu.c b/drivers/xen/xlate_mmu.c
index 23f1387b3ef7..2b77c79f8ce7 100644
--- a/drivers/xen/xlate_mmu.c
+++ b/drivers/xen/xlate_mmu.c
@@ -151,8 +151,10 @@ int xen_xlate_remap_gfn_array(struct vm_area_struct *vma,
 	struct remap_data data;
 	unsigned long range = DIV_ROUND_UP(nr, XEN_PFN_PER_PAGE) << PAGE_SHIFT;

-	/* Kept here for the purpose of making sure code doesn't break
-	   x86 PVOPS */
+	/*
+	 * Kept here for the purpose of making sure code doesn't
+	 * break x86 PVOPS
+	 */
 	BUG_ON(!((vma->vm_flags & (VM_PFNMAP | VM_IO)) == (VM_PFNMAP | VM_IO)));

 	data.fgfn = gfn;
--
2.17.1


