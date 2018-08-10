Return-Path: <SRS0=aVpA=KZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA44AC4646D
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 16:49:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A3CF223AB
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 16:49:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9A3CF223AB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lxorguk.ukuu.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729705AbeHJTTg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Aug 2018 15:19:36 -0400
Received: from www.llwyncelyn.cymru ([82.70.14.225]:55702 "EHLO fuzix.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727570AbeHJTTf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Aug 2018 15:19:35 -0400
Received: from alans-desktop (82-70-14-226.dsl.in-addr.zen.co.uk [82.70.14.226])
        by fuzix.org (8.15.2/8.15.2) with ESMTP id w7AGmad8011629;
        Fri, 10 Aug 2018 17:48:36 +0100
Date:   Fri, 10 Aug 2018 17:48:36 +0100
From:   Alan Cox <gnomes@lxorguk.ukuu.org.uk>
To:     "Raj, Ashok" <ashok.raj@intel.com>
Cc:     Alex Williamson <alex.williamson@redhat.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
        Joerg Roedel <joro@8bytes.org>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Gage Eads <gage.eads@intel.com>
Subject: Re: [PATCH] vfio/pci: Some buggy virtual functions incorrectly
 report 1 for intx.
Message-ID: <20180810174836.66d9791b@alans-desktop>
In-Reply-To: <20180809230311.GA79703@otc-nc-03>
References: <1533843426-79170-1-git-send-email-ashok.raj@intel.com>
        <20180809134417.50de7fe7@t450s.home>
        <20180809230311.GA79703@otc-nc-03>
Organization: Intel Corporation
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> The hardware isn't public yet, so can't talk about it :-(. Once this patch gets 
> merged, will let the OSV engagement folks drive it for inclusions. We 
> could mark this for stable, but i would rather wait until we know the 
> timeline when they are expecting it to be in. It shouldn't break anything
> since we are just enforcing the spec.

Until a new better spec appears...

I know there is always fun when it comes to the people involved in
such a screwup having to admit it in public but this should IMHO be
tied to a PCI identifier table so that we know what the afflicted
hardware is. Otherwise some day in the future SRIOV will grow new features
and we'll have no idea what particular devices we need to narrow the
workaround too and indeed not necessarily even know this device is the
only one, as we'll silently fix other stuff then have it break on us
later.

Alan
