Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE9DCC43441
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 16:35:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B6B53208A3
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 16:35:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B6B53208A3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=interlog.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729200AbeKLCYQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 11 Nov 2018 21:24:16 -0500
Received: from smtp.infotech.no ([82.134.31.41]:36550 "EHLO smtp.infotech.no"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727817AbeKLCYQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Nov 2018 21:24:16 -0500
Received: from localhost (localhost [127.0.0.1])
        by smtp.infotech.no (Postfix) with ESMTP id 81BF920423F;
        Sun, 11 Nov 2018 17:35:14 +0100 (CET)
X-Virus-Scanned: by amavisd-new-2.6.6 (20110518) (Debian) at infotech.no
Received: from smtp.infotech.no ([127.0.0.1])
        by localhost (smtp.infotech.no [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id Bjai95owhmHm; Sun, 11 Nov 2018 17:35:08 +0100 (CET)
Received: from [172.16.0.116] (80.92-221-215.customer.lyse.net [92.221.215.80])
        by smtp.infotech.no (Postfix) with ESMTPA id 0E056204154;
        Sun, 11 Nov 2018 17:35:07 +0100 (CET)
Reply-To: dgilbert@interlog.com
Subject: Re: remove exofs, the T10 OSD code and block/scsi bidi support V3
To:     Christoph Hellwig <hch@lst.de>, axboe@kernel.dk,
        martin.petersen@oracle.com, ooo@electrozaur.com
Cc:     Johannes Thumshirn <jthumshirn@suse.de>,
        Benjamin Block <bblock@linux.vnet.ibm.com>,
        linux-scsi@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20181111133211.13926-1-hch@lst.de>
From:   Douglas Gilbert <dgilbert@interlog.com>
Message-ID: <5c1952ce-988e-45be-db01-0cf7277be0f5@interlog.com>
Date:   Sun, 11 Nov 2018 17:35:07 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181111133211.13926-1-hch@lst.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-CA
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-11-11 2:32 p.m., Christoph Hellwig wrote:
> The only real user of the T10 OSD protocol, the pNFS object layout
> driver never went to the point of having shipping products, and we
> removed it 1.5 years ago.  Exofs is just a simple example without
> real life users.
> 
> The code has been mostly unmaintained for years and is getting in the
> way of block / SCSI changes, so I think it's finally time to drop it.
> 
> Quote from Boaz:
> 
> "As I said then. It is used in Universities for studies and experiments.
> Every once in a while. I get an email with questions and reports.
> 
> But yes feel free to remove the all thing!!
> 
> I guess I can put it up on github. In a public tree.
> 
> Just that I will need to forward port it myself, til now you guys
> been doing this for me ;-)"
> 
> Now the last time this caused a bit of a stir, but still no actual users,
> not even for SG_IO passthrough commands.

What?? Do any Linux distros track what commands are sent to any (or all)
of the SG_IO passthroughs? I would hope that the last part of that
sentence remains unprovable.

Doug Gilbert

"I've told you a million times, don't exaggerate!"
