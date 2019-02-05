Return-Path: <SRS0=cBqk=QM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64AC1C282D7
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 08:46:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 312612145D
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 08:46:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549356394;
	bh=C56CfNs7387gl7jBJNIw0trskv+flu75Qhu40l+d+iE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=YmvpCsLxXfptiYsw6eZZirm7EPLfZXp0gjk1owI1UZXai3m/QHy4m5rIhJieFNmKk
	 z0zn7uq+rjkYK8syEjaaEJ/+5gp0t76SL56UchVQekLKcqE2gXOJlSbPEh98E2iOpi
	 iL80ZzlH0os3ch923SUnLrA1fLh3rKFXdx3jlBfo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728036AbfBEIqc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Feb 2019 03:46:32 -0500
Received: from mail.kernel.org ([198.145.29.99]:49018 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725952AbfBEIqb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Feb 2019 03:46:31 -0500
Received: from localhost (unknown [212.187.182.164])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1D4162083B;
        Tue,  5 Feb 2019 08:46:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549356390;
        bh=C56CfNs7387gl7jBJNIw0trskv+flu75Qhu40l+d+iE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SPRoh442m5zcpHooN1gREQm8iscKVylsII+DaL/vKIkCdrX1eq9/mGHbtwVsn/N5V
         JI1N+OXxZ6zWjaX4oG/h2UI6+AOmaRSfpdcIBeh9cgcbi+8ijWMse77o/oHmI9XgG3
         VSA2NUkP+tu2mKB73D+MoKJIysKF5q3sQteIFqO4=
Date:   Tue, 5 Feb 2019 09:46:26 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: Re: [PATCH 3.18 00/31] 3.18.134-stable review
Message-ID: <20190205084625.GA12210@kroah.com>
References: <20190204103557.903263774@linuxfoundation.org>
 <20190204214444.GB18895@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190204214444.GB18895@roeck-us.net>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 04, 2019 at 01:44:44PM -0800, Guenter Roeck wrote:
> On Mon, Feb 04, 2019 at 11:36:15AM +0100, Greg Kroah-Hartman wrote:
> > This is the start of the stable review cycle for the 3.18.134 release.
> > There are 31 patches in this series, all will be posted as a response
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
> > 
> > Responses should be made by Wed Feb  6 10:35:28 UTC 2019.
> > Anything received after that time might be too late.
> > 
> 
> Build results:
> 	total: 155 pass: 153 fail: 2
> Failed builds: 
> 	arm64:defconfig 
> 	arm64:allmodconfig 
> Qemu test results:
> 	total: 222 pass: 222 fail: 0
> 
> Error log:
> 
> Error log:
> arch/arm64/kernel/head.o: In function `el2_setup':
> (.head.text+0x130): relocation truncated to fit: R_AARCH64_ADR_PREL_LO21 against
> symbol `__hyp_stub_vectors' defined in .hyp.text section in arch/arm64/kernel/built-in.o
> 
> Looks like this is due to commit 8640f2308921 ("arm64: hyp-stub: Forbid
> kprobing of the hyp-stub").

Ah, thanks, let me go fix this up...

Ok, pushed out a -rc2 with that patch dropped.

greg k-h
