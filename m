Return-Path: <SRS0=cBqk=QM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F01EFC282CB
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 14:41:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C1142217FA
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 14:41:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549377711;
	bh=m+bsCC98uIIJ1RfeNVz7b+Uat+6ygub1aggY9OXyYto=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=DSRaI4Nf6/tdCol4bNJFLC+16mcaUJSJj+sJti+95cnKlUoSMg9gzkFnDLnmUFJ6q
	 YkpSFFjnilfrx5WQlm0h1Yz9mLylWlgmeEQZ0A/IHbQi6imQUto7ujYXjadHykAajh
	 9UA1wj/cJBGmwPsdvDX9RGAhYuv7jEpsP14TsUxM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728890AbfBEOlt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Feb 2019 09:41:49 -0500
Received: from mail.kernel.org ([198.145.29.99]:50934 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727432AbfBEOlt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Feb 2019 09:41:49 -0500
Received: from localhost (unknown [212.187.182.163])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 11C4120811;
        Tue,  5 Feb 2019 14:41:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549377708;
        bh=m+bsCC98uIIJ1RfeNVz7b+Uat+6ygub1aggY9OXyYto=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hlcOGrCnd1sr/lnSpMVb9ndFcCCgeDUxw90+VTZtOtQO5VRBIy5+S+J2Snq9MdI4h
         1xcLyq64iSiwcevSWqhLG1QGJcpFAXs/6P9Ycq1tHbzKeeQaOw7eBPBTPTXQ09i0q4
         JTRfLVbIOd07nOjwqpeYD0y9V1iItFVoR6IlU5Os=
Date:   Tue, 5 Feb 2019 15:41:45 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: Re: [PATCH 3.18 00/31] 3.18.134-stable review
Message-ID: <20190205144145.GA17950@kroah.com>
References: <20190204103557.903263774@linuxfoundation.org>
 <20190204214444.GB18895@roeck-us.net>
 <20190205084625.GA12210@kroah.com>
 <ae7ee607-9d7c-5b4d-545d-ab4f7bbcbc18@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ae7ee607-9d7c-5b4d-545d-ab4f7bbcbc18@roeck-us.net>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 05, 2019 at 05:54:45AM -0800, Guenter Roeck wrote:
> On 2/5/19 12:46 AM, Greg Kroah-Hartman wrote:
> > On Mon, Feb 04, 2019 at 01:44:44PM -0800, Guenter Roeck wrote:
> > > On Mon, Feb 04, 2019 at 11:36:15AM +0100, Greg Kroah-Hartman wrote:
> > > > This is the start of the stable review cycle for the 3.18.134 release.
> > > > There are 31 patches in this series, all will be posted as a response
> > > > to this one.  If anyone has any issues with these being applied, please
> > > > let me know.
> > > > 
> > > > Responses should be made by Wed Feb  6 10:35:28 UTC 2019.
> > > > Anything received after that time might be too late.
> > > > 
> > > 
> > > Build results:
> > > 	total: 155 pass: 153 fail: 2
> > > Failed builds:
> > > 	arm64:defconfig
> > > 	arm64:allmodconfig
> > > Qemu test results:
> > > 	total: 222 pass: 222 fail: 0
> > > 
> > > Error log:
> > > 
> > > Error log:
> > > arch/arm64/kernel/head.o: In function `el2_setup':
> > > (.head.text+0x130): relocation truncated to fit: R_AARCH64_ADR_PREL_LO21 against
> > > symbol `__hyp_stub_vectors' defined in .hyp.text section in arch/arm64/kernel/built-in.o
> > > 
> > > Looks like this is due to commit 8640f2308921 ("arm64: hyp-stub: Forbid
> > > kprobing of the hyp-stub").
> > 
> > Ah, thanks, let me go fix this up...
> > 
> > Ok, pushed out a -rc2 with that patch dropped.
> > 
> > greg k-h
> > 
> Now fixed:
> 
> Build results:
> 	total: 155 pass: 155 fail: 0
> Qemu test results:
> 	total: 226 pass: 226 fail: 0

Wonderful, thanks for testing all of these and letting me know.

greg k-h
