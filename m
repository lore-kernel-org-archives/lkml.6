Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0896BC5CFE7
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 12:48:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B2AC020B6F
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 12:48:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="sE3XDA5g"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B2AC020B6F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732630AbeGKMwk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 08:52:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:39174 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726457AbeGKMwk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 08:52:40 -0400
Received: from dragon (unknown [45.56.152.98])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5851C2089B;
        Wed, 11 Jul 2018 12:48:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1531313309;
        bh=EjA2kf3lbmpIMrp2MQzkN0KlMsjN21SPtD/O3TceKbM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=sE3XDA5gizE5T31kqTTleC9kXFDqZvnoDS5LbjW4yfwwShKS5wJxwPw0EqLNkPkQc
         DVL2jscMQcINmlKk6Wxf9nfkFnA5ZjNBWlkIoVUSuiiS37mEScJv7XE1fc58xzMWwb
         DZj+oxxFAsfs/4/fLcug2UkUXiXX8C0lNbSWbNgY=
Date:   Wed, 11 Jul 2018 20:47:55 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Nicholas Mc Guire <hofrat@osadl.org>
Cc:     Steffen Trumtrar <s.trumtrar@pengutronix.de>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Russell King <linux@armlinux.org.uk>,
        linux-kernel@vger.kernel.org, NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] ARM: imx: flag failure of of_iomap
Message-ID: <20180711124754.GG6959@dragon>
References: <1531038774-24657-1-git-send-email-hofrat@osadl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1531038774-24657-1-git-send-email-hofrat@osadl.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 08, 2018 at 10:32:54AM +0200, Nicholas Mc Guire wrote:
>  imx_set_aips is assuming that the address returned from of_iomap is
> valid which it probably is in the normal case - as the call site
> is void error propagation is not possible but never the less at least
> a WARN_ON() seems warranted here.
> 
> Signed-off-by: Nicholas Mc Guire <hofrat@osadl.org>
> Fixes: commit e57e4ab5fc2e ("ARM: i.MX: allow disabling supervisor protect via DT")

Applied, thanks.
