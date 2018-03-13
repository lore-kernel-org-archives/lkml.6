Return-Path: <kernel-hardening-return-12519-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AG47ELttOwpV2NDcN7GktVPQ3Pfri5PUUYrtyouC9Lz8+ke5Wlp26NTIJX6HKWkRIZ6h07UsX83r
ARC-Seal: i=1; a=rsa-sha256; t=1520971829; cv=none;
        d=google.com; s=arc-20160816;
        b=SJXMAiDqVkX1uXIl3uTgER+1I6GB4/Bcc09yyO5+gkpm0bngJ3N6jFfnoNVKJHjGu6
         ccq54XIvGMWX4ouR8wJaoJoBDlW2XxHLM5eWVCkwDGA+BbFzQpMSf9ib9ulo6TlM4dlG
         4Lvapi7jcp9xOjzuHH003EnixHTk8B9Cjx9L70C3XM9MmB2mFESzEqmH7gicsKh/5RjZ
         +drjs/fyZJcTybcRrkkHBktGxxKpV+Om/4JpzSvpQAJWJ2u+gD1ZwisT/Jwi81P4UYE0
         CfQSToBr3t7RbfhazIwEtBX4t8j/0XODVrh3lGO0A78NuaBCiH1oAqJ92bUIbjeIkwzC
         TBTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:dkim-signature:dkim-signature
         :delivered-to:list-id:list-subscribe:list-unsubscribe:list-help
         :list-post:precedence:mailing-list:arc-authentication-results;
        bh=4Wqy2Rj/Oi4upB4w2xftEHund8LI9VadWvV3nMSvESk=;
        b=qfDgieGkop6JdTnV7Ge7BjQIeiBY3m+oP6pFd+MK/4p1cwRJegtBIOyoRcNP8k66CV
         tHS91XbtkaKyoQtq51Jnaq81DRGR5VZLgUGIAm0zXlWXF903ZOUsGextsalHzvH49YQJ
         OBZEJs9HJpEoEixURb3lHAxm+dnbkxk/Y4SZSjXYHu1SkYqiM55oIndHpBIfAbEiRicG
         KOYXGH7olm6AXK9btW4WLntnWNwxHYM9drlXsGxghUw5iGGO+AWNu7e4epFVN3/Wpw4K
         i5lNROlwdARPRBO+nSATN9nAx0JWZyA4U0wfeQ/W5isdU6u6s8GvFFQIZegFDLeAS7Sr
         mbQw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@tobin.cc header.s=fm2 header.b=j8LH5l68;
       dkim=pass header.i=@messagingengine.com header.s=fm2 header.b=AjlPeZkC;
       spf=pass (google.com: domain of kernel-hardening-return-12519-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12519-gregkh=linuxfoundation.org@lists.openwall.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@tobin.cc header.s=fm2 header.b=j8LH5l68;
       dkim=pass header.i=@messagingengine.com header.s=fm2 header.b=AjlPeZkC;
       spf=pass (google.com: domain of kernel-hardening-return-12519-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12519-gregkh=linuxfoundation.org@lists.openwall.com
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
X-ME-Sender: <xms:GTCoWm3T_CyW7wNG0gBpILCm0ngCtu0t9QYTSbQxkDQUzL4TRb0Hyg>
Date: Wed, 14 Mar 2018 07:09:57 +1100
From: "Tobin C. Harding" <me@tobin.cc>
To: Larry Finger <Larry.Finger@lwfinger.net>
Cc: Kalle Valo <kvalo@codeaurora.org>, kernel-hardening@lists.openwall.com,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	linux-wireless@vger.kernel.org, Tycho Andersen <tycho@tycho.ws>,
	Kees Cook <keescook@chromium.org>
Subject: Re: [RESEND PATCH] rsi: Remove stack VLA usage
Message-ID: <20180313200957.GJ8631@eros>
References: <1520819022-15238-1-git-send-email-me@tobin.cc>
 <ff9309bf-4c3d-b0f9-cdd0-429dacd3177b@lwfinger.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ff9309bf-4c3d-b0f9-cdd0-429dacd3177b@lwfinger.net>
X-Mailer: Mutt 1.5.24 (2015-08-30)
User-Agent: Mutt/1.5.24 (2015-08-30)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594441103492436943?=
X-GMAIL-MSGID: =?utf-8?q?1594854557214026636?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Sun, Mar 11, 2018 at 09:06:10PM -0500, Larry Finger wrote:
> On 03/11/2018 08:43 PM, Tobin C. Harding wrote:
> >The kernel would like to have all stack VLA usage removed[1].  rsi uses
> >a VLA based on 'blksize'.  Elsewhere in the SDIO code maximum block size
> >is defined using a magic number.  We can use a pre-processor defined
> >constant and declare the array to maximum size.  We add a check before
> >accessing the array in case of programmer error.
> >
> >[1]: https://lkml.org/lkml/2018/3/7/621
> >
> >Signed-off-by: Tobin C. Harding <me@tobin.cc>
> >---
> >
> >RESEND: add wireless mailing list to CC's (requested by Kalle)
> >
> >  drivers/net/wireless/rsi/rsi_91x_hal.c  | 13 +++++++------
> >  drivers/net/wireless/rsi/rsi_91x_sdio.c |  9 +++++++--
> >  2 files changed, 14 insertions(+), 8 deletions(-)
> >
> >diff --git a/drivers/net/wireless/rsi/rsi_91x_hal.c b/drivers/net/wireless/rsi/rsi_91x_hal.c
> >index 1176de646942..839ebdd602df 100644
> >--- a/drivers/net/wireless/rsi/rsi_91x_hal.c
> >+++ b/drivers/net/wireless/rsi/rsi_91x_hal.c
> >@@ -641,7 +641,7 @@ static int ping_pong_write(struct rsi_hw *adapter, u8 cmd, u8 *addr, u32 size)
> >  	u32 cmd_addr;
> >  	u16 cmd_resp, cmd_req;
> >  	u8 *str;
> >-	int status;
> >+	int status, ret;
> >  	if (cmd == PING_WRITE) {
> >  		cmd_addr = PING_BUFFER_ADDRESS;
> >@@ -655,12 +655,13 @@ static int ping_pong_write(struct rsi_hw *adapter, u8 cmd, u8 *addr, u32 size)
> >  		str = "PONG_VALID";
> >  	}
> >-	status = hif_ops->load_data_master_write(adapter, cmd_addr, size,
> >+	ret = hif_ops->load_data_master_write(adapter, cmd_addr, size,
> >  					    block_size, addr);
> >-	if (status) {
> >-		rsi_dbg(ERR_ZONE, "%s: Unable to write blk at addr %0x\n",
> >-			__func__, *addr);
> >-		return status;
> >+	if (ret) {
> >+		if (ret != -EINVAL)
> >+			rsi_dbg(ERR_ZONE, "%s: Unable to write blk at addr %0x\n",
> >+				__func__, *addr);
> >+		return ret;
> >  	}
> >  	status = bl_cmd(adapter, cmd_req, cmd_resp, str);
> >diff --git a/drivers/net/wireless/rsi/rsi_91x_sdio.c b/drivers/net/wireless/rsi/rsi_91x_sdio.c
> >index b0cf41195051..b766578b591a 100644
> >--- a/drivers/net/wireless/rsi/rsi_91x_sdio.c
> >+++ b/drivers/net/wireless/rsi/rsi_91x_sdio.c
> >@@ -20,6 +20,8 @@
> >  #include "rsi_common.h"
> >  #include "rsi_hal.h"
> >+#define RSI_MAX_BLOCK_SIZE 256
> >+
> >  /**
> >   * rsi_sdio_set_cmd52_arg() - This function prepares cmd 52 read/write arg.
> >   * @rw: Read/write
> >@@ -362,7 +364,7 @@ static int rsi_setblocklength(struct rsi_hw *adapter, u32 length)
> >  	rsi_dbg(INIT_ZONE, "%s: Setting the block length\n", __func__);
> >  	status = sdio_set_block_size(dev->pfunction, length);
> >-	dev->pfunction->max_blksize = 256;
> >+	dev->pfunction->max_blksize = RSI_MAX_BLOCK_SIZE;
> >  	adapter->block_size = dev->pfunction->max_blksize;
> >  	rsi_dbg(INFO_ZONE,
> >@@ -567,9 +569,12 @@ static int rsi_sdio_load_data_master_write(struct rsi_hw *adapter,
> >  {
> >  	u32 num_blocks, offset, i;
> >  	u16 msb_address, lsb_address;
> >-	u8 temp_buf[block_size];
> >+	u8 temp_buf[RSI_MAX_BLOCK_SIZE];
> >  	int status;
> >+	if (block_size > RSI_MAX_BLOCK_SIZE)
> >+		return -EINVAL;
> >+
> >  	num_blocks = instructions_sz / block_size;
> >  	msb_address = base_address >> 16;
> 
> I am not giving this patch a negative review, but my solution to the same
> problem has been to change the on-stack array into a u8 pointer, use
> kmalloc() to assign the space, and then free that space at the end. That way
> large stack allocations are avoided, with a minimum of changes.

Your idea is better Larry, have you got a patch done already or do you
want me to knock one up?

thanks,
Tobin.
