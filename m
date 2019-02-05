Return-Path: <SRS0=cBqk=QM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D9F8C282CB
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 14:42:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 43CE4217F9
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 14:42:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549377747;
	bh=6m+zbJgXrJhebgvSPPlQcm3L2hNWuFZBi7Bp6jqttJQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=tUXeTRM9tWR4ndnyHtgEzL6TnzfbH0at1SW1Fd5uTSRO5caHaAkLjxOPXDfvrzb/k
	 uLPMb1Z7b1BgqWRPSHUN9z2F8b/qz/1W+tyFsON1OXFrB+FBf4e+k+9rt+q5/nuFcL
	 xJ/8OD54jWc4QBPOTSUTZg7nH1N/TY0AZDni13wA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728891AbfBEOmZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Feb 2019 09:42:25 -0500
Received: from mail.kernel.org ([198.145.29.99]:51980 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725947AbfBEOmZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Feb 2019 09:42:25 -0500
Received: from localhost (unknown [212.187.182.163])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0D7BA2080F;
        Tue,  5 Feb 2019 14:42:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549377744;
        bh=6m+zbJgXrJhebgvSPPlQcm3L2hNWuFZBi7Bp6jqttJQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ztIElAv7fm8Yx3PRPAViQ2cBR8892HpMFSkT5FQX9LvyRbmpSrEmWKc38BuS7NPHI
         6+vjreBgsheRktwByBTsLLUFgkMP/yR+yqm8RSoh5maXgBoLi70HV8i9U2n+Mksb2q
         BqtUijmOTozu9EXYxtilHdKpJs969RntPLBsqq48=
Date:   Tue, 5 Feb 2019 15:42:21 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: Re: [PATCH 4.4 00/65] 4.4.173-stable review
Message-ID: <20190205144221.GB17950@kroah.com>
References: <20190204103610.583715954@linuxfoundation.org>
 <20190204224817.GA12968@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190204224817.GA12968@roeck-us.net>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 04, 2019 at 02:48:17PM -0800, Guenter Roeck wrote:
> On Mon, Feb 04, 2019 at 11:35:53AM +0100, Greg Kroah-Hartman wrote:
> > This is the start of the stable review cycle for the 4.4.173 release.
> > There are 65 patches in this series, all will be posted as a response
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
> > 
> > Responses should be made by Wed Feb  6 10:35:30 UTC 2019.
> > Anything received after that time might be too late.
> > 
> 
> Build results:
> 	total: 171 pass: 171 fail: 0
> Qemu test results:
> 	total: 291 pass: 291 fail: 0 (*)
> 
> Guenter
> 
> ---
> (*) I had to revert to gcc 5.3.0 for sh4 boot tests.
>     With gcc 8.2.0, most tests stall early in boot.
>     I didn't try to track down the root cause.

Is this a new issue?  I don't see any sh-specific patches in this
series.

thnaks,

greg k-h
