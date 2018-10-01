Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A465C43143
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 12:35:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC2892089C
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 12:35:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BC2892089C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729273AbeJATMq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Oct 2018 15:12:46 -0400
Received: from verein.lst.de ([213.95.11.211]:37488 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729017AbeJATMq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Oct 2018 15:12:46 -0400
Received: by newverein.lst.de (Postfix, from userid 2407)
        id 68C6368B02; Mon,  1 Oct 2018 14:35:08 +0200 (CEST)
Date:   Mon, 1 Oct 2018 14:35:08 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Paul Menzel <pmenzel+linux-scsi@molgen.mpg.de>
Cc:     Ming Lei <ming.lei@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        it+linux-scsi@molgen.mpg.de,
        Adaptec OEM Raid Solutions <aacraid@microsemi.com>,
        linux-scsi@vger.kernel.org,
        Raghava Aditya Renukunta 
        <RaghavaAditya.Renukunta@microsemi.com>,
        Dave Carroll <david.carroll@microsemi.com>
Subject: Re: [PATCH] Revert "genirq/affinity: assign vectors to all
 possible CPUs"
Message-ID: <20181001123508.GA3415@lst.de>
References: <06ee23fe-ec9e-d67b-b533-d5151be74a11@molgen.mpg.de> <20180810133628.GA4131@kroah.com> <29b5f3ce-2c23-bf5e-fe50-29bedd4833e1@molgen.mpg.de> <20180810155511.GA17092@kroah.com> <f5c57bf7-b8c1-a560-d13a-d74e0f27adbb@molgen.mpg.de> <20180811135021.GA2186@kroah.com> <20180813033157.GA18254@ming.t460p> <89f2b622-3d2a-04ce-a6d1-ffb5d9612763@molgen.mpg.de> <cbd7cb64-dbfe-e085-e80b-67dad4084d69@molgen.mpg.de> <7c51fe1d-d591-90f2-8fb5-81990f8db0fe@molgen.mpg.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7c51fe1d-d591-90f2-8fb5-81990f8db0fe@molgen.mpg.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 01, 2018 at 02:33:07PM +0200, Paul Menzel wrote:
> Date: Wed, 29 Aug 2018 17:28:45 +0200
> 
> This reverts commit ef86f3a72adb8a7931f67335560740a7ad696d1d.

This seems rather odd.  If add all you'd revert the patch adding the
PCI_IRQ_AFFINITY to aacraid, not core infrastructure.
