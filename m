Return-Path: <SRS0=ekB2=LK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,TVD_SUBJ_WIPE_DEBT,T_DKIMWL_WL_HIGH,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7FC9C433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 01:53:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5406E2174E
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 01:53:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="FQHo6wVm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5406E2174E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727050AbeH0FiF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Aug 2018 01:38:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:34694 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726731AbeH0FiF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Aug 2018 01:38:05 -0400
Received: from dragon (unknown [104.237.86.214])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C20B32174A;
        Mon, 27 Aug 2018 01:53:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1535334818;
        bh=S7P5xqE3dblDNLnagvixdNG5Yk4z6MJnuICeYiSZpDU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FQHo6wVmZZSNBz0hDX40zV58Dj324+X/cgqcTEK17krcOZ/EgGQacGSbIM0BQk2vZ
         U4lOiEVPFNgiK/uQ5RZFCqR2tfK6j988gQfGjkow/6JckHtTX5qLk3Ue+JDHuDeE07
         9pb5uofGVqMyxNG0hlimxEFVDYKd9Vxn1P3YXE6w=
Date:   Mon, 27 Aug 2018 09:52:50 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Anson Huang <Anson.Huang@nxp.com>
Cc:     s.hauer@pengutronix.de, kernel@pengutronix.de,
        fabio.estevam@nxp.com, robh+dt@kernel.org, mark.rutland@arm.com,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Linux-imx@nxp.com
Subject: Re: [PATCH] ARM: dts: imx7s: remove snvs_poweroff node
Message-ID: <20180827015249.GF29208@dragon>
References: <1533534005-18736-1-git-send-email-Anson.Huang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1533534005-18736-1-git-send-email-Anson.Huang@nxp.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 06, 2018 at 01:40:05PM +0800, Anson Huang wrote:
> System poweroff is already supported by PSCI on i.MX7D,
> remove "snvs_poweroff" node to avoid below debug message
> from syscon-poweroff driver:
> 
> [    1.831414] syscon-poweroff 30370000.snvs:snvs-poweroff: pm_power_off already claimed (ptrval) psci_sys_poweroff
> [    1.841707] syscon-poweroff: probe of 30370000.snvs:snvs-poweroff failed with error -16
> 
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>

Applied, thanks.
