Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B1B2ECDE30
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 13:32:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A7B0121526
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 13:32:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="ycgqtBqZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A7B0121526
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727108AbeJQV1s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 17:27:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:40692 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726990AbeJQV1s (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 17:27:48 -0400
Received: from localhost (ip-213-127-77-176.ip.prioritytelecom.net [213.127.77.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DC50D214C2;
        Wed, 17 Oct 2018 13:32:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539783125;
        bh=aoxpQMLBWr2hyJ9ms0dnyfIVbXma0tAZ1vdsh6sxMbo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ycgqtBqZGcwVYp1wgFz9R3ivmEDSosfBqacNVOSfC3utOi/biZu+SI218JiPkI2Hi
         R1m32QyihDKu8ggudLnHpCJcDktyonvsGMgjiUo2eXfZZyTUIsL9PfLi7T/Vi9NFue
         OUFsx9EobQ73P52lzBJv1MeaQsA+NVAjsByWXTfM=
Date:   Wed, 17 Oct 2018 15:32:02 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: Re: [PATCH 4.9 00/71] 4.9.134-stable review
Message-ID: <20181017133202.GA16805@kroah.com>
References: <20181016170539.315587743@linuxfoundation.org>
 <86b6aaf4-d78e-338d-22a1-e5e377e637b1@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <86b6aaf4-d78e-338d-22a1-e5e377e637b1@roeck-us.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 17, 2018 at 06:19:06AM -0700, Guenter Roeck wrote:
> On 10/16/2018 10:08 AM, Greg Kroah-Hartman wrote:
> > This is the start of the stable review cycle for the 4.9.134 release.
> > There are 71 patches in this series, all will be posted as a response
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
> > 
> > Responses should be made by Thu Oct 18 17:05:18 UTC 2018.
> > Anything received after that time might be too late.
> > 
> 
> Boot tests are still going on, but:
> 
> powerpc:defconfig (and others):
> 
> arch/powerpc/include/asm/book3s/64/pgtable.h: In function 'pte_modify':
> arch/powerpc/include/asm/book3s/64/pgtable.h:74:24: error: '_PAGE_DEVMAP' undeclared
> 
> Introduced by commit 4091b46b1dfe ("mm: Preserve _PAGE_DEVMAP across mprotect() calls")
> which fixes ebd31197931d for ppc64 which is not in v4.9.y. Unfortunately it also fixes
> 69660fd797c3 ("x86, mm: introduce _PAGE_DEVMAP") which _is_ in the branch. ebd31197931d
> doesn't apply cleanly, so either someone needs to backport it, or the ppc changes need
> to be dropped from 4091b46b1dfe.

Now dropped from the tree, Jan Kara just reported the same thing.

thanks,

greg k-h
