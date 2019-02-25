Return-Path: <SRS0=3gpS=RA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9759CC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 21:48:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5CB1020652
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 21:48:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551131337;
	bh=vFJjMfFMxkPkp2LbnLlsJ2LztsEuA1HYI3W5mCMF7yI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=zbD2tNAjEQf495gUe5/m6EMYX1zVr+i9tOSVPO4No0ZPSzdQTLMGRLvo1zLVixxZb
	 2g9VJPceMI4Cai8kso07DoZOzCxx0b/FRH7SfUvOd0JN3eeoC+dhZutVj5IGmsL4WO
	 Ewpkt5mf84b4eQhILiCaUA1jrYi6pFr/RpVatRHw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731188AbfBYVs4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Feb 2019 16:48:56 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:46093 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730996AbfBYV0D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Feb 2019 16:26:03 -0500
Received: by mail-ot1-f68.google.com with SMTP id c18so9167626otl.13;
        Mon, 25 Feb 2019 13:26:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=2yrFTHvAvNMFra7q5lFH4/FVx30dM7YnqHHjY1QWIqE=;
        b=cknaBzMOEFuY7DWoNN1gAt+nmX+OsyFSXyQJlDpT+YFjhbmakXF0lq4Ztnui0a135H
         MmEU5dN+dVZNUJ8u8o94AL3TsTRNEB19cWPndXsiXbqUJED0Bo9odCg8+YJ5cFLXtjXa
         ap2GUBs1ucb6LpiEriqsg+k3UPGX6VDTHt/IyAZJSDNoKN8J04ysj4rJewoeafyNsrL0
         uXBepu+cyis3GbsNF+xjr6KDQp+sWcSfXiYQHgGp+FcbxZCMIKLUjIPcS+LT1qtrIosx
         q6D15OCyUdP+ZJcZ6SXuuhvUlDhbc/4UmKWsFkECRHaBKv8OMDuOalmreu+Rh3EZ+TdS
         1A8w==
X-Gm-Message-State: AHQUAubdunCFytrHOYNn7vYtFHyQTvTmp+E7xWLuDgkBiBstjaPTD3iX
        Rb2fURz9LKnt7l8vawTE36yzlPY=
X-Google-Smtp-Source: AHgI3Ib9qgscweXYshtruOng2azWI92WSSpCj4TXUnL9LhjhFz1r85Jhlz0ASMdMPXo8wYO+p/vvUQ==
X-Received: by 2002:a9d:7d99:: with SMTP id j25mr12439969otn.267.1551129962046;
        Mon, 25 Feb 2019 13:26:02 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id d10sm4481921otl.69.2019.02.25.13.26.00
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 25 Feb 2019 13:26:01 -0800 (PST)
Date:   Mon, 25 Feb 2019 15:26:00 -0600
From:   Rob Herring <robh@kernel.org>
To:     Roger Quadros <rogerq@ti.com>
Cc:     tony@atomide.com, s-anna@ti.com, nsekhar@ti.com,
        linux-omap@vger.kernel.org, t-kristo@ti.com, nsaulnier@ti.com,
        jreeder@ti.com, m-karicheri2@ti.com, david@lechnology.com,
        woods.technical@gmail.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/4] bus: ti-sysc: Add support for PRUSS SYSC type
Message-ID: <20190225212600.GA12346@bogus>
References: <1549295637-24890-1-git-send-email-rogerq@ti.com>
 <1549295637-24890-3-git-send-email-rogerq@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1549295637-24890-3-git-send-email-rogerq@ti.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 04, 2019 at 05:53:55PM +0200, Roger Quadros wrote:
> The PRUSS module has a SYSCFG which is unique. Add
> support for it.
> 
> Signed-off-by: Roger Quadros <rogerq@ti.com>
> ---
>  drivers/bus/ti-sysc.c                 | 77 +++++++++++++++++++++++++++++++++++
>  include/dt-bindings/bus/ti-sysc.h     | 11 -----

Did you intend to remove what you just added?

>  include/linux/platform_data/ti-sysc.h |  1 +
>  3 files changed, 78 insertions(+), 11 deletions(-)
