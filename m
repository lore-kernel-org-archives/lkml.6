Return-Path: <SRS0=sHJz=MZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BB79C28CF8
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Oct 2018 07:22:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 24D1F2087D
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Oct 2018 07:22:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 24D1F2087D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=telegraphics.com.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726920AbeJMO6W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 13 Oct 2018 10:58:22 -0400
Received: from kvm5.telegraphics.com.au ([98.124.60.144]:48792 "EHLO
        kvm5.telegraphics.com.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726097AbeJMO6W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Oct 2018 10:58:22 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
        by kvm5.telegraphics.com.au (Postfix) with ESMTP id 94C6829E16;
        Sat, 13 Oct 2018 03:22:17 -0400 (EDT)
Date:   Sat, 13 Oct 2018 18:22:18 +1100 (AEDT)
From:   Finn Thain <fthain@telegraphics.com.au>
To:     Christoph Hellwig <hch@infradead.org>
cc:     "James E.J. Bottomley" <jejb@linux.vnet.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Michael Schmitz <schmitzmic@gmail.com>,
        Hannes Reinecke <hare@suse.de>, linux-scsi@vger.kernel.org,
        linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/6] esp_scsi: De-duplicate PIO routines
In-Reply-To: <20181013070508.GA15008@infradead.org>
Message-ID: <alpine.LNX.2.21.1810131817540.375@nippy.intranet>
References: <cover.1539391876.git.fthain@telegraphics.com.au> <09d3a141dc16af63921f5414263069e9b4f97222.1539391876.git.fthain@telegraphics.com.au> <20181013070508.GA15008@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 13 Oct 2018, Christoph Hellwig wrote:

> > +#if IS_ENABLED(CONFIG_SCSI_MAC_ESP) || IS_ENABLED(CONFIG_SCSI_ZORRO_ESP)
> 
> Please add a new CONFIG_SCSI_ESP_PIO symbol that is selected by
> the mac and zorro drivers instead.
> 

OK.

> > +	pr_err("FIFO is empty (sreg %02x)\n", esp_read8(ESP_STATUS));
> 
> This should probably use dev_err (at least with my series).
> 

How about shost_printk()? That would be consistent with the rest of 
esp_scsi.c. It also means my series need not depend on yours which would 
complicate things.

-- 
