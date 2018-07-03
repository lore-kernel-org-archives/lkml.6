Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34599C6778A
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 10:23:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E621520779
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 10:23:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E621520779
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mentor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754777AbeGCKXw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 06:23:52 -0400
Received: from relay1.mentorg.com ([192.94.38.131]:37191 "EHLO
        relay1.mentorg.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754536AbeGCKXv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 06:23:51 -0400
Received: from nat-ies.mentorg.com ([192.94.31.2] helo=SVR-IES-MBX-04.mgc.mentorg.com)
        by relay1.mentorg.com with esmtps (TLSv1.2:ECDHE-RSA-AES256-SHA384:256)
        id 1faITH-00019p-HL from Vladimir_Zapolskiy@mentor.com ; Tue, 03 Jul 2018 03:23:43 -0700
Received: from [137.202.108.125] (137.202.0.87) by
 SVR-IES-MBX-04.mgc.mentorg.com (139.181.222.4) with Microsoft SMTP Server
 (TLS) id 15.0.1320.4; Tue, 3 Jul 2018 11:23:39 +0100
Subject: Re: [PATCH 2/2] misc: sram: enable clock before registering regions
To:     Johan Hovold <johan@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
References: <20180703100548.30214-1-johan@kernel.org>
 <20180703100548.30214-2-johan@kernel.org>
CC:     Arnd Bergmann <arnd@arndb.de>,
        Alexandre Belloni <alexandre.belloni@free-electrons.com>,
        <linux-kernel@vger.kernel.org>
From:   Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>
Message-ID: <e736a83f-bdd9-d136-070d-7093f5e8be2c@mentor.com>
Date:   Tue, 3 Jul 2018 13:23:30 +0300
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:45.0) Gecko/20100101
 Icedove/45.2.0
MIME-Version: 1.0
In-Reply-To: <20180703100548.30214-2-johan@kernel.org>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [137.202.0.87]
X-ClientProxiedBy: svr-ies-mbx-01.mgc.mentorg.com (139.181.222.1) To
 SVR-IES-MBX-04.mgc.mentorg.com (139.181.222.4)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Johan,

On 07/03/2018 01:05 PM, Johan Hovold wrote:
> Make sure to enable the clock before registering regions and exporting
> partitions to user space at which point we must be prepared for I/O.
> 
> Fixes: ee895ccdf776 ("misc: sram: fix enabled clock leak on error path")
> Cc: Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>
> Signed-off-by: Johan Hovold <johan@kernel.org>

thank you for the change, however please note that the identified commit
for the fix is incorrect one apparently.

In my opinion the proper tag contents would be

Fixes: b4c3fcb3c71f ("misc: sram: extend usage of reserved partitions")

I hope you agree to it, also I would suggest to swap the changes in
the series.

--
Best wishes,
Vladimir
