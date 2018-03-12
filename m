Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751764AbeCLGZN (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Mar 2018 02:25:13 -0400
Received: from mx2.suse.de ([195.135.220.15]:60103 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750752AbeCLGZM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Mar 2018 02:25:12 -0400
Subject: Re: [PATCH] device_handler: remove VLAs
To: Stephen Kitt <steve@sk2.org>, hare@suse.com, axboe@kernel.dk,
        jejb@linux.vnet.ibm.com, martin.petersen@oracle.com
Cc: linux-scsi@vger.kernel.org, kernel-hardening@lists.openwall.com,
        linux-kernel@vger.kernel.org, linux-block@vger.kernel.org
References: <20180309232933.14e39858@heffalump.sk2.org>
 <20180309223211.20473-1-steve@sk2.org>
From: Hannes Reinecke <hare@suse.de>
Organization: SUSE Linux GmbH
Message-ID: <7cd80595-ca17-0474-5870-6d7c0429db7a@suse.de>
Date: Mon, 12 Mar 2018 07:25:08 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180309223211.20473-1-steve@sk2.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/09/2018 11:32 PM, Stephen Kitt wrote:
> In preparation to enabling -Wvla, remove VLAs and replace them with
> fixed-length arrays instead.
> 
> scsi_dh_{alua,emc,rdac} use variable-length array declarations to
> store command blocks, with the appropriate size as determined by
> COMMAND_SIZE. This patch replaces these with fixed-sized arrays using
> MAX_COMMAND_SIZE, so that the array size can be determined at compile
> time.
> 
> This was prompted by https://lkml.org/lkml/2018/3/7/621
> 
> Signed-off-by: Stephen Kitt <steve@sk2.org>
> ---
>  drivers/scsi/device_handler/scsi_dh_alua.c | 8 ++++----
>  drivers/scsi/device_handler/scsi_dh_emc.c  | 2 +-
>  drivers/scsi/device_handler/scsi_dh_rdac.c | 2 +-
>  3 files changed, 6 insertions(+), 6 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare@suse.com>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		   Teamlead Storage & Networking
hare@suse.de			               +49 911 74053 688
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 Nürnberg
GF: F. Imendörffer, J. Smithard, J. Guild, D. Upmanyu, G. Norton
HRB 21284 (AG Nürnberg)
