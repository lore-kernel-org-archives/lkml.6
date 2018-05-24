Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S970340AbeEXOIK (ORCPT <rfc822;w@1wt.eu>);
        Thu, 24 May 2018 10:08:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:38518 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S966751AbeEXOII (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 May 2018 10:08:08 -0400
Date: Thu, 24 May 2018 16:07:50 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Steffen Maier <maier@linux.ibm.com>
Cc: linux-kernel@vger.kernel.org, Bart Van Assche <bart.vanassche@wdc.com>,
        stable@vger.kernel.org, Doug Gilbert <dgilbert@interlog.com>,
        Hannes Reinecke <hare@suse.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: Re: [PATCH 4.14 110/165] scsi: core: return BLK_STS_OK for DID_OK in
 __scsi_error_from_host_byte()
Message-ID: <20180524140750.GA19550@kroah.com>
References: <20180524093621.979359379@linuxfoundation.org>
 <20180524093626.469402002@linuxfoundation.org>
 <fdd36949-3a0c-0b7d-1946-34fd253569c5@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fdd36949-3a0c-0b7d-1946-34fd253569c5@linux.ibm.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 24, 2018 at 02:19:29PM +0200, Steffen Maier wrote:
> Hopefully I haven't missed it in the stable queue, but do we need the
> following on top (effectively not applying e39a97353e53)?:
> 
> commit cbe095e2b584623b882ebaf6c18e0b9077baa3f7
> Author: Bart Van Assche <bart.vanassche@wdc.com>
> Date:   Thu Apr 5 10:32:59 2018 -0700
> 
>     Revert "scsi: core: return BLK_STS_OK for DID_OK in
> __scsi_error_from_host_byte()"
> 
>     The description of commit e39a97353e53 is wrong: it mentions that commit
>     2a842acab109 introduced a bug in __scsi_error_from_host_byte() although
> that
>     commit did not change the behavior of that function.  Additionally,
> commit
>     e39a97353e53 introduced a bug: it causes commands that fail with
>     hostbyte=DID_OK and driverbyte=DRIVER_SENSE to be completed with
>     BLK_STS_OK. Hence revert that commit.
> 
>     Fixes: e39a97353e53 ("scsi: core: return BLK_STS_OK for DID_OK in
> __scsi_error_from_host_byte()")
>     Reported-by: Damien Le Moal <damien.lemoal@wdc.com>
>     Signed-off-by: Bart Van Assche <bart.vanassche@wdc.com>
>     Cc: Hannes Reinecke <hare@suse.com>
>     Cc: Douglas Gilbert <dgilbert@interlog.com>
>     Cc: Damien Le Moal <damien.lemoal@wdc.com>
>     Cc: Christoph Hellwig <hch@lst.de>
>     Cc: Lee Duncan <lduncan@suse.com>
>     Cc: stable@vger.kernel.org
>     Reviewed-by: Christoph Hellwig <hch@lst.de>
>     Reviewed-by: Hannes Reinecke <hare@suse.com>
>     Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>

Oops, yeah, I'll go drop this one from the queue, we shouldn't take it
at all, as that's easier than applying it and then reverting it again.

Thanks for letting me know.

greg k-h
