Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9618BC5ACC6
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 22:27:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 637A72147C
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 22:27:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 637A72147C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=telegraphics.com.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727186AbeJQGUR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 02:20:17 -0400
Received: from kvm5.telegraphics.com.au ([98.124.60.144]:49526 "EHLO
        kvm5.telegraphics.com.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726952AbeJQGUR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 02:20:17 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
        by kvm5.telegraphics.com.au (Postfix) with ESMTP id C8EE3282AB;
        Tue, 16 Oct 2018 18:27:44 -0400 (EDT)
Date:   Wed, 17 Oct 2018 09:27:45 +1100 (AEDT)
From:   Finn Thain <fthain@telegraphics.com.au>
To:     "Martin K. Petersen" <martin.petersen@oracle.com>
cc:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Adaptec OEM Raid Solutions <aacraid@microsemi.com>,
        "James E.J. Bottomley" <jejb@linux.vnet.ibm.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] scsi: ips: fix missing break in switch
In-Reply-To: <yq1ftx5sgw1.fsf@oracle.com>
Message-ID: <alpine.LNX.2.21.1810170922480.130@nippy.intranet>
References: <20181016091223.GA19765@embeddedor.com> <yq1ftx5sgw1.fsf@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 16 Oct 2018, Martin K. Petersen wrote:

> 
> Gustavo,
> 
> > Add missing break statement in order to prevent the code from falling
> > through to case TEST_UNIT_READY.
> 
> Applied to 4.20/scsi-queue, thanks!
> 
> 

This looks wrong to me. I think you've just prevented all START STOP 
commands sent to logical volumes from reaching

        return ((*ha->func.issue) (ha, scb));

I think a better patch is to add a "fall though" comment not a "break" 
statement. (I no longer have access to a ServeRAID board so I can't test.)

-- 
