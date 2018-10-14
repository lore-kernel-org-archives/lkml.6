Return-Path: <SRS0=+AQW=M2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36235C71122
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Oct 2018 23:04:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E21A120652
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Oct 2018 23:04:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E21A120652
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=telegraphics.com.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726397AbeJOGrK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Oct 2018 02:47:10 -0400
Received: from kvm5.telegraphics.com.au ([98.124.60.144]:59480 "EHLO
        kvm5.telegraphics.com.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725722AbeJOGrK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Oct 2018 02:47:10 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
        by kvm5.telegraphics.com.au (Postfix) with ESMTP id 20ABD22C30;
        Sun, 14 Oct 2018 19:04:29 -0400 (EDT)
Date:   Mon, 15 Oct 2018 10:04:27 +1100 (AEDT)
From:   Finn Thain <fthain@telegraphics.com.au>
To:     Michael Schmitz <schmitzmic@gmail.com>
cc:     Christoph Hellwig <hch@infradead.org>,
        "James E.J. Bottomley" <jejb@linux.vnet.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Hannes Reinecke <hare@suse.de>, linux-scsi@vger.kernel.org,
        linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/6] esp_scsi: Grant disconnect privilege for untagged
 commands
In-Reply-To: <4719e984-2c7e-33e1-6e7c-16dea5d4f610@gmail.com>
Message-ID: <alpine.LNX.2.21.1810150959290.10@nippy.intranet>
References: <cover.1539497520.git.fthain@telegraphics.com.au> <91b9ff9fc19ba40e3a2562171c8cd78a2ce7dc79.1539497520.git.fthain@telegraphics.com.au> <20181014154753.GA19252@infradead.org> <4719e984-2c7e-33e1-6e7c-16dea5d4f610@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 15 Oct 2018, Michael Schmitz wrote:

> 
> Do we really need to make that distinction?
> 

esp_reconnect() dereferences lp, so !lp has to inhibit disconnection.

At least, that's my reading. I can't see any other reason for the lp 
conditional.

-- 
