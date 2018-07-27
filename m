Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B12AC6778F
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 22:19:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0EAF920647
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 22:19:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="sHJGDY/L"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0EAF920647
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388851AbeG0Xmx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Jul 2018 19:42:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:48798 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728656AbeG0Xmx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jul 2018 19:42:53 -0400
Received: from localhost (unknown [69.71.4.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 52D5520647;
        Fri, 27 Jul 2018 22:18:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1532729937;
        bh=/4Oyp04Bh+cstm92mcgrbFBE1Sg7hmnbi0xFTfLrllc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=sHJGDY/L4gYTG/wdtSV7B71u8JzR8HRs2ccMvTJ7W8GFsZMQg4foHlarg68TY3jeI
         Dba3It8v+nVuQ6UitRhser5Tvk8zFJdaIkBGtNz/adLSA0GKhXeufmBv0gSRX6O1zm
         3XOa/NFM3Cl4HVdA5t3zH8s+/XUz212JHuDVp3r0=
Date:   Fri, 27 Jul 2018 17:18:55 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     linux-pci@vger.kernel.org
Cc:     Jeff Kirsher <jeffrey.t.kirsher@intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        Kalle Valo <kvalo@codeaurora.org>,
        Johannes Berg <johannes.berg@intel.com>,
        Emmanuel Grumbach <emmanuel.grumbach@intel.com>,
        Luca Coelho <luciano.coelho@intel.com>,
        ath9k-devel@qca.qualcomm.com, linuxwifi@intel.com,
        intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org
Subject: Re: [PATCH v1 0/4] PCI: Remove unnecessary includes of
 <linux/pci-aspm.h>
Message-ID: <20180727221855.GG173328@bhelgaas-glaptop.roam.corp.google.com>
References: <153254813164.92573.10755585465477668768.stgit@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <153254813164.92573.10755585465477668768.stgit@bhelgaas-glaptop.roam.corp.google.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 25, 2018 at 02:52:08PM -0500, Bjorn Helgaas wrote:
> Remove includes of <linux/pci-aspm.h> from files that don't need
> it.  I'll apply all these via the PCI tree unless there's objection.
> 
> ---
> 
> Bjorn Helgaas (4):
>       igb: Remove unnecessary include of <linux/pci-aspm.h>
>       ath9k: Remove unnecessary include of <linux/pci-aspm.h>
>       iwlwifi: Remove unnecessary include of <linux/pci-aspm.h>
>       PCI: Remove unnecessary include of <linux/pci-aspm.h>
> 
> 
>  drivers/net/ethernet/intel/igb/igb_main.c     |    1 -
>  drivers/net/wireless/ath/ath9k/pci.c          |    1 -
>  drivers/net/wireless/intel/iwlwifi/pcie/drv.c |    1 -
>  drivers/pci/pci-sysfs.c                       |    1 -
>  drivers/pci/pci.c                             |    1 -
>  drivers/pci/probe.c                           |    1 -
>  drivers/pci/remove.c                          |    1 -
>  7 files changed, 7 deletions(-)

I applied these to the pci/aspm branch for v4.19.
