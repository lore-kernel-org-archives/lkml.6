Return-Path: <SRS0=3DzG=QX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38F3FC43381
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Feb 2019 19:52:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0726921A4C
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Feb 2019 19:52:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550346779;
	bh=YSol02upQJoUfM6FssF9IivMQ4fz1ACPGd1U1iVjvOc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=xl13U8xXCQiBtDyfa0gROyELc/8qd8z3mcbqqBibq/tW8b9apTcq/VaOGzWuDdmrJ
	 6091ZaWH3EmUI6Q4Dd+2kas45yKojKTuQtvdj3wsu1hxOOtK1/7zCB0er+vvwS1Wk6
	 N5hT3v8ngTtibsj0vEBMDUnYe9Aue7vC4uMA6Q0M=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732948AbfBPTw5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 Feb 2019 14:52:57 -0500
Received: from mail.kernel.org ([198.145.29.99]:53522 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729041AbfBPTw5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Feb 2019 14:52:57 -0500
Received: from localhost (19.64.7.109.rev.sfr.net [109.7.64.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1E93321A4C;
        Sat, 16 Feb 2019 19:52:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550346776;
        bh=YSol02upQJoUfM6FssF9IivMQ4fz1ACPGd1U1iVjvOc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lk3bmxrVkwEdyzDLzUDQpw10ehGgmA9xXohRuvj/OHm3KvWR7TLWt4lZlrbXyiUAi
         g4SY/L+lCcBfQDx4aFGkVhdb0iT/AkXD0j+Ov58bUUpa5cmQg/KoQ/6gNrc5sxgqfm
         rY10y7R+s9R4O7BQxSAhTBAhnQqqNxWO4UWn7k10=
Date:   Sat, 16 Feb 2019 20:52:53 +0100
From:   "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
To:     Vishnu DASA <vdasa@vmware.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "virtualization@lists.linux-foundation.org" 
        <virtualization@lists.linux-foundation.org>,
        Pv-drivers <Pv-drivers@vmware.com>
Subject: Re: [PATCH] VMCI: Support upto 64-bit PPNs
Message-ID: <20190216195253.GB11061@kroah.com>
References: <20190215162738.21334-1-vdasa@vmware.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190215162738.21334-1-vdasa@vmware.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 15, 2019 at 04:32:47PM +0000, Vishnu DASA wrote:
> diff --git a/include/linux/vmw_vmci_defs.h b/include/linux/vmw_vmci_defs.h
> index b724ef7005de..eaa1e762bf06 100644
> --- a/include/linux/vmw_vmci_defs.h
> +++ b/include/linux/vmw_vmci_defs.h
> @@ -45,6 +45,7 @@
>  #define VMCI_CAPS_GUESTCALL     0x2
>  #define VMCI_CAPS_DATAGRAM      0x4
>  #define VMCI_CAPS_NOTIFICATIONS 0x8
> +#define VMCI_CAPS_PPN64         0x10

BIT()?

