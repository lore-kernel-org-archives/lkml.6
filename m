Return-Path: <SRS0=+VtO=O2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD99BC43444
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 11:25:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 761182133F
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 11:25:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=verge.net.au header.i=@verge.net.au header.b="ruItiLpS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732053AbeLQLZ2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Dec 2018 06:25:28 -0500
Received: from kirsty.vergenet.net ([202.4.237.240]:38859 "EHLO
        kirsty.vergenet.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726660AbeLQLZ2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Dec 2018 06:25:28 -0500
Received: from reginn.horms.nl (watermunt.horms.nl [80.127.179.77])
        by kirsty.vergenet.net (Postfix) with ESMTPA id 75B2525B781;
        Mon, 17 Dec 2018 22:25:25 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=verge.net.au; s=mail;
        t=1545045925; bh=wz60tNHfGGPk+S4hB/ZjOuP/EouotGj47K9eaZPypSE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ruItiLpS4JrppFNcpOsBdyQbQ6UbhjxBnVX9xcv+row1qRdEFNRNoziFUXucV6m3o
         0N62yevGP3W00RUSr2CxmmuQoBkiw2lOhc9pfSfbTg4PpZIKU5NlWt/pg4MqIVwInN
         vqpbkQJyRJntBR72btoeg2fUiCoKIeDHGzd+Vtsw=
Received: by reginn.horms.nl (Postfix, from userid 7100)
        id D441D94048A; Mon, 17 Dec 2018 12:25:23 +0100 (CET)
Date:   Mon, 17 Dec 2018 12:25:23 +0100
From:   Simon Horman <horms@verge.net.au>
To:     YueHaibing <yuehaibing@huawei.com>
Cc:     laurent.pinchart@ideasonboard.com,
        kieran.bingham+renesas@ideasonboard.com, airlied@linux.ie,
        daniel@ffwll.ch, linux-kernel@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org, dri-devel@lists.freedesktop.org
Subject: Re: [PATCH -next] drm/shmob: Fix return value check in
 shmob_drm_probe
Message-ID: <20181217112523.gm4hsn47v73gsjck@verge.net.au>
References: <20181217091830.32624-1-yuehaibing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181217091830.32624-1-yuehaibing@huawei.com>
Organisation: Horms Solutions BV
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 17, 2018 at 05:18:30PM +0800, YueHaibing wrote:
> In case of error, the function devm_ioremap_resource() returns ERR_PTR()
> and never returns NULL. The NULL test in the return value check should
> be replaced with IS_ERR().
> 
> Fixes: 8f1597c8f1a5 ("drm: shmobile: Perform initialization/cleanup at probe/remove time")
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>

Reviewed-by: Simon Horman <horms+renesas@verge.net.au>
