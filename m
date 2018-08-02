Return-Path: <SRS0=MSGh=KR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C8BCC43142
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 12:51:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE29C21501
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 12:51:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CE29C21501
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387461AbeHBOmr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Aug 2018 10:42:47 -0400
Received: from mx2.suse.de ([195.135.220.15]:60712 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2387420AbeHBOmr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Aug 2018 10:42:47 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id CF4C0AF68;
        Thu,  2 Aug 2018 12:51:42 +0000 (UTC)
Date:   Thu, 2 Aug 2018 14:51:41 +0200
From:   Johannes Thumshirn <jthumshirn@suse.de>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Bart Van Assche <Bart.VanAssche@wdc.com>,
        "James.Bottomley@HansenPartnership.com" 
        <James.Bottomley@HansenPartnership.com>,
        "tom.leiming@gmail.com" <tom.leiming@gmail.com>,
        "sfr@canb.auug.org.au" <sfr@canb.auug.org.au>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-next@vger.kernel.org" <linux-next@vger.kernel.org>
Subject: Re: linux-next: Tree for Aug 1
Message-ID: <20180802125141.jyb2zz75jgrzibaq@linux-x5ow.site>
References: <20180801175852.36549130@canb.auug.org.au>
 <20180801224813.GA13074@roeck-us.net>
 <1533163965.3158.1.camel@HansenPartnership.com>
 <20180801234727.GA3762@roeck-us.net>
 <CACVXFVMrzLRP5Q=cwZGnqeUeyODL3Pq9jMkT7czZouK9510fUA@mail.gmail.com>
 <1533168205.3158.12.camel@HansenPartnership.com>
 <171b2cdc-2e74-2b3c-e5f5-c656a196601a@roeck-us.net>
 <e3e32fd801cb1270cddec6fc1ea3dabad4473b64.camel@wdc.com>
 <93cbb876-3a25-482a-a5b4-6e13d42ee535@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <93cbb876-3a25-482a-a5b4-6e13d42ee535@roeck-us.net>
User-Agent: NeoMutt/20170912 (1.9.0)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 02, 2018 at 05:46:19AM -0700, Guenter Roeck wrote:
> This is consistent across multiple test runs. In summary,
> 
> - Boot from initrd fails
> - Boot from SATA drive fails (this is with CONFIG_ATA)
> - Boot from NVME fails
> - Boot from USB drive fails
> - Boot from MMC (SD) fails
> - Boot from USB UAS drive passes
> - Boot from various real SCSI drives passes
> 
> Platform (pc,q35), CPU type, or SMP/NOSMP does not seem to make a difference.

OK. I try to bisect between next-20180727 (known good) and
next-20180731 (known bad) with forced scsi_mod.use_blk_mq=1, but so
far the only bad I've seen is next-20180731.

Byte,
	Johannes
-- 
Johannes Thumshirn                                          Storage
jthumshirn@suse.de                                +49 911 74053 689
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 Nürnberg
GF: Felix Imendörffer, Jane Smithard, Graham Norton
HRB 21284 (AG Nürnberg)
Key fingerprint = EC38 9CAB C2C4 F25D 8600 D0D0 0393 969D 2D76 0850
