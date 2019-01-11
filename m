Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CCBDC43444
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 07:30:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 53A7A217F9
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 07:30:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547191822;
	bh=u5Dq1NY5tOW+MSeRB+f8I6cQb16PIDyV31tZOoCwUL8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=HF6M/e2So2JwCtGLJ5OF6EjCYMSxtU+TL9IOYtrhDO1jMWQwxbJkF28KMPYxgCpTx
	 J8QyN5/rlMbIOFM7mw4k3K9N0ggiPzgHaHZI0pzfWqX25ROD0LO/HNjmxd1ZsCaixd
	 atHjXRtIfgpuvE69U9NpzUXkOPsOSN64+CPqK36c=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730803AbfAKHaV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 02:30:21 -0500
Received: from mail.kernel.org ([198.145.29.99]:49260 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727723AbfAKHaV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 02:30:21 -0500
Received: from dragon (61-216-91-114.HINET-IP.hinet.net [61.216.91.114])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 27CEA2084C;
        Fri, 11 Jan 2019 07:30:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547191820;
        bh=u5Dq1NY5tOW+MSeRB+f8I6cQb16PIDyV31tZOoCwUL8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=iv5zcOoXe/Duju4MiYM5KZ2CkX426uxWcHSgvfIHscRrMsCOYdBpn4xnqjjk1f2LB
         l6zHvXNYzEBDCLjS1ubQ++cvS4ZS8kmXbYAOEFqDQFazEa7OFDzOrqOeueRmF01y3k
         +lXNxwKDiGzAqID4bm3/zLlrcL9g1Z8jf2cp8JrI=
Date:   Fri, 11 Jan 2019 15:30:08 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     "Z.q. Hou" <zhiqiang.hou@nxp.com>
Cc:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "jingoohan1@gmail.com" <jingoohan1@gmail.com>,
        "gustavo.pimentel@synopsys.com" <gustavo.pimentel@synopsys.com>,
        Leo Li <leoyang.li@nxp.com>, Roy Zang <roy.zang@nxp.com>,
        Mingkai Hu <mingkai.hu@nxp.com>,
        "M.h. Lian" <minghuan.lian@nxp.com>
Subject: Re: [PATCHv3 1/5] ARM: dts: ls1021a: add num-viewport property for
 PCIe DT nodes
Message-ID: <20190111073006.GD32649@dragon>
References: <20181218041956.41809-1-Zhiqiang.Hou@nxp.com>
 <20181218041956.41809-2-Zhiqiang.Hou@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181218041956.41809-2-Zhiqiang.Hou@nxp.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 18, 2018 at 04:19:26AM +0000, Z.q. Hou wrote:
> From: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
> 
> Add num-viewport property for PCIe DT nodes to specify how many
> viewports are implemented.
> 
> Signed-off-by: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>

Applied, thanks.
