Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8DD3C282D0
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 09:47:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A749A2084A
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 09:47:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="RmwYZmpg";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="cMtIWR3H"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727709AbfA2Jrq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 04:47:46 -0500
Received: from new1-smtp.messagingengine.com ([66.111.4.221]:42231 "EHLO
        new1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726456AbfA2Jrp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 04:47:45 -0500
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailnew.nyi.internal (Postfix) with ESMTP id 76488A5BE;
        Tue, 29 Jan 2019 04:47:44 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Tue, 29 Jan 2019 04:47:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm2; bh=mbPMnzqs0erg8gPU2jVhjQdklBs
        T+w1HHr18/PvW4Pc=; b=RmwYZmpgyyfcSP1bXEkYQOTDCGGNIJD0//M+q3hBwfm
        Xq4KxX7rNIe6vKQda84zWNNWMmSDkqXdBLrdNgorjjhz+6K61AyWBoHUaFZEmO7L
        /JGTP3qOfzJ/ke3gNS42dJyhvBylWwmtmhMSMAEH6K7wUiLLbFxDl3pbIoiuwxR+
        4pflqT1QCQlsdczoKL+mY09eno+HCI97sEmJKXQd/EsmgP3ULOIfpEXuwHYvcSJg
        WPm9xjmVRghg+aMl/q4aLLHe3pCyxyYgM7Zt+YCCLKCJdKzWTGf3/R19JsW9+dVA
        1aTa7cOrnhgw8U16G0lDlNDL3BsVkkfw5HEtLpSvCWg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=mbPMnz
        qs0erg8gPU2jVhjQdklBsT+w1HHr18/PvW4Pc=; b=cMtIWR3HoGqY4vyh6FF0wq
        ZH+H6Vt12xjW6iR8fupHuOgCAAvxhNiDC/w+amc11QjsiVjwfAMb0q+NsVY/Xfay
        mGxULwUz6iDV7Wkm2Pvicvm9qJlz+vkuqhTFRDKZUQoydfPEceaPsyET04Z8CKTB
        aAWi/1aYLJMCwkrkemGePoSRSmgeZoS2t2wPrizD2ZBE0nrhUURiFNQqOMAXM8A4
        wWegR/DlKlDuQIdng+78A3981WvSTTMR7bE4j7l7dH72xzhcFAHrpgaKVHqTdTy5
        NMbngGyio3wSLV87iWob+lMLhIB6PDSjRkFsAjwwdVCAGMh22LMnB77b5ht425bQ
        ==
X-ME-Sender: <xms:PyFQXJCc_gjzyyLSvhEY4RxRUrjAFTPGh_QQqme7NL1VFesu3fTN3Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedtledrjedvgddtkecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfhuthenuceurghilhhouhhtmecufedt
    tdenucesvcftvggtihhpihgvnhhtshculddquddttddmnegoufhprghmkfhpucdlfedttd
    dmnecujfgurhepfffhvffukfhfgggtuggjfgesthdtredttdervdenucfhrhhomhepifhr
    vghgucfmjfcuoehgrhgvgheskhhrohgrhhdrtghomheqnecukfhppeekfedrkeeirdekle
    druddtjeenucfrrghrrghmpehmrghilhhfrhhomhepghhrvghgsehkrhhorghhrdgtohhm
    necuvehluhhsthgvrhfuihiivgeptd
X-ME-Proxy: <xmx:PyFQXO8ApHtncXfUSZiwBi8hhwRznLU6iup2D3F-GuLvW6iNEvo9BQ>
    <xmx:PyFQXB8ofVAEp1QWhse_oN89RD6vriYbd6zualjg_UOf7iZjakz98Q>
    <xmx:PyFQXNdytH5lqBZn-uek91NDpOYBn40__szD6MqjGJz63Z27OX-9lw>
    <xmx:QCFQXGI-4TgaWCcTVAVTr3j_Txfohvr6N5uJWXJ4Pb4KRJzrYFr3xw>
Received: from localhost (5356596b.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        by mail.messagingengine.com (Postfix) with ESMTPA id 62D0AE4536;
        Tue, 29 Jan 2019 04:47:43 -0500 (EST)
Date:   Tue, 29 Jan 2019 10:47:42 +0100
From:   Greg KH <greg@kroah.com>
To:     Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc:     linux-kernel@vger.kernel.org, Marc Zyngier <marc.zyngier@arm.com>,
        stable@vger.kernel.org
Subject: Re: [PATCH] irqchip/gic-v3-its: Align PCI Multi-MSI allocation on
 their size
Message-ID: <20190129094742.GA22220@kroah.com>
References: <20190128170015.12253-1-ard.biesheuvel@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190128170015.12253-1-ard.biesheuvel@linaro.org>
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 28, 2019 at 06:00:15PM +0100, Ard Biesheuvel wrote:
> From: Marc Zyngier <marc.zyngier@arm.com>
> 
> Commit 8208d1708b88b412ca97f50a6d951242c88cbbac upstream.
> 
> The way we allocate events works fine in most cases, except
> when multiple PCI devices share an ITS-visible DevID, and that
> one of them is trying to use MultiMSI allocation.
> 
> In that case, our allocation is not guaranteed to be zero-based
> anymore, and we have to make sure we allocate it on a boundary
> that is compatible with the PCI Multi-MSI constraints.
> 
> Fix this by allocating the full region upfront instead of iterating
> over the number of MSIs. MSI-X are always allocated one by one,
> so this shouldn't change anything on that front.
> 
> Fixes: b48ac83d6bbc2 ("irqchip: GICv3: ITS: MSI support")
> Cc: <stable@vger.kernel.org> # v4.4 - v4.9
> Reported-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> Tested-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
> [ardb: rebased onto v4.9.153, should apply cleanly onto v4.4.y as well]
> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> ---
>  drivers/irqchip/irq-gic-v3-its.c | 25 ++++++++++----------
>  1 file changed, 13 insertions(+), 12 deletions(-)

Now queued up, thanks.

greg k-h
