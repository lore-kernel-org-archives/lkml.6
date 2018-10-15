Return-Path: <SRS0=AKhD=M3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3879EC28CF8
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 03:51:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B6642086A
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 03:51:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=mendozajonas.com header.i=@mendozajonas.com header.b="oca8wH07";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ZXwvSzhc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B6642086A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mendozajonas.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726597AbeJOLeh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Oct 2018 07:34:37 -0400
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:44625 "EHLO
        out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726262AbeJOLeg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Oct 2018 07:34:36 -0400
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
        by mailout.nyi.internal (Postfix) with ESMTP id 4B4B821F37;
        Sun, 14 Oct 2018 23:51:14 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Sun, 14 Oct 2018 23:51:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        mendozajonas.com; h=message-id:subject:from:to:cc:date
        :in-reply-to:references:content-type:mime-version
        :content-transfer-encoding; s=fm1; bh=g5z8t9HAs2ttRojnp65adMD8iv
        VtWcHMldGBdkA39lY=; b=oca8wH076Oynds/WoIajhltDxZSE2uyfdpsmLv2e5M
        JEj39MCE3Mm7dqho9bz83if7RJl/+dM6jL6r9N10QvgX4AeRzlkWttaUBbwQGa9j
        zysh1GhzH8+4CPSz1YUYNbNyKPMyinCwm1jsr5s6JaCE60K5y4M8DfHn3RhDZsD/
        3r9kodXGtT0d/6nmc7TQFe+zFWas/wo5EexIZywkM9dCSon45paqMqeuT51V97Hp
        bC5W59HcSXyj6Cfel7nQxkhPeu60HF/mKQVHTnYlKpSY2/XSUVPg72z8wDC1vWi1
        3MWi6yEeU0ShOaUkXRyWaMF/i8m3eHiV1G61Www01ypA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; bh=g5z8t9HAs2ttRojnp65adMD8ivVtWcHMldGBdkA39
        lY=; b=ZXwvSzhcUdYvzaC+QP+XNOiGWqrdV/6p4qPDJAfV2UTYJthfha7eePonk
        j1fEo+mSygNAmja1qr7+syCiS6+z5xXcIOlc2Hisd324VDzTADLHZIYFLjS7SjBr
        Ar1fOb5Xmuhc6/cVjydWYHbkEqVQS1ZYDT753l05WPg86pRgXEmgy+PcRX291HiJ
        2oHzNuJlbngGDUal6q1zULy6pg19kKrmlzVIBMTly1wZV/KZaWC0p0Vy9zpDTMW+
        LxjJyJ/9swxLQ34g5vNV0+cw/+hywqgLbXHT5T9o2tUTS4hp8DIeHKwgwZ+xv5Aq
        aYnnl4R/5O3O3N/boSmAI03rwVQ6w==
X-ME-Sender: <xms:sQ7EW8fYHJjQTVFy7l5YlUQd2i4dSBVtKxg40zQrqSNKPNGnLCL-hQ>
X-ME-Proxy: <xmx:sQ7EWybo6WeWM6e6_14htZW2sxGpSzV97y62Iiw8GTmO2Uf6CyFIsQ>
    <xmx:sQ7EW8y8Hqr_K-bW3qDpK2Bgql265zbKOqIQFYQ04BxLNqC4Aw9bCw>
    <xmx:sQ7EW3TStSfRI257p20mwsq4CNHQpAgRTF2BpUkKymoDLqaKjdzl3A>
    <xmx:sQ7EW6oQ2_vOs13JQx604lVOTumDL2-Dml4EjPCXM7dOV6rxo2d9WQ>
    <xmx:sQ7EWxZrdLQ5y2tlw5dNxZ7gQFOg3WLwAEpj6r246ZGKdnOoAX8fOw>
    <xmx:sg7EW4CA86YcBrtwHj2zWNlKBYVCcfnXB5R8F_jvhheMCiLdmFl-Ew>
Received: from v4 (unknown [122.99.82.10])
        by mail.messagingengine.com (Postfix) with ESMTPA id 36F0F102E9;
        Sun, 14 Oct 2018 23:51:10 -0400 (EDT)
