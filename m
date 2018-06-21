Return-Path: <SRS0=bmN+=JH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABBFFC43141
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 16:48:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 68DAD216FB
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 16:48:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 68DAD216FB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933645AbeFUQsm (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Jun 2018 12:48:42 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:52470 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933391AbeFUQsk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jun 2018 12:48:40 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7BB1D1435;
        Thu, 21 Jun 2018 09:48:40 -0700 (PDT)
Received: from e107981-ln.cambridge.arm.com (e107981-ln.cambridge.arm.com [10.1.207.54])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4B1463F557;
        Thu, 21 Jun 2018 09:48:39 -0700 (PDT)
Date:   Thu, 21 Jun 2018 17:48:29 +0100
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Ray Jui <ray.jui@broadcom.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Bjorn Helgaas <helgaas@kernel.org>,
        linux-kernel@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com, linux-pci@vger.kernel.org
Subject: Re: [PATCH v2 0/5] Improve Broadcom PAXC support
Message-ID: <20180621164821.GA14519@e107981-ln.cambridge.arm.com>
References: <1528762867-16823-1-git-send-email-ray.jui@broadcom.com>
 <45945371-3cd7-102d-bb47-69a60435542b@broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <45945371-3cd7-102d-bb47-69a60435542b@broadcom.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 20, 2018 at 10:26:28AM -0700, Ray Jui wrote:
> Hi Lorenzo/Bjorn,
> 
> Could you please help to review this patch series when you have time?
> 
> I believe I have addressed major comment in v1 from Bjorn and answered all
> questions from Lorenzo.

I will have a look next week, sorry for the delay.

Thanks,
Lorenzo

> Thanks,
> 
> Ray
> 
> On 6/11/2018 5:21 PM, Ray Jui wrote:
> >This patch series improves the Broadcom PAXC support by 1) adding more
> >quirks for specific versions of PAXC controllers; 2) adding logic to
> >reject internally unconfigured physical functions from the embedded
> >network processor acting as endpoint; 3) reducing verbose print level
> >in the outbound/inbound mapping code
> >
> >This patch series is based off v4.17 and is available on GIHUB:
> >repo: https://github.com/Broadcom/arm64-linux.git
> >branch: sr-paxc-v2
> >
> >Changes since v1:
> >  - consolidate 2 PAXC related patch series into 1
> >  - change the way how the capability list corruption is handled, per
> >recommendation from Bjorn. Now handle and fix up the corruption at
> >the config register read
> >  - rebase to v4.17
> >
> >Ray Jui (5):
> >   PCI: iproc: Activate PAXC bridge quirk for more devices
> >   PCI: iproc: Fix up corrupted PAXC root complex config registers
> >   PCI: iproc: Disable MSI parsing in certain PAXC blocks
> >   PCI: iproc: Reject unconfigured physical functions from PAXC
> >   PCI: iproc: Reduce inbound/outbound mapping print level
> >
> >  drivers/pci/host/pcie-iproc.c | 159 +++++++++++++++++++++++++++++++++++-------
> >  drivers/pci/host/pcie-iproc.h |   8 +++
> >  drivers/pci/quirks.c          |   3 +
> >  3 files changed, 144 insertions(+), 26 deletions(-)
> >
