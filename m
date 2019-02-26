Return-Path: <SRS0=tlbf=RB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB195C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 11:20:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D8F9217F9
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 11:20:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551180037;
	bh=FcRxEM0Yzwi9u5pEgsiYMNy/dyfF27NhAUCiHa/VuFE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=dJxjEZQ8ta16YNjjsYrcjjW8X23zCztL0VcKnlNlN69M2Zcvgb3gMx0GRHqAlvbLl
	 +R/1p4KXcJ/pwXU17vt4StBBppns+kJmSx3xOFM6ON3D84Y2KBDXlS9FOmvdgJwu32
	 7Rr151d55Pa7ZeY9117grPaipdMDXZh6meexe2co=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728056AbfBZLUg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Feb 2019 06:20:36 -0500
Received: from mail.kernel.org ([198.145.29.99]:52080 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726115AbfBZLUg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Feb 2019 06:20:36 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 16983206B8;
        Tue, 26 Feb 2019 11:20:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551180035;
        bh=FcRxEM0Yzwi9u5pEgsiYMNy/dyfF27NhAUCiHa/VuFE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OwPJGm6wyVjbTPz2tKRUHGe1fh2a0X0DIeU115eUH82uswmUXoTGuv2DbdUWj8RjO
         MtXyIo6uFiknwgqagL9+6MtEjlonk6eWutOTuNhKIdY/hzuN8MNBmPvi64QMNY9Oov
         a+OEFVx9ap1WjXTjyEP926FHwgadVguE7pzDZI7I=
Date:   Tue, 26 Feb 2019 12:20:33 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     liaoweixiong <liaoweixiong@allwinnertech.com>
Cc:     Kees Cook <keescook@chromium.org>,
        Anton Vorontsov <anton@enomsg.org>,
        Colin Cross <ccross@android.com>,
        Tony Luck <tony.luck@intel.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Arnd Bergmann <arnd@arndb.de>, Rob Herring <robh@kernel.org>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC v10 0/4] pstore/block: new support logger for block devices
Message-ID: <20190226112033.GA16900@kroah.com>
References: <1551162825-28943-1-git-send-email-liaoweixiong@allwinnertech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1551162825-28943-1-git-send-email-liaoweixiong@allwinnertech.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 26, 2019 at 02:33:41PM +0800, liaoweixiong wrote:
> Why should we need pstore_block?
> 1. Most embedded intelligent equipment have no persistent ram, which
> increases costs. We perfer to cheaper solutions, like block devices.
> In fast, there is already a sample for block device logger in driver
> MTD (drivers/mtd/mtdoops.c).
> 2. Do not any equipment have battery, which means that it lost all data
> on general ram if power failure. Pstore has little to do for these
> equipments.
> 
> [PATCH v10]

Why are you still labeling these as "RFC"?  No one should actually be
applying a Request For Comments patchset, as you obviously are not
thinking it is ready to be merged :(

After 10 revisions, I hope you are confident in this patchset :)

thanks,

greg k-h
