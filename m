Return-Path: <SRS0=PZ5q=MW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAAD4C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 04:39:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 56CAF2086D
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 04:39:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=mendozajonas.com header.i=@mendozajonas.com header.b="cM9Ekouq";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="jVwMfF/z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 56CAF2086D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mendozajonas.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727388AbeJJMAK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Oct 2018 08:00:10 -0400
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:53463 "EHLO
        out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725955AbeJJMAJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Oct 2018 08:00:09 -0400
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
        by mailout.nyi.internal (Postfix) with ESMTP id 23F3D21AE0;
        Wed, 10 Oct 2018 00:39:52 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Wed, 10 Oct 2018 00:39:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        mendozajonas.com; h=message-id:subject:from:to:cc:date
        :in-reply-to:references:content-type:mime-version
        :content-transfer-encoding; s=fm1; bh=1W9VwvsWX/2yPw5ceYLZYxqAbW
        Ly6negRyUKAemFUhw=; b=cM9Ekouq8al+NMeduURO+bKHjVyyO3Aej43g6i6+vr
        +9jXdZIqM4cg224ouc4Is+GgHTe6EsPWdd9tAQYjCY/fkj9yitPGcXxsuuRGPQKa
        krstN4GBp0+e3t0w3LxPH5m9UpquLjGPyT3wlOuh4HRchb+X+gPw7lCbxAPzvjgD
        GWpUaepbFBaK7l86xHcTPgTQYcxwfL0cnlLobD5Je/KlmBspMS2l08TVhZzsfz5a
        BNHHEoiz1WiKXShEjt/o6h85pi+JCXejsHSkqKZyTPbMuT+D7kGqXYvGE7vaGfxK
        cKD5Q4mK/o82XMHRvQkKfC4/gMLzlvmmKVe04IpnEDwA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; bh=1W9VwvsWX/2yPw5ceYLZYxqAbWLy6negRyUKAemFU
        hw=; b=jVwMfF/zAw2JfGWEXVuGgqnm7u+zpmrn7zrauSJNybMDkbBDjWz/hMtUg
        J5Y+bGvkexUegyiBkPkKx/bJObGKdUR5T0lCTC/cLuugQKRnoAwVrSSCTu1Jm/WN
        AHhtI7Bcp7WJLh8SYMRaPortxj+ssdmEVdXOAtCwKrFdRmbm6n8TOc70ma6SDUli
        SW4aICkyphxoh1/GqCWWREbHidG4/Kke5LrSpYxnWsHzvhmYgAY+1cWlKh8TJxbG
        olptPFCZVQOL923by0HWo6jjvInnM3Gan6rgM+F5ujEFpSi4YyrpertyHLHcLzJl
        Nx0LXYA5xJ/2W8yYbG49lPo6ojp/g==
X-ME-Sender: <xms:loK9W-lotDNP6aVGoQCpQ28yt9C3WCjttLBDM1LV3jUXhuz0kZvWHw>
X-ME-Proxy: <xmx:loK9W14kcoP1hPDITMQqVv6qBhLBvslzKKmy7oIOvNfuagoLIPILIQ>
    <xmx:loK9WzHmNsM0QLIIVwfK1yi_UujMA5aM4ETJauplUjgi1av_TSYjKA>
    <xmx:loK9W-RRNkxoLJcMDTVVVF7Q4W3CAqfOYc7Sp2w0pxW4jjauEtHN0Q>
    <xmx:loK9W8szqmApNfUz4-0ESwnzuKJGXEF9d5FfTZeDFtzJeDj2Tc-7hw>
    <xmx:loK9W9xavHm5mK8KazIGRfVQz6ITNtidt1OFOw1_qE7c2Fh_fwTWOw>
    <xmx:mIK9WzAubZSO9GI1FIaxuLMsS3M_sbUBiVvXY9TnSV2c-Ocex8nDcQ>
Received: from v4 (unknown [122.99.82.10])
        by mail.messagingengine.com (Postfix) with ESMTPA id BCB2FE4124;
        Wed, 10 Oct 2018 00:39:47 -0400 (EDT)
Message-ID: <7893ec3aa673b6009d00df1646b2820be2fc33a6.camel@mendozajonas.com>
Subject: Re: [PATCH v2 1/2] net/ncsi: Add NCSI Broadcom OEM command
From:   Samuel Mendoza-Jonas <sam@mendozajonas.com>
To:     Vijay Khemka <vijaykhemka@fb.com>,
        "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     "openbmc @ lists . ozlabs . org" <openbmc@lists.ozlabs.org>,
        Justin.Lee1@Dell.com, joel@jms.id.au, linux-aspeed@lists.ozlabs.org
Date:   Wed, 10 Oct 2018 15:39:44 +1100
In-Reply-To: <20181009174806.404791-1-vijaykhemka@fb.com>
References: <20181009174806.404791-1-vijaykhemka@fb.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2018-10-09 at 10:48 -0700, Vijay Khemka wrote:
> This patch adds OEM Broadcom commands and response handling. It also
> defines OEM Get MAC Address handler to get and configure the device.
> 
> ncsi_oem_gma_handler_bcm: This handler send NCSI broadcom command for
> getting mac address.
> ncsi_rsp_handler_oem_bcm: This handles response received for all
> broadcom OEM commands.
> ncsi_rsp_handler_oem_bcm_gma: This handles get mac address response and
> set it to device.
> 
> Signed-off-by: Vijay Khemka <vijaykhemka@fb.com>
> ---
>  net/ncsi/Kconfig       |  6 ++++
>  net/ncsi/internal.h    |  8 +++++
>  net/ncsi/ncsi-manage.c | 70 +++++++++++++++++++++++++++++++++++++++++-
>  net/ncsi/ncsi-pkt.h    |  8 +++++
>  net/ncsi/ncsi-rsp.c    | 40 +++++++++++++++++++++++-
>  5 files changed, 130 insertions(+), 2 deletions(-)
> 

<snip>

>  static void ncsi_configure_channel(struct ncsi_dev_priv *ndp)
>  {
>  	struct ncsi_dev *nd = &ndp->ndev;
> @@ -643,9 +676,10 @@ static void ncsi_configure_channel(struct ncsi_dev_priv *ndp)
>  	struct ncsi_channel *nc = ndp->active_channel;
>  	struct ncsi_channel *hot_nc = NULL;
>  	struct ncsi_cmd_arg nca;
> +	struct ncsi_oem_gma_handler *nch = NULL;
>  	unsigned char index;
>  	unsigned long flags;
> -	int ret;
> +	int ret, i;
>  

I just noticed that if CONFIG_NCSI_OEM_CMD_GET_MAC is not set then this
generates unused variable warnings for i and nch. Otherwise all looking good!

Regards,
Sam


