Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id iZVgJRAuHlssWgAAmS7hNA
	; Mon, 11 Jun 2018 08:17:32 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id D7EEA607BB; Mon, 11 Jun 2018 08:17:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
	s=default; t=1528705051;
	bh=SWxYZaYG1Zsq/9R5y52sYUaNSgkA+usWRmrpOk9UlHs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=Toa1gDY7fTkZDdLyQONamynEXu1cQOJyJNXGVP9aJVAqPOvyxAnubbfW/rPwu/S+A
	 PxNKH3MWFNcmtMPmTGcbr7zYZqN0+NF5sriDkBDikbvapy4/8ieEa8Sc+k+BRGM7VH
	 nBUJ6kQNbFG9nuzXIaqATAi+UJvTDs4o1CvIY9mw=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	MAILING_LIST_MULTI,T_DKIM_INVALID autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 669A0606FA;
	Mon, 11 Jun 2018 08:17:31 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="daF7mEpc";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="daF7mEpc"
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 669A0606FA
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754137AbeFKIR3 (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 19 others); Mon, 11 Jun 2018 04:17:29 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:40382 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754039AbeFKIR1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jun 2018 04:17:27 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 608F7606FA; Mon, 11 Jun 2018 08:17:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1528705047;
        bh=SWxYZaYG1Zsq/9R5y52sYUaNSgkA+usWRmrpOk9UlHs=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=daF7mEpc8VX5lxhyLbeFa0J2YGQXIh6NwNGcAF9bd5ujRRkHQNnhYosl3VLGoJBMH
         6EFdljYCjc1UX0fy/GHSW1ZoXm5yYTk8tTA54JNpUoyYwCMAn87h+KxhsUXLVetpc1
         x7vKbG16c33Lf2m9CHUC/IomOiV137Dec0yv7SfQ=
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.codeaurora.org (Postfix) with ESMTP id F3AAC60791;
        Mon, 11 Jun 2018 08:17:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1528705047;
        bh=SWxYZaYG1Zsq/9R5y52sYUaNSgkA+usWRmrpOk9UlHs=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=daF7mEpc8VX5lxhyLbeFa0J2YGQXIh6NwNGcAF9bd5ujRRkHQNnhYosl3VLGoJBMH
         6EFdljYCjc1UX0fy/GHSW1ZoXm5yYTk8tTA54JNpUoyYwCMAn87h+KxhsUXLVetpc1
         x7vKbG16c33Lf2m9CHUC/IomOiV137Dec0yv7SfQ=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date: Mon, 11 Jun 2018 13:47:26 +0530
From: poza@codeaurora.org
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v1 0/9] PCI/portdrv: Squash into one file
In-Reply-To: <152848853199.14051.12670957565366345798.stgit@bhelgaas-glaptop.roam.corp.google.com>
References: <152848853199.14051.12670957565366345798.stgit@bhelgaas-glaptop.roam.corp.google.com>
Message-ID: <1ade8ebfbd2e02177d2f6afa3d805bb0@codeaurora.org>
X-Sender: poza@codeaurora.org
User-Agent: Roundcube Webmail/1.2.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-06-09 01:42, Bjorn Helgaas wrote:
> The portdrv code is scattered across several files, which makes it a 
> bit of
> a hassle to browse.  Consolidate it all in a single file.
> 

Although I do not have any objection is merging the code,

It looks to me that the 2 files served purpose of keeping
portdrv device functionality in  one file > portdrv_pci.c
while, port driver helper and exported service functions for services 
are in > portdrv_core.c

If that was the original intention, it just looks okay to me.
But I am not sure the way the code is now, we can call is scattered,
and also I do not think by merging it, we can call it more organised.

although certainly it looks easier to browse as you are suggesting.
little less confusing.

> This is all pure code moves; no functional changes intended.  Well, 
> there
> is a function rename, but it shouldn't change any behavior.
> 
> ---
> 
> Bjorn Helgaas (9):
>       PCI/portdrv: Rename resume_iter() to prevent name collision
>       PCI/portdrv: Squash pieces of portdrv_core.c into portdrv_pci.c
>       PCI/portdrv: Squash PM-related code into portdrv_pci.c
>       PCI/portdrv: Squash device removal code into portdrv_pci.c
>       PCI/portdrv: Squash lookup interfaces into portdrv_pci.c
>       PCI/portdrv: Squash service driver registration into 
> portdrv_pci.c
>       PCI/portdrv: Move private definitions to portdrv_pci.c
>       PCI/portdrv: Clean up whitespace
>       PCI/portdrv: Rename portdrv_pci.c to portdrv.c
> 
> 
>  drivers/pci/pcie/Makefile       |    6
>  drivers/pci/pcie/portdrv.c      |  822 
> +++++++++++++++++++++++++++++++++++++++
>  drivers/pci/pcie/portdrv.h      |   15 -
>  drivers/pci/pcie/portdrv_core.c |  578 ---------------------------
>  drivers/pci/pcie/portdrv_pci.c  |  261 ------------
>  5 files changed, 824 insertions(+), 858 deletions(-)
>  create mode 100644 drivers/pci/pcie/portdrv.c
>  delete mode 100644 drivers/pci/pcie/portdrv_core.c
>  delete mode 100644 drivers/pci/pcie/portdrv_pci.c
