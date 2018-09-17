Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C5D8ECE560
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 11:51:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 24D74214DA
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 11:51:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 24D74214DA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728319AbeIQRSy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 13:18:54 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:55314 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726743AbeIQRSx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 13:18:53 -0400
Received: from localhost (ip-213-127-77-73.ip.prioritytelecom.net [213.127.77.73])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id D8533BC6;
        Mon, 17 Sep 2018 11:51:53 +0000 (UTC)
Date:   Mon, 17 Sep 2018 13:51:51 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Andi Kleen <andi@firstfloor.org>
Cc:     Jiri Slaby <jslaby@suse.cz>, stable@vger.kernel.org,
        x86@kernel.org, linux-kernel@vger.kernel.org,
        bernhard.kaindl@thalesgroup.com, Andi Kleen <ak@linux.intel.com>
Subject: Re: [PATCH] x86/mm/pat: Fix L1TF stable backport for CPA
Message-ID: <20180917115151.GJ13057@kroah.com>
References: <20180825135015.33547-1-andi@firstfloor.org>
 <2374a957-ab3c-5fad-64eb-14ce4a698715@suse.cz>
 <20180906202749.siuw4hlnafzq4o23@two.firstfloor.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180906202749.siuw4hlnafzq4o23@two.firstfloor.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 06, 2018 at 01:27:49PM -0700, Andi Kleen wrote:
> > And what about populate_pud?
> >                 set_pud(pud, pud_mkhuge(pfn_pud(cpa->pfn,
> >                                    canon_pgprot(pud_pgprot))));
> > 
> >                 start     += PUD_SIZE;
> >                 cpa->pfn  += PUD_SIZE;
> 
> Yes you're right. That case needs to be fixed too.
> 
> Are you sending a patch, or should I?

Someone needs to.  Please?

greg k-h
