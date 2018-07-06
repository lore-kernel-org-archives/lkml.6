Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AE37C3279B
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 08:08:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 189D823FAF
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 08:08:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 189D823FAF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753616AbeGFIIm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 04:08:42 -0400
Received: from mx2.suse.de ([195.135.220.15]:56228 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753054AbeGFIIk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 04:08:40 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 0F3FCAD97;
        Fri,  6 Jul 2018 08:08:39 +0000 (UTC)
Date:   Fri, 6 Jul 2018 10:08:38 +0200
From:   Johannes Thumshirn <jthumshirn@suse.de>
To:     Bart Van Assche <Bart.VanAssche@wdc.com>
Cc:     "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/4] scsi: bfa: remove ScsiResult macro
Message-ID: <20180706080838.gxdevbhsx2sxl5ou@linux-x5ow.site>
References: <20180705110140.19545-1-jthumshirn@suse.de>
 <20180705110140.19545-3-jthumshirn@suse.de>
 <1f5d6a4266daabfd49bad726f17524d80fdab524.camel@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1f5d6a4266daabfd49bad726f17524d80fdab524.camel@wdc.com>
User-Agent: NeoMutt/20170912 (1.9.0)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 05, 2018 at 05:00:10PM +0000, Bart Van Assche wrote:
> On Thu, 2018-07-05 at 13:01 +0200, Johannes Thumshirn wrote:
> > -	cmnd->result = ScsiResult(DID_OK, SCSI_STATUS_GOOD);
> > +	cmnd->result = DID_OK << 16 | SCSI_STATUS_GOOD;
> 
> Please consider to remove the SCSI_STATUS_GOOD constant since it is
> non-standard and since it used by the bfa driver only. Additionally, since
> SCSI_STATUS_GOOD == 0, please leave out "| SCSI_STATUS_GOOD".

Can we agree on using SAM_STAT_GOOD here? I really don't want to leave
out the trailing "| 0" parts in this stage of the refactoring yet. I'm
still undecided if I don't want a set_scsi_cmnd_status(cmnd, foo, bar,
baz, frob); function in an intermediate step.

-- 
Johannes Thumshirn                                          Storage
jthumshirn@suse.de                                +49 911 74053 689
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 Nürnberg
GF: Felix Imendörffer, Jane Smithard, Graham Norton
HRB 21284 (AG Nürnberg)
Key fingerprint = EC38 9CAB C2C4 F25D 8600 D0D0 0393 969D 2D76 0850
