Return-Path: <SRS0=1bfu=OR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3225C04EB8
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Dec 2018 09:02:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9952F20892
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Dec 2018 09:02:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544259725;
	bh=h005SZ5u+6JiBV/rOzfwNmPsGPeAmmLifHZVhEHS75w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Df4tr+iQVI5QcsL7DbgsH3rHtzJQ+P1UqncA60QfiRyCtHPNzNTj+TI5h8r2O+Vts
	 ChzWD0vnGmHB4YIMEmul6Tl57Qa8htxatiw7OdOL6Kih9pwosWh7d5QcBMpk8C0HBa
	 gtpijBCxvao7CRcoaz2dUm/uAGwUP0YsssYlPhrE=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9952F20892
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726265AbeLHJCE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 8 Dec 2018 04:02:04 -0500
Received: from mail.kernel.org ([198.145.29.99]:47470 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726103AbeLHJCE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Dec 2018 04:02:04 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D6B232083D;
        Sat,  8 Dec 2018 09:02:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544259723;
        bh=h005SZ5u+6JiBV/rOzfwNmPsGPeAmmLifHZVhEHS75w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CMv5xJJZdAOCHcymPPqalDmu06XsMsaxoNyADljabF8kR08yDLG9mw/B8Ialhd2bv
         ENqGe0FOEwy3ziSI9s7WGeRIUcXBnNfzbMzLHwoR0svZHCQd+uL147wZiFgp6y8anr
         fENYoCLF6nFxlqBpO3FIvFtPkn573ameSM94jsvE=
Date:   Sat, 8 Dec 2018 10:02:00 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: Re: [PATCH 4.19 00/41] 4.19.8-stable review
Message-ID: <20181208090200.GC28887@kroah.com>
References: <20181206142949.757402551@linuxfoundation.org>
 <20181207203117.GB16551@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181207203117.GB16551@roeck-us.net>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 07, 2018 at 12:31:17PM -0800, Guenter Roeck wrote:
> On Thu, Dec 06, 2018 at 03:38:40PM +0100, Greg Kroah-Hartman wrote:
> > This is the start of the stable review cycle for the 4.19.8 release.
> > There are 41 patches in this series, all will be posted as a response
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
> > 
> > Responses should be made by Sat Dec  8 14:29:30 UTC 2018.
> > Anything received after that time might be too late.
> > 
> 
> Build results:
> 	total: 155 pass: 155 fail: 0
> Qemu test results:
> 	total: 337 pass: 337 fail: 0
> 
> Details are available at https://kerneltests.org/builders/.

Wonderful, thanks for fixing this all up and letting me know.

greg k-h
