Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CCACECDE32
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 07:48:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD02821526
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 07:48:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="gi+951KH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DD02821526
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727400AbeJQPnA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 11:43:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:56758 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726947AbeJQPnA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 11:43:00 -0400
Received: from localhost (unknown [188.88.119.206])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 05FE2214C3;
        Wed, 17 Oct 2018 07:48:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539762514;
        bh=DH0a2DtgbaKHK9xmp9Xrj/M2dX3cgPzO9DrTkfK4MeA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gi+951KH3zqKli0DmzmNbwMdXNnBuBcURr648sYbdFD0zt+r0+OgQhq5D/hW54VeE
         4bgyD1p5/e+ZYFcuU3EY7+sdcofHndVpVY1fFnAHgPf4WAOeTvZcA3Q9hTaWBDVGvq
         Pms/eZwwpRub2BSbe3Kic5vcI1GezcR09ho4FtoI=
Date:   Wed, 17 Oct 2018 09:48:31 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Paul Mackerras <paulus@ozlabs.org>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        David Gibson <david@gibson.dropbear.id.au>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        kvm-ppc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        Nicholas Piggin <npiggin@gmail.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: Re: [PATCH 4.18 086/135] KVM: PPC: Book3S HV: Dont use
 compound_order to determine host mapping size
Message-ID: <20181017074831.GF25537@kroah.com>
References: <20181016170515.447235311@linuxfoundation.org>
 <20181016170521.241312038@linuxfoundation.org>
 <20181016223224.GA27627@blackberry>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181016223224.GA27627@blackberry>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 17, 2018 at 09:32:25AM +1100, Paul Mackerras wrote:
> On Tue, Oct 16, 2018 at 07:05:16PM +0200, Greg Kroah-Hartman wrote:
> > 4.18-stable review patch.  If anyone has any objections, please let me know.
> > 
> > ------------------
> > 
> > From: Nicholas Piggin <npiggin@gmail.com>
> > 
> > [ Upstream commit 71d29f43b6332badc5598c656616a62575e83342 ]
> 
> If you take 71d29f43b633 then you also need 6579804c4317 ("KVM: PPC:
> Book3S HV: Avoid crash from THP collapse during radix page fault",
> 2018-10-04).

Thanks, now queued up.

greg k-h
