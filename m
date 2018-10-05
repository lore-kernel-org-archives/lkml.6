Return-Path: <SRS0=9Qwj=MR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29712C00449
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 14:26:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF134208E7
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 14:26:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ocux4ypY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CF134208E7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728852AbeJEVZk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Oct 2018 17:25:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:52110 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727968AbeJEVZj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Oct 2018 17:25:39 -0400
Received: from localhost (unknown [171.76.113.63])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 49D822084D;
        Fri,  5 Oct 2018 14:26:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1538749602;
        bh=NeoU8WHoJ1ouTUceAiqMFtJ5GQB4armtRjXQ7aBClis=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Ocux4ypYD3JmJoR2VMPLAPI+fFwoC+ycLg5lkmQaoXX09LuYK9tTuX2DI5XGItBgp
         p3bA0nfTR/BqeJIqS6t8aOWMdUbFYcIySbrUtMDlBjpgCay6sUE/Yt9xVvtBDWVM4c
         0Np/831H5rLO6Uc2HfQNMzzxRJNxPOGbTucMLCLg=
Date:   Fri, 5 Oct 2018 19:56:34 +0530
From:   Vinod <vkoul@kernel.org>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Oza Pawandeep <poza@codeaurora.org>,
        Jeff Kirsher <jeffrey.t.kirsher@intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        Solarflare linux maintainers <linux-net-drivers@solarflare.com>,
        Edward Cree <ecree@solarflare.com>,
        Jacob Keller <jacob.e.keller@intel.com>,
        Amritha Nambiar <amritha.nambiar@intel.com>,
        Alan Brady <alan.brady@intel.com>,
        Alexander Duyck <alexander.h.duyck@intel.com>,
        Shannon Nelson <shannon.nelson@oracle.com>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org
Subject: Re: [PATCH] XXX PCI/AER: remove unused variables
Message-ID: <20181005142634.GL2372@vkoul-mobl>
References: <20181002210426.2447078-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181002210426.2447078-1-arnd@arndb.de>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02-10-18, 23:02, Arnd Bergmann wrote:
> A couple of files now contain a function with a return
> code variable that is no longer used:
> 
> drivers/net/ethernet/sfc/efx.c: In function 'efx_io_slot_reset':
> drivers/net/ethernet/sfc/efx.c:3824:6: error: unused variable 'rc' [-Werror=unused-variable]
>   int rc;
>       ^~
> drivers/net/ethernet/sfc/falcon/efx.c: In function 'ef4_io_slot_reset':
> Oza Pawandeep <poza@codeaurora.org>
> drivers/net/ethernet/sfc/falcon/efx.c:3163:6: error: unused variable 'rc' [-Werror=unused-variable]
>   int rc;
>       ^~
> drivers/net/ethernet/intel/ixgbe/ixgbe_main.c: In function 'ixgbe_io_slot_reset':
> drivers/net/ethernet/intel/ixgbe/ixgbe_main.c:11143:6: error: unused variable 'err' [-Werror=unused-variable]
>   int err;
>       ^~~
> drivers/net/ethernet/intel/i40e/i40e_main.c: In function 'i40e_pci_error_slot_reset':
> drivers/net/ethernet/intel/i40e/i40e_main.c:14555:6: error: unused variable 'err' [-Werror=unused-variable]
>   int err;
> 
> drivers/dma/ioat/init.c: In function 'ioat_pcie_error_slot_reset':
> drivers/dma/ioat/init.c:1255:6: error: unused variable 'err' [-Werror=unused-variable]
>   int err;
> 
> This removes all the ones I found during randconfig build testing.
> 
> Fixes: 6dcde3e574b2 ("XXX PCI/AER: Remove pci_cleanup_aer_uncorrect_error_status() calls")
> Cc: Oza Pawandeep <poza@codeaurora.org>
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  drivers/dma/ioat/init.c                       | 1 -

For this:

Acked-by: Vinod Koul <vkoul@kernel.org>
-- 
~Vinod