Message-ID: <9c82f52a7ce3fb9052600709a10783b23ef88457.camel@mendozajonas.com>
Subject: Re: [PATCH net-next v4] net/ncsi: Add NCSI Broadcom OEM command
From:   Samuel Mendoza-Jonas <sam@mendozajonas.com>
To:     Vijay Khemka <vijaykhemka@fb.com>,
        "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     linux-aspeed@lists.ozlabs.org, openbmc@lists.ozlabs.org
Date:   Mon, 15 Oct 2018 14:51:01 +1100
In-Reply-To: <69cae9d44cbebb2cd4f468dc710d6a97210af835.camel@mendozajonas.com>
References: <20181012182008.1665690-1-vijaykhemka@fb.com>
         <69cae9d44cbebb2cd4f468dc710d6a97210af835.camel@mendozajonas.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2018-10-15 at 13:08 +1100, Samuel Mendoza-Jonas wrote:
> On Fri, 2018-10-12 at 11:20 -0700, Vijay Khemka wrote:
> > This patch adds OEM Broadcom commands and response handling. It also
> > defines OEM Get MAC Address handler to get and configure the device.
> > 
> > ncsi_oem_gma_handler_bcm: This handler send NCSI broadcom command for
> > getting mac address.
> > ncsi_rsp_handler_oem_bcm: This handles response received for all
> > broadcom OEM commands.
> > ncsi_rsp_handler_oem_bcm_gma: This handles get mac address response and
> > set it to device.
> > 
> > Signed-off-by: Vijay Khemka <vijaykhemka@fb.com>
> > ---
> >  v4: updated as per comment from Sam, I was just wondering if I can remove
> >  NCSI_OEM_CMD_GET_MAC config option and let this code be valid always and
> >  it will configure mac address if there is get mac address handler for given 
> >  manufacture id.
> 
> Hi Vijay,
> 
> We can look at handling this a different way, but I don't think we want
> to unconditionally set the system's MAC address based on the OEM GMA
> command. If the user wants to set a custom MAC address, or in the case of
> OpenBMC for example who have their MAC address saved in flash, this will
> override that value with whatever the Network Controller has saved. In
> particular as it is set up it will override any MAC address every time a
> channel is configured, such as during a failover event.
> 
> We *could* always send the GMA command if it is available and move the
> decision whether to use the resulting address or not into the response
> handler. That would simplify the ncsi_configure_channel() logic a bit.
> Another idea may be to have a Netlink command to tell NCSI to ignore the
> GMA result; then we could drop the config option and the system can
> safely change the address if desired.
> 
> Any thoughts? I'll also ping some of the OpenBMC people and see what
> their expectations are.

After a bit of a think and an ask around, to quote a colleague:
> I think we'd want it handled (overall) like any other net device; the MAC
> address in the device's ROM provides a default, and is overridden by anything
> specified by userspace 

Which describes what I was thinking pretty well.
So if we can have it such that the NCSI driver only sets the MAC address
_once_, and then after then does not update it again, we should be able to call
the OEM GMA command without hiding it behind a config option. So the first time
a channel was configured we store and set the MAC address given, but then on
later configure events we don't continue to update it. What do you think?

Cheers,
Sam

> 
> > +#if IS_ENABLED(CONFIG_NCSI_OEM_CMD_GET_MAC)
> > +
> > +/* NCSI OEM Command APIs */
> > +static void ncsi_oem_gma_handler_bcm(struct ncsi_cmd_arg *nca)
> > +{
> > +	unsigned char data[NCSI_OEM_BCM_CMD_GMA_LEN];
> > +	int ret = 0;
> > +
> > +	nca->payload = NCSI_OEM_BCM_CMD_GMA_LEN;
> > +
> > +	memset(data, 0, NCSI_OEM_BCM_CMD_GMA_LEN);
> > +	*(unsigned int *)data = ntohl(NCSI_OEM_MFR_BCM_ID);
> > +	data[5] = NCSI_OEM_BCM_CMD_GMA;
> > +
> > +	nca->data = data;
> > +
> > +	ret = ncsi_xmit_cmd(nca);
> > +	if (ret)
> > +		netdev_err(nca->ndp->ndev.dev,
> > +			   "NCSI: Failed to transmit cmd 0x%x during configure\n",
> > +			   nca->type);
> > +}
> 
> As a side note while unlikely we probably want to propagate the return
> value of ncsi_xmit_cmd() from here; otherwise we'll miss a failure and
> the configure process will stall.
> 
> Regards,
> Sam
> 


