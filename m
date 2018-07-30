Return-Path: <SRS0=qqIy=KO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5485213F6DFF
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 09:11:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 098C420870
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 09:11:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 098C420870
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726723AbeG3Kpn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Jul 2018 06:45:43 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:46656 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726568AbeG3Kpn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jul 2018 06:45:43 -0400
Received: from localhost (D57D388D.static.ziggozakelijk.nl [213.125.56.141])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id E648DCB1;
        Mon, 30 Jul 2018 09:11:40 +0000 (UTC)
Date:   Mon, 30 Jul 2018 11:11:38 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     John Whitmore <johnfwhitmore@gmail.com>
Cc:     linux-kernel@vger.kernel.org, devel@driverdev.osuosl.org
Subject: Re: [PATCH v2 01/15] staging:rtl8192u: Remove typedef of struct
 cmpk_txfb_t - Style
Message-ID: <20180730091138.GA22781@kroah.com>
References: <20180729210747.10803-1-johnfwhitmore@gmail.com>
 <20180729210747.10803-2-johnfwhitmore@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180729210747.10803-2-johnfwhitmore@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 29, 2018 at 10:07:33PM +0100, John Whitmore wrote:
> Remove the typedef of the structure cmpk_txfb_t. This clears the
> checkpatch issue with defining new types.
> 
> Additionally the type is renamed from cmpk_txfb_t to cmd_pkt_tx_feedback
> removing the '_t' as the typedef has been removed.
> 
> These changes are purely coding style in nature and should have no
> impact on runtime code execution.
> 
> Signed-off-by: John Whitmore <johnfwhitmore@gmail.com>
> ---
>  drivers/staging/rtl8192u/r819xU_cmdpkt.c | 8 ++++----
>  drivers/staging/rtl8192u/r819xU_cmdpkt.h | 6 +++---
>  2 files changed, 7 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/staging/rtl8192u/r819xU_cmdpkt.c b/drivers/staging/rtl8192u/r819xU_cmdpkt.c
> index 3140b3413f91..630cf612f265 100644
> --- a/drivers/staging/rtl8192u/r819xU_cmdpkt.c
> +++ b/drivers/staging/rtl8192u/r819xU_cmdpkt.c
> @@ -66,7 +66,7 @@ rt_status SendTxCommandPacket(struct net_device *dev, void *pData, u32 DataLen)
>   * Overview:
>   *
>   * Input:       PADAPTER	pAdapter
> - *              CMPK_TXFB_T	*psTx_FB
> + *              STRUCT CMD_PKT_TX_FEEDBACK	*psTx_FB

nit, this should all be in lowercase now right?

Anyway, these function comments need to all go anyway, they are horrid :)

Something for future patches, look at the ones for the gasket driver
sent yesterday as an example of what to do.

thanks,

greg k-h
