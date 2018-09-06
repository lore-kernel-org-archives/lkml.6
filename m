Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACDF9C43334
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 20:27:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4FD9C20659
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 20:27:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=firstfloor.org header.i=@firstfloor.org header.b="m4YyuBea"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4FD9C20659
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=firstfloor.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729763AbeIGBE7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 21:04:59 -0400
Received: from one.firstfloor.org ([193.170.194.197]:33428 "EHLO
        one.firstfloor.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729373AbeIGBE7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 21:04:59 -0400
Received: by one.firstfloor.org (Postfix, from userid 503)
        id 6C3E886871; Thu,  6 Sep 2018 22:27:49 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=firstfloor.org;
        s=mail; t=1536265669;
        bh=SLBByu8IGtuFYDtkGsY7m0xk+PI1itLEhm+uNavLCLs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=m4YyuBea/Q7ksVbaWJBrD7180UH6s0/jJG26Ws7amfHmRc2Lm+2AZpf6q6MGauOVG
         rbDHwRLHyB507/WA5Ll2KLpqv4cFbPCZf7ksVyDO5RLteu+JnXuXWh3OLwwL6OkgYl
         PipGxOzA6f5XzeNWWnDHD6k8XxyPUNI6axpGVnTI=
Date:   Thu, 6 Sep 2018 13:27:49 -0700
From:   Andi Kleen <andi@firstfloor.org>
To:     Jiri Slaby <jslaby@suse.cz>
Cc:     Andi Kleen <andi@firstfloor.org>, stable@vger.kernel.org,
        x86@kernel.org, linux-kernel@vger.kernel.org,
        bernhard.kaindl@thalesgroup.com, Andi Kleen <ak@linux.intel.com>
Subject: Re: [PATCH] x86/mm/pat: Fix L1TF stable backport for CPA
Message-ID: <20180906202749.siuw4hlnafzq4o23@two.firstfloor.org>
References: <20180825135015.33547-1-andi@firstfloor.org>
 <2374a957-ab3c-5fad-64eb-14ce4a698715@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2374a957-ab3c-5fad-64eb-14ce4a698715@suse.cz>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> And what about populate_pud?
>                 set_pud(pud, pud_mkhuge(pfn_pud(cpa->pfn,
>                                    canon_pgprot(pud_pgprot))));
> 
>                 start     += PUD_SIZE;
>                 cpa->pfn  += PUD_SIZE;

Yes you're right. That case needs to be fixed too.

Are you sending a patch, or should I?

-Andi
