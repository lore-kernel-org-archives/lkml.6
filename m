Return-Path: <SRS0=T/cj=MV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70CF0C6787A
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 00:20:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 301CE2145D
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 00:20:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="qk2YqV+I"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 301CE2145D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726491AbeJIHfJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Oct 2018 03:35:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:36430 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725749AbeJIHfJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Oct 2018 03:35:09 -0400
Received: from dragon (unknown [45.56.155.247])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 45ED02089D;
        Tue,  9 Oct 2018 00:20:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539044453;
        bh=H7dk0fAYJLb6mHjlwa4+2jRuIo+4eusljvQhf5oEWPw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qk2YqV+IV6z/FKKMvYwhv5DXYgiBG5mm2prfJ3TXCL6lzBwbY16xLxo/QL2hFFOGA
         5ztOQur93By+bygA+ZOPp7xSr4iPrv2vpgUPSLIObvRl//09DxQDVFoliDv2gQZChQ
         HABwXkQqVcqvXjSrH2jKAfCUNc6/l7h0m6b/psNY=
Date:   Tue, 9 Oct 2018 08:20:33 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     =?utf-8?B?Vm9rw6HEjQ==?= Michal <Michal.Vokac@ysoft.com>
Cc:     Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Rob Herring <robh+dt@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>
Subject: Re: [RESEND PATCH v2 3/3] ARM: dts: imx28-cfa10036: Fix the reset
 gpio signal polarity
Message-ID: <20181009002031.GU3587@dragon>
References: <1538040281-21319-1-git-send-email-michal.vokac@ysoft.com>
 <1538040281-21319-3-git-send-email-michal.vokac@ysoft.com>
 <68f4da21-6f0d-5bf9-b352-cdc423269080@ysoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <68f4da21-6f0d-5bf9-b352-cdc423269080@ysoft.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 08, 2018 at 11:45:36AM +0000, Vokáč Michal wrote:
> On 27.9.2018 11:24, Michal Vokáč wrote:
> > The reset signal of the SSD1306 OLED display is actually active-low.
> > Adapt the DT to reflect the real world.
> > 
> > Signed-off-by: Michal Vokáč <michal.vokac@ysoft.com>
> > ---
> > v2 changes: New patch in the series
> 
> Bartlomiej just queued the first two patches for v4.20.
> Will somebody take this one? Otherwise this SoM will end up with
> broken OLED display reset.

Well, it means the change breaks the ABI between kernel and device tree,
e.g. the new kernel will not work with existing/installed DTBs.

Shawn
