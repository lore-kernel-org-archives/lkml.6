Return-Path: <SRS0=aTzB=K7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CC57C4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 19:15:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 32A6F2147A
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 19:15:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 32A6F2147A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726170AbeHPWPf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Aug 2018 18:15:35 -0400
Received: from mga09.intel.com ([134.134.136.24]:54198 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725783AbeHPWPf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Aug 2018 18:15:35 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 16 Aug 2018 12:15:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,248,1531810800"; 
   d="scan'208";a="65775219"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.157])
  by orsmga008.jf.intel.com with SMTP; 16 Aug 2018 12:15:16 -0700
Received: by lahna (sSMTP sendmail emulation); Thu, 16 Aug 2018 22:15:15 +0300
Date:   Thu, 16 Aug 2018 22:15:15 +0300
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Linux PCI <linux-pci@vger.kernel.org>,
        teika kazura <teika@gmx.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>
Subject: Re: [PATCH] PCI / ACPI / PM: Resume all bridges on suspend-to-RAM
Message-ID: <20180816191515.GM2343@lahna.fi.intel.com>
References: <6401388.2t0qD3iTOr@aspire.rjw.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6401388.2t0qD3iTOr@aspire.rjw.lan>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 16, 2018 at 12:56:46PM +0200, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Commit 26112ddc254c (PCI / ACPI / PM: Resume bridges w/o drivers on
> suspend-to-RAM) attempted to fix a functional regression resulting
> from commit c62ec4610c40 (PM / core: Fix direct_complete handling
> for devices with no callbacks) by resuming PCI bridges without
> drivers (that is, "parallel PCI" ones) during system-wide suspend if
> the target system state is not ACPI S0 (working state).
> 
> That turns out insufficient, however, as it is reported that, at
> least in one case, the platform firmware gets confused if a PCIe
> root port is suspended before entering the ACPI S3 sleep state.
> 
> For this reason, drop the driver check from acpi_pci_need_resume()
> and resume all bridges (including PCIe ports with drivers) during
> system-wide suspend if the target system state is not ACPI S0.
> 
> [If the target system state is ACPI S0, it means suspend-to-idle
>  and the platform firmware is not going to be invoked to actually
>  suspend the system, so there is no need to resume the bridges in
>  that case.]
> 
> Fixes: c62ec4610c40 (PM / core: Fix direct_complete handling for devices with no callbacks)
> Reported-by: teika kazura <teika@gmx.com>
> Tested-by: teika kazura <teika@gmx.com>
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=200675
> Cc: 4.15+ <stable@vger.kernel.org> # 4.15+: 26112ddc254c (PCI / ACPI / PM: Resume bridges ...)
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
