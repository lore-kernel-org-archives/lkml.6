Return-Path: <SRS0=S+WB=KJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DE16C67790
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 21:00:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 20CFD20844
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 21:00:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="jtpyP9iH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 20CFD20844
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731379AbeGYWN2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Jul 2018 18:13:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:50732 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730357AbeGYWN2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jul 2018 18:13:28 -0400
Received: from localhost (unknown [69.71.4.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 23E0D20852;
        Wed, 25 Jul 2018 20:59:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1532552401;
        bh=hTSG9vdkaiIeIFTdsT1pQ7aEYfvM+zdA4Uss5vA+Kn0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jtpyP9iHVSjbKIhFUSN97zYRuAh1bYKZZYN8VfwuqG8Di8VNdZJ5AAN5ZgiVCnKQY
         3SVNCCgPqOM0ZiAUqvDz6E1aKUZLi3eWKqef2pJfW6PdRUSPHP/O+tc5e5g2LkVe0c
         Wfxu4UhaG6jgUr7kBuJW3s3yn0EWXTuVBL1iHw5k=
Date:   Wed, 25 Jul 2018 15:59:29 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Sinan Kaya <okaya@kernel.org>
Cc:     linux-pci@vger.kernel.org,
        Jeff Kirsher <jeffrey.t.kirsher@intel.com>,
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
Message-ID: <20180725205929.GB173328@bhelgaas-glaptop.roam.corp.google.com>
References: <153254813164.92573.10755585465477668768.stgit@bhelgaas-glaptop.roam.corp.google.com>
 <43748afd-712a-48e5-97a9-0b6046f575b3@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43748afd-712a-48e5-97a9-0b6046f575b3@kernel.org>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 25, 2018 at 01:33:23PM -0700, Sinan Kaya wrote:
> On 7/25/2018 12:52 PM, Bjorn Helgaas wrote:
> > emove includes of <linux/pci-aspm.h> from files that don't need
> > it.  I'll apply all these via the PCI tree unless there's objection.
> > 
> > ---
> > 
> > Bjorn Helgaas (4):
> >        igb: Remove unnecessary include of <linux/pci-aspm.h>
> >        ath9k: Remove unnecessary include of <linux/pci-aspm.h>
> >        iwlwifi: Remove unnecessary include of <linux/pci-aspm.h>
> >        PCI: Remove unnecessary include of <linux/pci-aspm.h>
> 
> Thanks.
> 
> Reviewed-by: Sinan Kaya <okaya@kernel.org>
> 
> Is it possible to kill that file altogether? I haven't looked who is
> using outside of pci directory.

Thanks for taking a look!

It's possible we could remove it altogether; there's very little in
it, and in most cases the only reason drivers include it is to disable
certain ASPM link states to work around hardware defects.  It might
make sense to just move that interface into <linux/pci.h>.
