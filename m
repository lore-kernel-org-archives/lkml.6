Return-Path: <SRS0=K7k5=Q2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D72EC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 10:20:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 65A0F2177E
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 10:20:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550571619;
	bh=iHyTq3trAhhHUYiZiqBypP90etaOVTP6CPP76yXB7n0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=lh77CWXf0c3KG3AOgTGqc4k2MbF1S+ZAXJpGESaJdheVOD0RJO3huRf0G8H+RuoAc
	 RTBGhSnNXqVtLRVLVUR8i/hWocuF5s/RhWltWYVBSll/tfqdgbcgAZqSvR+m0vCMdH
	 9mINEBSnRIgfvvbcfHbzB+mu+yMRJQrCxJoS26kA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728121AbfBSKUS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Feb 2019 05:20:18 -0500
Received: from mail.kernel.org ([198.145.29.99]:35950 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726385AbfBSKUR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Feb 2019 05:20:17 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8DBC82177E;
        Tue, 19 Feb 2019 10:20:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550571617;
        bh=iHyTq3trAhhHUYiZiqBypP90etaOVTP6CPP76yXB7n0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=k51tqvzlhwTXJYjdAl7+9MgTgPOwCAQyvVF+r6iu3ZTjUbaEhPdFjrbx/Gacy1Ax2
         ohFza3TdNiPUnd/dH4ay1P/GfrERB9FEvlV61zIKaPDnAxaFWCU3X1B3gtO8zzFK4X
         6CiHvXnBnoMhYab2rkzc2TyXAjIZSwgwZjWeTe3k=
Date:   Tue, 19 Feb 2019 11:20:10 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Marcin Ciupak <marcin.s.ciupak@gmail.com>
Cc:     Joe Perches <joe@perches.com>, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org,
        Dan Carpenter <dan.carpenter@oracle.com>
Subject: Re: [PATCH v4] staging: nrf24: add new driver for 2.4GHz radio
 transceiver
Message-ID: <20190219102010.GA18634@kroah.com>
References: <20190213194035.n2ldlt7xque5qaps@metis.ciupak.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190213194035.n2ldlt7xque5qaps@metis.ciupak.eu>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 13, 2019 at 08:40:35PM +0100, Marcin Ciupak wrote:
> This patch adds driver for Nordic Semiconductor nRF24L01+ radio
> transceiver.
> 
> Signed-off-by: Marcin Ciupak <marcin.s.ciupak@gmail.com>
> ---
> Changes in v2:
>   - add terminating newlines to all logging formats
> Changes in v3:
>   - patch subject
>   - comments cleanup
>   - goto labels cleanup
>   - scnprintf bugfix
>   - ida_simple_remove bugfix
> Changes in v4:
>   - fix smatch warnings

What is preventing this from being merged today with the normal
subsystem for this type of drivers?  Why does this have to go into
staging?

thanks,

greg k-h
