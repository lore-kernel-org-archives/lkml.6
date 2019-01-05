Return-Path: <SRS0=xVxK=PN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE22EC43387
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Jan 2019 08:54:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA56D21871
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Jan 2019 08:54:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546678474;
	bh=PDsmdnFAgF3VtMxu4zTYIvjCy/3lBqeFi9AkJ694sco=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=PdB2oqjc9xvfOYSQ2GAir+gW/WcERPt2MHq4LP18PKTLjPKRETezUfPVWZigFL5ac
	 HyifVs+xmkI4/Syy2yHWTbOyMmCfeaw5G15CBmMM8B+XvnVI/45QUcniwjcGMw1goQ
	 as4OFgBgDeZqsUbPNRhburkYeuPUXuipoQw7q5oA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726270AbfAEIyd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 5 Jan 2019 03:54:33 -0500
Received: from mail.kernel.org ([198.145.29.99]:58398 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726202AbfAEIyd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Jan 2019 03:54:33 -0500
Received: from localhost (unknown [62.119.166.9])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4660520874;
        Sat,  5 Jan 2019 08:54:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546678473;
        bh=PDsmdnFAgF3VtMxu4zTYIvjCy/3lBqeFi9AkJ694sco=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=vJUs5s6AsZwQB/hHcFxHHmkTdkXFS/F88MB6gNN5JYR+7/onoDkx8E9s2VoaBPJBD
         d+U68BwyFn1o/tYtjgEC0gLX3lF7ZkDfEE8G102qS/2GBFPD8cIUbBNbptDToT5xwJ
         11DxTDaN9l3xpWXDiRnrMDzhWozKhnG/VRMp1Lf8=
Date:   Sat, 5 Jan 2019 09:54:29 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     rkir@google.com
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drivers: misc: goldfish_address_space: add a driver
Message-ID: <20190105085429.GB13941@kroah.com>
References: <20190104021311.38194-1-rkir@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190104021311.38194-1-rkir@google.com>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 03, 2019 at 06:13:11PM -0800, rkir@google.com wrote:
> From: Roman Kiryanov <rkir@google.com>
> 
> A driver for the Goldfish Android emulator that occupies
> address space to use it with the memory sharing device
> on the QEMU side. The memory sharding device allocates
> subranges and populate them with actual RAM.
> This allows sharing host's memory with the guest.

Why isn't this in drivers/platform/goldfish/ ?
