Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936315AbeCBMAm (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Mar 2018 07:00:42 -0500
Received: from mx2.suse.de ([195.135.220.15]:44702 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S936301AbeCBMAj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Mar 2018 07:00:39 -0500
Date: Fri, 2 Mar 2018 13:00:38 +0100
From: Johannes Thumshirn <jthumshirn@suse.de>
To: Jeremy Cline <jeremy@jcline.org>
Cc: "James E . J . Bottomley" <jejb@linux.vnet.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] scsi: sd: Keep disk read-only when re-reading partition
Message-ID: <20180302120038.4mgcn2lmft4ygqz4@linux-x5ow.site>
References: <01000161e1e448a5-d54e05d2-58f2-4480-b05b-67185d4ffae7-000000@email.amazonses.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <01000161e1e448a5-d54e05d2-58f2-4480-b05b-67185d4ffae7-000000@email.amazonses.com>
User-Agent: NeoMutt/20170421 (1.8.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 01, 2018 at 02:08:10PM +0000, Jeremy Cline wrote:
> If the read-only flag is true on a SCSI disk, re-reading the partition
> table sets the flag back to false.
> 
> To observe this bug, you can run:
> 
> 1. blockdev --setro /dev/sda
> 2. blockdev --rereadpt /dev/sda
> 3. blockdev --getro /dev/sda

hi Jeremy,

Do you mind wiring up a testcase in blktest [1] for this? Given that
you already have a rather trivial reproducer.

[1] https://github.com/osandov/

Thanks,
	Johannes

-- 
Johannes Thumshirn                                          Storage
jthumshirn@suse.de                                +49 911 74053 689
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 Nürnberg
GF: Felix Imendörffer, Jane Smithard, Graham Norton
HRB 21284 (AG Nürnberg)
Key fingerprint = EC38 9CAB C2C4 F25D 8600 D0D0 0393 969D 2D76 0850
