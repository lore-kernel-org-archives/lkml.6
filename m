Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F232AC04EBD
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 05:46:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9199C208B3
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 05:46:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=mendozajonas.com header.i=@mendozajonas.com header.b="t8Mnrfdv";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Q3nO8t97"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9199C208B3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mendozajonas.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728051AbeJPNez (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 09:34:55 -0400
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:46593 "EHLO
        out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727438AbeJPNez (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 09:34:55 -0400
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
        by mailout.nyi.internal (Postfix) with ESMTP id 72E7722239;
        Tue, 16 Oct 2018 01:46:08 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Tue, 16 Oct 2018 01:46:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        mendozajonas.com; h=message-id:subject:from:to:cc:date
        :in-reply-to:references:content-type:mime-version
        :content-transfer-encoding; s=fm1; bh=p7lDReh9Po24QTriDU3HF5iWU7
        vr2lFBTf6PhLTOehI=; b=t8Mnrfdv6GyjJq5y9er7qDWvx60NaXyDKn//yW+JHH
        EzVGrnkkO3/skLfQLMCrYc1q0e7oSs8/FL9pyTiau6hZ9DU8lIdPnYWm8NMz0k4m
        jKNoDA5JPyBwgqcsZ6UCPO2X3ph4MZwaCEm1lzOGAr+fEydl1STD9SCL2BwOWMSZ
        QeX6+yp76SfkbSq+6rWES6Q50wKAeG9AokdPl7e+pObASmzv9RLjfODb41OAAyPL
        soT+1vUALaBMXNdCrTdUu+U7pzllrGXjMWakuoCZpQ5/W1aeX1poa9JhlW+a6d3E
        d/ReGJ2UcBmUGMvYigUA9xpMw9q4PKBIBD6Qv91elOww==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; bh=p7lDReh9Po24QTriDU3HF5iWU7vr2lFBTf6PhLTOe
        hI=; b=Q3nO8t97MgEAXb2Y4OlNP6b1eVsvMRXzFl77nNz04Rog0bePRiA+SZlFj
        +cSczfmfYztiJxQp9YjtbAknm0v+wPjEqbkW+32zalY8LOStU53ZsZck59G+tj1n
        VAVO+6lcBula7rSzrID8sylE2DoE5BVHivXbhZhyEM1H/sfD24q9Yh7vRCH+U4hN
        5deRHOAT7Rszyd5BhnmLhraSjzQsjmuZW46ojTg9XdHqw02s0L1Qynfpwa1GrNBO
        jA5RnCJX8VFrtkrnru5LgInaktbUdJH0CtQYFWqLS/DjbnpbNjdkwmnytEJuO1fh
        2K4A5TLhGd3tFVheD+7s8+bREu+KA==
X-ME-Sender: <xms:H3vFW0hNMzh7D_CZO3FkSPSlD8N4jxjQChLjKqtM2NIx5b-zkmZL7w>
X-ME-Proxy: <xmx:H3vFW62P8k8DRzLbgjA6aJ5V21fchm4oN0if4SGiH-B8DBKR6SNNZQ>
    <xmx:H3vFW9SQIaXJfs8YIgUO5XP82Aqgv9WAVajVgaMFhk3ljDc2YQ7g8g>
    <xmx:H3vFW0trs_qqeNemQYgNQP6pbQx_xweNwva1RMoa34UpVF6iBVhrLw>
    <xmx:H3vFW6aOtM3WQJ_h81OC7Q44y4rFl8r383KCo7Z3D1jYnNrbCxZavg>
    <xmx:H3vFWxvMqeAN_953Rm99i02AIOvb21G1a_LgYWrOSUcMPcIrIE1l7w>
    <xmx:IHvFWwMfBF6LbVnoZr3h-VVDirjjO1lNz2EjjScpxbE3_UAgaByxdA>
Received: from v4 (unknown [122.99.82.10])
        by mail.messagingengine.com (Postfix) with ESMTPA id 71B16E4439;
        Tue, 16 Oct 2018 01:46:05 -0400 (EDT)
Message-ID: <337567b2936725686459bdba7ef76dc46dea748a.camel@mendozajonas.com>
Subject: Re: [Potential Spoof] Re: [PATCH net-next v4] net/ncsi: Add NCSI
 Broadcom OEM command
From:   Samuel Mendoza-Jonas <sam@mendozajonas.com>
To:     Vijay Khemka <vijaykhemka@fb.com>,
        "David S. Miller" <davem@davemloft.net>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc:     "openbmc@lists.ozlabs.org" <openbmc@lists.ozlabs.org>,
        "linux-aspeed@lists.ozlabs.org" <linux-aspeed@lists.ozlabs.org>
Date:   Tue, 16 Oct 2018 16:46:01 +1100
In-Reply-To: <E82A7C2E-6DBF-437D-B571-5376F0122176@fb.com>
References: <E82A7C2E-6DBF-437D-B571-5376F0122176@fb.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.1 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2018-10-15 at 17:38 +0000, Vijay Khemka wrote:
> 
> ﻿On 10/15/18, 10:27 AM, "Linux-aspeed on behalf of Vijay Khemka" <linux-aspeed-bounces+vijaykhemka=fb.com@lists.ozlabs.org on behalf of vijaykhemka@fb.com> wrote:
> 
>     
>     
>     On 10/14/18, 8:51 PM, "Samuel Mendoza-Jonas" <sam@mendozajonas.com> wrote:
>     
>         On Mon, 2018-10-15 at 13:08 +1100, Samuel Mendoza-Jonas wrote:
>         > On Fri, 2018-10-12 at 11:20 -0700, Vijay Khemka wrote:
>         > > This patch adds OEM Broadcom commands and response handling. It also
>         > > defines OEM Get MAC Address handler to get and configure the device.
>         > > 
>         > > ncsi_oem_gma_handler_bcm: This handler send NCSI broadcom command for
>         > > getting mac address.
>         > > ncsi_rsp_handler_oem_bcm: This handles response received for all
>         > > broadcom OEM commands.
>         > > ncsi_rsp_handler_oem_bcm_gma: This handles get mac address response and
>         > > set it to device.
>         > > 
>         > > Signed-off-by: Vijay Khemka <vijaykhemka@fb.com>
>         > > ---
>         > >  v4: updated as per comment from Sam, I was just wondering if I can remove
>         > >  NCSI_OEM_CMD_GET_MAC config option and let this code be valid always and
>         > >  it will configure mac address if there is get mac address handler for given 
>         > >  manufacture id.
>         > 
>         > Hi Vijay,
>         > 
>         > We can look at handling this a different way, but I don't think we want
>         > to unconditionally set the system's MAC address based on the OEM GMA
>         > command. If the user wants to set a custom MAC address, or in the case of
>         > OpenBMC for example who have their MAC address saved in flash, this will
>         > override that value with whatever the Network Controller has saved. In
>         > particular as it is set up it will override any MAC address every time a
>         > channel is configured, such as during a failover event.
>         > 
>         > We *could* always send the GMA command if it is available and move the
>         > decision whether to use the resulting address or not into the response
>         > handler. That would simplify the ncsi_configure_channel() logic a bit.
>         > Another idea may be to have a Netlink command to tell NCSI to ignore the
>         > GMA result; then we could drop the config option and the system can
>         > safely change the address if desired.
>         > 
>         > Any thoughts? I'll also ping some of the OpenBMC people and see what
>         > their expectations are.
>         
>         After a bit of a think and an ask around, to quote a colleague:
>         > I think we'd want it handled (overall) like any other net device; the MAC
>         > address in the device's ROM provides a default, and is overridden by anything
>         > specified by userspace 
>         
>         Which describes what I was thinking pretty well.
>         So if we can have it such that the NCSI driver only sets the MAC address
>         _once_, and then after then does not update it again, we should be able to call
>         the OEM GMA command without hiding it behind a config option. So the first time
>         a channel was configured we store and set the MAC address given, but then on
>         later configure events we don't continue to update it. What do you think?
>         
>         Cheers,
>         Sam
>     
>       I agree with you setting it only once. I gave a thought about config option and realize that 
>       we should allow user to configure it. If user wants to set mac address through device tree 
>       and not through ROM then we must not override mac set by device tree. So my proposal is 
>       setting of mac address in response should be hidden under config option. Getting mac address 
>       can still go without config option. Your thought?
>         
>   or simply guard following block under config and no other function declaration guard required. 
>   And set static variable flag in function " ncsi_oem_handler" for calling this only once.
> 
>   #if IS_ENABLED(CONFIG_NCSI_OEM_CMD_GET_MAC)
>     nca.type = NCSI_PKT_CMD_OEM;
>     nca.package = np->id;
>     nca.channel = nc->id;
>     ndp->pending_req_num = 1;
>     ret = ncsi_oem_handler(&nca, nc->version.mf_id);
> #endif /* CONFIG_NCSI_OEM_CMD_GET_MAC */
> 

Hi Vijay,

Either way is likely fine; although you might need to take care you don't
get an unused function warning depending on how you guard
ncsi_oem_handler(). Also a flag in the ncsi_dev_priv struct could be
easier to keep track of than having a static variable in the handler
function.

Sam

