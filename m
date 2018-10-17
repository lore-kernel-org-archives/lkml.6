Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70482C5ACC6
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 02:52:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 222FF214C4
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 02:52:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=mendozajonas.com header.i=@mendozajonas.com header.b="q0tYtFrG";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="d4Qn7xqT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 222FF214C4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mendozajonas.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727363AbeJQKob (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 06:44:31 -0400
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:38291 "EHLO
        out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726988AbeJQKob (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 06:44:31 -0400
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
        by mailout.nyi.internal (Postfix) with ESMTP id 81B76220C1;
        Tue, 16 Oct 2018 22:51:04 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Tue, 16 Oct 2018 22:51:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        mendozajonas.com; h=message-id:subject:from:to:cc:date
        :in-reply-to:references:content-type:mime-version
        :content-transfer-encoding; s=fm1; bh=9RDa/sfA57LjVRNoAAfNFfkqop
        cgjNBz6JwAD15+fyA=; b=q0tYtFrGWq798USTuL+11JftcpK8/Wnoej0xZToqgK
        X7FhAyqB09fzaIuK0f2mGgMu/V4q3x9QAsPpjsJXbHm2gGPXqmKuBBdyK7m1Ss0p
        8WAm3JP4C0fISHEv2C5wZ5QjCf1rC2N9mLIetxG/54FoW+6IQBmKfB6cLDmSULJO
        6jv1PJBgK5AAgby2TMweq/PtNFgs7Ki8Uv+SgtQGos427c9j5xkeLgQafouZcO6v
        yIv1+29XNGv/sULO5/8EbtXYNhjsFbgPsgHndNuQHSFEeqrJwZy1CLlApf21l1KU
        kQoGgzzWxhNcXmJjBYkdtmPObEM8AuFUCGrJ45cNk7Eg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; bh=9RDa/sfA57LjVRNoAAfNFfkqopcgjNBz6JwAD15+f
        yA=; b=d4Qn7xqTJvnzWsNkZ6x3i/f/unOwk6oRG0mkbI7EAG5UmwgQGBr/h45T8
        qnKzXQCpQaL+CkIx07hEOfB3gDbqE9Jxq2wJCsJBsgdoroBrxdN5VCDufGeJUiKr
        6oANWUCbIZi+yzWKcABEF+Mt6ESyrhIckSMh3nAdFNalvlK3lWJkX3ayF+1mWt1d
        xQVg+YVSf3Y4bXSCNsfXpjyysfJCDDNxaJZbJPh9tpuMfrNPQ7XTiNiBln/Qc05a
        v6tsa8tP1C4rs8iC6g+2fp6HOHmJkS+Dtv7HLsVylnwVVTpercR1bUK8ZcZyGCtO
        Uz3p9V/VmUuZFnmuEIHBLMQ3GNgvQ==
X-ME-Sender: <xms:l6PGW0dANLAh8oJtwjDikr2ADj8tV5TYY4MFYk8wMQ3bp0XUCfa6KQ>
X-ME-Proxy: <xmx:l6PGW0pStml1VN_r4f-SGUIOz4mfqtN0qgUJ9tV9AbKN-H6Zll5vcg>
    <xmx:l6PGW8vImyiXpBkQF5XdHqb9uRiUYzUg3p54lXG0NEmlEIyffG7UNw>
    <xmx:l6PGW3Xms97h_6rSuJMvA1N1rKBrkNAc6XNW2gxA1zTyduqAniKzFg>
    <xmx:l6PGWw2yVwnooHfOlhwjYa96nrsbsyXbKLJUp8W1GmoCWg1ODucm4w>
    <xmx:l6PGWwfbXMl3nRsvyTlObMIZPKwpapIgMzyTeTb0vxA_AvLfUWOTxg>
    <xmx:mKPGWwo7gCIxA0lYF5Vt7he8krP01jtJVmCXKgF3McKOm9xIC77Utw>
Received: from v4 (unknown [122.99.82.10])
        by mail.messagingengine.com (Postfix) with ESMTPA id 0B532102EB;
        Tue, 16 Oct 2018 22:51:00 -0400 (EDT)
Message-ID: <ef5233889f290ec62d0f371c8e05689535740d87.camel@mendozajonas.com>
Subject: Re: [PATCH net-next v5] net/ncsi: Add NCSI Broadcom OEM command
From:   Samuel Mendoza-Jonas <sam@mendozajonas.com>
To:     Vijay Khemka <vijaykhemka@fb.com>,
        "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     "openbmc @ lists . ozlabs . org" <openbmc@lists.ozlabs.org>,
        Justin.Lee1@Dell.com, joel@jms.id.au, linux-aspeed@lists.ozlabs.org
Date:   Wed, 17 Oct 2018 13:50:57 +1100
In-Reply-To: <20181016191319.1909502-1-vijaykhemka@fb.com>
References: <20181016191319.1909502-1-vijaykhemka@fb.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2018-10-16 at 12:13 -0700, Vijay Khemka wrote:
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

Reviewed-by: Samuel Mendoza-Jonas <sam@mendozajonas.com>

