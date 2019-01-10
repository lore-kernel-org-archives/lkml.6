Return-Path: <SRS0=lBHl=PS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CEB9C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 20:08:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F2C7208E3
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 20:08:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729868AbfAJUIg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Jan 2019 15:08:36 -0500
Received: from gateway33.websitewelcome.com ([192.185.146.80]:24093 "EHLO
        gateway33.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728145AbfAJUIg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jan 2019 15:08:36 -0500
Received: from cm13.websitewelcome.com (cm13.websitewelcome.com [100.42.49.6])
        by gateway33.websitewelcome.com (Postfix) with ESMTP id 6AFFC15ECB5
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jan 2019 14:07:16 -0600 (CST)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id hgbkg74AsYTGMhgbkgs6Nu; Thu, 10 Jan 2019 14:07:16 -0600
X-Authority-Reason: nr=8
Received: from [189.250.130.205] (port=41220 helo=[192.168.43.131])
        by gator4166.hostgator.com with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.91)
        (envelope-from <gustavo@embeddedor.com>)
        id 1ghgbj-002aQ1-QG; Thu, 10 Jan 2019 14:07:16 -0600
Subject: Re: [PATCH 16/41] scsi: imm: mark expected switch fall-throughs
To:     linux-kernel@vger.kernel.org
Cc:     "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org
References: <cover.1543374820.git.gustavo@embeddedor.com>
 <42e3f9f751b662b7f0e4e763aa880bd752511c60.1543374820.git.gustavo@embeddedor.com>
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Message-ID: <bb9000e6-837f-6978-9b09-02dc592ef5f4@embeddedor.com>
Date:   Thu, 10 Jan 2019 14:07:13 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <42e3f9f751b662b7f0e4e763aa880bd752511c60.1543374820.git.gustavo@embeddedor.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 189.250.130.205
X-Source-L: No
X-Exim-ID: 1ghgbj-002aQ1-QG
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: ([192.168.43.131]) [189.250.130.205]:41220
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 31
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Friendly ping (second one):

Who can ack/review/take this patch, please?

Martin: apparently, the only maintainers for this
driver are you and James.

Thanks
--
Gustavo

On 11/27/18 10:29 PM, Gustavo A. R. Silva wrote:
> In preparation to enabling -Wimplicit-fallthrough, mark switch cases
> where we are expecting to fall through.
> 
> Notice that, in this particular case, I placed all the "Phase N - ..."
> comments on the same line as its corresponding switch case. The same
> way in which similar comments appear in drivers/scsi/ppa.c. This makes
> it possible to place the "fall through" annotations at the bottom of
> each switch case, which is what GCC is expecting to find.
> 
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
> ---
>   drivers/scsi/imm.c | 33 +++++++++++++++++----------------
>   1 file changed, 17 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/scsi/imm.c b/drivers/scsi/imm.c
> index 8c6627bc8a39..629e0bc70d3e 100644
> --- a/drivers/scsi/imm.c
> +++ b/drivers/scsi/imm.c
> @@ -796,21 +796,21 @@ static int imm_engine(imm_struct *dev, struct scsi_cmnd *cmd)
>   			return 0;
>   		}
>   		return 1;	/* wait until imm_wakeup claims parport */
> -		/* Phase 1 - Connected */
> -	case 1:
> +
> +	case 1:		/* Phase 1 - Connected */
>   		imm_connect(dev, CONNECT_EPP_MAYBE);
>   		cmd->SCp.phase++;
> +		/* fall through */
>   
> -		/* Phase 2 - We are now talking to the scsi bus */
> -	case 2:
> +	case 2:		/* Phase 2 - We are now talking to the scsi bus */
>   		if (!imm_select(dev, scmd_id(cmd))) {
>   			imm_fail(dev, DID_NO_CONNECT);
>   			return 0;
>   		}
>   		cmd->SCp.phase++;
> +		/* fall through */
>   
> -		/* Phase 3 - Ready to accept a command */
> -	case 3:
> +	case 3:		/* Phase 3 - Ready to accept a command */
>   		w_ctr(ppb, 0x0c);
>   		if (!(r_str(ppb) & 0x80))
>   			return 1;
> @@ -818,9 +818,9 @@ static int imm_engine(imm_struct *dev, struct scsi_cmnd *cmd)
>   		if (!imm_send_command(cmd))
>   			return 0;
>   		cmd->SCp.phase++;
> +		/* fall through */
>   
> -		/* Phase 4 - Setup scatter/gather buffers */
> -	case 4:
> +	case 4:		/* Phase 4 - Setup scatter/gather buffers */
>   		if (scsi_bufflen(cmd)) {
>   			cmd->SCp.buffer = scsi_sglist(cmd);
>   			cmd->SCp.this_residual = cmd->SCp.buffer->length;
> @@ -834,8 +834,9 @@ static int imm_engine(imm_struct *dev, struct scsi_cmnd *cmd)
>   		cmd->SCp.phase++;
>   		if (cmd->SCp.this_residual & 0x01)
>   			cmd->SCp.this_residual++;
> -		/* Phase 5 - Pre-Data transfer stage */
> -	case 5:
> +		/* fall through */
> +
> +	case 5:		/* Phase 5 - Pre-Data transfer stage */
>   		/* Spin lock for BUSY */
>   		w_ctr(ppb, 0x0c);
>   		if (!(r_str(ppb) & 0x80))
> @@ -850,9 +851,9 @@ static int imm_engine(imm_struct *dev, struct scsi_cmnd *cmd)
>   			if (imm_negotiate(dev))
>   				return 0;
>   		cmd->SCp.phase++;
> +		/* fall through */
>   
> -		/* Phase 6 - Data transfer stage */
> -	case 6:
> +	case 6:		/* Phase 6 - Data transfer stage */
>   		/* Spin lock for BUSY */
>   		w_ctr(ppb, 0x0c);
>   		if (!(r_str(ppb) & 0x80))
> @@ -866,9 +867,9 @@ static int imm_engine(imm_struct *dev, struct scsi_cmnd *cmd)
>   				return 1;
>   		}
>   		cmd->SCp.phase++;
> +		/* fall through */
>   
> -		/* Phase 7 - Post data transfer stage */
> -	case 7:
> +	case 7:		/* Phase 7 - Post data transfer stage */
>   		if ((dev->dp) && (dev->rd)) {
>   			if ((dev->mode == IMM_NIBBLE) || (dev->mode == IMM_PS2)) {
>   				w_ctr(ppb, 0x4);
> @@ -878,9 +879,9 @@ static int imm_engine(imm_struct *dev, struct scsi_cmnd *cmd)
>   			}
>   		}
>   		cmd->SCp.phase++;
> +		/* fall through */
>   
> -		/* Phase 8 - Read status/message */
> -	case 8:
> +	case 8:		/* Phase 8 - Read status/message */
>   		/* Check for data overrun */
>   		if (imm_wait(dev) != (unsigned char) 0xb8) {
>   			imm_fail(dev, DID_ERROR);
> 
