Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4D4AECDFB8
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 06:30:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7020E2084E
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 06:30:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ozlabs.org header.i=@ozlabs.org header.b="LenVzAGV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7020E2084E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ozlabs.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729193AbeGRHHC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 03:07:02 -0400
Received: from ozlabs.org ([203.11.71.1]:49549 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728826AbeGRHHB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 03:07:01 -0400
Received: by ozlabs.org (Postfix, from userid 1003)
        id 41VnMm2tqtz9s8F; Wed, 18 Jul 2018 16:30:44 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ozlabs.org; s=201707;
        t=1531895444; bh=gkcwrB5wZYkHmkLVCGszmPSs4saEnTLxxZijVdhaANI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LenVzAGVtzmLhcXLJGH8ht+cA4Kpk4Sw9Iz/DrnZsVoQSUa+UlKK1tB3vrpQ5/ZsK
         O+Mup2QashZW1LnvAujPGKOC3En/0N2iEux1l684DIZxppd2WMNTkTqcNGVRWT5Yoz
         84RoTrvGUU273609L0o9t/8jhGpNKrLzZ92C41y02BbUV5dlrwGFojFWJuwkOdO8A1
         qIGK5FR77rSWec6BWWnKYvdof47/Vs///JUJ90ZoPB5eUG+Zn3EYM1VRgf8G6x3Lwp
         r4lDcgzDJt6+jHtzerJM6pymXV2n7T8Cvur5lfRnZPOtr2zK+Msi89VaLbOpKeV38k
         +Coq1oLsLJl8w==
Date:   Wed, 18 Jul 2018 16:29:27 +1000
From:   Paul Mackerras <paulus@ozlabs.org>
To:     Nicholas Mc Guire <hofrat@osadl.org>
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Michael Ellerman <mpe@ellerman.id.au>, kvm-ppc@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] KVM: PPC: Book3S HV: fix constant size warning
Message-ID: <20180718062927.GC27453@fergus>
References: <1530954445-6780-1-git-send-email-hofrat@osadl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1530954445-6780-1-git-send-email-hofrat@osadl.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 07, 2018 at 11:07:25AM +0200, Nicholas Mc Guire wrote:
>  The constants are 64bit but not explicitly declared UL resulting
> in sparse warnings. Fixed by declaring the constants UL.
> 
> Signed-off-by: Nicholas Mc Guire <hofrat@osadl.org>

Thanks, patch applied to my kvm-ppc-next branch.

Paul.
