Return-Path: <SRS0=HMm1=J4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F5F9C43A1D
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 06:10:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD9D320C0C
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 06:10:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CD9D320C0C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726966AbeGLGSM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Jul 2018 02:18:12 -0400
Received: from mx2.suse.de ([195.135.220.15]:43134 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725995AbeGLGSM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jul 2018 02:18:12 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 27E57AD3B;
        Thu, 12 Jul 2018 06:10:09 +0000 (UTC)
Subject: Re: linux-next: build warning after merge of the scsi-mkp tree
To:     Stephen Rothwell <sfr@canb.auug.org.au>,
        James Bottomley <James.Bottomley@HansenPartnership.com>
Cc:     "Martin K. Petersen" <martin.petersen@oracle.com>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Johannes Thumshirn <jth@kernel.org>
References: <20180711141737.57c1e26f@canb.auug.org.au>
 <20180712143057.49bfcab5@canb.auug.org.au>
From:   Hannes Reinecke <hare@suse.de>
Message-ID: <7526aa85-b9ad-d314-4fde-b3936457552c@suse.de>
Date:   Thu, 12 Jul 2018 08:10:08 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.0
MIME-Version: 1.0
In-Reply-To: <20180712143057.49bfcab5@canb.auug.org.au>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/12/2018 06:30 AM, Stephen Rothwell wrote:
> Hi all,
> 
> On Wed, 11 Jul 2018 14:17:37 +1000 Stephen Rothwell <sfr@canb.auug.org.au> wrote:
>>
>> After merging the scsi-mkp tree, today's linux-next build (x86_64
>> allmodconfig) produced this warning:
>>
>> In file included from include/linux/spinlock_types.h:18:0,
>>                  from include/linux/spinlock.h:82,
>>                  from drivers/scsi/libfc/fc_rport.c:61:
>> drivers/scsi/libfc/fc_rport.c: In function 'fc_rport_recv_req':
>> include/linux/lockdep.h:347:45: warning: 'rdata' may be used uninitialized in this function [-Wmaybe-uninitialized]
>>  #define lockdep_is_held(lock)  lock_is_held(&(lock)->dep_map)
>>                                              ^
>> drivers/scsi/libfc/fc_rport.c:1832:24: note: 'rdata' was declared here
>>   struct fc_rport_priv *rdata;
>>                         ^~~~~
>>
>> Introduced by commit
>>
>>   ee35624e1e4e ("scsi: libfc: Add lockdep annotations")
>>
>> It is actually complaining about function fc_rport_recv_plogi_req()
>> (presumably it is being inlined) and this looks like an actual bug :-(
> 
> This warning now appears after the merge of the scsi tree.
> 
I have send a new round of patches to the scsi mailing list (cf
'libfc/fcoe: disc_mutex fixes') which address this issue.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		   Teamlead Storage & Networking
hare@suse.de			               +49 911 74053 688
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 Nürnberg
GF: F. Imendörffer, J. Smithard, J. Guild, D. Upmanyu, G. Norton
HRB 21284 (AG Nürnberg)
