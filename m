Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB6F6C282C3
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 11:08:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A0FD420879
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 11:08:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548155294;
	bh=gVJPOuGlt6T9ElgvA4wbZf+3K4QS499W26EXAywQmx4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Dr9lbHTZFSKUHDM9GSQxtOb8sg/8WeL8BA4fKgSFlWj7iKpRv5EL0QsWkf7q7TaBy
	 MJ7QXlBaFKSaH9t1KEyLwpMkh3a9MAtDVNFo9HlJj9ZSZfXfFuclFwP8m/AUPP0dxN
	 AARLDoeZfn1e97khUzaQYMpxgBNq8eV1RjXy6AR8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728143AbfAVLIN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 06:08:13 -0500
Received: from mail.kernel.org ([198.145.29.99]:33666 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727663AbfAVLIM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 06:08:12 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 83D7520879;
        Tue, 22 Jan 2019 11:08:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548155292;
        bh=gVJPOuGlt6T9ElgvA4wbZf+3K4QS499W26EXAywQmx4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JXzlP3tq+4LEHdXPuOMifiPjG/fzK0kcSPztybBVnH7cTy78S64H7YKFVvBTqLTT1
         Cnz3AyzSvZf6+tftvH80LDXxtZNA0j4pIoT650LS7cBkWROSA1vyTfsBwrQd69/h+T
         voHsVgynZT8y62aS5GM6m9CJUDzXzXTu1vjZ5DrI=
Date:   Tue, 22 Jan 2019 12:08:09 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     rkir@google.com
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 3/3] drivers: platform: goldfish: goldfish_sync: add a
 driver
Message-ID: <20190122110809.GB1004@kroah.com>
References: <20190109021112.5836-1-rkir@google.com>
 <20190109021112.5836-3-rkir@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190109021112.5836-3-rkir@google.com>
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 08, 2019 at 06:11:12PM -0800, rkir@google.com wrote:
> From: Roman Kiryanov <rkir@google.com>
> 
> The Goldfish sync driver is designed to provide a interface
> between the underlying host's sync device and the kernel's
> fence sync framework.
> 
> Signed-off-by: Roman Kiryanov <rkir@google.com>
> ---
> Changes in v3:
>  - Removed WARN_ON.
> 
> Changes in v2:
>  - Added a missing include (mod_devicetable.h).
>  - Put in one batch with goldfish_address_space.c to avoid merge comflicts.
> 
>  drivers/platform/goldfish/Kconfig           |   7 +
>  drivers/platform/goldfish/Makefile          |   1 +
>  drivers/platform/goldfish/goldfish_sync.c   | 827 ++++++++++++++++++++
>  include/uapi/linux/goldfish/goldfish_sync.h |  28 +
>  4 files changed, 863 insertions(+)
>  create mode 100644 drivers/platform/goldfish/goldfish_sync.c
>  create mode 100644 include/uapi/linux/goldfish/goldfish_sync.h
> 

Please get this reviewed by the sync subsystem maintainers to ensure
that you are using the API properly, and that this really is needed.  If
it is needed, why is this a goldfish-only type device, why do not all
systems need this?

thanks,

greg k-h
