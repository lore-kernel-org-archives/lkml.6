Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43AB7C5CFEB
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 20:53:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F0474208A2
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 20:53:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="EigO8VJ4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F0474208A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754565AbeGIUxB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 16:53:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:40796 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754528AbeGIUw7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 16:52:59 -0400
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 48DA8208A2;
        Mon,  9 Jul 2018 20:52:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1531169579;
        bh=+3YJDA510hDQdAhIZcNBWEjKbtYSegMtTl3ayrlkg6o=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=EigO8VJ4NwPjwWtVZ3Fy8E+zdI2kUaUfBKL1aViiAqEqBA3Dn850bBL+1y5BUKC7P
         sReEtTy0/w3AlMTUUpPqGoChlu0oum1Ua6Ur/G2RAJoh/p8SUERmt1ccTgd1ztJY7f
         95yMGG+hlaA/Uz2LA6/zpgPXhZLzH/LEUw8TfUE4=
Date:   Mon, 9 Jul 2018 22:52:54 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Sujeev Dias <sdias@codeaurora.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        Tony Truong <truong@codeaurora.org>,
        Siddartha Mohanadoss <smohanad@codeaurora.org>
Subject: Re: [PATCH v2 1/7] mhi_bus: core: initial checkin for modem host
 interface bus driver
Message-ID: <20180709205254.GB1202@kroah.com>
References: <1524795811-21399-1-git-send-email-sdias@codeaurora.org>
 <1531166894-30984-1-git-send-email-sdias@codeaurora.org>
 <1531166894-30984-2-git-send-email-sdias@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1531166894-30984-2-git-send-email-sdias@codeaurora.org>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 09, 2018 at 01:08:08PM -0700, Sujeev Dias wrote:
> This is the initial skeleton driver for mhi bus stack. MHI Host
> Interface is a communication protocol to be used by the host to
> control and communcate with modem over a high speed peripheral bus.
> This module will allow host to communicate with external devices that
> support MHI protocol.
> 
> Signed-off-by: Sujeev Dias <sdias@codeaurora.org>
> Reviewed-by: Tony Truong <truong@codeaurora.org>
> Signed-off-by: Siddartha Mohanadoss <smohanad@codeaurora.org>
> ---
>  Documentation/00-INDEX                        |   2 +
>  Documentation/devicetree/bindings/bus/mhi.txt | 258 ++++++++++++
>  Documentation/mhi.txt                         | 235 +++++++++++

Do not put .txt files in the root of the documentation directory for no
reason.  They should be in .rst and hopefully in the proper location for
where the documentation belongs.

And dt bindings always belong in a separate patch, you all know better
than to mush it into a large one like this...

thanks,

greg k-h
