Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9F65C282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 08:04:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8765B20879
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 08:04:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548144259;
	bh=MWbvwA24Cy7m38O5Li+P5zc5RV46yGtMojOpwfl02As=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=UyoPh/VZfDU4UHLddXNPQmLOFEWwnFLXfAOYngXyiA32q7NrBBxDt3JhqaxDwJXdw
	 YVh8yhbQ7vIVlAnCLzlTcz7kx+qEREvqEhv+HgpKu/zMDVZR4xYbrQ4aIMnff+O6Kl
	 93UKBG8L6C/AvF+IQLNwlHG+dmW0UhDApkwXO0qE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727510AbfAVIES (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 03:04:18 -0500
Received: from mail.kernel.org ([198.145.29.99]:57680 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727274AbfAVIER (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 03:04:17 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5E2D02084C;
        Tue, 22 Jan 2019 08:04:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548144256;
        bh=MWbvwA24Cy7m38O5Li+P5zc5RV46yGtMojOpwfl02As=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CGwMT+P3DitDbTkZc5yvzvoAsSHAEx45MXvKY+Jnhv/4AJkYPOxVyv3jTqKCgG/Hw
         4CveMdOxmrmPaINs3Mdn+qQdH3OGrJTCwR0plQm+e5jAt1hRkfI9hlFk/Cf0/rUsGs
         +A/mNiPBmQqIwpAWs769tGXY32iBXibN8n+h3DNg=
Date:   Tue, 22 Jan 2019 09:04:14 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Yinbo Zhu <yinbo.zhu@nxp.com>
Cc:     Alan Stern <stern@rowland.harvard.edu>,
        Xiaobo Xie <xiaobo.xie@nxp.com>,
        Jerry Huang <jerry.huang@nxp.com>,
        Ran Wang <ran.wang_1@nxp.com>,
        Ramneek Mehresh <ramneek.mehresh@freescale.com>,
        Nikhil Badola <nikhil.badola@freescale.com>,
        Suresh Gupta <suresh.gupta@freescale.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 3/6] usb: host: Stops USB controller init if PLL fails
 to lock
Message-ID: <20190122080414.GA9680@kroah.com>
References: <20190121102601.4735-1-yinbo.zhu@nxp.com>
 <20190121102601.4735-3-yinbo.zhu@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190121102601.4735-3-yinbo.zhu@nxp.com>
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 21, 2019 at 10:25:10AM +0000, Yinbo Zhu wrote:
> From: yinbo.zhu <yinbo.zhu@nxp.com>

This line is still wrong :(
