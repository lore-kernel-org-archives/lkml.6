Return-Path: <SRS0=ekB2=LK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0162C433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 18:34:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 804A3208B4
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 18:34:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="RwQOyEhw";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="cj7fNSAT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 804A3208B4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kroah.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727407AbeH0WVu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Aug 2018 18:21:50 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:51659 "EHLO
        out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726895AbeH0WVu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Aug 2018 18:21:50 -0400
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id 1620321E1D;
        Mon, 27 Aug 2018 14:34:03 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Mon, 27 Aug 2018 14:34:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
        :content-type:date:from:in-reply-to:message-id:mime-version
        :references:subject:to:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; bh=ZdyHd/ZFDpvu7mDwFNm3HdyQNVdw+zh2DQHfZpqKLAQ=; b=RwQOyEhw
        cEYdRshF206ZJgzCedzYp5hLmZg+E96O92G99JGReuh1PuIcIxSeDt5uKe4evcUC
        6Anbkpi2or/WiCGuT1tWTfnuEmk0Ybve1Y587YjoKonXEEOONYwdP+4fmBg5esj5
        YPmb+H0ld3ZxfI53nZiLNQ1nBiWl+gXqkLPOQe2ZgRHvOMSgUntNjqOAoLeSw+pk
        TWjxcJlGQ4JH5+YayeI299LTLf6WOIA4hTK7+LwJG9xCG0/PSlIByaRu7ypO0/rf
        XDcv8Oag153KE5h9jk71cU2+gBL+jPcmxPrBsuW4+fx5k9axf55BHTL4FHf2u/EJ
        44IAvR3WwZzIOQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-sender
        :x-me-sender:x-sasl-enc; s=fm3; bh=ZdyHd/ZFDpvu7mDwFNm3HdyQNVdw+
        zh2DQHfZpqKLAQ=; b=cj7fNSATRDQn77BYIC42edOFWr5o3Pc0jasAypK0AsfPO
        l1SfcHWXu940nnqJbGn14s1h1dcNNHjIuCfGLLapw5dMfQ0HaU67sBjnxrtoFRXT
        EYHgfsANlu/oihYlWQa8cE4xQx2EKDE1MMRpz1iuHUC1OKBhKn/CU4kOANLc9Kpn
        PZay+D6EBYraWk1psIr9pCKuh6TUKxRdmIAPy+Mte//EwKAX6ISp2uqi2A9McKSY
        bT0klc6cmjzhsH23zt6OitlwEEsCjRSyfPQIqZCX5Yd3qICjqvwfjWVMrfybg4ub
        PMoxlpI6DTczDIw5BDQgL674V+I7PcTVVktBwtq9Q==
X-ME-Proxy: <xmx:GkSEW7YcGKHmY_8hdILj2zEJrMTqbk9zsHeJ-UqsCMSu9MacPc8Q4g>
    <xmx:GkSEWxUNJLFmDzQezDq66FxR1SGzfaALAplbATnJ0fu_yVf2z1hu0w>
    <xmx:GkSEWzGMPdecZLT4eq9bm-RwxEyqXvJRp7g5DDHwD21lCShopecmEg>
    <xmx:GkSEW2BFbWGPi3wv-GrLa0gB1MCc5g8JZDovAlMgqsfWpEwRL5SLmQ>
    <xmx:GkSEW2XcsyHUfAeGPPYykYyIFcn5kvD-_U6hW65IaQivP1Nz6qdBzA>
    <xmx:G0SEW6d6IPkchN1FGMuFN2XqOxw3-Q65-0828JHukC61UaRU54O3_Q>
X-ME-Sender: <xms:GkSEWyV9Gsfu5hh0yhgoO2ETqdkC5gZkee-Hli_ObntIOkeALEoUug>
Received: from localhost (unknown [62.119.166.9])
        by mail.messagingengine.com (Postfix) with ESMTPA id 00EF9E405E;
        Mon, 27 Aug 2018 14:34:00 -0400 (EDT)
Date:   Mon, 27 Aug 2018 20:33:35 +0200
From:   Greg Kroah-Hartman <greg@kroah.com>
To:     Ray Clinton <mr.ray.clinton@gmail.com>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: Question On staging/drivers/staging/*/TODO
Message-ID: <20180827183335.GA22829@kroah.com>
References: <CAPMnawtqVnT2ux+VQzaPhyqHvYMp_Dm0sbeoWQcpYiRM-9QE2A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPMnawtqVnT2ux+VQzaPhyqHvYMp_Dm0sbeoWQcpYiRM-9QE2A@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 27, 2018 at 02:26:48PM -0400, Ray Clinton wrote:
> Hi,
> 
> I'm brand new to kernel dev and after going through Kernel Newbies
> am trying to find a good first patch to work.
> 
> I just wanted to know if the TODO files, mentioned in the subject, are
> up-to-date. If not, would you have any suggestions on where to find
> a good first patch to work on?

They should be up to date, if not hey, there's your first task!  :)

good luck,

greg k-h
