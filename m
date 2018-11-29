Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAF0AC43441
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 08:09:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6606B2147C
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 08:09:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="D+auLjln";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="h4t5752D"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6606B2147C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kroah.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727837AbeK2TN5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 14:13:57 -0500
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:51673 "EHLO
        out4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727017AbeK2TN5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 14:13:57 -0500
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id 89E8C21C24;
        Thu, 29 Nov 2018 03:09:25 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Thu, 29 Nov 2018 03:09:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm2; bh=s8D3KGdqHXecFnX8it035mVxsJi
        xwUXlYYaL2rTeZpw=; b=D+auLjlnt/60hHebumzyX1bPax7V6Y3zBYkpDyjRTRY
        JZP0JpIR4kQAl0ccya1WP+bgGKPKPPV/8COn1uCCmkn7hOgmXhxfEgiDJAi9N5pp
        yWNRIvkbnOZXwbDQc8wsU21DBnKqF05jeCZyhPJsNeqUrpFtfH1LoWHUIYjsZ2IQ
        ffeO7qUpieqWPHIZ5m9muuhkH5pULUu0Kjk+pS21jO4omaFAaIrQ8PWc65lH4Xvk
        OkjyyoHgafSabf0I9D8NaG/ZNMHK924NM426LmHUeEJbfLVOAQr7Pphu+bJsoZJs
        PhbYsB6OyIGwpm8OTlFSV7dthAjCjc3PpwdACYsD7Qg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=s8D3KG
        dqHXecFnX8it035mVxsJixwUXlYYaL2rTeZpw=; b=h4t5752DULVxuP6RmCILZ8
        e5DIxOhzCAo4oIXYNzo0d9j53fbVqGI0DNYGM++2mI6qhYn65CI4VCT8nwVGpcvz
        cI1bcZYoXfUgrMOcjpf0uCYbXoeApkxU/fkUbs7Ib+ZQFnF15d77VxOjQniRMCRZ
        aPgPp3Q9sJf0FtGkSBgvNS9ebeCYKeV8JcTbTWqDXc4Eg7MpieB6HERQ1D9O9eFL
        W78cJvs4ytwxWZxWjYKDsC+oT1sffXQWWQLzkcPGw+2mPReANyNIKORrjkN/zm+z
        AlmloD6gUVsSbnG7fTvYdcSRWzmPnb5CJIFZiPi9vGiKXSKOA95Gra7BtANByyzg
        ==
X-ME-Sender: <xms:tJ7_W1U2AaFX2OR2Pia79cLfrxPuCAXgximISiunK9uKikZP_LgpGQ>
X-ME-Proxy: <xmx:tJ7_W2btrDonF6B_1hADNipujXU7OkC-MWPBxyS3GF6XVzQOaq6I8A>
    <xmx:tJ7_WwUW1ruyd_AI26VD_b6wg-HtDF2aLGmSgwD1U82895fs_6AKWQ>
    <xmx:tZ7_W2Awe6bu7mM2avtB8-TTxr6YnfsccT3ZLYVTNebk4k4vcFpx3g>
    <xmx:tZ7_W_wQII0qcQz_Vg8soCB68M3U2RGLCDDZj00GuJSpr-suhhNYrw>
    <xmx:tZ7_W8aXmDCxHMpjE3OpYiXMF7llQxv0V9Hv6Uc3-7TIRf-StxzXOA>
    <xmx:tZ7_WyRomZhW035oUNH5Y_GyWSZMWOc1umKRMka30_mhEUQWvLL0dA>
Received: from localhost (5356596b.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        by mail.messagingengine.com (Postfix) with ESMTPA id 75642E4122;
        Thu, 29 Nov 2018 03:09:24 -0500 (EST)
Date:   Thu, 29 Nov 2018 09:09:23 +0100
From:   Greg KH <greg@kroah.com>
To:     Martin Kepplinger <martin.kepplinger@ginzinger.com>
Cc:     stable@vger.kernel.org, dedekind1@gmail.com, richard@nod.at,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ubi: fastmap: Check each mapping only once
Message-ID: <20181129080923.GE13859@kroah.com>
References: <20181126103842.3249-1-martin.kepplinger@ginzinger.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181126103842.3249-1-martin.kepplinger@ginzinger.com>
User-Agent: Mutt/1.11.0 (2018-11-25)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 26, 2018 at 11:38:42AM +0100, Martin Kepplinger wrote:
> From: Richard Weinberger <richard@nod.at>
> 
> [ Upstream commit 34653fd8c46e771585fce5975e4243f8fd401914 ]
> 
> This commit got merged along with commit 781932375ffc
> ("ubi: fastmap: Correctly handle interrupted erasures in EBA") upstream but
> only the latter has been applied to stable v4.14.54 as commit a23cf10d9abb.
> This resulted in a performance regression. Startup on i.MX platforms is
> delayed for up to a few seconds depending on the platform.
> This fixes ubi fastmap to be of the same performance as it has been before
> said fastmap changes.
> 
> Fixes: a23cf10d9abb ("ubi: fastmap: Correctly handle interrupted erasures in EBA")
> Signed-off-by: Richard Weinberger <richard@nod.at>
> Signed-off-by: Martin Kepplinger <martin.kepplinger@ginzinger.com>
> ---
> 
> Richard, although this fixes a major slowdown regression in -stable, do you
> consider this "stable" too?
> 
> This applies and is tested only for the 4.14 stable tree. It seems to be
> equally relevant for 4.9 and 4.4 though.

Now queued up for 4.14.y, thanks.

greg k-h
