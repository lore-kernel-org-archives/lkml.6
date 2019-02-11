Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69AE6C282C2
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 01:20:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B4D221736
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 01:20:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726751AbfBKBUC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 10 Feb 2019 20:20:02 -0500
Received: from gate.crashing.org ([63.228.1.57]:40797 "EHLO gate.crashing.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726130AbfBKBUC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Feb 2019 20:20:02 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
        by gate.crashing.org (8.14.1/8.14.1) with ESMTP id x1B0UtG5017871;
        Sun, 10 Feb 2019 18:30:56 -0600
Message-ID: <c2d6938902656f2829be8077c656cee9235c21b1.camel@kernel.crashing.org>
Subject: Re: [PATCH] powerpc: fix 32-bit KVM-PR lockup and panic with MacOS
 guest
From:   Benjamin Herrenschmidt <benh@kernel.crashing.org>
To:     Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
        Christophe Leroy <christophe.leroy@c-s.fr>, paulus@samba.org,
        mpe@ellerman.id.au, npiggin@gmail.com,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        kvm-ppc@vger.kernel.org
Date:   Mon, 11 Feb 2019 11:30:54 +1100
In-Reply-To: <2ed8efb9-5cd4-31bf-6c7b-501b9d1925e6@ilande.co.uk>
References: <20190208143319.11980-1-mark.cave-ayland@ilande.co.uk>
         <41b02fb0-cdc6-6de0-d8fc-44d3d0a8ad70@c-s.fr>
         <2ed8efb9-5cd4-31bf-6c7b-501b9d1925e6@ilande.co.uk>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.4 (3.30.4-1.fc29) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2019-02-08 at 14:51 +0000, Mark Cave-Ayland wrote:
> 
> Indeed, but there are still some questions to be asked here:
> 
> 1) Why were these bits removed from the original bitmask in the first place without
> it being documented in the commit message?
> 
> 2) Is this the right fix? I'm told that MacOS guests already run without this patch
> on a G5 under 64-bit KVM-PR which may suggest that this is a workaround for another
> bug elsewhere in the 32-bit powerpc code.
> 
> 
> If you think that these points don't matter, then I'm happy to resubmit the patch
> as-is based upon your comments above.

We should write a test case to verify that FE0/FE1 are properly
preserved/context-switched etc... I bet if we accidentally wiped them,
we wouldn't notice 99.9% of the time.

Cheers,
Ben.

