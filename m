Return-Path: <SRS0=3gpS=RA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAC5BC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 20:42:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A23ED20C01
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 20:42:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="aXPgz4Y1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727531AbfBYUmx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Feb 2019 15:42:53 -0500
Received: from mail.skyhub.de ([5.9.137.197]:55898 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727230AbfBYUmw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Feb 2019 15:42:52 -0500
Received: from zn.tnic (p200300EC2BC68000605C24440EAF7D3B.dip0.t-ipconnect.de [IPv6:2003:ec:2bc6:8000:605c:2444:eaf:7d3b])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 4CC711EC04F3;
        Mon, 25 Feb 2019 21:42:51 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1551127371;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=LYt6QNtuPUERhVQOjDHliIhKCr9rtSWbkLNMb2Z1RTc=;
        b=aXPgz4Y1eB5+sRjy1ioiWFZ7XUKeFHgaP87+h5HZA/ahkY8evR6rBPdWVQx0oeHA4d56Zw
        wfkeihkIupmqDeaCh1onhyT+wO3qARoWUW3XXs/cFT1smVDx7TOhreIRCi6/ii3PB4MYWe
        RiFztsRJb5P8jf7m1Xr8ClZ0quJIsPk=
Date:   Mon, 25 Feb 2019 21:42:44 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     thor.thayer@linux.intel.com
Cc:     dinguyen@kernel.org, linux@armlinux.org.uk, mchehab@kernel.org,
        james.morse@arm.com, linux-edac@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCHv2 0/2] Independent SOCFPGA SDRAM EDAC config
Message-ID: <20190225204244.GJ26145@zn.tnic>
References: <1551121006-4657-1-git-send-email-thor.thayer@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1551121006-4657-1-git-send-email-thor.thayer@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 25, 2019 at 12:56:44PM -0600, thor.thayer@linux.intel.com wrote:
> From: Thor Thayer <thor.thayer@linux.intel.com>
> 
> Most users want EDAC support so make it the default.
> 
> SOCFPGA SDRAM EDAC reporting was enabled by the parent EDAC
> config (CONFIG_ALTERA_EDAC) since initial customers always
> wanted SDRAM EDAC enabled.
> There are cases where the SDRAM needs to be disabled while
> the other block EDACs remain enabled.
> This patch set 1) splits out the SDRAM EDAC into a separate
> config and 2) enables all the EDAC blocks by default for
> 32 bit SOCFPGA.
> 
> V2 Changes
>   Rebase socfpga_defconfig against arm-soc/arm/defconfig
> 
> Thor Thayer (2):
>   EDAC, altera: Add separate SDRAM EDAC config
>   ARM: socfpga_defconfig: enable EDAC by default

Am I supposed to take the second patch too or is it going through Dinh's
tree?

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
