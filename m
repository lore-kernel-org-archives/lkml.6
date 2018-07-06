Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 877A7C3279B
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 08:04:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 41DD923EE5
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 08:04:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 41DD923EE5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753839AbeGFIEx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 04:04:53 -0400
Received: from mx2.suse.de ([195.135.220.15]:55512 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751763AbeGFIEt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 04:04:49 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 27D18AD97;
        Fri,  6 Jul 2018 08:04:48 +0000 (UTC)
Date:   Fri, 6 Jul 2018 10:04:47 +0200
From:   Johannes Thumshirn <jthumshirn@suse.de>
To:     Bart Van Assche <Bart.VanAssche@wdc.com>
Cc:     "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "RaghavaAditya.Renukunta@microsemi.com" 
        <RaghavaAditya.Renukunta@microsemi.com>,
        "david.carroll@microsemi.com" <david.carroll@microsemi.com>
Subject: Re: [PATCH 1/4] scsi: aacraid: remove AAC_STAT_GOOD define
Message-ID: <20180706080447.2u3iptpnvmso6ncc@linux-x5ow.site>
References: <20180705110140.19545-1-jthumshirn@suse.de>
 <20180705110140.19545-2-jthumshirn@suse.de>
 <babfea1746aaca57109f84bff674dda635a76e29.camel@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <babfea1746aaca57109f84bff674dda635a76e29.camel@wdc.com>
User-Agent: NeoMutt/20170912 (1.9.0)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 05, 2018 at 05:24:23PM +0000, Bart Van Assche wrote:
> On Thu, 2018-07-05 at 13:01 +0200, Johannes Thumshirn wrote:
> >  		if (((aac_cache & 6) == 6) && dev->cache_protected) {
> > -			scsicmd->result = AAC_STAT_GOOD;
> > +			scsicmd->result = DID_OK << 16 | COMMAND_COMPLETE << 8 |
> > +					  SAM_STAT_GOOD;
> 
> Does AAC_STAT_GOOD really have to be expanded in full multiple times?
> Have you considered to replace AAC_STAT_GOOD by the numerical constant
> 0 instead?

This won't work anymore once we start splitting ->result into 4
unrelated enums. That's why I prefer this way.

Byte,
	Johannes
-- 
Johannes Thumshirn                                          Storage
jthumshirn@suse.de                                +49 911 74053 689
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 Nürnberg
GF: Felix Imendörffer, Jane Smithard, Graham Norton
HRB 21284 (AG Nürnberg)
Key fingerprint = EC38 9CAB C2C4 F25D 8600 D0D0 0393 969D 2D76 0850
