Return-Path: <SRS0=wTza=QL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 879B6C282C4
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 09:56:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 55E4920811
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 09:56:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="v7rOH4D1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729147AbfBDJ4g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Feb 2019 04:56:36 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:59794 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728276AbfBDJ4g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Feb 2019 04:56:36 -0500
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id x149uPqJ093070;
        Mon, 4 Feb 2019 03:56:25 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1549274185;
        bh=NAHy9/vL592rHLYn/LBJW9mjS4jW0/G1THvZ2gILx4g=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=v7rOH4D1uXPYNFnMZ0IuwFNYfiei+JKlArwmAdwnbfOqz6sVyDmUE6jtiAj1LNesn
         6kOVnZkQUaq0XHv0vykaQUsKXv6cessNJ8ZndPRhnsFeCK3q6JF/BVfbOCZrs1tTj/
         CbwVj5d0WS+x8IavhG6NVnorRjF9nGBiintyhM+s=
Received: from DFLE114.ent.ti.com (dfle114.ent.ti.com [10.64.6.35])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x149uP8b125571
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 4 Feb 2019 03:56:25 -0600
Received: from DFLE109.ent.ti.com (10.64.6.30) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Mon, 4
 Feb 2019 03:56:25 -0600
Received: from dlep32.itg.ti.com (157.170.170.100) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Mon, 4 Feb 2019 03:56:25 -0600
Received: from [172.24.190.233] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dlep32.itg.ti.com (8.14.3/8.13.8) with ESMTP id x149uMAt015172;
        Mon, 4 Feb 2019 03:56:23 -0600
Subject: Re: [PATCH 0/3] phy: remove needless usage of module header
To:     Paul Gortmaker <paul.gortmaker@windriver.com>
CC:     <linux-kernel@vger.kernel.org>, Andrew Lunn <andrew@lunn.ch>,
        Gregory CLEMENT <gregory.clement@free-electrons.com>
References: <1544402090-30970-1-git-send-email-paul.gortmaker@windriver.com>
From:   Kishon Vijay Abraham I <kishon@ti.com>
Message-ID: <a22629dc-c8c0-207d-b9ba-2d72e40cbf80@ti.com>
Date:   Mon, 4 Feb 2019 15:25:46 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <1544402090-30970-1-git-send-email-paul.gortmaker@windriver.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/12/18 6:04 AM, Paul Gortmaker wrote:
> The most important thing to note here, is these clean-ups make no
> changes to the final generated run-time.  The 1st commit removes an
> unused function, otherwise the generated objects are also unchanged.
> 
> The work here represents a scan over the phy dir, looking for files
> that have nothing to do with a modular use case, but are using modular
> infrastructure regardless.
> 
> We are trying to make driver code consistent with the Makefiles/Kconfigs
> that control them.  This means not using modular functions/macros for
> drivers that can never be built as a module.  This has been done in quite
> a lot of other mainline subsystem dirs already.
> 
> Using modular infrastructure in non-modules might seem harmless, but some
> of the downfalls this leads to are:
> 
>  (1) it is easy to accidentally write unused module_exit and remove code
>  (2) it can be misleading when reading the source, thinking it can be
>      modular when the Makefile and/or Kconfig prohibit it
>  (3) it requires the include of the module.h header file which in turn
>      includes nearly everything else, thus adding to CPP overhead.
>  (4) it gets copied/replicated into other drivers and spreads quickly.
> 
> As a data point for #3 above, an empty C file that just includes the
> module.h header generates over 750kB of CPP output.  Repeating the same
> experiment with init.h and the result is less than 12kB; with export.h
> it is only about 1/2kB; with both it still is less than 12kB.
> 
> Build tested on x86-64 and ARM-64.

merged, thanks!

-Kishon
> 
> Paul.
> ---
> 
> Cc: Andrew Lunn <andrew@lunn.ch>
> Cc: Gregory CLEMENT <gregory.clement@free-electrons.com>
> Cc: Kishon Vijay Abraham I <kishon@ti.com>
> 
> Paul Gortmaker (3):
>   phy: make phy-core explicitly non-modular
>   phy: make phy-mvebu-sata explicitly non-modular
>   phy: make phy-armada375-usb2 explicitly non-modular
> 
>  drivers/phy/marvell/phy-armada375-usb2.c |  8 +-------
>  drivers/phy/marvell/phy-mvebu-sata.c     |  9 ++-------
>  drivers/phy/phy-core.c                   | 12 +-----------
>  3 files changed, 4 insertions(+), 25 deletions(-)
> 
